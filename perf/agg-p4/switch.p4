#include <core.p4>
#include <tna.p4>

#include "switch_config.p4"
#include "switch_types.p4"
#include "switch_parsers.p4"

control expo_reducer( in bitmap_t bitmap_old,
                      in bitmap_t bitmap_chk,
                      in slot_idx_t idx,
                      inout expo_t expo)
{
  Register<expo_t, slot_idx_t>(ALLREDUCE_AGG_SLOTS) R;

  RegisterAction<expo_t, slot_idx_t, expo_t>(R) write = {
    void apply(inout expo_t reg, out expo_t ret) {
      reg = expo;
      ret = reg;
    }
  };

  RegisterAction<expo_t, slot_idx_t, expo_t>(R) update = {
    void apply(inout expo_t reg, out expo_t ret) {
      reg = max(reg, expo);
      ret = reg;
    }
  };

  RegisterAction<expo_t, slot_idx_t, expo_t>(R) read = {
    void apply(inout expo_t reg, out expo_t ret) {
      ret = reg;
    }
  };

  action update_register() {
    expo = update.execute(idx);
  }

  action read_register() {
    expo = read.execute(idx);
  }

  action write_register() {
    expo = write.execute(idx);
  }

  table reduce {
    key = {
      bitmap_old: ternary;
      bitmap_chk: ternary;}
    actions = {
      update_register;
      read_register;
      write_register;
      NoAction;
    }
    const default_action = NoAction; // should never happen
    const size = 32;
    const entries = {
      (0, 0) : write_register();
      (_, 0) : update_register();
      (_, _) : read_register();
    }
  }

  apply {
    reduce.apply();
  }
}

control reducer(in bitmap_t bitmap_old,
                in bitmap_t bitmap_chk,
                in slot_idx_t idx,
                inout value_t v)
{
  Register<value_t, slot_idx_t>(ALLREDUCE_AGG_SLOTS) R;

  RegisterAction<value_t, slot_idx_t, value_t>(R) update = {
    void apply(inout value_t reg, out value_t ret) {
      reg = reg + v;
      ret = reg;
    }
  };

  RegisterAction<value_t, slot_idx_t, value_t>(R) read = {
    void apply(inout value_t reg, out value_t ret) {
      ret = reg;
    }
  };

  RegisterAction<value_t, slot_idx_t, value_t>(R) write = {
    void apply(inout value_t reg, out value_t ret) {
      reg = v;
      ret = reg;
    }
  };

  action update_register() {
    v = update.execute(idx);
  }

  action read_register() {
    v = read.execute(idx);
  }

  action write_register() {
    v = write.execute(idx);
  }

  table reduce {
    key = {
      bitmap_old: ternary;
      bitmap_chk: ternary;
    }
    actions = {
      update_register;
      read_register;
      write_register;
      NoAction;
    }
    const default_action = NoAction; // should never happen
    const size = 32;
    const entries = {
      (0, 0) : write_register();
      (_, 0) : update_register();
      (_, _) : read_register();
    }
  }

  apply { reduce.apply(); }
}

