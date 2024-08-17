_box_h<bit<32>>[1] ncp_data_1_0;
_box_h<bit<32>>[1] ncp_data_1_1;
_box_h<bit<16>>[1] ncp_data_1_2;
_box_h<bit<16>>[1] ncp_data_1_3;
_box_h<bit<8>>[1] ncp_data_1_4;
_box_h<bit<32>>[8] ncp_data_1_5;
bit<8> _lv__0_ncvm_scf_pred_var_0 = 0;
Register<bit<32>, bit<8>>(1) _mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance;
bit<32> ncvm_swi_tbl_key_0;
table ncvm_swi_tbl_0 {
	key = { ncvm_swi_tbl_key_0 : exact; }
	actions = {ncvm_swi_tbl_0_action_0; ncvm_swi_tbl_0_action_1; ncvm_swi_tbl_0_action_default; }
	const default_action = ncvm_swi_tbl_0_action_default();
	const size = 2;
	const entries = {
		16 : ncvm_swi_tbl_0_action_0;
		32 : ncvm_swi_tbl_0_action_1;
	}
}
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
action mem_rmw_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(in bit<8> i) {	__ra__ncvm_atomic_write_u32_0_0_0_e_0_.execute(i); }
action mem_rmw_o_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(out bit<32> o, in bit<8> i) {	o = __ra__ncvm_atomic_add_u32_1_1_0_e_0_.execute(i); }
apply {
	ncvm_swi_tbl_key_0 = H.ncp_data_1_0[0].value;
	switch (ncvm_swi_tbl_0.apply().action_run) {
		ncvm_swi_tbl_0_action_default : { _lv__0_ncvm_scf_pred_var_0 = 0; }
		ncvm_swi_tbl_0_action_1 : {
			mem_rmw_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(0);
			_lv__0_ncvm_scf_pred_var_0 = 0;
		}
		ncvm_swi_tbl_0_action_0 : {
			H.ncp_data_1_0[0].value = 4;
			mem_rmw_o_0_mem__ZZ6leaderR8msg_typeRjtRtRhPjE8Instance(H.ncp_data_1_1[0].value, 0);
			ncvm_action_multicast(M, 11);
			_lv__0_ncvm_scf_pred_var_0 = 1;
		}
	}
	if ((_lv__0_ncvm_scf_pred_var_0 == 1)) { }
	else {
		ncvm_action_drop(M);
	}
	return;
}