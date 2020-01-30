library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.phase_modulator_pkg.all;

entity phase_modulator is
    generic (g_carrier_max_value : integer);
    port (
        phase_modulator_clocks : in phase_modulator_clock_group; 
        phase_modulator_FPGA_out : out phase_modulator_FPGA_output_group; 
        phase_modulator_data_in : in phase_modulator_data_input_group;
        phase_modulator_data_out : out phase_modulator_data_output_group
    );
end entity phase_modulator;

architecture rtl of phase_modulator is

    alias core_clock : std_logic is phase_modulator_clocks.core_clock;
    alias modulator_clock : std_logic is phase_modulator_clocks.modulator_clock;
    

begin

    create_pwm : process(modulator_clock)
        
    begin
        if rising_edge(modulator_clock) then
            if phase_modulator_data_in.dhb_is_enabled then
            -- reset state
                if phase_modulator_data_in.carrier > g_carrier_max_value/2 then
                    phase_modulator_FPGA_out.primary <= positive_vector;
                    phase_modulator_FPGA_out.secondary <= positive_vector;
                else
                    phase_modulator_FPGA_out.primary <= negative_vector;
                    phase_modulator_FPGA_out.secondary <= negative_vector;
                end if;
    
            end if; -- rstn
        end if; --rising_edge
    end process create_pwm;	


end rtl;
