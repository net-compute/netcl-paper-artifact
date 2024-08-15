action send_back(bit<32> result) {
  bit<48> tmp;
  bit<32> tmp2;
  bit<16> tmp3;

  /* Put the result back in */
  H.p4calc.res = result;

  /* Swap the MAC addresses */
  tmp = H.eth.dst_addr;
  H.eth.dst_addr = H.eth.src_addr;
  H.eth.src_addr = tmp;

  /* Swap the IP addresses */
  tmp2 = H.ip4.dst_addr;
  H.ip4.dst_addr = H.ip4.src_addr;
  H.ip4.src_addr = tmp2;

  /* Swap UDP ports */
  tmp3 = H.udp.dst_port;
  H.udp.dst_port = H.udp.src_port;
  H.udp.src_port = tmp3;

  /* Disable UDP checksum */
  H.udp.checksum = 0;

  /* Send the packet back to the port it came from */
  TIM.ucast_egress_port = IM.ingress_port;
  DIM.drop_ctl[0:0] = 0;
}

action operation_add() {
  send_back(H.p4calc.operand_a + H.p4calc.operand_b);
}

action operation_sub() {
  send_back(H.p4calc.operand_a - H.p4calc.operand_b);
}

action operation_and() {
  send_back(H.p4calc.operand_a & H.p4calc.operand_b);
}

action operation_or() {
  send_back(H.p4calc.operand_a | H.p4calc.operand_b);
}

action operation_xor() {
  send_back(H.p4calc.operand_a ^ H.p4calc.operand_b);
}

action operation_drop() {
  DIM.drop_ctl[0:0] = 1;
}