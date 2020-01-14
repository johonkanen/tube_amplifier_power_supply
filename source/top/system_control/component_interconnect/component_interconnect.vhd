library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.component_interconnect_pkg.all;
    use work.led_driver_pkg.all;
    use work.uart_pkg.all;
    -- use work.sw_supply_ctrl_pkg.all;
library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

entity component_interconnect is
    port (
        system_clocks : in work.system_clocks_pkg.system_clock_group;    

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group
    );
end entity component_interconnect;

architecture rtl of component_interconnect is

    -- signal sw_supply_control_clocks : sw_supply_control_clock_group;
    -- signal sw_supply_control_data_in : sw_supply_control_data_input_group;
    -- signal sw_supply_control_data_out : sw_supply_control_data_output_group;

    signal core_clk            : std_logic;
    signal po_uart_tx_serial   :  std_logic;
    signal pi_uart_rx_serial   : std_logic;
    signal si_uart_start_event : std_logic;
    signal si16_uart_tx_data   : std_logic_vector(15 downto 0);
    signal so_uart_ready_event :  std_logic;
    signal so16_uart_rx_data   :  std_logic_vector(15 downto 0);

    signal onboard_ad_control_clocks   : onboard_ad_control_clock_group;
    signal onboard_ad_control_data_in  : onboard_ad_control_data_input_group;
    signal onboard_ad_control_data_out : onboard_ad_control_data_output_group;
begin
------------------------------------------------------------------------
    si_uart_start_event <= '1' when onboard_ad_control_data_out.ada_data_is_ready and onboard_ad_control_data_out.ada_channel = to_integer(unsigned(so16_uart_rx_data)) else '0';
    si16_uart_tx_data <= std_logic_vector(to_unsigned(onboard_ad_control_data_out.ada_conversion_data,16));
------------------------------------------------------------------------
    test_adc : process(system_clocks.core_clock)
        variable adc_test_counter : integer;
    begin
        if rising_edge(system_clocks.core_clock) then
            if system_clocks.pll_lock = '0' then
            -- reset state
                adc_test_counter := 0;
            else
                adc_test_counter := adc_test_counter + 1;
                if adc_test_counter = 7680 then
                    adc_test_counter := 0;
                end if;

                onboard_ad_control_data_in.ada_start_request <= false;
                onboard_ad_control_data_in.adb_start_request <= false;
                CASE adc_test_counter is
                    WHEN 0 =>
                        onboard_ad_control_data_in <= trigger_adc(1);
                    WHEN 948 =>
                        onboard_ad_control_data_in <= trigger_adc(2);
                    WHEN 1896 =>
                        onboard_ad_control_data_in <= trigger_adc(3);
                    WHEN 3792 =>
                        onboard_ad_control_data_in <= trigger_adc(4);
                    WHEN 4740 =>
                        onboard_ad_control_data_in <= trigger_adc(5);
                    WHEN 5688 =>
                        onboard_ad_control_data_in <= trigger_adc(6);
                    WHEN 6636 =>
                        onboard_ad_control_data_in <= trigger_adc(0);
                    WHEN others =>
                end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process test_adc;	

------------------------------------------------------------------------  
-- onboard_ad_control_data_in <= component_interconnect_data_in.onboard_ad_control_data_in;
    component_interconnect_data_out.onboard_ad_control_data_out <= onboard_ad_control_data_out;

    onboard_ad_control_clocks <= (system_clocks.core_clock, system_clocks.core_clock, system_clocks.pll_lock);
    u_onboard_ad_control : onboard_ad_control 
    port map(
        onboard_ad_control_clocks,   
        component_interconnect_FPGA_in.onboard_ad_control_FPGA_in,  
        component_interconnect_FPGA_out.onboard_ad_control_FPGA_out, 
        onboard_ad_control_data_in,
        onboard_ad_control_data_out 
    );
------------------------------------------------------------------------
    burn_leds : led_driver
    port map(system_clocks.core_clock, component_interconnect_FPGA_out.po3_led1, component_interconnect_FPGA_out.po3_led2, component_interconnect_FPGA_out.po3_led3, component_interconnect_data_in.led1_color, component_interconnect_data_in.led2_color, component_interconnect_data_in.led3_color);
------------------------------------------------------------------------
    u_uart_event_ctrl : uart_event_ctrl
	generic map(25,2,2)
    port map(
	    system_clocks.core_clock,
	    component_interconnect_FPGA_out.po_uart_tx_serial,
	    component_interconnect_FPGA_in.pi_uart_rx_serial,
	    si_uart_start_event,
        -- '1',
	    si16_uart_tx_data,
	    so_uart_ready_event,
	    so16_uart_rx_data
	);
------------------------------------------------------------------------
end rtl;
