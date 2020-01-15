# Copyright (C) 2018  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: cl10_tube_psu_v5.tcl
# Generated on: Sun Aug 25 19:15:20 2019

# Load Quartus Prime Tcl Project package

package require ::quartus::project
package require ::quartus::flow
package require cmdline

set options \
{\
    { "source_path.arg" "" "testi" } \
}

array set opts [::cmdline::getoptions quartus(args) $options]

set jihuu $opts(source_path)

set tcl_scripts $jihuu
set source_folder $tcl_scripts/../../source

set need_to_close_project 0
set make_assignments 1


# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "cl10_tube_psu_v5"]} {
		puts "Project cl10_tube_psu_v5 is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists cl10_tube_psu_v5]} {
		project_open -revision cl10_tubepsu cl10_tube_psu_v5
	} else {
		project_new -revision cl10_tubepsu cl10_tube_psu_v5
	}
	set need_to_close_project 1
}

# read sources
source ../list_of_sources.tcl
	set_global_assignment -name MIF_FILE $tcl_scripts/../intel_specifics/memory_files/sine_u16x512_halfpi.mif
	set_global_assignment -name QIP_FILE $tcl_scripts/../intel_specifics/memory_files/rom1port_16x512.qip
	set_global_assignment -name QIP_FILE $tcl_scripts/../intel_specifics/multiplier/sign_18x18_mult_dsp.qip
	set_global_assignment -name QIP_FILE $tcl_scripts/../intel_specifics/main_pll.qip

	set_global_assignment -name VHDL_FILE $source_folder/cyclone_10lp/cl10_specifics.vhd
	set_global_assignment -name VHDL_FILE $source_folder/cyclone_10lp/cl10_pll_wrapper.vhd
	set_global_assignment -name VHDL_FILE $source_folder/cyclone_10lp/cl10_adc_wrapper.vhd
	set_global_assignment -name VHDL_FILE $source_folder/cyclone_10lp/cl10_multiplier_wrapper.vhd

    foreach x [read_sources ../] \
    { \
        if {[lsearch -glob $x *onboard_ad_control*] == 0} \
        { \
            set_global_assignment -name VHDL_FILE $source_folder/$x -library onboard_adc_library
        } \
        else \
        { \
            set_global_assignment -name VHDL_FILE $source_folder/$x \
        } \
    }

