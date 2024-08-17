RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) write_value_1 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval1;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) write_value_2 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval2;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) write_value_3 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval3;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) write_value_4 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval4;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) write_value_5 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval5;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) write_value_6 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval6;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) write_value_7 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval7;
    ret = reg;
  }
};
RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) write_value_8 = {
  void apply(inout bit<32> reg, out bit<32> ret) {
    reg = hdr.paxos.paxosval8;
    ret = reg;
  }
};
RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) read_old_round_and_write_max = {
  void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
    ret = reg;
    reg = max(reg, hdr.paxos.rnd);
  }
};
RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) update_history = {
  void apply (inout bit<8> reg, out bit<8> ret) {
    reg = (bit<8>) reg | vote;
    ret = reg;
  }
};
RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) write_history = {
  void apply(inout bit<8> reg, out bit<8> ret) {
    reg = vote;
    ret = reg;
  }
};