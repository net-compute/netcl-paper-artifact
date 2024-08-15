RegisterAction<expo_t, slot_idx_t, expo_t>(R) write = {
  void apply(inout expo_t reg, out expo_t ret) {
    reg = expo;
    ret = reg;
  }
};
RegisterAction<expo_t, slot_idx_t, expo_t>(R) update = {
  void apply(inout expo_t reg, out expo_t ret) {
    reg = max(reg, expo);
    ret = reg;
  }
};
RegisterAction<expo_t, slot_idx_t, expo_t>(R) read = {
  void apply(inout expo_t reg, out expo_t ret) {
    ret = reg;
  }
};
RegisterAction<value_t, slot_idx_t, value_t>(R) update = {
  void apply(inout value_t reg, out value_t ret) {
    reg = reg + v;
    ret = reg;
  }
};
RegisterAction<value_t, slot_idx_t, value_t>(R) read = {
  void apply(inout value_t reg, out value_t ret) {
    ret = reg;
  }
};
RegisterAction<value_t, slot_idx_t, value_t>(R) write = {
  void apply(inout value_t reg, out value_t ret) {
    reg = v;
    ret = reg;
  }
};
RegisterAction<pair<bitmap_t>, slot_idx_t, bitmap_t>(Bitmap) bitmap_record_hi = {
  void apply(inout pair<bitmap_t> reg, out bitmap_t ret) {
    ret = reg.hi;
    reg.hi = reg.hi | H.agg.mask;    // set hi
    reg.lo = reg.lo & (~H.agg.mask); // clear lo
  }
};
RegisterAction<pair<bitmap_t>, slot_idx_t, bitmap_t>(Bitmap) bitmap_record_lo = {
  void apply(inout pair<bitmap_t> reg, out bitmap_t ret) {
    ret = reg.lo;
    reg.hi = reg.hi & (~H.agg.mask); // clear hi
    reg.lo = reg.lo | H.agg.mask;    // set lo
  }
};
RegisterAction<bit<32>, slot_idx_t, bit<32>>(Count) update_counter = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
    if (reg == 0) {
      reg = ALLREDUCE_WORKERS - 1;
    } else {
      reg = reg - 1;
    }
  }
};
RegisterAction<bit<32>, slot_idx_t, bit<32>>(Count) read_counter = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};