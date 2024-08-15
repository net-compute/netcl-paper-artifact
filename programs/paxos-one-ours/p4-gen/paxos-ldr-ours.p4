// code generated by NCC v0.1.0
// target: tna
// location: 4
// source-file: 
#include <core.p4>
#include <tna.p4>

#define __NCVM__
#define __NCL_LOCATION__ 4
#define __NCL_TARGET_TOFINO__
#define __NCL_TARGET_TOFINO_TNA__
#define __NCL_TARGET_NAME__ "tna"

enum ncl_error_t {
	nclSuccess,
	nclError,
	nclErrorNoComputation,
	nclErrorUnknownComputation,
	nclErrorInsufficientPackingInput,
	nclErrorInsufficientUnpackingOutput}
typedef bit<48> mac_addr_t;
typedef bit<16> eth_type_t;
const eth_type_t ETH_IPV4 = 2048;
const eth_type_t ETH_ARP = 2054;
const eth_type_t ETH_ROCEv1 = 35093;
header ethernet_h {
	bit<48> dst_addr;
	bit<48> src_addr;
	bit<16> eth_type;
}
typedef bit<16> arp_opcode_t;
const bit<16> ARP_HTYPE_ETH = 1;
const bit<16> ARP_PTYPE_IP4 = ETH_IPV4;
const arp_opcode_t ARP_REQ = 1;
const arp_opcode_t ARP_RES = 2;
header arp_h {
	bit<16> hw_type;
	eth_type_t proto_type;
	bit<8> hw_addr_len;
	bit<8> proto_addr_len;
	arp_opcode_t opcode;
}
typedef bit<32> ip4_addr_t;
typedef bit<8> ip4_proto_t;
header arp_ip4_h {
	mac_addr_t src_hw_addr;
	ip4_addr_t src_proto_addr;
	mac_addr_t dst_hw_addr;
	ip4_addr_t dst_proto_addr;
}
const ip4_proto_t IP_ICMP = 1;
const ip4_proto_t IP_UDP = 17;
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
	bit<8> h_src;
	bit<8> h_dst;
	bit<8> d_src;
	bit<8> d_dst;
	bit<8> cid;
	bit<8> act;
	bit<16> act_arg;
}
@ncvm("ncrt.util.box")
header _box_h<T> {
	T value;
}
@ncvm("p4.headers.1")
struct headers {
	ethernet_h eth;
	arp_h arp;
	arp_ip4_h arp_ip4;
	ipv4_h ip4;
	udp_h udp;
	ncp_h ncp;
	_box_h<bit<32>>[1] ncp_data_1_0;
	_box_h<bit<32>>[1] ncp_data_1_1;
	_box_h<bit<16>>[1] ncp_data_1_2;
	_box_h<bit<16>>[1] ncp_data_1_3;
	_box_h<bit<8>>[1] ncp_data_1_4;
	_box_h<bit<32>>[8] ncp_data_1_5;
}
@ncvm("p4.metadata.1")
struct metadata {
	@field_list(0x42) @ncvm("p4.metadata.1:iter")
	bit<32> ncl_iter;
	@ncvm("p4.metadata.1:act")
	bit<8> ncl_act;
	@ncvm("p4.metadata.1:act_arg")
	bit<16> ncl_act_arg;
	bool ncl_sender_is_host;
	bool ncl_no_op;
	bool ncl_next_is_neighbour;
	bool ip4_checksum_verification;
}
const bit<8> _ncl_action_none_ = 0;
const bit<8> _ncl_action_pass_ = 1;
const bit<8> _ncl_action_drop_ = 3;
const bit<8> _ncl_action_repeat_ = 4;
const bit<8> _ncl_action_reflect_ = 5;
const bit<8> _ncl_action_reflect_long_ = 6;
const bit<8> _ncl_action_send_to_host_ = 7;
const bit<8> _ncl_action_send_to_device_ = 8;
const bit<8> _ncl_action_multicast_ = 9;
const bit<8> _ncl_action_multicast_long_ = 16;
const bit<8> _ncl_device_kind_unknown_ = 0;
const bit<8> _ncl_device_kind_switch_ = 1;
const bit<8> _ncl_device_kind_nic_ = 2;
const bit<8> _ncl_device_id_unknown_ = 0;
@ncvm("ncrt.const.device.id")const bit<8> _ncl_device_id_ = 4;
@ncvm("ncrt.const.device.kind")const bit<8> _ncl_device_kind_ = _ncl_device_kind_switch_;
@ncvm("ncrt.const.action.default")const bit<8> _ncl_default_action_ = _ncl_action_pass_;
@ncvm("ncrt.const.action.default_arg")const bit<16> _ncl_default_action_arg_ = 0;
@ncvm("ncrt.const.action.error")const bit<8> _ncl_error_action_ = _ncl_action_drop_;
@ncvm("ncrt.const.action.error_arg")const bit<16> _ncl_error_action_arg_ = 0;
@ncvm("ncrt.const.ip.4.addr")const bit<32> _ncl_ip4_addr_ = 707406378;
@ncvm("ncrt.const.udp.port")const bit<16> _ncl_udp_port_ = 4242;
@ncvm("ncrt.const.udp.port.hi")const bit<16> _ncl_udp_port_hi_ = 4242;
@ncvm("ncrt.const.multicast.default_gid")const bit<16> _ncl_multicast_group_default_ = 0;
@ncvm("ncrt.const.host.multicast.use_implicit_source_addr")const bool _ncl_host_multicast_implicit_src_ = false;
@ncvm("ncrt.const.host.reflect.use_implicit_source_addr")const bool _ncl_host_reflect_implicit_src_ = false;
@ncvm("ncrt.const.host.loop.use_implicit_source_addr")const bool _ncl_host_loop_implicit_src_ = false;
@ncvm("ncrt.const.use_implicit_ip4_src_addr")const bool _ncl_use_implicit_ip4_src_addr_ = ((_ncl_host_multicast_implicit_src_ || _ncl_host_reflect_implicit_src_) || _ncl_host_loop_implicit_src_);
action ncl_lookup_read_u8(out bit<8> val,  bit<8> value) {val = value; }
action ncl_lookup_read_u16(out bit<16> val,  bit<16> value) {val = value; }
action ncl_lookup_read_u32(out bit<32> val,  bit<32> value) {val = value; }
action ncl_lookup_read_u64(out bit<64> val,  bit<64> value) {val = value; }
action ncl_lookup_read_none() { }
@ncvm("ncrt.action.default")
action ncvm_action_default(in headers H, inout metadata M) {if ((_ncl_default_action_ == _ncl_action_pass_)) {
	M.ncl_act = _ncl_action_send_to_host_;
}
else {
	M.ncl_act = _ncl_action_drop_;
} }
@ncvm("ncrt.action.drop")
action ncvm_action_drop(inout metadata M) {
	M.ncl_act = _ncl_action_drop_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.pass")
action ncvm_action_pass(inout metadata M) {
	M.ncl_act = _ncl_action_pass_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.send_to_host")
action ncvm_action_send_to_host(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_send_to_host_;
	M.ncl_act_arg = ID;
}
@ncvm("ncrt.action.send_to_device")
action ncvm_action_send_to_device(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_send_to_device_;
	M.ncl_act_arg = ID;
}
@ncvm("ncrt.action.reflect")
action ncvm_action_reflect(inout metadata M) {
	M.ncl_act = _ncl_action_reflect_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.reflect_long")
action ncvm_action_reflect_long(inout metadata M) {
	M.ncl_act = _ncl_action_reflect_long_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.action.multicast")
action ncvm_action_multicast(inout metadata M, in bit<16> ID) {
	M.ncl_act = _ncl_action_multicast_;
	M.ncl_act_arg = ID;
}
@ncvm("ncrt.action.multicast")
action ncvm_action_repeat(inout metadata M) {
	M.ncl_act = _ncl_action_repeat_;
	M.ncl_act_arg = _ncl_default_action_arg_;
}
@ncvm("ncrt.ncp.parser.data.1")
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
		P.extract(H.ncp_data_1_5.next);
		P.extract(H.ncp_data_1_5.next);
		P.extract(H.ncp_data_1_5.next);
		P.extract(H.ncp_data_1_5.next);
		P.extract(H.ncp_data_1_5.next);
		P.extract(H.ncp_data_1_5.next);
		P.extract(H.ncp_data_1_5.next);
		transition accept;
	}
}

@ncvm("p4.parser.1")
parser MainIngressParser(packet_in P,
                         out headers H,
                         out metadata M,
                         out ingress_intrinsic_metadata_t IIM) {
	Checksum() ip_checksum;
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
			ETH_IPV4: parse_ipv4;
			ETH_ARP: parse_arp;
			default: accept;
		}
	}
	state parse_arp {
		P.extract(H.arp);
		transition select(H.arp.hw_type,H.arp.proto_type) {
			{ARP_HTYPE_ETH,ARP_PTYPE_IP4}: parse_arp_ip4;
			default: accept;
		}
	}
	state parse_arp_ip4 {
		P.extract(H.arp_ip4);
		transition accept;
	}
	state parse_ipv4 {
		P.extract(H.ip4);
		ip_checksum.add(H.ip4);
		M.ip4_checksum_verification = ip_checksum.verify();
		transition select(H.ip4.ihl,H.ip4.protocol) {
			{5,IP_UDP}: parse_udp;
			default: accept;
		}
	}
	state parse_udp {
		P.extract(H.udp);
		transition select(H.udp.dst_port) {
			_ncl_udp_port_ .. _ncl_udp_port_hi_: parse_ncp;
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

@ncvm("p4.deparser.1")
control MainIngressDeparser(packet_out P,
                            inout headers H,
                            in metadata M,
                            in ingress_intrinsic_metadata_for_deparser_t DIM) {
	apply {
		P.emit(H);
	}
}

action ncvm_swi_tbl_0_action_0() { }
action ncvm_swi_tbl_0_action_1() { }
action ncvm_swi_tbl_0_action_default() { }
@ncvm("main.1")
control ncl_compute(inout headers H,
                    inout metadata M,
                    in ingress_intrinsic_metadata_t IM) {
	bit<8> _lv__0_ncvm_scf_pred_var_0 = 0;
	@name(".ncvm.mem.net._ZZ6leaderR8msg_typeRjtRtRhPjE8Instance")
	@hidden
	Register<bit<32>, bit<8>>(1) _mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance;
	bit<32> ncvm_swi_tbl_key_0;
	table ncvm_swi_tbl_0 {
		key = { ncvm_swi_tbl_key_0 : exact; }
		actions = {ncvm_swi_tbl_0_action_0; ncvm_swi_tbl_0_action_1; ncvm_swi_tbl_0_action_default; }
		const default_action = ncvm_swi_tbl_0_action_default();
		const size = 2;
		const entries = {
			16 : ncvm_swi_tbl_0_action_0;
			32 : ncvm_swi_tbl_0_action_1;
		}
	}
	RegisterAction<bit<32>, bit<8>, bit<32>>(_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance) __ra__ncvm_atomic_write_u32_0_0_0_e_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = ((bit<32>) R);
			R = 0;
		}
	};
	RegisterAction<bit<32>, bit<8>, bit<32>>(_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance) __ra__ncvm_atomic_add_u32_1_1_0_e_0_ = {
		void apply(inout bit<32> R, out bit<32> O){
			O = R;
			R = (R + 1);
		}
	};
	action mem_rmw_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(in bit<8> i) {	__ra__ncvm_atomic_write_u32_0_0_0_e_0_.execute(i); }
	action mem_rmw_o_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(out bit<32> o, in bit<8> i) {	o = __ra__ncvm_atomic_add_u32_1_1_0_e_0_.execute(i); }
	apply {
		ncvm_swi_tbl_key_0 = H.ncp_data_1_0[0].value;
		switch (ncvm_swi_tbl_0.apply().action_run) {
			ncvm_swi_tbl_0_action_default : { _lv__0_ncvm_scf_pred_var_0 = 0; }
			ncvm_swi_tbl_0_action_0 : {
				H.ncp_data_1_0[0].value = 4;
				mem_rmw_o_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(H.ncp_data_1_1[0].value, 0);
				ncvm_action_multicast(M, 11);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_1 : {
				mem_rmw_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(0);
				_lv__0_ncvm_scf_pred_var_0 = 0;
			}
		}
		if ((_lv__0_ncvm_scf_pred_var_0 == 1)) { }
		else {
			ncvm_action_drop(M);
		}
		return;
	}
}

control ncl_network(inout headers H,
                    inout metadata M,
                    in ingress_intrinsic_metadata_t IM,
                    inout ingress_intrinsic_metadata_for_deparser_t DIM,
                    inout ingress_intrinsic_metadata_for_tm_t TIM) {
	action ncl_forward_host( PortId_t port) {
		H.ncp.act = M.ncl_act;
		H.ncp.act_arg = M.ncl_act_arg;
		H.ncp.d_src = _ncl_device_id_;
		H.ncp.d_dst = 0;
		TIM.ucast_egress_port = port;
	}
	action ncl_forward_device( PortId_t port) {
		H.ncp.act = M.ncl_act;
		H.ncp.act_arg = M.ncl_act_arg;
		H.ncp.d_src = _ncl_device_id_;
		H.ncp.d_dst = ((bit<8>) M.ncl_act_arg);
		TIM.ucast_egress_port = port;
	}
	action ncl_reflect_host() {
		H.ncp.act = M.ncl_act;
		H.ncp.act_arg = M.ncl_act_arg;
		H.ncp.d_src = _ncl_device_id_;
		H.ncp.h_dst = H.ncp.h_src;
		TIM.ucast_egress_port = IM.ingress_port;
	}
	action ncl_reflect_device() {
		H.ncp.act = M.ncl_act;
		H.ncp.act_arg = M.ncl_act_arg;
		bit<8> tmp = H.ncp.d_src;
		H.ncp.d_src = _ncl_device_id_;
		H.ncp.d_dst = tmp;
		TIM.ucast_egress_port = IM.ingress_port;
	}
	action ncl_multicast( MulticastGroupId_t mgid) {
		H.ncp.act = M.ncl_act;
		H.ncp.act_arg = M.ncl_act_arg;
		TIM.mcast_grp_a = mgid;
	}
	action ncl_drop() {	DIM.drop_ctl = 1; }
	action ncl_repeat() { }
	@name(".ncrt.ingress.tbl.forward.reflect")
	table ncl_forward_reflect_tbl {
		key = { H.ncp.d_src : exact; }
		actions = {ncl_reflect_host; ncl_reflect_device; ncl_drop; }
		default_action = ncl_reflect_device();
		size = 256;
		const entries = {
			0 : ncl_reflect_host();
		}
	}
	@name(".ncrt.ingress.tbl.forward.host")
	table ncl_forward_host_tbl {
		key = { M.ncl_act_arg : exact; }
		actions = {ncl_forward_host; ncl_drop; }
		default_action = ncl_drop();
		size = 256;
	}
	@name(".ncrt.ingress.tbl.forward.device")
	table ncl_forward_device_tbl {
		key = { M.ncl_act_arg : exact; }
		actions = {ncl_forward_device; ncl_drop; }
		default_action = ncl_drop();
		size = 256;
	}
	@name(".ncrt.ingress.tbl.forward.multicast")
	table ncl_forward_multicast_tbl {
		key = { M.ncl_act_arg : exact; }
		actions = {ncl_multicast; ncl_drop; }
		default_action = ncl_drop();
		size = 256;
	}
	apply {
		if ((M.ncl_act == _ncl_action_multicast_)) {
			ncl_forward_multicast_tbl.apply();
		}
		else
			if ((M.ncl_act == _ncl_action_repeat_)) {
				ncl_repeat();
			}
			else
				if ((M.ncl_act == _ncl_action_reflect_)) {
					ncl_forward_reflect_tbl.apply();
				}
				else
					if ((M.ncl_act == _ncl_action_send_to_device_)) {
						ncl_forward_device_tbl.apply();
					}
					else {
						ncl_forward_host_tbl.apply();
					}
	}
}

control network(inout headers H,
                inout metadata M,
                in ingress_intrinsic_metadata_t IM,
                inout ingress_intrinsic_metadata_for_deparser_t DIM,
                inout ingress_intrinsic_metadata_for_tm_t TIM) {
	action reflect() {
		mac_addr_t tmp = H.eth.dst_addr;
		H.eth.dst_addr = H.eth.src_addr;
		H.eth.src_addr = tmp;
		DIM.drop_ctl = 0;
		TIM.bypass_egress = 1;
	}
	action forward( PortId_t port) {
		DIM.drop_ctl = 0;
		TIM.ucast_egress_port = port;
		TIM.bypass_egress = 1;
	}
	action drop() {	DIM.drop_ctl[0:0] = 1; }
	action multicast( MulticastGroupId_t mgid) {
		TIM.mcast_grp_a = mgid;
		TIM.level1_exclusion_id = ((bit<16>) IM.ingress_port);
		TIM.bypass_egress = 1;
		DIM.drop_ctl[0:0] = 0;
	}
	table forwarding_table {
		key = { H.eth.dst_addr : exact; }
		actions = {forward; multicast; drop; NoAction; }
		default_action = NoAction;
		size = 1024;
	}
	action arp_resolve( mac_addr_t mac) {
		H.arp.opcode = ARP_RES;
		H.arp_ip4.dst_hw_addr = H.arp_ip4.src_hw_addr;
		H.arp_ip4.src_hw_addr = mac;
		ip4_addr_t tmp1 = H.arp_ip4.dst_proto_addr;
		H.arp_ip4.dst_proto_addr = H.arp_ip4.src_proto_addr;
		H.arp_ip4.src_proto_addr = tmp1;
		H.eth.dst_addr = H.eth.src_addr;
		H.eth.src_addr = mac;
	}
	table arp_table {
		key = { H.arp_ip4.dst_proto_addr : exact; }
		actions = {multicast; arp_resolve; NoAction; }
		default_action = NoAction;
		size = 1024;
	}
	apply {
		if ((H.arp_ip4.isValid() && (H.arp.opcode == ARP_REQ)))
			arp_table.apply();
		forwarding_table.apply();
	}
}

@ncvm("p4.main.1")
control MainIngress(inout headers H,
                    inout metadata M,
                    in ingress_intrinsic_metadata_t IM,
                    in ingress_intrinsic_metadata_from_parser_t PIM,
                    inout ingress_intrinsic_metadata_for_deparser_t DIM,
                    inout ingress_intrinsic_metadata_for_tm_t TIM) {
	network() net;
	apply {
		if (H.ncp.isValid()) {
			M.ncl_act_arg = ((bit<16>) H.ncp.h_dst);
			if (!M.ncl_no_op) {
				ncvm_action_default(H, M);
				ncl_compute.apply(H, M, IM);
			}
			ncl_network.apply(H, M, IM, DIM, TIM);
		}
		else {
			net.apply(H, M, IM, DIM, TIM);
		}
	}
}

@ncvm("p4.parser.2")
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
			ETH_IPV4: parse_ipv4;
			default: accept;
		}
	}
	state parse_ipv4 {
		P.extract(H.ip4);
		transition select(H.ip4.protocol) {
			IP_UDP: parse_udp;
			default: accept;
		}
	}
	state parse_udp {
		P.extract(H.udp);
		transition select(H.udp.dst_port) {
			_ncl_udp_port_ .. _ncl_udp_port_hi_: parse_ncp;
			default: accept;
		}
	}
	state parse_ncp {
		P.extract(H.ncp);
		transition accept;
	}
}

