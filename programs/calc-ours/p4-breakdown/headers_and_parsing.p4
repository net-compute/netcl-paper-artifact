header ethernet_h {
  mac_addr_t dst_addr;
  mac_addr_t src_addr;
  eth_type_t ether_type;
}
header arp_ip4_h {
  mac_addr_t  src_hw_addr;
  ip4_addr_t  src_proto_addr;
  mac_addr_t  dst_hw_addr;
  ip4_addr_t  dst_proto_addr;
}
header ip4_h {
  bit<4>       version;
  bit<4>       ihl;
  bit<8>       diffserv;
  bit<16>      total_len;
  bit<16>      identification;
  bit<3>       flags;
  bit<13>      frag_offset;
  bit<8>       ttl;
  ip4_proto_t  protocol;
  bit<16>      hdr_checksum;
  ip4_addr_t   src_addr;
  ip4_addr_t   dst_addr;
}
header udp_h {
  bit<16> src_port;
  bit<16> dst_port;
  bit<16> length;
  bit<16> checksum;
}
header p4calc_t {
  bit<8>  p;
  bit<8>  four;
  bit<8>  ver;
  bit<8>  op;
  bit<32> operand_a;
  bit<32> operand_b;
  bit<32> res;
}
struct headers_t {
  ethernet_h   eth;
  ip4_h        ip4;
  udp_h        udp;
  p4calc_t     p4calc;
}
parser ingress_parser(packet_in P,
                      out headers_t H,
                      out metadata M,
                      out ingress_intrinsic_metadata_t IM)
{
  state start {
    P.extract(IM);
    P.advance(PORT_METADATA_SIZE);
    transition parse_ethernet;
  }

  state parse_ethernet {
    P.extract(H.eth);
    transition select(H.eth.ether_type) {
      ETH_IPV4 : parse_ip4;
       default : accept;
    }
  }

  state parse_ip4 {
    P.extract(H.ip4);
    transition select(H.ip4.protocol) {
       IP_UDP : parse_udp;
      default : accept;
    }
  }

  state parse_udp {
    P.extract(H.udp);
    transition select(H.udp.dst_port) {
      CACL_UDP_PORT: parse_calc;
           default : accept;
    }
  }

  state parse_calc {
    P.extract(H.p4calc);
    transition accept;
  }
}
control ingress_deparser( packet_out P,
                          inout headers_t H,
                          in metadata M,
                          in ingress_intrinsic_metadata_for_deparser_t DIM)
{
  Checksum() ip4_checksum;

  apply {
    if (H.p4calc.isValid()) {
      H.ip4.hdr_checksum =
        ip4_checksum.update({
          H.ip4.version,
          H.ip4.ihl,
          H.ip4.diffserv,
          H.ip4.total_len,
          H.ip4.identification,
          H.ip4.flags,
          H.ip4.frag_offset,
          H.ip4.ttl,
          H.ip4.protocol,
          H.ip4.src_addr,
          H.ip4.dst_addr
        });
    }
    P.emit(H);
  }
}
parser egress_parser( packet_in P, out headers_t H,
                      out metadata M,
                      out egress_intrinsic_metadata_t IM)
{
  state start {
    transition accept;
  }
}
control egress_deparser(packet_out P,
                        inout headers_t H,
                        in metadata M,
                        in egress_intrinsic_metadata_for_deparser_t DIM)
{
  apply {
  }
}