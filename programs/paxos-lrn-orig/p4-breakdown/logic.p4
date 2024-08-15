apply {
  if (hdr.ipv4.isValid()) {
    if (hdr.paxos.isValid()) {
      read_round();
      if (hdr.paxos.rnd > meta.paxos_metadata.round) {
          reset_consensus_instance.apply();
      }
      else if (hdr.paxos.rnd == meta.paxos_metadata.round) {
          learner_tbl.apply();
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