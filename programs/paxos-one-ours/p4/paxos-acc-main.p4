// #include <core.p4>
// #include <tna.p4>
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

  // VALUE
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue1;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue2;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue3;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue4;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue5;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue6;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue7;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue8;

  bool read_value = false;
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) value_1_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval1;
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) value_2_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval2;
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) value_3_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval3;
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) value_4_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval4;
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) value_5_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval5;
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) value_6_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval6;
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) value_7_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval7;
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) value_8_read_or_write = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if (read_value) {
        ret = reg;
      } else {
        reg = hdr.paxos.paxosval8;
        ret = reg;
      }
    }
  };

  // ROUND
  Register<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerRound;
  RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) read_old_round_and_write_max = {
    void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
      ret = reg;
      reg = max(hdr.paxos.rnd, reg);
    }
  };

  action _drop() {
    dim.drop_ctl[0:0] = 1;
  }

  action handle_1a() {
    hdr.paxos.msgtype = PAXOS_1B;
    hdr.paxos.vrnd = registerVRound.read(hdr.paxos.inst);
    registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
    meta.paxos_metadata.set_drop = 0;
    read_value = true;
  }

  action handle_2a() {
    hdr.paxos.msgtype = PAXOS_2B;
    registerVRound.write(hdr.paxos.inst, hdr.paxos.rnd);
    registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
    meta.paxos_metadata.set_drop = 0;
  }

  table acceptor_tbl {
    key = {hdr.paxos.msgtype : exact;}
    actions = {
      handle_1a;
      handle_2a;
      _drop;
    }
    size = 4;
    default_action = _drop();
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

  bit<ROUND_SIZE> round_check = 0;
  action check_for_larger_round() {
    round_check = (meta.paxos_metadata.old_round - hdr.paxos.rnd);
  }

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