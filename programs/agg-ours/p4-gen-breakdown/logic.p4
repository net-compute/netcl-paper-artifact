apply {
	if ((H.ncp_data_1_0[0].value == 0)) {
		mem_rmw_o_1_mem_Bitmap_fragment_0_(_lv__0_bitmap_0_reg2mem, H.ncp_data_1_1[0].value);
		mem_rmw_1_mem_Bitmap_fragment_1_(H.ncp_data_1_1[0].value);
	}
	else {
		mem_rmw_0_mem_Bitmap_fragment_0_(H.ncp_data_1_1[0].value);
		mem_rmw_o_0_mem_Bitmap_fragment_1_(_lv__0_bitmap_0_reg2mem, H.ncp_data_1_1[0].value);
	}
	if ((_lv__0_bitmap_0_reg2mem == 0)) {
		mem_rmw_2_mem_Expo(H.ncp_data_1_2[0].value);
		mem_rmw_3_mem_Agg_fragment_0_(H.ncp_data_1_2[0].value);
		mem_rmw_4_mem_Agg_fragment_1_(H.ncp_data_1_2[0].value);
		mem_rmw_5_mem_Agg_fragment_2_(H.ncp_data_1_2[0].value);
		mem_rmw_6_mem_Agg_fragment_3_(H.ncp_data_1_2[0].value);
		mem_rmw_7_mem_Agg_fragment_4_(H.ncp_data_1_2[0].value);
		mem_rmw_8_mem_Agg_fragment_5_(H.ncp_data_1_2[0].value);
		mem_rmw_9_mem_Agg_fragment_6_(H.ncp_data_1_2[0].value);
		mem_rmw_10_mem_Agg_fragment_7_(H.ncp_data_1_2[0].value);
		mem_rmw_11_mem_Agg_fragment_8_(H.ncp_data_1_2[0].value);
		mem_rmw_12_mem_Agg_fragment_9_(H.ncp_data_1_2[0].value);
		mem_rmw_13_mem_Agg_fragment_10_(H.ncp_data_1_2[0].value);
		mem_rmw_14_mem_Agg_fragment_11_(H.ncp_data_1_2[0].value);
		mem_rmw_15_mem_Agg_fragment_12_(H.ncp_data_1_2[0].value);
		mem_rmw_16_mem_Agg_fragment_13_(H.ncp_data_1_2[0].value);
		mem_rmw_17_mem_Agg_fragment_14_(H.ncp_data_1_2[0].value);
		mem_rmw_18_mem_Agg_fragment_15_(H.ncp_data_1_2[0].value);
		mem_rmw_19_mem_Agg_fragment_16_(H.ncp_data_1_2[0].value);
		mem_rmw_20_mem_Agg_fragment_17_(H.ncp_data_1_2[0].value);
		mem_rmw_21_mem_Agg_fragment_18_(H.ncp_data_1_2[0].value);
		mem_rmw_22_mem_Agg_fragment_19_(H.ncp_data_1_2[0].value);
		mem_rmw_23_mem_Agg_fragment_20_(H.ncp_data_1_2[0].value);
		mem_rmw_24_mem_Agg_fragment_21_(H.ncp_data_1_2[0].value);
		mem_rmw_25_mem_Agg_fragment_22_(H.ncp_data_1_2[0].value);
		mem_rmw_26_mem_Agg_fragment_23_(H.ncp_data_1_2[0].value);
		mem_rmw_27_mem_Agg_fragment_24_(H.ncp_data_1_2[0].value);
		mem_rmw_28_mem_Agg_fragment_25_(H.ncp_data_1_2[0].value);
		mem_rmw_29_mem_Agg_fragment_26_(H.ncp_data_1_2[0].value);
		mem_rmw_30_mem_Agg_fragment_27_(H.ncp_data_1_2[0].value);
		mem_rmw_31_mem_Agg_fragment_28_(H.ncp_data_1_2[0].value);
		mem_rmw_32_mem_Agg_fragment_29_(H.ncp_data_1_2[0].value);
		mem_rmw_33_mem_Agg_fragment_30_(H.ncp_data_1_2[0].value);
		mem_rmw_34_mem_Agg_fragment_31_(H.ncp_data_1_2[0].value);
		mem_rmw_35_mem_Count(H.ncp_data_1_2[0].value);
	}
	else {
		ncvm_and_32_32_32(_tmp__8_and, _lv__0_bitmap_0_reg2mem, H.ncp_data_1_3[0].value);
		mem_rmw_o_2_mem_Expo(H.ncp_data_1_5[0].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_3_mem_Agg_fragment_0_(H.ncp_data_1_6[0].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_4_mem_Agg_fragment_1_(H.ncp_data_1_6[1].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_5_mem_Agg_fragment_2_(H.ncp_data_1_6[2].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_6_mem_Agg_fragment_3_(H.ncp_data_1_6[3].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_7_mem_Agg_fragment_4_(H.ncp_data_1_6[4].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_8_mem_Agg_fragment_5_(H.ncp_data_1_6[5].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_9_mem_Agg_fragment_6_(H.ncp_data_1_6[6].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_10_mem_Agg_fragment_7_(H.ncp_data_1_6[7].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_11_mem_Agg_fragment_8_(H.ncp_data_1_6[8].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_12_mem_Agg_fragment_9_(H.ncp_data_1_6[9].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_13_mem_Agg_fragment_10_(H.ncp_data_1_6[10].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_14_mem_Agg_fragment_11_(H.ncp_data_1_6[11].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_15_mem_Agg_fragment_12_(H.ncp_data_1_6[12].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_16_mem_Agg_fragment_13_(H.ncp_data_1_6[13].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_17_mem_Agg_fragment_14_(H.ncp_data_1_6[14].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_18_mem_Agg_fragment_15_(H.ncp_data_1_6[15].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_19_mem_Agg_fragment_16_(H.ncp_data_1_6[16].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_20_mem_Agg_fragment_17_(H.ncp_data_1_6[17].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_21_mem_Agg_fragment_18_(H.ncp_data_1_6[18].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_22_mem_Agg_fragment_19_(H.ncp_data_1_6[19].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_23_mem_Agg_fragment_20_(H.ncp_data_1_6[20].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_24_mem_Agg_fragment_21_(H.ncp_data_1_6[21].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_25_mem_Agg_fragment_22_(H.ncp_data_1_6[22].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_26_mem_Agg_fragment_23_(H.ncp_data_1_6[23].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_27_mem_Agg_fragment_24_(H.ncp_data_1_6[24].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_28_mem_Agg_fragment_25_(H.ncp_data_1_6[25].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_29_mem_Agg_fragment_26_(H.ncp_data_1_6[26].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_30_mem_Agg_fragment_27_(H.ncp_data_1_6[27].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_31_mem_Agg_fragment_28_(H.ncp_data_1_6[28].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_32_mem_Agg_fragment_29_(H.ncp_data_1_6[29].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_33_mem_Agg_fragment_30_(H.ncp_data_1_6[30].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_34_mem_Agg_fragment_31_(H.ncp_data_1_6[31].value, H.ncp_data_1_2[0].value);
		mem_rmw_o_35_mem_Count(call_i61, H.ncp_data_1_2[0].value);
		ncvm_swi_tbl_key_0 = call_i61;
		switch (ncvm_swi_tbl_0.apply().action_run) {
			ncvm_swi_tbl_0_action_0 : { ncvm_action_reflect(M); }
			ncvm_swi_tbl_0_action_1 : { ncvm_action_multicast(M, 42); }
			ncvm_swi_tbl_0_action_default : { }
		}
	}
	return;
}
apply {
	if ((M.ncl_act == _ncl_action_multicast_)) {
		ncl_forward_multicast_tbl.apply();
	}
	else
		if ((M.ncl_act == _ncl_action_repeat_)) {
			ncl_repeat();
		}
		else
			if ((M.ncl_act == _ncl_action_reflect_)) {
				ncl_forward_reflect_tbl.apply();
			}
			else
				if ((M.ncl_act == _ncl_action_send_to_device_)) {
					ncl_forward_device_tbl.apply();
				}
				else {
					ncl_forward_host_tbl.apply();
				}
}
apply {
	if ((H.arp_ip4.isValid() && (H.arp.opcode == ARP_REQ)))
		arp_table.apply();
	forwarding_table.apply();
}
apply {
	if (H.ncp.isValid()) {
		M.ncl_act_arg = ((bit<16>) H.ncp.h_dst);
		if (!M.ncl_no_op) {
			ncvm_action_default(H, M);
			ncl_compute.apply(H, M, IM);
		}
		ncl_network.apply(H, M, IM, DIM, TIM);
	}
	else {
		net.apply(H, M, IM, DIM, TIM);
	}
}
apply {
	if (H.ncp.isValid()) {
		if ((H.ncp.act == _ncl_action_repeat_)) { }
		else {
			ncl_port_tbl.apply();
			ncl_udp_adj_tbl.apply();
			if ((((H.ncp.act == _ncl_action_multicast_) || (H.ncp.act == _ncl_action_multicast_long_)) || (H.ip4.src_addr == H.ip4.dst_addr)))
				ncl_use_implicit_ip4_src_addr(H);
		}
	}
}