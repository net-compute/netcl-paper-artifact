NetCL Paper Artifact
--------------------
This repository contains artifacts to reproduce the experiments on the NetCL paper

## Usage

1. Download the NetCL VM image (12GB) from [https://drive.google.com/drive/folders/1mCRPzej0ckkm1awvhmpvJO0sNzYOrC3l](https://drive.google.com/drive/folders/1mCRPzej0ckkm1awvhmpvJO0sNzYOrC3l)
2. Import it to VirtualBox and log in with:
   ```
   username: nc
   password: nc
   ```
   We have also set up SSH port forwarding at port `10042` for headless mode:
   ```
   ssh -p 10042 nc@localhost
   ```
3. Clone this repository in the `$HOME` directory:
   ```
   cd $HOME && git clone https://github.com/net-compute/netcl-paper-artifact.git
   ```
4. **(Optional)** [Request access](https://www.intel.com/content/www/us/en/products/docs/network-io/intelligent-fabric-processors/connectivity-education-hub/research-program.html) to Intel's Tofino SDE and follow its instruction to install it under `$HOME`. Our scripts will look under `$HOME/bf-sde-9.13.0/` for the Tofino tools. If not found the relevant experiments will be ignored.
5. Run `run_all.sh` to generate figures.

For questions please contact netcomputeproject@gmail.com or [open an issue](https://github.com/net-compute/netcl-paper-artifact/issues/new)!

## Example Output (with Tofino SDE)
```
[+] Preparing programs...
[+] took 0m9s

[+] Generating Table 3...
+ -------------- + ---- + ------ + ---------- + ------ + ------ + ----------- + ------ +
| program        | ncl  | p4     | reduction  | ncl.i  | p4.i   | reduction.i | p4-gen |
+ -------------- + ---- + ------ + ---------- + ------ + ------ + ----------- + ------ +
| agg            | 38   | 1360   | 35.79      | 33     | 1283   | 33.76       | 1278   |
| calculator     | 25   | 139    | 5.56       | 25     | 139    | 5.56        | 512    |
| netcache       | 97   | 692    | 7.13       | 88     | 1518   | 15.65       | 1592   |
| paxos-acceptor | 38   | 230    | 6.05       | 34     | 208    | 5.47        | 614    |
| paxos-leader   | 26   | 214    | 8.23       | 23     | 192    | 7.38        | 522    |
| paxos-learner  | 35   | 241    | 6.89       | 33     | 219    | 6.26        | 637    |
| paxos-one      | 76   | 387    | 5.09       | 70     | 365    | 4.80        | -      |
+ -------------- + ---- + ------ + ---------- + ------ + ------ + ----------- + ------ +
[+] took 0m0s

[+] Generating Table 4...
[====>] timing NetCL and P4 compilation (5/5) of: paxos-leader
[====>] timing NetCL and P4 compilation (5/5) of: paxos-learner
[====>] timing NetCL and P4 compilation (5/5) of: netcache
[====>] timing NetCL and P4 compilation (5/5) of: calculator
[====>] timing NetCL and P4 compilation (5/5) of: paxos-acceptor
[====>] timing NetCL and P4 compilation (5/5) of: agg
+ --- + ----- + ---------- + -------- + -------------- + ------------ + ------------- +
|     | agg   | calculator | netcache | paxos-acceptor | paxos-leader | paxos-learner |
+ --- + ----- + ---------- + -------- + -------------- + ------------ + ------------- +
| ncc | 0.61  | 0.61       | 0.64     | 0.60           | 0.59         | 0.59          |
| p4c | 9.87  | 2.69       | 56.60    | 3.61           | 2.95         | 3.49          |
| tot | 10.49 | 3.30       | 57.24    | 4.21           | 3.54         | 4.08          |
+ --- + ----- + ---------- + -------- + -------------- + ------------ + ------------- +
[+] took 7m24s

[+] Generating Table 6...
+ ---------- + ---------- + ---------- + ---------- + -------------- + ------------ + ------------- +
|            | agg        | calculator | netcache   | paxos-acceptor | paxos-leader | paxos-learner |
+ ---------- + ---------- + ---------- + ---------- + -------------- + ------------ + ------------- +
| IR Allocas | 1 / 16b    | 1 / 8b     | 3 / 176b   | 0              | 1 / 8b       | 1 / 8b        |
| P4 Locvars | 4 / 80b    | 2 / 40b    | 17 / 349b  | 3 / 64b        | 2 / 40b      | 7 / 80b       |
+ ---------- + ---------- + ---------- + ---------- + -------------- + ------------ + ------------- +
[+] took 0m0s

[+] Generating Figure 12...
[+] took 0m1s

Finished after 7m34s
```