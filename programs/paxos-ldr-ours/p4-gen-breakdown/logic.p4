apply {
	ncvm_swi_tbl_key_0 = H.ncp_data_1_0[0].value;
	switch (ncvm_swi_tbl_0.apply().action_run) {
		ncvm_swi_tbl_0_action_default : { _lv__0_ncvm_scf_pred_var_0 = 0; }
		ncvm_swi_tbl_0_action_1 : {
			mem_rmw_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(0);
			_lv__0_ncvm_scf_pred_var_0 = 0;
		}
		ncvm_swi_tbl_0_action_0 : {
			H.ncp_data_1_0[0].value = 4;
			mem_rmw_o_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(H.ncp_data_1_1[0].value, 0);
			ncvm_action_multicast(M, 11);
			_lv__0_ncvm_scf_pred_var_0 = 1;
		}
	}
	if ((_lv__0_ncvm_scf_pred_var_0 == 1)) { }
	else {
		ncvm_action_drop(M);
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