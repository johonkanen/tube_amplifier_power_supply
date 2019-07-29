create_project tube_psu_s6 -force -part xc6slx16ftg256-3
set_property design_mode RTL [get_property srcset [current_run]]
# set_property target_language VHDL [current_project]
# set_property ng.output_hdl_format VHDL [get_filesets sim_1]


source read_sources.tcl
read_ip ../ip/clk_wiz_v3_6_0/system_clocks.xci
read_ip ../ip/mult_gen_v11_2_0/mult_sign18x18.xci
add_files -fileset [get_property constrset [current_run]] -norecurse {../ucf/s6_tubepsu.ucf}

set_property top top [get_property srcset [current_run]]

# set_property steps.map.args.timing true [get_runs impl_1]
# set_property steps.map.args.logic_opt on [get_runs impl_1]
# set_property steps.map.args.global_opt speed [get_runs impl_1]
# set_property steps.map.args.retiming on [get_runs impl_1]
# set_property steps.map.args.ol high [get_runs impl_1]
# set_property steps.map.args.xe c [get_runs impl_1]
# set_property steps.map.args.mt on [get_runs impl_1]
# set_property steps.par.args.ol high [get_runs impl_1]
# set_property steps.par.args.pl high [get_runs impl_1]
# set_property steps.par.args.rl high [get_runs impl_1]
# set_property steps.par.args.xe c [get_runs impl_1]
# set_property steps.par.args.mt 4 [get_runs impl_1]

# create_project pa_proj {crc_example/pa_proj} -part xc6slx9csg225-3
# set_property design_mode RTL [get_property srcset [current_run]]
# add_files -norecurse {crc_example/proj/.. /src/crc.v}
# set_property library work [get_files -of_objects [get_property srcset [current_run]] {src/crc.v}]
# add_files -fileset [get_property constrset [current_run]] -norecurse {ucf/crc.ucf}
# set_property top crc [get_property srcset [current_run]]
# set_property verilog_2001 true [get_property srcset [current_run]]
# launch_runs -runs synth_1 -jobs 1 -scripts_only -dir {crc_example/pa_proj/pa_proj.runs}
launch_runs -runs synth_1 -jobs 1
wait_on_run synth_1

set_property steps.map.args.timing true [get_runs impl_1]
set_property add_step Bitgen [get_runs impl_1]
launch_runs -runs impl_1 -jobs 1
wait_on_run impl_1
# launch_runs -runs impl_1 -jobs 1 -dir {crc_example/pa_proj/pa_proj.runs}
