#Define target part and create output directory
set partNum xc7s15ftgb196-2
set outputDir ./output
file mkdir $outputDir
set files [glob -nocomplain "$outputDir/*"]
if {[llength $files] != 0} {
    # clear folder contents
    puts "deleting contents of $outputDir"
    file delete -force {*}[glob -directory $outputDir *]; 
} else {
    puts "$outputDir is empty"
}

create_project -in_memory -part $partNum
# read vhdl files
read_vhdl -vhdl2008 [ glob ../source/spartan_7/s7_adc_wrapper.vhd]
read_vhdl -vhdl2008 [ glob ../source/spartan_7/s7_specifics.vhd]
read_vhdl -vhdl2008 [ glob ../source/top/top.vhd ]
read_vhdl -vhdl2008 [ glob ../source/pfc_ctrl/pfc_pkg.vhd]
read_vhdl -vhdl2008 [ glob ../source/dhb/dhb_pkg.vhd]
read_vhdl -vhdl2008 [ glob ../source/heater_ctrl/llc_pkg.vhd]

# dhb sources
read_vhdl -vhdl2008 [ glob ../source/dhb/dhb_pkg.vhd ]
read_vhdl -vhdl2008 [ glob ../source/dhb/phase_modulator.vhd ]

# ad sources
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ad_ctrl.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ext_ad_control.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/spi3w_ads7056_driver.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ad_bus_driver.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ad_bus_pkg.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ext_ad_spi3w.vhd ]

read_vhdl -vhdl2008 [ glob ../source/heater_ctrl/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/led_driver/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/onboard_ad_control/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/pfc_ctrl/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/sw_supply_control/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/system_control/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/uart/uart.vhd ]
read_vhdl -vhdl2008 [ glob ../source/uart/uart_event_ctrl.vhd]
read_vhdl -vhdl2008 [ glob ../source/uart/uart_rx.vhd]
read_vhdl -vhdl2008 [ glob ../source/uart/uart_tx.vhd]
read_vhdl -vhdl2008 [ glob ../source/uart/command_shell.vhd]

source ./tcl_scripts/ipgen_main_pll.tcl
source ./tcl_scripts/ipgen_mult_18x18.tcl
source ./tcl_scripts/ipgen_ab_sum_c.tcl

read_xdc constraints/constraints.xdc

synth_design -top top -part $partNum
write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt

 opt_design
 place_design
 report_clock_utilization -file $outputDir/clock_util.rpt

#get timing violations and run optimizations if needed
 if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
  puts "Found setup timing violations => running physical optimization"
  phys_opt_design
 }
 write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

#Route design and generate bitstream
route_design -directive Explore
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
write_verilog -force $outputDir/cpu_impl_netlist.v -mode timesim -sdf_anno true

#VCCO(zero) = IO = 2.5V || 3.3V, GND IO bank0 = 1.8v
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.Config.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
write_bitstream -force $outputDir/testibitstream.bit
