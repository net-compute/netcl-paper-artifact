import os
import sys
import json
import subprocess
from util import remove_comments, cc

CC = "gcc"
CLOC = "cloc"
INPUTS_DIR = 'programs'
NCLANG = os.path.abspath(os.environ['NCLANG']) if 'NCLANG' in os.environ else \
    os.path.join(os.path.expanduser("~"), "nclang-0.1.0", "bin", "nclang")

need_fmt = ["cache-orig"]

DEVNULL = open(os.devnull, 'wb', 0)


def create_p4_loc_file(program):
    d = os.path.join(os.path.abspath(INPUTS_DIR), program, 'p4')
    loc = {"P4": {"code": 0}}
    for f in os.listdir(d):
        if f.endswith('p4'):
            with open(os.path.join(d, f)) as p4:
                lines = remove_comments(p4.read()).splitlines()
                for l in lines:
                    if len(l.strip()) > 0:
                        loc["P4"]["code"] += 1
    # we add the 2 extra lines to for core.p4 and arch.p4
    # because we have commented them out because we do not want
    # the preprocessor to expand them when counting the preprocessed file
    loc["P4"]["code"] += 2
    with open(os.path.join(d, "%s.p4.loc.json" % program), 'w+') as f:
        json.dump(loc, f)


def create_p4_pp_loc_file(program, need_formatting=False):
    d = os.path.join(os.path.abspath(INPUTS_DIR), program, 'p4')
    loc = {"P4": {"code": 0}}

    preprocessed = ""
    if '--combined--' in program:
        for f in os.listdir(d):
            if f.endswith(".p4"):
                fp = os.path.join(d, f)
                res = subprocess.check_output(
                    "gcc -x c++ -E -P %s" % fp, shell=True).decode('utf-8')
                preprocessed += res

    else:
        fp = os.path.join(d, "main.p4")
        preprocessed = subprocess.check_output(
            "gcc -x c++ -E -P %s" % fp, shell=True).decode('utf-8')
        if need_formatting:
            fmtp = "%s.pp.formatted" % fp
            with open(fmtp, 'w+') as f:
                f.write(preprocessed)
            os.system("clang-format -i %s" % fmtp)
            with open(fmtp) as f:
                preprocessed = f.read()
            os.remove(fmtp)

        # we add the 2 extra lines to for core.p4 and arch.p4
        # because we have commented them out because we do not want
        # the preprocessor to expand them when counting the preprocessed file
        loc["P4"]["code"] += 2

    for l in preprocessed.splitlines():
        if len(l.strip()) > 0:
            loc["P4"]["code"] += 1

    with open(os.path.join(d, "%s.p4.pp.loc.json" % program), 'w+') as f:
        json.dump(loc, f)


def create_p4_gen_loc_file(program):
    loc = {"P4": {"code": 0}}
    gen_d = os.path.join(os.path.abspath(INPUTS_DIR), program, 'p4-gen')

    if program in cc['ncc']['p4'].keys():
        ncl_d = os.path.join(os.path.abspath(INPUTS_DIR), program, 'ncl')
        ncl_f = os.path.join(ncl_d, "%s.cpp" % program)
        gen_f = os.path.join(gen_d, "%s.p4" % program)
        ncc_command = "%s %s %s -o %s" % (NCLANG,
                                          cc['ncc']['p4'][program], ncl_f, gen_f)
        subprocess.check_call([ncc_command], shell=True,
                              stdout=DEVNULL, stderr=DEVNULL)
        with open(gen_f) as f:
            lines = remove_comments(f.read()).splitlines()
            for l in lines:
                if len(l.strip()) > 0:
                    loc["P4"]["code"] += 1
    with open(os.path.join(gen_d, "%s.p4.loc.json" % program), 'w+') as f:
        json.dump(loc, f)


def create_ncl_loc_file(program):
    d = os.path.join(os.path.abspath(INPUTS_DIR), program, 'ncl')
    f = os.path.join(d, "%s.cpp" % program)
    os.system("cloc %s --json > %s.loc.json" % (f, f))


def create_ncl_pp_loc_file(program):
    d = os.path.join(os.path.abspath(INPUTS_DIR), program, 'ncl')
    f = os.path.join(d, "%s.cpp" % program)
    o = os.path.join(d, "%s.pp.cpp" % program)
    os.system("gcc -x c++ -E -P %s > %s" % (f, o))
    os.system("cloc %s --json > %s.pp.loc.json" % (o, f))


def create_ir_file(program):
    nc = os.path.join(os.path.abspath(INPUTS_DIR),
                      program, "ncl", "%s.cpp" % program)
    ll = os.path.join(os.path.abspath(INPUTS_DIR),
                      program, "ir", "%s.ll" % program)
    emit_ir = "%s %s %s -o %s" % (NCLANG, cc['ncc']['ir'][program], nc, ll)
    subprocess.check_call([emit_ir], shell=True, stdout=DEVNULL)


def cleanup(program):
    d = os.path.join(os.path.abspath(INPUTS_DIR), program)
    for f in os.listdir(os.path.join(d, "ir")) if os.path.isdir(os.path.join(d, "ir")) else []:
        if f.endswith('json') or f.endswith('ll'):
            os.remove(os.path.join(d, "ir", f))
    for f in os.listdir(os.path.join(d, "ncl")) if os.path.isdir(os.path.join(d, "ncl")) else []:
        if f.endswith('json') or f.endswith('pp.cpp'):
            os.remove(os.path.join(d, "ncl", f))
    for f in os.listdir(os.path.join(d, "p4")) if os.path.isdir(os.path.join(d, "p4")) else []:
        if f.endswith('json'):
            os.remove(os.path.join(d, "p4", f))
    for f in os.listdir(os.path.join(d, "p4-gen")) if os.path.isdir(os.path.join(d, "p4-gen")) else []:
        if f.endswith('json'):
            os.remove(os.path.join(d, "p4-gen", f))


for program in sorted(os.listdir(INPUTS_DIR)):
    if "--cleanup" in sys.argv:
        cleanup(program)
    else:
        program_path = os.path.join(INPUTS_DIR, program)
        if os.path.isdir(os.path.join(program_path, 'ncl')):
            if not os.path.exists(NCLANG):
                sys.stderr.write(
                    "error: could not find NCLANG at '%s'\n" % NCLANG)
                sys.exit(1)
            create_ir_file(program)
            create_ncl_loc_file(program)
            create_ncl_pp_loc_file(program)
        else:
            print(f"no ncl input for {program}")
        create_p4_loc_file(program)
        create_p4_pp_loc_file(program, program in need_fmt)
        if program in cc['ncc']['p4']:
            create_p4_gen_loc_file(program)
