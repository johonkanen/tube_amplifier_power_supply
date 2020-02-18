rem simulate phase_modulator.vhd

set component_interconnect=../../../../
@echo off
echo %source

ghdl -a --ieee=synopsys %component_interconnect%/power_supply_control/dhb_control/phase_modulator/phase_modulator_pkg.vhd
ghdl -a --ieee=synopsys %component_interconnect%/power_supply_control/dhb_control/phase_modulator/phase_modulator.vhd
ghdl -a --ieee=synopsys tb_phase_modulator.vhd
ghdl -e --ieee=synopsys tb_phase_modulator
ghdl -r --ieee=synopsys tb_phase_modulator --vcd=tb_phase_modulator.vcd


IF %1 EQU 1 start "" gtkwave tb_phase_modulator.vcd
