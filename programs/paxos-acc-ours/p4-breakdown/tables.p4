table read_or_write_value_1 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_1_read;
    value_1_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_1_read();
    PAXOS_2A  : value_1_write();
  }
}
table read_or_write_value_2 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_2_read;
    value_2_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_2_read();
    PAXOS_2A  : value_2_write();
  }
}
table read_or_write_value_3 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_3_read;
    value_3_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_3_read();
    PAXOS_2A  : value_3_write();
  }
}
table read_or_write_value_4 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_4_read;
    value_4_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_4_read();
    PAXOS_2A  : value_4_write();
  }
}
table read_or_write_value_5 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_5_read;
    value_5_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_5_read();
    PAXOS_2A  : value_5_write();
  }
}
table read_or_write_value_6 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_6_read;
    value_6_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_6_read();
    PAXOS_2A  : value_6_write();
  }
}
table read_or_write_value_7 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_7_read;
    value_7_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_7_read();
    PAXOS_2A  : value_7_write();
  }
}
table read_or_write_value_8 {
  key = {
    hdr.paxos.msgtype: exact;
  }
  actions = {
    value_8_read;
    value_8_write;
    NoAction;
  }
  default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A  : value_8_read();
    PAXOS_2A  : value_8_write();
  }
}
table acceptor_tbl {
  key = { hdr.paxos.msgtype : exact; }
  actions = {
    handle_1a;
    handle_2a;
    _drop;
  }
  size = 2;
  default_action = _drop();
  const entries = {
    PAXOS_1A : handle_1a();
    PAXOS_2A : handle_2a();
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
table round_tbl {
  key = { hdr.paxos.msgtype: exact; }
  actions = { read_round; NoAction; }
  const default_action = NoAction;
  const size = 2;
  const entries = {
    PAXOS_1A: read_round();
    PAXOS_2A: read_round();
  }
}
table place_holder_table {
  actions = {
    NoAction;
  }
  size = 2;
  default_action = NoAction();
}