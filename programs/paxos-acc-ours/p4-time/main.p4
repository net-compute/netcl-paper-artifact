#include <core.p4>
#include <tna.p4>
#include "headers.p4"
#include "parsers.p4"

control ingress( inout headers hdr,
                 inout metadata meta,
                 in ingress_intrinsic_metadata_t im,
                 in ingress_intrinsic_metadata_from_parser_t pim,
                 inout ingress_intrinsic_metadata_for_deparser_t dim,
                 inout ingress_intrinsic_metadata_for_tm_t tim) {

  Register<bit<DATAPATH_SIZE>, bit<1>>(1) registerAcceptorID;
  Register<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerVRound;

  // ROUND
  bit<ROUND_SIZE> round_old = 0;
  bit<ROUND_SIZE> current_round = 0;
  bit<1> round_valid = 0;
  Register<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerRound;
  RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) compute_and_get_max_round = {
    void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
      reg = max(hdr.paxos.rnd, reg);
      ret = reg;
    }
  };


  // VALUE
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue1;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue2;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue3;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue4;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue5;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue6;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue7;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue8;
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) read_value_1 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) read_value_2 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) read_value_3 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) read_value_4 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) read_value_5 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) read_value_6 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) read_value_7 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) read_value_8 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) write_value_1 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval1;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) write_value_2 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval2;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) write_value_3 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval3;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) write_value_4 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval4;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) write_value_5 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval5;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) write_value_6 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval6;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) write_value_7 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval7;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) write_value_8 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval8;
    }
  };
  action value_1_read() {
    hdr.paxos.paxosval1 = read_value_1.execute(hdr.paxos.inst);
  }
  action value_2_read() {
    hdr.paxos.paxosval2 = read_value_2.execute(hdr.paxos.inst);
  }
  action value_3_read() {
    hdr.paxos.paxosval3 = read_value_3.execute(hdr.paxos.inst);
  }
  action value_4_read() {
    hdr.paxos.paxosval4 = read_value_4.execute(hdr.paxos.inst);
  }
  action value_5_read() {
    hdr.paxos.paxosval5 = read_value_5.execute(hdr.paxos.inst);
  }
  action value_6_read() {
    hdr.paxos.paxosval6 = read_value_6.execute(hdr.paxos.inst);
  }
  action value_7_read() {
    hdr.paxos.paxosval7 = read_value_7.execute(hdr.paxos.inst);
  }
  action value_8_read() {
    hdr.paxos.paxosval8 = read_value_8.execute(hdr.paxos.inst);
  }
  action value_1_write() {
    hdr.paxos.paxosval1 = write_value_1.execute(hdr.paxos.inst);
  }
  action value_2_write() {
    hdr.paxos.paxosval2 = write_value_2.execute(hdr.paxos.inst);
  }
  action value_3_write() {
    hdr.paxos.paxosval3 = write_value_3.execute(hdr.paxos.inst);
  }
  action value_4_write() {
    hdr.paxos.paxosval4 = write_value_4.execute(hdr.paxos.inst);
  }
  action value_5_write() {
    hdr.paxos.paxosval5 = write_value_5.execute(hdr.paxos.inst);
  }
  action value_6_write() {
    hdr.paxos.paxosval6 = write_value_6.execute(hdr.paxos.inst);
  }
  action value_7_write() {
    hdr.paxos.paxosval7 = write_value_7.execute(hdr.paxos.inst);
  }
  action value_8_write() {
    hdr.paxos.paxosval8 = write_value_8.execute(hdr.paxos.inst);
  }
  table read_or_write_value_1 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_1_read;
      value_1_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_1_read();
      PAXOS_2A  : value_1_write();
    }
  }
  table read_or_write_value_2 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_2_read;
      value_2_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_2_read();
      PAXOS_2A  : value_2_write();
    }
  }
  table read_or_write_value_3 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_3_read;
      value_3_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_3_read();
      PAXOS_2A  : value_3_write();
    }
  }
  table read_or_write_value_4 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_4_read;
      value_4_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_4_read();
      PAXOS_2A  : value_4_write();
    }
  }
  table read_or_write_value_5 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_5_read;
      value_5_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_5_read();
      PAXOS_2A  : value_5_write();
    }
  }
  table read_or_write_value_6 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_6_read;
      value_6_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_6_read();
      PAXOS_2A  : value_6_write();
    }
  }
  table read_or_write_value_7 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_7_read;
      value_7_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_7_read();
      PAXOS_2A  : value_7_write();
    }
  }
  table read_or_write_value_8 {
    key = {
      hdr.paxos.msgtype: exact;
    }
    actions = {
      value_8_read;
      value_8_write;
      NoAction;
    }
    default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A  : value_8_read();
      PAXOS_2A  : value_8_write();
    }
  }

  action _drop() {
    meta.paxos_metadata.set_drop = 1;
    dim.drop_ctl[0:0] = 1;
  }

  action handle_1a() {
    hdr.paxos.msgtype = PAXOS_1B;
    hdr.paxos.vrnd = registerVRound.read(hdr.paxos.inst);
    meta.paxos_metadata.set_drop = 0;
  }

  action handle_2a() {
    hdr.paxos.msgtype = PAXOS_2B;
    registerVRound.write(hdr.paxos.inst, hdr.paxos.rnd);
    meta.paxos_metadata.set_drop = 0;
  }

  table acceptor_tbl {
    key = { hdr.paxos.msgtype : exact; }
    actions = {
      handle_1a;
      handle_2a;
      _drop;
    }
    size = 2;
    default_action = _drop();
    const entries = {
      PAXOS_1A : handle_1a();
      PAXOS_2A : handle_2a();
    }
  }

  action forward(PortId port, bit<16> learnerPort) {
    tim.ucast_egress_port = port;
    hdr.udp.dstPort = learnerPort;
  }

  table transport_tbl {
    key = { meta.paxos_metadata.set_drop : exact; }
    actions = {
      _drop;
        forward;
    }
    size = 2;
    default_action =  _drop();
  }

  action read_round() {
    current_round = compute_and_get_max_round.execute(hdr.paxos.inst);
  }

  // if its a valid packet, compute max of register and incoming round,
  // write the result back to the register, and store it at current_round
  table round_tbl {
    key = { hdr.paxos.msgtype: exact; }
    actions = { read_round; NoAction; }
    const default_action = NoAction;
    const size = 2;
    const entries = {
      PAXOS_1A: read_round();
      PAXOS_2A: read_round();
    }
  }

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
}

control egress( inout headers hdr,
                inout metadata m,
                in egress_intrinsic_metadata_t im,
                in egress_intrinsic_metadata_from_parser_t pim,
                inout egress_intrinsic_metadata_for_deparser_t dim,
                inout egress_intrinsic_metadata_for_output_port_t opim ) {

  table place_holder_table {
    actions = {
      NoAction;
    }
    size = 2;
    default_action = NoAction();
  }
  apply {
    place_holder_table.apply();
  }
}

Pipeline(ingress_parser(), ingress(), ingress_deparser(),
         egress_parser(), egress(), egress_deparser()) pipe;

Switch(pipe) main;