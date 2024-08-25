#include <core.p4>
#include <tna.p4>

#include "switch_config.p4"
#include "switch_types.p4"
#include "switch_parsers.p4"

#define CACHELINE_WORDS 4
#define CACHELINE_ENTRIES 2
#define CACHE_LINES 4096
#define CACHE_SIZE CACHE_LINES *CACHELINE_ENTRIES
#define CMS_SIZE CACHE_SIZE * 2
#define CMS_BITS 14
#define BLF_SIZE CACHE_SIZE * 4
#define BLF_BITS 15
#define HH_THRESH CACHE_LINES

const op_t GET_RQ = 1;
const op_t GET_RS = 2;
const op_t PUT_RQ = 3;
const op_t PUT_RS = 4;
const op_t DEL_RQ = 5;
const op_t DEL_RS = 6;
const op_t UPD_RQ = 5;
const op_t UPD_RS = 7;

control heavy_hitter ( inout headers_t H)  {
  Hash<bit<32>>(HashAlgorithm_t.CRC16) cms_hash_1;
  Hash<bit<32>>(HashAlgorithm_t.CRC32) cms_hash_2;
  Hash<bit<32>>(HashAlgorithm_t.CRC64) cms_hash_3;
  Hash<bit<32>>(HashAlgorithm_t.XOR16) cms_hash_4;
  Register<bit<32>, bit<32>>(CMS_SIZE) cms1;
  Register<bit<32>, bit<32>>(CMS_SIZE) cms2;
  Register<bit<32>, bit<32>>(CMS_SIZE) cms3;
  Register<bit<32>, bit<32>>(CMS_SIZE) cms4;
  RegisterAction<bit<32>, bit<32>, bit<32>>(cms1) sketch1 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = reg |+| 1;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(cms2) sketch2 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = reg |+| 1;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(cms3) sketch3 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = reg |+| 1;
      ret = reg;
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(cms4) sketch4 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = reg |+| 1;
      ret = reg;
    }
  };
  bit<32> c1idx;
  bit<32> c2idx;
  bit<32> c3idx;
  bit<32> c4idx;
  bit<32> c1;
  bit<32> c2;
  bit<32> c3;
  bit<32> c4;
  action compute_cms_idx_1() {
    c1idx = cms_hash_1.get({H.cache.k});
  }
  action compute_cms_idx_2() {
    c2idx = cms_hash_2.get({H.cache.k});
  }
  action compute_cms_idx_3() {
    c3idx = cms_hash_3.get({H.cache.k});
  }
  action compute_cms_idx_4() {
    c4idx = cms_hash_4.get({H.cache.k});
  }

  Hash<bit<32>>(HashAlgorithm_t.XOR32) bh1;
  Hash<bit<32>>(HashAlgorithm_t.CRC32) bh2;
  Hash<bit<32>>(HashAlgorithm_t.CRC64) bh3;
  Register<bit<8>, bit<32>>(BLF_SIZE) bf1;
  Register<bit<8>, bit<32>>(BLF_SIZE) bf2;
  Register<bit<8>, bit<32>>(BLF_SIZE) bf3;
  RegisterAction<bit<8>, bit<32>, bit<8>>(bf1) filter1 = {
    void apply(inout bit<8> reg, out bit<8> ret) {
      ret = reg;
      reg = 1;
    }
  };
  RegisterAction<bit<8>, bit<32>, bit<8>>(bf2) filter2 = {
    void apply(inout bit<8> reg, out bit<8> ret) {
      ret = reg;
      reg = 1;
    }
  };
  RegisterAction<bit<8>, bit<32>, bit<8>>(bf3) filter3 = {
    void apply(inout bit<8> reg, out bit<8> ret) {
      ret = reg;
      reg = 1;
    }
  };
  bit<32> bidx1;
  bit<32> bidx2;
  bit<32> bidx3;
  bit<8> b1;
  bit<8> b2;
  bit<8> b3;
  action compute_bf_idx_1() {
    bidx1 = bh1.get({H.cache.k});
  }
  action compute_bf_idx_2() {
    bidx2 = bh2.get({H.cache.k});
  }
  action compute_bf_idx_3() {
    bidx3 = bh3.get({H.cache.k});
  }

  bit<32> cond1;
  bit<32> cond2;
  bit<32> cond3;
  bit<32> cond4;
  action compute_cond_1() {
    cond1 = HH_THRESH - c1;
  }
  action compute_cond_2() {
    cond2 = HH_THRESH - c2;
  }
  action compute_cond_3() {
    cond3 = HH_THRESH - c3;
  }
  action compute_cond_4() {
    cond4 = HH_THRESH - c4;
  }
  action hot() {
    H.cache.hot = 1;
  }
  action cold() {
    H.cache.hot = 0;
  }
  table check {
    key = {
      b1: ternary;
      b2: exact;
      b3: exact;
    }
    actions = {
      hot;
      cold;
    }
    const default_action = cold;
    const size = 1;
    const entries = {
      (1, 1, 1) : hot;
    }
  }
  apply {
    compute_cms_idx_1();
    compute_cms_idx_2();
    compute_cms_idx_3();
    compute_cms_idx_4();
    c1 = sketch1.execute(c1idx);
    c2 = sketch2.execute(c2idx);
    c3 = sketch3.execute(c3idx);
    c4 = sketch4.execute(c4idx);
    compute_cond_1();
    compute_cond_2();
    compute_cond_3();
    compute_cond_4();
    if (cond1[31:31] == 1) {
      if (cond2[31:31] == 1) {
        if (cond3[31:31] == 1) {
          if (cond4[31:31] == 1) {
            compute_bf_idx_1();
            compute_bf_idx_2();
            compute_bf_idx_3();
            b1 = filter1.execute(bidx1);
            b2 = filter2.execute(bidx2);
            b3 = filter3.execute(bidx3);
            check.apply();
          }
        }
      }
    }
  }
}

