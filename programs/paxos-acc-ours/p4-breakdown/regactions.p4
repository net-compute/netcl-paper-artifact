RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) value_1_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval1;
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) value_2_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval2;
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) value_3_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval3;
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) value_4_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval4;
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) value_5_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval5;
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) value_6_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval6;
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) value_7_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval7;
      ret = reg;
    }
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) value_8_read_or_write = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    if (read_value) {
      ret = reg;
    } else {
      reg = hdr.paxos.paxosval8;
      ret = reg;
    }
  }
};
RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) read_old_round_and_write_max = {
  void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
    ret = reg;
    reg = max(hdr.paxos.rnd, reg);
  }
};