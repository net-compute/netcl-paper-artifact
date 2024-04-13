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
				R = H.ncp_data_1_2[0].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_1_) __ra__ncvm_atomic_cond_write_u32_10_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[1:1])) {
				R = H.ncp_data_1_2[1].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_2_) __ra__ncvm_atomic_cond_write_u32_11_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[2:2])) {
				R = H.ncp_data_1_2[2].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_3_) __ra__ncvm_atomic_cond_write_u32_12_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[3:3])) {
				R = H.ncp_data_1_2[3].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_4_) __ra__ncvm_atomic_cond_write_u32_13_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[4:4])) {
				R = H.ncp_data_1_2[4].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_5_) __ra__ncvm_atomic_cond_write_u32_14_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[5:5])) {
				R = H.ncp_data_1_2[5].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_6_) __ra__ncvm_atomic_cond_write_u32_15_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[6:6])) {
				R = H.ncp_data_1_2[6].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_7_) __ra__ncvm_atomic_cond_write_u32_16_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[7:7])) {
				R = H.ncp_data_1_2[7].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_8_) __ra__ncvm_atomic_cond_write_u32_17_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[8:8])) {
				R = H.ncp_data_1_2[8].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_9_) __ra__ncvm_atomic_cond_write_u32_18_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[9:9])) {
				R = H.ncp_data_1_2[9].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_10_) __ra__ncvm_atomic_cond_write_u32_19_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[10:10])) {
				R = H.ncp_data_1_2[10].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_11_) __ra__ncvm_atomic_cond_write_u32_20_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[11:11])) {
				R = H.ncp_data_1_2[11].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_12_) __ra__ncvm_atomic_cond_write_u32_21_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[12:12])) {
				R = H.ncp_data_1_2[12].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_13_) __ra__ncvm_atomic_cond_write_u32_22_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[13:13])) {
				R = H.ncp_data_1_2[13].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_14_) __ra__ncvm_atomic_cond_write_u32_23_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[14:14])) {
				R = H.ncp_data_1_2[14].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_15_) __ra__ncvm_atomic_cond_write_u32_24_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[15:15])) {
				R = H.ncp_data_1_2[15].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_16_) __ra__ncvm_atomic_cond_write_u32_25_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[16:16])) {
				R = H.ncp_data_1_2[16].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_17_) __ra__ncvm_atomic_cond_write_u32_26_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[17:17])) {
				R = H.ncp_data_1_2[17].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_18_) __ra__ncvm_atomic_cond_write_u32_27_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[18:18])) {
				R = H.ncp_data_1_2[18].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_19_) __ra__ncvm_atomic_cond_write_u32_28_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[19:19])) {
				R = H.ncp_data_1_2[19].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_20_) __ra__ncvm_atomic_cond_write_u32_29_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[20:20])) {
				R = H.ncp_data_1_2[20].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_21_) __ra__ncvm_atomic_cond_write_u32_30_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[21:21])) {
				R = H.ncp_data_1_2[21].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_22_) __ra__ncvm_atomic_cond_write_u32_31_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[22:22])) {
				R = H.ncp_data_1_2[22].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_23_) __ra__ncvm_atomic_cond_write_u32_32_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[23:23])) {
				R = H.ncp_data_1_2[23].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_24_) __ra__ncvm_atomic_cond_write_u32_33_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[24:24])) {
				R = H.ncp_data_1_2[24].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_25_) __ra__ncvm_atomic_cond_write_u32_34_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[25:25])) {
				R = H.ncp_data_1_2[25].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_26_) __ra__ncvm_atomic_cond_write_u32_35_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[26:26])) {
				R = H.ncp_data_1_2[26].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_27_) __ra__ncvm_atomic_cond_write_u32_36_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[27:27])) {
				R = H.ncp_data_1_2[27].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_28_) __ra__ncvm_atomic_cond_write_u32_37_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[28:28])) {
				R = H.ncp_data_1_2[28].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_29_) __ra__ncvm_atomic_cond_write_u32_38_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[29:29])) {
				R = H.ncp_data_1_2[29].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_30_) __ra__ncvm_atomic_cond_write_u32_39_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[30:30])) {
				R = H.ncp_data_1_2[30].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_31_) __ra__ncvm_atomic_cond_write_u32_40_0_0_lm_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[31:31])) {
				R = H.ncp_data_1_2[31].value;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_HitCounts0) __ra__ncvm_atomic_cond_write_u32_41_0_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (((bool) _lv__2_bitmap[0:0])) {
				R = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_HitCounts1) __ra__ncvm_atomic_cond_write_u32_42_0_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			if (!((bool) _lv__2_bitmap[0:0])) {
				R = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_0_) __ra__ncvm_atomic_cond_read_or_u32_43_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[0:0])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_1_) __ra__ncvm_atomic_cond_read_or_u32_44_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[1:1])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_2_) __ra__ncvm_atomic_cond_read_or_u32_45_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[2:2])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_3_) __ra__ncvm_atomic_cond_read_or_u32_46_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[3:3])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_4_) __ra__ncvm_atomic_cond_read_or_u32_47_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[4:4])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_5_) __ra__ncvm_atomic_cond_read_or_u32_48_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[5:5])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_6_) __ra__ncvm_atomic_cond_read_or_u32_49_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[6:6])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_7_) __ra__ncvm_atomic_cond_read_or_u32_50_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[7:7])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_8_) __ra__ncvm_atomic_cond_read_or_u32_51_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[8:8])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_9_) __ra__ncvm_atomic_cond_read_or_u32_52_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[9:9])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_10_) __ra__ncvm_atomic_cond_read_or_u32_53_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[10:10])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_11_) __ra__ncvm_atomic_cond_read_or_u32_54_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[11:11])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_12_) __ra__ncvm_atomic_cond_read_or_u32_55_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[12:12])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_13_) __ra__ncvm_atomic_cond_read_or_u32_56_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[13:13])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_14_) __ra__ncvm_atomic_cond_read_or_u32_57_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[14:14])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_15_) __ra__ncvm_atomic_cond_read_or_u32_58_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[15:15])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_16_) __ra__ncvm_atomic_cond_read_or_u32_59_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[16:16])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_17_) __ra__ncvm_atomic_cond_read_or_u32_60_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[17:17])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_18_) __ra__ncvm_atomic_cond_read_or_u32_61_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[18:18])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_19_) __ra__ncvm_atomic_cond_read_or_u32_62_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[19:19])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_20_) __ra__ncvm_atomic_cond_read_or_u32_63_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[20:20])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_21_) __ra__ncvm_atomic_cond_read_or_u32_64_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[21:21])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_22_) __ra__ncvm_atomic_cond_read_or_u32_65_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[22:22])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_23_) __ra__ncvm_atomic_cond_read_or_u32_66_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[23:23])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_24_) __ra__ncvm_atomic_cond_read_or_u32_67_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[24:24])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_25_) __ra__ncvm_atomic_cond_read_or_u32_68_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[25:25])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_26_) __ra__ncvm_atomic_cond_read_or_u32_69_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[26:26])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_27_) __ra__ncvm_atomic_cond_read_or_u32_70_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[27:27])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_28_) __ra__ncvm_atomic_cond_read_or_u32_71_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[28:28])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_29_) __ra__ncvm_atomic_cond_read_or_u32_72_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[29:29])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_30_) __ra__ncvm_atomic_cond_read_or_u32_73_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[30:30])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Cache_fragment_31_) __ra__ncvm_atomic_cond_read_or_u32_74_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			if (((bool) _lv__2_bitmap[31:31])) {
				O = ((bit<32>) R);
			}
			else {
				O = 0;
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_HitCounts0) __ra__ncvm_atomic_cond_sadd_u32_75_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = R;
			if (((bool) _lv__2_bitmap[0:0])) {
				R = (R |+| 1);
			}
		}
	};
	RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_HitCounts1) __ra__ncvm_atomic_cond_sadd_u32_76_1_0_le_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = R;
			if (!((bool) _lv__2_bitmap[0:0])) {
				R = (R |+| 1);
			}
		}
	};
	RegisterAction<bit<8>, bit<16>, bool>(_mem_Valid0) __ra__ncvm_atomic_cond_write_bool_77_1_1_le_0_ = {
		void apply(inout bit<8> R, out bool O){
			O = ((bool) ((bit<1>) R));
			if (((bool) _lv__2_bitmap[0:0])) {
				R = ((bit<8>) 0);
			}
		}
	};
	RegisterAction<bit<8>, bit<16>, bool>(_mem_Valid1) __ra__ncvm_atomic_cond_write_bool_78_1_1_le_0_ = {
		void apply(inout bit<8> R, out bool O){
			O = ((bool) ((bit<1>) R));
			if (!((bool) _lv__2_bitmap[0:0])) {
				R = ((bit<8>) 0);
			}
		}
	};