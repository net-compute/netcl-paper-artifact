table ncvm_swi_tbl_0 {
	key = { ncvm_swi_tbl_key_0 : exact; }
	actions = {ncvm_swi_tbl_0_action_0; ncvm_swi_tbl_0_action_1; ncvm_swi_tbl_0_action_2; ncvm_swi_tbl_0_action_3; ncvm_swi_tbl_0_action_default; }
	const default_action = ncvm_swi_tbl_0_action_default();
	const size = 4;
	const entries = {
		7 : ncvm_swi_tbl_0_action_0;
		1 : ncvm_swi_tbl_0_action_1;
		3 : ncvm_swi_tbl_0_action_2;
		5 : ncvm_swi_tbl_0_action_3;
	}
}
table _mem_lut_Bitmap {
	key = { H.ncp_data_1_0[0].value : exact; }
	actions = {_mem_lut_Bitmap_Read; NoAction; }
	const default_action = NoAction();
	const size = 8192;
}
table _mem_lut_Index {
	key = { H.ncp_data_1_0[0].value : exact; }
	actions = {_mem_lut_Index_Read; NoAction; }
	const default_action = NoAction();
	const size = 4096;
}
table ncl_forward_reflect_tbl {
	key = { H.ncp.d_src : exact; }
	actions = {ncl_reflect_host; ncl_reflect_device; ncl_drop; }
	default_action = ncl_reflect_device();
	size = 256;
	const entries = {
		0 : ncl_reflect_host();
	}
}
table ncl_forward_host_tbl {
	key = { M.ncl_act_arg : exact; }
	actions = {ncl_forward_host; ncl_drop; }
	default_action = ncl_drop();
	size = 256;
}
table ncl_forward_device_tbl {
	key = { M.ncl_act_arg : exact; }
	actions = {ncl_forward_device; ncl_drop; }
	default_action = ncl_drop();
	size = 256;
}
table ncl_forward_multicast_tbl {
	key = { M.ncl_act_arg : exact; }
	actions = {ncl_multicast; ncl_drop; }
	default_action = ncl_drop();
	size = 256;
}
table forwarding_table {
	key = { H.eth.dst_addr : exact; }
	actions = {forward; multicast; drop; NoAction; }
	default_action = NoAction;
	size = 1024;
}
table arp_table {
	key = { H.arp_ip4.dst_proto_addr : exact; }
	actions = {multicast; arp_resolve; NoAction; }
	default_action = NoAction;
	size = 1024;
}
table ncl_port_tbl {
	key = { EM.egress_port : exact; }
	actions = {host_port; device_port; drop; }
	default_action = drop();
	size = 256;
}
table ncl_udp_adj_tbl {
	key = {
		H.ncp.cid: exact;
		H.ncp.act: exact;
		H.ncp.h_dst: exact;
	}
	actions = {udp_ports_swap; udp_ports_mod; udp_ports_are_ncl_and; udp_ports_are_dst_and; NoAction; }
	default_action = NoAction();
	size = 512;
}