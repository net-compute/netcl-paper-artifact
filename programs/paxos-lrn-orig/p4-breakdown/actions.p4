action _drop() {
  mark_to_drop();
}

action read_round() {
  registerRound.read(meta.paxos_metadata.round, hdr.paxos.inst);
  meta.paxos_metadata.set_drop = 1;
  registerHistory2B.read(meta.paxos_metadata.ack_acceptors, hdr.paxos.inst);
}

action handle_2b() {
  registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  registerValue.write(hdr.paxos.inst, hdr.paxos.paxosval);
  // Limit to 8 bits for left shift operation
  bit<8> acptid = 8w1 << (bit<8>)hdr.paxos.acptid;
  meta.paxos_metadata.ack_acceptors = meta.paxos_metadata.ack_acceptors | acptid;
  registerHistory2B.write(hdr.paxos.inst, meta.paxos_metadata.ack_acceptors);
}
action handle_new_value() {
  registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  registerValue.write(hdr.paxos.inst, hdr.paxos.paxosval);
  bit<8> acptid = 8w1 << (bit<8>)hdr.paxos.acptid;
  registerHistory2B.write(hdr.paxos.inst, acptid);
}
action forward(PortId port, bit<16> learnerPort) {
  standard_metadata.egress_spec = port;
  hdr.udp.dstPort = learnerPort;
}
