import os
import sys
import json
import subprocess

CC = "gcc"
INPUTS_DIR = 'programs'

ext = {
    'ncl': "cpp.loc.json",
    'ncl_pp': "cpp.pp.loc.json",
    "p4": "p4.loc.json",
    "p4_pp": "p4.pp.loc.json",
    "p4_gen": "p4.loc.json"
}

def count_loc(program, ver, ext, key):
    res = 0
    d = os.path.join(os.path.abspath(INPUTS_DIR), program, ver)
    for f in os.listdir(d):
        if f.endswith(ext):
            with open(os.path.join(d, f)) as lf:
                j = json.load(lf)
                res += j[key]["code"]
    return res


fmt = "| {:<14} | {:<4} | {:<6} | {:<10} | {:<6} | {:<6} | {:<11} | {:<6} |"
print('+', '-' * 14, '+', '-' * 4, '+', '-' * 6, '+', '-' * 10, '+', '-' * 6, '+', '-' * 6, '+', '-' * 11, '+', '-' * 6, '+')
print(fmt.format("program", "ncl", "p4", "reduction", "ncl.i", "p4.i", "reduction.i", "p4-gen"))
print('+', '-' * 14, '+', '-' * 4, '+', '-' * 6, '+', '-' * 10, '+', '-' * 6, '+', '-' * 6, '+', '-' * 11, '+', '-' * 6, '+')

lines = {}

ones = []

for program in os.listdir(INPUTS_DIR):
    ncl_loc = count_loc(program, "ncl", ext['ncl'], "C++")
    p4_loc = count_loc(program, "p4", ext['p4'], "P4")
    reduction = p4_loc / ncl_loc if ncl_loc > 0 else 0

    ncl_pp_loc = count_loc(program, "ncl", ext['ncl_pp'], "C++")
    p4_pp_loc = count_loc(program, "p4", ext['p4_pp'], "P4")
    reduction_pp = p4_pp_loc / ncl_loc if ncl_loc > 0 else 0

    p4_gen_loc = count_loc(program, "p4-gen", ext['p4_gen'], "P4") if not program.endswith('-one') else 0

    lines[program] = fmt.format(program,
                     ncl_loc,
                     p4_loc,
                     ("%.2f" % reduction) if reduction > 0 else '-',
                     ncl_pp_loc,
                     p4_pp_loc,
                     ("%.2f" % reduction_pp) if reduction_pp > 0 else '-',
                     p4_gen_loc if p4_gen_loc > 0 else '-')

lines = dict(sorted(lines.items()))
for p in lines:
    print(lines[p])
print('+', '-' * 14, '+', '-' * 4, '+', '-' * 6, '+', '-' * 10, '+', '-' * 6, '+', '-' * 6, '+', '-' * 11, '+', '-' * 6, '+')
