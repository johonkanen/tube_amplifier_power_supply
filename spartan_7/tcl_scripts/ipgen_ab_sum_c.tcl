if { [file isdirectory "IP/dsp_ab_sum_c/"] } {
    read_ip IP/dsp_ab_sum_c/dsp_ab_sum_c.xci
} else {
        if { [file isdirectory "IP/"] } {
        } else {
                file mkdir IP
        }

        create_ip -name xbip_dsp48_macro -vendor xilinx.com -library ip -version 3.0 -module_name dsp_ab_sum_c -dir IP
        set_property -dict [list CONFIG.Component_Name {dsp_ab_sum_c} CONFIG.pipeline_options {Expert} CONFIG.c_width {18} CONFIG.has_acout {false} CONFIG.areg_3 {false} CONFIG.areg_4 {false} CONFIG.breg_3 {false} CONFIG.breg_4 {false} CONFIG.creg_3 {false} CONFIG.creg_4 {false} CONFIG.creg_5 {false} CONFIG.mreg_5 {false} CONFIG.preg_6 {false} CONFIG.c_binarywidth {0} CONFIG.p_full_width {37} CONFIG.p_width {37} CONFIG.p_binarywidth {0}] [get_ips dsp_ab_sum_c]
        generate_target {instantiation_template} [get_files IP/dsp_ab_sum_c/dsp_ab_sum_c.xci]
        set_property generate_synth_checkpoint false [get_files  IP/dsp_ab_sum_c/dsp_ab_sum_c.xci]
        generate_target all [get_files  IP/dsp_ab_sum_c/dsp_ab_sum_c.xci]
        export_ip_user_files -of_objects [get_files IP/dsp_ab_sum_c/dsp_ab_sum_c.xci] -no_script -sync -force -quiet
        export_simulation -of_objects [get_files IP/dsp_ab_sum_c/dsp_ab_sum_c.xci] -directory .ip_user_files/sim_scripts -ip_user_files_dir .ip_user_files -ipstatic_source_dir .ip_user_files/ipstatic -lib_map_path [list {modelsim=./.cache/compile_simlib/modelsim} {questa=./.cache/compile_simlib/questa} {riviera=./.cache/compile_simlib/riviera} {activehdl=./.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
}
