rem simulate tb_pfc_modulator.vhd
ghdl -a --ieee=synopsys ..\pfc_modulator_pkg.vhd
ghdl -a --ieee=synopsys ..\pfc_modulator.vhd
ghdl -a --ieee=synopsys tb_pfc_modulator.vhd
ghdl -e --ieee=synopsys tb_pfc_modulator
ghdl -r --ieee=synopsys tb_pfc_modulator --vcd=tb_tb_pfc_modulator.vcd


IF %1 EQU 1 start "" gtkwave tb_tb_pfc_modulator.vcd
