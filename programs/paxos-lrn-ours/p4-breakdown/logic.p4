apply {
  if (hdr.ipv4.isValid()) {
    if (hdr.paxos.isValid()) {

      acptid = (bit<8>) hdr.paxos.acptid;
      get_acptid_tbl.apply();

      meta.paxos_metadata.old_round = read_old_round_and_write_max.execute(hdr.paxos.inst);

      get_round_check();
      if ((round_check[ROUND_SIZE - 1: ROUND_SIZE - 1] == 1) || (round_check == 0)) {
        write_value_1();
        write_value_2();
        write_value_3();
        write_value_4();
        write_value_5();
        write_value_6();
        write_value_7();
        write_value_8();
      }

      history_tbl.apply();

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