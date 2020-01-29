library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

library work;
    use work.power_supply_control_pkg.all;
    use work.pfc_control_pkg.all;

entity power_supply_control is
    port (
        power_supply_control_clocks : in power_supply_control_clock_group;

        power_supply_control_FPGA_out : out power_supply_control_FPGA_output_group;

        power_supply_control_data_in : in power_supply_control_data_input_group;
        power_supply_control_data_out : out power_supply_control_data_output_group
    );
end entity power_supply_control;

architecture rtl of power_supply_control is

    alias onboard_ad_control_data_in is power_supply_control_data_out.onboard_ad_control_data_in;

    alias modulator_clock : std_logic is power_supply_control_clocks.modulator_clock;
    alias core_clock : std_logic is power_supply_control_clocks.core_clock;
    alias pll_lock : std_logic is power_supply_control_clocks.pll_lock;
    signal master_carrier : integer range 0 to 2**12-1;

    signal pfc_control_clocks   : pfc_control_clock_group;
    signal pfc_control_data_in  : pfc_control_data_input_group;
    signal pfc_control_data_out : pfc_control_data_output_group;

begin

------------------------------------------------------------------------
    power_supply_sequencer : process(core_clock)
        
    begin
        if rising_edge(core_clock) then
            if pll_lock = '0' then
            -- reset state
                pfc_control_data_in.start_pfc <= false;

            else
                pfc_control_data_in.start_pfc <= true;
            end if; -- rstn
        end if; --rising_edge
    end process power_supply_sequencer;	

------------------------------------------------------------------------
    test_adc : process(power_supply_control_clocks.core_clock)
        variable adc_test_counter : integer;
    begin
        if rising_edge(power_supply_control_clocks.core_clock) then
            if power_supply_control_clocks.pll_lock = '0' then
            -- reset state
                adc_test_counter := 0;
                onboard_ad_control_data_in <=(false, 0, false, 0);
            else
                adc_test_counter := adc_test_counter + 1;
                if adc_test_counter = 896 then
                    adc_test_counter := 0;
                end if;

                onboard_ad_control_data_in.ada_start_request <= false;
                onboard_ad_control_data_in.adb_start_request <= false;
                CASE adc_test_counter is
                    WHEN 0 =>
                        onboard_ad_control_data_in <= trigger_adc(1);
                    WHEN 128 =>
                        onboard_ad_control_data_in <= trigger_adc(2);
                    WHEN 256 =>
                        onboard_ad_control_data_in <= trigger_adc(3);
                    WHEN 384 =>
                        onboard_ad_control_data_in <= trigger_adc(4);
                    WHEN 512 =>
                        onboard_ad_control_data_in <= trigger_adc(5);
                    WHEN 640 =>
                        onboard_ad_control_data_in <= trigger_adc(6);
                    WHEN 768 =>
                        onboard_ad_control_data_in <= trigger_adc(0);
                    WHEN others =>
                end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process test_adc;	

    -- free running carrier common for pfc and dhb controls, and used for triggering adc
------------------------------------------------------------------------
    carrier_generation : process(power_supply_control_clocks.modulator_clock)
        
    begin
        if rising_edge(power_supply_control_clocks.modulator_clock) then
                -- register carrier for pfc and dhb to shorten logic path
                pfc_control_data_in.pfc_carrier <= master_carrier;
                master_carrier <= master_carrier + 1;
                if master_carrier > 1896 then
                    master_carrier <= 0;
                end if;
        end if; --rising_edge
    end process carrier_generation;	
------------------------------------------------------------------------
    pfc_control_clocks <= ( core_clock => core_clock,
                            modulator_clock => modulator_clock,
                            pll_lock => pll_lock);
    u_pfc_control : pfc_control
        port map
        (
            pfc_control_clocks, 
            power_supply_control_FPGA_out.pfc_control_FPGA_out, 
            pfc_control_data_in, 
            pfc_control_data_out  
        );
------------------------------------------------------------------------

end rtl;
