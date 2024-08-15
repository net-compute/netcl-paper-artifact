#define PAXOS 1
#define LEARNER 5

using namespace ncl;

enum msg_type {
  PAXOS_1A = 1 << 0,  // Phase1, leader   -> acceptor, prepare
  PAXOS_1B = 1 << 1,  // Phase1, acceptor -> leader  , already accepted a value
  PAXOS_2A = 1 << 2,  // Phase2, leader   -> acceptor, select value
  PAXOS_2B = 1 << 3,  // Phase2, acceptor -> learner,  acknowledge value
  PAXOS_REQ = 1 << 4, // Phase0, proposer -> leader,   propose value
  PAXOS_RST = 1 << 5, // Reset paxos
};

_at(LEARNER) _net_ uint32_t Value[8][65536];
_at(LEARNER) _net_ uint16_t Round[65536];

/// Paxos learner kernel. Receive votes, deliver value when majority
_at(LEARNER) _kernel(PAXOS) void learner(msg_type &type, uint32_t &instance,
                                         uint16_t round, uint16_t &vote_round,
                                         uint8_t &vote, uint32_t val[8]) {
  static uint8_t VoteHistory[65536];
  static const _lookup_ uint8_t Majority[] = {0b011, 0b101, 0b110, 0b111};

  if (type == PAXOS_2B) {
    auto prev_round = atomic_cmp_write_lte(&Round[instance], round, round);

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
