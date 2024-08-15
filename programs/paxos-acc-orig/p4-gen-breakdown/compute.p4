_box_h<bit<32>>[1] ncp_data_1_0;
_box_h<bit<32>>[1] ncp_data_1_1;
_box_h<bit<16>>[1] ncp_data_1_2;
_box_h<bit<16>>[1] ncp_data_1_3;
_box_h<bit<8>>[1] ncp_data_1_4;
_box_h<bit<32>>[8] ncp_data_1_5;
bit<16> call_i;
bit<32> _tmp__0_and;
bit<16> _tmp__3_icmp_conv_0_sub;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_3_;
Register<bit<16>, bit<16>>(65536) _mem_Round;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_7_;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_0_;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_5_;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_4_;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_6_;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_2_;
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_1_;
Register<bit<16>, bit<16>>(65536) _mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound;
RegisterAction<bit<16>, bit<16>, bit<16>>(_mem_Round) __ra__ncvm_atomic_cmp_write_lte_u16_0_0_0_mm_0_ = {
	void apply(inout bit<16> R, out bit<16> O){ }
};
RegisterAction<bit<16>, bit<16>, bit<16>>(_mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound) __ra__ncvm_atomic_write_u16_1_0_0_m_0_ = {
	void apply(inout bit<16> R, out bit<16> O){
		O = ((bit<16>) R);
		R = H.ncp_data_1_2[0].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_0_) __ra__ncvm_atomic_write_u32_2_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[0].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_1_) __ra__ncvm_atomic_write_u32_3_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[1].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_2_) __ra__ncvm_atomic_write_u32_4_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[2].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_3_) __ra__ncvm_atomic_write_u32_5_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[3].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_4_) __ra__ncvm_atomic_write_u32_6_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[4].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_5_) __ra__ncvm_atomic_write_u32_7_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[5].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_6_) __ra__ncvm_atomic_write_u32_8_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[6].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Value_fragment_7_) __ra__ncvm_atomic_write_u32_9_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[7].value;
	}
};
action mem_rmw_0_mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound(in bit<16> i) {	__ra__ncvm_atomic_write_u16_1_0_0_m_0_.execute(i); }
action mem_rmw_1_mem_Value_fragment_0_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_2_0_0_m_0_.execute(i); }
action mem_rmw_2_mem_Value_fragment_1_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_3_0_0_m_0_.execute(i); }
action mem_rmw_3_mem_Value_fragment_2_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_4_0_0_m_0_.execute(i); }
action mem_rmw_4_mem_Value_fragment_3_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_5_0_0_m_0_.execute(i); }
action mem_rmw_5_mem_Value_fragment_4_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_6_0_0_m_0_.execute(i); }
action mem_rmw_6_mem_Value_fragment_5_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_7_0_0_m_0_.execute(i); }
action mem_rmw_7_mem_Value_fragment_6_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_8_0_0_m_0_.execute(i); }
action mem_rmw_8_mem_Value_fragment_7_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_9_0_0_m_0_.execute(i); }
action mem_rmw_o_0_mem_Round(out bit<16> o, in bit<16> i) {	o = __ra__ncvm_atomic_cmp_write_lte_u16_0_0_0_mm_0_.execute(i); }
action ncvm_and_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a & b)); }
action ncvm_sub_16_16_16(out bit<16> c, in bit<16> a, in bit<16> b) {	c = ((bit<16>) (a - b)); }
apply {
	ncvm_and_32_32_32(_tmp__0_and, H.ncp_data_1_0[0].value, 5);
	if ((_tmp__0_and == 0)) {
		ncvm_action_drop(M);
	}
	else {
		mem_rmw_o_0_mem_Round(call_i, ((bit<16>) H.ncp_data_1_1[0].value));
		ncvm_sub_16_16_16(_tmp__3_icmp_conv_0_sub, H.ncp_data_1_2[0].value, call_i);
		if (((bool) _tmp__3_icmp_conv_0_sub[15:15])) {
			ncvm_action_drop(M);
		}
		else {
			H.ncp_data_1_4[0].value = 1;
			if ((H.ncp_data_1_0[0].value == 1)) {
				H.ncp_data_1_0[0].value = 2;
				H.ncp_data_1_3[0].value = _mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[0].value = _mem_Value_fragment_0_.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[1].value = _mem_Value_fragment_1_.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[2].value = _mem_Value_fragment_2_.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[3].value = _mem_Value_fragment_3_.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[4].value = _mem_Value_fragment_4_.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[5].value = _mem_Value_fragment_5_.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[6].value = _mem_Value_fragment_6_.read(((bit<16>) H.ncp_data_1_1[0].value));
				H.ncp_data_1_5[7].value = _mem_Value_fragment_7_.read(((bit<16>) H.ncp_data_1_1[0].value));
				ncvm_action_send_to_device(M, 4);
			}
			else {
				H.ncp_data_1_0[0].value = 8;
				mem_rmw_0_mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_1_mem_Value_fragment_0_(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_2_mem_Value_fragment_1_(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_3_mem_Value_fragment_2_(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_4_mem_Value_fragment_3_(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_5_mem_Value_fragment_4_(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_6_mem_Value_fragment_5_(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_7_mem_Value_fragment_6_(((bit<16>) H.ncp_data_1_1[0].value));
				mem_rmw_8_mem_Value_fragment_7_(((bit<16>) H.ncp_data_1_1[0].value));
				ncvm_action_multicast(M, 12);
			}
		}
	}
	return;
}