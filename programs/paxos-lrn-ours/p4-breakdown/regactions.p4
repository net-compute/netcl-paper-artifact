RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) read_old_round_and_write_max = {
  void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
    ret = reg;
    bit<ROUND_SIZE> tmp = reg - hdr.paxos.rnd;
    if (tmp > (16w0b0111111111111111 / 2)) // hdr.paxos.rnd is larger
      reg = hdr.paxos.rnd;
    if ( (tmp == 0))                       // is equal
      reg = hdr.paxos.rnd;
  }
};
RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) update_history = {
  void apply (inout bit<8> reg, out bit<8> ret) {
    reg = (bit<8>) reg | acptid;
    ret = reg;
  }
};
RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) write_history = {
  void apply(inout bit<8> reg, out bit<8> ret) {
    reg = acptid;
    ret = reg;
  }
};