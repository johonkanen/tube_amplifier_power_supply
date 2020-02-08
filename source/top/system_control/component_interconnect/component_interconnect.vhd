library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.component_interconnect_pkg.all;
    use work.led_driver_pkg.all;
    use work.uart_pkg.all;
    use work.multiplier_pkg.all;
    use work.power_supply_control_pkg.all;
    
library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.get_ad_measurement;
    use onboard_adc_library.onboard_ad_control_pkg.ad_channel_is_ready;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;

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

    function "<"
    (
        left : std_logic_vector; right : integer
    )
    return boolean
    is
    begin
        return to_integer(unsigned(left)) < right;
    end "<";

------------------------------------------------------------------------
    signal si_uart_start_event : std_logic;
    signal si16_uart_tx_data   : std_logic_vector(15 downto 0);
    signal so_uart_ready_event :  std_logic;
    signal so16_uart_rx_data   :  std_logic_vector(15 downto 0);
------------------------------------------------------------------------
    signal measurement_interface_clocks   : measurement_interface_clock_group;
    signal measurement_interface_data_in  : measurement_interface_data_input_group;
    signal measurement_interface_data_out : measurement_interface_data_output_group;
------------------------------------------------------------------------
    signal multiplier_clocks   : multiplier_clock_group;
    signal multiplier_data_in  : multiplier_data_input_group;
    signal multiplier_data_out :  multiplier_data_output_group;
------------------------------------------------------------------------
    signal power_supply_control_clocks   : power_supply_control_clock_group;
    signal power_supply_control_data_in  : power_supply_control_data_input_group;
    signal power_supply_control_data_out :  power_supply_control_data_output_group;
------------------------------------------------------------------------
begin
------------------------------------------------------------------------
    test_multiplier : process(system_clocks.core_clock)
        constant b1 : int18 := 2500;
        constant a1 : int18 := 22e3;
        constant b0 : int18 := 2**15-a1-b1;
        variable uin : int18;
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
                mem1 := 0;
                delay_counter := 0;
                uin := 0;
            else
                increment(delay_counter);
                if delay_counter = 1280 then
                    delay_counter := 0;
                end if;
                si_uart_start_event <= '0';
                multiplier_data_in.multiplication_is_requested <= false;
            case process_counter is
                WHEN 0 => 
                    if so16_uart_rx_data < 7 then
                        if ad_channel_is_ready(measurement_interface_data_out.onboard_ad_control_data_out.ada_measurements,
                           to_integer(unsigned(so16_uart_rx_data))) then

                            increment(process_counter);
                            uin := get_ada_measurement(measurement_interface_data_out);
                        end if;
                    elsif so16_uart_rx_data < 8 then 
                        if measurement_interface_data_out.dhb_ad_is_done then
                            uin := measurement_interface_data_out.dhb_ad_measurement;
                            increment(process_counter);
                        end if;
                    else
                        if measurement_interface_data_out.llc_ad_is_done then
                            uin := measurement_interface_data_out.llc_ad_measurement;
                            increment(process_counter);
                        end if;
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
                    if multiplier_is_ready(multiplier_data_out) then
                        mem1 := mem1 + get_result(multiplier_data_out,radix);
                        process_counter := 0;
                    end if;
                when others =>
                end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process test_multiplier;

------------------------------------------------------------------------  
-- measurement_interface_data_in <= component_interconnect_data_in.measurement_interface_data_in;
    component_interconnect_data_out.measurement_interface_data_out <= measurement_interface_data_out;
    measurement_interface_clocks <= (system_clocks.core_clock, system_clocks.core_clock, system_clocks.pll_lock);
    u_measurement_interface : measurement_interface 
    port map(
        measurement_interface_clocks,   
        component_interconnect_FPGA_in.measurement_interface_FPGA_in,  
        component_interconnect_FPGA_out.measurement_interface_FPGA_out, 
        measurement_interface_data_in,
        measurement_interface_data_out 
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

------------------------------------------------------------------------
        power_supply_control_clocks <= (core_clock      => system_clocks.core_clock,
                                        modulator_clock => system_clocks.modulator_clock,
                                        pll_lock        => system_clocks.pll_lock);

        measurement_interface_data_in <= power_supply_control_data_out.measurement_interface_data_in;
        power_supply_control_data_in.measurement_interface_data_out <= measurement_interface_data_out;
        u_power_supply_control : power_supply_control
        port map (
            power_supply_control_clocks,
            component_interconnect_FPGA_out.power_supply_control_FPGA_out,
            power_supply_control_data_in,
            power_supply_control_data_out
        );
------------------------------------------------------------------------
end rtl;
