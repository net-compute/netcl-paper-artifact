apply {
  if (hdr.ipv4.isValid()) {
    if (hdr.paxos.isValid()) {
      leader_tbl.apply();
      transport_tbl.apply();
    }
  }
}
apply {
  place_holder_table.apply();
}