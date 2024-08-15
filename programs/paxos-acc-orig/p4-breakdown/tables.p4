table acceptor_tbl {
  key = {hdr.paxos.msgtype : exact;}
  actions = {
    handle_1a;
    handle_2a;
    _drop;
  }
  size = 4;
  default_action = _drop();
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