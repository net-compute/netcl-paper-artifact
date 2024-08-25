#include <core.p4>
#include <tna.p4>

const bit<16> LEN_ETH = 14 * 8;
const bit<16> LEN_IP4 = 20 * 8;
const bit<16> LEN_UDP =  8 * 8;

// -----------------------------------------
// ETH
// -----------------------------------------
typedef bit<48> mac_addr_t;
typedef bit<16> eth_type_t;

const eth_type_t ETH_IPV4   = 16w0x0800;
const eth_type_t ETH_ARP    = 16w0x0806;

header ethernet_h {
  mac_addr_t dst_addr;
  mac_addr_t src_addr;
  eth_type_t ether_type;
}

// -----------------------------------------
// IPv4
// -----------------------------------------
typedef bit<32> ip4_addr_t;
typedef bit<8>  ip4_proto_t;

header arp_ip4_h {
  mac_addr_t  src_hw_addr;
  ip4_addr_t  src_proto_addr;
  mac_addr_t  dst_hw_addr;
  ip4_addr_t  dst_proto_addr;
}

const ip4_proto_t IP_ICMP   = 1;
const ip4_proto_t IP_UDP    = 17;
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

// -----------------------------------------
// UDP
// -----------------------------------------
typedef bit<16> udp_port_t;

header udp_h {
  bit<16> src_port;
  bit<16> dst_port;
  bit<16> length;
  bit<16> checksum;
}

const bit<16> P4CALC_ETYPE = 0x1234;
const bit<8>  P4CALC_P     = 0x50;   // 'P'
const bit<8>  P4CALC_4     = 0x34;   // '4'
const bit<8>  P4CALC_VER   = 0x01;   // v0.1
const bit<8>  P4CALC_PLUS  = 0x2b;   // '+'
const bit<8>  P4CALC_MINUS = 0x2d;   // '-'
const bit<8>  P4CALC_AND   = 0x26;   // '&'
const bit<8>  P4CALC_OR    = 0x7c;   // '|'
const bit<8>  P4CALC_CARET = 0x5e;   // '^'

header p4calc_t {
  bit<8>  p;
  bit<8>  four;
  bit<8>  ver;
  bit<8>  op;
  bit<32> operand_a;
  bit<32> operand_b;
  bit<32> res;
}

const bit<16> CACL_UDP_PORT = 4242;

struct headers_t {
  ethernet_h   eth;
  ip4_h        ip4;
  udp_h        udp;
  p4calc_t     p4calc;
}

struct metadata { }

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

control ingress( inout headers_t H,
                 inout metadata M,
                 in ingress_intrinsic_metadata_t IM,
                 in ingress_intrinsic_metadata_from_parser_t PIM,
                 inout ingress_intrinsic_metadata_for_deparser_t DIM,
                 inout ingress_intrinsic_metadata_for_tm_t TIM)
{

  action send_back(bit<32> result) {
    bit<48> tmp;
    bit<32> tmp2;
    bit<16> tmp3;

    /* Put the result back in */
    H.p4calc.res = result;

    /* Swap the MAC addresses */
    tmp = H.eth.dst_addr;
    H.eth.dst_addr = H.eth.src_addr;
    H.eth.src_addr = tmp;

    /* Swap the IP addresses */
    tmp2 = H.ip4.dst_addr;
    H.ip4.dst_addr = H.ip4.src_addr;
    H.ip4.src_addr = tmp2;

    /* Swap UDP ports */
    tmp3 = H.udp.dst_port;
    H.udp.dst_port = H.udp.src_port;
    H.udp.src_port = tmp3;

    /* Disable UDP checksum */
    H.udp.checksum = 0;

    /* Send the packet back to the port it came from */
    TIM.ucast_egress_port = IM.ingress_port;
    DIM.drop_ctl[0:0] = 0;
  }

  action operation_add() {
    send_back(H.p4calc.operand_a + H.p4calc.operand_b);
  }

  action operation_sub() {
    send_back(H.p4calc.operand_a - H.p4calc.operand_b);
  }

  action operation_and() {
    send_back(H.p4calc.operand_a & H.p4calc.operand_b);
  }

  action operation_or() {
    send_back(H.p4calc.operand_a | H.p4calc.operand_b);
  }

  action operation_xor() {
    send_back(H.p4calc.operand_a ^ H.p4calc.operand_b);
  }

  action operation_drop() {
    DIM.drop_ctl[0:0] = 1;
  }

  table calculate {
    key = {
      H.p4calc.op        : exact;
    }
    actions = {
      operation_add;
      operation_sub;
      operation_and;
      operation_or;
      operation_xor;
      operation_drop;
    }
    const default_action = operation_drop();
    const size = 5;
    const entries = {
      P4CALC_PLUS : operation_add();
      P4CALC_MINUS: operation_sub();
      P4CALC_AND  : operation_and();
      P4CALC_OR   : operation_or();
      P4CALC_CARET: operation_xor();
    }
  }

  apply {
    if (H.p4calc.isValid()) {
      calculate.apply();
    } else {
      operation_drop();
    }
  }
}


control egress( inout headers_t H,
                inout metadata M,
                in egress_intrinsic_metadata_t IM,
                in egress_intrinsic_metadata_from_parser_t PIM,
                inout egress_intrinsic_metadata_for_deparser_t DIM,
                inout egress_intrinsic_metadata_for_output_port_t OPIM )
{
  apply { }
}


Pipeline( ingress_parser(), ingress(), ingress_deparser(),
          egress_parser(), egress(), egress_deparser()) pipe;

Switch(pipe) main;