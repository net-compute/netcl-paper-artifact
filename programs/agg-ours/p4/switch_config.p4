#ifndef CONFIG_P4
#define CONFIG_P4

#define FORWARDING_TABLE_CAPACITY       512
#define FLOOD_MULTICAST_GROUP_ID        1
#define ARP_TABLE_CAPACITY              32

#define ALLREDUCE_MULTICAST_GRPOUP_ID   FLOOD_MULTICAST_GROUP_ID
#define ALLREDUCE_UDP_PORT              4242
#define ALLREDUCE_WORKERS               2
#define ALLREDUCE_THREADS               32 // Leave this high for now
#define ALLREDUCE_WINDOW                32 // Leave this high for now
#define ALLREDUCE_VALUE_BYTES           4
#define ALLREDUCE_EXPONENT_BYTES        4

#define ALLREDUCE_BMP_SLOTS             (ALLREDUCE_WORKERS * ALLREDUCE_THREADS * ALLREDUCE_WINDOW)
#define ALLREDUCE_AGG_SLOTS             (ALLREDUCE_BMP_SLOTS * 2)
#define ALLREDUCE_WORKER_TABLE_CAPACITY 32

#endif