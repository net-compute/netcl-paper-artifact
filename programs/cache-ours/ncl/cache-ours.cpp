#define CACHELINE_WORDS 4
#define CACHELINE_ENTRIES 2
#define CACHE_LINES 4096

#define CACHE_SIZE CACHE_LINES *CACHELINE_ENTRIES
#define CMS_SIZE CACHE_SIZE * 2
#define CMS_BITS 14
#define BLF_SIZE CACHE_SIZE * 4
#define BLF_BITS 15
#define HH_THRESH CACHE_LINES

using namespace ncl;
using bitmap_t = uint32_t;

enum op_t : uint8_t { GET_RQ = 1, GET_RS, PUT_RQ, PUT_RS, DEL_RQ, DEL_RS, UPD_RQ, UPD_RS };

_net_ uint32_t Cache[CACHELINE_WORDS][CACHE_LINES];
_managed_ bool Valid0[CACHE_LINES];
_managed_ bool Valid1[CACHE_LINES];
_managed_ uint32_t Stats0[CACHE_LINES];
_managed_ uint32_t Stats1[CACHE_LINES];

_managed_ _lookup_ ncl_kv<uint64_t, uint16_t> Index[CACHE_LINES];
_managed_ _lookup_ ncl_kv<uint64_t, bitmap_t> Bitmap[CACHE_SIZE];
_managed_ uint32_t c0[CMS_SIZE];
_managed_ uint32_t c1[CMS_SIZE];
_managed_ uint32_t c2[CMS_SIZE];
_managed_ uint32_t c3[CMS_SIZE];
_managed_ bool b0[BLF_SIZE];
_managed_ bool b1[BLF_SIZE];
_managed_ bool b2[BLF_SIZE];

_net_ void read_value(uint32_t cacheline, bitmap_t bitmap, uint32_t *val) {
  for (auto i = 0; i < CACHELINE_WORDS; ++i)
    val[i] = atomic_cond_read_or(&Cache[i][cacheline], bit_chk(bitmap, i), 0);
}

_net_ void write_value(uint32_t cacheline, bitmap_t bitmap, uint32_t *val) {
  for (auto i = 0; i < CACHELINE_WORDS; ++i)
    atomic_cond_write(&Cache[i][cacheline], bit_chk(bitmap, i), val[i]);
}

_net_ void set_validity(uint32_t cacheline, bitmap_t bitmap, bool v) {
  atomic_cond_write(&Valid0[cacheline], bit_chk(bitmap, 0), v);
  atomic_cond_write(&Valid1[cacheline], !bit_chk(bitmap, 0), v);
}

_net_ void stats(uint32_t cacheline, bitmap_t bitmap) {
  atomic_cond_sadd(&Stats0[cacheline], bit_chk(bitmap, 0), 1);
  atomic_cond_sadd(&Stats1[cacheline], !bit_chk(bitmap, 0), 1);
}

_net_ void heavy_hitter(uint64_t key, bool &hot) {
  uint32_t cms[4];
  cms[0] = atomic_sadd_new(&c0[tna::crc16<CMS_BITS>(key)], 1);
  cms[1] = atomic_sadd_new(&c1[tna::crc32<CMS_BITS>(key)], 1);
  cms[2] = atomic_sadd_new(&c2[tna::crc64<CMS_BITS>(key)], 1);
  cms[3] = atomic_sadd_new(&c3[tna::xor16<CMS_BITS>(key)], 1);

  auto min_count = cms[0];
  for (uint8_t i = 0; i < 4; ++i)
    min_count = cms[i] < min_count ? cms[i] : min_count;

  if (min_count > HH_THRESH) {
    auto a = atomic_write(&b0[tna::xor32<BLF_BITS>(key)], true);
    auto b = atomic_write(&b1[tna::crc32<BLF_BITS>(key)], true);
    auto c = atomic_write(&b2[tna::crc64<BLF_BITS>(key)], true);
    hot = !(a && b && c); // not recently reported
  }
}

_kernel(1) void query(uint64_t key, uint32_t val[CACHELINE_WORDS],
                      op_t &op, bitmap_t &mask, bool &hot) {
  uint16_t cacheline;
  bitmap_t bitmap;
  lookup(Index, key, cacheline);
  if (lookup(Bitmap, key, bitmap)) {
    switch (op) {
    default:
      return _drop();
    case PUT_RQ:
    case DEL_RQ:
      set_validity(cacheline, bitmap, false);
      break;
    case GET_RQ:
      if (bit_chk<0>(bitmap) ? Valid0[cacheline] : Valid1[cacheline]) {
        read_value(cacheline, bitmap, val);
        stats(cacheline, bitmap);
        op = GET_RS;
        mask = bitmap;
        return _reflect();
      }
      break;
    // This only comes from the server/controller
    case UPD_RQ:
      op = UPD_RS;
      set_validity(cacheline, bitmap, true);
      write_value(cacheline, bitmap, val);
      return _reflect();
    }
  } else {
    if (op == GET_RQ)
      heavy_hitter(key, hot);
  }
}