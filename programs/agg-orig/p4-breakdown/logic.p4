apply {
  arp_icmp.apply();
}
apply {
  reconstruct_worker_bitmap.apply();
}
apply {
  update_and_check_worker_bitmap.apply();
}
apply {
  exponent_max.apply();
}
apply {
  forward.apply();
}
apply {
  count_consume = false;
  count_broadcast = false;
  count_retransmit = false;
  count_recirculate = false;
  count_drop = false;

  next_step.apply();

  // Update counters
  if (count_consume || count_drop) {
      drop_counter.count(ig_md.switchml_md.pool_index);
  }

  if (count_recirculate) {
      recirculate_counter.count(ig_md.switchml_md.pool_index);
  }

  if (count_broadcast) {
      broadcast_counter.count(ig_md.switchml_md.pool_index);
  }

  if (count_retransmit) {
      retransmit_counter.count(ig_md.switchml_md.pool_index);
  }
  apply {
    sum.apply();
  }
}
apply {
    receive_udp.apply();
}
apply {
    hdr.ethernet.setValid();
    hdr.ipv4.setValid();
    hdr.udp.setValid();
    hdr.switchml.setValid();
    hdr.switchml.pool_index = 16w0;

    switch_mac_and_ip.apply();
    dst_addr.apply();

    // Add payload size
    if (eg_md.switchml_md.packet_size == packet_size_t.IBV_MTU_256) {
        hdr.ipv4.total_len = hdr.ipv4.total_len + 256;
        hdr.udp.length = hdr.udp.length + 256;
    }
    else if (eg_md.switchml_md.packet_size == packet_size_t.IBV_MTU_1024) {
        hdr.ipv4.total_len = hdr.ipv4.total_len + 1024;
        hdr.udp.length = hdr.udp.length + 1024;
    }
}
apply {
    count_workers.apply();
}