library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.pfc_modulator_pkg.all;

entity pfc_modulator is
    generic( g_carrier_max_value : integer);
    port (
        pfc_modulator_clocks : in pfc_modulator_clock_group;
        pfc_modulator_FPGA_out : out pfc_modulator_FPGA_output_group;
        pfc_modulator_data_in : in pfc_modulator_data_input_group;
        pfc_modulator_data_out : out pfc_modulator_data_output_group
    );
end entity pfc_modulator;


architecture rtl of pfc_modulator is

    
    alias modulator_clock : std_logic is pfc_modulator_clocks.modulator_clock;
    alias core_clock : std_logic is pfc_modulator_clocks.core_clock;

    subtype uint12 is integer range 0 to 2**12-1;

    signal jee : uint12;
    signal pfc_carrier : uint12;
    signal pfc_carrier1 : uint12;

    signal shift_register : std_logic_vector(1 downto 0); 
    signal shift_register2 : std_logic_vector(2 downto 0); 

begin

    clock_crossing : process(core_clock)
        
    begin
        if rising_edge(core_clock) then

        end if; --rising_edge
    end process clock_crossing;	

    pwm_modulator : process(modulator_clock)
        
    begin

        if rising_edge(modulator_clock) then
            if pfc_modulator_data_in.pfc_carrier <= g_carrier_max_value/2 then
                pfc_carrier <= pfc_carrier + 1;
            else
                pfc_carrier <= pfc_carrier - 1;
            end if;

            shift_register2 <= shift_register2(1 downto 0) & pfc_modulator_data_in.tg_load_pfc_duty;
            if shift_register2(2) /= shift_register2(1) then
                jee <= pfc_modulator_data_in.duty;
            end if;

            pfc_carrier1 <= pfc_carrier;
            if pfc_carrier1 < jee then
                pfc_modulator_FPGA_out.ac1_switch <= '1';
                pfc_modulator_FPGA_out.ac2_switch <= '1';
            else
                pfc_modulator_FPGA_out.ac1_switch <= '0';
                pfc_modulator_FPGA_out.ac2_switch <= '0';
            end if;

            shift_register <= shift_register(0) & pfc_modulator_data_in.pfc_is_enabled;
            if shift_register(1) = '0' then
                pfc_modulator_FPGA_out.ac1_switch <= '0';
                pfc_modulator_FPGA_out.ac2_switch <= '0';
            end if;

        end if; --rising_edge
    end process pwm_modulator;	


end rtl;
