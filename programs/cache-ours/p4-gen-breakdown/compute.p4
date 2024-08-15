_box_h<bit<64>>[1] ncp_data_1_0;
_box_h<bit<32>>[4] ncp_data_1_1;
_box_h<bit<8>>[1] ncp_data_1_2;
_box_h<bit<32>>[1] ncp_data_1_3;
_box_h<bit<8>>[1] ncp_data_1_4;
bit<32> _tmp__14_icmp_conv_0_sub;
_box_h<bit<32>>[4] _lv__0_cms_i;
bit<16> _lv__1_cacheline = 0;
bit<1> _lv__7_spec_select74_i;
bit<32> _lv__3_spec_select73_i_1;
bool call_i43_i;
bit<8> _tmp__45_cond_in_in;
bit<32> _lv__4_spec_select73_i_2;
bit<32> _tmp__18_icmp_conv_2_sub;
bit<32> call_i50_i;
bit<32> _tmp__16_icmp_conv_1_sub;
bool call_i_i55;
bit<1> _lv__6__2;
bit<32> _lv__5_spec_select73_i_3;
bit<32> _tmp__20_icmp_conv_3_sub;
bit<32> _lv__2_bitmap = 0;
bool call_i47_i;
Hash<bit<14>>(HashAlgorithm_t.CRC16) _hash_0_crc16_u14;
Hash<bit<14>>(HashAlgorithm_t.CRC32) _hash_1_crc32_u14;
Hash<bit<15>>(HashAlgorithm_t.CRC32) _hash_5_crc32_u15;
Hash<bit<15>>(HashAlgorithm_t.XOR32) _hash_4_xor32_u15;
Hash<bit<14>>(HashAlgorithm_t.CRC64) _hash_2_crc64_u14;
Hash<bit<14>>(HashAlgorithm_t.XOR16) _hash_3_xor16_u14;
Hash<bit<15>>(HashAlgorithm_t.CRC64) _hash_6_crc64_u15;
Register<bit<32>, bit<16>>(4096) _mem_Stats0;
Register<bit<32>, bit<16>>(4096) _mem_Cache_fragment_2_;
Register<bit<8>, bit<16>>(4096) _mem_Valid1;
Register<bit<32>, bit<16>>(4096) _mem_Cache_fragment_1_;
Register<bit<32>, bit<16>>(4096) _mem_Cache_fragment_3_;
Register<bit<32>, bit<16>>(4096) _mem_Stats1;
Register<bit<32>, bit<16>>(16384) _mem_c2;
Register<bit<32>, bit<16>>(16384) _mem_c3;
Register<bit<32>, bit<16>>(16384) _mem_c1;
Register<bit<32>, bit<16>>(16384) _mem_c0;
Register<bit<8>, bit<16>>(4096) _mem_Valid0;
Register<bit<8>, bit<16>>(32768) _mem_b0;
Register<bit<8>, bit<16>>(32768) _mem_b1;
Register<bit<8>, bit<16>>(32768) _mem_b2;
Register<bit<32>, bit<16>>(4096) _mem_Cache_fragment_0_;
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_c0) __ra__ncvm_atomic_sadd_new_u32_0_0_0_e_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		R = (R |+| 1);
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_c1) __ra__ncvm_atomic_sadd_new_u32_1_0_0_e_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		R = (R |+| 1);
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_c2) __ra__ncvm_atomic_sadd_new_u32_2_0_0_e_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		R = (R |+| 1);
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_c3) __ra__ncvm_atomic_sadd_new_u32_3_0_0_e_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		R = (R |+| 1);
		O = R;
	}
};
RegisterAction<bit<8>, bit<16>, bool>(_mem_b0) __ra__ncvm_atomic_write_bool_4_0_0_e_0_ = {
	void apply(inout bit<8> R, out bool O){
		O = ((bool) ((bit<1>) R));
		R = ((bit<8>) 1);
	}
};
RegisterAction<bit<8>, bit<16>, bool>(_mem_b1) __ra__ncvm_atomic_write_bool_5_0_0_e_0_ = {
	void apply(inout bit<8> R, out bool O){
		O = ((bool) ((bit<1>) R));
		R = ((bit<8>) 1);
	}
};
RegisterAction<bit<8>, bit<16>, bool>(_mem_b2) __ra__ncvm_atomic_write_bool_6_0_0_e_0_ = {
	void apply(inout bit<8> R, out bool O){
		O = ((bool) ((bit<1>) R));
		R = ((bit<8>) 1);
	}
};
bit<8> ncvm_swi_tbl_key_0;
table ncvm_swi_tbl_0 {
	key = { ncvm_swi_tbl_key_0 : exact; }
	actions = {ncvm_swi_tbl_0_action_0; ncvm_swi_tbl_0_action_1; ncvm_swi_tbl_0_action_2; ncvm_swi_tbl_0_action_3; ncvm_swi_tbl_0_action_default; }
	const default_action = ncvm_swi_tbl_0_action_default();
	const size = 4;
	const entries = {
		7 : ncvm_swi_tbl_0_action_0;
		1 : ncvm_swi_tbl_0_action_1;
		3 : ncvm_swi_tbl_0_action_2;
		5 : ncvm_swi_tbl_0_action_3;
	}
}
RegisterAction<bit<8>, bit<16>, bool>(_mem_Valid0) __ra__ncvm_atomic_cond_write_bool_7_0_0_le_0_ = {
	void apply(inout bit<8> R, out bool O){
		O = ((bool) ((bit<1>) R));
		if (((bool) _lv__2_bitmap[0:0])) {
			R = ((bit<8>) 1);
		}
	}
};
RegisterAction<bit<8>, bit<16>, bool>(_mem_Valid1) __ra__ncvm_atomic_cond_write_bool_8_0_0_le_0_ = {
	void apply(inout bit<8> R, out bool O){
		O = ((bool) ((bit<1>) R));
		if (!((bool) _lv__2_bitmap[0:0])) {
			R = ((bit<8>) 1);
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_0_) __ra__ncvm_atomic_cond_write_u32_9_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		if (((bool) _lv__2_bitmap[0:0])) {
			R = H.ncp_data_1_1[0].value;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_1_) __ra__ncvm_atomic_cond_write_u32_10_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		if (((bool) _lv__2_bitmap[1:1])) {
			R = H.ncp_data_1_1[1].value;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_2_) __ra__ncvm_atomic_cond_write_u32_11_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		if (((bool) _lv__2_bitmap[2:2])) {
			R = H.ncp_data_1_1[2].value;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_3_) __ra__ncvm_atomic_cond_write_u32_12_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		if (((bool) _lv__2_bitmap[3:3])) {
			R = H.ncp_data_1_1[3].value;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_0_) __ra__ncvm_atomic_cond_read_or_u32_13_1_0_le_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if (((bool) _lv__2_bitmap[0:0])) {
			O = ((bit<32>) R);
		}
		else {
			O = 0;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_1_) __ra__ncvm_atomic_cond_read_or_u32_14_1_0_le_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if (((bool) _lv__2_bitmap[1:1])) {
			O = ((bit<32>) R);
		}
		else {
			O = 0;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_2_) __ra__ncvm_atomic_cond_read_or_u32_15_1_0_le_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if (((bool) _lv__2_bitmap[2:2])) {
			O = ((bit<32>) R);
		}
		else {
			O = 0;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_3_) __ra__ncvm_atomic_cond_read_or_u32_16_1_0_le_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if (((bool) _lv__2_bitmap[3:3])) {
			O = ((bit<32>) R);
		}
		else {
			O = 0;
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Stats0) __ra__ncvm_atomic_cond_sadd_u32_17_0_0_le_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		if (((bool) _lv__2_bitmap[0:0])) {
			R = (R |+| 1);
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Stats1) __ra__ncvm_atomic_cond_sadd_u32_18_0_0_le_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		if (!((bool) _lv__2_bitmap[0:0])) {
			R = (R |+| 1);
		}
	}
};
RegisterAction<bit<8>, bit<16>, bool>(_mem_Valid0) __ra__ncvm_atomic_cond_write_bool_19_1_1_le_0_ = {
	void apply(inout bit<8> R, out bool O){
		O = ((bool) ((bit<1>) R));
		if (((bool) _lv__2_bitmap[0:0])) {
			R = ((bit<8>) 0);
		}
	}
};
RegisterAction<bit<8>, bit<16>, bool>(_mem_Valid1) __ra__ncvm_atomic_cond_write_bool_20_1_1_le_0_ = {
	void apply(inout bit<8> R, out bool O){
		O = ((bool) ((bit<1>) R));
		if (!((bool) _lv__2_bitmap[0:0])) {
			R = ((bit<8>) 0);
		}
	}
};
action _mem_lut_Bitmap_Read( bit<32> value) {	_lv__2_bitmap = value; }
action _mem_lut_Index_Read( bit<16> value) {	_lv__1_cacheline = value; }
action mem_rmw_0_mem_Valid0(in bit<16> i) {	__ra__ncvm_atomic_cond_write_bool_7_0_0_le_0_.execute(i); }
action mem_rmw_10_mem_Valid0(in bit<16> i) {	__ra__ncvm_atomic_cond_write_bool_19_1_1_le_0_.execute(i); }
action mem_rmw_11_mem_Valid1(in bit<16> i) {	__ra__ncvm_atomic_cond_write_bool_20_1_1_le_0_.execute(i); }
action mem_rmw_1_mem_Valid1(in bit<16> i) {	__ra__ncvm_atomic_cond_write_bool_8_0_0_le_0_.execute(i); }
action mem_rmw_2_mem_Cache_fragment_0_(in bit<16> i) {	__ra__ncvm_atomic_cond_write_u32_9_0_0_lm_0_.execute(i); }
action mem_rmw_3_mem_Cache_fragment_1_(in bit<16> i) {	__ra__ncvm_atomic_cond_write_u32_10_0_0_lm_0_.execute(i); }
action mem_rmw_4_mem_Cache_fragment_2_(in bit<16> i) {	__ra__ncvm_atomic_cond_write_u32_11_0_0_lm_0_.execute(i); }
action mem_rmw_5_mem_Cache_fragment_3_(in bit<16> i) {	__ra__ncvm_atomic_cond_write_u32_12_0_0_lm_0_.execute(i); }
action mem_rmw_6_mem_Stats0(in bit<16> i) {	__ra__ncvm_atomic_cond_sadd_u32_17_0_0_le_0_.execute(i); }
action mem_rmw_7_mem_Stats1(in bit<16> i) {	__ra__ncvm_atomic_cond_sadd_u32_18_0_0_le_0_.execute(i); }
action mem_rmw_8_mem_Valid0(in bit<16> i) {	__ra__ncvm_atomic_cond_write_bool_19_1_1_le_0_.execute(i); }
action mem_rmw_9_mem_Valid1(in bit<16> i) {	__ra__ncvm_atomic_cond_write_bool_20_1_1_le_0_.execute(i); }
action mem_rmw_o_0_mem_c0(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_sadd_new_u32_0_0_0_e_0_.execute(i); }
action mem_rmw_o_10_mem_Cache_fragment_3_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_read_or_u32_16_1_0_le_0_.execute(i); }
action mem_rmw_o_1_mem_c1(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_sadd_new_u32_1_0_0_e_0_.execute(i); }
action mem_rmw_o_2_mem_c2(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_sadd_new_u32_2_0_0_e_0_.execute(i); }
action mem_rmw_o_3_mem_c3(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_sadd_new_u32_3_0_0_e_0_.execute(i); }
action mem_rmw_o_4_mem_b0(out bool o, in bit<16> i) {	o = __ra__ncvm_atomic_write_bool_4_0_0_e_0_.execute(i); }
action mem_rmw_o_5_mem_b1(out bool o, in bit<16> i) {	o = __ra__ncvm_atomic_write_bool_5_0_0_e_0_.execute(i); }
action mem_rmw_o_6_mem_b2(out bool o, in bit<16> i) {	o = __ra__ncvm_atomic_write_bool_6_0_0_e_0_.execute(i); }
action mem_rmw_o_7_mem_Cache_fragment_0_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_read_or_u32_13_1_0_le_0_.execute(i); }
action mem_rmw_o_8_mem_Cache_fragment_1_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_read_or_u32_14_1_0_le_0_.execute(i); }
action mem_rmw_o_9_mem_Cache_fragment_2_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_read_or_u32_15_1_0_le_0_.execute(i); }
action ncvm_sub_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a - b)); }
action ncvm_xor_8_1_1(out bit<8> c, in bit<1> a, in bit<1> b) {	c = ((bit<8>) (a ^ b)); }
table _mem_lut_Bitmap {
	key = { H.ncp_data_1_0[0].value : exact; }
	actions = {_mem_lut_Bitmap_Read; NoAction; }
	const default_action = NoAction();
	const size = 8192;
}
table _mem_lut_Index {
	key = { H.ncp_data_1_0[0].value : exact; }
	actions = {_mem_lut_Index_Read; NoAction; }
	const default_action = NoAction();
	const size = 4096;
}
apply {
	_lv__0_cms_i[0] = ((_box_h<bit<32>>) {0});
	_lv__0_cms_i[1] = ((_box_h<bit<32>>) {0});
	_lv__0_cms_i[2] = ((_box_h<bit<32>>) {0});
	_lv__0_cms_i[3] = ((_box_h<bit<32>>) {0});
	_mem_lut_Index.apply();
	bool _tmp__2_call_i21 = _mem_lut_Bitmap.apply().hit;
	if (_tmp__2_call_i21) {
		ncvm_swi_tbl_key_0 = H.ncp_data_1_2[0].value;
		switch (ncvm_swi_tbl_0.apply().action_run) {
			ncvm_swi_tbl_0_action_0 : {
				H.ncp_data_1_2[0].value = 8;
				mem_rmw_0_mem_Valid0(_lv__1_cacheline);
				mem_rmw_1_mem_Valid1(_lv__1_cacheline);
				mem_rmw_2_mem_Cache_fragment_0_(_lv__1_cacheline);
				mem_rmw_3_mem_Cache_fragment_1_(_lv__1_cacheline);
				mem_rmw_4_mem_Cache_fragment_2_(_lv__1_cacheline);
				mem_rmw_5_mem_Cache_fragment_3_(_lv__1_cacheline);
				ncvm_action_reflect(M);
			}
			ncvm_swi_tbl_0_action_1 : {
				if (((bool) _lv__2_bitmap[0:0]))
					_tmp__45_cond_in_in = _mem_Valid0.read(_lv__1_cacheline);
				else
					_tmp__45_cond_in_in = _mem_Valid1.read(_lv__1_cacheline);
				if ((_tmp__45_cond_in_in == 0)) { }
				else {
					mem_rmw_o_7_mem_Cache_fragment_0_(H.ncp_data_1_1[0].value, _lv__1_cacheline);
					mem_rmw_o_8_mem_Cache_fragment_1_(H.ncp_data_1_1[1].value, _lv__1_cacheline);
					mem_rmw_o_9_mem_Cache_fragment_2_(H.ncp_data_1_1[2].value, _lv__1_cacheline);
					mem_rmw_o_10_mem_Cache_fragment_3_(H.ncp_data_1_1[3].value, _lv__1_cacheline);
					mem_rmw_6_mem_Stats0(_lv__1_cacheline);
					mem_rmw_7_mem_Stats1(_lv__1_cacheline);
					H.ncp_data_1_2[0].value = 2;
					H.ncp_data_1_3[0].value = _lv__2_bitmap;
					ncvm_action_reflect(M);
				}
			}
			ncvm_swi_tbl_0_action_2 : {
				mem_rmw_10_mem_Valid0(_lv__1_cacheline);
				mem_rmw_11_mem_Valid1(_lv__1_cacheline);
			}
			ncvm_swi_tbl_0_action_3 : {
				mem_rmw_8_mem_Valid0(_lv__1_cacheline);
				mem_rmw_9_mem_Valid1(_lv__1_cacheline);
			}
			ncvm_swi_tbl_0_action_default : { ncvm_action_drop(M); }
		}
	}
	else {
		if ((H.ncp_data_1_2[0].value == 1)) {
			mem_rmw_o_0_mem_c0(_lv__0_cms_i[0].value, ((bit<16>) _hash_0_crc16_u14.get({H.ncp_data_1_0[0].value})));
			mem_rmw_o_1_mem_c1(_lv__0_cms_i[1].value, ((bit<16>) _hash_1_crc32_u14.get({H.ncp_data_1_0[0].value})));
			mem_rmw_o_2_mem_c2(_lv__0_cms_i[2].value, ((bit<16>) _hash_2_crc64_u14.get({H.ncp_data_1_0[0].value})));
			mem_rmw_o_3_mem_c3(call_i50_i, ((bit<16>) _hash_3_xor16_u14.get({H.ncp_data_1_0[0].value})));
			_lv__0_cms_i[3].value = call_i50_i;
			ncvm_sub_32_32_32(_tmp__14_icmp_conv_0_sub, _lv__0_cms_i[1].value, ((bit<32>) _lv__0_cms_i[0].value));
			if (((bool) _tmp__14_icmp_conv_0_sub[31:31]))
				_lv__3_spec_select73_i_1 = _lv__0_cms_i[1].value;
			else
				_lv__3_spec_select73_i_1 = ((bit<32>) _lv__0_cms_i[0].value);
			ncvm_sub_32_32_32(_tmp__16_icmp_conv_1_sub, _lv__0_cms_i[2].value, _lv__3_spec_select73_i_1);
			if (((bool) _tmp__16_icmp_conv_1_sub[31:31]))
				_lv__4_spec_select73_i_2 = _lv__0_cms_i[2].value;
			else
				_lv__4_spec_select73_i_2 = _lv__3_spec_select73_i_1;
			ncvm_sub_32_32_32(_tmp__18_icmp_conv_2_sub, call_i50_i, _lv__4_spec_select73_i_2);
			if (((bool) _tmp__18_icmp_conv_2_sub[31:31]))
				_lv__5_spec_select73_i_3 = call_i50_i;
			else
				_lv__5_spec_select73_i_3 = _lv__4_spec_select73_i_2;
			ncvm_sub_32_32_32(_tmp__20_icmp_conv_3_sub, 4096, _lv__5_spec_select73_i_3);
			if (((bool) _tmp__20_icmp_conv_3_sub[31:31])) {
				mem_rmw_o_4_mem_b0(call_i47_i, ((bit<16>) _hash_4_xor32_u15.get({H.ncp_data_1_0[0].value})));
				mem_rmw_o_5_mem_b1(call_i43_i, ((bit<16>) _hash_5_crc32_u15.get({H.ncp_data_1_0[0].value})));
				mem_rmw_o_6_mem_b2(call_i_i55, ((bit<16>) _hash_6_crc64_u15.get({H.ncp_data_1_0[0].value})));
				if (call_i47_i)
					_lv__6__2 = ((bit<1>) call_i43_i);
				else
					_lv__6__2 = 0;
				if (((bool) _lv__6__2))
					_lv__7_spec_select74_i = ((bit<1>) call_i_i55);
				else
					_lv__7_spec_select74_i = 0;
				ncvm_xor_8_1_1(H.ncp_data_1_4[0].value, _lv__7_spec_select74_i, 1);
			}
			else { }
		}
		else { }
	}
	return;
}