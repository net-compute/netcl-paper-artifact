import pprint
import numpy as np
import matplotlib.pyplot as plt
import os
import re
import sys
import json
import subprocess
from util import remove_comments, CC

INPUTS_DIR = 'programs'
OUTFILE = "figure_12.pdf"
DATA = {}
cc = CC['ncl']

PAPER_ORDER = ["agg-orig", "agg-ours", "cache-orig", "cache-ours", "paxos-acc-orig", "paxos-acc-ours", "paxos-ldr-orig",
               "paxos-ldr-ours", "paxos-lrn-orig", "paxos-lrn-ours", "calc-orig", "calc-ours"]


def get_breakdown(program, ncl_d, full_d, brkd_d, breakdown):
    with open(os.path.join(ncl_d, "%s.cpp.loc.json" % program)) as f:
        breakdown['ncl'] = json.load(f)["C++"]["code"]

    with open(os.path.join(full_d, "%s.p4.loc.json" % program)) as f:
        breakdown['total'] = json.load(f)["P4"]["code"]

    rel = 0
    for f in os.listdir(brkd_d):
        path = os.path.join(brkd_d, f)
        with open(path) as bf:
            # cnt = len(bf.read().splitlines())
            non_empty_lines = sum(1 for line in bf if line.strip())
            key = f.split('.')[0]
            breakdown[key] = non_empty_lines
            if key == 'compute':
                continue
            rel += non_empty_lines
    breakdown['other'] = breakdown['total'] - rel


for program in sorted(os.listdir(INPUTS_DIR)):
    if program not in PAPER_ORDER:
        continue
    program_path = os.path.join(INPUTS_DIR, program)

    # breakdown = None

    # if os.path.isdir(os.path.join(program_path, "p4-gen-breakdown")):
    #     breakdown = "generated"
    # elif os.path.isdir(os.path.join(program_path, "p4-breakdown")):
    #     breakdown = "handwritten"
    # else:
    #     print(f"generate_figure_12: skipping '{program}'")
    #     PAPER_ORDER.remove(program)
    #     continue

    d = os.path.join(os.path.abspath(INPUTS_DIR), program)
    ncl_d = os.path.join(d, "ncl")

    # if breakdown == 'generated':
    #     full_d = os.path.join(d, "p4-gen")
    #     brkd_d = os.path.join(d, "p4-gen-breakdown")
    # else:
    #     full_d = os.path.join(d, "p4")
    #     brkd_d = os.path.join(d, "p4-breakdown")

    breakdown = {'h': {'total': 0, 'ncl': 0, 'other': 0},
                 'g': {'total': 0, 'ncl': 0, 'other': 0}}

    if os.path.isdir(os.path.join(program_path, "p4-breakdown")):
        full_d = os.path.join(d, "p4")
        brkd_d = os.path.join(d, "p4-breakdown")
        get_breakdown(program, ncl_d, full_d, brkd_d, breakdown['h'])
    else:
        print(f" \033[31m\u2718\033[0m no p4-breakdown for '{program}'")
        breakdown['h'] = None
    if os.path.isdir(os.path.join(program_path, "p4-gen-breakdown")):
        full_d = os.path.join(d, "p4-gen")
        brkd_d = os.path.join(d, "p4-gen-breakdown")
        get_breakdown(program, ncl_d, full_d, brkd_d, breakdown['g'])
    else:
        print(f" \033[31m\u2718\033[0m no p4--gen-breakdown for '{program}'")
        breakdown['g'] = None

    DATA[program] = breakdown

    # total = 0
    # breakdown = {'total': 0, 'ncl': 0, 'other': 0, 'kind': breakdown}

    # with open(os.path.join(ncl_d, "%s.cpp.loc.json" % program)) as f:
    #     breakdown['ncl'] = json.load(f)["C++"]["code"]

    # with open(os.path.join(full_d, "%s.p4.loc.json" % program)) as f:
    #     breakdown['total'] = json.load(f)["P4"]["code"]

    # for f in os.listdir(brkd_d):
    #     path = os.path.join(brkd_d, f)
    #     with open(path) as bf:
    #         cnt = len(bf.read().splitlines())
    #         key = f.split('.')[0]
    #         breakdown[key] = cnt
    #         if key == 'compute':
    #             continue
    #         rel += cnt

    # breakdown['other'] = breakdown['total'] - rel

    # DATA[program] = breakdown


