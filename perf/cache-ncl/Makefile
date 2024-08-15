BUILD := $(shell pwd)/build
NCLSRC := $(shell realpath "cache.cpp")
P4SRC := $(shell realpath "cache.ncl.device.1.p4")
P4CONF := cache.ncl.device.1.conf
P4NAME:= p4_cache_ncl_device_1
CXXFLAGS = -x c++ -g -std=c++17 -mavx2 -pthread
ifdef RX_BURST
    CXXFLAGS += -DRX_BURST
endif

ncl:
	${NCLANG} -ncc -x ncl -ncl-is-device -ncl-target tna -ncl-device-id 1 -emit-asm \
	${NCLSRC} -o $(shell pwd)/cache.ncl.device.1.p4 \
	-mncvm --p4-no-switch-statements -mncvm --speculate=1 \
	-mncvm --ncp-host-multicast-implicit-src-addr \
	-mncvm --ncp-implicit-addr=42.0.0.0 -mncvm --ncp-udp-port=4242

mininet-bfshell:
	mx s1 SDE=${SDE} SDE_INSTALL=${SDE}/install ${SDE}/run_bfshell.sh

mininet-bfrt:
	mx s1 SDE=${SDE} SDE_INSTALL=${SDE}/install ${SDE}/run_bfshell.sh -b ${PWD}/bfrt-cli-model.py

mininet-network: build_dir
	SDE=${SDE} cd ${BUILD} && sudo -E python3 ../network.py

asic-compile: build_dir
	${SDE_INSTALL}/bin/bf-p4c -b tofino -o ${BUILD}/${P4NAME} ${P4SRC}

hosts: client server
hosts-debug: client-debug server-debug

client: client.cpp client_utils.h
	g++ client.cpp -O3 -o client -pthread

client-debug: client.cpp client_utils.h
	g++ -g -DDEBUG client.cpp -o client -lpthread

server: server.cpp server_utils.h
	g++ server.cpp -O3 -o server -pthread

server-debug: server.cpp server_utils.h
	g++ -g -DDEBUG server.cpp -o server -lpthread

asic: asic-compile
	tmux new -d -s switch
	tmux split-window -t switch:0 -v
	tmux send-keys -t switch.0 '${SDE}/run_bfshell.sh -b ${PWD}/bfrt-cli-asic.py' C-m
	tmux send-keys -t switch.1 'cd ${BUILD}/log && ${SDE}/run_switchd.sh -c ${BUILD}/${P4NAME}/${P4CONF} ' C-m
	tmux attach -t switch

asic-bfrt:
	${SDE}/run_bfshell.sh -b ${PWD}/bfrt-cli-asic.py

hpdc-servers-ips:
	ssh hpdc-gnode1 sudo ip addr replace 42.0.0.1/24 dev ens4f0
	ssh hpdc-gnode2 sudo ip addr replace 42.0.0.2/24 dev ens4f0
	ssh hpdc-gnode3 sudo ip addr replace 42.0.0.3/24 dev ens4f0
	ssh hpdc-gnode4 sudo ip addr replace 42.0.0.4/24 dev ens4f0

hpdc-servers-pull:
	ssh hpdc-gnode1 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode2 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode3 "cd netcl-paper-artifact && git reset --hard && git pull"
	ssh hpdc-gnode4 "cd netcl-paper-artifact && git reset --hard && git pull"

hpdc-servers-clone: hpdc-servers-setup-ips
	ssh hpdc-gnode1 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode2 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode3 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"
	ssh hpdc-gnode4 "rm -rf netcl-paper-artifact && git clone https://github.com/net-compute/netcl-paper-artifact"

hpdc-servers-compile: hpdc-servers-pull
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/cache-ncl && make -B client"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/cache-ncl && make -B client"
	ssh hpdc-gnode3 "cd netcl-paper-artifact/perf/cache-ncl && make -B client"
	ssh hpdc-gnode4 "cd netcl-paper-artifact/perf/cache-ncl && make -B server"

hpdc-servers-compile-debug: hpdc-servers-pull
	ssh hpdc-gnode1 "cd netcl-paper-artifact/perf/cache-ncl && make -B client-debug"
	ssh hpdc-gnode2 "cd netcl-paper-artifact/perf/cache-ncl && make -B client-debug"
	ssh hpdc-gnode3 "cd netcl-paper-artifact/perf/cache-ncl && make -B client-debug"
	ssh hpdc-gnode4 "cd netcl-paper-artifact/perf/cache-ncl && make -B server-debug"

clean:
	rm -rf ${BUILD}

build_dir: clean
	mkdir ${BUILD}
	mkdir ${BUILD}/log


