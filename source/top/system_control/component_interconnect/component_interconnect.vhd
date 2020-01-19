library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.component_interconnect_pkg.all;
    use work.led_driver_pkg.all;
    use work.uart_pkg.all;
    use work.multiplier_pkg.all;
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

    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;

begin
------------------------------------------------------------------------
    -- si_uart_start_event <= '1' when onboard_ad_control_data_out.ada_data_is_ready and onboard_ad_control_data_out.ada_channel = to_integer(unsigned(so16_uart_rx_data)) else '0';
    -- si16_uart_tx_data <= std_logic_vector(to_unsigned(onboard_ad_control_data_out.ada_conversion_data,16));
------------------------------------------------------------------------
    test_adc : process(system_clocks.core_clock)
        variable adc_test_counter : integer;
    begin
        if rising_edge(system_clocks.core_clock) then
            if system_clocks.pll_lock = '0' then
            -- reset state
                adc_test_counter := 0;
                onboard_ad_control_data_in <=(false, 0, false, 0);
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

    test_multiplier : process(system_clocks.core_clock)
        constant b1 : int18 := 2500;
        constant a1 : int18 := 22e3;
        constant b0 : int18 := 2**15-a1-b1;
        constant uin : int18 := 44252;
        constant radix : integer := 15;
        variable mem, mem1, y : int18;
        variable process_counter : int18;
        variable delay_counter : integer;
        ------------------------------------------------------------------------
        impure function "*" (left, right : int18) return int18
        is
        begin
            alu_mpy(left, right, multiplier_data_in, multiplier_data_out);
            return get_result(multiplier_data_out,radix);
        end "*";
        ------------------------------------------------------------------------
    begin
        if rising_edge(system_clocks.core_clock) then
            if system_clocks.pll_lock = '0' then
            -- reset state
                process_counter := 0;
                multiplier_data_in.mult_a <= 0;
                multiplier_data_in.mult_b <= 0;
                multiplier_data_in.multiplication_is_requested <= false;
                mem := 0;
                mem1 := 0;
                delay_counter := 0;
            else
                increment(delay_counter);
                if delay_counter = 1280 then
                    delay_counter := 0;
                end if;
                si_uart_start_event <= '0';
                multiplier_data_in.multiplication_is_requested <= false;
            case process_counter is
                WHEN 0 => 
                    if delay_counter = 0 then
                            increment(process_counter);
                    end if;
               WHEN 1 => 
                    y := uin * b0 + mem1;
                    if multiplier_is_ready(multiplier_data_out) then
                        increment(process_counter);
                        si_uart_start_event <= '1';
                        si16_uart_tx_data <= std_logic_vector(to_signed(y,16));
                    end if;
                WHEN 2 => 
                    mem1 := b1 * uin;
                    increment(process_counter);
                WHEN 3 => 
                    mem1 := a1 * y;
                    if multiplier_is_ready(multiplier_data_out) then
                        mem1 := get_result(multiplier_data_out,radix);
                        increment(process_counter);
                    end if;
                when 4 =>
                    mem1 := mem1 + get_result(multiplier_data_out,radix);
                    process_counter := 0;
                when others =>
                end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process test_multiplier;	


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
	generic map(24,2,2)
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
    multiplier_clocks.dsp_clock <= system_clocks.core_clock;
    u_multiplier : multiplier
        port map(
            multiplier_clocks, 
            multiplier_data_in,
            multiplier_data_out 
        );
end rtl;
