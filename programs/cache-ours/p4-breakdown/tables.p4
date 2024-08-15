table check {
  key = {
    b1: ternary;
    b2: exact;
    b3: exact;
  }
  actions = {
    hot;
    cold;
  }
  const default_action = cold;
  const size = 1;
  const entries = {
    (1, 1, 1) : hot;
  }
}
table index {
  key = {
    H.cache.k: exact;
  }
  actions = {
    read_idx;
    NoAction;
  }
  default_action = NoAction;
  size = CACHE_SIZE;
}
table mask {
  key = {
    H.cache.k: exact;
  }
  actions = {
    read_mask;
    NoAction;
  }
  default_action = NoAction;
  size = CACHE_SIZE;
}
table chk_valid {
  key = {
    H.cache.mask: ternary;
  }
  actions = {
    read_valid_lo;
    read_valid_hi;
  }
  const entries = {
    1 &&& 1 : read_valid_lo();
          _ : read_valid_hi();
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