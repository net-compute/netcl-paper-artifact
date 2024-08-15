table ncvm_swi_tbl_0 {
	key = { ncvm_swi_tbl_key_0 : exact; }
	actions = {ncvm_swi_tbl_0_action_0; ncvm_swi_tbl_0_action_1; ncvm_swi_tbl_0_action_default; }
	const default_action = ncvm_swi_tbl_0_action_default();
	const size = 2;
	const entries = {
		16 : ncvm_swi_tbl_0_action_0;
		32 : ncvm_swi_tbl_0_action_1;
	}
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