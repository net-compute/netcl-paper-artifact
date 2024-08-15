const bit<16> P4CALC_ETYPE = 0x1234;
const bit<8>  P4CALC_P     = 0x50;   // 'P'
const bit<8>  P4CALC_4     = 0x34;   // '4'
const bit<8>  P4CALC_VER   = 0x01;   // v0.1
const bit<8>  P4CALC_PLUS  = 0x2b;   // '+'
const bit<8>  P4CALC_MINUS = 0x2d;   // '-'
const bit<8>  P4CALC_AND   = 0x26;   // '&'
const bit<8>  P4CALC_OR    = 0x7c;   // '|'
const bit<8>  P4CALC_CARET = 0x5e;  
header p4calc_t {
  bit<8>  p;
  bit<8>  four;
  bit<8>  ver;
  bit<8>  op;
  bit<32> operand_a;
  bit<32> operand_b;
  bit<32> res;
}
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

table calculate {
  key = {
    H.p4calc.op        : exact;
  }
  actions = {
    operation_add;
    operation_sub;
    operation_and;
    operation_or;
    operation_xor;
    operation_drop;
  }
  const default_action = operation_drop();
  const size = 5;
  const entries = {
    P4CALC_PLUS : operation_add();
    P4CALC_MINUS: operation_sub();
    P4CALC_AND  : operation_and();
    P4CALC_OR   : operation_or();
    P4CALC_CARET: operation_xor();
  }
}

apply {
  if (H.p4calc.isValid()) {
    calculate.apply();
  } else {
    operation_drop();
  }
}