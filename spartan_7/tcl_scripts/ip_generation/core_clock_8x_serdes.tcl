create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name main_clock_8x_serdes
set_property -dict [list \
  CONFIG.CLKIN1_JITTER_PS {312.5} \
  CONFIG.CLKOUT1_JITTER {188.836} \
  CONFIG.CLKOUT1_PHASE_ERROR {198.711} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {128} \
  CONFIG.CLKOUT2_JITTER {153.853} \
  CONFIG.CLKOUT2_PHASE_ERROR {198.711} \
  CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {512} \
  CONFIG.CLKOUT2_USED {true} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {32.000} \
  CONFIG.MMCM_CLKIN1_PERIOD {31.250} \
  CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} \
  CONFIG.MMCM_CLKOUT1_DIVIDE {2} \
  CONFIG.NUM_OUT_CLKS {2} \
  CONFIG.PRIM_IN_FREQ {32} \
  CONFIG.USE_RESET {false} \
] [get_ips main_clock_8x_serdes]

generate_target {instantiation_template} [get_files .srcs/sources_1/ip/main_clock_8x_serdes/main_clock_8x_serdes.xci]
set_property generate_synth_checkpoint false [get_files  .srcs/sources_1/ip/main_clock_8x_serdes/main_clock_8x_serdes.xci]
generate_target all [get_files  .srcs/sources_1/ip/main_clock_8x_serdes/main_clock_8x_serdes.xci]
export_ip_user_files -of_objects [get_files .srcs/sources_1/ip/main_clock_8x_serdes/main_clock_8x_serdes.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files .srcs/sources_1/ip/main_clock_8x_serdes/main_clock_8x_serdes.xci] -directory .ip_user_files/sim_scripts -ip_user_files_dir .ip_user_files -ipstatic_source_dir .ip_user_files/ipstatic -lib_map_path [list {modelsim=./.cache/compile_simlib/modelsim} {questa=./.cache/compile_simlib/questa} {riviera=./.cache/compile_simlib/riviera} {activehdl=./.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
