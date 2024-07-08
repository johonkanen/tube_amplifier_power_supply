library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.component_interconnect_pkg.all;
    use work.led_driver_pkg.all;
    use work.power_supply_control_pkg.all;
    use work.sincos_pkg.all;
    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_model_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;
    use work.half_bridge_current_control_pkg.all;
    use work.voltage_control_pkg.all;
    
library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.get_ad_measurement;
    use onboard_adc_library.onboard_ad_control_pkg.ad_channel_is_ready;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;

    use work.timing_pkg.all;
    use work.typedefines_pkg.all;
    use work.test_interface_pkg.all;

    use work.tubepsu_addresses_pkg;

entity component_interconnect is
    port (
        system_clocks : in work.system_clocks_pkg.system_clock_group;    

        component_interconnect_FPGA_in : in component_interconnect_FPGA_input_group;
        component_interconnect_FPGA_out : out component_interconnect_FPGA_output_group;

        component_interconnect_data_in : in component_interconnect_data_input_group;
        component_interconnect_data_out : out component_interconnect_data_output_group;

        bus_to_component_interconnect   : in fpga_interconnect_record;
        bus_from_component_interconnect : out fpga_interconnect_record
    );
end entity component_interconnect;

architecture rtl of component_interconnect is
    alias core_clock is system_clocks.core_clock;
    alias reset_n is system_clocks.pll_lock;

    use work.tubepsu_addresses_pkg.all;

------------------------------------------------------------------------
    signal measurement_interface_clocks   : measurement_interface_clock_group;
    signal measurement_interface_data_in  : measurement_interface_data_input_group;
    signal measurement_interface_data_out : measurement_interface_data_output_group;
------------------------------------------------------------------------
    signal power_supply_control_clocks   : power_supply_control_clock_group;
    signal power_supply_control_data_in  : power_supply_control_data_input_group;
    signal power_supply_control_data_out : power_supply_control_data_output_group;
------------------------------------------------------------------------
    signal bus_to_communications   : fpga_interconnect_record;
    signal bus_out : fpga_interconnect_record;
------------------------------------------------------------------------
    signal processor_ready : boolean := false;

    signal bus_from_communications : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_test_control : fpga_interconnect_record := init_fpga_interconnect;
------------------------------------------------------------------------
    signal current_control : current_control_record := init_current_control(16.0, 8.0/4, number_of_fractional_bits => 7);
    signal voltage_control : voltage_control_record := init_voltage_control;
    signal vkp : integer := to_fixed(0.25     , 15);
    signal vki : integer := to_fixed(0.016125 , 15);

    signal multiplier         : multiplier_record := init_multiplier;
    signal voltage_multiplier : multiplier_record := init_multiplier;
    signal divider            : division_record   := init_division;
    signal divider_multiplier : multiplier_record := init_multiplier;


    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 1.0e-6);

    signal boost_model_interface : boost_model_interface_record;
    signal control_counter : natural range 0 to 2**15-1 := 0;
    signal model_trigger_counter : natural range 0 to 255 := 0;
    signal reference_voltage : integer range -2**15 to 2**15-1 := to_fixed(205.0,7);

    signal test_interface : comm_bus_record;
    signal data_from_test_interface : std_logic_vector(15 downto 0);

------------------------------------------------------------------------
begin

    component_interconnect_data_out.measurement_interface_data_out <= measurement_interface_data_out;
------------------------------------------------------------------------
    measurement_interface_clocks <= (system_clocks.core_clock, system_clocks.core_clock, system_clocks.pll_lock);
    u_measurement_interface : entity onboard_adc_library.measurement_interface 
    port map(
        measurement_interface_clocks,   
        component_interconnect_FPGA_in.measurement_interface_FPGA_in,  
        component_interconnect_FPGA_out.measurement_interface_FPGA_out, 
        measurement_interface_data_in,
        measurement_interface_data_out 
    );

------------------------------------------------------------------------
    burn_leds : entity work.led_driver
    port map(system_clocks.core_clock, 
            component_interconnect_FPGA_out.po3_led1, 
            component_interconnect_FPGA_out.po3_led2, 
            component_interconnect_FPGA_out.po3_led3, 
            component_interconnect_data_in.led1_color, 
            component_interconnect_data_in.led2_color, 
            component_interconnect_data_in.led3_color);