DATA = dict(sorted(DATA.items(), key=lambda kv: PAPER_ORDER.index(
    kv[0]) if kv[0] in PAPER_ORDER else len(PAPER_ORDER)))

xlabels = []
for p in DATA.keys():
    name = p.replace('-', '-\n')
    xlabels.append(name + '.g')
    xlabels.append(name + '.h')

plt.figure(figsize=(12, 6))

# xlabels = [prog.replace('-', '-\n') for prog in DATA.keys()]
plt.ylim((0, 101))
plt.yticks(np.arange(0, 101, step=20))
plt.ylabel("Percentage")
# plt.xticks(np.arange(len(xlabels)), labels=xlabels, rotation=85, ha='right', fontsize=10)

plt.title("Breakdown of P4 LoC in the test programs", fontweight='bold')


n = len(xlabels)
bar_width = 0.55
group_width = bar_width * 3  # Total width of one group of bars
x = np.arange(n) * (group_width + 0.5)
# plt.xticks(np.arange(n) * (group_width + 0.5) + group_width / 3, labels=xlabels, rotation=85, ha='right', fontsize=10)
plt.xticks(x, labels=xlabels, rotation=85, ha='right', fontsize=10)


# List of the keys to stack
keys = ["headers_and_parsing", "tables", "actions",
        "regs", "regactions", "logic", "other"]

# Stack bars for g and h
colors = ["blue", "limegreen", "forestgreen", "pink",
          "red", "orange", "silver", "purple", "midnightblue"]
