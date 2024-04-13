action ncl_lookup_read_u8(out bit<8> val,  bit<8> value) {val = value; }
action ncl_lookup_read_u16(out bit<16> val,  bit<16> value) {val = value; }
action ncl_lookup_read_u32(out bit<32> val,  bit<32> value) {val = value; }
action ncl_lookup_read_u64(out bit<64> val,  bit<64> value) {val = value; }
action ncl_lookup_read_none() { }
@ncvm("ncrt.action.drop")
action ncvm_action_drop(inout metadata M) {
	M.ncl_act = _ncl_action_drop_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.pass")
action ncvm_action_pass(inout metadata M) {
	M.ncl_act = _ncl_action_pass_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.send_to_host")
action ncvm_action_send_to_host(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_send_to_host_;
	M.ncl_act_arg = ID;
}
@ncvm("ncrt.action.send_to_device")
action ncvm_action_send_to_device(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_send_to_device_;
	M.ncl_act_arg = ID;
}
@ncvm("ncrt.action.reflect")
action ncvm_action_reflect(inout metadata M) {
	M.ncl_act = _ncl_action_reflect_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.reflect_long")
action ncvm_action_reflect_long(inout metadata M) {
	M.ncl_act = _ncl_action_reflect_long_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.multicast")
action ncvm_action_multicast(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_multicast_;
	M.ncl_act_arg = ID;
}
@ncvm("ncrt.action.multicast")
action ncvm_action_repeat(inout metadata M) {
	M.ncl_act = _ncl_action_repeat_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
action mem_rmw_0_mem_Value_fragment_0_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_1_0_0_m_0_.execute(i); }
action mem_rmw_1_mem_Value_fragment_1_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_2_0_0_m_0_.execute(i); }
action mem_rmw_2_mem_Value_fragment_2_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_3_0_0_m_0_.execute(i); }
action mem_rmw_3_mem_Value_fragment_3_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_4_0_0_m_0_.execute(i); }
action mem_rmw_4_mem_Value_fragment_4_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_5_0_0_m_0_.execute(i); }
action mem_rmw_5_mem_Value_fragment_5_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_6_0_0_m_0_.execute(i); }
action mem_rmw_6_mem_Value_fragment_6_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_7_0_0_m_0_.execute(i); }
action mem_rmw_7_mem_Value_fragment_7_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_8_0_0_m_0_.execute(i); }
action mem_rmw_o_0_mem_Round(out bit<16> o, in bit<16> i) {	o = __ra__ncvm_atomic_cmp_write_lte_u16_0_0_0_mm_0_.execute(i); }
action mem_rmw_o_1_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory(out bit<8> o, in bit<16> i) {	o = __ra__ncvm_atomic_or_u8_9_0_0_m_0_.execute(i); }
action mem_rmw_o_2_mem__ZZ7learnerR8msg_typeRjtRtRhPjE11VoteHistory(out bit<8> o, in bit<16> i) {	o = __ra__ncvm_atomic_write_u8_10_1_0_m_0_.execute(i); }
action ncvm_and_8_8_8(out bit<8> c, in bit<8> a, in bit<8> b) {	c = ((bit<8>) (a & b)); }
action ncvm_or_8_8_8(out bit<8> c, in bit<8> a, in bit<8> b) {	c = ((bit<8>) (a | b)); }
action ncvm_sub_16_16_16(out bit<16> c, in bit<16> a, in bit<16> b) {	c = ((bit<16>) (a - b)); }
action ncl_forward_host( PortId_t port) {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.d_dst = 0;
	ITM.ucast_egress_port = port;
}
action ncl_forward_device( PortId_t port) {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.d_dst = ((bit<8>) M.ncl_act_arg);
	ITM.ucast_egress_port = port;
}
action ncl_reflect_host() {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.h_dst = H.ncp.h_src;
	ITM.ucast_egress_port = IM.ingress_port;
}
action ncl_reflect_device() {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	bit<8> tmp = H.ncp.d_src;
	H.ncp.d_src = _ncl_device_id_;
	H.ncp.d_dst = tmp;
	ITM.ucast_egress_port = IM.ingress_port;
}
action ncl_multicast( MulticastGroupId_t mgid) {
	H.ncp.act = M.ncl_act;
	H.ncp.act_arg = M.ncl_act_arg;
	ITM.mcast_grp_a = mgid;
}
action ncl_drop() {	IDM.drop_ctl = 1; }
action ncl_repeat() { }
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