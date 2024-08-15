table ncvm_swi_tbl_0 {
	key = { ncvm_swi_tbl_key_0 : exact; }
	actions = {ncvm_swi_tbl_0_action_0; ncvm_swi_tbl_0_action_1; ncvm_swi_tbl_0_action_2; ncvm_swi_tbl_0_action_3; ncvm_swi_tbl_0_action_4; ncvm_swi_tbl_0_action_default; }
	const default_action = ncvm_swi_tbl_0_action_default();
	const size = 5;
	const entries = {
		1 : ncvm_swi_tbl_0_action_0;
		2 : ncvm_swi_tbl_0_action_1;
		3 : ncvm_swi_tbl_0_action_2;
		0 : ncvm_swi_tbl_0_action_3;
		4 : ncvm_swi_tbl_0_action_4;
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
table ncl_port_tbl {
	key = { EM.egress_port : exact; }
	actions = {host_port; device_port; drop; }
	default_action = drop();
	size = 256;
}