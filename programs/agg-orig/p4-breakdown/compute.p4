header switchml_h {
    bit<4> msg_type;
    bit<1> unused;
    packet_size_t size;
    bit<8> job_number;
    bit<32> tsi;
    bit<16> pool_index;
}

header exponents_h {
    exponent_t e0;
    exponent_t e1;
}

// 128-byte data header
header data_h {
    value_t d00;
    value_t d01;
    value_t d02;
    value_t d03;
    value_t d04;
    value_t d05;
    value_t d06;
    value_t d07;
    value_t d08;
    value_t d09;
    value_t d10;
    value_t d11;
    value_t d12;
    value_t d13;
    value_t d14;
    value_t d15;
    value_t d16;
    value_t d17;
    value_t d18;
    value_t d19;
    value_t d20;
    value_t d21;
    value_t d22;
    value_t d23;
    value_t d24;
    value_t d25;
    value_t d26;
    value_t d27;
    value_t d28;
    value_t d29;
    value_t d30;
    value_t d31;
}
control ReconstructWorkerBitmap(
    inout ingress_metadata_t ig_md) {

    action reconstruct_worker_bitmap_from_worker_id(worker_bitmap_t bitmap) {
        ig_md.worker_bitmap = bitmap;
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

    apply {
        reconstruct_worker_bitmap.apply();
    }
}

control UpdateAndCheckWorkerBitmap(
  inout header_t hdr,
  inout ingress_metadata_t ig_md,
  in ingress_intrinsic_metadata_t ig_intr_md,
  inout ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md,
  inout ingress_intrinsic_metadata_for_tm_t ig_tm_md) {

  Register<worker_bitmap_pair_t, pool_index_by2_t>(num_slots) worker_bitmap;

  RegisterAction<worker_bitmap_pair_t, pool_index_by2_t, worker_bitmap_t>(worker_bitmap) worker_bitmap_update_set0 = {
    void apply(inout worker_bitmap_pair_t value, out worker_bitmap_t return_value) {
      return_value = value.first; // return first set
      value.first  = value.first  | ig_md.worker_bitmap;    // add bit to first set
      value.second = value.second & (~ig_md.worker_bitmap); // remove bit from second set
    }
  };

  RegisterAction<worker_bitmap_pair_t, pool_index_by2_t, worker_bitmap_t>(worker_bitmap) worker_bitmap_update_set1 = {
    void apply(inout worker_bitmap_pair_t value, out worker_bitmap_t return_value) {
      return_value = value.second; // return second set
      value.first  = value.first & (~ig_md.worker_bitmap); // remove bit from first set
      value.second = value.second | ig_md.worker_bitmap;    // add bit to second set
    }
  };

  action drop() {
    // Mark for drop; mark as IGNORE so we don't further process this packet
    ig_dprsr_md.drop_ctl[0:0] = 1;
    ig_md.switchml_md.packet_type = packet_type_t.IGNORE;
  }

  action simulate_drop() {
    drop();
  }

  action check_worker_bitmap_action() {
      // Set map result to nonzero if this packet is a retransmission
    ig_md.switchml_md.map_result = ig_md.switchml_md.worker_bitmap_before & ig_md.worker_bitmap;
  }

  action update_worker_bitmap_set0_action() {
    ig_md.switchml_md.worker_bitmap_before = worker_bitmap_update_set0.execute(ig_md.switchml_md.pool_index[14:1]);
    check_worker_bitmap_action();
  }

  action update_worker_bitmap_set1_action() {
    ig_md.switchml_md.worker_bitmap_before = worker_bitmap_update_set1.execute(ig_md.switchml_md.pool_index[14:1]);
    check_worker_bitmap_action();
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

  apply {
    update_and_check_worker_bitmap.apply();
  }
}
control Exponents(
    in exponent_t exponent0,
    in exponent_t exponent1,
    out exponent_t max_exponent0,
    out exponent_t max_exponent1,
    inout ingress_metadata_t ig_md) {

  Register<exponent_pair_t, pool_index_t>(register_size) exponents;

  // Write both exponents and read first one
  RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) write_read0_register_action = {
    void apply(inout exponent_pair_t value, out exponent_t read_value) {
      value.first = exponent0;
      value.second = exponent1;
      read_value = value.first;
    }
  };

  action write_read0_action() {
    max_exponent0 = write_read0_register_action.execute(ig_md.switchml_md.pool_index);
  }

  // Compute max of both exponents and read first one
  RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) max_read0_register_action = {
    void apply(inout exponent_pair_t value, out exponent_t read_value) {
      value.first  = max(value.first,  exponent0);
      value.second = max(value.second, exponent1);
      read_value = value.first;
    }
  };

  action max_read0_action() {
    max_exponent0 = max_read0_register_action.execute(ig_md.switchml_md.pool_index);
  }

  // Read first max register
  RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) read0_register_action = {
    void apply(inout exponent_pair_t value, out exponent_t read_value) {
      read_value = value.first;
    }
  };

  action read0_action() {
    max_exponent0 = read0_register_action.execute(ig_md.switchml_md.pool_index);
  }

  // Read second max register
  RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) read1_register_action = {
    void apply(inout exponent_pair_t value, out exponent_t read_value) {
      read_value = value.second;
    }
  };

  action read1_action() {
    max_exponent1 = read1_register_action.execute(ig_md.switchml_md.pool_index);
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

  apply {
    exponent_max.apply();
  }
}
const int register_size = 16384;

