apply {
  compute_cms_idx_1();
  compute_cms_idx_2();
  compute_cms_idx_3();
  compute_cms_idx_4();
  c1 = sketch1.execute(c1idx);
  c2 = sketch2.execute(c2idx);
  c3 = sketch3.execute(c3idx);
  c4 = sketch4.execute(c4idx);
  compute_cond_1();
  compute_cond_2();
  compute_cond_3();
  compute_cond_4();
  if (cond1[31:31] == 1) {
    if (cond2[31:31] == 1) {
      if (cond3[31:31] == 1) {
        if (cond4[31:31] == 1) {
          compute_bf_idx_1();
          compute_bf_idx_2();
          compute_bf_idx_3();
          b1 = filter1.execute(bidx1);
          b2 = filter2.execute(bidx2);
          b3 = filter3.execute(bidx3);
          check.apply();
        }
      }
    }
  }
}
apply {
  mask.apply();
  if (index.apply().hit) {
    if ( H.cache.op == GET_RQ) {
      chk_valid.apply();
      if (valid == 1) {

        read_cache_1_action();
        read_cache_2_action();
        read_cache_3_action();
        read_cache_4_action();

        reg_stats_update.execute(idx);

        H.cache.op = GET_RS;
        reflect(); // reflect to client
      }
    } else if (H.cache.op == PUT_RQ || H.cache.op == DEL_RQ) {
      // Put and del only invalidate the cache,
      // The server may follow with UPD_RQ or update the cache
      // from the control plane
      set_invalid();

    } else if (H.cache.op == UPD_RQ) {
      // This is only coming from the server
      set_valid();

      if (H.cache.mask[0:0] == 1)
        write_cache_1_action();
      if (H.cache.mask[1:1] == 1)
        write_cache_2_action();
      if (H.cache.mask[2:2] == 1)
        write_cache_3_action();
      if (H.cache.mask[3:3] == 1)
        write_cache_4_action();

      reg_stats_reset.execute(idx);

      H.cache.op = UPD_RS;
      reflect(); // reflect to server
    }
  } else if ( H.cache.op == GET_RQ) {
    // On a miss, count statistics fot GET_RQ
    hh.apply(H);
  }
}
apply {
  TIM.bypass_egress = 1;
  if (H.arp_ip4.isValid() && H.arp.opcode == ARP_REQ) {
    arp_table.apply();
  }
  forwarding_table.apply();
}
apply {
  if (H.cache.isValid())
    cache.apply(H, M, IM, PIM, DIM, TIM);
  net.apply(H, M, IM, PIM, DIM, TIM);
}
apply {}