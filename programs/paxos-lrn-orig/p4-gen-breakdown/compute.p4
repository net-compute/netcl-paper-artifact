_box_h<bit<32>>[1] ncp_data_1_0;
_box_h<bit<32>>[1] ncp_data_1_1;
_box_h<bit<16>>[1] ncp_data_1_2;
_box_h<bit<16>>[1] ncp_data_1_3;
_box_h<bit<8>>[1] ncp_data_1_4;
_box_h<bit<32>>[8] ncp_data_1_5;
action ncl_lookup_read_u8(out bit<8> val,  bit<8> value) {val = value; }
action ncl_lookup_read_u16(out bit<16> val,  bit<16> value) {val = value; }
action ncl_lookup_read_u32(out bit<32> val,  bit<32> value) {val = value; }
action ncl_lookup_read_u64(out bit<64> val,  bit<64> value) {val = value; }
action ncl_lookup_read_none() { }
bit<8> _tmp__19_or41;
bit<8> _mem_lut__ZZ7learnerR8msg_typeRjtRtRhPjE8Majority_key = 0;
bit<16> _tmp__12_icmp_conv_1_sub;
bit<8> _tmp__16_and40;
bit<16> call_i36;
bit<16> _tmp__2_icmp_conv_0_sub;
bit<8> _lv__0_votes_0_reg2mem = 0;
@name(".ncvm.mem.net.Value_fragment_2_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_2_;
@name(".ncvm.mem.net.Value_fragment_5_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_5_;
@name(".ncvm.mem.net.Value_fragment_3_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_3_;
@name(".ncvm.mem.net.Value_fragment_0_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_0_;
@name(".ncvm.mem.net._ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory")
@hidden
Register<bit<8>, bit<16>>(65536) _mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory;
@name(".ncvm.mem.net.Value_fragment_4_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_4_;
@name(".ncvm.mem.net.Value_fragment_1_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_1_;
@name(".ncvm.mem.net.Round")
@hidden
Register<bit<16>, bit<16>>(65536) _mem_Round;
@name(".ncvm.mem.net.Value_fragment_7_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_7_;
@name(".ncvm.mem.net.Value_fragment_6_")
@hidden
Register<bit<32>, bit<16>>(65536) _mem_Value_fragment_6_;
RegisterAction<bit<16>, bit<16>, bit<16>>(_mem_Round) __ra__ncvm_atomic_cmp_write_lte_u16_0_0_0_mm_0_ = {
	void apply(inout bit<16> R, out bit<16> O){ }
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
action mem_rmw_0_mem_Value_fragment_0_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_1_0_0_m_0_.execute(i); }
action mem_rmw_1_mem_Value_fragment_1_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_2_0_0_m_0_.execute(i); }
action mem_rmw_2_mem_Value_fragment_2_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_3_0_0_m_0_.execute(i); }
action mem_rmw_3_mem_Value_fragment_3_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_4_0_0_m_0_.execute(i); }
action mem_rmw_4_mem_Value_fragment_4_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_5_0_0_m_0_.execute(i); }
action mem_rmw_5_mem_Value_fragment_5_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_6_0_0_m_0_.execute(i); }
action mem_rmw_6_mem_Value_fragment_6_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_7_0_0_m_0_.execute(i); }
action mem_rmw_7_mem_Value_fragment_7_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_8_0_0_m_0_.execute(i); }
action mem_rmw_o_0_mem_Round(out bit<16> o, in bit<16> i) {	o = __ra__ncvm_atomic_cmp_write_lte_u16_0_0_0_mm_0_.execute(i); }
action mem_rmw_o_1_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory(out bit<8> o, in bit<16> i) {	o = __ra__ncvm_atomic_or_u8_9_0_0_m_0_.execute(i); }
action mem_rmw_o_2_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory(out bit<8> o, in bit<16> i) {	o = __ra__ncvm_atomic_write_u8_10_1_0_m_0_.execute(i); }
action ncvm_and_8_8_8(out bit<8> c, in bit<8> a, in bit<8> b) {	c = ((bit<8>) (a & b)); }
action ncvm_or_8_8_8(out bit<8> c, in bit<8> a, in bit<8> b) {	c = ((bit<8>) (a | b)); }
action ncvm_sub_16_16_16(out bit<16> c, in bit<16> a, in bit<16> b) {	c = ((bit<16>) (a - b)); }
@name(".ncvm.mem.net.lut._ZZ7learnerR8msg_typeRjtRtRhPjE8Majority")
@hidden
table _mem_lut__ZZ7learnerR8msg_typeRjtRtRhPjE8Majority {
	key = { _mem_lut__ZZ7learnerR8msg_typeRjtRtRhPjE8Majority_key : exact; }
	actions = {NoAction; }
	const default_action = NoAction();
	const entries = {
		3 : NoAction();
		5 : NoAction();
		6 : NoAction();
		7 : NoAction();
	}
}
apply {
	if ((H.ncp_data_1_0[0].value == 8)) {
		mem_rmw_o_0_mem_Round(call_i36, ((bit<16>) H.ncp_data_1_1[0].value));
		ncvm_sub_16_16_16(_tmp__2_icmp_conv_0_sub, H.ncp_data_1_2[0].value, call_i36);
		if (((bool) _tmp__2_icmp_conv_0_sub[15:15])) {
			ncvm_action_drop(M);
		}
		else {
			mem_rmw_0_mem_Value_fragment_0_(((bit<16>) H.ncp_data_1_1[0].value));
			mem_rmw_1_mem_Value_fragment_1_(((bit<16>) H.ncp_data_1_1[0].value));
			mem_rmw_2_mem_Value_fragment_2_(((bit<16>) H.ncp_data_1_1[0].value));
			mem_rmw_3_mem_Value_fragment_3_(((bit<16>) H.ncp_data_1_1[0].value));
			mem_rmw_4_mem_Value_fragment_4_(((bit<16>) H.ncp_data_1_1[0].value));
			mem_rmw_5_mem_Value_fragment_5_(((bit<16>) H.ncp_data_1_1[0].value));
			mem_rmw_6_mem_Value_fragment_6_(((bit<16>) H.ncp_data_1_1[0].value));
			mem_rmw_7_mem_Value_fragment_7_(((bit<16>) H.ncp_data_1_1[0].value));
			ncvm_sub_16_16_16(_tmp__12_icmp_conv_1_sub, call_i36, H.ncp_data_1_2[0].value);
			if (((bool) _tmp__12_icmp_conv_1_sub[15:15])) {
				mem_rmw_o_2_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory(_lv__0_votes_0_reg2mem, ((bit<16>) H.ncp_data_1_1[0].value));
			}
			else {
				mem_rmw_o_1_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory(_lv__0_votes_0_reg2mem, ((bit<16>) H.ncp_data_1_1[0].value));
			}
			ncvm_and_8_8_8(_tmp__16_and40, H.ncp_data_1_4[0].value, _lv__0_votes_0_reg2mem);
			if ((_tmp__16_and40 == 0)) {
				ncvm_or_8_8_8(_tmp__19_or41, H.ncp_data_1_4[0].value, _lv__0_votes_0_reg2mem);
				_mem_lut__ZZ7learnerR8msg_typeRjtRtRhPjE8Majority_key = _tmp__19_or41;
				bool _tmp__21_call_i = _mem_lut__ZZ7learnerR8msg_typeRjtRtRhPjE8Majority.apply().hit;
				if (_tmp__21_call_i) { }
				else {
					ncvm_action_drop(M);
				}
			}
			else {
				ncvm_action_drop(M);
			}
		}
	}
	else { }
	return;
}