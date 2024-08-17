NetCL Paper Artifact
--------------------
This repository contains artifacts to reproduce the experiments of the paper:

> NetCL: A Unified Programming Framework for In-Network Computing - Supercomputing 2024


## Usage

1. Download the NetCL VM image (~13GB) from [Zenodo](https://zenodo.org/records/13328729)

2. Import it to VirtualBox and log in with:
   ```
   username: nc
   password: nc
   ```
   We have also set up SSH port forwarding at port `10042` for headless mode:
   ```bash
   ssh -p 10042 nc@localhost
   ```
   **This repository is already cloned under `$HOME`**

3. **(IMPORTANT)** We discovered (and fixed) a couple of bugs after the artifact-freeze deadline of the conference, meaning that the repository in the VM does not contain those fixes. If you want to produce the exact values reported in the paper you need to pull the fixes.
   ```bash
   cd $HOME/netcl-paper-artifact && git pull
   ```

4. **(Optional)** [Request access](https://www.intel.com/content/www/us/en/products/docs/network-io/intelligent-fabric-processors/connectivity-education-hub/research-program.html) to Intel's Tofino SDE and follow its instruction to install it under `$HOME`. Our scripts will look under `$HOME/bf-sde-9.13.0/` for the Tofino tools. If not found the relevant experiments will be ignored.

5. Run `run_all.sh` to generate all figures in the paper, except those that report on switch resources and packet latency. For those you need to:
   - Make sure that you have correctly performed step 4 from above
   - Run `$HOME/bf-sde-9.13.0/install/bin/p4i` and then open a browser and paste `http://localhost:3000`. If all went well you should see `p4i`'s web interface
   - Load the P4C output of each program manually, through `p4i`'s web interface, and inspect the report. The P4C outputs are found under `$HOME/netcl-paper-artifact/programs/<program>/<program>.tofino`.

For questions please contact netcomputeproject@gmail.com or [open an issue](https://github.com/net-compute/netcl-paper-artifact/issues/new)!

## Example Output (with Tofino SDE)
```
[+] Preparing programs...
[+] took 0m20s

[+] Generating Table 3...
+ ------------------------- + ---- + ------ + ---------- +      + ------ + ------ + ----------- +      + ------ +
| program                   | ncl  | p4     | reduction  |      | ncl.i  | p4.i   | reduction.i |      | p4-gen |
+ ------------------------- + ---- + ------ + ---------- +      + ------ + ------ + ----------- +      + ------ +
| agg-orig                  | 38   | 1139   | 29.97      |      | 33     | 1062   | 27.95       |      | 1420   |
| agg-ours                  | 38   | 686    | 18.05      |      | 33     | 660    | 17.37       |      | 1420   |
| cache-orig                | 91   | 692    | 7.60       |      | 82     | 1518   | 16.68       |      | 965    |
| cache-ours                | 91   | 723    | 7.95       |      | 82     | 697    | 7.66        |      | 965    |
| calc-orig                 | 25   | 139    | 5.56       |      | 25     | 139    | 5.56        |      | 646    |
| calc-ours                 | 25   | 234    | 9.36       |      | 25     | 234    | 9.36        |      | 646    |
| paxos--combined--orig     | 76   | 381    | 5.01       |      | 70     | 743    | 9.78        |      | -      |
| paxos--combined--ours     | 76   | 901    | 11.86      |      | 70     | 1441   | 18.96       |      | -      |
| paxos-acc-orig            | 38   | 230    | 6.05       |      | 34     | 208    | 5.47        |      | 746    |
| paxos-acc-ours            | 38   | 573    | 15.08      |      | 34     | 550    | 14.47       |      | 746    |
| paxos-ldr-orig            | 26   | 214    | 8.23       |      | 23     | 192    | 7.38        |      | 656    |
| paxos-ldr-ours            | 26   | 276    | 10.62      |      | 23     | 253    | 9.73        |      | 656    |
| paxos-lrn-orig            | 34   | 241    | 7.09       |      | 32     | 219    | 6.44        |      | 766    |
| paxos-lrn-ours            | 35   | 436    | 12.46      |      | 33     | 413    | 11.80       |      | 774    |
+ ------------------------- + ---- + ------ + ---------- +      + ------ + ------ + ----------- +      + ------ +
[+] took 0m0s

[+] Generating Table 4...
[====>] timing NetCL and P4 compilation (5/5) of: paxos-lrn-ours
[====>] timing NetCL and P4 compilation (5/5) of: paxos-acc-ours
[====>] timing NetCL and P4 compilation (5/5) of: paxos-ldr-orig
[====>] timing NetCL and P4 compilation (5/5) of: paxos-lrn-orig
[====>] timing NetCL and P4 compilation (5/5) of: paxos-ldr-ours
[====>] timing NetCL and P4 compilation (5/5) of: cache-ours
[====>] timing NetCL and P4 compilation (5/5) of: calc-orig
[====>] timing NetCL and P4 compilation (5/5) of: cache-orig
[====>] timing NetCL and P4 compilation (5/5) of: calc-ours
[====>] timing NetCL and P4 compilation (5/5) of: agg-ours
[====>] timing NetCL and P4 compilation (5/5) of: agg-orig
[====>] timing NetCL and P4 compilation (5/5) of: paxos-acc-orig
+ --- + -------- + -------- + ---------- + ---------- + --------- + --------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
|     | agg-orig | agg-ours | cache-orig | cache-ours | calc-orig | calc-ours | paxos-acc-orig | paxos-acc-ours | paxos-ldr-orig | paxos-ldr-ours | paxos-lrn-orig | paxos-lrn-ours |
+ --- + -------- + -------- + ---------- + ---------- + --------- + --------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
| ncc | 0.73     | 0.73     | 0.74       | 0.74       | 0.71      | 0.70      | 0.71           | 0.70           | 0.70           | 0.69           | 0.71           | 0.73           |
| p4c | 10.93    | 10.99    | 5.42       | 5.45       | 3.21      | 3.23      | 4.05           | 4.06           | 3.54           | 3.52           | 4.05           | 4.07           |
| tot | 11.66    | 11.72    | 6.16       | 6.20       | 3.92      | 3.94      | 4.76           | 4.76           | 4.24           | 4.21           | 4.76           | 4.80           |
+ --- + -------- + -------- + ---------- + ---------- + --------- + --------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
[+] took 6m56s

[+] Generating Table 6...
+ ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
|            | agg-orig   | agg-ours   | cache-orig | cache-ours | calc-orig  | calc-ours  | paxos-acc-orig | paxos-acc-ours | paxos-ldr-orig | paxos-ldr-ours | paxos-lrn-orig | paxos-lrn-ours |
+ ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
| IR Allocas | 0          | 0          | 0          | 0          | 1 / 8b     | 1 / 8b     | 0              | 0              | 1 / 8b         | 1 / 8b         | 1 / 8b         | 1 / 8b         |
| P4 Locvars | 4 / 128b   | 4 / 128b   | 17 / 325b  | 17 / 325b  | 2 / 40b    | 2 / 40b    | 2 / 48b        | 2 / 48b        | 2 / 40b        | 2 / 40b        | 6 / 72b        | 7 / 80b        |
+ ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
[+] took 0m0s

[+] Generating Figure 12...
 ✘ no p4-breakdown for 'cache-orig'
 ✔ figure written at /home/gk/ws/netcl-paper-artifact/figure_12.pdf

Program          | Headers+Parsing | Tables | Actions | Registers | RegisterActions | Logic | Other | Compute | Total | NetCL
-----------------------------------------------------------------------------------------------------------------------------
agg-orig.G       | 256             | 65     | 233     | 36        | 500             | 139   | 191   | 720     | 1420  | 38   
agg-orig.H       | 345             | 274    | 206     | 4         | 62              | 168   | 80    | 644     | 1139  | 38   
agg-ours.G       | 256             | 65     | 233     | 36        | 500             | 139   | 191   | 720     | 1420  | 38   
agg-ours.H       | 210             | 122    | 75      | 4         | 63              | 64    | 148   | 347     | 686   | 38   
cache-orig.G     | 214             | 79     | 168     | 15        | 162             | 141   | 186   | 350     | 965   | 91   
cache-ours.G     | 214             | 79     | 168     | 15        | 162             | 141   | 186   | 350     | 965   | 91   
cache-ours.H     | 163             | 73     | 112     | 13        | 146             | 81    | 135   | 428     | 723   | 91   
paxos-acc-orig.G | 223             | 55     | 152     | 10        | 60              | 89    | 157   | 129     | 746   | 38   
paxos-acc-orig.H | 120             | 26     | 27      | 4         | 0               | 14    | 39    | 96      | 230   | 38   
paxos-acc-ours.G | 223             | 55     | 152     | 10        | 60              | 89    | 157   | 129     | 746   | 38   
paxos-acc-ours.H | 138             | 168    | 69      | 11        | 86              | 25    | 76    | 397     | 573   | 38   
paxos-ldr-orig.G | 223             | 65     | 157     | 1         | 12              | 70    | 128   | 54      | 656   | 26   
paxos-ldr-orig.H | 114             | 19     | 18      | 1         | 0               | 11    | 51    | 80      | 214   | 26   
paxos-ldr-ours.G | 223             | 65     | 157     | 1         | 12              | 70    | 128   | 54      | 656   | 26   
paxos-ldr-ours.H | 154             | 26     | 15      | 1         | 12              | 11    | 57    | 96      | 276   | 26   
paxos-lrn-orig.G | 223             | 66     | 155     | 10        | 66              | 84    | 162   | 149     | 766   | 34   
paxos-lrn-orig.H | 114             | 32     | 26      | 3         | 0               | 25    | 41    | 107     | 241   | 34   
calc-ours.G      | 183             | 46     | 99      | 0         | 0               | 81    | 237   | 54      | 646   | 25   
calc-ours.H      | 124             | 22     | 42      | 0         | 0               | 8     | 38    | 89      | 234   | 25   
[+] took 0m6s

Finished after 7m22s
```