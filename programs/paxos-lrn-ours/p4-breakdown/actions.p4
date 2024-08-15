action get_acptid(bit<8> id) {
  acptid = id;
}
action write_value_1() {
  registerValue1.write(hdr.paxos.inst, hdr.paxos.paxosval1);
}
action write_value_2() {
  registerValue2.write(hdr.paxos.inst, hdr.paxos.paxosval2);
}
action write_value_3() {
  registerValue3.write(hdr.paxos.inst, hdr.paxos.paxosval3);
}
action write_value_4() {
  registerValue4.write(hdr.paxos.inst, hdr.paxos.paxosval4);
}
action write_value_5() {
  registerValue5.write(hdr.paxos.inst, hdr.paxos.paxosval5);
}
action write_value_6() {
  registerValue6.write(hdr.paxos.inst, hdr.paxos.paxosval6);
}
action write_value_7() {
  registerValue7.write(hdr.paxos.inst, hdr.paxos.paxosval7);
}
action write_value_8() {
  registerValue8.write(hdr.paxos.inst, hdr.paxos.paxosval8);
}
action update_round() {
  registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
}
action update_history_action() {
  meta.paxos_metadata.ack_acceptors = update_history.execute(hdr.paxos.inst);
}
action write_history_action() {
  meta.paxos_metadata.ack_acceptors = write_history.execute(hdr.paxos.inst);
}
action _drop() {
  dim.drop_ctl[0:0] = 1;
}
action forward(PortId port, bit<16> learnerPort) {
  tim.ucast_egress_port = port;
  hdr.udp.dstPort = learnerPort;
}
action get_round_check() {
  round_check = (meta.paxos_metadata.old_round - hdr.paxos.rnd);
}