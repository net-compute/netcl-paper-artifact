action get_vote(bit<8> v) {
  vote = v;
}
action value_1_write() {
  write_value_1.execute(hdr.paxos.inst);
}
action value_2_write() {
  write_value_2.execute(hdr.paxos.inst);
}
action value_3_write() {
  write_value_3.execute(hdr.paxos.inst);
}
action value_4_write() {
  write_value_4.execute(hdr.paxos.inst);
}
action value_5_write() {
  write_value_5.execute(hdr.paxos.inst);
action value_6_write() {
  write_value_6.execute(hdr.paxos.inst);
}
action value_7_write() {
  write_value_7.execute(hdr.paxos.inst);
}
action value_8_write() {
  write_value_8.execute(hdr.paxos.inst);
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
action round_is_valid() {
  round_valid = 1;
}
action round_is_invalid() {
  round_valid = 0;
}