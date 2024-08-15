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