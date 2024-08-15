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
RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) write_read0_register_action = {
  void apply(inout exponent_pair_t value, out exponent_t read_value) {
    value.first = exponent0;
    value.second = exponent1;
    read_value = value.first;
  }
};
RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) max_read0_register_action = {
  void apply(inout exponent_pair_t value, out exponent_t read_value) {
    value.first  = max(value.first,  exponent0);
    value.second = max(value.second, exponent1);
    read_value = value.first;
  }
};
RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) read0_register_action = {
  void apply(inout exponent_pair_t value, out exponent_t read_value) {
    read_value = value.first;
  }
};
RegisterAction<exponent_pair_t, pool_index_t, exponent_t>(exponents) read1_register_action = {
  void apply(inout exponent_pair_t value, out exponent_t read_value) {
    read_value = value.second;
  }
};
RegisterAction<value_pair_t, pool_index_t, value_t>(values) write_read1_register_action = {
    void apply(inout value_pair_t value, out value_t read_value) {
        value.first = value0;
        value.second = value1;
        read_value = value.second;
    }
};
RegisterAction<value_pair_t, pool_index_t, value_t>(values) sum_read1_register_action = {
    void apply(inout value_pair_t value, out value_t read_value) {
        value.first  = value.first  + value0;
        value.second = value.second + value1;
        read_value = value.second;
    }
};
RegisterAction<value_pair_t, pool_index_t, value_t>(values) read0_register_action = {
    void apply(inout value_pair_t value, out value_t read_value) {
        read_value = value.first;
    }
};
RegisterAction<value_pair_t, pool_index_t, value_t>(values) read1_register_action = {
    void apply(inout value_pair_t value, out value_t read_value) {
        read_value = value.second;
    }
};
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