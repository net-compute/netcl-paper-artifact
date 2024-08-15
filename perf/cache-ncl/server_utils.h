#ifndef _OPTIONS_H_
#define _OPTIONS_H_

#include "popl.h" // https://github.com/badaix/popl
#include <cstdint>
#include <iostream>
#include <mutex>
#include <ostream>
#include <string>

inline void exitWithErrorMessage(const std::string &msg) {
  std::cout << "error: " << msg << '\n';
  exit(1);
}

class log {
public:
  log(std::ostream &o = std::cout) : o(o) { buffer << "[server] "; }
  log(uint32_t tid, std::ostream &o = std::cout) : o(o) {
    buffer << "[server." << tid << "] ";
  }
  ~log() {
    std::lock_guard<std::mutex> guard(this->cout_mutex);
    o << buffer.str();
  }

  template <typename T> log &operator<<(const T &value) {
    buffer << value;
    return *this;
  }

private:
  static inline std::mutex cout_mutex;
  std::ostream &o;
  std::ostringstream buffer;
};

struct options {

private:
  popl::OptionParser parser;

public:
  bool Help;
  bool Perf;
  uint32_t Threads;
  std::string IP;
  uint16_t Port;
  std::string ServerIp;
  uint16_t ServerPort;
  std::string DeviceMac;
  std::string DeviceIp;
  uint16_t DevicePort;
  uint8_t NclID;

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
  options() {
    parser.add<popl::Switch>("h", "help", "print this help message", &Help);
    parser.add<popl::Value<std::string>>("I", "ip", "the workers's ip",
                                         "42.0.0.4", &IP);
    parser.add<popl::Value<uint16_t>>("P", "port", "base udp port", 4242,
                                      &Port);
    parser.add<popl::Value<unsigned>>("j", "threads", "number of threads", 1,
                                      &Threads);

    parser.add<popl::Value<uint8_t>>("", "id", "the NetCL id of this host", 4,
                                      &NclID);
    parser.add<popl::Switch>("", "perf", "run in performance mode", &Perf);

    parser.add<popl::Value<std::string>>("", "device-mac", "device MAC address",
                                         "42:00:00:00:00:00", &DeviceMac);
    parser.add<popl::Value<std::string>>("", "device-ip", "device IPv4 address",
                                         "42.0.0.0", &DeviceIp);
    parser.add<popl::Value<uint16_t>>("", "device-port", "device UDP port",
                                      4242, &DevicePort);
  }

  void parse(int argc, char **argv) {
    parser.parse(argc, argv);

    if (Threads == 0)
      exitWithErrorMessage("-j/--threads must be > 0");
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

static inline uint32_t DefaulRngState = 123456789;

}

inline uint32_t xorshift32(uint32_t &state = detail::DefaulRngState) {
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