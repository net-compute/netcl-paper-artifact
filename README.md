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
[+] took 0m22s

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
| empty                     | -    | 0      | -          |      | -      | 0      | -           |      | 568    |
| paxos--combined--orig     | 74   | 381    | 5.15       |      | 68     | 743    | 10.04       |      | -      |
| paxos--combined--ours     | 74   | 901    | 12.18      |      | 68     | 1441   | 19.47       |      | -      |
| paxos-acc-orig            | 38   | 230    | 6.05       |      | 34     | 208    | 5.47        |      | 746    |
| paxos-acc-ours            | 38   | 573    | 15.08      |      | 34     | 550    | 14.47       |      | 746    |
| paxos-ldr-orig            | 26   | 214    | 8.23       |      | 23     | 192    | 7.38        |      | 656    |
| paxos-ldr-ours            | 26   | 276    | 10.62      |      | 23     | 253    | 9.73        |      | 656    |
| paxos-lrn-orig            | 33   | 241    | 7.30       |      | 31     | 219    | 6.64        |      | 766    |
| paxos-lrn-ours            | 33   | 436    | 13.21      |      | 31     | 413    | 12.52       |      | 766    |
+ ------------------------- + ---- + ------ + ---------- +      + ------ + ------ + ----------- +      + ------ +
[+] took 0m0s

[+] Generating Table 4...
[====>] timing NetCL and P4-Gen compilation (5/5) of: paxos-lrn-ours
[====>] timing NetCL and P4-Gen compilation (5/5) of: empty
[====>] timing NetCL and P4-Gen compilation (5/5) of: paxos-acc-ours
[====>] timing NetCL and P4-Gen compilation (5/5) of: paxos-ldr-orig
[====>] timing NetCL and P4-Gen compilation (5/5) of: paxos-lrn-orig
[====>] timing NetCL and P4-Gen compilation (5/5) of: paxos-ldr-ours
[====>] timing NetCL and P4-Gen compilation (5/5) of: cache-ours
[====>] timing NetCL and P4-Gen compilation (5/5) of: calc-orig
[====>] timing NetCL and P4-Gen compilation (5/5) of: cache-orig
[====>] timing NetCL and P4-Gen compilation (5/5) of: calc-ours
[====>] timing NetCL and P4-Gen compilation (5/5) of: agg-ours
[====>] timing NetCL and P4-Gen compilation (5/5) of: agg-orig
[====>] timing NetCL and P4-Gen compilation (5/5) of: paxos-acc-orig
+ --- + -------- + -------- + ---------- + ---------- + --------- + --------- + ----- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
|     | agg-orig | agg-ours | cache-orig | cache-ours | calc-orig | calc-ours | empty | paxos-acc-orig | paxos-acc-ours | paxos-ldr-orig | paxos-ldr-ours | paxos-lrn-orig | paxos-lrn-ours |
+ --- + -------- + -------- + ---------- + ---------- + --------- + --------- + ----- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
| ncc | 0.73     | 0.72     | 0.73       | 0.73       | 0.71      | 0.69      | 0.70  | 0.71           | 0.70           | 0.71           | 0.69           | 0.69           | 0.70           |
| p4c | 10.96    | 10.95    | 5.45       | 5.49       | 3.20      | 3.23      | 2.53  | 4.07           | 4.07           | 3.49           | 3.49           | 4.04           | 4.07           |
| tot | 11.69    | 11.67    | 6.18       | 6.22       | 3.91      | 3.92      | 3.22  | 4.78           | 4.77           | 4.19           | 4.18           | 4.74           | 4.78           |
+ --- + -------- + -------- + ---------- + ---------- + --------- + --------- + ----- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
[====>] timing P4 compilation (5/5) of: paxos-lrn-ours
[====>] timing P4 compilation (5/5) of: paxos-acc-ours
[====>] timing P4 compilation (5/5) of: paxos-ldr-ours
[====>] timing P4 compilation (5/5) of: cache-ours
[====>] timing P4 compilation (5/5) of: calc-ours
[====>] timing P4 compilation (5/5) of: agg-ours
+ --- + -------- + ---------- + --------- + -------------- + -------------- + -------------- +
|     | agg-ours | cache-ours | calc-ours | paxos-acc-ours | paxos-ldr-ours | paxos-lrn-ours |
+ --- + -------- + ---------- + --------- + -------------- + -------------- + -------------- +
| p4c | 8.82     | 5.50       | 1.39      | 3.35           | 1.88           | 2.30           |
+ --- + -------- + ---------- + --------- + -------------- + -------------- + -------------- +
[+] took 9m13s

