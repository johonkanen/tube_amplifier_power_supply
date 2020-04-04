library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.deadtime_pkg.all;


entity deadtime is
    port (
        deadtime_clocks : in deadtime_clock_group; 
        deadtime_FPGA_out : out deadtime_FPGA_output_group; 
        deadtime_data_in : in deadtime_data_input_group
    );
end entity;

architecture rtl of deadtime is

    alias modulator_clock is deadtime_clocks.modulator_clock;
    alias half_bridge_gates is deadtime_fpga_out.half_bridge_gates;
    alias half_bridge_voltage is deadtime_data_in.half_bridge_voltage;
    
    constant positive_vector : std_logic_vector(1 downto 0) := "10";
    constant negative_vector : std_logic_vector(1 downto 0) := "01";

begin

    deadtime_generator : process(modulator_clock)
        
    begin
        if rising_edge(modulator_clock) then
            -- if reset_n = '0' then
            -- -- reset state
            -- else
            --
            if half_bridge_voltage = '1' then
                half_bridge_gates <= positive_vector;
            else
                half_bridge_gates <= negative_vector;
            end if;
    
            -- end if; -- rstn
        end if; --rising_edge
    end process deadtime_generator;	


end rtl;

