library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.system_clocks_pkg.all;
    use work.vendor_specifics_pkg.all;
--     use work.system_control_pkg.all;
--
entity top is
    port(
-- main clock input
	    xclk : in std_logic;

        testout : out std_logic
        -- system_control_FPGA_in  : in system_control_FPGA_input_group;
        -- system_control_FPGA_out : out system_control_FPGA_output_group
    );
end top;

architecture behavioral of top is

-- component pll_wrapper is
--     port (
--         xclk : in std_logic;
--         core_clk : out std_logic;
--         modulator_clk : out std_logic;
--         modulator_clk2 : out std_logic;
--         pll_lock : out std_logic
--     );
-- end component;

    -- signal system_clocks : system_clock_group;    
    -- signal system_control_data_in  : system_control_data_input_group;
    -- signal system_control_data_out : system_control_data_output_group;
    signal system_clocks : system_clock_group;

begin

core_clocks : pll_wrapper
	port map
	(
		xclk,
        system_clocks
	);

    -- system_clocks <= (clk_128mhz,  clk_256mhz, clk2_256mhz, std_pll_lock);
    -- u_system_control : system_control
    --     port map(
    --         system_clocks,
    --         system_control_FPGA_in,
    --         system_control_FPGA_out,
    --         system_control_data_in,
    --         system_control_data_out
    --     );
    --
end behavioral;
