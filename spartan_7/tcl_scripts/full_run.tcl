variable tcl_path [ file dirname [ file normalize [ info script ] ] ] 

source $tcl_path/init_build_environment.tcl

set target_device xc7s15ftgb196-2
create_project -force -in_memory tube_psu_v5
set_property target_language VHDL [current_project]
set_property part $target_device [current_project]

add_vhdl_file_to_project $tcl_path/../s7_source/s7_adc_wrapper.vhd
add_vhdl_file_to_project $tcl_path/../s7_source/s7_specifics.vhd
add_vhdl_file_to_project $tcl_path/../s7_source/s7_multiplier_wrapper.vhd

add_vhdl_file_to_project $source_folder/float_configuration/artix7_float_configuration_pkg.vhd

source $source_folder/../list_of_sources.tcl
source $source_folder/../fpga_communication_sources.tcl

run_tcl_scripts $tcl_path/ip_generation

add_vhdl_file_to_project $source_folder/top/s7_top.vhd
set_property top top [current_fileset]

synth_design

source $tcl_path/place_io.tcl

write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt

opt_design
place_design
report_clock_utilization -file $outputDir/clock_util.rpt

#get timing violations and run optimizations if needed
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0.1} {
    puts "Found setup timing violations => running physical optimization"
    phys_opt_design
}
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

#Route design and generate bitstream
route_design -directive Explore
write_checkpoint -force $outputDir/post_route.dcp

write_bit_and_flash_images tube_power

save_project_as tube_power tube_power -force
