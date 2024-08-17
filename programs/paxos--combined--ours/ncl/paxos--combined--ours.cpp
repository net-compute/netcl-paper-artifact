#define PAXOS 1
#define LEADER 4
#define ACCEPTORS 1, 2, 3
#define LEARNERS 5
#define LEARNER_GROUP 12
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

_at(ACCEPTORS, LEARNERS) _net_ uint32_t Value[8][65536];
_at(ACCEPTORS, LEARNERS) _net_ uint16_t Round[65536];

/// Acceptor kernel
_at(ACCEPTORS) _kernel(PAXOS) void acceptor(msg_type &type, uint32_t &instance,
                                            uint16_t round, uint16_t &vround,
                                            uint8_t &vote, uint32_t val[8]) {

  // static because if we write all kernels in 1 file
  // only the acceptor needs to access VRound
  static _net_ uint16_t VRound[65536];

  if ((type & (PAXOS_1A | PAXOS_2A)) == 0)
    return _drop();

  // do not handle old rounds
  if (atomic_max_new(&Round[instance], round) == round) {

    vote = ((uint8_t)1) << (device.id - 1);

    if (type == PAXOS_1A) {
      type = PAXOS_1B;
      vround = VRound[instance];
      for (auto i = 0; i < 8; ++i)
        val[i] = Value[i][instance];
      return _send_to_device(LEADER);

    } else {
      // Acknowledge value
      type = PAXOS_2B;
      VRound[instance] = round;
      for (auto i = 0; i < 8; ++i)
        Value[i][instance] = val[i];
      return _multicast(LEARNER_GROUP);
    }
  }
}

/// Paxos learner kernel. Receive votes, deliver value when majority
_at(LEARNERS) _kernel(PAXOS) void learner(msg_type &type, uint32_t &instance,
                                         uint16_t round, uint16_t &vote_round,
                                         uint8_t &vote, uint32_t val[8]) {
  static uint8_t VoteHistory[65536];
  static const _lookup_ uint8_t Majority[] = {0b011, 0b101, 0b110, 0b111};

  if (type == PAXOS_2B) {
    auto prev_round = atomic_max(&Round[instance], round);

    uint8_t votes;

    if (round < prev_round)
      return _drop(); // lower round => drop

    for (auto i = 0; i < 8; ++i)
      Value[i][instance] = val[i];

    if (round > prev_round)
      votes = atomic_write(&VoteHistory[instance], vote);
    else
      votes = atomic_or(&VoteHistory[instance], vote);

    if (votes & vote)
      return _drop();
    if (!lookup(Majority, votes | vote))
      return _drop();
  }
}