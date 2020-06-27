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

# example command line
# quartus_sh -t ../cyclone_10/tcl/cl10_tube_psu_v5.tcl -source_path ../cyclone_10/tcl/ -card_version u10 -load_program_to ram

package require ::quartus::project
package require ::quartus::flow
package require cmdline

set options \
{\
    { "source_path.arg"} \
    { "card_version.arg"} \
    { "load_program_to.arg"} \
    { "usb_cable.arg"} \
    { "clean_all.arg"} \
}

#possible versions, u10, u25

array set opts [::cmdline::getoptions quartus(args) $options]

set tcl_scripts $opts(source_path)
set source_folder $tcl_scripts/../../source

set need_to_close_project 0

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "cl10_tube_psu_v5"]} {
		puts "Project cl10_tube_psu_v5 is not open"
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

if {$opts(card_version) == "u10"} \
{
    set fpga_device 10CL010YU256I7G
}\
else \
{
    set fpga_device 10CL025YU256I7G
}

# read sources
source ../list_of_sources.tcl

	# set_global_assignment -name MIF_FILE $tcl_scripts/../intel_specifics/memory_files/sine_u16x512_halfpi.mif
	# set_global_assignment -name QIP_FILE $tcl_scripts/../intel_specifics/memory_files/rom1port_16x512.qip
	# set_global_assignment -name QIP_FILE $tcl_scripts/../intel_specifics/multiplier/sign_18x18_mult_dsp.qip
	set_global_assignment -name QIP_FILE $tcl_scripts/../ip_components/$opts(card_version)_clocks/main_pll.qip

	set_global_assignment -name QIP_FILE $tcl_scripts/../ip_components/fifo/uart_fifo.qip
	set_global_assignment -name VHDL_FILE $source_folder/../cyclone_10/source_cl10/cl10_fifo_control_pkg.vhd

	set_global_assignment -name QIP_FILE $tcl_scripts/../ip_components/two_port_ram/ram_2_port.qip
	set_global_assignment -name VHDL_FILE $source_folder/../cyclone_10/source_cl10/ram_control_pkg.vhd

	set_global_assignment -name VHDL_FILE $source_folder/../cyclone_10/source_cl10/cl10_specifics.vhd
	set_global_assignment -name VHDL_FILE $source_folder/../cyclone_10/source_cl10/cl10_pll_wrapper.vhd
	set_global_assignment -name VHDL_FILE $source_folder/../cyclone_10/source_cl10/cl10_adc_wrapper.vhd
	set_global_assignment -name VHDL_FILE $source_folder/../cyclone_10/source_cl10/cl10_multiplier_wrapper.vhd

    foreach x [read_sources ../] \
    { \
        if {[lsearch -glob $x *measurement_interface*] == 0} \
        { \
            set_global_assignment -name VHDL_FILE $source_folder/$x -library onboard_adc_library
        } \
        elseif {[lsearch -glob $x *common*] == 0} \
        { \
            set_global_assignment -name VHDL_FILE $source_folder/$x -library common_library
        } \
        else \
        { \
            set_global_assignment -name VHDL_FILE $source_folder/$x \
        } 
    }

# Make assignments
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
	set_global_assignment -name OPTIMIZATION_MODE "AGGRESSIVE PERFORMANCE" 
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 256
	set_global_assignment -name EDA_DESIGN_ENTRY_SYNTHESIS_TOOL "Synplify Pro"
	set_global_assignment -name TOP_LEVEL_ENTITY top
	set_global_assignment -name FAMILY "Cyclone 10 LP"
	set_global_assignment -name CYCLONEII_OPTIMIZATION_TECHNIQUE SPEED 
	set_global_assignment -name MUX_RESTRUCTURE OFF
	set_global_assignment -name ADV_NETLIST_OPT_SYNTH_WYSIWYG_REMAP ON
	set_global_assignment -name REMOVE_REDUNDANT_LOGIC_CELLS ON
	set_global_assignment -name PRE_MAPPING_RESYNTHESIS ON
	set_global_assignment -name PROJECT_IP_REGENERATION_POLICY ALWAYS_REGENERATE_IP
    set_global_assignment -name VHDL_INPUT_VERSION VHDL_1993
	set_global_assignment -name VHDL_SHOW_LMF_MAPPING_MESSAGES OFF
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 7
	set_global_assignment -name STATE_MACHINE_PROCESSING "ONE-HOT"
	set_global_assignment -name DEVICE $fpga_device
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

	set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "main_pll:core_clocks|altpll:altpll_component|main_pll_altpll:auto_generated|wire_pll1_clk[2]"
	set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "main_pll:core_clocks|altpll:altpll_component|main_pll_altpll:auto_generated|wire_pll1_clk[0]"
	set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to "main_pll:core_clocks|altpll:altpll_component|main_pll_altpll:auto_generated|wire_pll1_clk[1]"
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

source $tcl_scripts/route_fpga_pins.tcl
place_fpga_pins_for_$fpga_device

	export_assignments

set_global_assignment -name SDC_FILE $tcl_scripts/cl10_tubepsu_constraints.sdc

#compile flow
#
execute_flow -compile

#call external executables to generate flash image and program cfi flash

if {$opts(load_program_to) == "ram"} \
{
    # program fpga ram
    exec quartus_pgm -c "USB-Blaster \[$opts(usb_cable)\]" -m JTAG -o "p;./output_files/cl10_tubepsu.sof"
}
