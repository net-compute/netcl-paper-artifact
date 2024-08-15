from netaddr import IPAddress, EUI
import json
import os

with open(os.path.abspath(os.path.join(os.path.dirname(__file__), 'config.json'))) as f:
    C = json.load(f)['asic']


def get_dport_from_fport(fp, ch=0):
    return bfrt.port.port_hdl_info.get(CONN_ID=fp, CHNL_ID=ch, print_ents=False).data[b'$DEV_PORT']


# clear multicast nodes/groups
if bfrt.pre.node.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.node.get(regex=True, return_ents=True, print_ents=False):
        e.remove()
if bfrt.pre.mgid.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.mgid.get(regex=True, return_ents=True, print_ents=False):
        e.remove()

IN = bfrt.switch.pipe.ingress
EG = bfrt.switch.pipe.egress

IN.net.forwarding_table.clear()
IN.net.arp_table.clear()
IN.agg.R00.R.clear()
IN.agg.R01.R.clear()
IN.agg.R02.R.clear()
IN.agg.R03.R.clear()
IN.agg.R04.R.clear()
IN.agg.R05.R.clear()
IN.agg.R06.R.clear()
IN.agg.R07.R.clear()
IN.agg.R08.R.clear()
IN.agg.R09.R.clear()
IN.agg.R10.R.clear()
IN.agg.R11.R.clear()
IN.agg.R12.R.clear()
IN.agg.R13.R.clear()
IN.agg.R14.R.clear()
IN.agg.R15.R.clear()
IN.agg.R16.R.clear()
IN.agg.R17.R.clear()
IN.agg.R18.R.clear()
IN.agg.R19.R.clear()
IN.agg.R20.R.clear()
IN.agg.R21.R.clear()
IN.agg.R22.R.clear()
IN.agg.R23.R.clear()
IN.agg.R24.R.clear()
IN.agg.R25.R.clear()
IN.agg.R26.R.clear()
IN.agg.R27.R.clear()
IN.agg.R28.R.clear()
IN.agg.R29.R.clear()
IN.agg.R30.R.clear()
IN.agg.R31.R.clear()
IN.agg.Count.clear()
IN.agg.Bitmap.clear()

EG.allreduce_sender.clear()

# Flooding
all_ports = [get_dport_from_fport(C['workers'][w]['port'])
             for w in C['workers']]

IN.net.forwarding_table.add_with_flood(dst_addr=EUI("ff:ff:ff:ff:ff:ff"))
bfrt.pre.node.entry(MULTICAST_NODE_ID=1, MULTICAST_RID=1,
                    MULTICAST_LAG_ID=[], DEV_PORT=all_ports).push()
bfrt.pre.mgid.add(MGID=1, MULTICAST_NODE_ID=[1],
                  MULTICAST_NODE_L1_XID_VALID=[False], MULTICAST_NODE_L1_XID=[0])

# Allreduce job 1
IN.net.arp_table.add_with_arp_resolve(
    dst_proto_addr=IPAddress(C['device']['ip']), mac=EUI(C['device']['mac']))

for w in C['workers']:
    dport = get_dport_from_fport(C['workers'][w]['port'])
    bfrt.port.port.add( DEV_PORT=dport, SPEED="BF_SPEED_100G", FEC="BF_FEC_TYP_NONE",
                        PORT_ENABLE=True, AUTO_NEGOTIATION="PM_AN_FORCE_DISABLE")
    print(f'  enabled port {dport}')

for w in C['workers']:
    dport = get_dport_from_fport(C['workers'][w]['port'])
    mask = 1 << (C['workers'][w]['rank'] - 1)
    mac, ip = EUI(C['workers'][w]['mac']), IPAddress(C['workers'][w]['ip'])
    IN.net.forwarding_table.add_with_send_to_port(dst_addr=mac, port=dport)
    EG.allreduce_sender.add_with_send_to_worker(
        egress_port=dport, mac=mac, ip=ip, mask=mask)
    print('  %s/%s -> %d (%s)' % (mac, ip, dport, w))

# Multicast group for allreduce
worker_ports = [get_dport_from_fport(
    C['workers'][w]['port']) for w in C['workers']]
bfrt.pre.node.entry(MULTICAST_NODE_ID=C['mgid'], MULTICAST_RID=C['mgid'],
                    MULTICAST_LAG_ID=[], DEV_PORT=worker_ports).push()
bfrt.pre.mgid.add(MGID=C['mgid'], MULTICAST_NODE_ID=[C['mgid']],
                  MULTICAST_NODE_L1_XID_VALID=[False], MULTICAST_NODE_L1_XID=[0])

print('  mgid %d -> %s' % (1, all_ports))
print('  mgid %d -> %s' % (C['mgid'], worker_ports))

bfrt.complete_operations()
