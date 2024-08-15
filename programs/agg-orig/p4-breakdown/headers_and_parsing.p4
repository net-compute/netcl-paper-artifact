header ethernet_h {
  mac_addr_t dst_addr;
  mac_addr_t src_addr;
  bit<16>    ether_type;
}

header ipv4_h {
  bit<4>        version;
  bit<4>        ihl;
  bit<8>        diffserv;
  bit<16>       total_len;
  bit<16>       identification;
  bit<3>        flags;
  bit<13>       frag_offset;
  bit<8>        ttl;
  ip_protocol_t protocol;
  bit<16>       hdr_checksum;
  ipv4_addr_t   src_addr;
  ipv4_addr_t   dst_addr;
}

header icmp_h {
  icmp_type_t msg_type;
  bit<8>      msg_code;
  bit<16>     checksum;
}

header arp_h {
  bit<16>       hw_type;
  ether_type_t  proto_type;
  bit<8>        hw_addr_len;
  bit<8>        proto_addr_len;
  arp_opcode_t  opcode;
}

header arp_ipv4_h {
  mac_addr_t   src_hw_addr;
  ipv4_addr_t  src_proto_addr;
  mac_addr_t   dst_hw_addr;
  ipv4_addr_t  dst_proto_addr;
}

header udp_h {
  bit<16> src_port;
  bit<16> dst_port;
  bit<16> length;
  bit<16> checksum;
}

// SwitchML header
header switchml_h {
  bit<4> msg_type;
  bit<1> unused;
  packet_size_t size;
  bit<8> job_number;
  bit<32> tsi;
  bit<16> pool_index;
}

// InfiniBand-RoCE Base Transport Header
// header ib_bth_h {
//     ib_opcode_t       opcode;
//     bit<1>            se;
//     bit<1>            migration_req;
//     bit<2>            pad_count;
//     bit<4>            transport_version;
//     bit<16>           partition_key;
//     bit<1>            f_res1;
//     bit<1>            b_res1;
//     bit<6>            reserved;
//     queue_pair_t      dst_qp;
//     bit<1>            ack_req;
//     bit<7>            reserved2;
//     sequence_number_t psn;
// }

// @pa_container_size("ingress", "hdr.ib_bth.psn", 32)

// // InfiniBand-RoCE RDMA Extended Transport Header
// header ib_reth_h {
//     bit<64> addr;
//     bit<32> r_key;
//     bit<32> len;
// }

// // InfiniBand-RoCE Immediate Header
// header ib_immediate_h {
//     bit<32> immediate;
// }

// // InfiniBand-RoCE ICRC Header
// header ib_icrc_h {
//     bit<32> icrc;
// }

// Exponent headers
header exponents_h {
  exponent_t e0;
  exponent_t e1;
}

// 128-byte data header
header data_h {
  value_t d00;
  value_t d01;
  value_t d02;
  value_t d03;
  value_t d04;
  value_t d05;
  value_t d06;
  value_t d07;
  value_t d08;
  value_t d09;
  value_t d10;
  value_t d11;
  value_t d12;
  value_t d13;
  value_t d14;
  value_t d15;
  value_t d16;
  value_t d17;
  value_t d18;
  value_t d19;
  value_t d20;
  value_t d21;
  value_t d22;
  value_t d23;
  value_t d24;
  value_t d25;
  value_t d26;
  value_t d27;
  value_t d28;
  value_t d29;
  value_t d30;
  value_t d31;
}

// Full header stack
struct header_t {
  ethernet_h     ethernet;
  arp_h          arp;
  arp_ipv4_h     arp_ipv4;
  ipv4_h         ipv4;
  icmp_h         icmp;
  udp_h          udp;
  switchml_h     switchml;
  exponents_h    exponents;
  // ib_bth_h       ib_bth;
  // ib_reth_h      ib_reth;
  // ib_immediate_h ib_immediate;
  // Two 128-byte data headers to support harvesting 256 bytes with recirculation
  data_h         d0;
  data_h         d1;
  ib_icrc_h      ib_icrc;
}

#include "types.p4"
#include "headers.p4"

