table reduce {
  key = {
    bitmap_old: ternary;
    bitmap_chk: ternary;}
  actions = {
    update_register;
    read_register;
    write_register;
    NoAction;
  }
  const default_action = NoAction; // should never happen
  const size = 32;
  const entries = {
    (0, 0) : write_register();
    (_, 0) : update_register();
    (_, _) : read_register();
  }
}
table reduce {
  key = {
    bitmap_old: ternary;
    bitmap_chk: ternary;
  }
  actions = {
    update_register;
    read_register;
    write_register;
    NoAction;
  }
  const default_action = NoAction; // should never happen
  const size = 32;
  const entries = {
    (0, 0) : write_register();
    (_, 0) : update_register();
    (_, _) : read_register();
  }
}
table bitmap {
  key = {
    H.agg.ver: exact;
  }
  actions = {
    bitmap_0;
    bitmap_1;
    NoAction;
  }
  const size = 2;
  const default_action = NoAction;
  const entries = {
    0: bitmap_0();
    1: bitmap_1();
  }
}
table count {
  key = {
    M.agg.bitmap_chk: ternary;
  }
  actions = {
    count_contribution;
    count_retransmission;
    NoAction;
  }
  const size = 2;
  const default_action = NoAction;
  const entries = {
    0: count_contribution();
    _: count_retransmission();
  }
}
table next {
  key = {
    M.agg.bitmap_chk: ternary;
    M.agg.count_old: ternary;
  }
  actions = {
    next_reflect;
    next_multicast;
    next_drop;
    NoAction;
  }
  const default_action = NoAction;
  const entries = {
    ( 0, 0): next_drop();      // First packet for slot
    ( 0, 1): next_multicast(); // not seen and count == 1 ==> completed now
    ( _, 0): next_reflect();   //     seen and count == 0 ==> completed earlier
    ( _, _): next_drop();      // either not seen, count != 1
                                //            seen, count != 0
  }
}
table forwarding_table {
  key = {
    H.eth.dst_addr: exact;
  }
  actions = {
      send_to_port;
      flood;
  }
  const default_action = flood;
  const size = FORWARDING_TABLE_CAPACITY;
}
table arp_table {
  key = {
    H.arp_ip4.dst_proto_addr: exact;
  }
  actions = {
    arp_resolve;
    NoAction;
  }
  const default_action = NoAction;
  const size = ARP_TABLE_CAPACITY;
}
table allreduce_sender {
  key = {
    IM.egress_port: exact;
  }
  actions = {
    send_to_worker;
    NoAction;
  }
  size = ALLREDUCE_WORKER_TABLE_CAPACITY;
  const default_action = NoAction;
}