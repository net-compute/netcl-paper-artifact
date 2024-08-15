action _drop() {
  mark_to_drop();
}
action increase_instance() {
  registerInstance.read(hdr.paxos.inst, 0);
  hdr.paxos.inst = hdr.paxos.inst + 1;
  registerInstance.write(0, hdr.paxos.inst);
  meta.paxos_metadata.set_drop = 0;
}
action reset_instance() {
  registerInstance.write(0, 0);
  // Do not need to forward this message
  meta.paxos_metadata.set_drop = 1;
}
action forward(PortId port, bit<16> acceptorPort) {
  standard_metadata.egress_spec = port;
  hdr.udp.dstPort = acceptorPort;
}