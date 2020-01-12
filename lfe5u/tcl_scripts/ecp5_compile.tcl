set outputDir ./output
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

prj_src add "C:/Users/Jari/mycodeprojects/tube_psu/source/dhb/phase_modulator.vhd"

prj_strgy set_value -strategy Strategy1 syn_arrange_vhdl_files=True
prj_strgy set_value -strategy Strategy1 par_pathbased_place=On
prj_strgy set_value -strategy Strategy1 par_stop_zero=True

# prj_src ../source/top/top.vhd
prj_src add $source_dir//system_control/system_control.vhd
prj_src add $source_dir//system_control/data_control.vhd
prj_src add $source_dir//ext_ad/ext_ad_control.vhd
prj_src add $source_dir//ext_ad/ad_ctrl.vhd
prj_src add $source_dir//ext_ad/ad_bus_pkg.vhd
prj_src add $source_dir//onboard_ad_control/onboard_ad_ctrl_pkg.vhd
prj_src add $source_dir//ext_ad/spi3w_ads7056_driver.vhd
prj_src add $source_dir//sw_supply_control/sw_supply_ctrl.vhd
prj_src add $source_dir//sw_supply_control/sw_supply_ctrl_pkg.vhd
prj_src add $source_dir//pfc_ctrl/pfc_pkg.vhd
prj_src add $source_dir//pfc_ctrl/pfc_control.vhd
prj_src add $source_dir//pfc_ctrl/pfc_modulator.vhd
prj_src add $source_dir//dhb/dhb_pkg.vhd
prj_src add $source_dir//dhb/dhb_control.vhd
prj_src add $source_dir//dhb/phase_modulator.vhd
prj_src add $source_dir//heater_ctrl/heater_ctrl.vhd
prj_src add $source_dir//heater_ctrl/llc_pkg.vhd
prj_src add $source_dir//system_control/sys_ctrl_pkg.vhd
prj_src add $source_dir//ext_ad/ext_ad_spi3w.vhd
prj_src add $source_dir//heater_ctrl/freq_modulator.vhd
prj_src add $source_dir//led_driver/led_driver.vhd
prj_src add $source_dir//uart/uart.vhd
prj_src add $source_dir//uart/uart_tx.vhd
prj_src add $source_dir//uart/uart_rx.vhd
prj_src add $source_dir//uart/uart_event_ctrl.vhd
prj_src add $source_dir//uart/command_shell.vhd
# ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd
# ecp5u_specifics/ecp5_ip_components/mpy18x18/mpy18x18.vhd
prj_src add $source_dir//led_driver/led_driver_pkg.vhd
prj_src add $source_dir//uart/tubepsu_commands_pkg.vhd
prj_src add $source_dir//dsp/seq_pi_control.vhd
prj_src add $source_dir//ecp5/ecp5_adc_wrapper.vhd
prj_src add $source_dir//ecp5/ecp5_specifics.vhd
prj_src add $source_dir//ecp5/ecp5_pll_wrapper.vhd
prj_src add $source_dir//ecp5/ecp5_multiplier_wrapper.vhd
prj_src add $source_dir//dsp/alu_routines_pkg.vhd
prj_src add $source_dir//dsp/alu16bit.vhd
prj_src add $source_dir//dsp/alu16bit_pkg.vhd
prj_src add $source_dir//dsp/rad4_inv16bit.vhd
prj_src add $source_dir//dsp/rad4_inv16bit_pkg.vhd
# ecp5u_specifics/ecp5_ip_components/ecp5_ip_components.sbx
prj_src add $source_dir//dsp/sin_cos16bit_pkg.vhd
prj_src add $source_dir//dsp/sin_cos16bit.vhd

prj_src add $source_dir//top/top.vhd

prj_project save
