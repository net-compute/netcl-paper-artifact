	bit<8> _lv__0_ncvm_scf_pred_var_0 = 0;
	bit<32> ncvm_swi_tbl_key_0;
	table ncvm_swi_tbl_0 {
		key = { ncvm_swi_tbl_key_0 : exact; }
		actions = {ncvm_swi_tbl_0_action_0; ncvm_swi_tbl_0_action_1; ncvm_swi_tbl_0_action_2; ncvm_swi_tbl_0_action_3; ncvm_swi_tbl_0_action_4; ncvm_swi_tbl_0_action_default; }
		const default_action = ncvm_swi_tbl_0_action_default();
		const size = 5;
		const entries = {
			1 : ncvm_swi_tbl_0_action_0;
			2 : ncvm_swi_tbl_0_action_1;
			3 : ncvm_swi_tbl_0_action_2;
			0 : ncvm_swi_tbl_0_action_3;
			4 : ncvm_swi_tbl_0_action_4;
		}
	}
	action ncvm_add_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a + b)); }
	action ncvm_and_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a & b)); }
	action ncvm_or_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a | b)); }
	action ncvm_sub_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a - b)); }
	action ncvm_xor_32_32_32(out bit<32> c, in bit<32> a, in bit<32> b) {	c = ((bit<32>) (a ^ b)); }
	apply {
		ncvm_swi_tbl_key_0 = H.ncp_data_1_0[0].value;
		switch (ncvm_swi_tbl_0.apply().action_run) {
			ncvm_swi_tbl_0_action_2 : {
				ncvm_or_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_4 : {
				ncvm_xor_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_0 : {
				ncvm_sub_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_1[0].value, H.ncp_data_1_2[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_default : {
				ncvm_action_drop(M);
				_lv__0_ncvm_scf_pred_var_0 = 0;
			}
			ncvm_swi_tbl_0_action_3 : {
				ncvm_add_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
			ncvm_swi_tbl_0_action_1 : {
				ncvm_and_32_32_32(H.ncp_data_1_3[0].value, H.ncp_data_1_2[0].value, H.ncp_data_1_1[0].value);
				_lv__0_ncvm_scf_pred_var_0 = 1;
			}
		}
		if ((_lv__0_ncvm_scf_pred_var_0 == 0)) { }
		else {
			ncvm_action_reflect(M);
		}
		return;
	}