@ncvm("p4.deparser.2")
control MainEgressDeparser(packet_out P,
                           inout headers H,
                           in metadata M,
                           in egress_intrinsic_metadata_for_deparser_t EDM) {
	Checksum() ip4_checksum;
	apply {
		H.ip4.checksum = ip4_checksum.update({H.ip4.version,H.ip4.ihl,H.ip4.tos,H.ip4.total_len,H.ip4.identification,H.ip4.flags,H.ip4.frag_offset,H.ip4.ttl,H.ip4.protocol,H.ip4.src_addr,H.ip4.dst_addr});
		P.emit(H);
	}
}

action ncl_use_implicit_ip4_src_addr(inout headers H) {if (_ncl_use_implicit_ip4_src_addr_)
	H.ip4.src_addr = _ncl_ip4_addr_; }
@ncvm("p4.main.2")
control MainEgress(inout headers H,
                   inout metadata M,
                   in egress_intrinsic_metadata_t EM,
                   in egress_intrinsic_metadata_from_parser_t EPM,
                   inout egress_intrinsic_metadata_for_deparser_t EDM,
                   inout egress_intrinsic_metadata_for_output_port_t EPOM) {
	action drop() {	EDM.drop_ctl = 1; }
	action host_port( bit<8> id,  bit<32> ip,  bit<48> mac,  bool neighbor) {
		if (neighbor) {
			H.ncp.h_dst = id;
			H.ncp.d_dst = 0;
		}
		H.eth.src_addr = H.eth.dst_addr;
		H.eth.dst_addr = mac;
		H.ip4.dst_addr = ip;
		H.ip4.ttl = (H.ip4.ttl - 1);
		H.udp.checksum = 0;
	}
	action device_port( bit<8> id) {	H.ncp.d_dst = id; }
	@name(".ncrt.egress.tbl.ports")
	table ncl_port_tbl {
		key = { EM.egress_port : exact; }
		actions = {host_port; device_port; drop; }
		default_action = drop();
		size = 256;
	}
	action udp_ports_swap() {
		bit<16> tmp = H.udp.dst_port;
		H.udp.dst_port = H.udp.src_port;
		H.udp.src_port = tmp;
	}
	action udp_ports_mod( bit<16> src_port,  bit<16> dst_port) {
		if ((src_port != 0))
			H.udp.src_port = src_port;
		if ((dst_port != 0))
			H.udp.dst_port = dst_port;
	}
	action udp_ports_are_ncl_and( bit<16> dst_port) {
		H.udp.src_port = _ncl_udp_port_;
		if ((dst_port != 0))
			H.udp.dst_port = dst_port;
	}
	action udp_ports_are_dst_and( bit<16> dst_port) {
		H.udp.src_port = H.udp.dst_port;
		if ((dst_port != 0))
			H.udp.dst_port = dst_port;
	}
	@name(".ncrt.egress.tbl.udp.adj")
	table ncl_udp_adj_tbl {
		key = {
			H.ncp.cid: exact;
			H.ncp.act: exact;
			H.ncp.h_dst: exact;
		}
		actions = {udp_ports_swap; udp_ports_mod; udp_ports_are_ncl_and; udp_ports_are_dst_and; NoAction; }
		default_action = NoAction();
		size = 512;
	}
	apply {
		if (H.ncp.isValid()) {
			if ((H.ncp.act == _ncl_action_repeat_)) { }
			else {
				ncl_port_tbl.apply();
				ncl_udp_adj_tbl.apply();
				if ((((H.ncp.act == _ncl_action_multicast_) || (H.ncp.act == _ncl_action_multicast_long_)) || (H.ip4.src_addr == H.ip4.dst_addr)))
					ncl_use_implicit_ip4_src_addr(H);
			}
		}
	}
}

Pipeline(MainIngressParser(), MainIngress(), MainIngressDeparser(), MainEgressParser(), MainEgress(), MainEgressDeparser()) pipe;
Switch(pipe) main;
