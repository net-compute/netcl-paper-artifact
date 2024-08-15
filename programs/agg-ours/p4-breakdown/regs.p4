Register<expo_t, slot_idx_t>(ALLREDUCE_AGG_SLOTS) R;
Register<value_t, slot_idx_t>(ALLREDUCE_AGG_SLOTS) R;
Register<pair<bitmap_t>, slot_idx_t>(ALLREDUCE_BMP_SLOTS) Bitmap;
Register<bit<32>, slot_idx_t>(ALLREDUCE_AGG_SLOTS) Count;
