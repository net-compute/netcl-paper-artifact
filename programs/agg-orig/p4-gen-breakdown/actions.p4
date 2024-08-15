action ncl_lookup_read_u8(out bit<8> val,  bit<8> value) {val = value; }
action ncl_lookup_read_u16(out bit<16> val,  bit<16> value) {val = value; }
action ncl_lookup_read_u32(out bit<32> val,  bit<32> value) {val = value; }
action ncl_lookup_read_u64(out bit<64> val,  bit<64> value) {val = value; }
action ncl_lookup_read_none() { }
action ncvm_action_default(in headers H, inout metadata M) {if ((_ncl_default_action_ == _ncl_action_pass_)) {
	M.ncl_act = _ncl_action_send_to_host_;
}
else {
	M.ncl_act = _ncl_action_drop_;
}
}
action ncvm_action_drop(inout metadata M) {
	M.ncl_act = _ncl_action_drop_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
action ncvm_action_pass(inout metadata M) {
	M.ncl_act = _ncl_action_pass_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
action ncvm_action_send_to_host(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_send_to_host_;
	M.ncl_act_arg = ID;
}
action ncvm_action_send_to_device(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_send_to_device_;
	M.ncl_act_arg = ID;
}
action ncvm_action_reflect(inout metadata M) {
	M.ncl_act = _ncl_action_reflect_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
action ncvm_action_reflect_long(inout metadata M) {
	M.ncl_act = _ncl_action_reflect_long_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
action ncvm_action_multicast(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_multicast_;
	M.ncl_act_arg = ID;
}
action ncvm_action_repeat(inout metadata M) {
	M.ncl_act = _ncl_action_repeat_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
action ncvm_swi_tbl_0_action_0() { }
action ncvm_swi_tbl_0_action_1() { }
action ncvm_swi_tbl_0_action_default() { }
action mem_rmw_0_mem_Bitmap_fragment_0_(in bit<16> i) {	__ra__ncvm_atomic_and_u32_0_0_0_l_0_.execute(i); }
action mem_rmw_10_mem_Agg_fragment_7_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_46_1_0_m_0_.execute(i); }
action mem_rmw_11_mem_Agg_fragment_8_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_47_1_0_m_0_.execute(i); }
action mem_rmw_12_mem_Agg_fragment_9_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_48_1_0_m_0_.execute(i); }
action mem_rmw_13_mem_Agg_fragment_10_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_49_1_0_m_0_.execute(i); }
action mem_rmw_14_mem_Agg_fragment_11_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_50_1_0_m_0_.execute(i); }
action mem_rmw_15_mem_Agg_fragment_12_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_51_1_0_m_0_.execute(i); }
action mem_rmw_16_mem_Agg_fragment_13_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_52_1_0_m_0_.execute(i); }
action mem_rmw_17_mem_Agg_fragment_14_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_53_1_0_m_0_.execute(i); }
action mem_rmw_18_mem_Agg_fragment_15_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_54_1_0_m_0_.execute(i); }
action mem_rmw_19_mem_Agg_fragment_16_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_55_1_0_m_0_.execute(i); }
action mem_rmw_1_mem_Bitmap_fragment_1_(in bit<16> i) {	__ra__ncvm_atomic_and_u32_3_1_0_l_0_.execute(i); }
action mem_rmw_20_mem_Agg_fragment_17_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_56_1_0_m_0_.execute(i); }
action mem_rmw_21_mem_Agg_fragment_18_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_57_1_0_m_0_.execute(i); }
action mem_rmw_22_mem_Agg_fragment_19_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_58_1_0_m_0_.execute(i); }
action mem_rmw_23_mem_Agg_fragment_20_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_59_1_0_m_0_.execute(i); }
action mem_rmw_24_mem_Agg_fragment_21_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_60_1_0_m_0_.execute(i); }
action mem_rmw_25_mem_Agg_fragment_22_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_61_1_0_m_0_.execute(i); }
action mem_rmw_26_mem_Agg_fragment_23_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_62_1_0_m_0_.execute(i); }
action mem_rmw_27_mem_Agg_fragment_24_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_63_1_0_m_0_.execute(i); }
action mem_rmw_28_mem_Agg_fragment_25_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_64_1_0_m_0_.execute(i); }
action mem_rmw_29_mem_Agg_fragment_26_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_65_1_0_m_0_.execute(i); }
action mem_rmw_2_mem_Expo(in bit<16> i) {	__ra__ncvm_atomic_write_u32_38_1_0_m_0_.execute(i); }
action mem_rmw_30_mem_Agg_fragment_27_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_66_1_0_m_0_.execute(i); }
action mem_rmw_31_mem_Agg_fragment_28_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_67_1_0_m_0_.execute(i); }
action mem_rmw_32_mem_Agg_fragment_29_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_68_1_0_m_0_.execute(i); }
action mem_rmw_33_mem_Agg_fragment_30_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_69_1_0_m_0_.execute(i); }
action mem_rmw_34_mem_Agg_fragment_31_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_70_1_0_m_0_.execute(i); }
action mem_rmw_35_mem_Count(in bit<16> i) {	__ra__ncvm_atomic_write_u32_71_1_0_e_0_.execute(i); }
action mem_rmw_3_mem_Agg_fragment_0_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_39_1_0_m_0_.execute(i); }
action mem_rmw_4_mem_Agg_fragment_1_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_40_1_0_m_0_.execute(i); }
action mem_rmw_5_mem_Agg_fragment_2_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_41_1_0_m_0_.execute(i); }
action mem_rmw_6_mem_Agg_fragment_3_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_42_1_0_m_0_.execute(i); }
action mem_rmw_7_mem_Agg_fragment_4_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_43_1_0_m_0_.execute(i); }
action mem_rmw_8_mem_Agg_fragment_5_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_44_1_0_m_0_.execute(i); }
action mem_rmw_9_mem_Agg_fragment_6_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_45_1_0_m_0_.execute(i); }
action mem_rmw_o_0_mem_Bitmap_fragment_1_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_or_u32_1_0_0_m_0_.execute(i); }
action mem_rmw_o_10_mem_Agg_fragment_7_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_12_0_0_lm_0_.execute(i); }
action mem_rmw_o_11_mem_Agg_fragment_8_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_13_0_0_lm_0_.execute(i); }
action mem_rmw_o_12_mem_Agg_fragment_9_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_14_0_0_lm_0_.execute(i); }
action mem_rmw_o_13_mem_Agg_fragment_10_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_15_0_0_lm_0_.execute(i); }
action mem_rmw_o_14_mem_Agg_fragment_11_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_16_0_0_lm_0_.execute(i); }
action mem_rmw_o_15_mem_Agg_fragment_12_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_17_0_0_lm_0_.execute(i); }
action mem_rmw_o_16_mem_Agg_fragment_13_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_18_0_0_lm_0_.execute(i); }
action mem_rmw_o_17_mem_Agg_fragment_14_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_19_0_0_lm_0_.execute(i); }
action mem_rmw_o_18_mem_Agg_fragment_15_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_20_0_0_lm_0_.execute(i); }
action mem_rmw_o_19_mem_Agg_fragment_16_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_21_0_0_lm_0_.execute(i); }
action mem_rmw_o_1_mem_Bitmap_fragment_0_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_or_u32_2_1_0_m_0_.execute(i); }
action mem_rmw_o_20_mem_Agg_fragment_17_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_22_0_0_lm_0_.execute(i); }
action mem_rmw_o_21_mem_Agg_fragment_18_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_23_0_0_lm_0_.execute(i); }
action mem_rmw_o_22_mem_Agg_fragment_19_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_24_0_0_lm_0_.execute(i); }
action mem_rmw_o_23_mem_Agg_fragment_20_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_25_0_0_lm_0_.execute(i); }
action mem_rmw_o_24_mem_Agg_fragment_21_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_26_0_0_lm_0_.execute(i); }
action mem_rmw_o_25_mem_Agg_fragment_22_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_27_0_0_lm_0_.execute(i); }
action mem_rmw_o_26_mem_Agg_fragment_23_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_28_0_0_lm_0_.execute(i); }
action mem_rmw_o_27_mem_Agg_fragment_24_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_29_0_0_lm_0_.execute(i); }
action mem_rmw_o_28_mem_Agg_fragment_25_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_30_0_0_lm_0_.execute(i); }
action mem_rmw_o_29_mem_Agg_fragment_26_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_31_0_0_lm_0_.execute(i); }
action mem_rmw_o_2_mem_Expo(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_max_new_u32_4_0_0_lm_0_.execute(i); }
action mem_rmw_o_30_mem_Agg_fragment_27_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_32_0_0_lm_0_.execute(i); }
action mem_rmw_o_31_mem_Agg_fragment_28_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_33_0_0_lm_0_.execute(i); }
action mem_rmw_o_32_mem_Agg_fragment_29_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_34_0_0_lm_0_.execute(i); }
action mem_rmw_o_33_mem_Agg_fragment_30_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_35_0_0_lm_0_.execute(i); }
action mem_rmw_o_34_mem_Agg_fragment_31_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_36_0_0_lm_0_.execute(i); }
action mem_rmw_o_35_mem_Count(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_dec_u32_37_0_0_l_0_.execute(i); }
action mem_rmw_o_3_mem_Agg_fragment_0_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_5_0_0_lm_0_.execute(i); }
action mem_rmw_o_4_mem_Agg_fragment_1_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_6_0_0_lm_0_.execute(i); }
action mem_rmw_o_5_mem_Agg_fragment_2_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_7_0_0_lm_0_.execute(i); }
action mem_rmw_o_6_mem_Agg_fragment_3_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_8_0_0_lm_0_.execute(i); }
action mem_rmw_o_7_mem_Agg_fragment_4_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_9_0_0_lm_0_.execute(i); }
action mem_rmw_o_8_mem_Agg_fragment_5_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_10_0_0_lm_0_.execute(i); }
action mem_rmw_o_9_mem_Agg_fragment_6_(out bit<32> o, in bit<16> i) {	o = __ra__ncvm_atomic_cond_add_new_u32_11_0_0_lm_0_.execute(i); }
action ncvm_and_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a & b)); }
action ncl_forward_host( PortId_t port) {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.d_dst = 0;
	TIM.ucast_egress_port = port;
}
action ncl_forward_device( PortId_t port) {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.d_dst = ((bit<8>) M.ncl_act_arg);
	TIM.ucast_egress_port = port;
}
action ncl_reflect_host() {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.h_dst = H.ncp.h_src;
	TIM.ucast_egress_port = IM.ingress_port;
}
action ncl_reflect_device() {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	bit<8> tmp = H.ncp.d_src;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.d_dst = tmp;
	TIM.ucast_egress_port = IM.ingress_port;
}
action ncl_multicast( MulticastGroupId_t mgid) {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	TIM.mcast_grp_a = mgid;
}
action ncl_drop() {	DIM.drop_ctl = 1; }
action ncl_repeat() { }
action reflect() {
	mac_addr_t tmp = H.eth.dst_addr;
	H.eth.dst_addr = H.eth.src_addr;
	H.eth.src_addr = tmp;
	DIM.drop_ctl = 0;
	TIM.bypass_egress = 1;
}
action forward( PortId_t port) {
	DIM.drop_ctl = 0;
	TIM.ucast_egress_port = port;
	TIM.bypass_egress = 1;
}
action drop() {	DIM.drop_ctl[0:0] = 1; }
action multicast( MulticastGroupId_t mgid) {
	TIM.mcast_grp_a = mgid;
	TIM.level1_exclusion_id = ((bit<16>) IM.ingress_port);
	TIM.bypass_egress = 1;
	DIM.drop_ctl[0:0] = 0;
}
table forwarding_table {
	key = { H.eth.dst_addr : exact; }
	actions = {forward; multicast; drop; NoAction; }
	default_action = NoAction;
	size = 1024;
}
action arp_resolve( mac_addr_t mac) {
	H.arp.opcode = ARP_RES;
	H.arp_ip4.dst_hw_addr = H.arp_ip4.src_hw_addr;
	H.arp_ip4.src_hw_addr = mac;
	ip4_addr_t tmp1 = H.arp_ip4.dst_proto_addr;
	H.arp_ip4.dst_proto_addr = H.arp_ip4.src_proto_addr;
	H.arp_ip4.src_proto_addr = tmp1;
	H.eth.dst_addr = H.eth.src_addr;
	H.eth.src_addr = mac;
}
action ncl_use_implicit_ip4_src_addr(inout headers H) {if (_ncl_use_implicit_ip4_src_addr_)
	H.ip4.src_addr = _ncl_ip4_addr_; }

