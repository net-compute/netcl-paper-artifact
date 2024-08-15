#define PAXOS 1
#define ACCEPTORS 1, 2, 3
#define LEADER 4
#define LEARNER_GROUP 12

using namespace ncl;

enum msg_type {
  PAXOS_1A = 1 << 0,  // Phase1, leader   -> acceptor, prepare
  PAXOS_1B = 1 << 1,  // Phase1, acceptor -> leader  , already accepted a value
  PAXOS_2A = 1 << 2,  // Phase2, leader   -> acceptor, select value
  PAXOS_2B = 1 << 3,  // Phase2, acceptor -> learner,  acknowledge value
  PAXOS_REQ = 1 << 4, // Phase0, proposer -> leader,   propose value
  PAXOS_RST = 1 << 5, // Reset paxos
};

_at(ACCEPTORS) _net_ uint32_t Value[8][65536];
_at(ACCEPTORS) _net_ uint16_t Round[65536];

/// Acceptor kernel
_at(ACCEPTORS) _kernel(PAXOS) void acceptor(msg_type &type, uint32_t &instance,
                                            uint16_t round, uint16_t &vround,
                                            uint8_t &vote, uint32_t val[8]) {
  static _net_ uint16_t VRound[65536];

  if ((type & (PAXOS_1A | PAXOS_2A)) == 0)
    return _drop();
  if (atomic_cmp_write_lte(&Round[instance], round, round) > round)
    return _drop();

  vote = ((uint8_t)1) << (device.id - 1);

  if (type == PAXOS_1A) {
    // this message is sent by backup leaders only,
    // so this part is not really used at the moment
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