parser IngressParser(
    packet_in pkt,
    out header_t hdr,
    out ingress_metadata_t ig_md,
    out ingress_intrinsic_metadata_t ig_intr_md) {

    Checksum() ipv4_checksum;

    state start {
        pkt.extract(ig_intr_md);
        transition select(ig_intr_md.resubmit_flag) {
            1 : parse_resubmit;
            default : parse_port_metadata;
        }
    }

    state parse_resubmit {
        // Resubmission not currently used; just skip header
        // assume recirculated packets will never be resubmitted for now
    	pkt.advance(64);
        transition parse_ethernet;
    }

    state parse_port_metadata {
        // parse port metadata
        ig_md.port_metadata = port_metadata_unpack<port_metadata_t>(pkt);

        transition select(ig_intr_md.ingress_port) {
            64: parse_recirculate; // pipe 0 CPU Eth port
            68: parse_recirculate; // pipe 0 recirc port
            320: parse_ethernet;   // pipe 2 CPU PCIe port
            0x080 &&& 0x180: parse_recirculate; // all pipe 1 ports
            0x100 &&& 0x180: parse_recirculate; // all pipe 2 ports
            0x180 &&& 0x180: parse_recirculate; // all pipe 3 ports
            default:  parse_ethernet;
        }
    }

    state parse_recirculate {
        // Parse switchml metadata
        pkt.extract(ig_md.switchml_md);
        pkt.extract(ig_md.switchml_rdma_md);

        // Now parse the rest of the packet
        transition select(ig_md.switchml_md.packet_type) {
            (packet_type_t.CONSUME0) : parse_consume;
            (packet_type_t.CONSUME1) : parse_consume;
            (packet_type_t.CONSUME2) : parse_consume;
            (packet_type_t.CONSUME3) : parse_consume;
            default : parse_harvest; // default to parsing for harvests
        }
    }

    state parse_consume {
        // Extract the next 256B values
        pkt.extract(hdr.d0);
        pkt.extract(hdr.d1);
        transition accept;
    }

    state parse_harvest {
        // One of these will be filled in by the pipeline, and the other set invalid
        hdr.d0.setValid();
        hdr.d1.setValid();
        transition accept;
    }

    state parse_ethernet {
        pkt.extract(hdr.ethernet);
        transition select(hdr.ethernet.ether_type) {
            ETHERTYPE_ARP : parse_arp;
            ETHERTYPE_IPV4 : parse_ipv4;
            default : accept_regular;
        }
    }

    state parse_arp {
        pkt.extract(hdr.arp);
        transition select(hdr.arp.hw_type, hdr.arp.proto_type) {
            (0x0001, ETHERTYPE_IPV4) : parse_arp_ipv4;
            default: accept_regular;
        }
    }

    state parse_arp_ipv4 {
        pkt.extract(hdr.arp_ipv4);
        transition accept_regular;
    }

    state parse_ipv4 {
        pkt.extract(hdr.ipv4);
        ipv4_checksum.add(hdr.ipv4);
        ig_md.checksum_err_ipv4 = ipv4_checksum.verify();
        ig_md.update_ipv4_checksum = false;

        // parse only non-fragmented IP packets with no options
        transition select(hdr.ipv4.ihl, hdr.ipv4.frag_offset, hdr.ipv4.protocol) {
            (5, 0, ip_protocol_t.ICMP) : parse_icmp;
            (5, 0, ip_protocol_t.UDP)  : parse_udp;
            default                    : accept_regular;
        }
    }

    state parse_icmp {
        pkt.extract(hdr.icmp);
        transition accept_regular;
    }

    state parse_udp {
        pkt.extract(hdr.udp);
        transition select(hdr.udp.dst_port) {
            UDP_PORT_ROCEV2                                   : parse_ib_bth;
            UDP_PORT_SWITCHML_BASE &&& UDP_PORT_SWITCHML_MASK : parse_switchml;
            default                                           : accept_regular;
        }
    }

    // state parse_ib_bth {
    //     pkt.extract(hdr.ib_bth);
    //     transition select(hdr.ib_bth.opcode) {
    //         // include only UC operations here
    //         ib_opcode_t.UC_SEND_FIRST                : parse_ib_payload;
    //         ib_opcode_t.UC_SEND_MIDDLE               : parse_ib_payload;
    //         ib_opcode_t.UC_SEND_LAST                 : parse_ib_payload;
    //         ib_opcode_t.UC_SEND_LAST_IMMEDIATE       : parse_ib_immediate;
    //         ib_opcode_t.UC_SEND_ONLY                 : parse_ib_payload;
    //         ib_opcode_t.UC_SEND_ONLY_IMMEDIATE       : parse_ib_immediate;
    //         ib_opcode_t.UC_RDMA_WRITE_FIRST          : parse_ib_reth;
    //         ib_opcode_t.UC_RDMA_WRITE_MIDDLE         : parse_ib_payload;
    //         ib_opcode_t.UC_RDMA_WRITE_LAST           : parse_ib_payload;
    //         ib_opcode_t.UC_RDMA_WRITE_LAST_IMMEDIATE : parse_ib_immediate;
    //         ib_opcode_t.UC_RDMA_WRITE_ONLY           : parse_ib_reth;
    //         ib_opcode_t.UC_RDMA_WRITE_ONLY_IMMEDIATE : parse_ib_reth_immediate;
    //         default: accept_regular;
    //     }
    // }

    // state parse_ib_immediate {
    //     pkt.extract(hdr.ib_immediate);
    //     transition parse_ib_payload;
    // }

    // state parse_ib_reth {
    //     pkt.extract(hdr.ib_reth);
    //     transition parse_ib_payload;
    // }

    // state parse_ib_reth_immediate {
    //     pkt.extract(hdr.ib_reth);
    //     pkt.extract(hdr.ib_immediate);
    //     transition parse_ib_payload;
    // }

    // state parse_ib_payload {
    //     pkt.extract(hdr.d0);
    //     pkt.extract(hdr.d1);
    //     // do NOT extract ICRC, since this might be in the middle of a >256B packet
    //     ig_md.switchml_md.setValid();
    //     ig_md.switchml_md.ether_type_msb = 16w0xffff;
    //     ig_md.switchml_md.packet_type = packet_type_t.CONSUME0;
    //     ig_md.switchml_rdma_md.setValid();
    //     transition accept;
    // }

    state parse_switchml {
        pkt.extract(hdr.switchml);
        pkt.extract(hdr.exponents);
        transition parse_values;
    }

    state parse_values {
        pkt.extract(hdr.d0);
        pkt.extract(hdr.d1);
        // At this point we know this is a SwitchML packet that wasn't recirculated,
        // so mark it for consumption
        ig_md.switchml_md.setValid();
        ig_md.switchml_md.packet_type = packet_type_t.CONSUME0;
        ig_md.switchml_rdma_md.setValid();
        transition accept;
    }

    state accept_regular {
        ig_md.switchml_md.setValid();
        ig_md.switchml_md.packet_type = packet_type_t.IGNORE;
        ig_md.switchml_rdma_md.setValid();
        transition accept;
    }
}

