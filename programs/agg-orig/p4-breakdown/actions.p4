action send_back() {
  // we assume this runs in parallel with or after
  // UDPReceiver which will set packet type IGNORE, so
  // packet will be forwarded
  ig_tm_md.ucast_egress_port = ig_intr_md.ingress_port;
}
action send_arp_reply(mac_addr_t switch_mac, ipv4_addr_t switch_ip) {
  hdr.ethernet.dst_addr = hdr.arp_ipv4.src_hw_addr;
  hdr.ethernet.src_addr = switch_mac;

  hdr.arp.opcode = arp_opcode_t.REPLY;
  hdr.arp_ipv4.dst_hw_addr    = hdr.arp_ipv4.src_hw_addr;
  hdr.arp_ipv4.dst_proto_addr = hdr.arp_ipv4.src_proto_addr;
  hdr.arp_ipv4.src_hw_addr    = switch_mac;
  hdr.arp_ipv4.src_proto_addr = switch_ip;

  send_back();
}
action send_icmp_echo_reply(mac_addr_t switch_mac, ipv4_addr_t switch_ip) {
  hdr.ethernet.dst_addr = hdr.ethernet.src_addr;
  hdr.ethernet.src_addr = switch_mac;

  hdr.ipv4.dst_addr = hdr.ipv4.src_addr;
  hdr.ipv4.src_addr = switch_ip;

  hdr.icmp.msg_type = icmp_type_t.ECHO_REPLY;
  hdr.icmp.checksum = 0;

  send_back();
}
action reconstruct_worker_bitmap_from_worker_id(worker_bitmap_t bitmap) {
  ig_md.worker_bitmap = bitmap;
}
action drop() {
  // Mark for drop; mark as IGNORE so we don't further process this packet
  ig_dprsr_md.drop_ctl[0:0] = 1;
  ig_md.switchml_md.packet_type = packet_type_t.IGNORE;
}
action reconstruct_worker_bitmap_from_worker_id(worker_bitmap_t bitmap) {
  ig_md.worker_bitmap = bitmap;
}
action drop() {
  // Mark for drop; mark as IGNORE so we don't further process this packet
  ig_dprsr_md.drop_ctl[0:0] = 1;
  ig_md.switchml_md.packet_type = packet_type_t.IGNORE;
}
action simulate_drop() {
  drop();
}
action check_worker_bitmap_action() {
  // Set map result to nonzero if this packet is a retransmission
  ig_md.switchml_md.map_result = ig_md.switchml_md.worker_bitmap_before & ig_md.worker_bitmap;
}
action update_worker_bitmap_set0_action() {
  ig_md.switchml_md.worker_bitmap_before = worker_bitmap_update_set0.execute(ig_md.switchml_md.pool_index[14:1]);
  check_worker_bitmap_action();
}
action update_worker_bitmap_set1_action() {
  ig_md.switchml_md.worker_bitmap_before = worker_bitmap_update_set1.execute(ig_md.switchml_md.pool_index[14:1]);
  check_worker_bitmap_action();
}
action write_read0_action() {
  max_exponent0 = write_read0_register_action.execute(ig_md.switchml_md.pool_index);
}
action max_read0_action() {
  max_exponent0 = max_read0_register_action.execute(ig_md.switchml_md.pool_index);
}
action read0_action() {
  max_exponent0 = read0_register_action.execute(ig_md.switchml_md.pool_index);
}
action read1_action() {
  max_exponent1 = read1_register_action.execute(ig_md.switchml_md.pool_index);
}
action set_egress_port(bit<9> egress_port) {
  ig_tm_md.ucast_egress_port = egress_port;
  ig_tm_md.bypass_egress = 1w1;
  ig_dprsr_md.drop_ctl[0:0] = 0;

  ig_md.switchml_md.setInvalid();
  ig_md.switchml_rdma_md.setInvalid();
}
action flood(MulticastGroupId_t flood_mgid) {
  ig_tm_md.mcast_grp_a         = flood_mgid;
  //We use 0x8000 + dev_port as the RID and XID for the flood group
  ig_tm_md.level1_exclusion_id = 7w0b1000000 ++ ig_intr_md.ingress_port;
  ig_tm_md.bypass_egress = 1w1;
  ig_dprsr_md.drop_ctl[0:0] = 0;

  ig_md.switchml_md.setInvalid();
  ig_md.switchml_rdma_md.setInvalid();
}
action recirculate_for_consume(packet_type_t packet_type, PortId_t recirc_port) {
  // Drop both data headers now that they've been consumed
  hdr.d0.setInvalid();
  hdr.d1.setInvalid();

  // Send to recirculation port
  ig_tm_md.ucast_egress_port = recirc_port;
  ig_tm_md.bypass_egress = 1w1;
  ig_dprsr_md.drop_ctl[0:0] = 0;
  ig_md.switchml_md.packet_type = packet_type;

  count_consume = true;
  count_recirculate = true;
}
action recirculate_for_harvest(packet_type_t packet_type, PortId_t recirc_port) {
  // Recirculate for harvest
  ig_tm_md.ucast_egress_port = recirc_port;
  ig_tm_md.bypass_egress = 1w1;
  ig_dprsr_md.drop_ctl[0:0] = 0;
  ig_md.switchml_md.packet_type = packet_type;
}
action recirculate_for_CONSUME1(PortId_t recirc_port) {
  recirculate_for_consume(packet_type_t.CONSUME1, recirc_port);
}
action recirculate_for_CONSUME2_same_port_next_pipe() {
  recirculate_for_consume(packet_type_t.CONSUME2, 2w2 ++ ig_intr_md.ingress_port[6:0]);
}
action recirculate_for_CONSUME3_same_port_next_pipe() {
  recirculate_for_consume(packet_type_t.CONSUME3, 2w3 ++ ig_intr_md.ingress_port[6:0]);
}
action recirculate_for_HARVEST1(PortId_t recirc_port) {
  hdr.d0.setInvalid();
  recirculate_for_harvest(packet_type_t.HARVEST1, recirc_port);
}
action recirculate_for_HARVEST2(PortId_t recirc_port) {
  hdr.d1.setInvalid();
  recirculate_for_harvest(packet_type_t.HARVEST2, recirc_port);
}
action recirculate_for_HARVEST3(PortId_t recirc_port) {
  hdr.d0.setInvalid();
  recirculate_for_harvest(packet_type_t.HARVEST3, recirc_port);
}
action recirculate_for_HARVEST4(PortId_t recirc_port) {
  hdr.d1.setInvalid();
  recirculate_for_harvest(packet_type_t.HARVEST4, recirc_port);
}
action recirculate_for_HARVEST5(PortId_t recirc_port) {
  hdr.d0.setInvalid();
  recirculate_for_harvest(packet_type_t.HARVEST5, recirc_port);
}
action recirculate_for_HARVEST6(PortId_t recirc_port) {
  hdr.d1.setInvalid();
  recirculate_for_harvest(packet_type_t.HARVEST6, recirc_port);
}
action recirculate_for_HARVEST7(PortId_t recirc_port) {
  hdr.d0.setInvalid();
  recirculate_for_harvest(packet_type_t.HARVEST7, recirc_port);
}
action finish_consume() {
  ig_dprsr_md.drop_ctl[0:0] = 1;
  count_consume = true;
  count_drop = true;
}
action broadcast() {
  hdr.d1.setInvalid();

  // Send to multicast group; egress will fill in destination IP and MAC address
  ig_tm_md.mcast_grp_a = ig_md.switchml_md.mgid;
  ig_tm_md.level1_exclusion_id = null_level1_exclusion_id; // don't exclude any nodes
  ig_md.switchml_md.packet_type = packet_type_t.BROADCAST;
  ig_tm_md.bypass_egress = 1w0;
  ig_dprsr_md.drop_ctl[0:0] = 0;

  count_broadcast = true;
}
action retransmit() {
  hdr.d1.setInvalid();

  // Send back out ingress port
  ig_tm_md.ucast_egress_port = ig_md.switchml_md.ingress_port;
  ig_md.switchml_md.packet_type = packet_type_t.RETRANSMIT;
  ig_tm_md.bypass_egress = 1w0;
  ig_dprsr_md.drop_ctl[0:0] = 0;

  count_retransmit = true;
}
action drop() {
  // Mark for drop
  ig_dprsr_md.drop_ctl[0:0] = 1;
  ig_md.switchml_md.packet_type = packet_type_t.IGNORE;
  count_drop = true;
}
action write_read1_action() {
    value1_out = write_read1_register_action.execute(switchml_md.pool_index);
}
action sum_read1_action() {
    value1_out = sum_read1_register_action.execute(switchml_md.pool_index);
}
action read0_action() {
    value0_out = read0_register_action.execute(switchml_md.pool_index);
}
action read1_action() {
    value1_out = read1_register_action.execute(switchml_md.pool_index);
}
action drop() {
    // Ignore this packet and drop when it leaves pipeline
    ig_dprsr_md.drop_ctl[0:0] = 1;
    ig_md.switchml_md.packet_type = packet_type_t.IGNORE;
    receive_counter.count();
}
action forward() {
    ig_md.switchml_md.packet_type = packet_type_t.IGNORE;
    receive_counter.count();
}
action set_bitmap(
    MulticastGroupId_t mgid,
    worker_type_t worker_type,
    worker_id_t worker_id,
    num_workers_t num_workers,
    worker_bitmap_t worker_bitmap) {

    // Count received packet
    receive_counter.count();

    // Bitmap representation for this worker
    ig_md.worker_bitmap = worker_bitmap;
    ig_md.switchml_md.num_workers = num_workers;

    // Group ID for this job
    ig_md.switchml_md.mgid = mgid;

    // Record packet size for use in recirculation
    ig_md.switchml_md.packet_size = hdr.switchml.size;

    ig_md.switchml_md.worker_type = worker_type;
    ig_md.switchml_md.worker_id = worker_id;
    ig_md.switchml_md.dst_port = hdr.udp.src_port;
    ig_md.switchml_md.src_port = hdr.udp.dst_port;
    ig_md.switchml_md.tsi = hdr.switchml.tsi;
    ig_md.switchml_md.job_number = hdr.switchml.job_number;

    // Move the SwitchML set bit in the MSB to the LSB. TODO move set bit to MSB
    ig_md.switchml_md.pool_index = hdr.switchml.pool_index[13:0] ++ hdr.switchml.pool_index[15:15];

    // Mark packet as single-packet message since it's the UDP protocol
    ig_md.switchml_md.first_packet = true;
    ig_md.switchml_md.last_packet = true;

    // Exponents
    ig_md.switchml_md.e0 = hdr.exponents.e0;
    ig_md.switchml_md.e1 = hdr.exponents.e1;

    // Get rid of headers we don't want to recirculate
    hdr.ethernet.setInvalid();
    hdr.ipv4.setInvalid();
    hdr.udp.setInvalid();
    hdr.switchml.setInvalid();
    hdr.exponents.setInvalid();
}
action set_switch_mac_and_ip(mac_addr_t switch_mac, ipv4_addr_t switch_ip) {

    // Set switch addresses
    hdr.ethernet.src_addr = switch_mac;
    hdr.ipv4.src_addr = switch_ip;

    hdr.udp.src_port = eg_md.switchml_md.src_port;

    hdr.ethernet.ether_type = ETHERTYPE_IPV4;

    hdr.ipv4.version = 4;
    hdr.ipv4.ihl = 5;
    hdr.ipv4.diffserv = 0x00;
    hdr.ipv4.total_len = IPV4_LENGTH;
    hdr.ipv4.identification = 0x0000;
    hdr.ipv4.flags = 0b000;
    hdr.ipv4.frag_offset = 0;
    hdr.ipv4.ttl = 64;
    hdr.ipv4.protocol = ip_protocol_t.UDP;
    hdr.ipv4.hdr_checksum = 0; // To be filled in by deparser
    hdr.ipv4.src_addr = switch_ip;
    eg_md.update_ipv4_checksum = true;

    hdr.udp.length = UDP_LENGTH;

    hdr.switchml.setValid();
    hdr.switchml.msg_type = 1;
    hdr.switchml.unused = 0;
    hdr.switchml.size = eg_md.switchml_md.packet_size;
    hdr.switchml.job_number = eg_md.switchml_md.job_number;
    hdr.switchml.tsi = eg_md.switchml_md.tsi;

    // Rearrange pool index
    hdr.switchml.pool_index[13:0] = eg_md.switchml_md.pool_index[14:1];
}
action set_dst_addr(
    mac_addr_t eth_dst_addr,
    ipv4_addr_t ip_dst_addr) {

    // Set to destination node
    hdr.ethernet.dst_addr = eth_dst_addr;
    hdr.ipv4.dst_addr = ip_dst_addr;

    hdr.udp.dst_port = eg_md.switchml_md.dst_port;

    // Disable UDP checksum for now
    hdr.udp.checksum = 0;

    // Update IPv4 checksum
    eg_md.update_ipv4_checksum = true;

    // Pool set bit
    hdr.switchml.pool_index[15:15] = eg_md.switchml_md.pool_index[0:0];

    // Exponents
    hdr.exponents.setValid();
    hdr.exponents.e0 = eg_md.switchml_md.e0;
    hdr.exponents.e1 = eg_md.switchml_md.e1;

    // Count send
    send_counter.count();
}
action count_workers_action() {
    ig_md.switchml_md.first_last_flag = workers_count_action.execute(ig_md.switchml_md.pool_index);
}
action single_worker_count_action() {
    // Execute register action even though it's irrelevant with a single worker
    workers_count_action.execute(ig_md.switchml_md.pool_index);
    // Called for a new packet in a single worker job, so mark as last packet
    ig_md.switchml_md.first_last_flag = 1;
}
action single_worker_read_action() {
    // Called for a retransmitted packet in a single-worker job
    ig_md.switchml_md.first_last_flag = 0;
}
action read_count_workers_action() {
    ig_md.switchml_md.first_last_flag = read_workers_count_action.execute(ig_md.switchml_md.pool_index);
}