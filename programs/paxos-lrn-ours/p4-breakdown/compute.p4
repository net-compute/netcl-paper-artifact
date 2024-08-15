#define PAXOS_1A 0 
#define PAXOS_1B 1 
#define PAXOS_2A 2
#define PAXOS_2B 3 

#define MSGTYPE_SIZE    16
#define INSTANCE_SIZE   32
#define ROUND_SIZE      16
#define DATAPATH_SIZE   16
#define VALUELEN_SIZE   32
#define VALUE_SIZE      256
#define INSTANCE_COUNT  65536
header paxos_t {
  bit<MSGTYPE_SIZE>   msgtype;    // indicates the message type e.g., 1A, 1B, etc.
  bit<INSTANCE_SIZE>  inst;       // instance number
  bit<ROUND_SIZE>     rnd;        // round number
  bit<ROUND_SIZE>     vrnd;       // round in which an acceptor casted a vote
  bit<DATAPATH_SIZE>  acptid;     // Switch ID
  bit<VALUELEN_SIZE>  paxoslen;   // the length of paxos_value
  bit<32>             paxosval1;
  bit<32>             paxosval2;
  bit<32>             paxosval3;
  bit<32>             paxosval4;
  bit<32>             paxosval5;
  bit<32>             paxosval6;
  bit<32>             paxosval7;
  bit<32>             paxosval8;
}
struct paxos_metadata_t {
  bit<ROUND_SIZE> old_round;
  bit<1> set_drop;
  bit<8> ack_count;
  bit<8> ack_acceptors;
}
struct metadata {
  paxos_metadata_t   paxos_metadata;
}
control ingress( inout headers hdr,
                 inout metadata meta,
                 in ingress_intrinsic_metadata_t im,
                 in ingress_intrinsic_metadata_from_parser_t pim,
                 inout ingress_intrinsic_metadata_for_deparser_t dim,
                 inout ingress_intrinsic_metadata_for_tm_t tim) {

  bit<8> acptid = 0;
  bit<ROUND_SIZE> round_check = 0;
  action get_acptid(bit<8> id) {
    acptid = id;
  }
  table get_acptid_tbl {
    key = {
      acptid: exact;
    }
    actions = { get_acptid; }
    const size = 8;
    const entries = {
      8w0b00000000 : get_acptid(1 << 8w0b00000000);
      8w0b00000001 : get_acptid(1 << 8w0b00000001);
      8w0b00000010 : get_acptid(1 << 8w0b00000010);
      8w0b00000100 : get_acptid(1 << 8w0b00000100);
      8w0b00001000 : get_acptid(1 << 8w0b00001000);
      8w0b00010000 : get_acptid(1 << 8w0b00010000);
      8w0b00100000 : get_acptid(1 << 8w0b00100000);
      8w0b01000000 : get_acptid(1 << 8w0b01000000);
      8w0b10000000 : get_acptid(1 << 8w0b10000000);
    }
  }

  // VALUE
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue1;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue2;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue3;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue4;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue5;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue6;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue7;
  Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue8;
  action write_value_1() {
    registerValue1.write(hdr.paxos.inst, hdr.paxos.paxosval1);
  }
  action write_value_2() {
    registerValue2.write(hdr.paxos.inst, hdr.paxos.paxosval2);
  }
  action write_value_3() {
    registerValue3.write(hdr.paxos.inst, hdr.paxos.paxosval3);
  }
  action write_value_4() {
    registerValue4.write(hdr.paxos.inst, hdr.paxos.paxosval4);
  }
  action write_value_5() {
    registerValue5.write(hdr.paxos.inst, hdr.paxos.paxosval5);
  }
  action write_value_6() {
    registerValue6.write(hdr.paxos.inst, hdr.paxos.paxosval6);
  }
  action write_value_7() {
    registerValue7.write(hdr.paxos.inst, hdr.paxos.paxosval7);
  }
  action write_value_8() {
    registerValue8.write(hdr.paxos.inst, hdr.paxos.paxosval8);
  }

  // ROUND
  Register<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerRound;
  RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) read_old_round_and_write_max = {
    void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
      ret = reg;
      bit<ROUND_SIZE> tmp = reg - hdr.paxos.rnd;
      if (tmp > (16w0b0111111111111111 / 2)) // hdr.paxos.rnd is larger
        reg = hdr.paxos.rnd;
      if ( (tmp == 0))                       // is equal
        reg = hdr.paxos.rnd;
    }
  };
  action update_round() {
    registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
  }
  table update_round_tbl {
    key = {hdr.paxos.msgtype : exact; }
    actions = { NoAction; update_round; }
    size = 2;
    default_action = NoAction;
  }

  // HISTORY
  Register<bit<8>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerHistory2B;
  RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) update_history = {
    void apply (inout bit<8> reg, out bit<8> ret) {
      reg = (bit<8>) reg | acptid;
      ret = reg;
    }
  };
  RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) write_history = {
    void apply(inout bit<8> reg, out bit<8> ret) {
      reg = acptid;
      ret = reg;
    }
  };
  action update_history_action() {
    meta.paxos_metadata.ack_acceptors = update_history.execute(hdr.paxos.inst);
  }
  action write_history_action() {
    meta.paxos_metadata.ack_acceptors = write_history.execute(hdr.paxos.inst);
  }
  table history_tbl {
    key = {
      round_check: ternary;
    }
    actions = {
      update_history_action;
      write_history_action;
    }
    const size = 2;
    const entries = {
                                                        0 :  update_history_action();
      (1 << (ROUND_SIZE - 1)) &&& (1 << (ROUND_SIZE - 1)) :  write_history_action();
    }
  }


  action _drop() {
    dim.drop_ctl[0:0] = 1;
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


  action get_round_check() {
    round_check = (meta.paxos_metadata.old_round - hdr.paxos.rnd);
  }

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
}