table transport_tbl {
  key = { meta.paxos_metadata.set_drop : exact; }
  actions = {
    _drop;
      forward;
  }
  size = 2;
  default_action =  _drop();
}
table leader_tbl {
  key = {hdr.paxos.msgtype : exact;}
  actions = {
    increase_instance;
    reset_instance;
    _drop;
  }
  size = 4;
  default_action = _drop();
}