------------------------------------------------------------------------
        power_supply_control_clocks <= (core_clock      => system_clocks.core_clock,
                                        modulator_clock => system_clocks.modulator_clock,
                                        pll_lock        => system_clocks.pll_lock);

        measurement_interface_data_in                               <= power_supply_control_data_out.measurement_interface_data_in;
        power_supply_control_data_in.measurement_interface_data_out <= measurement_interface_data_out;
        power_supply_control_data_in.power_supplies_are_enabled     <= component_interconnect_data_in.power_supplies_are_enabled;

        u_power_supply_control : entity work.power_supply_control
        port map (
            power_supply_control_clocks                                   ,
            component_interconnect_FPGA_out.power_supply_control_FPGA_out ,
            power_supply_control_data_in                                  ,
            power_supply_control_data_out
        );
------------------------------------------------------------------------
    u_communications : entity work.fpga_communications
        port map(
            clock                   => system_clocks.core_clock                          ,
            uart_rx                 => component_interconnect_FPGA_in.pi_uart_rx_serial  ,
            uart_tx                 => component_interconnect_FPGA_out.po_uart_tx_serial ,
            bus_to_communications   => bus_to_communications                             ,
            bus_from_communications => bus_from_communications
        );
------------------------------------------------------------------------

        bus_from_component_interconnect <= bus_from_communications;

        process(system_clocks.core_clock) is
            procedure loopback
            (
                signal self : view comm_bus_view
            ) is
            begin
                init_tx(self);
                if write_to_address_is_requested(bus_from_communications, tubepsu_addresses_pkg.vhdl2019_interface_test_address) then
                    write_data(self, get_data(bus_from_communications));
                end if;
                if bus_feedback_is_ready(self) then
                    data_from_test_interface <= self.data_from_entity;
                end if;
            end loopback;
        begin
            if rising_edge(system_clocks.core_clock) then
                init_bus(bus_out);
                connect_read_only_data_to_address(bus_from_communications, bus_out, interconnect_test_address, 44252);

                loopback(test_interface);
                connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.vhdl2019_interface_test_address, data_from_test_interface);

                bus_to_communications <= bus_out              and
                                         bus_from_boost_model and
                                         bus_from_test_control and
                                         bus_to_component_interconnect;
            end if;
        end process;
------------------------------------------------------------------------

    test_control : process(system_clocks.core_clock)
        constant dutymax : integer := to_fixed(0.90, number_of_fractional_bits => 15);
        constant dutymin : integer := to_fixed(0.10, number_of_fractional_bits => 15);
        constant vkp : integer := to_fixed(0.5     , 15);
        constant vki : integer := to_fixed(0.016125/4.0 , 15);
            
    begin
        if rising_edge(system_clocks.core_clock) then
            init_bus(bus_from_test_control);
            connect_data_to_address(bus_from_communications, bus_from_test_control, 11, reference_voltage);


            create_multiplier(voltage_multiplier);
            create_voltage_control(voltage_control, voltage_multiplier,
            proportional_gain => vkp,
            integral_gain     => vki);

            create_divider_and_multiplier(divider,divider_multiplier);
            create_multiplier(multiplier);
            create_current_control(current_control,multiplier, divider, divider_multiplier,
                                    get_measurement(boost_model_interface, dc_link_voltage),
                                    get_measurement(boost_model_interface, input_voltage),
                                    dutymax     ,
                                    dutymin);

            create_boost_model_interface(boost_model_interface);

            if control_counter < 128e6/120e3 then
                control_counter <= control_counter + 1;
            else
                control_counter <= 0;
                request_current_control(current_control , voltage_control.current_ref , get_measurement(boost_model_interface , inductor_current)*2**4);
                request_voltage_control(voltage_control , reference_voltage           , get_measurement(boost_model_interface , dc_link_voltage)*2);
            end if;

            if current_control_is_ready(current_control) then
                set_duty(boost_model_interface, get_int_multiplier_result(multiplier, 7, 20, target_radix => 15));
            end if;

            if model_trigger_counter < integer(cl_parameters.timestep*128.0e6) then -- counter for 1us calculation time
                model_trigger_counter <= model_trigger_counter + 1;
            else
                model_trigger_counter <= 0;
                request_boost_calculation(boost_model_interface);
            end if;

        end if; --rising_edge
    end process test_control;	

------------------------------------------------------------------------
    u_test_entity : entity work.test_entity
    port map(core_clock, test_interface);
------------------------------------------------------------------------
    u_boost_model : entity work.boost_model
    generic map(boost_model_parameters => cl_parameters, initial_voltage => 150.0)
    port map(
        system_clocks.core_clock ,
        bus_from_communications,
        bus_from_boost_model,
        boost_model_interface.input,
        boost_model_interface.output
    );
------------------------------------------------------------------------
end rtl;
