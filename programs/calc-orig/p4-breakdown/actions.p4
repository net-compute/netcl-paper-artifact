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