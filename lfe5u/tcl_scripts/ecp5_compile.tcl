set outputDir ./output
set tube_psu_v5_dir ../
file mkdir $outputDir

variable this_file_path [ file dirname [ file normalize [ info script ] ] ]
set tcl_scripts $this_file_path
set source_folder $tcl_scripts/../../source

set files [glob -nocomplain "$outputDir/*"]
if {[llength $files] != 0} {
    # clear folder contents
    puts "deleting contents of $outputDir"
    file delete -force {*}[glob -directory $outputDir *]; 
} else {
    puts "$outputDir is empty"
}


prj_project new -name tube_psu_v5 \
    -impl "impl1" \
    -dev LFE5U-12F-8BG381C \
    -impl_dir $outputDir \
    -synthesis "Synplify" \

# prj_src add "C:/Users/Jari/mycodeprojects/tube_psu/source/dhb/phase_modulator.vhd"

prj_strgy set_value -strategy Strategy1 syn_arrange_vhdl_files=True
prj_strgy set_value -strategy Strategy1 par_pathbased_place=On
prj_strgy set_value -strategy Strategy1 map_reg_retiming=True
prj_strgy set_value -strategy Strategy1 syn_update_compile_pt_timing_data=True 
#do not change area setting, synthesis will crash if syn_area = true
prj_strgy set_value -strategy Strategy1 syn_area=False
#If retiming is not on, Synplify will crash for some reason
prj_strgy set_value -strategy Strategy1 {map_timing_driven=True map_timing_driven_node_replication=True map_timing_driven_pack=True}
prj_strgy set_value -strategy Strategy1 syn_res_sharing=False
prj_strgy set_value -strategy Strategy1 syn_allow_dup_modules=True
prj_strgy set_value -strategy Strategy1 syn_frequency=150
prj_strgy set_value -strategy Strategy1 syn_fsm_encoding=True
prj_strgy set_value -strategy Strategy1 syn_vhdl2008=True
prj_strgy set_value -strategy Strategy1 {syn_pipelining_retiming=Pipelining and Retiming}

# prj_strgy set_value -strategy Strategy1 par_stop_zero=True

prj_src add $tube_psu_v5_dir/lfe5u/source_ecp5/vendor_specifics_pkg.vhd
prj_src add $tube_psu_v5_dir/lfe5u/source_ecp5/ecp5_pll_wrapper.vhd
prj_src add $tube_psu_v5_dir/lfe5u/source_ecp5/ecp5_adc_wrapper.vhd
prj_src add $tube_psu_v5_dir/lfe5u/ip_cores/ip_cores.sbx


prj_src add -exclude $tube_psu_v5_dir/lfe5u/constraints/tubepsu_constraints.lpf
prj_src enable $tube_psu_v5_dir/lfe5u/constraints/tubepsu_constraints.lpf
prj_src enable $tube_psu_v5_dir/lfe5u/constraints/timing.ldc
prj_src remove tube_psu_v5.lpf
file delete -force tube_psu_v5.lpf

proc add_vhdl_file_to_project {vhdl_file} {
    prj_src add $vhdl_file
}

proc add_vhdl_file_to_library {vhdl_file library} {
    prj_src add $vhdl_file -work $library
}
source $tube_psu_v5_dir/fpga_communication_sources.tcl
source $tube_psu_v5_dir/list_of_sources.tcl

add_vhdl_file_to_project $source_folder/top/ecp5_top.vhd

prj_run Synthesis -impl impl1
prj_run Translate -impl impl1
prj_run Map -impl impl1
prj_run PAR -impl impl1
prj_run Export -impl impl1 -task Bitgen
prj_run Export -impl impl1 -task Promgen
prj_project save
