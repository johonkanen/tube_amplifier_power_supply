variable tcl_path [ file dirname [ file normalize [ info script ] ] ] 
set outputDir ./output
file mkdir $outputDir
set source_folder $tcl_path/../../source

proc add_vhdl_file_to_project {vhdl_file} {
    read_vhdl -vhdl2019 $vhdl_file
}

proc add_vhdl_file_to_library {vhdl_file library} {
    read_vhdl -vhdl2019 -library $library $vhdl_file 
}

proc set_3v3_io {pin_name_from_port package_pin_location} {
    set_property IOSTANDARD LVCMOS33 [get_ports *$pin_name_from_port*]
    place_ports *$pin_name_from_port* $package_pin_location
}

proc generate_ip_module {ip_module} {
    generate_target {instantiation_template} [get_files .srcs/sources_1/ip/$ip_module/$ip_module.xci]
    set_property generate_synth_checkpoint false [get_files  .srcs/sources_1/ip/$ip_module/$ip_module.xci]
    generate_target all [get_files  .srcs/sources_1/ip/$ip_module/$ip_module.xci]
    export_ip_user_files -of_objects [get_files .srcs/sources_1/ip/$ip_module/$ip_module.xci] -no_script -sync -force -quiet
    export_simulation -of_objects [get_files .srcs/sources_1/ip/$ip_module/$ip_module.xci] -directory .ip_user_files/sim_scripts -ip_user_files_dir .ip_user_files -ipstatic_source_dir .ip_user_files/ipstatic -lib_map_path [list {modelsim=./.cache/compile_simlib/modelsim} {questa=./.cache/compile_simlib/questa} {riviera=./.cache/compile_simlib/riviera} {activehdl=./.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
}


source $tcl_path/program_functions.tcl
source $tcl_path/source_all_scripts_in_folder.tcl
