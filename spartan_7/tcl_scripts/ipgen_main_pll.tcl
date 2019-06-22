
set partNum xc7s15ftgb196-2
create_project -in_memory -part $partNum

create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name pll_1x256mhz -dir ../.srcs/sources_1/ip

set_property -dict [list CONFIG.Component_Name {pll_1x256mhz} CONFIG.PRIM_IN_FREQ {32.000} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {256.000} CONFIG.USE_RESET {false} CONFIG.CLKIN1_JITTER_PS {312.5} CONFIG.MMCM_CLKFBOUT_MULT_F {31.000} CONFIG.MMCM_CLKIN1_PERIOD {31.250} CONFIG.MMCM_CLKIN2_PERIOD {10.0} CONFIG.MMCM_CLKOUT0_DIVIDE_F {3.875} CONFIG.CLKOUT1_JITTER {173.096} CONFIG.CLKOUT1_PHASE_ERROR {203.212}] [get_ips pll_1x256mhz]

generate_target {instantiation_template} [get_files ../.srcs/sources_1/ip/pll_1x256mhz/pll_1x256mhz.xci]

set_property generate_synth_checkpoint false [get_files  ../.srcs/sources_1/ip/pll_1x256mhz/pll_1x256mhz.xci]

generate_target all [get_files  ../.srcs/sources_1/ip/pll_1x256mhz/pll_1x256mhz.xci]

export_ip_user_files -of_objects [get_files ../.srcs/sources_1/ip/pll_1x256mhz/pll_1x256mhz.xci] -no_script -sync -force -quiet

export_simulation -of_objects [get_files ../.srcs/sources_1/ip/pll_1x256mhz/pll_1x256mhz.xci] -directory .ip_user_files/sim_scripts -ip_user_files_dir .ip_user_files -ipstatic_source_dir .ip_user_files/ipstatic -lib_map_path [list {modelsim=./.cache/compile_simlib/modelsim} {questa=./.cache/compile_simlib/questa} {riviera=./.cache/compile_simlib/riviera} {activehdl=./.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet

