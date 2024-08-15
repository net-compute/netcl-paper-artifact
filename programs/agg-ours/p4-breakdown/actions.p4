action update_register() {
  expo = update.execute(idx);
}

action read_register() {
  expo = read.execute(idx);
}

action write_register() {
  expo = write.execute(idx);
}

action update_register() {
  v = update.execute(idx);
}

action read_register() {
  v = read.execute(idx);
}

action write_register() {
  v = write.execute(idx);
}

action bitmap_0() {
  M.agg.bitmap_old = bitmap_record_lo.execute(H.agg.bmp_idx);
}
action bitmap_1() {
  M.agg.bitmap_old = bitmap_record_hi.execute(H.agg.bmp_idx);
}

action count_contribution() {
  M.agg.count_old = update_counter.execute(H.agg.agg_idx);
}
action count_retransmission() {
  M.agg.count_old = read_counter.execute(H.agg.agg_idx);
}

action next_reflect() {
  TIM.ucast_egress_port = IM.ingress_port;
  TIM.bypass_egress = 0;
  DIM.drop_ctl[0:0] = 0;
}

action next_multicast() {
  TIM.mcast_grp_a = ALLREDUCE_MULTICAST_GRPOUP_ID;
  TIM.bypass_egress = 0;
  DIM.drop_ctl[0:0] = 0;
}

action next_drop() {
  DIM.drop_ctl[0:0] = 1;
}

action check_bitmap() { M.agg.bitmap_chk = M.agg.bitmap_old & H.agg.mask; }

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

action send_to_worker(mac_addr_t mac, ip4_addr_t ip, bitmap_t mask) {
  H.eth.src_addr = H.eth.dst_addr;
  H.eth.dst_addr = mac;
  H.ip4.src_addr = H.ip4.dst_addr;
  H.ip4.dst_addr = ip;
  H.ip4.ttl = H.ip4.ttl |-| 1;
  udp_port_t tmp = H.udp.src_port;
  H.udp.src_port = H.udp.dst_port;
  H.udp.dst_port = tmp;
  H.udp.checksum = 0;
  H.agg.mask = mask;
}