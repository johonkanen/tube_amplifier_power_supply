set outputDir ./output
set tube_psu_v5_dir ../
set source_dir ../source
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

prj_strgy set_value -strategy Strategy1 syn_arrange_vhdl_files=True
prj_strgy set_value -strategy Strategy1 par_pathbased_place=On
prj_strgy set_value -strategy Strategy1 par_stop_zero=True


prj_src add $tube_psu_v5_dir/lfe5u/ecp5_specifics/vendor_specifics_pkg.vhd

source $tube_psu_v5_dir/list_of_sources.tcl

foreach x [read_sources ../source] {prj_src add ../source/$x}

prj_project save
