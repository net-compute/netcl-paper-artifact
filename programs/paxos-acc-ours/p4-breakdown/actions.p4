action value_1_read() {
  hdr.paxos.paxosval1 = read_value_1.execute(hdr.paxos.inst);
}
action value_2_read() {
  hdr.paxos.paxosval2 = read_value_2.execute(hdr.paxos.inst);
}
action value_3_read() {
  hdr.paxos.paxosval3 = read_value_3.execute(hdr.paxos.inst);
}
action value_4_read() {
  hdr.paxos.paxosval4 = read_value_4.execute(hdr.paxos.inst);
}
action value_5_read() {
  hdr.paxos.paxosval5 = read_value_5.execute(hdr.paxos.inst);
}
action value_6_read() {
  hdr.paxos.paxosval6 = read_value_6.execute(hdr.paxos.inst);
}
action value_7_read() {
  hdr.paxos.paxosval7 = read_value_7.execute(hdr.paxos.inst);
}
action value_8_read() {
  hdr.paxos.paxosval8 = read_value_8.execute(hdr.paxos.inst);
}
action value_1_write() {
  hdr.paxos.paxosval1 = write_value_1.execute(hdr.paxos.inst);
}
action value_2_write() {
  hdr.paxos.paxosval2 = write_value_2.execute(hdr.paxos.inst);
}
action value_3_write() {
  hdr.paxos.paxosval3 = write_value_3.execute(hdr.paxos.inst);
}
action value_4_write() {
  hdr.paxos.paxosval4 = write_value_4.execute(hdr.paxos.inst);
}
action value_5_write() {
  hdr.paxos.paxosval5 = write_value_5.execute(hdr.paxos.inst);
}
action value_6_write() {
  hdr.paxos.paxosval6 = write_value_6.execute(hdr.paxos.inst);
}
action value_7_write() {
  hdr.paxos.paxosval7 = write_value_7.execute(hdr.paxos.inst);
}
action value_8_write() {
  hdr.paxos.paxosval8 = write_value_8.execute(hdr.paxos.inst);
}
action _drop() {
  meta.paxos_metadata.set_drop = 1;
  dim.drop_ctl[0:0] = 1;
}
action handle_1a() {
  hdr.paxos.msgtype = PAXOS_1B;
  hdr.paxos.vrnd = registerVRound.read(hdr.paxos.inst);
  meta.paxos_metadata.set_drop = 0;
}
action handle_2a() {
  hdr.paxos.msgtype = PAXOS_2B;
  registerVRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  meta.paxos_metadata.set_drop = 0;
}
action forward(PortId port, bit<16> learnerPort) {
  tim.ucast_egress_port = port;
  hdr.udp.dstPort = learnerPort;
}
action read_round() {
  current_round = compute_and_get_max_round.execute(hdr.paxos.inst);
}