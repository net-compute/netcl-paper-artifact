#define NUM_WORKERS 4
#define COMPLETE_BITMAP 0xFFFFFFFF >> (32 - NUM_WORKERS)
#define WORKERS_PER_THREAD 1
#define NUM_SLOTS NUM_WORKERS * WORKERS_PER_THREAD
#define SLOT_SIZE 32

using namespace ncl;

_net_ uint32_t Agg[SLOT_SIZE][NUM_SLOTS * 2];
_net_ uint16_t Bitmap[2][NUM_SLOTS];
_net_ uint32_t Count[NUM_SLOTS * 2];
_net_ uint32_t Expo[NUM_SLOTS * 2];

_kernel(1) void allreduce(uint32_t offset, uint8_t ver, uint16_t bitmap_slot,
                          uint16_t slot, uint16_t mask, uint32_t &expo,
                          uint32_t values[SLOT_SIZE]) {
  uint16_t bitmap;
  if (ver == 0) {
    bitmap = atomic_or(&Bitmap[0][bitmap_slot], mask); // Add bit to set-0
    atomic_and(&Bitmap[1][bitmap_slot], ~mask);        // Remove bit from set-1
  } else {
    atomic_and(&Bitmap[0][bitmap_slot], ~mask);        // Remove bit from set-0
    bitmap = atomic_or(&Bitmap[1][bitmap_slot], mask); // Add bit to set-1
  }

  if (bitmap == 0) { // first packet for slot ==> Agg = values
    Count[slot] = NUM_WORKERS - 1;
    Expo[slot] = expo;
    for (int i = 0; i < SLOT_SIZE; ++i)
      Agg[i][slot] = values[i];
  } else {
    uint16_t seen = bitmap & mask;
    uint16_t fini = bitmap | mask;
    expo = atomic_cond_max_new(&Expo[slot], !seen, expo);
    for (int i = 0; i < SLOT_SIZE; ++i)
      values[i] = atomic_cond_add_new(&Agg[i][slot], !seen, values[i]);

    if (!atomic_cond_dec(&Count[slot], !seen)) // slot finished
      return _reflect();
    if (fini == COMPLETE_BITMAP)
      return _multicast(42);
  }
}