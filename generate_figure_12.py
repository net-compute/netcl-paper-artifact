import numpy as np
import matplotlib.pyplot as plt
import os
import re
import sys
import json
import subprocess
from util import remove_comments, cc

INPUTS_DIR = 'programs'

DATA = {}

for program in sorted(os.listdir(INPUTS_DIR)):
    if program not in cc['ncc']['p4']:
        continue
    d = os.path.join(os.path.abspath(INPUTS_DIR), program)
    ncl_d = os.path.join(d, "ncl")
    gen_d = os.path.join(d, "p4-gen")
    brk_d = os.path.join(d, "p4-gen-breakdown")

    total = 0
    breakdown = {'total': 0, 'ncl': 0, 'other': 0}

    with open(os.path.join(ncl_d, "%s.cpp.loc.json" % program)) as f:
        breakdown['ncl'] = json.load(f)["C++"]["code"]

    with open(os.path.join(gen_d, "%s.p4.loc.json" % program)) as f:
        breakdown['total'] = json.load(f)["P4"]["code"]

    rel = 0
    for f in os.listdir(brk_d):
        path = os.path.join(brk_d, f)
        with open(path) as bf:
            cnt = len(bf.read().splitlines())
            key = f.split('.')[0]
            breakdown[key] = cnt
            if key == 'compute':
                continue
            rel += cnt

    breakdown['other'] = breakdown['total'] - rel
    DATA[program] = breakdown

DATA = dict(sorted(DATA.items()))


bottom = np.zeros(len(DATA))
bar_width = 0.3
xlabels = [label.replace('-', '-\n') for label in DATA.keys()]

plt.ylim((0, 101))
plt.yticks(np.arange(0, 101, step=20))
plt.ylabel("Percentage")
plt.xticks(np.arange(len(DATA.keys())), labels=xlabels)
plt.title("Breakdown of P4 LoC in the test programs",fontweight='bold')

x = np.arange(len(DATA.keys()))
x_l = x - bar_width
x_r = x + bar_width

d_headers_and_parsing = [
    DATA[k]["headers_and_parsing"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_l, d_headers_and_parsing, width=bar_width)
bottom += d_headers_and_parsing

d_tables = [DATA[k]["tables"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_l, d_tables, bottom=bottom, color='limegreen', width=bar_width)
bottom += d_tables

d_actions = [DATA[k]["actions"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_l, d_actions, bottom=bottom, color='forestgreen', width=bar_width)
bottom += d_actions

d_registers = [DATA[k]["regs"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_l, d_registers, bottom=bottom, color="pink", width=bar_width)
bottom += d_registers

d_register_actions = [DATA[k]["regactions"] /
                      DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_l, d_register_actions, bottom=bottom, color="red", width=bar_width)
bottom += d_register_actions

d_logic = [DATA[k]["logic"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_l, d_logic, bottom=bottom, color="orange", width=bar_width)
bottom += d_logic

d_other = [DATA[k]["other"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_l, d_other, bottom=bottom, color="silver", width=bar_width)
bottom += d_other

d_compute = [DATA[k]["compute"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x, d_compute, color="purple", width=bar_width)

d_ncl = [DATA[k]["ncl"] / DATA[k]['total'] * 100 for k in DATA]
plt.bar(x_r, d_ncl, color="midnightblue", width=bar_width)

plt.legend(labels=["Headers+Parsing", "Tables", "Actions", "Registers",
           "RegisterActions", "Logic", "Other", "Compute", "NetCL"], loc='upper center', bbox_to_anchor=(0.5, -0.15),
          fancybox=True, shadow=True, ncol=3)
plt.tight_layout()
plt.savefig("figure_12.pdf", format="pdf", bbox_inches="tight")

if "--noshow" not in sys.argv:
    plt.show()
