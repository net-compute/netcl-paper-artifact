table vote_tbl {
  key = {
    hdr.paxos.acptid: exact;
  }
  actions = {
    get_vote;
  }
  const default_action = get_vote(0);
  const size = 8;
  const entries = {
    16w0b00000001 : get_vote(1 << 0);
    16w0b00000010 : get_vote(1 << 1);
    16w0b00000100 : get_vote(1 << 2);
    16w0b00001000 : get_vote(1 << 3);
    16w0b00010000 : get_vote(1 << 4);
    16w0b00100000 : get_vote(1 << 5);
    16w0b01000000 : get_vote(1 << 6);
    16w0b10000000 : get_vote(1 << 7);
  }
}
table history_tbl {
  key = {
    hdr.paxos.msgtype: ternary;
  }
  actions = {
    update_history_action;
    write_history_action;
  }
  const size = 2;
  const entries = {
    PAXOS_2B : update_history_action();
            _ : write_history_action();
  }
}
table transport_tbl {
  key = {
    meta.paxos_metadata.set_drop : exact;
  }
  actions = {
    _drop;
      forward;
  }
  size = 2;
  default_action =  _drop();
}
table round_check_tbl {
  key = {
    round_dif: ternary;
  }
  actions = {
    round_is_valid;
    round_is_invalid;
  }
  const default_action = round_is_valid;
  const size = 2;
  const entries = {
                                                      0 : round_is_valid();
    (1 << (ROUND_SIZE - 1)) &&& (1 << (ROUND_SIZE - 1)) : round_is_invalid(); // MSB==1 -> larger round
  }
}
table place_holder_table {
  actions = {
    NoAction;
  }
  size = 2;
  default_action = NoAction();
}