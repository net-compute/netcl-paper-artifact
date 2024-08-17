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
                 inout ingress_intrinsic_metadata_for_tm_t tim)  {

  Register<bit<INSTANCE_SIZE>, bit<1>>(1) registerInstance;
  RegisterAction<bit<INSTANCE_SIZE>, bit<1>, bit<INSTANCE_SIZE>>(registerInstance) inc_instance = {
    void apply(inout bit<INSTANCE_SIZE> reg, out bit<INSTANCE_SIZE> ret) {
      reg = reg + 1;
      ret = reg;
    }
  };
  RegisterAction<bit<INSTANCE_SIZE>, bit<1>, bit<INSTANCE_SIZE>>(registerInstance) rst_instance = {
    void apply(inout bit<INSTANCE_SIZE> reg, out bit<INSTANCE_SIZE> ret) {
      reg = 0;
      ret = reg;
    }
  };

  action _drop() {
    dim.drop_ctl[0:0] = 1;
  }

  action increase_instance() {
    hdr.paxos.inst = inc_instance.execute(0);
    meta.paxos_metadata.set_drop = 0;
  }

  action reset_instance() {
    hdr.paxos.inst = rst_instance.execute(0);
    meta.paxos_metadata.set_drop = 1;
  }

  table leader_tbl {
    key = {hdr.paxos.msgtype : exact;}
    actions = {
      increase_instance;
      reset_instance;
      _drop;
    }
    size = 4;
    default_action = _drop();
  }


  action forward(PortId port, bit<16> acceptorPort) {
    tim.ucast_egress_port = port;
    hdr.udp.dstPort = acceptorPort;
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

  apply {
    if (hdr.ipv4.isValid()) {
      if (hdr.paxos.isValid()) {
        leader_tbl.apply();
        transport_tbl.apply();
      }
    }
  }
}
