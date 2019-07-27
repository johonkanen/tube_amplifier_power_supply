
set partNum xc7s15ftgb196-2
create_project -in_memory -part $partNum
# read vhdl files
read_vhdl -vhdl2008 [ glob ../source/spartan_7/s7_adc_wrapper.vhd]
read_vhdl -vhdl2008 [ glob ../source/spartan_7/s7_specifics.vhd]
read_vhdl -vhdl2008 [ glob ../source/spartan_7/s7_multiplier_wrapper.vhd]
read_vhdl -vhdl2008 [ glob ../source/spartan_7/s7_pll_wrapper.vhd]

read_vhdl -vhdl2008 [ glob ../source/top/top.vhd ]

#pfc sources
read_vhdl -vhdl2008 [ glob ../source/pfc_ctrl/pfc_control.vhd ]
read_vhdl -vhdl2008 [ glob ../source/pfc_ctrl/pfc_modulator.vhd ]
read_vhdl -vhdl2008 [ glob ../source/pfc_ctrl/pfc_pkg.vhd ]

read_vhdl -vhdl2008 [ glob ../source/heater_ctrl/freq_modulator.vhd]
read_vhdl -vhdl2008 [ glob ../source/heater_ctrl/heater_ctrl.vhd]
read_vhdl -vhdl2008 [ glob ../source/heater_ctrl/llc_pkg.vhd]

# dhb sources
read_vhdl -vhdl2008 [ glob ../source/dhb/dhb_control.vhd]
read_vhdl -vhdl2008 [ glob ../source/dhb/dhb_pkg.vhd ]
read_vhdl -vhdl2008 [ glob ../source/dhb/phase_modulator.vhd ]

# ad sources
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ad_ctrl.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ext_ad_control.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ad_bus_pkg.vhd ]
read_vhdl -vhdl2008 [ glob ../source/ext_ad/ext_ad_spi3w.vhd ]

#alu vhdl 
read_vhdl -vhdl2008 [ glob ../source/dsp/alu16bit_pkg.vhd ]
read_vhdl -vhdl2008 [ glob ../source/dsp/alu16bit.vhd ]
read_vhdl -vhdl2008 [ glob ../source/dsp/rad4_inv16bit_pkg.vhd]
read_vhdl -vhdl2008 [ glob ../source/dsp/rad4_inv16bit.vhd]
read_vhdl -vhdl2008 [ glob ../source/dsp/alu_routines_pkg.vhd]
read_vhdl -vhdl2008 [ glob ../source/dsp/seq_pi_control.vhd]

read_vhdl -vhdl2008 [ glob ../source/led_driver/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/onboard_ad_control/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/sw_supply_control/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/system_control/*.vhd ]
read_vhdl -vhdl2008 [ glob ../source/uart/uart.vhd ]
read_vhdl -vhdl2008 [ glob ../source/uart/uart_event_ctrl.vhd]
read_vhdl -vhdl2008 [ glob ../source/uart/uart_rx.vhd]
read_vhdl -vhdl2008 [ glob ../source/uart/uart_tx.vhd]
read_vhdl -vhdl2008 [ glob ../source/uart/command_shell.vhd]
read_vhdl -vhdl2008 [ glob ../source/uart/tubepsu_commands_pkg.vhd]

source ./tcl_scripts/ipgen_main_pll.tcl
source ./tcl_scripts/ipgen_mult_18x18.tcl
source ./tcl_scripts/ipgen_ab_sum_c.tcl

read_xdc constraints/constraints.xdc
