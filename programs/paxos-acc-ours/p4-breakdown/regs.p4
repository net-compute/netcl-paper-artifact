Register<bit<DATAPATH_SIZE>, bit<1>>(1) registerAcceptorID;
Register<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerVRound;

// VALUE
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue1;
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue2;
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue3;
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue4;
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue5;
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue6;
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue7;
Register<bit<32>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerValue8;
Register<bit<ROUND_SIZE>, bit<INSTANCE_SIZE>>(INSTANCE_COUNT) registerRound;