// Each slot has two registers because of the shadow copy
const int num_slots = register_size / 2;

// Max number of SwitchML workers we support
const int max_num_workers = 32;
const int max_num_workers_log2 = 5; // log base 2 of max_num_workers
const int max_num_queue_pairs_per_worker = 512;
const int max_num_queue_pairs_per_worker_log2 = 9;
// Total number of destination queue pairs
const int max_num_queue_pairs = max_num_queue_pairs_per_worker * max_num_workers;
const int max_num_queue_pairs_log2 = max_num_queue_pairs_per_worker_log2 + max_num_workers_log2;
control Processor(
    in value_t value0,
    in value_t value1,
    out value_t value0_out,
    out value_t value1_out,
    in switchml_md_h switchml_md) {

    Register<value_pair_t, pool_index_t>(register_size) values;

    // Write both values and read first one
    RegisterAction<value_pair_t, pool_index_t, value_t>(values) write_read1_register_action = {
        void apply(inout value_pair_t value, out value_t read_value) {
            value.first = value0;
            value.second = value1;
            read_value = value.second;
        }
    };

    action write_read1_action() {
        value1_out = write_read1_register_action.execute(switchml_md.pool_index);
    }

    // Compute sum of both values and read first one
    RegisterAction<value_pair_t, pool_index_t, value_t>(values) sum_read1_register_action = {
        void apply(inout value_pair_t value, out value_t read_value) {
            value.first  = value.first  + value0;
            value.second = value.second + value1;
            read_value = value.second;
        }
    };

    action sum_read1_action() {
        value1_out = sum_read1_register_action.execute(switchml_md.pool_index);
    }

    // Read first sum register
    RegisterAction<value_pair_t, pool_index_t, value_t>(values) read0_register_action = {
        void apply(inout value_pair_t value, out value_t read_value) {
            read_value = value.first;
        }
    };

    action read0_action() {
        value0_out = read0_register_action.execute(switchml_md.pool_index);
    }

    // Read second sum register
    RegisterAction<value_pair_t, pool_index_t, value_t>(values) read1_register_action = {
        void apply(inout value_pair_t value, out value_t read_value) {
            read_value = value.second;
        }
    };

    action read1_action() {
        value1_out = read1_register_action.execute(switchml_md.pool_index);
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

    apply {
        sum.apply();
    }
}
control WorkersCounter(
    in header_t hdr,
    inout ingress_metadata_t ig_md,
    in ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md) {

    Register<num_workers_pair_t, pool_index_t>(register_size) workers_count;

    RegisterAction<num_workers_pair_t, pool_index_t, num_workers_t>(workers_count) workers_count_action = {
        // 1 means last packet; 0 means first packet
        void apply(inout num_workers_pair_t value, out num_workers_t read_value) {
            // Only works with jobs of 2 workers or more
            read_value = value.first;

            if (value.first == 0) {
                value.first = ig_md.switchml_md.num_workers - 1;
            } else {
                value.first = value.first - 1;
            }
        }
    };

    RegisterAction<num_workers_pair_t, pool_index_t, num_workers_t>(workers_count) read_workers_count_action = {
        void apply(inout num_workers_pair_t value, out num_workers_t read_value) {
            read_value = value.first;
        }
    };

    action count_workers_action() {
        ig_md.switchml_md.first_last_flag = workers_count_action.execute(ig_md.switchml_md.pool_index);
    }

    action single_worker_count_action() {
        // Execute register action even though it's irrelevant with a single worker
        workers_count_action.execute(ig_md.switchml_md.pool_index);
        // Called for a new packet in a single worker job, so mark as last packet
        ig_md.switchml_md.first_last_flag = 1;
    }

    action single_worker_read_action() {
        // Called for a retransmitted packet in a single-worker job
        ig_md.switchml_md.first_last_flag = 0;
    }

    action read_count_workers_action() {
        ig_md.switchml_md.first_last_flag = read_workers_count_action.execute(ig_md.switchml_md.pool_index);
    }

    // If no bits are set in the map result, this was the first time we
    // saw this packet, so decrement worker count. Otherwise, it's a
    // retransmission, so just read the worker count.
    // Only act if packet type is CONSUME0
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

    apply {
        count_workers.apply();
    }
}