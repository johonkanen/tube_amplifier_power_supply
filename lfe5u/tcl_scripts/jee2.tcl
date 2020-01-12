prj_project open "C:/Users/Jari/mycodeprojects/tube_psu/lfe5u/tube_psu.ldf"
prj_run Synthesis -impl rtl
prj_project close
prj_project open "C:/Users/Jari/mycodeprojects/tube_power_v5/lfe5u/tube_psu.ldf"
prj_run Synthesis -impl rtl -task Synplify_Synthesis
prj_strgy set_value -strategy Strategy1 syn_arrange_vhdl_files=False
prj_strgy set_value -strategy Strategy1 syn_arrange_vhdl_files=True
prj_strgy set_value -strategy Strategy1 par_pathbased_place=On
prj_strgy set_value -strategy Strategy1 par_stop_zero=True
prj_run Synthesis -impl rtl -task Synplify_Synthesis
prj_run Translate -impl rtl
help ngd_port
ngd_port get
ngd_port get -in
ngd_port get -in *mhz
ngd_port get -in
save_script C:/Users/Jari/mycodeprojects/tube_power_v5/lfe5u/tcl_scripts/jee.tcl
prj_project close
prj_project open "C:/Users/Jari/mycodeprojects/tube_power_v5/lfe5u/tube_psu.ldf"
prj_run Export -impl rtl
