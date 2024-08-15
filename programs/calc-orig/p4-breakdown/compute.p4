const bit<16> P4CALC_ETYPE = 0x1234;
const bit<8>  P4CALC_P     = 0x50;   // 'P'
const bit<8>  P4CALC_4     = 0x34;   // '4'
const bit<8>  P4CALC_VER   = 0x01;   // v0.1
const bit<8>  P4CALC_PLUS  = 0x2b;   // '+'
const bit<8>  P4CALC_MINUS = 0x2d;   // '-'
const bit<8>  P4CALC_AND   = 0x26;   // '&'
const bit<8>  P4CALC_OR    = 0x7c;   // '|'
const bit<8>  P4CALC_CARET = 0x5e;   // '^'
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

    /* Put the result back in */
    hdr.p4calc.res = result;

    /* Swap the MAC addresses */
    tmp = hdr.ethernet.dstAddr;
    hdr.ethernet.dstAddr = hdr.ethernet.srcAddr;
    hdr.ethernet.srcAddr = tmp;

    /* Send the packet back to the port it came from */
    standard_metadata.egress_spec = standard_metadata.ingress_port;
}

action operation_add() {
    send_back(hdr.p4calc.operand_a + hdr.p4calc.operand_b);
}

action operation_sub() {
    send_back(hdr.p4calc.operand_a - hdr.p4calc.operand_b);
}

action operation_and() {
    send_back(hdr.p4calc.operand_a & hdr.p4calc.operand_b);
}

action operation_or() {
    send_back(hdr.p4calc.operand_a | hdr.p4calc.operand_b);
}

action operation_xor() {
    send_back(hdr.p4calc.operand_a ^ hdr.p4calc.operand_b);
}

action operation_drop() {
    mark_to_drop(standard_metadata);
}

table calculate {
    key = {
        hdr.p4calc.op        : exact;
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
    const entries = {
        P4CALC_PLUS : operation_add();
        P4CALC_MINUS: operation_sub();
        P4CALC_AND  : operation_and();
        P4CALC_OR   : operation_or();
        P4CALC_CARET: operation_xor();
    }
}


apply {
    if (hdr.p4calc.isValid()) {
        calculate.apply();
    } else {
        operation_drop();
    }
}