[+] Generating Table 6...
+ ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
|            | agg-orig   | agg-ours   | cache-orig | cache-ours | calc-orig  | calc-ours  | empty      | paxos-acc-orig | paxos-acc-ours | paxos-ldr-orig | paxos-ldr-ours | paxos-lrn-orig | paxos-lrn-ours |
+ ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
| IR Allocas | 0          | 0          | 0          | 0          | 1 / 8b     | 1 / 8b     | 0          | 0              | 0              | 1 / 8b         | 1 / 8b         | 1 / 8b         | 1 / 8b         |
| P4 Locvars | 4 / 128b   | 4 / 128b   | 17 / 325b  | 17 / 325b  | 2 / 40b    | 2 / 40b    | 0          | 2 / 48b        | 2 / 48b        | 2 / 40b        | 2 / 40b        | 6 / 72b        | 6 / 72b        |
+ ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + ---------- + -------------- + -------------- + -------------- + -------------- + -------------- + -------------- +
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
paxos-lrn-orig.G | 223             | 66     | 155     | 10        | 66              | 84    | 162   | 149     | 766   | 33   
paxos-lrn-orig.H | 114             | 32     | 26      | 3         | 0               | 25    | 41    | 107     | 241   | 33   
paxos-lrn-ours.G | 223             | 66     | 155     | 10        | 66              | 84    | 162   | 149     | 766   | 33   
paxos-lrn-ours.H | 154             | 67     | 45      | 10        | 66              | 36    | 58    | 263     | 436   | 33   
calc-orig.G      | 183             | 46     | 99      | 0         | 0               | 81    | 237   | 54      | 646   | 25   
calc-orig.H      | 48              | 21     | 18      | 0         | 0               | 7     | 45    | 75      | 139   | 25   
calc-ours.G      | 183             | 46     | 99      | 0         | 0               | 81    | 237   | 54      | 646   | 25   
calc-ours.H      | 124             | 22     | 42      | 0         | 0               | 8     | 38    | 89      | 234   | 25   


Program          | Headers+Parsing | Tables | Actions | Registers | RegisterActions | Logic | Other | Compute | Total   | NetCL
-------------------------------------------------------------------------------------------------------------------------------
agg-orig.G       | 18.03           | 4.58   | 16.41   | 2.54      | 35.21           | 9.79  | 13.45 | 50.70   | 1420  | 2.68 
agg-orig.H       | 30.29           | 24.06  | 18.09   | 0.35      | 5.44            | 14.75 | 7.02  | 56.54   | 1139  | 3.34 
agg-ours.G       | 18.03           | 4.58   | 16.41   | 2.54      | 35.21           | 9.79  | 13.45 | 50.70   | 1420  | 2.68 
agg-ours.H       | 30.61           | 17.78  | 10.93   | 0.58      | 9.18            | 9.33  | 21.57 | 50.58   | 686   | 5.54 
cache-orig.G     | 22.18           | 8.19   | 17.41   | 1.55      | 16.79           | 14.61 | 19.27 | 36.27   | 965   | 9.43 
cache-ours.G     | 22.18           | 8.19   | 17.41   | 1.55      | 16.79           | 14.61 | 19.27 | 36.27   | 965   | 9.43 
cache-ours.H     | 22.54           | 10.10  | 15.49   | 1.80      | 20.19           | 11.20 | 18.67 | 59.20   | 723   | 12.59
paxos-acc-orig.G | 29.89           | 7.37   | 20.38   | 1.34      | 8.04            | 11.93 | 21.05 | 17.29   | 746   | 5.09 
paxos-acc-orig.H | 52.17           | 11.30  | 11.74   | 1.74      | 0.00            | 6.09  | 16.96 | 41.74   | 230   | 16.52
paxos-acc-ours.G | 29.89           | 7.37   | 20.38   | 1.34      | 8.04            | 11.93 | 21.05 | 17.29   | 746   | 5.09 
paxos-acc-ours.H | 24.08           | 29.32  | 12.04   | 1.92      | 15.01           | 4.36  | 13.26 | 69.28   | 573   | 6.63 
paxos-ldr-orig.G | 33.99           | 9.91   | 23.93   | 0.15      | 1.83            | 10.67 | 19.51 | 8.23    | 656   | 3.96 
paxos-ldr-orig.H | 53.27           | 8.88   | 8.41    | 0.47      | 0.00            | 5.14  | 23.83 | 37.38   | 214   | 12.15
paxos-ldr-ours.G | 33.99           | 9.91   | 23.93   | 0.15      | 1.83            | 10.67 | 19.51 | 8.23    | 656   | 3.96 
paxos-ldr-ours.H | 55.80           | 9.42   | 5.43    | 0.36      | 4.35            | 3.99  | 20.65 | 34.78   | 276   | 9.42 
paxos-lrn-orig.G | 29.11           | 8.62   | 20.23   | 1.31      | 8.62            | 10.97 | 21.15 | 19.45   | 766   | 4.31 
paxos-lrn-orig.H | 47.30           | 13.28  | 10.79   | 1.24      | 0.00            | 10.37 | 17.01 | 44.40   | 241   | 13.69
paxos-lrn-ours.G | 29.11           | 8.62   | 20.23   | 1.31      | 8.62            | 10.97 | 21.15 | 19.45   | 766   | 4.31 
paxos-lrn-ours.H | 35.32           | 15.37  | 10.32   | 2.29      | 15.14           | 8.26  | 13.30 | 60.32   | 436   | 7.57 
calc-orig.G      | 28.33           | 7.12   | 15.33   | 0.00      | 0.00            | 12.54 | 36.69 | 8.36    | 646   | 3.87 
calc-orig.H      | 34.53           | 15.11  | 12.95   | 0.00      | 0.00            | 5.04  | 32.37 | 53.96   | 139   | 17.99
calc-ours.G      | 28.33           | 7.12   | 15.33   | 0.00      | 0.00            | 12.54 | 36.69 | 8.36    | 646   | 3.87 
calc-ours.H      | 52.99           | 9.40   | 17.95   | 0.00      | 0.00            | 3.42  | 16.24 | 38.03   | 234   | 10.68
[+] took 0m26s

Finished after 10m1s
```