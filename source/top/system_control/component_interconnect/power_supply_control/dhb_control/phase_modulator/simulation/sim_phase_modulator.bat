rem simulate phase_modulator.vhd
ghdl -a --std=08 --ieee=synopsys ..\phase_modulator_pkg.vhd
ghdl -a --std=08 --ieee=synopsys ..\phase_modulator.vhd
ghdl -a --std=08 --ieee=synopsys tb_phase_modulator.vhd
ghdl -e --std=08 --ieee=synopsys tb_phase_modulator
ghdl -r --std=08 --ieee=synopsys tb_phase_modulator --vcd=tb_phase_modulator.vcd


IF %1 EQU 1 start "" gtkwave tb_phase_modulator.vcd
