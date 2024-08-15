action _drop() {
  dim.drop_ctl[0:0] = 1;
}

action increase_instance() {
  hdr.paxos.inst = inc_instance.execute(0);
  meta.paxos_metadata.set_drop = 0;
}

action reset_instance() {
  hdr.paxos.inst = rst_instance.execute(0);
  meta.paxos_metadata.set_drop = 1;
}
action forward(PortId port, bit<16> acceptorPort) {
  tim.ucast_egress_port = port;
  hdr.udp.dstPort = acceptorPort;
}
