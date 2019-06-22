
set partNum xc7s15ftgb196-2
create_project -in_memory -part $partNum

create_ip -name mult_gen -vendor xilinx.com -library ip -version 12.0 -module_name combi_mult_18x18 -dir ../.srcs/sources_1/ip
set_property -dict [list CONFIG.Component_Name {combi_mult_18x18} CONFIG.Multiplier_Construction {Use_Mults} CONFIG.OptGoal {Speed} CONFIG.PipeStages {0}] [get_ips combi_mult_18x18]
generate_target {instantiation_template} [get_files ../.srcs/sources_1/ip/combi_mult_18x18/combi_mult_18x18.xci]
set_property generate_synth_checkpoint false [get_files  ../.srcs/sources_1/ip/combi_mult_18x18/combi_mult_18x18.xci]
generate_target all [get_files  ../.srcs/sources_1/ip/combi_mult_18x18/combi_mult_18x18.xci]
export_ip_user_files -of_objects [get_files ../.srcs/sources_1/ip/combi_mult_18x18/combi_mult_18x18.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files ../.srcs/sources_1/ip/combi_mult_18x18/combi_mult_18x18.xci] -directory .ip_user_files/sim_scripts -ip_user_files_dir .ip_user_files -ipstatic_source_dir .ip_user_files/ipstatic -lib_map_path [list {modelsim=./.cache/compile_simlib/modelsim} {questa=./.cache/compile_simlib/questa} {riviera=./.cache/compile_simlib/riviera} {activehdl=./.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet

