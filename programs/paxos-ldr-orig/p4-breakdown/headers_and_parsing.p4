header ethernet_t {
  EthernetAddress dstAddr;
  EthernetAddress srcAddr;
  bit<16> etherType;
}
header ipv4_t {
  bit<4> version;
  bit<4> ihl;
  bit<8> diffserv;
  bit<16> totalLen;
  bit<16> identification;
  bit<3> flags;
  bit<13> fragOffset;
  bit<8> ttl;
  bit<8> protocol;
  bit<16> hdrChecksum;
  IPv4Address srcAddr;
  IPv4Address dstAddr;
}
header udp_t {
  bit<16> srcPort;
  bit<16> dstPort;
  bit<16> length_;
  bit<16> checksum;
}
header paxos_t {
  bit<MSGTYPE_SIZE>   msgtype;    // indicates the message type e.g., 1A, 1B, etc.
  bit<INSTANCE_SIZE>  inst;       // instance number
  bit<ROUND_SIZE>     rnd;        // round number
  bit<ROUND_SIZE>     vrnd;       // round in which an acceptor casted a vote
  bit<DATAPATH_SIZE>  acptid;     // Switch ID
  bit<VALUELEN_SIZE>  paxoslen;   // the length of paxos_value
  bit<VALUE_SIZE>     paxosval;   // the value the acceptor voted for
}
struct headers {
  ethernet_t ethernet;
  ipv4_t ipv4;
  udp_t udp;
  paxos_t paxos;
}
parser TopParser(packet_in b, out headers p, inout metadata meta, inout standard_metadata_t standard_metadata) {
  state start {
    transition parse_ethernet;
  }

  state parse_ethernet {
    b.extract(p.ethernet);
    transition select(p.ethernet.etherType) {
      ETHERTYPE_IPV4 : parse_ipv4;
    }
  }

  state parse_ipv4 {
    b.extract(p.ipv4);
    transition select(p.ipv4.protocol) {
      UDP_PROTOCOL : parse_udp;
      default : accept;
    }
  }

  state parse_udp {
    b.extract(p.udp);
    transition select(p.udp.dstPort) {
      PAXOS_PROTOCOL : parse_paxos;
      default : accept;
    }
  }

  state parse_paxos {
    b.extract(p.paxos);
    transition accept;
  }
}
control TopDeparser(packet_out packet, in headers hdr) {
  apply {
    packet.emit(hdr.ethernet);
    packet.emit(hdr.ipv4);
    packet.emit(hdr.udp);
    packet.emit(hdr.paxos);
  }
}
control verifyChecksum(in headers hdr, inout metadata meta) {
  Checksum16() ipv4_checksum;
  apply {
      if (hdr.ipv4.hdrChecksum == ipv4_checksum.get({
                                      hdr.ipv4.version,
                                      hdr.ipv4.ihl,
                                      hdr.ipv4.diffserv,
                                      hdr.ipv4.totalLen,
                                      hdr.ipv4.identification,
                                      hdr.ipv4.flags,
                                      hdr.ipv4.fragOffset,
                                      hdr.ipv4.ttl,
                                      hdr.ipv4.protocol,
                                      hdr.ipv4.srcAddr,
                                      hdr.ipv4.dstAddr
                                  }))
          mark_to_drop();
  }
}
control computeChecksum(inout headers hdr, inout metadata meta) {
  Checksum16() ipv4_checksum;
  apply {
      hdr.ipv4.hdrChecksum = ipv4_checksum.get({
                                      hdr.ipv4.version,
                                      hdr.ipv4.ihl,
                                      hdr.ipv4.diffserv,
                                      hdr.ipv4.totalLen,
                                      hdr.ipv4.identification,
                                      hdr.ipv4.flags,
                                      hdr.ipv4.fragOffset,
                                      hdr.ipv4.ttl,
                                      hdr.ipv4.protocol,
                                      hdr.ipv4.srcAddr,
                                      hdr.ipv4.dstAddr
                                  });
  }
}