control allreduce ( inout headers_t H,
                    inout ingress_metadata_t M,
                    in ingress_intrinsic_metadata_t IM,
                    in ingress_intrinsic_metadata_from_parser_t PIM,
                    inout ingress_intrinsic_metadata_for_deparser_t DIM,
                    inout ingress_intrinsic_metadata_for_tm_t TIM )
{

  Register<pair<bitmap_t>, slot_idx_t>(ALLREDUCE_BMP_SLOTS) Bitmap;

  RegisterAction<pair<bitmap_t>, slot_idx_t, bitmap_t>(Bitmap) bitmap_record_hi = {
    void apply(inout pair<bitmap_t> reg, out bitmap_t ret) {
      ret = reg.hi;
      reg.hi = reg.hi | H.agg.mask;    // set hi
      reg.lo = reg.lo & (~H.agg.mask); // clear lo
    }
  };

  RegisterAction<pair<bitmap_t>, slot_idx_t, bitmap_t>(Bitmap) bitmap_record_lo = {
    void apply(inout pair<bitmap_t> reg, out bitmap_t ret) {
      ret = reg.lo;
      reg.hi = reg.hi & (~H.agg.mask); // clear hi
      reg.lo = reg.lo | H.agg.mask;    // set lo
    }
  };

  action bitmap_0() {
    M.agg.bitmap_old = bitmap_record_lo.execute(H.agg.bmp_idx);
  }
  action bitmap_1() {
    M.agg.bitmap_old = bitmap_record_hi.execute(H.agg.bmp_idx);
  }

  table bitmap {
    key = {
      H.agg.ver: exact;
    }
    actions = {
      bitmap_0;
      bitmap_1;
      NoAction;
    }
    const size = 2;
    const default_action = NoAction;
    const entries = {
      0: bitmap_0();
      1: bitmap_1();
    }
  }

  Register<bit<32>, slot_idx_t>(ALLREDUCE_AGG_SLOTS) Count;

  RegisterAction<bit<32>, slot_idx_t, bit<32>>(Count) update_counter = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
      if (reg == 0) {
        reg = ALLREDUCE_WORKERS - 1;
      } else {
        reg = reg - 1;
      }
    }
  };

  RegisterAction<bit<32>, slot_idx_t, bit<32>>(Count) read_counter = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      ret = reg;
    }
  };

  action count_contribution() {
    M.agg.count_old = update_counter.execute(H.agg.agg_idx);
  }
  action count_retransmission() {
    M.agg.count_old = read_counter.execute(H.agg.agg_idx);
  }

  table count {
    key = {
      M.agg.bitmap_chk: ternary;
    }
    actions = {
      count_contribution;
      count_retransmission;
      NoAction;
    }
    const size = 2;
    const default_action = NoAction;
    const entries = {
      0: count_contribution();
      _: count_retransmission();
    }
  }

  expo_reducer() RExpo;
  reducer() R00;
  reducer() R01;
  reducer() R02;
  reducer() R03;
  reducer() R04;
  reducer() R05;
  reducer() R06;
  reducer() R07;
  reducer() R08;
  reducer() R09;
  reducer() R10;
  reducer() R11;
  reducer() R12;
  reducer() R13;
  reducer() R14;
  reducer() R15;
  reducer() R16;
  reducer() R17;
  reducer() R18;
  reducer() R19;
  reducer() R20;
  reducer() R21;
  reducer() R22;
  reducer() R23;
  reducer() R24;
  reducer() R25;
  reducer() R26;
  reducer() R27;
  reducer() R28;
  reducer() R29;
  reducer() R30;
  reducer() R31;

  action next_reflect() {
    TIM.ucast_egress_port = IM.ingress_port;
    TIM.bypass_egress = 0;
    DIM.drop_ctl[0:0] = 0;
  }

  action next_multicast() {
    TIM.mcast_grp_a = ALLREDUCE_MULTICAST_GRPOUP_ID;
    TIM.bypass_egress = 0;
    DIM.drop_ctl[0:0] = 0;
  }

  action next_drop() {
    DIM.drop_ctl[0:0] = 1;
  }

  table next {
    key = {
      M.agg.bitmap_chk: ternary;
      M.agg.count_old: ternary;
    }
    actions = {
      next_reflect;
      next_multicast;
      next_drop;
      NoAction;
    }
    const default_action = NoAction;
    const entries = {
      ( 0, 0): next_drop();      // First packet for slot
      ( 0, 1): next_multicast(); // not seen and count == 1 ==> completed now
      ( _, 0): next_reflect();   //     seen and count == 0 ==> completed earlier
      ( _, _): next_drop();      // either not seen, count != 1
                                 //            seen, count != 0
    }
  }

  action check_bitmap() { M.agg.bitmap_chk = M.agg.bitmap_old & H.agg.mask; }
  apply {

    bitmap.apply();
    check_bitmap();

    count.apply();

    RExpo.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.expo);

    R00.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v00);
    R01.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v01);
    R02.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v02);
    R03.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v03);
    R04.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v04);
    R05.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v05);
    R06.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v06);
    R07.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v07);
    R08.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v08);
    R09.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v09);
    R10.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v10);
    R11.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v11);
    R12.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v12);
    R13.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v13);
    R14.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v14);
    R15.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v15);
    R16.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v16);
    R17.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v17);
    R18.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v18);
    R19.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v19);
    R20.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v20);
    R21.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v21);
    R22.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v22);
    R23.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v23);
    R24.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v24);
    R25.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v25);
    R26.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v26);
    R27.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v27);
    R28.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v28);
    R29.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v29);
    R30.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v30);
    R31.apply( M.agg.bitmap_old, M.agg.bitmap_chk, H.agg.agg_idx, H.agg_data.v31);

    next.apply();
  }
}


