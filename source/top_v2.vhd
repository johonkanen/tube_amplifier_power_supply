library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.led_driver_pkg.all;
    use work.power_supply_control_pkg.all;
    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_model_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;
    use work.half_bridge_current_control_pkg.all;
    use work.voltage_control_pkg.all;
    
entity top is
    port (
        xclk    : in std_logic;
        uart_rx : in std_logic;
        uart_tx : out std_logic
    );
end entity component_interconnect;

architecture rtl of top is
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
    signal boost_model_bus : boost_model_interface_record := (others => init_fpga_interconnect);

    signal bus_to_communications : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_test_control : fpga_interconnect_record := init_fpga_interconnect;

    alias bus_from_communications is boost_model_bus.bus_to_boost_model;
    alias bus_from_boost_model is boost_model_bus.bus_from_boost_model;
------------------------------------------------------------------------
------------------------------------------------------------------------
    -- hack signals
    signal current_control : current_control_record := init_current_control(16.0, 8.0/4, number_of_fractional_bits => 7);
    signal self : voltage_control_record := init_voltage_control;
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

    signal boost_interface       : boost_interface_record;
    signal control_counter       : natural range 0 to 2**15-1      := 0;
    signal model_trigger_counter : natural range 0 to 255          := 0;
    signal reference_voltage     : integer range -2**15 to 2**15-1 := to_fixed(205.0,7);

------------------------------------------------------------------------
begin

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
        process(system_clocks.core_clock) is
        begin
            if rising_edge(system_clocks.core_clock) then
                init_bus(bus_out);
                connect_read_only_data_to_address(bus_from_communications, bus_out, interconnect_test_address, 44252);

                bus_to_communications <= bus_out               and
                                         bus_from_boost_model  and
                                         bus_from_test_control;
            end if;
        end process;
------------------------------------------------------------------------

    test_control : process(system_clocks.core_clock)
        constant dutymax : integer := to_fixed(0.90, number_of_fractional_bits => 15);
        constant dutymin : integer := to_fixed(0.10, number_of_fractional_bits => 15);
        constant vkp     : integer := to_fixed(0.5     , 15);
        constant vki     : integer := to_fixed(0.016125/4.0 , 15);
    begin
        if rising_edge(system_clocks.core_clock) then

            init_bus(bus_from_test_control);
            connect_data_to_address(bus_from_communications, bus_from_test_control, 11, reference_voltage);

            create_multiplier(voltage_multiplier);
            create_voltage_control(self, voltage_multiplier,
            proportional_gain => vkp,
            integral_gain     => vki);

            create_divider_and_multiplier(divider,divider_multiplier);
            create_multiplier(multiplier);
            create_current_control(current_control,multiplier, divider, divider_multiplier,
                                    get_measurement(boost_interface, dc_link_voltage),
                                    get_measurement(boost_interface, input_voltage),
                                    dutymax     ,
                                    dutymin);

            create_boost_interface(boost_interface);

            if control_counter < 128e6/120e3 then
                control_counter <= control_counter + 1;
            else
                control_counter <= 0;
                request_current_control(current_control, self.current_ref, get_measurement(boost_interface,inductor_current)*2**4);
                request_voltage_control(self, reference_voltage , get_measurement(boost_interface,dc_link_voltage)*2);
            end if;

            if current_control_is_ready(current_control) then
                set_duty(boost_interface, get_int_multiplier_result(multiplier, 7, 20, target_radix => 15));
            end if;

            if model_trigger_counter < integer(cl_parameters.timestep*128.0e6) then -- counter for 1us calculation time
                model_trigger_counter <= model_trigger_counter + 1;
            else
                model_trigger_counter <= 0;
                request_boost_calculation(boost_interface);
            end if;

        end if; --rising_edge
    end process test_control;	

------------------------------------------------------------------------
    u_boost_model : entity work.boost_model
    generic map(boost_model_parameters => cl_parameters, initial_voltage => 150.0)
    port map(
        system_clocks.core_clock ,
        boost_model_bus,

        boost_in  => boost_interface.input ,
        boost_out => boost_interface.output
    );
------------------------------------------------------------------------
end rtl;
