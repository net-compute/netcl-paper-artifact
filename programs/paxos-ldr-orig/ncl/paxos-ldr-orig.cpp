#define PAXOS 1
#define LEADER 4
#define ACCEPTOR_GROUP 11

using namespace ncl;

enum msg_type {
  PAXOS_1A = 1 << 0,  // Phase1, leader   -> acceptor, prepare
  PAXOS_1B = 1 << 1,  // Phase1, acceptor -> leader  , already accepted a value
  PAXOS_2A = 1 << 2,  // Phase2, leader   -> acceptor, select value
  PAXOS_2B = 1 << 3,  // Phase2, acceptor -> learner,  acknowledge value
  PAXOS_REQ = 1 << 4, // Phase0, proposer -> leader,   propose value
  PAXOS_RST = 1 << 5, // Reset paxos
};

// Paxos (primary) leader kernel. Backup leader(s) need not be switch(es)
// Optimization: primary leader does not need to perforn Phase1 before
// submitting a value (pp. 5)
_at(LEADER) _kernel(PAXOS) void leader(msg_type &type, uint32_t &instance,
                                       uint16_t round, uint16_t &vround,
                                       uint8_t &vote, uint32_t val[8]) {
  static _net_ uint32_t Instance;
  if (type == PAXOS_REQ) { // incr. instannce
    type = PAXOS_2A;
    round = 0;
    instance = atomic_add(&Instance, 1);
    return _multicast(ACCEPTOR_GROUP);
  }
  if (type == PAXOS_RST)
    Instance = 0;
  return _drop();
}