control networking( inout headers_t H,
                    inout ingress_metadata_t M,
                    in ingress_intrinsic_metadata_t IM,
                    in ingress_intrinsic_metadata_from_parser_t PIM,
                    inout ingress_intrinsic_metadata_for_deparser_t DIM,
                    inout ingress_intrinsic_metadata_for_tm_t TIM )
{
  action send_to_port(PortId_t port) {
    DIM.drop_ctl[0:0] = 0x0;
    TIM.ucast_egress_port = port;
  }

  action flood() {
    DIM.drop_ctl[0:0] = 0x0;
    TIM.mcast_grp_a = FLOOD_MULTICAST_GROUP_ID;
    TIM.level1_exclusion_id = (bit<16>) IM.ingress_port;
  }

  table forwarding_table {
    key = {H.eth.dst_addr: exact;}
    actions = { send_to_port; flood; }
    const default_action = flood;
    const size = FORWARDING_TABLE_CAPACITY;
  }

  action arp_resolve(mac_addr_t mac) {
    H.arp.opcode = ARP_RES;
    H.arp_ip4.dst_hw_addr = H.arp_ip4.src_hw_addr;
    H.arp_ip4.src_hw_addr = mac;
    ip4_addr_t tmp = H.arp_ip4.dst_proto_addr;
    H.arp_ip4.dst_proto_addr = H.arp_ip4.src_proto_addr;
    H.arp_ip4.src_proto_addr = tmp;
    H.eth.dst_addr = H.eth.src_addr;
    H.eth.src_addr = mac;
  }

  table arp_table {
    key = {
      H.arp_ip4.dst_proto_addr: exact;
    }
    actions = {
      arp_resolve;
      NoAction;
    }
    const default_action = NoAction;
    const size = ARP_TABLE_CAPACITY;
  }

  apply {
    TIM.bypass_egress = 1;
    if (H.arp_ip4.isValid() && H.arp.opcode == ARP_REQ) {
      arp_table.apply();
    }
    forwarding_table.apply();
  }
}


control ingress( inout headers_t H,
                 inout ingress_metadata_t M,
                 in ingress_intrinsic_metadata_t IM,
                 in ingress_intrinsic_metadata_from_parser_t PIM,
                 inout ingress_intrinsic_metadata_for_deparser_t DIM,
                 inout ingress_intrinsic_metadata_for_tm_t TIM)
{

  allreduce() agg;
  networking() net;

  apply {
    if (H.agg.isValid()) {
      agg.apply(H, M, IM, PIM, DIM, TIM);
    } else {
      net.apply(H, M, IM, PIM, DIM, TIM);
    }
  }
}

control egress( inout headers_t H,
                inout egress_metadata_t M,
                in egress_intrinsic_metadata_t IM,
                in egress_intrinsic_metadata_from_parser_t PIM,
                inout egress_intrinsic_metadata_for_deparser_t DIM,
                inout egress_intrinsic_metadata_for_output_port_t OPIM )
{

  action send_to_worker(mac_addr_t mac, ip4_addr_t ip, bitmap_t mask) {
    H.eth.src_addr = H.eth.dst_addr;
    H.eth.dst_addr = mac;
    H.ip4.src_addr = H.ip4.dst_addr;
    H.ip4.dst_addr = ip;
    H.ip4.ttl = H.ip4.ttl |-| 1;
    udp_port_t tmp = H.udp.src_port;
    H.udp.src_port = H.udp.dst_port;
    H.udp.dst_port = tmp;
    H.udp.checksum = 0;
    H.agg.mask = mask;
  }

  table allreduce_sender {
    key = {
      IM.egress_port: exact;
    }
    actions = {
      send_to_worker;
      NoAction;
    }
    size = ALLREDUCE_WORKER_TABLE_CAPACITY;
    const default_action = NoAction;
  }

  apply {
    if (H.agg.isValid()) {
      allreduce_sender.apply();
    }
  }
}

Pipeline( ingress_parser(), ingress(), ingress_deparser(),
          egress_parser(), egress(), egress_deparser()) pipe;

Switch(pipe) main;