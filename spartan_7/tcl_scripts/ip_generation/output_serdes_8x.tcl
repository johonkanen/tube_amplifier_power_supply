create_ip -name selectio_wiz -vendor xilinx.com -library ip -version 5.1 -module_name output_serdes_8x
set_property -dict [list \
  CONFIG.BUS_DIR {OUTPUTS} \
  CONFIG.BUS_IO_STD {LVCMOS33} \
  CONFIG.CLK_FWD_IO_STD {LVCMOS33} \
  CONFIG.SELIO_ACTIVE_EDGE {DDR} \
  CONFIG.SELIO_BUS_IN_DELAY {NONE} \
  CONFIG.SELIO_CLK_BUF {MMCM} \
  CONFIG.SELIO_CLK_IO_STD {LVCMOS33} \
  CONFIG.SELIO_INTERFACE_TYPE {NETWORKING} \
  CONFIG.SERIALIZATION_FACTOR {8} \
  CONFIG.SYSTEM_DATA_WIDTH {1} \
  CONFIG.USE_SERIALIZATION {true} \
] [get_ips output_serdes_8x]

proc generate_ip_module {ip_module} {
    generate_target {instantiation_template} [get_files .srcs/sources_1/ip/$ip_module/$ip_module.xci]
    set_property generate_synth_checkpoint false [get_files  .srcs/sources_1/ip/$ip_module/$ip_module.xci]
    generate_target all [get_files  .srcs/sources_1/ip/$ip_module/$ip_module.xci]
    export_ip_user_files -of_objects [get_files .srcs/sources_1/ip/$ip_module/$ip_module.xci] -no_script -sync -force -quiet
    export_simulation -of_objects [get_files .srcs/sources_1/ip/$ip_module/$ip_module.xci] -directory .ip_user_files/sim_scripts -ip_user_files_dir .ip_user_files -ipstatic_source_dir .ip_user_files/ipstatic -lib_map_path [list {modelsim=./.cache/compile_simlib/modelsim} {questa=./.cache/compile_simlib/questa} {riviera=./.cache/compile_simlib/riviera} {activehdl=./.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
}

generate_ip_module output_serdes_8x
