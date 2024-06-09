
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
    signal bus_from_communications : fpga_interconnect_record;
    signal bus_out : fpga_interconnect_record;
------------------------------------------------------------------------
    signal rtl_current : integer range -2**15 to 2**15-1 := 0;
    signal rtl_voltage : integer range -2**15 to 2**15-1 := 0;
    signal processor_ready : boolean := false;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;
------------------------------------------------------------------------
begin

    component_interconnect_data_out.measurement_interface_data_out <= measurement_interface_data_out;
------------------------------------------------------------------------
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

        u_power_supply_control : power_supply_control
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

                bus_to_communications <= bus_out and 
                                         bus_from_boost_model and 
                                         bus_to_component_interconnect;
            end if;
        end process;
------------------------------------------------------------------------

    u_boost_model : entity work.boost_model
    port map(
        clock        => system_clocks.core_clock          ,
        bus_to_boost_model     => bus_from_communications ,
        bus_from_boost_model   => bus_from_boost_model    ,

        rtl_current => rtl_current,
        rtl_voltage => rtl_voltage,

        program_ready        => processor_ready);
------------------------------------------------------------------------
end rtl;
