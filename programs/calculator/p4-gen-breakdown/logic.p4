	apply {
		P.emit(H);
	}
	apply {
		ncvm_swi_tbl_key_0 = H.ncp_data_1_0[0].value;
		switch (ncvm_swi_tbl_0.apply().action_run) {
			ncvm_swi_tbl_0_action_2 : {
				ncvm_or_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_4 : {
				ncvm_xor_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_0 : {
				ncvm_sub_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_1[0].value, H.ncp_data_1_2[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_default : {
				ncvm_action_drop(M);
				_lv__0_ncvm_scf_pred_var_0 = 0;
			}
			ncvm_swi_tbl_0_action_3 : {
				ncvm_add_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_1 : {
				ncvm_and_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
		}
		if ((_lv__0_ncvm_scf_pred_var_0 == 0)) { }
		else {
			ncvm_action_reflect(M);
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