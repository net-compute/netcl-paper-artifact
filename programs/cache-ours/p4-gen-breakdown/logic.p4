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