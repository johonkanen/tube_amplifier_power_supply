
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name spartan_6 -dir "C:/Users/Jari/mycodeprojects/tube_psu/spartan_6/planAhead_run_1" -part xc6slx16ftg256-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Jari/mycodeprojects/tube_psu/spartan_6/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Jari/mycodeprojects/tube_psu/spartan_6} {ipcore_dir} }
add_files [list {ipcore_dir/multiplier_s18xs18.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design
