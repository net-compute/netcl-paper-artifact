action _drop() {
  mark_to_drop();
}
action read_round() {
  registerRound.read(meta.paxos_metadata.round, hdr.paxos.inst);
  meta.paxos_metadata.set_drop = 1;
}
action handle_1a() {
  hdr.paxos.msgtype = PAXOS_1B;
  registerVRound.read(hdr.paxos.vrnd, hdr.paxos.inst);
  registerValue.read(hdr.paxos.paxosval, hdr.paxos.inst);
  registerAcceptorID.read(hdr.paxos.acptid, 0);
  registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  meta.paxos_metadata.set_drop = 0;
}
action handle_2a() {
  hdr.paxos.msgtype = PAXOS_2B;
  registerAcceptorID.read(hdr.paxos.acptid, 0);
  registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  registerVRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  registerValue.write(hdr.paxos.inst, hdr.paxos.paxosval);
  meta.paxos_metadata.set_drop = 0;
}
action forward(PortId port, bit<16> learnerPort) {
  standard_metadata.egress_spec = port;
  hdr.udp.dstPort = learnerPort;
}