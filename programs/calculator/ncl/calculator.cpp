using namespace ncl;

enum operation { Add, Sub, And, Or, Xor };

_kernel(1) void calculator(operation op, unsigned op1, unsigned op2,
                           unsigned &res) {
  switch (op) {
  case operation::Add:
    res = op1 + op2;
    break;
  case operation::Sub:
    res = op1 - op2;
    break;
  case operation::And:
    res = op1 & op2;
    break;
  case operation::Or:
    res = op1 | op2;
    break;
  case operation::Xor:
    res = op1 ^ op2;
    break;
  default:
    return _drop();
  }
  return _reflect();
}