library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.system_clocks_pkg.all;
    use work.system_control_pkg.all;

entity top is
    port(
	    xclk : in std_logic;
        system_control_FPGA_in  : in system_control_FPGA_input_group;
        system_control_FPGA_out : out system_control_FPGA_output_group
    );
end top;

architecture behavioral of top is

    signal system_clocks : system_clock_group;

begin
------------------------------------------------------------------------
    clocks : entity work.pll_wrapper
	port map
	(
		xclk,
        system_clocks
	);
------------------------------------------------------------------------
    u_system_control : system_control
        port map(
            system_clocks,
            system_control_FPGA_in,
            system_control_FPGA_out
        );
------------------------------------------------------------------------
end behavioral;
