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
} }
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
action mem_rmw_0_mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound(in bit<16> i) {	__ra__ncvm_atomic_write_u16_1_0_0_m_0_.execute(i); }
action mem_rmw_1_mem_Value_fragment_0_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_2_0_0_m_0_.execute(i); }
action mem_rmw_2_mem_Value_fragment_1_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_3_0_0_m_0_.execute(i); }
action mem_rmw_3_mem_Value_fragment_2_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_4_0_0_m_0_.execute(i); }
action mem_rmw_4_mem_Value_fragment_3_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_5_0_0_m_0_.execute(i); }
action mem_rmw_5_mem_Value_fragment_4_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_6_0_0_m_0_.execute(i); }
action mem_rmw_6_mem_Value_fragment_5_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_7_0_0_m_0_.execute(i); }
action mem_rmw_7_mem_Value_fragment_6_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_8_0_0_m_0_.execute(i); }
action mem_rmw_8_mem_Value_fragment_7_(in bit<16> i) {	__ra__ncvm_atomic_write_u32_9_0_0_m_0_.execute(i); }
action mem_rmw_o_0_mem_Round(out bit<16> o, in bit<16> i) {	o = __ra__ncvm_atomic_max_new_u16_0_0_0_m_0_.execute(i); }
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