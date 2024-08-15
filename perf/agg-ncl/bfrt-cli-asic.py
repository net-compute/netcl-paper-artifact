from netaddr import IPAddress, EUI
import json
import os

NCL_REFLECT_ACTION=6
NCL_MULTICAST_ACTION=9
NCL_DROP_ACTION=3

def get_dport_from_fport(fp, ch=0):
    return bfrt.port.port_hdl_info.get(CONN_ID=fp, CHNL_ID=ch, print_ents=False).data[b'$DEV_PORT']


with open(os.path.abspath(os.path.join(os.path.dirname(__file__), 'config.json'))) as f:
    C = json.load(f)['asic']


# clear multicast nodes/groups
if bfrt.pre.node.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.node.get(regex=True, return_ents=True, print_ents=False):
        e.remove()
if bfrt.pre.mgid.info(return_info=True, print_info=False)['usage']:
    for e in bfrt.pre.mgid.get(regex=True, return_ents=True, print_ents=False):
        e.remove()

print("configuration")
print(f" p4_allreduce_{C['active-workers']}_ncl_device_1")

NCRT = eval(f'bfrt.p4_allreduce_{C["active-workers"]}_ncl_device_1.pipe.ncrt')
NCVM = eval(f'bfrt.p4_allreduce_{C["active-workers"]}_ncl_device_1.pipe.ncvm')
NET = eval(f'bfrt.p4_allreduce_{C["active-workers"]}_ncl_device_1.pipe.MainIngress.net')

# NCRT tables
NCRT.ingress.tbl.forward.multicast.clear()
NCRT.ingress.tbl.forward.host.clear()
NCRT.ingress.tbl.forward.device.clear()
NCRT.egress.tbl.ports.clear()
NCRT.egress.tbl.udp.adj.clear()

# NCVM (codegen) tables
for i in range(32):
    exec(f"NCVM.mem.net.Agg_fragment_{i}_.clear()")
NCVM.mem.net.Expo.clear()
NCVM.mem.net.Count.clear()
NCVM.mem.net.Bitmap_fragment_0_.clear()
NCVM.mem.net.Bitmap_fragment_1_.clear()

# NET tables
NET.forwarding_table.clear()
NET.arp_table.clear()

all_ports = [get_dport_from_fport(C['workers'][w]['port'])
             for (i,w) in enumerate(C['workers']) if i < C['active-workers']]

# multicast
print("multicast groups")
bfrt.pre.node.entry(MULTICAST_NODE_ID=1, MULTICAST_RID=1,
                    MULTICAST_LAG_ID=[], DEV_PORT=all_ports).push()
bfrt.pre.mgid.add(MGID=1, MULTICAST_NODE_ID=[1],
                  MULTICAST_NODE_L1_XID_VALID=[False], MULTICAST_NODE_L1_XID=[0])
bfrt.pre.node.entry(MULTICAST_NODE_ID=C['mgid'], MULTICAST_RID=C['mgid'],
                    MULTICAST_LAG_ID=[], DEV_PORT=all_ports).push()
bfrt.pre.mgid.add(MGID=C['mgid'], MULTICAST_NODE_ID=[C['mgid']],
                  MULTICAST_NODE_L1_XID_VALID=[False], MULTICAST_NODE_L1_XID=[0])

# ncp_mcast = pipe.ncrt.ingress.tbl.forward.multicast
# ncp_mcast.add_with_ncl_multicast(ncl_act_arg=42, mgid=2)

print(f" {1:2d} -> {all_ports}")
print(f" {C['mgid']:2d} -> {all_ports}")

# forward
print("ncrt configuration")

NCRT.ingress.tbl.forward.multicast.add_with_ncl_multicast(ncl_act_arg=42, mgid=C['mgid'])
print(f" ncl_multicast(42) -> {C['mgid']}")

for i, w in enumerate(C['workers']):
    if i < C['active-workers']:
        dport = get_dport_from_fport(C['workers'][w]['port'])
        rank = C['workers'][w]['rank']

        # enable switch ports
        bfrt.port.port.add( DEV_PORT=dport, SPEED="BF_SPEED_100G", FEC="BF_FEC_TYP_NONE",
                            PORT_ENABLE=True, AUTO_NEGOTIATION="PM_AN_FORCE_DISABLE")

        NCRT.ingress.tbl.forward.host.add_with_ncl_forward_host(ncl_act_arg=rank, port=dport)
        NCRT.egress.tbl.ports.add_with_host_port(egress_port=dport, id=rank, ip=C['workers'][w]['ip'], mac=C['workers'][w]['mac'], neighbor=True)

        # A bit of a dirty hack (the compiler is compicit!) to have multicasts and reflects
        # use the src UDP port of the packet as the dst port. Need something better and more generic
        NCRT.egress.tbl.udp.adj.add_with_udp_ports_swap(cid=1, act=NCL_MULTICAST_ACTION, h_dst=rank)
        NCRT.egress.tbl.udp.adj.add_with_udp_ports_swap(cid=1, act=NCL_REFLECT_ACTION, h_dst=rank)
        # NCRT.egress.tbl.udp.adj.add_with_udp_ports_swap(cid=1, act=NCL_MULTICAST_ACTION)
        # NCRT.egress.tbl.udp.adj.add_with_udp_ports_swap(cid=1, act=NCL_REFLECT_ACTION)

        print(f" host {C['workers'][w]['rank']} -> port {dport}")

# NETWORKING
print("network configuration")
for i, w in enumerate(C['workers']):
    if i < C['active-workers']:
        dport = get_dport_from_fport(C['workers'][w]['port'])
        mac = EUI(C['workers'][w]['mac'])
        ip = IPAddress(C['workers'][w]['ip'])
        NET.arp_table.add_with_arp_resolve(dst_proto_addr=ip, mac=mac)
        NET.forwarding_table.add_with_forward(dst_addr=mac, port=dport)
        print(f" {mac}/{ip} -> port {dport}")

NET.arp_table.set_default_with_multicast(mgid=1)
NET.arp_table.add_with_arp_resolve(dst_proto_addr=IPAddress(
    "42.42.42.42"), mac=EUI("42:42:42:42:42:42"))
NET.arp_table.add_with_arp_resolve(dst_proto_addr=IPAddress(
    C['device']['ip']), mac=EUI(C['device']['mac']))
print(f" {EUI(C['device']['mac'])}/{IPAddress(C['device']['ip'])} -> device {C['device']['id']} address")
print(f" {EUI('42:42:42:42:42:42')}/{IPAddress('42.42.42.42')} -> ncl-ipmlicit address")

NET.forwarding_table.set_default_with_multicast(mgid=1)
NET.forwarding_table.add_with_multicast(
    dst_addr=EUI("ff:ff:ff:ff:ff:ff"), mgid=1)
print(f" {EUI('ff:ff:ff:ff:ff:ff')} -> mgid 1")


bfrt.complete_operations()
