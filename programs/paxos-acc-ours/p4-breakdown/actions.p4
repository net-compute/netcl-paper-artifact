action _drop() {
  dim.drop_ctl[0:0] = 1;
}

action handle_1a() {
  hdr.paxos.msgtype = PAXOS_1B;
  hdr.paxos.vrnd = registerVRound.read(hdr.paxos.inst);
  registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  meta.paxos_metadata.set_drop = 0;
  read_value = true;
}

action handle_2a() {
  hdr.paxos.msgtype = PAXOS_2B;
  registerVRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  meta.paxos_metadata.set_drop = 0;
}

action forward(PortId port, bit<16> learnerPort) {
  tim.ucast_egress_port = port;
  hdr.udp.dstPort = learnerPort;
}

action check_for_larger_round() {
  round_check = (meta.paxos_metadata.old_round - hdr.paxos.rnd);
}
