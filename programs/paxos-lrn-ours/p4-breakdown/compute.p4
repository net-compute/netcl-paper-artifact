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
  bit<1> set_drop;
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

  bit<8> vote = 0;
  action get_vote(bit<8> v) {
    vote = v;
  }
  table vote_tbl {
    key = {
      hdr.paxos.acptid: exact;
    }
    actions = {
      get_vote;
    }
    const default_action = get_vote(0);
    const size = 8;
    const entries = {
      16w0b00000001 : get_vote(1 << 0);
      16w0b00000010 : get_vote(1 << 1);
      16w0b00000100 : get_vote(1 << 2);
      16w0b00001000 : get_vote(1 << 3);
      16w0b00010000 : get_vote(1 << 4);
      16w0b00100000 : get_vote(1 << 5);
      16w0b01000000 : get_vote(1 << 6);
      16w0b10000000 : get_vote(1 << 7);
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
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue1) write_value_1 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval1;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue2) write_value_2 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval2;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue3) write_value_3 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval3;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue4) write_value_4 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval4;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue5) write_value_5 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval5;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue6) write_value_6 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval6;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue7) write_value_7 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval7;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<INSTANCE_SIZE>, bit<32>>(registerValue8) write_value_8 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = hdr.paxos.paxosval8;
      ret = reg;
    }
  };

  action value_1_write() {
    write_value_1.execute(hdr.paxos.inst);
  }
  action value_2_write() {
    write_value_2.execute(hdr.paxos.inst);
  }
  action value_3_write() {
    write_value_3.execute(hdr.paxos.inst);
  }
  action value_4_write() {
    write_value_4.execute(hdr.paxos.inst);
  }
  action value_5_write() {
    write_value_5.execute(hdr.paxos.inst);
  }
  action value_6_write() {
    write_value_6.execute(hdr.paxos.inst);
  }
  action value_7_write() {
    write_value_7.execute(hdr.paxos.inst);
  }
  action value_8_write() {
    write_value_8.execute(hdr.paxos.inst);
  }

  // ROUND
  Register<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerRound;
  RegisterAction<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>, bit<ROUND_SIZE>>(registerRound) read_old_round_and_write_max = {
    void apply(inout bit<ROUND_SIZE> reg, out bit<ROUND_SIZE> ret) {
      ret = reg;
      reg = max(reg, hdr.paxos.rnd);
    }
  };

  // HISTORY
  Register<bit<8>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerHistory2B;
  RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) update_history = {
    void apply (inout bit<8> reg, out bit<8> ret) {
      reg = (bit<8>) reg | vote;
      ret = reg;
    }
  };
  RegisterAction<bit<8>, bit<INSTANCE_SIZE>, bit<8>>(registerHistory2B) write_history = {
    void apply(inout bit<8> reg, out bit<8> ret) {
      reg = vote;
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
      hdr.paxos.msgtype: ternary;
    }
    actions = {
      update_history_action;
      write_history_action;
    }
    const size = 2;
    const entries = {
      PAXOS_2B : update_history_action();
             _ : write_history_action();
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
    key = {
      meta.paxos_metadata.set_drop : exact;
    }
    actions = {
      _drop;
        forward;
    }
    size = 2;
    default_action =  _drop();
  }

  bit<ROUND_SIZE> round_old;
  bit<ROUND_SIZE> round_dif;
  bit<1> round_valid;
  action round_is_valid() {
    round_valid = 1;
  }
  action round_is_invalid() {
    round_valid = 0;
  }
  table round_check_tbl {
    key = {
      round_dif: ternary;
    }
    actions = {
      round_is_valid;
      round_is_invalid;
    }
    const default_action = round_is_valid;
    const size = 2;
    const entries = {
                                                        0 : round_is_valid();
      (1 << (ROUND_SIZE - 1)) &&& (1 << (ROUND_SIZE - 1)) : round_is_invalid(); // MSB==1 -> larger round
    }
  }

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
}