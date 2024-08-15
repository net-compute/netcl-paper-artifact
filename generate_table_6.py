import os
import sys
import subprocess
from util import cc

INPUTS_DIR = 'programs'
NCLANG = os.path.abspath(os.environ['NCLANG']) if 'NCLANG' in os.environ else \
    os.path.join(os.path.abspath('~'), "nclang-0.1.0", "build", "bin", "nclang")

if not os.path.exists(NCLANG):
    print("error: NetCL compiler (nclang) not found.")
    sys.exit(1)

ir_kernel_prefix = "define dso_local void"
ir_kernels = {
          "agg-orig": "@_Z9allreducejhtttRjPj",
          "agg-ours": "@_Z9allreducejhtttRjPj",
        "cache-orig": "@_Z5queryR4op_tmPjRjRbS2_b",
        "cache-ours": "@_Z5queryR4op_tmPjRjRbS2_b",
         "calc-orig": "@_Z10calculator9operationjjRj",
         "calc-ours": "@_Z10calculator9operationjjRj",
    "paxos-acc-orig": "@_Z8acceptorR8msg_typeRjtRtRhPj",
    "paxos-acc-ours": "@_Z8acceptorR8msg_typeRjtRtRhPj",
    "paxos-ldr-orig": "@_Z6leaderR8msg_typeRjtRtRhPj",
    "paxos-ldr-ours": "@_Z6leaderR8msg_typeRjtRtRhPj",
    "paxos-lrn-orig": "@_Z7learnerR8msg_typeRjtRtRhPj",
    "paxos-lrn-ours": "@_Z7learnerR8msg_typeRjtRtRhPj"
}


p4_netcl_main_annotation = '@ncvm("main.1")'

def count_allocas(program, ll):
    intty = {'i1': 1, 'i8': 8, 'i16': 16, 'i32': 32, 'i64': 64}

    num, bits = 0, 0

    with open(ll, 'r') as f:
        lines = f.read().splitlines()
        prefix = ir_kernel_prefix + ' ' + ir_kernels[program]
        for i in range(len(lines)):
            if lines[i].startswith(prefix):
                for l in lines[i:]:
                    if l.startswith('}'):
                        break
                    toks = l.split()
                    idx = toks.index('alloca') if 'alloca' in toks else -1
                    if idx >= 0:
                        if toks[idx + 1].startswith('i'):
                            num += 1
                            bits += intty[toks[idx + 1].split(',')[0]] if toks[idx + 1].endswith(',') else intty[toks[idx + 1]]
                        elif toks[idx + 1].startswith('['):
                            num += 1
                            bits += int(toks[idx + 1].split('[')[1]) * intty[toks[idx + 3].split(']')[0]]
                        else:
                            print("cannot handle alloca:", l)
                break
    return num, bits


def count_locvars(program, p4):
    num, bits = 0, 0
    with open(p4, 'r') as f:
        lines = f.read().splitlines()
        for i in range(len(lines)):
            if lines[i].startswith(p4_netcl_main_annotation):
                for l in lines[i + 1:]:
                    if l.strip().startswith('apply'):
                        break
                    if l.strip().startswith('bit<1>'):
                        num += 1
                        bits += 1
                    elif l.strip().startswith('bit<8>'):
                        num += 1
                        bits += 8
                    elif l.strip().startswith('bit<16>'):
                        num += 1
                        bits += 16
                    elif l.strip().startswith('bit<32>'):
                        num += 1
                        bits += 32
                    elif l.strip().startswith('bit<64>'):
                        num += 1
                        bits += 1
                    elif l.strip().startswith('bool'):
                        num += 1
                        bits += 1

                break
    return num, bits

DEVNULL = open(os.devnull, 'wb', 0)

res = {}

for program in os.listdir(INPUTS_DIR):
    if program not in cc['ncc']['p4'].keys():
        continue
    program_path = os.path.join(INPUTS_DIR, program)
    if not os.path.isdir(os.path.join(program_path, "p4-gen")):
        print(f"generate_table_6: skipping '{program}'")
        continue

    res[program] = {'ir': {'n': 0, 'bits': 0}, 'p4' : {'n': 0, 'bits': 0}}

    nc = os.path.join(os.path.abspath(INPUTS_DIR), program, "ncl","%s.cpp" % program)
    ll = os.path.join(os.path.abspath(INPUTS_DIR), program, "ir", "%s.ll" % program)
    p4 = os.path.join(os.path.abspath(INPUTS_DIR), program, "p4-gen", "%s.p4" % program)

    if not os.path.exists(ll):
        emit_ir = "%s %s %s -o %s" % (NCLANG, cc['ncc']['ir'][program], nc, ll)
        subprocess.check_call([emit_ir], shell=True, stdout=DEVNULL)

    if not os.path.exists(p4):
        emit_p4 = "%s %s %s -o %s" % (NCLANG, cc['ncc']['p4'][program], nc, p4)
        subprocess.check_call([emit_p4], shell=True, stdout=DEVNULL)

    allocas, alloca_bits = count_allocas(program, ll)
    res[program]['ir']['n'] += allocas
    res[program]['ir']['bits'] += alloca_bits

    locvars, locvar_bits = count_locvars(program, p4)
    res[program]['p4']['n'] += locvars
    res[program]['p4']['bits'] += locvar_bits



res = dict(sorted(res.items()))

sep = "+ " + ('-' * 10) + " + " + " + ".join('-' * max(10, len(t)) for t in res.keys()) + " +"
fmt = "| {:10} | " + " | ".join(["{:%d}" % max(10, (len(t))) for t in res.keys()]) + " |"

print(sep)
print(fmt.format("", *res.keys()))
print(sep)

ir_allocas = [("0" if res[k]['ir']['n'] == 0 else ("%d / %db" % (res[k]['ir']['n'], res[k]['ir']['bits'])) ) for k in res]
p4_locvars = [("0" if res[k]['p4']['n'] == 0 else ("%d / %db" % (res[k]['p4']['n'], res[k]['p4']['bits'])) ) for k in res]

print(fmt.format('IR Allocas', *ir_allocas))
print(fmt.format('P4 Locvars', *p4_locvars))
print(sep)