# Make assignments
if {$make_assignments} {
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 17.0.2
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "20:17:12  OCTOBER 15, 2017"
	set_global_assignment -name LAST_QUARTUS_VERSION "18.1.0 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name NUM_PARALLEL_PROCESSORS ALL
	set_global_assignment -name SMART_RECOMPILE ON
	set_global_assignment -name FLOW_ENABLE_IO_ASSIGNMENT_ANALYSIS ON
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP "-40"
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
	set_global_assignment -name TIMING_ANALYZER_MULTICORNER_ANALYSIS ON
	set_global_assignment -name OPTIMIZATION_MODE BALANCED
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 256
	set_global_assignment -name EDA_DESIGN_ENTRY_SYNTHESIS_TOOL "Synplify Pro"
	set_global_assignment -name TOP_LEVEL_ENTITY top
	set_global_assignment -name FAMILY "Cyclone 10 LP"
	set_global_assignment -name CYCLONEII_OPTIMIZATION_TECHNIQUE BALANCED
	set_global_assignment -name MUX_RESTRUCTURE OFF
	set_global_assignment -name ADV_NETLIST_OPT_SYNTH_WYSIWYG_REMAP ON
	set_global_assignment -name REMOVE_REDUNDANT_LOGIC_CELLS ON
	set_global_assignment -name PRE_MAPPING_RESYNTHESIS ON
	set_global_assignment -name PROJECT_IP_REGENERATION_POLICY ALWAYS_REGENERATE_IP
    set_global_assignment -name VHDL_INPUT_VERSION VHDL_1993
	set_global_assignment -name VHDL_SHOW_LMF_MAPPING_MESSAGES OFF
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 7
	set_global_assignment -name STATE_MACHINE_PROCESSING "ONE-HOT"
	set_global_assignment -name DEVICE 10CL010YU256I7G
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
	set_global_assignment -name PHYSICAL_SYNTHESIS_COMBO_LOGIC ON
	set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON
	set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_RETIMING ON
	set_global_assignment -name ROUTER_LCELL_INSERTION_AND_LOGIC_DUPLICATION ON
	set_global_assignment -name ROUTER_TIMING_OPTIMIZATION_LEVEL MAXIMUM
	set_global_assignment -name QII_AUTO_PACKED_REGISTERS NORMAL
	set_global_assignment -name FITTER_EFFORT "STANDARD FIT"
	set_global_assignment -name ECO_OPTIMIZE_TIMING ON
	set_global_assignment -name FITTER_AGGRESSIVE_ROUTABILITY_OPTIMIZATION AUTOMATICALLY
	set_global_assignment -name ROUTER_CLOCKING_TOPOLOGY_ANALYSIS ON
	set_global_assignment -name PHYSICAL_SYNTHESIS_ASYNCHRONOUS_SIGNAL_PIPELINING ON
	set_global_assignment -name PHYSICAL_SYNTHESIS_EFFORT NORMAL
	set_global_assignment -name ENABLE_CONFIGURATION_PINS OFF
	set_global_assignment -name ENABLE_BOOT_SEL_PIN OFF
	set_global_assignment -name CRC_ERROR_OPEN_DRAIN OFF
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVCMOS"
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (VHDL)"
	set_global_assignment -name ENABLE_OCT_DONE OFF
	set_global_assignment -name USE_CONFIGURATION_DEVICE OFF
	set_global_assignment -name ENABLE_DRC_SETTINGS ON
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name POWER_DEFAULT_TOGGLE_RATE 12.5%
	set_global_assignment -name POWER_DEFAULT_INPUT_IO_TOGGLE_RATE 12.5%
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -fall
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -fall
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME tuitui -section_id testi
	set_global_assignment -name EDA_TEST_BENCH_RUN_SIM_FOR "1 us" -section_id testi
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME testi -section_id testi
	set_global_assignment -name EDA_TEST_BENCH_FILE source/ext_ad/extad_tb.vhd -section_id testi
	set_global_assignment -name EDA_LMF_FILE synplcty.lmf -section_id eda_design_synthesis
	set_global_assignment -name EDA_RUN_TOOL_AUTOMATICALLY OFF -section_id eda_design_synthesis
	set_global_assignment -name EDA_INPUT_DATA_FORMAT VQM -section_id eda_design_synthesis
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT VHDL -section_id eda_simulation
	set_global_assignment -name EDA_TEST_BENCH_ENABLE_STATUS NOT_USED -section_id eda_simulation
	set_global_assignment -name EDA_NATIVELINK_SIMULATION_TEST_BENCH testi -section_id eda_simulation
	set_global_assignment -name EDA_TEST_BENCH_NAME testi -section_id eda_simulation
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name FINAL_PLACEMENT_OPTIMIZATION AUTOMATICALLY
	set_global_assignment -name REMOVE_DUPLICATE_REGISTERS ON
	set_global_assignment -name EDA_GENERATE_FUNCTIONAL_NETLIST ON -section_id eda_simulation
	set_global_assignment -name SAFE_STATE_MACHINE ON

	# pin assignments
	set_location_assignment PIN_M1 -to xclk
	set_location_assignment PIN_G16 -to system_control_FPGA_out.bypass_relay

	set_location_assignment PIN_R8 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led1.red
	set_location_assignment PIN_T7 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led1.green
	set_location_assignment PIN_T8 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led1.blue

	set_location_assignment PIN_T6 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led2.red
	set_location_assignment PIN_R6 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led2.green
	set_location_assignment PIN_R7 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led2.blue

    set_location_assignment PIN_T3 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led3.red
	set_location_assignment PIN_R3 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led3.green
	set_location_assignment PIN_R4 -to system_control_FPGA_out.component_interconnect_FPGA_out.po3_led3.blue

	set_location_assignment PIN_T9  -to system_control_FPGA_in.component_interconnect_FPGA_in.onboard_ad_control_FPGA_in.ada_data
	set_location_assignment PIN_R10 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.ada_clock
    set_location_assignment PIN_R9  -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.ada_cs
	set_location_assignment PIN_T10 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.ada_mux[0]
	set_location_assignment PIN_R11 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.ada_mux[1]
	set_location_assignment PIN_T11 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.ada_mux[2]

	set_location_assignment PIN_R5 -to system_control_FPGA_in.component_interconnect_FPGA_in.onboard_ad_control_FPGA_in.adb_data
	set_location_assignment PIN_T4 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.adb_cs
	set_location_assignment PIN_T5 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.adb_clock
	set_location_assignment PIN_R12 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.adb_mux[0]
	set_location_assignment PIN_R13 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.adb_mux[1]
	set_location_assignment PIN_T12 -to system_control_FPGA_out.component_interconnect_FPGA_out.onboard_ad_control_FPGA_out.adb_mux[2]
# 

	set_location_assignment PIN_K15 -to system_control_FPGA_in.component_interconnect_FPGA_in.pi_uart_rx_serial
	set_location_assignment PIN_L15 -to system_control_FPGA_out.component_interconnect_FPGA_out.po_uart_tx_serial

	# set_location_assignment PIN_F15 -to po_ext_ad1_clk
	# set_location_assignment PIN_A14 -to po_ext_ad1_cs
	# set_location_assignment PIN_C16 -to po_ext_ad2_clk
	# set_location_assignment PIN_B13 -to po_ext_ad2_cs
	# set_location_assignment PIN_C15 -to pi_ext_ad1_sdata
	# set_location_assignment PIN_D15 -to pi_ext_ad2_sdata
    #
	# set_location_assignment PIN_J15 -to po2_pfc_pwm.ac1
	# set_location_assignment PIN_T13 -to po2_pfc_pwm.ac2
	# set_location_assignment PIN_A11 -to po4_dhb_pwm.pri_high
	# set_location_assignment PIN_B12 -to po4_dhb_pwm.pri_low
	# set_location_assignment PIN_B14 -to po4_dhb_pwm.sec_high
	# set_location_assignment PIN_B16 -to po4_dhb_pwm.sec_low
	# set_location_assignment PIN_A13 -to po4_ht_pwm.pri_high
	# set_location_assignment PIN_A12 -to po4_ht_pwm.pri_low
	# set_location_assignment PIN_A15 -to po4_ht_pwm.sync1
	# set_location_assignment PIN_D16 -to po4_ht_pwm.sync2
    #
	set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "main_pll:core_clocks|altpll:altpll_component|main_pll_altpll:auto_generated|wire_pll1_clk[2]"
	set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "main_pll:core_clocks|altpll:altpll_component|main_pll_altpll:auto_generated|wire_pll1_clk[0]"
	set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "main_pll:core_clocks|altpll:altpll_component|main_pll_altpll:auto_generated|wire_pll1_clk[1]"
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	#if {$need_to_close_project} {
	#	project_close
	#}
}

set_global_assignment -name SDC_FILE $tcl_scripts/cl10_tubepsu_constraints.sdc

#compile flow
#
execute_flow -compile

#call external executables to generate flash image and program cfi flash
exec quartus_cpf -c $tcl_scripts/generate_flash_image.cof

# program fpga ram
exec quartus_pgm -c "USB-Blaster \[USB-0\]" -m JTAG -o "p;./output_files/cl10_tubepsu.sof"
# program fpga flash
# exec quartus_pgm -i -c "USB-Blaster \[USB-0\]" -m JTAG -o "ipv;./output_files/output_file.jic"


