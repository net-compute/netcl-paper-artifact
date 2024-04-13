	@name(".ncrt.ingress.tbl.forward.reflect")
	table ncl_forward_reflect_tbl {
		key = { H.ncp.d_src : exact; }
		actions = {ncl_reflect_host; ncl_reflect_device; ncl_drop; }
		default_action = ncl_reflect_device();
		size = 256;
		const entries = {
			0 : ncl_reflect_host();
		}
	}
	@name(".ncrt.ingress.tbl.forward.host")
	table ncl_forward_host_tbl {
		key = { M.ncl_act_arg : exact; }
		actions = {ncl_forward_host; ncl_drop; }
		default_action = ncl_drop();
		size = 256;
	}
	@name(".ncrt.ingress.tbl.forward.device")
	table ncl_forward_device_tbl {
		key = { M.ncl_act_arg : exact; }
		actions = {ncl_forward_device; ncl_drop; }
		default_action = ncl_drop();
		size = 256;
	}
	@name(".ncrt.ingress.tbl.forward.multicast")
	table ncl_forward_multicast_tbl {
		key = { M.ncl_act_arg : exact; }
		actions = {ncl_multicast; ncl_drop; }
		default_action = ncl_drop();
		size = 256;
	}
	@name(".ncrt.egress.tbl.ports")
	table ncl_port_tbl {
		key = { EM.egress_port : exact; }
		actions = {host_port; device_port; drop; }
		default_action = drop();
		size = 256;
	}