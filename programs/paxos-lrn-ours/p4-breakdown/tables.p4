table get_acptid_tbl {
  key = {
    acptid: exact;
  }
  actions = { get_acptid; }
  const size = 8;
  const entries = {
    8w0b00000000 : get_acptid(1 << 8w0b00000000);
    8w0b00000001 : get_acptid(1 << 8w0b00000001);
    8w0b00000010 : get_acptid(1 << 8w0b00000010);
    8w0b00000100 : get_acptid(1 << 8w0b00000100);
    8w0b00001000 : get_acptid(1 << 8w0b00001000);
    8w0b00010000 : get_acptid(1 << 8w0b00010000);
    8w0b00100000 : get_acptid(1 << 8w0b00100000);
    8w0b01000000 : get_acptid(1 << 8w0b01000000);
    8w0b10000000 : get_acptid(1 << 8w0b10000000);
  }
}
table update_round_tbl {
  key = {hdr.paxos.msgtype : exact; }
  actions = { NoAction; update_round; }
  size = 2;
  default_action = NoAction;
}
table history_tbl {
  key = {
    round_check: ternary;
  }
  actions = {
    update_history_action;
    write_history_action;
  }
  const size = 2;
  const entries = {
                                                      0 :  update_history_action();
    (1 << (ROUND_SIZE - 1)) &&& (1 << (ROUND_SIZE - 1)) :  write_history_action();
  }
}
table transport_tbl {
  key = { meta.paxos_metadata.set_drop : exact; }
  actions = {
    _drop;
      forward;
  }
  size = 2;
  default_action =  _drop();
}
table place_holder_table {
  actions = {
    NoAction;
  }
  size = 2;
  default_action = NoAction();
}