ghdl -a --ieee=synopsys ..\..\multiplier\sim_multiplier18x18.vhd
ghdl -a --ieee=synopsys ..\..\multiplier\multiplier_pkg.vhd
ghdl -a --ieee=synopsys ..\..\multiplier\multiplier.vhd
ghdl -a --ieee=synopsys tb_sincos.vhd
ghdl -e --ieee=synopsys tb_sincos
ghdl -r --ieee=synopsys tb_sincos --vcd=tb_sincos.vcd

IF %1 EQU 1 start "" gtkwave tb_sincos.vcd
