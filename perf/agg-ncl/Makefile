BUILD := $(shell pwd)/build
NCLSRC := $(shell realpath "allreduce-${WORKERS}.ncl")
P4SRC := $(shell realpath "allreduce-${WORKERS}.ncl.device.1.p4")
P4CONF := allreduce-${WORKERS}.ncl.device.1.conf
P4NAME:= p4_allreduce_${WORKERS}_ncl_device_1
CXXFLAGS = -x c++ -std=c++17 -mavx2 -lpthread
ifdef RX_BURST
    CXXFLAGS += -DRX_BURST
endif

ncl:
	${NCLANG} -ncc -ncl-is-device -ncl-target tna -ncl-device-id 1 -ncl-implicit-drop -emit-asm \
	${NCLSRC} -o $(shell pwd)/allreduce-${WORKERS}.ncl.device.1.p4 \
	-mncvm --p4-no-switch-statements -mncvm --speculate=1 \
	-mncvm --ncp-host-reflect-implicit-src-addr -mncvm --ncp-host-multicast-implicit-src-addr \
	-mncvm --ncp-implicit-addr=42.0.0.0 -mncvm --ncp-udp-port=4242

worker: worker.cpp worker_utils.h
	g++ ${CXXFLAGS} -O3 worker.cpp -o worker

worker-debug: worker.cpp worker_utils.h
	g++ ${CXXFLAGS} -g -DDEBUG worker.cpp -o worker

mininet-bfshell:
	mx s1 SDE=${SDE} SDE_INSTALL=${SDE}/install ${SDE}/run_bfshell.sh

mininet-bfrt:
	mx s1 SDE=${SDE} SDE_INSTALL=${SDE}/install ${SDE}/run_bfshell.sh -b ${PWD}/bfrt-cli-model.py

mininet-network: build_dir
	SDE=${SDE} cd ${BUILD} && sudo -E python3 ../network.py

asic: build-dir
	${SDE_INSTALL}/bin/bf-p4c -b tofino -o ${BUILD}/${P4NAME} ${P4SRC}
	tmux new -d -s switch
	tmux split-window -t switch:0 -v
	tmux send-keys -t switch.0 '${SDE}/run_bfshell.sh -b ${PWD}/bfrt-cli-asic.py' C-m
	tmux send-keys -t switch.1 'cd ${BUILD}/log && ${SDE}/run_switchd.sh -c ${BUILD}/${P4NAME}/${P4CONF} ' C-m
	tmux attach -t switch

asic-bfshel:
	SDE=${SDE} SDE_INSTALL=${SDE}/install ${SDE}/run_bfshell.sh

asic-bfrt:
	${SDE}/run_bfshell.sh -b ${PWD}/bfrt-cli-asic.py

hpdc-2-servers-ips:
	ssh hpdc-gnode1 sudo ip addr replace 42.0.0.1/24 dev ens4f0
	ssh hpdc-gnode2 sudo ip addr replace 42.0.0.2/24 dev ens4f0

hpdc-4-servers-ips:
	ssh hpdc-gnode1 sudo ip addr replace 42.0.0.1/24 dev ens4f0
	ssh hpdc-gnode2 sudo ip addr replace 42.0.0.2/24 dev ens4f0
	ssh hpdc-gnode3 sudo ip addr replace 42.0.0.3/24 dev ens4f0
	ssh hpdc-gnode4 sudo ip addr replace 42.0.0.4/24 dev ens4f0

hpdc-6-servers-ips:
	ssh hpdc-gnode1 sudo ip addr replace 42.0.0.1/24 dev ens4f0
	ssh hpdc-gnode2 sudo ip addr replace 42.0.0.2/24 dev ens4f0
	ssh hpdc-gnode3 sudo ip addr replace 42.0.0.3/24 dev ens4f0
	ssh hpdc-gnode4 sudo ip addr replace 42.0.0.4/24 dev ens4f0
	ssh hpdc-gnode5 sudo ip addr replace 42.0.0.5/24 dev ens4f0
	ssh hpdc-gnode6 sudo ip addr replace 42.0.0.6/24 dev ens4f0

hpdc-2-servers-pull:
	ssh hpdc-gnode1 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode2 "cd netcl-paper-artifact && git reset --hard && git pull"

hpdc-4-servers-pull:
	ssh hpdc-gnode1 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode2 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode3 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode4 "cd netcl-paper-artifact && git reset --hard && git pull"

hpdc-6-servers-pull:
	ssh hpdc-gnode1 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode2 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode3 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode4 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode5 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode6 "cd netcl-paper-artifact && git reset --hard && git pull"

hpdc-2-servers-clone: hpdc-2-servers-setup-ips
	ssh hpdc-gnode1 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode2 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"

hpdc-4-servers-clone: hpdc-4-servers-setup-ips
	ssh hpdc-gnode1 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode2 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode3 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode4 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"

hpdc-6-servers-clone: hpdc-4-servers-setup-ips
	ssh hpdc-gnode1 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode2 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode3 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode4 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode5 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode6 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"

hpdc-2-servers-compile:
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"

hpdc-2-servers-compile-debug:
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker-debug"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker-debug"

hpdc-4-servers-compile:
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode3 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode4 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"

hpdc-4-servers-compile-debug:
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode3 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode4 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"

hpdc-6-servers-compile:
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode3 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode4 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode5 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode6 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"

hpdc-6-servers-compile-debug:
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode3 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode4 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode5 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"
	ssh hpdc-gnode6 "cd netcl-paper-artifact/perf/agg-ncl && make -B worker"

clean:
	rm -rf ${BUILD}

build_dir: clean
	mkdir ${BUILD}
	mkdir ${BUILD}/log