control IngressDeparser(
    packet_out pkt,
    inout header_t hdr,
    in ingress_metadata_t ig_md,
    in ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md) {

    Checksum() ipv4_checksum;

    apply {
        if (ig_md.update_ipv4_checksum) {
            hdr.ipv4.hdr_checksum = ipv4_checksum.update({
                    hdr.ipv4.version,
                    hdr.ipv4.ihl,
                    hdr.ipv4.diffserv,
                    hdr.ipv4.total_len,
                    hdr.ipv4.identification,
                    hdr.ipv4.flags,
                    hdr.ipv4.frag_offset,
                    hdr.ipv4.ttl,
                    hdr.ipv4.protocol,
                    hdr.ipv4.src_addr,
                    hdr.ipv4.dst_addr});
        }

        pkt.emit(ig_md.switchml_md);
        pkt.emit(ig_md.switchml_rdma_md);
        pkt.emit(hdr);
    }
}

parser EgressParser(
    packet_in pkt,
    out header_t hdr,
    out egress_metadata_t eg_md,
    out egress_intrinsic_metadata_t eg_intr_md) {

    state start {
        pkt.extract(eg_intr_md);
        // All egress packets have a bridged metadata header
        transition select(eg_intr_md.pkt_length) {
            0 : parse_switchml_md;
            _ : parse_switchml_md;
        }
    }

    state parse_switchml_md {
        pkt.extract(eg_md.switchml_md);
        transition parse_switchml_rdma_md;
    }

    state parse_switchml_rdma_md {
        pkt.extract(eg_md.switchml_rdma_md);
        transition accept;
    }
}

control EgressDeparser(
    packet_out pkt,
    inout header_t hdr,
    in egress_metadata_t eg_md,
    in egress_intrinsic_metadata_for_deparser_t eg_intr_dprs_md) {

    Checksum() ipv4_checksum;

    apply {
        if (eg_md.update_ipv4_checksum) {
            hdr.ipv4.hdr_checksum = ipv4_checksum.update({
                    hdr.ipv4.version,
                    hdr.ipv4.ihl,
                    hdr.ipv4.diffserv,
                    hdr.ipv4.total_len,
                    hdr.ipv4.identification,
                    hdr.ipv4.flags,
                    hdr.ipv4.frag_offset,
                    hdr.ipv4.ttl,
                    hdr.ipv4.protocol,
                    hdr.ipv4.src_addr,
                    hdr.ipv4.dst_addr});
        }

        pkt.emit(hdr);
    }
}
header switchml_md_h {

    MulticastGroupId_t mgid; // 16 bits

    queue_pair_index_t recirc_port_selector;

    packet_size_t packet_size;

    worker_type_t worker_type;
    worker_id_t worker_id;

    // Dest port or QPN to be used for responses
    bit<16> src_port;
    bit<16> dst_port;

    // What should we do with this packet?
    packet_type_t packet_type;

    // This needs to be 0xFFFF
    bit<16> ether_type_msb;

    // Index of pool elements, including both sets
    pool_index_t pool_index;

    // 0 if first packet, 1 if last packet
    num_workers_t first_last_flag;

    // 0 if packet is first packet; non-zero if retransmission
    worker_bitmap_t map_result;

    // Bitmap value before the current worker is ORed in
    worker_bitmap_t worker_bitmap_before;

    // TSI used to fill in switchML header (or RoCE address later)
    bit<32> tsi;
    bit<8> job_number;

    PortId_t ingress_port;

    // Egress drop flag
    // bool simulate_egress_drop;

    // Number of workers
    num_workers_t num_workers;

    // Exponents
    exponent_t e0;
    exponent_t e1;

    // Message ID
    msg_id_t msg_id;

    // First/last packet of a message
    bool first_packet;
    bool last_packet;
}