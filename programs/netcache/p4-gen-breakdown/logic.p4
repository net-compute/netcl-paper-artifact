	apply {
		P.emit(H);
	}
	apply {
		_lv__0_cms_i[0] = ((_box_h<bit<32>>) {0});
		_lv__0_cms_i[1] = ((_box_h<bit<32>>) {0});
		_lv__0_cms_i[2] = ((_box_h<bit<32>>) {0});
		_lv__0_cms_i[3] = ((_box_h<bit<32>>) {0});
		_mem_lut_Index.apply();
		bool _tmp__2_call_i20 = _mem_lut_Bitmap.apply().hit;
		if (_tmp__2_call_i20) {
			ncvm_swi_tbl_key_0 = H.ncp_data_1_0[0].value;
			switch (ncvm_swi_tbl_0.apply().action_run) {
				ncvm_swi_tbl_0_action_2 : {
					if (((bool) _lv__2_bitmap[0:0]))
						_tmp__106_cond_in_in = _mem_Valid0.read(_lv__1_cacheline);
					else
						_tmp__106_cond_in_in = _mem_Valid1.read(_lv__1_cacheline);
					if ((_tmp__106_cond_in_in == 0)) { }
					else {
						mem_rmw_o_7_mem_Cache_fragment_0_(H.ncp_data_1_2[0].value, _lv__1_cacheline);
						mem_rmw_o_8_mem_Cache_fragment_1_(H.ncp_data_1_2[1].value, _lv__1_cacheline);
						mem_rmw_o_9_mem_Cache_fragment_2_(H.ncp_data_1_2[2].value, _lv__1_cacheline);
						mem_rmw_o_10_mem_Cache_fragment_3_(H.ncp_data_1_2[3].value, _lv__1_cacheline);
						mem_rmw_o_11_mem_Cache_fragment_4_(H.ncp_data_1_2[4].value, _lv__1_cacheline);
						mem_rmw_o_12_mem_Cache_fragment_5_(H.ncp_data_1_2[5].value, _lv__1_cacheline);
						mem_rmw_o_13_mem_Cache_fragment_6_(H.ncp_data_1_2[6].value, _lv__1_cacheline);
						mem_rmw_o_14_mem_Cache_fragment_7_(H.ncp_data_1_2[7].value, _lv__1_cacheline);
						mem_rmw_o_15_mem_Cache_fragment_8_(H.ncp_data_1_2[8].value, _lv__1_cacheline);
						mem_rmw_o_16_mem_Cache_fragment_9_(H.ncp_data_1_2[9].value, _lv__1_cacheline);
						mem_rmw_o_17_mem_Cache_fragment_10_(H.ncp_data_1_2[10].value, _lv__1_cacheline);
						mem_rmw_o_18_mem_Cache_fragment_11_(H.ncp_data_1_2[11].value, _lv__1_cacheline);
						mem_rmw_o_19_mem_Cache_fragment_12_(H.ncp_data_1_2[12].value, _lv__1_cacheline);
						mem_rmw_o_20_mem_Cache_fragment_13_(H.ncp_data_1_2[13].value, _lv__1_cacheline);
						mem_rmw_o_21_mem_Cache_fragment_14_(H.ncp_data_1_2[14].value, _lv__1_cacheline);
						mem_rmw_o_22_mem_Cache_fragment_15_(H.ncp_data_1_2[15].value, _lv__1_cacheline);
						mem_rmw_o_23_mem_Cache_fragment_16_(H.ncp_data_1_2[16].value, _lv__1_cacheline);
						mem_rmw_o_24_mem_Cache_fragment_17_(H.ncp_data_1_2[17].value, _lv__1_cacheline);
						mem_rmw_o_25_mem_Cache_fragment_18_(H.ncp_data_1_2[18].value, _lv__1_cacheline);
						mem_rmw_o_26_mem_Cache_fragment_19_(H.ncp_data_1_2[19].value, _lv__1_cacheline);
						mem_rmw_o_27_mem_Cache_fragment_20_(H.ncp_data_1_2[20].value, _lv__1_cacheline);
						mem_rmw_o_28_mem_Cache_fragment_21_(H.ncp_data_1_2[21].value, _lv__1_cacheline);
						mem_rmw_o_29_mem_Cache_fragment_22_(H.ncp_data_1_2[22].value, _lv__1_cacheline);
						mem_rmw_o_30_mem_Cache_fragment_23_(H.ncp_data_1_2[23].value, _lv__1_cacheline);
						mem_rmw_o_31_mem_Cache_fragment_24_(H.ncp_data_1_2[24].value, _lv__1_cacheline);
						mem_rmw_o_32_mem_Cache_fragment_25_(H.ncp_data_1_2[25].value, _lv__1_cacheline);
						mem_rmw_o_33_mem_Cache_fragment_26_(H.ncp_data_1_2[26].value, _lv__1_cacheline);
						mem_rmw_o_34_mem_Cache_fragment_27_(H.ncp_data_1_2[27].value, _lv__1_cacheline);
						mem_rmw_o_35_mem_Cache_fragment_28_(H.ncp_data_1_2[28].value, _lv__1_cacheline);
						mem_rmw_o_36_mem_Cache_fragment_29_(H.ncp_data_1_2[29].value, _lv__1_cacheline);
						mem_rmw_o_37_mem_Cache_fragment_30_(H.ncp_data_1_2[30].value, _lv__1_cacheline);
						mem_rmw_o_38_mem_Cache_fragment_31_(H.ncp_data_1_2[31].value, _lv__1_cacheline);
						mem_rmw_36_mem_HitCounts0(_lv__1_cacheline);
						mem_rmw_37_mem_HitCounts1(_lv__1_cacheline);
						H.ncp_data_1_0[0].value = 1;
						H.ncp_data_1_3[0].value = _lv__2_bitmap;
						ncvm_action_reflect(M);
					}
				}
				ncvm_swi_tbl_0_action_default : { ncvm_action_drop(M); }
				ncvm_swi_tbl_0_action_0 : {
					mem_rmw_40_mem_Valid0(_lv__1_cacheline);
					mem_rmw_41_mem_Valid1(_lv__1_cacheline);
				}
				ncvm_swi_tbl_0_action_1 : {
					mem_rmw_38_mem_Valid0(_lv__1_cacheline);
					mem_rmw_39_mem_Valid1(_lv__1_cacheline);
				}
				ncvm_swi_tbl_0_action_3 : {
					H.ncp_data_1_0[0].value = 7;
					mem_rmw_0_mem_Valid0(_lv__1_cacheline);
					mem_rmw_1_mem_Valid1(_lv__1_cacheline);
					mem_rmw_2_mem_Cache_fragment_0_(_lv__1_cacheline);
					mem_rmw_3_mem_Cache_fragment_1_(_lv__1_cacheline);
					mem_rmw_4_mem_Cache_fragment_2_(_lv__1_cacheline);
					mem_rmw_5_mem_Cache_fragment_3_(_lv__1_cacheline);
					mem_rmw_6_mem_Cache_fragment_4_(_lv__1_cacheline);
					mem_rmw_7_mem_Cache_fragment_5_(_lv__1_cacheline);
					mem_rmw_8_mem_Cache_fragment_6_(_lv__1_cacheline);
					mem_rmw_9_mem_Cache_fragment_7_(_lv__1_cacheline);
					mem_rmw_10_mem_Cache_fragment_8_(_lv__1_cacheline);
					mem_rmw_11_mem_Cache_fragment_9_(_lv__1_cacheline);
					mem_rmw_12_mem_Cache_fragment_10_(_lv__1_cacheline);
					mem_rmw_13_mem_Cache_fragment_11_(_lv__1_cacheline);
					mem_rmw_14_mem_Cache_fragment_12_(_lv__1_cacheline);
					mem_rmw_15_mem_Cache_fragment_13_(_lv__1_cacheline);
					mem_rmw_16_mem_Cache_fragment_14_(_lv__1_cacheline);
					mem_rmw_17_mem_Cache_fragment_15_(_lv__1_cacheline);
					mem_rmw_18_mem_Cache_fragment_16_(_lv__1_cacheline);
					mem_rmw_19_mem_Cache_fragment_17_(_lv__1_cacheline);
					mem_rmw_20_mem_Cache_fragment_18_(_lv__1_cacheline);
					mem_rmw_21_mem_Cache_fragment_19_(_lv__1_cacheline);
					mem_rmw_22_mem_Cache_fragment_20_(_lv__1_cacheline);
					mem_rmw_23_mem_Cache_fragment_21_(_lv__1_cacheline);
					mem_rmw_24_mem_Cache_fragment_22_(_lv__1_cacheline);
					mem_rmw_25_mem_Cache_fragment_23_(_lv__1_cacheline);
					mem_rmw_26_mem_Cache_fragment_24_(_lv__1_cacheline);
					mem_rmw_27_mem_Cache_fragment_25_(_lv__1_cacheline);
					mem_rmw_28_mem_Cache_fragment_26_(_lv__1_cacheline);
					mem_rmw_29_mem_Cache_fragment_27_(_lv__1_cacheline);
					mem_rmw_30_mem_Cache_fragment_28_(_lv__1_cacheline);
					mem_rmw_31_mem_Cache_fragment_29_(_lv__1_cacheline);
					mem_rmw_32_mem_Cache_fragment_30_(_lv__1_cacheline);
					mem_rmw_33_mem_Cache_fragment_31_(_lv__1_cacheline);
					mem_rmw_34_mem_HitCounts0(_lv__1_cacheline);
					mem_rmw_35_mem_HitCounts1(_lv__1_cacheline);
					ncvm_action_reflect(M);
				}
			}
		}
		else {
			if ((H.ncp_data_1_0[0].value == 0)) {
				mem_rmw_o_0_mem_c0(_lv__0_cms_i[0].value, ((bit<16>) _hash_0_crc16_u14.get({H.ncp_data_1_1[0].value})));
				mem_rmw_o_1_mem_c1(_lv__0_cms_i[1].value, ((bit<16>) _hash_1_crc32_u14.get({H.ncp_data_1_1[0].value})));
				mem_rmw_o_2_mem_c2(_lv__0_cms_i[2].value, ((bit<16>) _hash_2_crc64_u14.get({H.ncp_data_1_1[0].value})));
				mem_rmw_o_3_mem_c3(call_i50_i, ((bit<16>) _hash_3_xor16_u14.get({H.ncp_data_1_1[0].value})));
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
					H.ncp_data_1_5[0].value = _lv__5_spec_select73_i_3;
					mem_rmw_o_4_mem_b0(call_i47_i, ((bit<16>) _hash_4_xor32_u15.get({H.ncp_data_1_1[0].value})));
					mem_rmw_o_5_mem_b1(call_i43_i, ((bit<16>) _hash_5_crc32_u15.get({H.ncp_data_1_1[0].value})));
					mem_rmw_o_6_mem_b2(call_i_i42, ((bit<16>) _hash_6_crc64_u15.get({H.ncp_data_1_1[0].value})));
					if (call_i47_i)
						_lv__6__2 = ((bit<1>) call_i43_i);
					else
						_lv__6__2 = 0;
					if (((bool) _lv__6__2))
						_lv__7_spec_select74_i = ((bit<1>) call_i_i42);
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