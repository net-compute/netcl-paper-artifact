action compute_cms_idx_1() {
  c1idx = cms_hash_1.get({H.cache.k});
}
action compute_cms_idx_2() {
  c2idx = cms_hash_2.get({H.cache.k});
}
action compute_cms_idx_3() {
  c3idx = cms_hash_3.get({H.cache.k});
}
action compute_cms_idx_4() {
  c4idx = cms_hash_4.get({H.cache.k});
}
action compute_bf_idx_1() {
  bidx1 = bh1.get({H.cache.k});
}
action compute_bf_idx_2() {
  bidx2 = bh2.get({H.cache.k});
}
action compute_bf_idx_3() {
  bidx3 = bh3.get({H.cache.k});
}
action compute_cond_1() {
  cond1 = HH_THRESH - c1;
}
action compute_cond_2() {
  cond2 = HH_THRESH - c2;
}
action compute_cond_3() {
  cond3 = HH_THRESH - c3;
}
action compute_cond_4() {
  cond4 = HH_THRESH - c4;
}
action hot() {
  H.cache.hot = 1;
}
action cold() {
  H.cache.hot = 0;
}
action read_idx(idx_t i) {
  idx = i;
}
action read_mask(bitmap_t mask) {
  H.cache.mask = mask;
}
action read_valid_lo() {
  valid = reg_valid_read_lo.execute(idx);
}
action read_valid_hi() {
  valid = reg_valid_read_hi.execute(idx);
}
action set_valid() {
  valid = reg_valid_set_valid.execute(idx);
}
action set_invalid() {
  valid = reg_valid_set_invalid.execute(idx);
}
action read_cache_1_action() {
  H.cache.v1 = read_cache_1.execute(idx);
}
action read_cache_2_action() {
  H.cache.v2 = read_cache_2.execute(idx);
}
action read_cache_3_action() {
  H.cache.v3 = read_cache_3.execute(idx);
}
action read_cache_4_action() {
  H.cache.v4 = read_cache_4.execute(idx);
}
action write_cache_1_action() {
  write_cache_1.execute(idx);
}
action write_cache_2_action() {
  write_cache_2.execute(idx);
}
action write_cache_3_action() {
  write_cache_3.execute(idx);
}
action write_cache_4_action() {
  write_cache_4.execute(idx);
}
action reflect() {
  mac_addr_t tmp = H.eth.src_addr;
  H.eth.src_addr = H.eth.dst_addr;
  H.eth.dst_addr = tmp;

  ip4_addr_t tmp2 = H.ip4.src_addr;
  H.ip4.src_addr = H.ip4.dst_addr;
  H.ip4.dst_addr = tmp2;

  udp_port_t tmp3 = H.udp.src_port;
  H.udp.src_port = H.udp.dst_port;
  H.udp.dst_port = tmp3;

  H.udp.checksum = 0;
}
action send_to_port(PortId_t port) {
  DIM.drop_ctl[0:0] = 0x0;
  TIM.ucast_egress_port = port;
}
action flood() {
  DIM.drop_ctl[0:0] = 0x0;
  TIM.mcast_grp_a = FLOOD_MULTICAST_GROUP_ID;
  TIM.level1_exclusion_id = (bit<16>) IM.ingress_port;
}
action arp_resolve(mac_addr_t mac) {
  H.arp.opcode = ARP_RES;
  H.arp_ip4.dst_hw_addr = H.arp_ip4.src_hw_addr;
  H.arp_ip4.src_hw_addr = mac;
  ip4_addr_t tmp = H.arp_ip4.dst_proto_addr;
  H.arp_ip4.dst_proto_addr = H.arp_ip4.src_proto_addr;
  H.arp_ip4.src_proto_addr = tmp;
  H.eth.dst_addr = H.eth.src_addr;
  H.eth.src_addr = mac;
}