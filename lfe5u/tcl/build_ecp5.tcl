set project_name tube_psu_v5
set implementation_name compile_to_fpga
set device_number LFE5U-12F-8BG381I

# set tcl_dir 

prj_project new -name "$project_name" -impl "$compile_to_fpga" -dev $device_number -synthesis "synplify"

# build system clocks with clarity designer
sbp_design new -dsgn "sys_clocks" -path "C:/Users/Jari/mycodeprojects/tube_psu/remove/sys_clocks" -device
