table arp_icmp {
    key = {
        hdr.arp_ipv4.isValid()      : exact;
        hdr.icmp.isValid()          : exact;
        hdr.arp.opcode              : ternary;
        hdr.arp_ipv4.dst_proto_addr : ternary;
        hdr.icmp.msg_type           : ternary;
        hdr.ipv4.dst_addr           : ternary;
    }
    actions = {
        send_arp_reply;
        send_icmp_echo_reply;
    }
    size = 2;
}
table reconstruct_worker_bitmap {
  key = {
    ig_md.switchml_md.worker_id : ternary;
  }
  actions = {
    reconstruct_worker_bitmap_from_worker_id;
  }
  const entries = {
    0  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 0);
    1  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 1);
    2  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 2);
    3  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 3);
    4  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 4);
    5  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 5);
    6  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 6);
    7  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 7);
    8  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 8);
    9  &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 9);
    10 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 10);
    11 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 11);
    12 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 12);
    13 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 13);
    14 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 14);
    15 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 15);
    16 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 16);
    17 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 17);
    18 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 18);
    19 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 19);
    20 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 20);
    21 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 21);
    22 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 22);
    23 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 23);
    24 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 24);
    25 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 25);
    26 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 26);
    27 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 27);
    28 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 28);
    29 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 29);
    30 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 30);
    31 &&& 0x1f : reconstruct_worker_bitmap_from_worker_id(1 << 31);
  }
}
table update_and_check_worker_bitmap {
  key = {
    ig_md.switchml_md.pool_index : ternary;
    ig_md.switchml_md.packet_type : ternary; // only act on packets of type CONSUME0
    ig_md.port_metadata.ingress_drop_probability : ternary; // if nonzero, drop packet
  }
  actions = {
    update_worker_bitmap_set0_action;
    update_worker_bitmap_set1_action;
    drop;
    simulate_drop;
    NoAction;
  }
  const entries = {
    // Drop packets indicated by the drop simulator
    (            _, packet_type_t.CONSUME0, 0xffff) : simulate_drop();

    // Direct updates to the correct set
    (15w0 &&& 15w1, packet_type_t.CONSUME0,      _) : update_worker_bitmap_set0_action();
    (15w1 &&& 15w1, packet_type_t.CONSUME0,      _) : update_worker_bitmap_set1_action();

    (15w0 &&& 15w1, packet_type_t.CONSUME1,      _) : update_worker_bitmap_set0_action();
    (15w1 &&& 15w1, packet_type_t.CONSUME1,      _) : update_worker_bitmap_set1_action();

    (15w0 &&& 15w1, packet_type_t.CONSUME2,      _) : update_worker_bitmap_set0_action();
    (15w1 &&& 15w1, packet_type_t.CONSUME2,      _) : update_worker_bitmap_set1_action();

    (15w0 &&& 15w1, packet_type_t.CONSUME3,      _) : update_worker_bitmap_set0_action();
    (15w1 &&& 15w1, packet_type_t.CONSUME3,      _) : update_worker_bitmap_set1_action();
  }
  const default_action = NoAction;
}
table exponent_max {
  key = {
    ig_md.switchml_md.worker_bitmap_before : ternary;
    ig_md.switchml_md.map_result : ternary;
    ig_md.switchml_md.packet_type: ternary;
  }
  actions = {
    write_read0_action;
    max_read0_action;
    read0_action;
    read1_action;
    @defaultonly NoAction;
  }
  size = 4;
  const entries = {
      // If bitmap_before is all 0's and type is CONSUME0, this is the first packet for slot,
      // so just write values and read first value
      (32w0,    _, packet_type_t.CONSUME0) : write_read0_action();
      // If bitmap_before is nonzero, map_result is all 0's, and type is CONSUME0,
      // compute max of values and read first value
      (   _, 32w0, packet_type_t.CONSUME0) : max_read0_action();
      // If bitmap_before is nonzero, map_result is nonzero, and type is CONSUME0,
      // this is a retransmission, so just read first value
      (   _,    _, packet_type_t.CONSUME0) : read0_action();
      // if type is HARVEST7, read second value
      (   _,    _, packet_type_t.HARVEST7) : read1_action();
  }
  // If none of the above are true, do nothing.
  const default_action = NoAction;
}
table forward {
  key = {
    hdr.ethernet.dst_addr : exact;
  }
  actions = {
    set_egress_port;
    flood;
  }
  size = forwarding_table_size;
}
table next_step {
  key = {
    ig_md.switchml_md.packet_size : ternary;
    ig_md.switchml_md.worker_id : ternary;
    ig_md.switchml_md.packet_type : ternary;
    ig_md.switchml_md.first_last_flag : ternary; // 1: last 0: first
    ig_md.switchml_md.map_result : ternary;
  }
  actions = {
    recirculate_for_CONSUME1;
    recirculate_for_CONSUME2_same_port_next_pipe;
    recirculate_for_CONSUME3_same_port_next_pipe;
    recirculate_for_HARVEST1;
    recirculate_for_HARVEST2;
    recirculate_for_HARVEST3;
    recirculate_for_HARVEST4;
    recirculate_for_HARVEST5;
    recirculate_for_HARVEST6;
    recirculate_for_HARVEST7;
    finish_consume;
    broadcast;
    retransmit;
    drop;
  }
  const default_action = drop();
  size = 128;
}
table sum {
    key = {
        switchml_md.worker_bitmap_before : ternary;
        switchml_md.map_result : ternary;
        switchml_md.packet_type: ternary;
    }
    actions = {
        write_read1_action;
        sum_read1_action;
        read0_action;
        read1_action;
        NoAction;
    }
    size = 20;
    const entries = {
        // If bitmap_before is all 0's and type is CONSUME, this is the first packet for slot,
        // so just write values and read second value
        (32w0,    _, packet_type_t.CONSUME0) : write_read1_action();
        (32w0,    _, packet_type_t.CONSUME1) : write_read1_action();
        (32w0,    _, packet_type_t.CONSUME2) : write_read1_action();
        (32w0,    _, packet_type_t.CONSUME3) : write_read1_action();
        // If bitmap_before is nonzero, map_result is all 0's, and type is CONSUME,
        // compute sum of values and read second value
        (   _, 32w0, packet_type_t.CONSUME0) : sum_read1_action();
        (   _, 32w0, packet_type_t.CONSUME1) : sum_read1_action();
        (   _, 32w0, packet_type_t.CONSUME2) : sum_read1_action();
        (   _, 32w0, packet_type_t.CONSUME3) : sum_read1_action();
        // If bitmap_before is nonzero, map_result is nonzero, and type is CONSUME,
        // this is a retransmission, so just read second value
        (   _,    _, packet_type_t.CONSUME0) : read1_action();
        (   _,    _, packet_type_t.CONSUME1) : read1_action();
        (   _,    _, packet_type_t.CONSUME2) : read1_action();
        (   _,    _, packet_type_t.CONSUME3) : read1_action();
        // If type is HARVEST, read one set of values based on sequence
        (   _,    _, packet_type_t.HARVEST0) : read1_action(); // extract data1 slice in pipe 3
        (   _,    _, packet_type_t.HARVEST1) : read0_action(); // extract data0 slice in pipe 3
        (   _,    _, packet_type_t.HARVEST2) : read1_action(); // extract data1 slice in pipe 2
        (   _,    _, packet_type_t.HARVEST3) : read0_action(); // extract data0 slice in pipe 2
        (   _,    _, packet_type_t.HARVEST4) : read1_action(); // extract data1 slice in pipe 1
        (   _,    _, packet_type_t.HARVEST5) : read0_action(); // extract data0 slice in pipe 1
        (   _,    _, packet_type_t.HARVEST6) : read1_action(); // extract data1 slice in pipe 0
        (   _,    _, packet_type_t.HARVEST7) : read0_action(); // last pass; extract data0 slice in pipe 0
    }
    // If none of the above are true, do nothing.
    const default_action = NoAction;
}
table receive_udp {
    key = {
        // use ternary matches to support matching on:
        // * ingress port only like the original design
        // * source IP and UDP destination port for the SwitchML Eth protocol
        // * source IP and UDP destination port for the SwitchML UDP protocol
        // * source IP and destination QP number for the RoCE protocols
        // * also, parser error values so we can drop bad packets
        ig_intr_md.ingress_port   : ternary;
        hdr.ethernet.src_addr     : ternary;
        hdr.ethernet.dst_addr     : ternary;
        hdr.ipv4.src_addr         : ternary;
        hdr.ipv4.dst_addr         : ternary;
        hdr.udp.dst_port          : ternary;
        ig_prsr_md.parser_err     : ternary;
    }

    actions = {
        drop;
        set_bitmap;
        @defaultonly forward;
    }
    const default_action = forward;

    // Create some extra table space to support parser error entries
    size = max_num_workers + 16;

    // Count received packets
    counters = receive_counter;
}
table switch_mac_and_ip {
    actions = { @defaultonly set_switch_mac_and_ip; }
    size = 1;
}
table dst_addr {
    key = {
        eg_md.switchml_md.worker_id : exact;
    }
    actions = {
        set_dst_addr;
    }
    size = max_num_workers;
    counters = send_counter;
}
table count_workers {
    key = {
        ig_md.switchml_md.num_workers: ternary;
        ig_md.switchml_md.map_result : ternary;
        ig_md.switchml_md.packet_type: ternary;
    }
    actions = {
        single_worker_count_action;
        single_worker_read_action;
        count_workers_action;
        read_count_workers_action;
        @defaultonly NoAction;
    }
    const entries = {
        // Special case for single-worker jobs
        // if map_result is all 0's and type is CONSUME0, this is the first time we've seen this packet
        (1, 0, packet_type_t.CONSUME0) : single_worker_count_action();
        (1, 0, packet_type_t.CONSUME1) : single_worker_count_action();
        (1, 0, packet_type_t.CONSUME2) : single_worker_count_action();
        (1, 0, packet_type_t.CONSUME3) : single_worker_count_action();

        // if we've seen this packet before, don't count, just read
        (1, _, packet_type_t.CONSUME0) : single_worker_read_action();
        (1, _, packet_type_t.CONSUME1) : single_worker_read_action();
        (1, _, packet_type_t.CONSUME2) : single_worker_read_action();
        (1, _, packet_type_t.CONSUME3) : single_worker_read_action();

        // Multi-worker jobs
        // if map_result is all 0's and type is CONSUME0, this is the first time we've seen this packet
        (_, 0, packet_type_t.CONSUME0) : count_workers_action();
        (_, 0, packet_type_t.CONSUME1) : count_workers_action();
        (_, 0, packet_type_t.CONSUME2) : count_workers_action();
        (_, 0, packet_type_t.CONSUME3) : count_workers_action();
        // if map_result is not all 0's, don't count, just read
        (_, _, packet_type_t.CONSUME0) : read_count_workers_action();
        (_, _, packet_type_t.CONSUME1) : read_count_workers_action();
        (_, _, packet_type_t.CONSUME2) : read_count_workers_action();
        (_, _, packet_type_t.CONSUME3) : read_count_workers_action();
    }
    const default_action = NoAction;
}