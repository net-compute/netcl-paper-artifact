from netaddr import IPAddress, EUI
import json
import os

NCL_REFLECT_ACTION=6
NCL_MULTICAST_ACTION=9
NCL_DROP_ACTION=3

# Percentage of keys in data.txt that will be in the cache
CACHE=100

SWITCH = {'name': "s1", 'mac': "42:00:00:00:00:00", 'ip': "42.0.0.0", 'id': 1}
HOSTS = {
    "server":  {'mac': "94:6d:ae:8c:e4:7c", 'ip': "42.0.0.4", 'port': 4, 'id': 4},
    "client1": {'mac': "10:70:fd:df:a5:aa", 'ip': "42.0.0.1", 'port': 1, 'id': 1},
    "client2": {'mac': "10:70:fd:df:a4:26", 'ip': "42.0.0.2", 'port': 2, 'id': 2},
    "client3": {'mac': "94:6d:ae:8c:ad:74", 'ip': "42.0.0.3", 'port': 3, 'id': 3}}


def get_dport_from_fport(fp, ch=0):
    return bfrt.port.port_hdl_info.get(CONN_ID=fp, CHNL_ID=ch, print_ents=False).data[b'$DEV_PORT']


NCRT = bfrt.p4_cache_ncl_device_1.pipe.ncrt
NCVM = bfrt.p4_cache_ncl_device_1.pipe.ncvm
NET = bfrt.p4_cache_ncl_device_1.pipe.MainIngress.net

# clear multicast nodes/groups
if bfrt.pre.node.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.node.get(regex=True, return_ents=True, print_ents=False):
        e.remove()
if bfrt.pre.mgid.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.mgid.get(regex=True, return_ents=True, print_ents=False):
        e.remove()

# NET tables
NET.forwarding_table.clear()
NET.arp_table.clear()

# NCRT tables
NCRT.ingress.tbl.forward.multicast.clear()
NCRT.ingress.tbl.forward.host.clear()
NCRT.ingress.tbl.forward.device.clear()
NCRT.egress.tbl.ports.clear()
NCRT.egress.tbl.udp.adj.clear()

# NCVM (codegen) tables
NCVM.mem.net.Cache_fragment_0_.clear()
NCVM.mem.net.Cache_fragment_1_.clear()
NCVM.mem.net.Cache_fragment_2_.clear()
NCVM.mem.net.Cache_fragment_3_.clear()
NCVM.mem.managed.Valid0.clear()
NCVM.mem.managed.Valid1.clear()
NCVM.mem.managed.Stats0.clear()
NCVM.mem.managed.Stats1.clear()
NCVM.mem.managed.c0.clear()
NCVM.mem.managed.c1.clear()
NCVM.mem.managed.c2.clear()
NCVM.mem.managed.c3.clear()
NCVM.mem.managed.b0.clear()
NCVM.mem.managed.b1.clear()
NCVM.mem.managed.b2.clear()
NCVM.mem.managed.lut.Bitmap.clear()
NCVM.mem.managed.lut.Index.clear()


print("=========================")
print("NETWORKING")
print("=========================")

all_ports = [get_dport_from_fport(HOSTS[h]['port']) for h in HOSTS]

bfrt.pre.node.entry(MULTICAST_NODE_ID=1, MULTICAST_RID=1,
                    MULTICAST_LAG_ID=[], DEV_PORT=all_ports).push()
bfrt.pre.mgid.add(MGID=1, MULTICAST_NODE_ID=[1],
                  MULTICAST_NODE_L1_XID_VALID=[False], MULTICAST_NODE_L1_XID=[0])



print(f"  mgid 1 -> {all_ports}")

