	apply {
		P.emit(H);
	}
	apply {
		if ((H.ncp_data_1_1[0].value == 0)) {
			mem_rmw_o_1_mem_Bitmap_fragment_0_(_lv__0_bitmap_0_reg2mem, ((bit<8>) H.ncp_data_1_2[0].value));
			mem_rmw_1_mem_Bitmap_fragment_1_(((bit<8>) H.ncp_data_1_2[0].value));
		}
		else {
			mem_rmw_0_mem_Bitmap_fragment_0_(((bit<8>) H.ncp_data_1_2[0].value));
			mem_rmw_o_0_mem_Bitmap_fragment_1_(_lv__0_bitmap_0_reg2mem, ((bit<8>) H.ncp_data_1_2[0].value));
		}
		if ((_lv__0_bitmap_0_reg2mem == 0)) {
			mem_rmw_2_mem_Count(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_3_mem_Expo(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_4_mem_Agg_fragment_0_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_5_mem_Agg_fragment_1_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_6_mem_Agg_fragment_2_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_7_mem_Agg_fragment_3_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_8_mem_Agg_fragment_4_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_9_mem_Agg_fragment_5_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_10_mem_Agg_fragment_6_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_11_mem_Agg_fragment_7_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_12_mem_Agg_fragment_8_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_13_mem_Agg_fragment_9_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_14_mem_Agg_fragment_10_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_15_mem_Agg_fragment_11_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_16_mem_Agg_fragment_12_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_17_mem_Agg_fragment_13_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_18_mem_Agg_fragment_14_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_19_mem_Agg_fragment_15_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_20_mem_Agg_fragment_16_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_21_mem_Agg_fragment_17_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_22_mem_Agg_fragment_18_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_23_mem_Agg_fragment_19_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_24_mem_Agg_fragment_20_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_25_mem_Agg_fragment_21_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_26_mem_Agg_fragment_22_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_27_mem_Agg_fragment_23_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_28_mem_Agg_fragment_24_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_29_mem_Agg_fragment_25_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_30_mem_Agg_fragment_26_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_31_mem_Agg_fragment_27_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_32_mem_Agg_fragment_28_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_33_mem_Agg_fragment_29_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_34_mem_Agg_fragment_30_(((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_35_mem_Agg_fragment_31_(((bit<8>) H.ncp_data_1_3[0].value));
		}
		else {
			ncvm_and_16_16_16(_tmp__8_and92, _lv__0_bitmap_0_reg2mem, H.ncp_data_1_4[0].value);
			mem_rmw_o_2_mem_Expo(H.ncp_data_1_5[0].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_3_mem_Agg_fragment_0_(H.ncp_data_1_6[0].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_4_mem_Agg_fragment_1_(H.ncp_data_1_6[1].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_5_mem_Agg_fragment_2_(H.ncp_data_1_6[2].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_6_mem_Agg_fragment_3_(H.ncp_data_1_6[3].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_7_mem_Agg_fragment_4_(H.ncp_data_1_6[4].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_8_mem_Agg_fragment_5_(H.ncp_data_1_6[5].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_9_mem_Agg_fragment_6_(H.ncp_data_1_6[6].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_10_mem_Agg_fragment_7_(H.ncp_data_1_6[7].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_11_mem_Agg_fragment_8_(H.ncp_data_1_6[8].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_12_mem_Agg_fragment_9_(H.ncp_data_1_6[9].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_13_mem_Agg_fragment_10_(H.ncp_data_1_6[10].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_14_mem_Agg_fragment_11_(H.ncp_data_1_6[11].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_15_mem_Agg_fragment_12_(H.ncp_data_1_6[12].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_16_mem_Agg_fragment_13_(H.ncp_data_1_6[13].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_17_mem_Agg_fragment_14_(H.ncp_data_1_6[14].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_18_mem_Agg_fragment_15_(H.ncp_data_1_6[15].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_19_mem_Agg_fragment_16_(H.ncp_data_1_6[16].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_20_mem_Agg_fragment_17_(H.ncp_data_1_6[17].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_21_mem_Agg_fragment_18_(H.ncp_data_1_6[18].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_22_mem_Agg_fragment_19_(H.ncp_data_1_6[19].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_23_mem_Agg_fragment_20_(H.ncp_data_1_6[20].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_24_mem_Agg_fragment_21_(H.ncp_data_1_6[21].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_25_mem_Agg_fragment_22_(H.ncp_data_1_6[22].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_26_mem_Agg_fragment_23_(H.ncp_data_1_6[23].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_27_mem_Agg_fragment_24_(H.ncp_data_1_6[24].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_28_mem_Agg_fragment_25_(H.ncp_data_1_6[25].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_29_mem_Agg_fragment_26_(H.ncp_data_1_6[26].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_30_mem_Agg_fragment_27_(H.ncp_data_1_6[27].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_31_mem_Agg_fragment_28_(H.ncp_data_1_6[28].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_32_mem_Agg_fragment_29_(H.ncp_data_1_6[29].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_33_mem_Agg_fragment_30_(H.ncp_data_1_6[30].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_34_mem_Agg_fragment_31_(H.ncp_data_1_6[31].value, ((bit<8>) H.ncp_data_1_3[0].value));
			mem_rmw_o_35_mem_Count(call_i73, ((bit<8>) H.ncp_data_1_3[0].value));
			ncvm_or_16_16_16(_tmp__45_or93, _lv__0_bitmap_0_reg2mem, H.ncp_data_1_4[0].value);
			if ((call_i73 == 0)) {
				ncvm_action_reflect(M);
			}
			else {
				if ((_tmp__45_or93 == 3)) {
					ncvm_action_multicast(M, 42);
				}
				else { }
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
		if (H.ncp.isValid()) {
			if (!M.ncl_no_op) {
				M.ncl_act = _ncl_default_action_;
				M.ncl_act_arg = _ncl_default_action_arg_;
				ncl_compute.apply(H, M, IM);
			}
			ncl_network.apply(H, M, IM, IDM, ITM);
		}
	}
	apply {
		H.ip4.checksum = ip4_checksum.update({H.ip4.version,H.ip4.ihl,H.ip4.tos,H.ip4.total_len,H.ip4.identification,H.ip4.flags,H.ip4.frag_offset,H.ip4.ttl,H.ip4.protocol,H.ip4.src_addr,H.ip4.dst_addr});
		P.emit(H.eth);
		P.emit(H.ip4);
		P.emit(H.udp);
		P.emit(H.ncp);
	}
	apply {
		if (H.ncp.isValid()) {
			if ((H.ncp.act == _ncl_action_repeat_)) { }
			else {
				ncl_port_tbl.apply();
				if ((((H.ncp.act == _ncl_action_multicast_) || (H.ncp.act == _ncl_action_multicast_long_)) || (H.ip4.src_addr == H.ip4.dst_addr)))
					ncl_use_implicit_ip4_src_addr(H);
			}
		}
	}