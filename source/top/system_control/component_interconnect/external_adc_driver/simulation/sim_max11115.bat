rem simulate max_11115.vhd
ghdl -a --ieee=synopsys ..\max_11115_pkg.vhd
ghdl -a --ieee=synopsys ..\max_11115.vhd
ghdl -a --ieee=synopsys tb_max_11115.vhd
ghdl -e --ieee=synopsys tb_max_11115
ghdl -r --ieee=synopsys tb_max_11115 --vcd=tb_max_11115.vcd


IF %1 EQU 1 start "" gtkwave tb_max_11115.vcd