action drop() {	EDM.drop_ctl = 1; }
action host_port( bit<8> id,  bit<32> ip,  bit<48> mac,  bool neighbor) {
	if (neighbor) {
		H.ncp.h_dst = id;
		H.ncp.d_dst = 0;
	}
	H.eth.src_addr = H.eth.dst_addr;
	H.eth.dst_addr = mac;
	H.ip4.dst_addr = ip;
	H.ip4.ttl = (H.ip4.ttl - 1);
	H.udp.checksum = 0;
}
action device_port( bit<8> id) {	H.ncp.d_dst = id; }
table ncl_port_tbl {
	key = { EM.egress_port : exact; }
	actions = {host_port; device_port; drop; }
	default_action = drop();
	size = 256;
}
action udp_ports_swap() {
	bit<16> tmp = H.udp.dst_port;
	H.udp.dst_port = H.udp.src_port;
	H.udp.src_port = tmp;
}
action udp_ports_mod( bit<16> src_port,  bit<16> dst_port) {
	if ((src_port != 0))
		H.udp.src_port = src_port;
	if ((dst_port != 0))
		H.udp.dst_port = dst_port;
}
action udp_ports_are_ncl_and( bit<16> dst_port) {
	H.udp.src_port = _ncl_udp_port_;
	if ((dst_port != 0))
		H.udp.dst_port = dst_port;
}
action udp_ports_are_dst_and( bit<16> dst_port) {
	H.udp.src_port = H.udp.dst_port;
	if ((dst_port != 0))
		H.udp.dst_port = dst_port;
}