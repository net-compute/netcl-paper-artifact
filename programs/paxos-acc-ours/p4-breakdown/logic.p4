apply {
  if (hdr.ipv4.isValid()) {
    if (meta.ipv4_checksum_error) {

      _drop();

    } else if (hdr.paxos.isValid()) {

      meta.paxos_metadata.set_drop = 1;

      if (round_tbl.apply().hit) {


        acceptor_tbl.apply();
        hdr.paxos.acptid = registerAcceptorID.read(0);

        read_or_write_value_1.apply();
        read_or_write_value_2.apply();
        read_or_write_value_3.apply();
        read_or_write_value_4.apply();
        read_or_write_value_5.apply();
        read_or_write_value_6.apply();
        read_or_write_value_7.apply();
        read_or_write_value_8.apply();

        transport_tbl.apply();
      }
    }
  }
}
apply {
  place_holder_table.apply();
}