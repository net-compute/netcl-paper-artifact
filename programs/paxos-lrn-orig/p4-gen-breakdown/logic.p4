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