apply {
  if (hdr.ipv4.isValid()) {
    if (meta.ipv4_checksum_error) {
      _drop();
    } else if (hdr.paxos.isValid()) {
      meta.paxos_metadata.old_round = read_old_round_and_write_max.execute(hdr.paxos.inst);
      if (round_check[ROUND_SIZE - 1: ROUND_SIZE - 1] == 1) {
        if ( acceptor_tbl.apply().hit ) {
          value_1_read_or_write.execute(hdr.paxos.inst);
          value_2_read_or_write.execute(hdr.paxos.inst);
          value_3_read_or_write.execute(hdr.paxos.inst);
          value_4_read_or_write.execute(hdr.paxos.inst);
          value_5_read_or_write.execute(hdr.paxos.inst);
          value_6_read_or_write.execute(hdr.paxos.inst);
          value_7_read_or_write.execute(hdr.paxos.inst);
          value_8_read_or_write.execute(hdr.paxos.inst);
        }
        transport_tbl.apply();
      }
    }
  }
}
apply {
  place_holder_table.apply();
}