# add hosts
for h in HOSTS:
    dport = get_dport_from_fport(HOSTS[h]['port'])
    mac = EUI(HOSTS[h]['mac'])
    ip = IPAddress(HOSTS[h]['ip'])

    # enable switch ports
    bfrt.port.port.add( DEV_PORT=dport, SPEED="BF_SPEED_100G", FEC="BF_FEC_TYP_NONE",
                        PORT_ENABLE=True, AUTO_NEGOTIATION="PM_AN_FORCE_DISABLE")
    # ncp
    NCRT.ingress.tbl.forward.host.add_with_ncl_forward_host(ncl_act_arg=HOSTS[h]['id'], port=dport)
    NCRT.egress.tbl.ports.add_with_host_port(egress_port=dport, id=HOSTS[h]['id'], ip=HOSTS[h]['ip'], mac=HOSTS[h]['mac'], neighbor=True)
    # NCRT.egress.tbl.ports.add_with_host_port(egress_port=dport, id=HOSTS[h]['id'], ip=HOSTS[h]['ip'], mac=HOSTS[h]['mac'], neighbor=True)
    # A bit of a dirty hack (the compiler is compicit!) to have multicasts and reflects
    # use the src UDP port of the packet as the dst port. Need something better and more generic
    NCRT.egress.tbl.udp.adj.add_with_udp_ports_swap(cid=1, act=NCL_REFLECT_ACTION, h_dst=HOSTS[h]['id'])

    # normal networking
    NET.arp_table.add_with_arp_resolve(dst_proto_addr=ip, mac=mac)
    NET.forwarding_table.add_with_forward(dst_addr=mac, port=dport)
    print('  %s/%s -> %d (%s)' % (mac, ip, dport, h))

# add switch arp
NET.arp_table.set_default_with_multicast(mgid=1)
NET.arp_table.add_with_arp_resolve(dst_proto_addr=IPAddress("42.42.42.42"), mac=EUI("42:42:42:42:42:42"))
NET.arp_table.add_with_arp_resolve(dst_proto_addr=IPAddress(SWITCH['ip']), mac=EUI(SWITCH['mac']))
print(f" {EUI(SWITCH['mac'])}/{IPAddress(SWITCH['ip'])} -> device {SWITCH['id']} address")
print(f" {EUI('42:42:42:42:42:42')}/{IPAddress('42.42.42.42')} -> ncl-ipmlicit address")
# arp multicasts
NET.forwarding_table.add_with_multicast(dst_addr=EUI("ff:ff:ff:ff:ff:ff"), mgid=1)
NET.forwarding_table.set_default_with_multicast(mgid=1)
print(f" {EUI('ff:ff:ff:ff:ff:ff')} -> mgid 1")


print("=========================")
print("CACHE")
print("=========================")

def str_to_int(seq, _m=str.maketrans('ACGT', '0123')):
    return int(seq.translate(_m), 4)

def encode_str_key(k):
    b = k.encode('utf-8')
    b = b[:8].ljust(8, b'\0')  # Ensure it's exactly 8 bytes
    # Convert bytes to a 64-bit integer
    return int.from_bytes(b, 'little')

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

    NCVM.mem.managed.lut.Index.add_with__mem_lut_Index_Read(H_ncp_data_1_00_value=k_enc, value=i)
    NCVM.mem.managed.lut.Bitmap.add_with__mem_lut_Bitmap_Read(H_ncp_data_1_00_value=k_enc, value=mask)
    NCVM.mem.managed.Valid0.add(REGISTER_INDEX=i, f1=1);
    NCVM.mem.managed.Valid1.add(REGISTER_INDEX=i, f1=0);

    val = bytes(v, 'utf-8')

    if is_bit_set(mask, 0):
        if is_bit_set(mask, 0):
            NCVM.mem.net.Cache_fragment_0_.add(REGISTER_INDEX=i, f1=int.from_bytes(
                val[0:4], byteorder='little'))
        if is_bit_set(mask, 1):
            NCVM.mem.net.Cache_fragment_1_.add(REGISTER_INDEX=i, f1=int.from_bytes(
                val[4:8], byteorder='little'))
        if is_bit_set(mask, 2):
            NCVM.mem.net.Cache_fragment_2_.add(REGISTER_INDEX=i, f1=int.from_bytes(
                val[8:12], byteorder='little'))
        if is_bit_set(mask, 3):
            NCVM.mem.net.Cache_fragment_3_.add(REGISTER_INDEX=i, f1=int.from_bytes(
                val[12:16], byteorder='little'))

    print(
        f"  key: 0x{k_enc:016x}/{k_enc} --> cacheline: {i} | slot: {slot}, mask: {mask:032b} / {val_bytes:2d}B,{val_words}W | raw: {k} -> {v}")


