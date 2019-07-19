// megafunction wizard: %LPM_MULT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: lpm_mult 

// ============================================================
// File Name: sign_18x18_mult_dsp.v
// Megafunction Name(s):
// 			lpm_mult
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.1.0 Build 625 09/12/2018 SJ Lite Edition
// ************************************************************


//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


//lpm_mult DEVICE_FAMILY="Cyclone 10 LP" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTHA=18 LPM_WIDTHB=18 LPM_WIDTHP=36 MAXIMIZE_SPEED=9 clock dataa datab result
//VERSION_BEGIN 18.1 cbx_cycloneii 2018:09:12:13:04:24:SJ cbx_lpm_add_sub 2018:09:12:13:04:24:SJ cbx_lpm_mult 2018:09:12:13:04:24:SJ cbx_mgl 2018:09:12:13:10:36:SJ cbx_nadder 2018:09:12:13:04:24:SJ cbx_padd 2018:09:12:13:04:24:SJ cbx_stratix 2018:09:12:13:04:24:SJ cbx_stratixii 2018:09:12:13:04:24:SJ cbx_util_mgl 2018:09:12:13:04:24:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = dsp_9bit 2 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  sign_18x18_mult_dsp_mult
	( 
	clock,
	dataa,
	datab,
	result) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   [17:0]  dataa;
	input   [17:0]  datab;
	output   [35:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [35:0]   wire_mac_mult1_dataout;
	wire  [35:0]   wire_mac_out2_dataout;
	wire aclr;
	wire clken;

	cyclone10lp_mac_mult   mac_mult1
	( 
	.dataa({dataa}),
	.datab({datab}),
	.dataout(wire_mac_mult1_dataout),
	.signa(1'b0),
	.signb(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clk(1'b1),
	.ena(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		mac_mult1.dataa_clock = "none",
		mac_mult1.dataa_width = 18,
		mac_mult1.datab_clock = "none",
		mac_mult1.datab_width = 18,
		mac_mult1.signa_clock = "none",
		mac_mult1.signb_clock = "none",
		mac_mult1.lpm_type = "cyclone10lp_mac_mult";
	cyclone10lp_mac_out   mac_out2
	( 
	.aclr(aclr),
	.clk(clock),
	.dataa(wire_mac_mult1_dataout),
	.dataout(wire_mac_out2_dataout),
	.ena(clken)
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		mac_out2.dataa_width = 36,
		mac_out2.output_clock = "0",
		mac_out2.lpm_type = "cyclone10lp_mac_out";
	assign
		aclr = 1'b0,
		clken = 1'b1,
		result = wire_mac_out2_dataout[35:0];
endmodule //sign_18x18_mult_dsp_mult
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module sign_18x18_mult_dsp (
	clock,
	dataa,
	datab,
	result)/* synthesis synthesis_clearbox = 1 */;

	input	  clock;
	input	[17:0]  dataa;
	input	[17:0]  datab;
	output	[35:0]  result;

	wire [35:0] sub_wire0;
	wire [35:0] result = sub_wire0[35:0];

	sign_18x18_mult_dsp_mult	sign_18x18_mult_dsp_mult_component (
				.clock (clock),
				.dataa (dataa),
				.datab (datab),
				.result (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: AutoSizeResult NUMERIC "1"
// Retrieval info: PRIVATE: B_isConstant NUMERIC "0"
// Retrieval info: PRIVATE: ConstantB NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone 10 LP"
// Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "1"
// Retrieval info: PRIVATE: Latency NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
// Retrieval info: PRIVATE: SignedMult NUMERIC "0"
// Retrieval info: PRIVATE: USE_MULT NUMERIC "1"
// Retrieval info: PRIVATE: ValidConstant NUMERIC "0"
// Retrieval info: PRIVATE: WidthA NUMERIC "18"
// Retrieval info: PRIVATE: WidthB NUMERIC "18"
// Retrieval info: PRIVATE: WidthP NUMERIC "36"
// Retrieval info: PRIVATE: aclr NUMERIC "0"
// Retrieval info: PRIVATE: clken NUMERIC "0"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: PRIVATE: optimize NUMERIC "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_HINT STRING "MAXIMIZE_SPEED=9"
// Retrieval info: CONSTANT: LPM_PIPELINE NUMERIC "1"
// Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "UNSIGNED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MULT"
// Retrieval info: CONSTANT: LPM_WIDTHA NUMERIC "18"
// Retrieval info: CONSTANT: LPM_WIDTHB NUMERIC "18"
// Retrieval info: CONSTANT: LPM_WIDTHP NUMERIC "36"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: dataa 0 0 18 0 INPUT NODEFVAL "dataa[17..0]"
// Retrieval info: USED_PORT: datab 0 0 18 0 INPUT NODEFVAL "datab[17..0]"
// Retrieval info: USED_PORT: result 0 0 36 0 OUTPUT NODEFVAL "result[35..0]"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @dataa 0 0 18 0 dataa 0 0 18 0
// Retrieval info: CONNECT: @datab 0 0 18 0 datab 0 0 18 0
// Retrieval info: CONNECT: result 0 0 36 0 @result 0 0 36 0
// Retrieval info: GEN_FILE: TYPE_NORMAL sign_18x18_mult_dsp.vhd TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sign_18x18_mult_dsp.inc TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sign_18x18_mult_dsp.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sign_18x18_mult_dsp.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sign_18x18_mult_dsp_inst.vhd FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sign_18x18_mult_dsp_syn.v TRUE
// Retrieval info: LIB_FILE: lpm