control netcache ( inout headers_t H,
                inout ingress_metadata_t M,
                in ingress_intrinsic_metadata_t IM,
                in ingress_intrinsic_metadata_from_parser_t PIM,
                inout ingress_intrinsic_metadata_for_deparser_t DIM,
                inout ingress_intrinsic_metadata_for_tm_t TIM ) {
  idx_t idx = 0;
  bit<8> valid = 0;
  heavy_hitter() hh;

  action read_idx(idx_t i) {
    idx = i;
  }
  table index {
    key = {
      H.cache.k: exact;
    }
    actions = {
      read_idx;
      NoAction;
    }
    default_action = NoAction;
    size = CACHE_SIZE;
  }

  action read_mask(bitmap_t mask) {
    H.cache.mask = mask;
  }
  table mask {
    key = {
      H.cache.k: exact;
    }
    actions = {
      read_mask;
      NoAction;
    }
    default_action = NoAction;
    size = CACHE_SIZE;
  }

  Register<pair<bit<8>>, bit<32>>(CACHE_LINES) Valid;
  RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_set_valid = {
    void apply(inout pair<bit<8>> reg, out bit<8> ret) {
      if (H.cache.mask[0:0] == 1) {
        reg.lo= 1;
      } else {
        reg.hi = 1;
      }
    }
  };
  RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_set_invalid = {
    void apply(inout pair<bit<8>> reg, out bit<8> ret) {
      if (H.cache.mask[0:0] == 1) {
        reg.lo= 0;
      } else {
        reg.hi = 0;
      }
    }
  };
  RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_read_lo = {
    void apply(inout pair<bit<8>> reg, out bit<8> ret) {
      ret = reg.lo;
    }
  };
  RegisterAction<pair<bit<8>>, bit<32>, bit<8>>(Valid) reg_valid_read_hi = {
    void apply(inout pair<bit<8>> reg, out bit<8> ret) {
      ret = reg.hi;
    }
  };

  action read_valid_lo() {
    valid = reg_valid_read_lo.execute(idx);
  }
  action read_valid_hi() {
    valid = reg_valid_read_hi.execute(idx);
  }
  action set_valid() {
    valid = reg_valid_set_valid.execute(idx);
  }
  action set_invalid() {
    valid = reg_valid_set_invalid.execute(idx);
  }

  table chk_valid {
    key = {
      H.cache.mask: ternary;
    }
    actions = {
      read_valid_lo;
      read_valid_hi;
    }
    const entries = {
      1 &&& 1 : read_valid_lo();
            _ : read_valid_hi();
    }
  }

  Register<pair<bit<32>>, bit<32>>(CACHE_LINES) stats;
  RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_update = {
    void apply(inout pair<bit<32>> reg, out bit<32> ret) {
      if ( H.cache.mask[0:0] == 1) {
        reg.lo = reg.lo |+| 1;
      } else {
        reg.hi = reg.hi |+| 1;
      }
    }
  };
  RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_reset = {
    void apply(inout pair<bit<32>> reg, out bit<32> ret) {
      if ( H.cache.mask[0:0] == 1) {
        reg.lo = 0;
      } else {
        reg.hi = 0;
      }
    }
  };
  RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_read_lo = {
    void apply(inout pair<bit<32>> reg, out bit<32> ret) {
      ret = reg.lo;
    }
  };
  RegisterAction<pair<bit<32>>, bit<32>, bit<32>>(stats) reg_stats_read_hi = {
    void apply(inout pair<bit<32>> reg, out bit<32> ret) {
      ret = reg.hi;
    }
  };

  Register<bit<32>, bit<32>>(CACHE_LINES) Cache1;
  Register<bit<32>, bit<32>>(CACHE_LINES) Cache2;
  Register<bit<32>, bit<32>>(CACHE_LINES) Cache3;
  Register<bit<32>, bit<32>>(CACHE_LINES) Cache4;
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache1) read_cache_1 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if ((bool) H.cache.mask[0:0]) {
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache2) read_cache_2 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if ((bool) H.cache.mask[1:1]) {
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache3) read_cache_3 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if ((bool) H.cache.mask[2:2]) {
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache4) read_cache_4 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      if ((bool) H.cache.mask[3:3]) {
        ret = reg;
      }
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache1) write_cache_1 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = H.cache.v1;
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache2) write_cache_2 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = H.cache.v2;
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache3) write_cache_3 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = H.cache.v3;
    }
  };
  RegisterAction<bit<32>, bit<32>, bit<32>>(Cache4) write_cache_4 = {
    void apply(inout bit<32> reg, out bit<32> ret) {
      reg = H.cache.v4;
    }
  };

  action read_cache_1_action() {
    H.cache.v1 = read_cache_1.execute(idx);
  }
  action read_cache_2_action() {
    H.cache.v2 = read_cache_2.execute(idx);
  }
  action read_cache_3_action() {
    H.cache.v3 = read_cache_3.execute(idx);
  }
  action read_cache_4_action() {
    H.cache.v4 = read_cache_4.execute(idx);
  }
  action write_cache_1_action() {
    write_cache_1.execute(idx);
  }
  action write_cache_2_action() {
    write_cache_2.execute(idx);
  }
  action write_cache_3_action() {
    write_cache_3.execute(idx);
  }
  action write_cache_4_action() {
    write_cache_4.execute(idx);
  }

  bit<1> isvalid;

  action reflect() {
    mac_addr_t tmp = H.eth.src_addr;
    H.eth.src_addr = H.eth.dst_addr;
    H.eth.dst_addr = tmp;

    ip4_addr_t tmp2 = H.ip4.src_addr;
    H.ip4.src_addr = H.ip4.dst_addr;
    H.ip4.dst_addr = tmp2;

    udp_port_t tmp3 = H.udp.src_port;
    H.udp.src_port = H.udp.dst_port;
    H.udp.dst_port = tmp3;

    H.udp.checksum = 0;
  }

  apply {
    mask.apply();
    if (index.apply().hit) {
      if ( H.cache.op == GET_RQ) {
        chk_valid.apply();
        if (valid == 1) {

          read_cache_1_action();
          read_cache_2_action();
          read_cache_3_action();
          read_cache_4_action();

          reg_stats_update.execute(idx);

          H.cache.op = GET_RS;
          reflect(); // reflect to client
        }
      } else if (H.cache.op == PUT_RQ || H.cache.op == DEL_RQ) {
        // Put and del only invalidate the cache,
        // The server may follow with UPD_RQ or update the cache
        // from the control plane
        set_invalid();

      } else if (H.cache.op == UPD_RQ) {
        // This is only coming from the server
        set_valid();

        if (H.cache.mask[0:0] == 1)
          write_cache_1_action();
        if (H.cache.mask[1:1] == 1)
          write_cache_2_action();
        if (H.cache.mask[2:2] == 1)
          write_cache_3_action();
        if (H.cache.mask[3:3] == 1)
          write_cache_4_action();

        reg_stats_reset.execute(idx);

        H.cache.op = UPD_RS;
        reflect(); // reflect to server
      }
    } else if ( H.cache.op == GET_RQ) {
      // On a miss, count statistics fot GET_RQ
      hh.apply(H);
    }
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
    key = {
      H.eth.dst_addr: exact;
    }
    actions = {
      send_to_port;
      flood;
    }
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

  netcache() cache;
  networking() net;

  apply {
    if (H.cache.isValid())
      cache.apply(H, M, IM, PIM, DIM, TIM);
    net.apply(H, M, IM, PIM, DIM, TIM);
  }
}

control egress( inout headers_t H,
                inout egress_metadata_t M,
                in egress_intrinsic_metadata_t IM,
                in egress_intrinsic_metadata_from_parser_t PIM,
                inout egress_intrinsic_metadata_for_deparser_t DIM,
                inout egress_intrinsic_metadata_for_output_port_t OPIM )
{
  apply {}
}


Pipeline( ingress_parser(), ingress(), ingress_deparser(),
          egress_parser(), egress(), egress_deparser()) pipe;

Switch(pipe) main;