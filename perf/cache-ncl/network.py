import sys
import os
import json
from p4utils.utils.compiler import BF_P4C
from p4utils.mininetlib.network_API import NetworkAPI

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__)))
SDE = os.environ['SDE']
SDE_INSTALL = os.path.join(SDE, 'install')


class T1Model:
    PIPES = 4
    FPORTS = 64
    FPORTS_PER_PIPE = 16
    DPORTS_PER_PIPE = 72
    FPORT_CHANNELS = 4
    RPORTS = {
        # These are the Quad 17 ports
        # We ignore Quad 16 ports
        0: [68, 69, 70, 71],
        1: [196, 197, 198, 199],
        2: [324, 235, 326, 327],
        3: [452, 453, 454, 455]
    }
    # Quad 16 ports in pipes 0, 2 are CPU ports
    CPORTS_ETH = [64, 65, 66, 67]
    CPORTS_PCI = [320]

    def get_pipe_from_fport(fport):
        assert fport in range(1, T1Model.FPORTS + 1), "invalid fport"
        return (fport - 1) // T1Model.FPORTS_PER_PIPE

    def get_pport_from_fport(fport, channel=0):
        assert fport in range(1, T1Model.FPORTS + 1), "invalid fport"
        assert channel in range(T1Model.FPORT_CHANNELS), "invalid channel"
        return ((fport - 1) % T1Model.FPORTS_PER_PIPE) * T1Model.FPORT_CHANNELS + channel

    def get_dport_from_pport(pipe, pipe_port):
        assert pipe in range(T1Model.PIPES), "invalid pipe"
        assert pipe_port in range(72), "invalid pipe_port"
        return pipe * 128 + pipe_port

    def get_dport_from_fport(fport, channel=0):
        assert fport in range(1, T1Model.FPORTS + 1), "invalid fport"
        assert channel in range(T1Model.FPORT_CHANNELS), "invalid channel"
        return ((T1Model.get_pipe_from_fport(fport) & 3) << 7) | (T1Model.get_pport_from_fport(fport, channel) & 0x7F)


SWITCH = {'name': "s1", 'mac': "42:00:00:00:00:00", 'ip': "42.0.0.0"}
HOSTS = {
    "server":  {'mac': "42:00:00:00:00:04", 'ip': "42.0.0.4", 'port': 4},
    "client1": {'mac': "42:00:00:00:00:01", 'ip': "42.0.0.1", 'port': 1}}

net = NetworkAPI()
net.setLogLevel('info')
net.enableCli()

net.setCompiler(compilerClass=BF_P4C, sde=SDE, sde_install=SDE_INSTALL)
net.addTofino(SWITCH['name'], sde=SDE, sde_install=SDE_INSTALL,
              mac=SWITCH['mac'], ip=SWITCH['ip'])
net.setP4Source(SWITCH['name'], os.path.abspath(
    os.path.join(os.path.dirname(__file__), 'cache.ncl.device.1.p4')))

for h in HOSTS:
    dport = T1Model.get_dport_from_fport(HOSTS[h]['port'], 0)
    net.addHost(h)
    net.addLink(h, SWITCH['name'], port2=dport)
    net.setIntfName(h, SWITCH['name'], f"{h}-eth0")
    net.setIntfMac(h, SWITCH['name'], HOSTS[h]['mac'])
    net.setIntfIp(h, SWITCH['name'], ip=f"{HOSTS[h]['ip']}/24")

# for w in range(1, NUM_WORKERS + 1):
#     dport = T1Model.get_dport_from_fport(w, 0)
#     net.addHost(f"w{w}")
#     net.addLink(f"w{w}", s, port2=dport)
#     # net.setIntfName(w, s, f"w{w}-eth0")
#     net.setIntfMac(f"w{w}", s, "42:42:42:42:42:%02d" % w)
#     net.setIntfIp(f"w{w}", s, ip="42.42.42.%02d/24" % w)


net.enableLogAll()
# net.disableArpTables()
net.startNetwork()
