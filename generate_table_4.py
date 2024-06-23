import os
import time
import sys
import shutil
import subprocess
from util import cc

INPUTS_DIR = 'programs'
REPEAT=5
NCLANG = os.path.abspath(os.environ['NCLANG']) if 'NCLANG' in os.environ else \
    os.path.join(os.path.abspath('~'), "nclang-0.1.0", "build", "bin", "nclang")
P4C = os.path.abspath(os.environ['P4C']) if 'P4C' in os.environ else None  # Path to Intel's P4C
KEEP= "--keep" in sys.argv
CLEANUP = "--cleanup" in sys.argv

if not CLEANUP:
    if not os.path.exists(NCLANG):
        print("error: NetCL compiler (nclang) not found")
        sys.exit(1)
    if P4C is None or not os.path.exists(P4C):
        print(" \033[31m\u2718\033[0m P4 compiler (bf-p4c) not found. Skipping ...")
        P4C = None

times = {}

DEVNULL = open(os.devnull, 'wb', 0)

for program in os.listdir(INPUTS_DIR):
    if program not in cc['ncc']['p4'].keys():
        continue

    d = os.path.join(os.path.abspath(INPUTS_DIR), program)
    n = os.path.join(d, 'ncl', "%s.cpp" % program)
    p = os.path.join(d, 'p4-gen', "%s.tmp.p4" % program)
    t = os.path.join(d, "%s.tofino" % program)

    if CLEANUP:
        shutil.rmtree(t, ignore_errors=True)
        continue

    times[program] = {"ncc" : 0, "p4c": 0}
    ncc_time = 0

    for i in range(REPEAT):
        txt = "NetCL and P4" if P4C is not None else "NetCL"

        print("[%s%s%s]" % ('=' * i, '>', ' ' * (REPEAT - (i + 1))), "timing %s compilation (%d/%d) of: %s" % (txt, i + 1,REPEAT, program), end='\r')

        ncc_command = "%s %s %s -o %s" % (NCLANG, cc['ncc']['p4'][program], n, p)
        p4c_command = "%s %s %s -o %s" % (P4C, cc['p4c'], p, t)

        start = time.time()
        subprocess.check_call([ncc_command], shell=True, stderr=DEVNULL, stdout=DEVNULL)
        times[program]["ncc"] += time.time() - start

        time.sleep(1)

        if P4C is not None:
            start = time.time()
            subprocess.check_call([p4c_command], shell=True, stderr=DEVNULL, stdout=DEVNULL)
            times[program]["p4c"] += time.time() - start

    print()

    times[program]["ncc"] /= REPEAT
    times[program]["p4c"] /= REPEAT

    os.remove(p)
    if not KEEP:
        shutil.rmtree(t, ignore_errors=True)

if not CLEANUP:
    times = dict(sorted(times.items()))

    sep = "+ --- + " + " + ".join('-' * max(5, len(t)) for t in times.keys()) + " +"
    fmt = "| {:3} | " + " | ".join(["{:%d}" % max(5, (len(t))) for t in times.keys()]) + " |"

    print(sep)
    print(fmt.format("", *times.keys()))
    print(sep)

    ncc_times = [times[k]['ncc'] for k in times]
    p4c_times = [times[k]['p4c'] for k in times]
    tot_times = [(times[k]['ncc'] + times[k]['p4c']) for k in times]

    print(fmt.format('ncc', *[("%.2f" % t) for t in ncc_times]))
    print(fmt.format('p4c', *[("  --" if P4C is None else ("%.2f" % t)) for t in p4c_times]))
    print(fmt.format('tot', *[("%.2f" % t) for t in tot_times]))
    print(sep)
