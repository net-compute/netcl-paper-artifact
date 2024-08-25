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

CC = {
    'ncl': {
        'ncc' : {
            "ir" : {
                    "agg-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm -mncvm --speculate=1",
                    "agg-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm -mncvm --speculate=1",
                    "cache-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                    "cache-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                    "calc-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                    "calc-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                "paxos-acc-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                "paxos-acc-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                "paxos-ldr-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 4 -emit-llvm",
                "paxos-ldr-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 4 -emit-llvm",
                "paxos-lrn-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 5 -emit-llvm",
                "paxos-lrn-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 5 -emit-llvm",
        "paxos--combined--orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
        "paxos--combined--ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
                        "empty": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-llvm",
            },
            'p4' : {
                    # --p4-no-switch-statements => Intel's compiler only supports switching on table.action_run
                    # --speculate=1             => Intel's compiler cannot fit 'agg' without speculation
                    "agg-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements -mncvm --speculate=1 -mncvm --ncp-host-reflect-implicit-src-addr -mncvm --ncp-host-multicast-implicit-src-addr -mncvm --ncp-implicit-addr=42.0.0.0 -mncvm --ncp-udp-port=4242",
                    "agg-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements -mncvm --speculate=1 -mncvm --ncp-host-reflect-implicit-src-addr -mncvm --ncp-host-multicast-implicit-src-addr -mncvm --ncp-implicit-addr=42.0.0.0 -mncvm --ncp-udp-port=4242",
                    "cache-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements -mncvm --speculate=1 -mncvm --ncp-host-multicast-implicit-src-addr -mncvm --ncp-implicit-addr=42.0.0.0 -mncvm --ncp-udp-port=4242",
                    "cache-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements -mncvm --speculate=1 -mncvm --ncp-host-multicast-implicit-src-addr -mncvm --ncp-implicit-addr=42.0.0.0 -mncvm --ncp-udp-port=4242",
                    "calc-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",
                    "calc-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",
                "paxos-acc-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",
                "paxos-acc-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",
                "paxos-ldr-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 4 -emit-asm -mncvm --p4-no-switch-statements",
                "paxos-ldr-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 4 -emit-asm -mncvm --p4-no-switch-statements",
                "paxos-lrn-orig": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 5 -emit-asm -mncvm --p4-no-switch-statements",
                "paxos-lrn-ours": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 5 -emit-asm -mncvm --p4-no-switch-statements",
                         "empty": "-ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm -mncvm --p4-no-switch-statements",

            }
        },
        "p4c" : "--target tofino --arch tna"
    },
    'p4': {
        'p4c' : "--target tofino --arch tna",
        'dataplane': {
            "agg-ours": "--target tofino --arch tna",
            "cache-ours": "--target tofino --arch tna",
            "calc-ours": "--target tofino --arch tna",
            "paxos-acc-ours": "--target tofino --arch tna",
            "paxos-ldr-ours": "--target tofino --arch tna",
            "paxos-lrn-ours": "--target tofino --arch tna",
        }
    }
}