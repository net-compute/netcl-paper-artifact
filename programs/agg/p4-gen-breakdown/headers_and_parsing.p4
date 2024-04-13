header ethernet_h {
	bit<48> dst_addr;
	bit<48> src_addr;
	bit<16> eth_type;
}
header ipv4_h {
	bit<4> version;
	bit<4> ihl;
	bit<8> tos;
	bit<16> total_len;
	bit<16> identification;
	bit<3> flags;
	bit<13> frag_offset;
	bit<8> ttl;
	bit<8> protocol;
	bit<16> checksum;
	bit<32> src_addr;
	bit<32> dst_addr;
}
header udp_h {
	bit<16> src_port;
	bit<16> dst_port;
	bit<16> length;
	bit<16> checksum;
}
@ncvm("ncrt.ncp.header")
header ncp_h {
	bit<8> cid;
	bit<8> act;
	bit<16> act_arg;
	bit<8> d_src;
	bit<8> d_dst;
	bit<8> h_src;
	bit<8> h_dst;
}
@ncvm("ncrt.util.box")
header _box_h<T> {
	T value;
}
@ncvm("p4.headers.1")
struct headers {
	ethernet_h eth;
	ipv4_h ip4;
	udp_h udp;
	ncp_h ncp;
	_box_h<bit<32>>[1] ncp_data_1_0;
	_box_h<bit<8>>[1] ncp_data_1_1;
	_box_h<bit<16>>[1] ncp_data_1_2;
	_box_h<bit<16>>[1] ncp_data_1_3;
	_box_h<bit<16>>[1] ncp_data_1_4;
	_box_h<bit<32>>[1] ncp_data_1_5;
	_box_h<bit<32>>[32] ncp_data_1_6;
}
parser NCPDataParser(packet_in P,
                     inout headers H,
                     in bit<8> Compute) {
	bit<32> cnt = 0;
	@ncvm("ncrt.ncp.parser.data.1:start")
	state start {
		transition _parse_data_1_0;
	}
	state _parse_data_1_0 {
		P.extract(H.ncp_data_1_0.next);
		transition _parse_data_1_1;
	}
	state _parse_data_1_1 {
		P.extract(H.ncp_data_1_1.next);
		transition _parse_data_1_2;
	}
	state _parse_data_1_2 {
		P.extract(H.ncp_data_1_2.next);
		transition _parse_data_1_3;
	}
	state _parse_data_1_3 {
		P.extract(H.ncp_data_1_3.next);
		transition _parse_data_1_4;
	}
	state _parse_data_1_4 {
		P.extract(H.ncp_data_1_4.next);
		transition _parse_data_1_5;
	}
	state _parse_data_1_5 {
		P.extract(H.ncp_data_1_5.next);
		transition _parse_data_1_6;
	}
	state _parse_data_1_6 {
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		P.extract(H.ncp_data_1_6.next);
		transition accept;
	}
}
parser MainIngressParser(packet_in P,
                         out headers H,
                         out metadata M,
                         out ingress_intrinsic_metadata_t IIM) {
	NCPDataParser() ncp_data_parser;
	state start {
		P.extract(IIM);
		P.advance(PORT_METADATA_SIZE);
		transition select(IIM.resubmit_flag) {
			1: parse_resubmit;
			default: parse_port_metadata;
		}
	}
	state parse_resubmit {
		transition parse_ethernet;
	}
	state parse_port_metadata {
		transition parse_ethernet;
	}
	state parse_ethernet {
		P.extract(H.eth);
		transition select(H.eth.eth_type) {
			_ETH_TYPE_.IPV4: parse_ipv4;
			default: accept;
		}
	}
	state parse_ipv4 {
		P.extract(H.ip4);
		transition select(H.ip4.protocol) {
			_IP4_PROTO_.UDP: parse_udp;
			default: accept;
		}
	}
	state parse_udp {
		P.extract(H.udp);
		transition select(H.udp.dst_port) {
			_ncl_udp_port_: parse_ncp;
			default: accept;
		}
	}
	state parse_ncp {
		P.extract(H.ncp);
		transition select(H.ncp.d_dst) {
			_ncl_device_id_: parse_ncp_data;
			default: ncp_no_op;
		}
	}
	state parse_ncp_data {
		ncp_data_parser.apply(P, H, H.ncp.cid);
		transition accept;
	}
	state ncp_no_op {
		M.ncl_no_op = true;
		transition accept;
	}
}
control MainIngressDeparser(packet_out P,
                            inout headers H,
                            in metadata M,
                            in ingress_intrinsic_metadata_for_deparser_t IDM) {
	apply {
		P.emit(H);
	}
}
parser MainEgressParser(packet_in P,
                        out headers H,
                        out metadata M,
                        out egress_intrinsic_metadata_t EIM) {
	state start {
		P.extract(EIM);
		transition parse_ethernet;
	}
	state parse_ethernet {
		P.extract(H.eth);
		transition select(H.eth.eth_type) {
			_ETH_TYPE_.IPV4: parse_ipv4;
			default: accept;
		}
	}
	state parse_ipv4 {
		P.extract(H.ip4);
		transition select(H.ip4.protocol) {
			_IP4_PROTO_.UDP: parse_udp;
			default: accept;
		}
	}
	state parse_udp {
		P.extract(H.udp);
		transition select(H.udp.dst_port) {
			_ncl_udp_port_: parse_ncp;
			default: accept;
		}
	}
	state parse_ncp {
		P.extract(H.ncp);
		transition accept;
	}
}
control MainEgressDeparser(packet_out P,
                           inout headers H,
                           in metadata M,
                           in egress_intrinsic_metadata_for_deparser_t EDM) {
	Checksum() ip4_checksum;
	apply {
		H.ip4.checksum = ip4_checksum.update({H.ip4.version,H.ip4.ihl,H.ip4.tos,H.ip4.total_len,H.ip4.identification,H.ip4.flags,H.ip4.frag_offset,H.ip4.ttl,H.ip4.protocol,H.ip4.src_addr,H.ip4.dst_addr});
		P.emit(H.eth);
		P.emit(H.ip4);
		P.emit(H.udp);
		P.emit(H.ncp);
	}
}