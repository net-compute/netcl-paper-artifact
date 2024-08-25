#include <core.p4>
#include <tna.p4>
#include "headers.p4"
#include "parsers.p4"

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

control egress( inout headers hdr,
                inout metadata m,
                in egress_intrinsic_metadata_t im,
                in egress_intrinsic_metadata_from_parser_t pim,
                inout egress_intrinsic_metadata_for_deparser_t dim,
                inout egress_intrinsic_metadata_for_output_port_t opim ) {

  table place_holder_table {
    actions = {
      NoAction;
    }
    size = 2;
    default_action = NoAction();
  }
  apply {
    place_holder_table.apply();
  }
}

Pipeline(ingress_parser(), ingress(), ingress_deparser(),
         egress_parser(), egress(), egress_deparser()) pipe;

Switch(pipe) main;