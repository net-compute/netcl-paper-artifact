import re, os

def remove_comments(string):
    pattern = r"(\".*?\"|\'.*?\')|(/\*.*?\*/|//[^\r\n]*$)"
    regex = re.compile(pattern, re.MULTILINE|re.DOTALL)
    def _replacer(match):
        if match.group(2) is not None:
            return ""
        else:
            return match.group(1)
    return regex.sub(_replacer, string)

cc = {
    'ncc' : {
        "ir" : {
                       "agg": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm -mncvm --speculate=1",
                  "netcache": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                "calculator": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
            "paxos-acceptor": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
              "paxos-leader": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 4 -emit-llvm",
             "paxos-learner": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 5 -emit-llvm",
                 "paxos-one": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
        },
        'p4' : {
                # --p4-no-switch-statements => Intel's compiler only supports switching on table.action_run
                # --speculate=1             => Intel's compiler cannot fit 'agg' without speculation
                       "agg": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements -mncvm --speculate=1",
                 "netcache" : "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",
                "calculator": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",
            "paxos-acceptor": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",
              "paxos-leader": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 4 -emit-asm -mncvm --p4-no-switch-statements",
             "paxos-learner": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 5 -emit-asm -mncvm --p4-no-switch-statements",

        }
    },
    "p4c" : "--target tofino --arch tna"
}