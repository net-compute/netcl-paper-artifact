from netaddr import IPAddress, EUI
import json
import os

# Percentage of keys in data.txt that will be in the cache
CACHE=20

SWITCH = {'name': "s1", 'mac': "42:00:00:00:00:00", 'ip': "42.0.0.0"}
HOSTS = {
    "server":  {'mac': "94:6d:ae:8c:e4:7c", 'ip': "42.0.0.4", 'port': 4, 'id': 4},
    "client1": {'mac': "10:70:fd:df:a5:aa", 'ip': "42.0.0.1", 'port': 1, 'id': 1},
    "client2": {'mac': "10:70:fd:df:a4:26", 'ip': "42.0.0.2", 'port': 2, 'id': 2},
    "client3": {'mac': "94:6d:ae:8c:ad:74", 'ip': "42.0.0.3", 'port': 3, 'id': 3}}


def get_dport_from_fport(fp, ch=0):
    return bfrt.port.port_hdl_info.get(CONN_ID=fp, CHNL_ID=ch, print_ents=False).data[b'$DEV_PORT']


IN = bfrt.switch.pipe.ingress
# EG = bfrt.switch.pipe.egress


# clear multicast nodes/groups
if bfrt.pre.node.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.node.get(regex=True, return_ents=True, print_ents=False):
        e.remove()
if bfrt.pre.mgid.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.mgid.get(regex=True, return_ents=True, print_ents=False):
        e.remove()

IN.net.forwarding_table.clear()
IN.net.arp_table.clear()

IN.cache.index.clear()
IN.cache.mask.clear()
IN.cache.Valid.clear()
IN.cache.Cache1.clear()
IN.cache.Cache2.clear()
IN.cache.Cache3.clear()
IN.cache.Cache4.clear()

print("=========================")
print("NETWORKING")
print("=========================")

all_ports = [get_dport_from_fport(HOSTS[h]['port']) for h in HOSTS]

IN.net.forwarding_table.add_with_flood(dst_addr=EUI("ff:ff:ff:ff:ff:ff"))
bfrt.pre.node.entry(MULTICAST_NODE_ID=1, MULTICAST_RID=1,
                    MULTICAST_LAG_ID=[], DEV_PORT=all_ports).push()
bfrt.pre.mgid.add(MGID=1, MULTICAST_NODE_ID=[1],
                  MULTICAST_NODE_L1_XID_VALID=[False], MULTICAST_NODE_L1_XID=[0])

print(f"  mgid 1 -> {all_ports}")
IN.net.arp_table.add_with_arp_resolve(
    dst_proto_addr=IPAddress(SWITCH['ip']), mac=EUI(SWITCH['mac']))

for h in HOSTS:
    dport = get_dport_from_fport(HOSTS[h]['port'])
    # mask = 1 << (C['workers'][h]['rank'] - 1)

    # enable switch ports
    bfrt.port.port.add( DEV_PORT=dport, SPEED="BF_SPEED_100G", FEC="BF_FEC_TYP_NONE",
                        PORT_ENABLE=True, AUTO_NEGOTIATION="PM_AN_FORCE_DISABLE")

    mac, ip = EUI(HOSTS[h]['mac']), IPAddress(HOSTS[h]['ip'])
    IN.net.forwarding_table.add_with_send_to_port(dst_addr=mac, port=dport)
    print('  %s/%s -> %d (%s)' % (mac, ip, dport, h))


Cache = IN.cache

def str_to_int(seq, _m=str.maketrans('ACGT', '0123')):
    return int(seq.translate(_m), 4)

def encode_str_key(k):
    b = k.encode('utf-8')
    b = b[:8].ljust(8, b'\0')  # Ensure it's exactly 8 bytes
    # Convert bytes to a 64-bit integer
    return int.from_bytes(b, 'little')


print("=========================")
print("CACHE")
print("=========================")


def is_bit_set(value, i):
    # Shift 1 to the left by i positions and perform bitwise AND with the value
    return (value & (1 << i)) != 0


cache_entries = {}
num_in_cache = 0
with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "data.txt")) as f:
    lines = f.read().splitlines()
    num_in_cache = round(CACHE / 100 * len(lines))

    print(f"\nWill insert {CACHE}% of keys in data.txt ({num_in_cache} keys) in the cache!!\n")

    for (i, l) in enumerate(lines):
        if i == num_in_cache:
            break
        kv = l.strip().split('=', 1)
        cache_entries[kv[0]] = kv[1]

