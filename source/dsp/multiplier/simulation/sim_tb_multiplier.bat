ghdl -a --ieee=synopsys ..\multiplier_pkg.vhd
ghdl -a --ieee=synopsys ..\multiplier.vhd
ghdl -a --ieee=synopsys tb_multiplier.vhd
ghdl -e --ieee=synopsys tb_multiplier
ghdl -r --ieee=synopsys tb_multiplier --vcd=tb_multiplier.vcd

IF %1 EQU 1 start "" gtkwave tb_multiplier.vcd
