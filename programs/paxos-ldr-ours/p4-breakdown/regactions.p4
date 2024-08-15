RegisterAction<bit<INSTANCE_SIZE>, bit<1>, bit<INSTANCE_SIZE>>(registerInstance) inc_instance = {
  void apply(inout bit<INSTANCE_SIZE> reg, out bit<INSTANCE_SIZE> ret) {
    reg = reg + 1;
    ret = reg;
  }
};
RegisterAction<bit<INSTANCE_SIZE>, bit<1>, bit<INSTANCE_SIZE>>(registerInstance) rst_instance = {
  void apply(inout bit<INSTANCE_SIZE> reg, out bit<INSTANCE_SIZE> ret) {
    reg = 0;
    ret = reg;
  }
};