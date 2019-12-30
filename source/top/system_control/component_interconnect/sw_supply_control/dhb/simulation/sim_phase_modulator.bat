ghdl -a --std=08 --ieee=synopsys ..\dhb_pkg.vhd
ghdl -a --std=08 --ieee=synopsys ..\phase_modulator.vhd
ghdl -a --std=08 --ieee=synopsys tb_phase_modulator.vhd
ghdl -e --std=08 --ieee=synopsys tb_phase_modulator
ghdl -r --std=08 --ieee=synopsys tb_phase_modulator --vcd=tb_phase_modulator.vcd

gtkwave tb_phase_modulator.vcd
