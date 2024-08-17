RegisterAction<bit<16>, bit<16>, bit<16>>(_mem_Round) __ra__ncvm_atomic_max_u16_0_0_0_m_0_ = {
  void apply(inout bit<16> R, out bit<16> O){
    O = R;
    R = max(R, H.ncp_data_1_2[0].value);
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_0_) __ra__ncvm_atomic_write_u32_1_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[0].value;
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_1_) __ra__ncvm_atomic_write_u32_2_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[1].value;
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_2_) __ra__ncvm_atomic_write_u32_3_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[2].value;
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_3_) __ra__ncvm_atomic_write_u32_4_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[3].value;
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_4_) __ra__ncvm_atomic_write_u32_5_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[4].value;
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_5_) __ra__ncvm_atomic_write_u32_6_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[5].value;
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_6_) __ra__ncvm_atomic_write_u32_7_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[6].value;
  }
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_7_) __ra__ncvm_atomic_write_u32_8_0_0_m_0_ = {
  void apply(inout bit<32> R, out bit<32> O){
    O = ((bit<32>) R);
    R = H.ncp_data_1_5[7].value;
  }
};
RegisterAction<bit<8>, bit<16>, bit<8>>(_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory) __ra__ncvm_atomic_or_u8_9_0_0_m_0_ = {
  void apply(inout bit<8> R, out bit<8> O){
    O = R;
    R = (R | H.ncp_data_1_4[0].value);
  }
};
RegisterAction<bit<8>, bit<16>, bit<8>>(_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory) __ra__ncvm_atomic_write_u8_10_1_0_m_0_ = {
  void apply(inout bit<8> R, out bit<8> O){
    O = ((bit<8>) R);
    R = H.ncp_data_1_4[0].value;
  }
};