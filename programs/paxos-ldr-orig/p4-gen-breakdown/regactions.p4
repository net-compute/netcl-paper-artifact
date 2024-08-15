RegisterAction<bit<32>, bit<8>, bit<32>>(_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance) __ra__ncvm_atomic_write_u32_0_0_0_e_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = ((bit<32>) R);
		R = 0;
	}
};
RegisterAction<bit<32>, bit<8>, bit<32>>(_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance) __ra__ncvm_atomic_add_u32_1_1_0_e_0_ = {
	void apply(inout bit<32> R, out bit<32> O){
		O = R;
		R = (R + 1);
	}
};