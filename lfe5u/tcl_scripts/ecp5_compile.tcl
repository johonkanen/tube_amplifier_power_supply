set outputDir ./output
set tube_psu_v5_dir ../
set source_folder ../source
file mkdir $outputDir

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
    -synthesis "synplify"

# prj_src add "C:/Users/Jari/mycodeprojects/tube_psu/source/dhb/phase_modulator.vhd"

prj_strgy set_value -strategy Strategy1 syn_arrange_vhdl_files=False
prj_strgy set_value -strategy Strategy1 par_pathbased_place=On
prj_strgy set_value -strategy Strategy1 par_stop_zero=True


prj_src add $tube_psu_v5_dir/source/ecp5/vendor_specifics_pkg.vhd
prj_src add $tube_psu_v5_dir/source/ecp5/ecp5_pll_wrapper.vhd
prj_src add $tube_psu_v5_dir/source/ecp5/ecp5_adc_wrapper.vhd
prj_src add $tube_psu_v5_dir/lfe5u/ip_cores/ip_cores.sbx

source $tube_psu_v5_dir/list_of_sources.tcl

    foreach x [read_sources ../] \
    { \
        if {[lsearch -glob $x *onboard_ad_control*] == 0} \
        { \
            prj_src add $source_folder/$x -work onboard_adc_library
        } \
        else \
        { \
            prj_src add $source_folder/$x \
        } \
    }

prj_project save
