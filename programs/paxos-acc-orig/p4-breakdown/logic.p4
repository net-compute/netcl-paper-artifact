apply {
  if (hdr.ipv4.isValid()) {
    if (hdr.paxos.isValid()) {
      read_round();
      if (hdr.paxos.rnd >= meta.paxos_metadata.round) {
        acceptor_tbl.apply();
        transport_tbl.apply();
      }
    }
  }
}
apply {
  place_holder_table.apply();
}