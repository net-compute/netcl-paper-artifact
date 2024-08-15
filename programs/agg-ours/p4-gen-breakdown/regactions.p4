RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Bitmap_fragment_0_) __ra__ncvm_atomic_and_u32_0_0_0_l_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		R = (R & ~H.ncp_data_1_3[0].value);
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Bitmap_fragment_1_) __ra__ncvm_atomic_or_u32_1_0_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		R = (R | H.ncp_data_1_3[0].value);
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Bitmap_fragment_0_) __ra__ncvm_atomic_or_u32_2_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		R = (R | H.ncp_data_1_3[0].value);
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Bitmap_fragment_1_) __ra__ncvm_atomic_and_u32_3_1_0_l_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		R = (R & ~H.ncp_data_1_3[0].value);
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Expo) __ra__ncvm_atomic_cond_max_new_u32_4_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = max(R, H.ncp_data_1_5[0].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_0_) __ra__ncvm_atomic_cond_add_new_u32_5_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[0].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_1_) __ra__ncvm_atomic_cond_add_new_u32_6_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[1].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_2_) __ra__ncvm_atomic_cond_add_new_u32_7_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[2].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_3_) __ra__ncvm_atomic_cond_add_new_u32_8_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[3].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_4_) __ra__ncvm_atomic_cond_add_new_u32_9_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[4].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_5_) __ra__ncvm_atomic_cond_add_new_u32_10_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[5].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_6_) __ra__ncvm_atomic_cond_add_new_u32_11_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[6].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_7_) __ra__ncvm_atomic_cond_add_new_u32_12_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[7].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_8_) __ra__ncvm_atomic_cond_add_new_u32_13_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[8].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_9_) __ra__ncvm_atomic_cond_add_new_u32_14_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[9].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_10_) __ra__ncvm_atomic_cond_add_new_u32_15_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[10].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_11_) __ra__ncvm_atomic_cond_add_new_u32_16_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[11].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_12_) __ra__ncvm_atomic_cond_add_new_u32_17_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[12].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_13_) __ra__ncvm_atomic_cond_add_new_u32_18_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[13].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_14_) __ra__ncvm_atomic_cond_add_new_u32_19_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[14].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_15_) __ra__ncvm_atomic_cond_add_new_u32_20_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[15].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_16_) __ra__ncvm_atomic_cond_add_new_u32_21_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[16].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_17_) __ra__ncvm_atomic_cond_add_new_u32_22_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[17].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_18_) __ra__ncvm_atomic_cond_add_new_u32_23_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[18].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_19_) __ra__ncvm_atomic_cond_add_new_u32_24_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[19].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_20_) __ra__ncvm_atomic_cond_add_new_u32_25_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[20].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_21_) __ra__ncvm_atomic_cond_add_new_u32_26_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[21].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_22_) __ra__ncvm_atomic_cond_add_new_u32_27_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[22].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_23_) __ra__ncvm_atomic_cond_add_new_u32_28_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[23].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_24_) __ra__ncvm_atomic_cond_add_new_u32_29_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[24].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_25_) __ra__ncvm_atomic_cond_add_new_u32_30_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[25].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_26_) __ra__ncvm_atomic_cond_add_new_u32_31_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[26].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_27_) __ra__ncvm_atomic_cond_add_new_u32_32_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[27].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_28_) __ra__ncvm_atomic_cond_add_new_u32_33_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[28].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_29_) __ra__ncvm_atomic_cond_add_new_u32_34_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[29].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_30_) __ra__ncvm_atomic_cond_add_new_u32_35_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[30].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_31_) __ra__ncvm_atomic_cond_add_new_u32_36_0_0_lm_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		if ((_tmp__8_and == 0)) {
			R = (R + H.ncp_data_1_6[31].value);
		}
		O = R;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Count) __ra__ncvm_atomic_cond_dec_u32_37_0_0_l_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		if ((_tmp__8_and == 0)) {
			R = (R - 1);
		}
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Expo) __ra__ncvm_atomic_write_u32_38_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_5[0].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_0_) __ra__ncvm_atomic_write_u32_39_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[0].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_1_) __ra__ncvm_atomic_write_u32_40_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[1].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_2_) __ra__ncvm_atomic_write_u32_41_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[2].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_3_) __ra__ncvm_atomic_write_u32_42_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[3].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_4_) __ra__ncvm_atomic_write_u32_43_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[4].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_5_) __ra__ncvm_atomic_write_u32_44_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[5].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_6_) __ra__ncvm_atomic_write_u32_45_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[6].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_7_) __ra__ncvm_atomic_write_u32_46_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[7].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_8_) __ra__ncvm_atomic_write_u32_47_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[8].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_9_) __ra__ncvm_atomic_write_u32_48_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[9].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_10_) __ra__ncvm_atomic_write_u32_49_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[10].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_11_) __ra__ncvm_atomic_write_u32_50_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[11].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_12_) __ra__ncvm_atomic_write_u32_51_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[12].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_13_) __ra__ncvm_atomic_write_u32_52_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[13].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_14_) __ra__ncvm_atomic_write_u32_53_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[14].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_15_) __ra__ncvm_atomic_write_u32_54_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[15].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_16_) __ra__ncvm_atomic_write_u32_55_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[16].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_17_) __ra__ncvm_atomic_write_u32_56_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[17].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_18_) __ra__ncvm_atomic_write_u32_57_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[18].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_19_) __ra__ncvm_atomic_write_u32_58_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[19].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_20_) __ra__ncvm_atomic_write_u32_59_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[20].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_21_) __ra__ncvm_atomic_write_u32_60_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[21].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_22_) __ra__ncvm_atomic_write_u32_61_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[22].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_23_) __ra__ncvm_atomic_write_u32_62_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[23].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_24_) __ra__ncvm_atomic_write_u32_63_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[24].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_25_) __ra__ncvm_atomic_write_u32_64_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[25].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_26_) __ra__ncvm_atomic_write_u32_65_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[26].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_27_) __ra__ncvm_atomic_write_u32_66_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[27].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_28_) __ra__ncvm_atomic_write_u32_67_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[28].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_29_) __ra__ncvm_atomic_write_u32_68_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[29].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_30_) __ra__ncvm_atomic_write_u32_69_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[30].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Agg_fragment_31_) __ra__ncvm_atomic_write_u32_70_1_0_m_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = H.ncp_data_1_6[31].value;
	}
};
RegisterAction<bit<32>, bit<16>, bit<32>>(_mem_Count) __ra__ncvm_atomic_write_u32_71_1_0_e_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = 3;
	}
};