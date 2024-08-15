#ifndef TYPES_P4
#define TYPES_P4

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
// ARP
// -----------------------------------------
typedef bit<16> arp_opcode_t;

const bit<16> ARP_HTYPE_ETH = 0x0001;
const bit<16> ARP_PTYPE_IP4 = ETH_IPV4;
const arp_opcode_t ARP_REQ = 1;
const arp_opcode_t ARP_RES = 2;
header arp_h {
  bit<16>      hw_type;
  eth_type_t   proto_type;
  bit<8>       hw_addr_len;
  bit<8>       proto_addr_len;
  arp_opcode_t opcode;
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

// -----------------------------------------
// Cache
// -----------------------------------------

typedef bit<8> op_t;
typedef bit<64> key_t;
typedef bit<32> val_frag_t;
typedef bit<32> bitmap_t;
typedef bit<8> hot_t;
typedef bit<32> count_;
typedef bit<32> idx_t;

struct pair<T> { T hi; T lo; }

header cache_h {
  key_t k;
  val_frag_t v1;
  val_frag_t v2;
  val_frag_t v3;
  val_frag_t v4;
  op_t op;
  bitmap_t mask;
  hot_t hot;
}

struct headers_t {
  ethernet_h eth;
  arp_h      arp;
  arp_ip4_h  arp_ip4;
  ip4_h      ip4;
  udp_h      udp;
  cache_h    cache;
}

struct ingress_metadata_t { }

struct egress_metadata_t { }

#endif