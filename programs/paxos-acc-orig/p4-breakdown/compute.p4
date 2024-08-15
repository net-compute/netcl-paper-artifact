#define PAXOS_PROTOCOL 16w0x8888
const bit<16> ACCEPTOR_PORT = 0x8889;
const bit<16> LEARNER_PORT = 0x8890;
const bit<16> APPLICATION_PORT = 56789;
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
  bit<VALUE_SIZE>     paxosval;   // the value the acceptor voted for
}
struct paxos_metadata_t {
  bit<ROUND_SIZE> round;
  bit<1> set_drop;
  bit<8> ack_count;
  bit<8> ack_acceptors;
}
struct metadata {
  paxos_metadata_t   paxos_metadata;
}
control ingress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
  register<bit<DATAPATH_SIZE>>(1) registerAcceptorID;
  register<bit<ROUND_SIZE>>(INSTANCE_COUNT) registerRound;
  register<bit<ROUND_SIZE>>(INSTANCE_COUNT) registerVRound;
  register<bit<VALUE_SIZE>>(INSTANCE_COUNT) registerValue;

  action _drop() {
      mark_to_drop();
  }

  action read_round() {
      registerRound.read(meta.paxos_metadata.round, hdr.paxos.inst);
      meta.paxos_metadata.set_drop = 1;
  }

  action handle_1a() {
      hdr.paxos.msgtype = PAXOS_1B;
      registerVRound.read(hdr.paxos.vrnd, hdr.paxos.inst);
      registerValue.read(hdr.paxos.paxosval, hdr.paxos.inst);
      registerAcceptorID.read(hdr.paxos.acptid, 0);
      registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
      meta.paxos_metadata.set_drop = 0;

  }

  action handle_2a() {
      hdr.paxos.msgtype = PAXOS_2B;
      registerAcceptorID.read(hdr.paxos.acptid, 0);
      registerRound.write(hdr.paxos.inst, hdr.paxos.rnd);
      registerVRound.write(hdr.paxos.inst, hdr.paxos.rnd);
      registerValue.write(hdr.paxos.inst, hdr.paxos.paxosval);
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
      standard_metadata.egress_spec = port;
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
}