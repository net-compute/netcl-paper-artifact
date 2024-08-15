header ethernet_h {
  mac_addr_t dst_addr;
  mac_addr_t src_addr;
  eth_type_t ether_type;
}
header arp_h {
  bit<16>      hw_type;
  eth_type_t   proto_type;
  bit<8>       hw_addr_len;
  bit<8>       proto_addr_len;
  arp_opcode_t opcode;
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
header agg_h {
  slot_ver_t ver;
  slot_idx_t bmp_idx;
  slot_idx_t agg_idx;
  bitmap_t mask;
  offset_t offset;
}
header agg_data_h {
  expo_t expo;
  value_t v00;
  value_t v01;
  value_t v02;
  value_t v03;
  value_t v04;
  value_t v05;
  value_t v06;
  value_t v07;
  value_t v08;
  value_t v09;
  value_t v10;
  value_t v11;
  value_t v12;
  value_t v13;
  value_t v14;
  value_t v15;
  value_t v16;
  value_t v17;
  value_t v18;
  value_t v19;
  value_t v20;
  value_t v21;
  value_t v22;
  value_t v23;
  value_t v24;
  value_t v25;
  value_t v26;
  value_t v27;
  value_t v28;
  value_t v29;
  value_t v30;
  value_t v31;
}
struct headers_t {
  ethernet_h eth;
  arp_h      arp;
  arp_ip4_h  arp_ip4;
  ip4_h      ip4;
  udp_h      udp;
  agg_h      agg;
  agg_data_h agg_data;
}
parser ingress_parser(packet_in P,
                      out headers_t H,
                      out ingress_metadata_t M,
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
      ETH_ARP  : parse_arp;
      ETH_IPV4 : parse_ip4;
       default : accept;
    }
  }

  state parse_arp {
    P.extract(H.arp);
    transition select(H.arp.hw_type, H.arp.proto_type) {
      (ARP_HTYPE_ETH, ARP_PTYPE_IP4) : parse_arp_ip4;
                             default : accept;
    }
  }

  state parse_arp_ip4 {
    P.extract(H.arp_ip4);
    transition accept;
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
      ALLREDUCE_UDP_PORT : parse_agg;
                 default : accept;
    }
  }

  state parse_agg {
    P.extract(H.agg);
    P.extract(H.agg_data);
    transition accept;
  }
}
control ingress_deparser( packet_out P,
                          inout headers_t H,
                          in ingress_metadata_t M,
                          in ingress_intrinsic_metadata_for_deparser_t DIM)
{
  apply {
    P.emit(H);
  }
}
parser egress_parser( packet_in P, out headers_t H,
                      out egress_metadata_t M,
                      out egress_intrinsic_metadata_t IM)
{
  state start {
    P.extract(IM);
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
      ALLREDUCE_UDP_PORT : parse_agg;
                 default : accept;
    }
  }

  state parse_agg {
    P.extract(H.agg);
    transition accept;
  }
}
control egress_deparser(packet_out P,
                        inout headers_t H,
                        in egress_metadata_t M,
                        in egress_intrinsic_metadata_for_deparser_t DIM)
{

  Checksum() ip4_checksum;

  apply {
    if (H.agg.isValid()) {
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