bfrt.complete_operations()

print()
print("================================")
print("CACHE INFO SANITY CHECK")
print("================================")

print("Cachelines:")
for e in NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    print(f"  0x{int(e.key[b'H.ncp_data_1_0$0.value']):016x} --> cacheline: {e.data[b'value']}")
print("Masks:")
for e in NCVM.mem.managed.lut.Bitmap.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    print(
        f"  0x{int(e.key[b'H.ncp_data_1_0$0.value']):016x} -->      mask: {e.data[b'value']:032b}, slot: {1 if is_bit_set(e.data[b'value'], 0) else 2}")
print("Valid:")
for i in range(len(cache_entries)):
    e0 = NCVM.mem.managed.Valid0.get(REGISTER_INDEX=i, return_ents=True, print_ents=False, from_hw=True)
    e1 = NCVM.mem.managed.Valid1.get(REGISTER_INDEX=i, return_ents=True, print_ents=False, from_hw=True)

    print(
        f"  cacheline: {i} --> valid1: {e1.data[b'ncvm.mem.managed.Valid1.f1']} valid0: {e0.data[b'ncvm.mem.managed.Valid0.f1']}")
print("Values:")

index_entries = NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True)
if len(index_entries) < 6: # if we have space in the terminal
    print("       ", end='')
    for e in index_entries: #NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
        print(f"     l:{e.data[b'value']:05d}", end='')
    print()
print("  Cache1: ", end='')
for e in NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'value']
    print(f"  0x{NCVM.mem.net.Cache_fragment_0_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_0_.f1'][0]:08x}",end='')
print()
print("  Cache2: ", end='')
for e in NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'value']
    print(f"  0x{NCVM.mem.net.Cache_fragment_1_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_1_.f1'][0]:08x}",end='')
print()
print("  Cache3: ", end='')
for e in NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'value']
    print(f"  0x{NCVM.mem.net.Cache_fragment_2_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_2_.f1'][0]:08x}",end='')
print()
print("  Cache4: ", end='')
for e in NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'value']
    print(f"  0x{NCVM.mem.net.Cache_fragment_3_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_3_.f1'][0]:08x}",end='')
print()

print("Values reconstruct:")

def combine_32bit_to_string(*integers):
    # Convert each 32-bit integer to 4 bytes and concatenate them
    combined_bytes = b''.join(i.to_bytes(4, byteorder='little') for i in integers)
    # Convert the combined byte sequence to a string
    return combined_bytes.decode('utf-8', errors='ignore')

for e in NCVM.mem.managed.lut.Index.get(regex=True, return_ents=True, print_ents=False, from_hw=True):
    idx = e.data[b'value']
    # print()
    key=e.key[b'H.ncp_data_1_0$0.value']
    # Cache.mask.dump()
    mask = NCVM.mem.managed.lut.Bitmap.get(key, return_ents=True, print_ents=False, from_hw=True).data[b'value']
    # mask.dump()
    # print("mask: ", mask[''])
    value_bytes = []
    if is_bit_set(mask, 0):
        value_bytes.append(NCVM.mem.net.Cache_fragment_0_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_0_.f1'][0])
    if is_bit_set(mask, 1):
        value_bytes.append(NCVM.mem.net.Cache_fragment_1_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_1_.f1'][0])
    if is_bit_set(mask, 2):
        value_bytes.append(NCVM.mem.net.Cache_fragment_2_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_2_.f1'][0])
    if is_bit_set(mask, 3):
        value_bytes.append(NCVM.mem.net.Cache_fragment_3_.get(REGISTER_INDEX=idx, return_ents=True, print_ents=False, from_hw=True).data[b'ncvm.mem.net.Cache_fragment_3_.f1'][0])
    print(f"  cacheline: {idx:05d}, mask: {mask:032b} --> {value_bytes} --> {combine_32bit_to_string(*value_bytes)}")

# print("================================")


bfrt.complete_operations()