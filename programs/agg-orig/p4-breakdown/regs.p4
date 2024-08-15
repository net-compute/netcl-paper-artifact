Register<worker_bitmap_pair_t, pool_index_by2_t>(num_slots) worker_bitmap;
Register<exponent_pair_t, pool_index_t>(register_size) exponents;
Register<value_pair_t, pool_index_t>(register_size) values;
Register<num_workers_pair_t, pool_index_t>(register_size) workers_count;
