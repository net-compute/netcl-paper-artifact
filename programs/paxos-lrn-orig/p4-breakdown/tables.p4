table learner_tbl {
  key = {hdr.paxos.msgtype : exact;}
  actions = {
      handle_2b;
  }
  size = 1;
  default_action = handle_2b;
}
table reset_consensus_instance {
  key = {hdr.paxos.msgtype : exact;}
  actions = {
      handle_new_value;
  }
  size = 1;
  default_action = handle_new_value;
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