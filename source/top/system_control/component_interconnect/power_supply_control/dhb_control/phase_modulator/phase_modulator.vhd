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

    subtype uint12 is integer range 0 to 2**12-1;

    alias core_clock : std_logic is phase_modulator_clocks.core_clock;
    alias modulator_clock : std_logic is phase_modulator_clocks.modulator_clock;

    signal dhb_master_carrier : uint12 := 0;
    signal dhb_primary_carrier : uint12 := 0;
    signal dhb_secondary_carrier : uint12 := 0;
    signal primary_phase_shift : uint12;
    signal secondary_phase_shift : uint12;
    

begin

    create_carriers : process(modulator_clock)
        
    begin
        if rising_edge(modulator_clock) then
            if phase_modulator_data_in.phase < 0 then
                primary_phase_shift <= -phase_modulator_data_in.phase;
                secondary_phase_shift <= 0;
            else
                secondary_phase_shift <= phase_modulator_data_in.phase;
                primary_phase_shift <= 0;
            end if;
------------------------------------------------------------------------
            dhb_master_carrier <= dhb_master_carrier + 1;
            if phase_modulator_data_in.carrier = g_carrier_max_value/4 then
                dhb_master_carrier <= 0;
            end if;
------------------------------------------------------------------------
            dhb_primary_carrier <= dhb_primary_carrier + 1;
            dhb_secondary_carrier <= dhb_secondary_carrier + 1;
------------------------------------------------------------------------
            if dhb_master_carrier = primary_phase_shift then
                dhb_primary_carrier <= 0;
            end if;
------------------------------------------------------------------------
            if dhb_master_carrier = secondary_phase_shift then
                dhb_secondary_carrier <= 0;
            end if;
------------------------------------------------------------------------
            if dhb_primary_carrier > g_carrier_max_value/2 then
                phase_modulator_FPGA_out.primary <= positive_vector;
            else
                phase_modulator_FPGA_out.primary <= negative_vector;
            end if;
------------------------------------------------------------------------
            if dhb_secondary_carrier > g_carrier_max_value/2 then
                phase_modulator_FPGA_out.secondary <= positive_vector;
            else
                phase_modulator_FPGA_out.secondary <= negative_vector;
            end if;
------------------------------------------------------------------------
        end if; --rising_edge
    end process create_carriers;	


end rtl;
