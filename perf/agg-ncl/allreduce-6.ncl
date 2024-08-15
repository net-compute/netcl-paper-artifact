#define NUM_WORKERS        6
#define THREADS_PER_WORKER 64
#define WINDOW             256
#define NUM_SLOTS          THREADS_PER_WORKER * WINDOW
#define SLOT_SIZE          32

using namespace ncl;

_net_ uint32_t Expo[NUM_SLOTS * 2];
_net_ uint32_t Count[NUM_SLOTS * 2];
_net_ uint32_t Bitmap[2][NUM_SLOTS];
_net_ uint32_t Agg[SLOT_SIZE][NUM_SLOTS * 2];

_kernel(1) void allreduce(uint8_t ver, uint16_t bmp_idx, uint16_t agg_idx,
                          uint32_t mask, uint32_t offset, uint32_t &expo,
                          uint32_t values[SLOT_SIZE]) {
  uint32_t bitmap;

  if (ver == 0) {
    bitmap = atomic_or(&Bitmap[0][bmp_idx], mask); // Add bit to set-0
    atomic_and(&Bitmap[1][bmp_idx], ~mask);        // Remove bit from set-1
  } else {
    atomic_and(&Bitmap[0][bmp_idx], ~mask);        // Remove bit from set-0
    bitmap = atomic_or(&Bitmap[1][bmp_idx], mask); // Add bit to set-1
  }

  if (bitmap == 0) { // first packet for slot ==> Agg = values
    Expo[agg_idx] = expo;
    for (int i = 0; i < SLOT_SIZE; ++i)
      Agg[i][agg_idx] = values[i];
    Count[agg_idx] = NUM_WORKERS - 1;
  } else {
    uint32_t seen = bitmap & mask;
    // uint32_t fini = bitmap | mask;

    expo = atomic_cond_max_new(&Expo[agg_idx], !seen, expo);

    for (int i = 0; i < SLOT_SIZE; ++i)
      values[i] = atomic_cond_add_new(&Agg[i][agg_idx], !seen, values[i]);

    // if (!atomic_cond_dec(&Count[agg_idx], !seen)) // slot finished
    //   return _reflect();
    // if (fini == COMPLETE_BITMAP)
    //   return _multicast(42);
    auto cnt = atomic_cond_dec(&Count[agg_idx], !seen);
    if (cnt == 0)
      return _reflect();
    if (cnt == 1)
      return _multicast(42);
  }
}