create_project tube_psu_s6 -force -part xc6slx16ftg256-3
set_property design_mode RTL [get_property srcset [current_run]]

source read_sources.tcl
read_ip ../ipcore_dir/s6_core_clocks.xco
read_ip ../ipcore_dir/multiplier_s18xs18.xco
set_property top top [get_property srcset [current_run]]
add_files -fileset [get_property constrset [current_run]] -norecurse {../ucf/s6_tubepsu.ucf}


# create_project pa_proj {crc_example/pa_proj} -part xc6slx9csg225-3
# set_property design_mode RTL [get_property srcset [current_run]]
# add_files -norecurse {crc_example/proj/.. /src/crc.v}
# set_property library work [get_files -of_objects [get_property srcset [current_run]] {src/crc.v}]
# add_files -fileset [get_property constrset [current_run]] -norecurse {ucf/crc.ucf}
# set_property top crc [get_property srcset [current_run]]
# set_property verilog_2001 true [get_property srcset [current_run]]
# launch_runs -runs synth_1 -jobs 1 -scripts_only -dir {crc_example/pa_proj/pa_proj.runs}
launch_runs -runs synth_1 -jobs 1
# launch_runs -runs impl_1 -jobs 1
# set_property add_step Bitgen [get_runs impl_1]
# launch_runs -runs impl_1 -jobs 1 -dir {crc_example/pa_proj/pa_proj.runs}
