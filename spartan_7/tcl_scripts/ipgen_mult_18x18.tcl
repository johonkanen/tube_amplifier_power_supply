
set partNum xc7s15ftgb196-2
create_project -in_memory -part $partNum
# Check IP
    # if the IP files exist, we already generated the IP, so we can just
    # read the ip definition (.xci)
        # IP folder does not exist. Create IP folder
if { [file isdirectory "../IP/combi_mult_18x18/"] } {
    read_ip ../IP/combi_mult_18x18/combi_mult_18x18.xci
} else {
       file mkdir ../IP
       create_ip -name mult_gen -vendor xilinx.com -library ip \
       -version 12.0 \
       -module_name combi_mult_18x18 -dir ../IP

       set_property -dict [list \
           CONFIG.Multiplier_Construction {Use_Mults} CONFIG.OptGoal {Speed} \
           CONFIG.PipeStages {0}] [get_ips combi_mult_18x18]
       generate_target {instantiation_template} [get_files ../IP/combi_mult_18x18/combi_mult_18x18.xci]

       set_property generate_synth_checkpoint false [get_files  ../IP/combi_mult_18x18/combi_mult_18x18.xci]

       #generate_target all [get_files  ../IP/combi_mult_18x18/combi_mult_18x18.xci]

       export_ip_user_files \
           -of_objects [get_files ../IP/combi_mult_18x18/combi_mult_18x18.xci] \
           -no_script -sync -force -quiet

       export_simulation -of_objects [get_files ../IP/combi_mult_18x18/combi_mult_18x18.xci] \
           -directory ../IP/.ip_user_files/sim_scripts \
           -ip_user_files_dir ../IP/.ip_user_files \
           -ipstatic_source_dir ../IP/.ip_user_files/ipstatic \
           -lib_map_path [list {modelsim=./.cache/compile_simlib/modelsim} \
               {questa=./.cache/compile_simlib/questa} \
               {riviera=./.cache/compile_simlib/riviera} \
               {activehdl=./.cache/compile_simlib/activehdl}] \
           -use_ip_compiled_libs -force -quiet

       generate_target all [get_ips]

#        # Synthesize all the IP
#        synth_ip [get_ips]
}
