library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.power_supply_control_pkg.all;

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

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

begin

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

end rtl;
