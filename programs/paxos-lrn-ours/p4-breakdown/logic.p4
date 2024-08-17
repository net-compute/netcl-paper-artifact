apply {
  if (hdr.ipv4.isValid()) {

    if (hdr.paxos.isValid()) {

      meta.paxos_metadata.set_drop = 1;

      round_old = read_old_round_and_write_max.execute(hdr.paxos.inst);
      round_dif = round_old - hdr.paxos.rnd;
      round_check_tbl.apply();

      if (round_valid == 1) {

        meta.paxos_metadata.set_drop = 0;

        // In both cases we read the value
        value_1_write();
        value_2_write();
        value_3_write();
        value_4_write();
        value_5_write();
        value_6_write();
        value_7_write();
        value_8_write();

        vote_tbl.apply();

        history_tbl.apply();
      }

      // TODO: replace this with counting number of 1 in Binary
      // e.g count_number_of_1_binary(paxos_metadata.acceptors) == MAJORITY
      if (meta.paxos_metadata.ack_acceptors == 6       // 0b110
          || meta.paxos_metadata.ack_acceptors == 5    // 0b101
          || meta.paxos_metadata.ack_acceptors == 3)   // 0b011
      {
        // deliver the value
        transport_tbl.apply();
      }
    }
  }
}
apply {
  place_holder_table.apply();
}