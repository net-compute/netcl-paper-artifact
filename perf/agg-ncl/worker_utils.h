#ifndef _OPTIONS_H_
#define _OPTIONS_H_

#include "popl.h" // https://github.com/badaix/popl
#include <cstdint>
#include <iostream>
#include <ostream>
#include <string>

inline void exitWithErrorMessage(const std::string &msg) {
  std::cout << "error: " << msg << '\n';
  exit(1);
}

struct options {

private:
  popl::OptionParser parser;

public:
  bool Help;
  bool Perf;
  bool Random;
  bool Pin;
  std::string IP;
  uint16_t Port;
  unsigned Steps;
  unsigned Warmup;
  unsigned Rank;
  unsigned World;
  unsigned Threads;
  unsigned Window;
  unsigned Multiplier;
  bool SIMD = false;
  std::string DeviceMac;
  std::string DeviceIp;
  uint16_t DevicePort;
#if defined(__AVX2__)
  bool AVX2Available = true;
#else
  bool AVX2Available = false;
#endif
#if defined(__AVX512F__)
  bool AVX512Available = true;
#else
  bool AVX512Available = false;
#endif

public:
  uint32_t Reducers;
  uint32_t Size;
  uint32_t Slots;
  uint32_t Aggregators;
  uint32_t ValuesPerPacket;
  uint32_t ValuesPerThread;
  uint32_t PacketsPerThread;

private:
  std::string _deviceMacStr;
  std::string _deviceIpStr;

public:
  options() {
    parser.add<popl::Switch>("h", "help", "print this help message", &Help);
    parser.add<popl::Value<unsigned>>("R", "rank", "the worker's rank", 1,
                                      &Rank);
    parser.add<popl::Value<unsigned>>("W", "world", "number of workers", 2,
                                      &World);
    parser.add<popl::Value<std::string>>("I", "ip", "the workers's ip",
                                         "42.0.0.0", &IP);
    parser.add<popl::Value<uint16_t>>("P", "port", "base udp port", 4242,
                                      &Port);
    parser.add<popl::Switch>("", "random", "Generate random data", &Random);
    parser.add<popl::Value<unsigned>>("j", "threads", "number of threads", 1,
                                      &Threads);
    parser.add<popl::Value<unsigned>>("w", "window", "per threads burst window",
                                      1, &Window);
    parser.add<popl::Value<unsigned>>("s", "steps", "number of steps to run", 1,
                                      &Steps);

    parser.add<popl::Value<unsigned>>("", "warmup", "number of warmup steps", 0,
                                      &Warmup);
    parser.add<popl::Value<unsigned>>("", "starting-version",
                                      "override default starting version", 0,
                                      &Multiplier);
    parser.add<popl::Switch>("", "--random", "Generate random values");
    parser.add<popl::Value<unsigned>>("m", "multiplier",
                                      "multiply the vector size by this value",
                                      1, &Multiplier);
    parser.add<popl::Switch>("", "perf", "run in performance mode", &Perf);

    parser.add<popl::Value<std::string>>("", "device-mac", "device MAC address",
                                         "42:00:00:00:00:00", &DeviceMac);
    parser.add<popl::Value<std::string>>("", "device-ip", "device IPv4 address",
                                         "42.0.0.0", &DeviceIp);
    parser.add<popl::Value<uint16_t>>("", "device-port", "device UDP port",
                                      4242, &DevicePort);
    parser.add<popl::Switch>("", "simd", "use SIMD whenever possible", &SIMD);
    parser.add<popl::Switch>("", "pin", "ping threads to CPU cores", &Pin);
  }

  void parse(int argc, char **argv) {
    parser.parse(argc, argv);

    if (Rank == 0)
      exitWithErrorMessage("-R/--rank must be > 0");
    if (World == 0)
      exitWithErrorMessage("-W/--world must be > 0");
    if (Threads == 0)
      exitWithErrorMessage("-j/--threads must be > 0");
    if (Window == 0)
      exitWithErrorMessage("-w/--window must be > 0");
    if (Steps == 0)
      exitWithErrorMessage("-s/--steps must be > 0");
    if (Multiplier == 0)
      exitWithErrorMessage("--multiplier must be > 0");

    Reducers = 32;
    Slots = Threads * Window;
    Aggregators = Slots * 2;
    ValuesPerPacket = Reducers;
    Size = Threads * Window * ValuesPerPacket * Multiplier;
    ValuesPerThread = Size / Threads;
    PacketsPerThread = Size / Threads / ValuesPerPacket;
  }

  int help(std::ostream &o = std::cout) {
    o << this->parser;
    return 0;
  }
};

inline std::string vec2str(uint32_t *v, size_t size, size_t n = 8) {
  std::ostringstream oss;
  for (auto i = 0; i < n; ++i) {
    if (i == size)
      break;
    if (i > 0)
      oss << ',';
    oss << v[i];
  }
  return oss.str();
}

namespace detail {

static inline uint32_t DefaultState = 123456789;

}

inline uint32_t xorshift32(uint32_t &state = detail::DefaultState) {
  state ^= state << 13;
  state ^= state >> 17;
  state ^= state << 5;
  return state;
};

inline uint32_t xorshift32(uint32_t state) {
  state ^= state << 13;
  state ^= state >> 17;
  state ^= state << 5;
  return state;
};

#endif