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