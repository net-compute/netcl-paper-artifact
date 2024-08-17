RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) compute_and_get_max_round = {
  void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
    reg = max(hdr.paxos.rnd, reg);
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) read_value_1 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) read_value_2 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) read_value_3 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) read_value_4 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) read_value_5 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) read_value_6 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) read_value_7 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) read_value_8 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) write_value_1 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval1;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) write_value_2 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval2;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) write_value_3 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval3;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) write_value_4 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval4;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) write_value_5 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval5;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) write_value_6 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval6;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) write_value_7 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval7;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) write_value_8 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval8;
  }
};