print("Inserting cache entries:")
for i, (k, v) in enumerate(cache_entries.items()):
    k_enc = encode_str_key(k)
    val_bytes = len(bytes(v, 'utf-8'))
    val_words = len(bytes(v, 'utf-8')) // 4 + \
        (1 if len(bytes(v, 'utf-8')) % 4 > 0 else 0)
    slot = 1
    mask = (1 << val_words) - 1

    Cache.index.add_with_read_idx(k=k_enc, i=i)
    Cache.mask.add_with_read_mask(k=k_enc, mask=mask)
    Cache.Valid.add(REGISTER_INDEX=i, lo=1)

    val = bytes(v, 'utf-8')

    if is_bit_set(mask, 0):
        Cache.Cache1.add(REGISTER_INDEX=i, f1=int.from_bytes(
            val[0:4], byteorder='little'))
    if is_bit_set(mask, 1):
        Cache.Cache2.add(REGISTER_INDEX=i, f1=int.from_bytes(
            val[4:8], byteorder='little'))
    if is_bit_set(mask, 2):
        Cache.Cache3.add(REGISTER_INDEX=i, f1=int.from_bytes(
            val[8:12], byteorder='little'))
    if is_bit_set(mask, 3):
        Cache.Cache4.add(REGISTER_INDEX=i, f1=int.from_bytes(
            val[12:16], byteorder='little'))


    print(
        f"  key: 0x{k_enc:016x}/{k_enc} --> cacheline: {i} | slot: {slot}, mask: {mask:032b} / {val_bytes:2d}B,{val_words}W | raw: {k} -> {v}")


bfrt.complete_operations()

print()
print("================================")
print("CACHE INFO SANITY CHECK")
print("================================")

print("Cachelines:")
for e in Cache.index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    print(f"  0x{int(e.key[b'H.cache.k']):016x} --> cacheline: {e.data[b'i']}")
print("Mask:")
for e in Cache.mask.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    print(
        f"  0x{int(e.key[b'H.cache.k']):016x} -->      mask: {e.data[b'mask']:032b}, slot: {1 if is_bit_set(e.data[b'mask'], 0) else 2}")
print("Valid:")
for i in range(len(cache_entries)):
    e = Cache.Valid.get(REGISTER_INDEX=i, return_ents=True,
                        print_ents=False, from_hw=True)
    print(
        f"  cacheline: {i} --> hi: {e.data[b'ingress.cache.Valid.hi']} lo: {e.data[b'ingress.cache.Valid.lo']}")
print("Values:")

print("       ", end='')
for e in Cache.index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    print(f"     l:{e.data[b'i']:05d}", end='')
print()
print("  Cache1: ", end='')
for e in Cache.index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'i']
    print(f"  0x{Cache.Cache1.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache1.f1'][0]:08x}",end='')
print()
print("  Cache2: ", end='')
for e in Cache.index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'i']
    print(f"  0x{Cache.Cache2.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache2.f1'][0]:08x}",end='')
print()
print("  Cache4: ", end='')
for e in Cache.index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'i']
    print(f"  0x{Cache.Cache3.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache3.f1'][0]:08x}",end='')
print()
print("  Cache4: ", end='')
for e in Cache.index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'i']
    print(f"  0x{Cache.Cache4.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache4.f1'][0]:08x}",end='')
print()

print("Values reconstruct:")

def combine_32bit_to_string(*integers):
    # Convert each 32-bit integer to 4 bytes and concatenate them
    combined_bytes = b''.join(i.to_bytes(4, byteorder='little') for i in integers)
    # Convert the combined byte sequence to a string
    return combined_bytes.decode('utf-8', errors='ignore')

for e in Cache.index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'i']
    # print()
    key=e.key[b'H.cache.k']
    # Cache.mask.dump()
    mask = Cache.mask.get(key, return_ents=True, print_ents=False, from_hw=True).data[b'mask']
    # mask.dump()
    # print("mask: ", mask[''])
    value_bytes = []
    if is_bit_set(mask, 0):
        value_bytes.append(Cache.Cache1.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache1.f1'][0])
    if is_bit_set(mask, 1):
        value_bytes.append(Cache.Cache2.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache2.f1'][0])
    if is_bit_set(mask, 2):
        value_bytes.append(Cache.Cache3.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache3.f1'][0])
    if is_bit_set(mask, 3):
        value_bytes.append(Cache.Cache4.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ingress.cache.Cache4.f1'][0])
    print(f"  cacheline: {idx:05d}, mask: {mask:032b} --> {value_bytes} --> {combine_32bit_to_string(*value_bytes)}")

print("================================")