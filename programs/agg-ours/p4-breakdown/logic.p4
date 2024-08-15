apply {
  reduce.apply();
}
apply {
  reduce.apply();
}
apply {

  bitmap.apply();
  check_bitmap();

  count.apply();

  RExpo.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.expo);

  R00.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v00);
  R01.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v01);
  R02.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v02);
  R03.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v03);
  R04.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v04);
  R05.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v05);
  R06.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v06);
  R07.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v07);
  R08.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v08);
  R09.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v09);
  R10.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v10);
  R11.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v11);
  R12.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v12);
  R13.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v13);
  R14.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v14);
  R15.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v15);
  R16.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v16);
  R17.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v17);
  R18.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v18);
  R19.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v19);
  R20.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v20);
  R21.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v21);
  R22.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v22);
  R23.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v23);
  R24.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v24);
  R25.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v25);
  R26.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v26);
  R27.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v27);
  R28.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v28);
  R29.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v29);
  R30.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v30);
  R31.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v31);

  next.apply();
}
apply {
  TIM.bypass_egress = 1;
  if (H.arp_ip4.isValid() && H.arp.opcode == ARP_REQ) {
    arp_table.apply();
  }
  forwarding_table.apply();
}
apply {
  if (H.agg.isValid()) {
    agg.apply(H, M, IM, PIM, DIM, TIM);
  } else {
    net.apply(H, M, IM, PIM, DIM, TIM);
  }
}
apply {
  if (H.agg.isValid()) {
    allreduce_sender.apply();
  }
}