bottom_g = np.zeros(len(xlabels) // 2)
bottom_h = np.zeros(len(xlabels) // 2)
legend_labels = []
legend_patches = []
for i, key in enumerate(keys):
    d_g = [(DATA[p]['g'][key] / DATA[p]['g']['total'] * 100)
           if DATA[p]['g'] is not None else 0 for p in DATA]
    d_h = [(DATA[p]['h'][key] / DATA[p]['h']['total'] * 100)
           if DATA[p]['h'] is not None else 0 for p in DATA]
    plt.bar(x[::2] - bar_width, d_g, width=bar_width, bottom=bottom_g,
            edgecolor='black', linewidth=.5, color=colors[i])
    plt.bar(x[1::2] - bar_width, d_h, width=bar_width, bottom=bottom_h,
            edgecolor='black', linewidth=.5, color=colors[i])
    bottom_g += d_g
    bottom_h += d_h
    legend_labels.append(key)
    legend_patches.append(plt.Line2D([0], [0], color=colors[i], lw=4))

# Plot compute and total separately
d_compute_g = [(DATA[p]['g']["compute"] / DATA[p]['g']['total']
                * 100) if DATA[p]['g'] is not None else 0 for p in DATA]
d_compute_h = [(DATA[p]['h']["compute"] / DATA[p]['h']['total']
                * 100) if DATA[p]['h'] is not None else 0 for p in DATA]
plt.bar(x[::2], d_compute_g, width=bar_width,
        linewidth=.5, edgecolor='black', color=colors[-2])
plt.bar(x[1::2], d_compute_h, width=bar_width,
        linewidth=.5, edgecolor='black', color=colors[-2])

d_ncl_g = [(DATA[p]['g']["ncl"] / DATA[p]['g']['total'] * 100) if DATA[p]
           ['g'] is not None else 0 for p in DATA]  # Total is 100% for normalization
d_ncl_h = [(DATA[p]['h']["ncl"] / DATA[p]['h']['total'] * 100) if DATA[p]
           ['h'] is not None else 0 for p in DATA]  # Total is 100% for normalization
plt.bar(x[::2] + bar_width, d_ncl_g, width=bar_width,
        color='black', linewidth=1, fill=True)
plt.bar(x[1::2] + bar_width, d_ncl_h, width=bar_width,
        color='black', linewidth=1, fill=True)

plt.legend(legend_patches + [plt.Line2D([0], [0], color=colors[-2], lw=4), plt.Line2D([0], [0], color='black', lw=4)],
           ['headers_and_parsing', 'tables', 'actions', 'regs', 'regactions', 'logic', 'other', 'compute', 'ncl'],
           loc='upper center', bbox_to_anchor=(0.5, -0.4),
           fancybox=True, shadow=True, ncol=3)
# plt.legend(labels=legend_labels + ['compute', 'ncl'], loc='upper center', bbox_to_anchor=(0.5, -0.4),
#           fancybox=True, shadow=True, ncol=3)
plt.tight_layout()
plt.savefig(OUTFILE, format="pdf", bbox_inches="tight")
print(" \033[32m\u2714\033[0m", "figure written at", os.path.abspath(OUTFILE))

if "--noshow" not in sys.argv:
    plt.show()


# print also as a table to help transferring to the paper:
headers = ["Program", "Headers+Parsing", "Tables", "Actions", "Registers",
           "RegisterActions", "Logic", "Other", "Compute", "Total", "NetCL"]
# Prepare rows

# pprint.pprint(DATA)
rows = []
for prog, metrics in DATA.items():
    for version in ['g', 'h']:
        if metrics[version]:
            rows.append([
                prog + '.' + version.upper(),
                metrics[version]['headers_and_parsing'],
                metrics[version]['tables'],
                metrics[version]['actions'],
                metrics[version]['regs'],
                metrics[version]['regactions'],
                metrics[version]['logic'],
                metrics[version]['other'],
                metrics[version]['compute'],
                metrics[version]['total'],
                metrics[version]['ncl'],
            ])

rows_percent = []
for prog, metrics in DATA.items():
    for version in ['g', 'h']:
        if metrics[version]:
            rows_percent.append([
                prog + '.' + version.upper(),
                (metrics[version]['headers_and_parsing'] / metrics[version]['total']) * 100,
                (metrics[version]['tables'] / metrics[version]['total']) * 100,
                (metrics[version]['actions'] / metrics[version]['total']) * 100,
                (metrics[version]['regs'] / metrics[version]['total']) * 100,
                (metrics[version]['regactions'] / metrics[version]['total']) * 100,
                (metrics[version]['logic'] / metrics[version]['total']) * 100,
                (metrics[version]['other'] / metrics[version]['total']) * 100,
                (metrics[version]['compute'] / metrics[version]['total']) * 100,
                metrics[version]['total'],
                (metrics[version]['ncl'] / metrics[version]['total']) * 100
            ])

col_widths = [max(len(str(item)) for item in col)
              for col in zip(*([headers] + rows))]
format_str = ' | '.join('{{:<{}}}'.format(width) for width in col_widths)
# Print the header
print()
print(format_str.format(*headers))
print('-' * (sum(col_widths) + 3 * (len(headers) - 1)))
# Print each row of data
for row in rows:
    print(format_str.format(*row))


# Print the header
col_widths_percent = [
    max(len(f"{item:.2f}") if isinstance(item, (int, float)) else len(str(item)) for item in col)
    for col in zip(*([headers] + rows_percent))
]
format_str_percent = ' | '.join('{{:<{}}}'.format(width) for width in col_widths_percent)
print()
print()
print(format_str_percent.format(*headers))
print('-' * (sum(col_widths_percent) + 3 * (len(headers) - 1)))

formatted_rows = [
    format_str.format(*[f"{item:.2f}" if isinstance(item, (float)) else str(item) for item in row])
    for row in rows_percent
]

for row in formatted_rows:
    print(row)
    #print(format_str_percent.format(*row))