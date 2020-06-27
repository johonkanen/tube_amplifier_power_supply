ram_2_port_inst : ram_2_port PORT MAP (
		clock	 => clock_sig,
		data	 => data_sig,
		rdaddress	 => rdaddress_sig,
		wraddress	 => wraddress_sig,
		wren	 => wren_sig,
		q	 => q_sig
	);
