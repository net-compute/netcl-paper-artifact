RegisterAction<bit<32>, bit<32>, bit<32>>(cms1) sketch1 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = reg |+| 1;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(cms2) sketch2 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = reg |+| 1;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(cms3) sketch3 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = reg |+| 1;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(cms4) sketch4 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = reg |+| 1;
    ret = reg;
  }
};
RegisterAction<bit<8>, bit<32>, bit<8>>(bf1) filter1 = {
  void apply(inout bit<8> reg, out bit<8> ret) {
    ret = reg;
    reg = 1;
  }
};
RegisterAction<bit<8>, bit<32>, bit<8>>(bf2) filter2 = {
  void apply(inout bit<8> reg, out bit<8> ret) {
    ret = reg;
    reg = 1;
  }
};
RegisterAction<bit<8>, bit<32>, bit<8>>(bf3) filter3 = {
  void apply(inout bit<8> reg, out bit<8> ret) {
    ret = reg;
    reg = 1;
  }
};
RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_set_valid = {
  void apply(inout pair<bit<8>> reg, out bit<8> ret) {
    if (H.cache.mask[0:0] == 1) {
      reg.lo= 1;
    } else {
      reg.hi = 1;
    }
  }
};
RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_set_invalid = {
  void apply(inout pair<bit<8>> reg, out bit<8> ret) {
    if (H.cache.mask[0:0] == 1) {
      reg.lo= 0;
    } else {
      reg.hi = 0;
    }
  }
};
RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_read_lo = {
  void apply(inout pair<bit<8>> reg, out bit<8> ret) {
    ret = reg.lo;
  }
};
RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_read_hi = {
  void apply(inout pair<bit<8>> reg, out bit<8> ret) {
    ret = reg.hi;
  }
};
RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_update = {
  void apply(inout pair<bit<32>> reg, out bit<32> ret) {
    if ( H.cache.mask[0:0] == 1) {
      reg.lo = reg.lo |+| 1;
    } else {
      reg.hi = reg.hi |+| 1;
    }
  }
};
RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_reset = {
  void apply(inout pair<bit<32>> reg, out bit<32> ret) {
    if ( H.cache.mask[0:0] == 1) {
      reg.lo = 0;
    } else {
      reg.hi = 0;
    }
  }
};
RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_read_lo = {
  void apply(inout pair<bit<32>> reg, out bit<32> ret) {
    ret = reg.lo;
  }
};
RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_read_hi = {
  void apply(inout pair<bit<32>> reg, out bit<32> ret) {
    ret = reg.hi;
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache1) read_cache_1 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if ((bool) H.cache.mask[0:0]) {
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache2) read_cache_2 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if ((bool) H.cache.mask[1:1]) {
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache3) read_cache_3 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if ((bool) H.cache.mask[2:2]) {
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache4) read_cache_4 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if ((bool) H.cache.mask[3:3]) {
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache1) write_cache_1 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = H.cache.v1;
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache2) write_cache_2 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = H.cache.v2;
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache3) write_cache_3 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = H.cache.v3;
  }
};
RegisterAction<bit<32>, bit<32>, bit<32>>(Cache4) write_cache_4 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = H.cache.v4;
  }
};