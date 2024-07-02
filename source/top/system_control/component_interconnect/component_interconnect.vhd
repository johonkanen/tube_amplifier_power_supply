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
    
library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.get_ad_measurement;
    use onboard_adc_library.onboard_ad_control_pkg.ad_channel_is_ready;
    use onboard_adc_library.measurement_interface_pkg.all;
    use onboard_adc_library.psu_measurement_interface_pkg.all;

library common_library;
    use common_library.timing_pkg.all;
    use common_library.typedefines_pkg.all;

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
    signal rtl_current : integer range -2**15 to 2**15-1 := 0;
    signal rtl_voltage : integer range -2**15 to 2**15-1 := 0;
    signal processor_ready : boolean := false;

    signal boost_model_bus : boost_model_interface_record := (others => init_fpga_interconnect);
    alias bus_from_communications is boost_model_bus.bus_to_boost_model;
    alias bus_from_boost_model is boost_model_bus.bus_from_boost_model;
------------------------------------------------------------------------
    signal current_control : current_control_record := init_current_control(16.0, 10.0, number_of_fractional_bits => 7);

    signal multiplier         : multiplier_record := init_multiplier;
    signal divider            : division_record   := init_division;
    signal divider_multiplier : multiplier_record := init_multiplier;

    signal control_counter : natural range 0 to 2**15-1 := 0;

    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 100.0e-3 ,
        timestep    => 1.5e-6);
    signal boost_interface : boost_interface_record;
    signal model_trigger_counter : natural range 0 to 255 := 0;
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
        begin
            if rising_edge(system_clocks.core_clock) then
                init_bus(bus_out);
                connect_read_only_data_to_address(bus_from_communications, bus_out, interconnect_test_address, 44252);

                bus_to_communications <= bus_out              and
                                         bus_from_boost_model and
                                         bus_to_component_interconnect;
            end if;
        end process;
------------------------------------------------------------------------

    test_control : process(system_clocks.core_clock)
        constant dutymax : integer := to_fixed(0.90, number_of_fractional_bits => 15);
        constant dutymin : integer := to_fixed(0.10, number_of_fractional_bits => 15);
    begin
        if rising_edge(system_clocks.core_clock) then

            create_divider_and_multiplier(divider,divider_multiplier);
            create_multiplier(multiplier);
            create_current_control(current_control,multiplier, divider, divider_multiplier,
                                    rtl_current ,
                                    rtl_voltage ,
                                    dutymax     ,
                                    dutymin);

            create_boost_interface(boost_interface);
            if write_to_address_is_requested(bus_from_communications, 3) then
                set_duty(boost_interface, get_data(bus_from_communications));
            end if;

            if control_counter < 948 then
                control_counter <= control_counter + 1;
            else
                control_counter <= 0;
                request_current_control(current_control, to_fixed(4.0, 6), rtl_current);
            end if;

            if model_trigger_counter < 127 then -- counter for 1us calculation time
                model_trigger_counter <= model_trigger_counter + 1;
            else
                model_trigger_counter <= 0;
                request_boost_calculation(boost_interface);
            end if;

        end if; --rising_edge
    end process test_control;	

------------------------------------------------------------------------
    u_boost_model : entity work.boost_model
    generic map(boost_model_parameters => init_parameters, initial_voltage => 150.0)
    port map(
        system_clocks.core_clock ,
        boost_model_bus,

        boost_interface.processor_requested => boost_interface.processor_requested ,
        boost_interface.write_duty          => boost_interface.write_duty          ,
        boost_interface.dutyin              => boost_interface.dutyin              ,

        boost_interface.program_ready => boost_interface.program_ready ,
        boost_interface.rtl_current   => boost_interface.rtl_current   ,
        boost_interface.rtl_voltage   => boost_interface.rtl_voltage  
    );
------------------------------------------------------------------------
end rtl;
