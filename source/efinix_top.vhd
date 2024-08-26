library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.main_system_control_pkg.all;
    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_rtl_entity_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.tubepsu_addresses_pkg;
    use work.boost_control_interface_pkg.all;
    use work.test_interface_pkg.all;
    use work.sincos_pkg.all;
    use work.multiplier_pkg.all;
    
entity efinix_top is
    port (
        core_clock : in std_logic;
        uart_rx    : in std_logic;
        uart_tx    : out std_logic;

        rgb_led1   : out std_logic_vector(2 downto 0);
        rgb_led2   : out std_logic_vector(2 downto 0)
    );
end entity efinix_top;

architecture rtl of efinix_top is

------------------------------------------------------------------------
------------------------------------------------------------------------
    signal bus_to_communications   : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_hil_simulation : fpga_interconnect_record := init_fpga_interconnect;

    signal bus_from_communications      : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_main_system_control : fpga_interconnect_record := init_fpga_interconnect;

    signal bus_out : fpga_interconnect_record := init_fpga_interconnect;
------------------------------------------------------------------------
------------------------------------------------------------------------

    signal main_system_control_interface : main_system_control_record;

    signal test_interface : comm_bus_record;
    signal data_from_test_interface : std_logic_vector(15 downto 0);

------------------------------------------------------------------------
begin

    rgb_led1 <= data_from_test_interface(2 downto 0);
    rgb_led2 <= data_from_test_interface(5 downto 3);

------------------------------------------------------------------------
    u_test_entity : entity work.test_entity
    port map(core_clock, test_interface);
------------------------------------------------------------------------
    combine_buses : process(core_clock)
    begin
        if rising_edge(core_clock) then
            init_bus(bus_out);
            init_tx(test_interface);
            if write_to_address_is_requested(bus_from_communications, tubepsu_addresses_pkg.vhdl2019_interface_test_address) then
                write_data(test_interface, get_data(bus_from_communications));
            end if;
            if bus_feedback_is_ready(test_interface) then
                data_from_test_interface <= get_data_from_entity(test_interface);
            end if;

            connect_read_only_data_to_address(bus_from_communications, bus_out, tubepsu_addresses_pkg.vhdl2019_interface_test_address, data_from_test_interface);

            bus_to_communications <= bus_from_hil_simulation      and
                                     bus_from_main_system_control and
                                     bus_out;

        end if; --rising_edge
    end process combine_buses;	
------------------------------------------------------------------------
    u_communications : entity work.fpga_communications
    generic map(fpga_interconnect_pkg => work.fpga_interconnect_pkg)
        port map(
            clock   => core_clock ,
            uart_rx => uart_rx    ,
            uart_tx => uart_tx    ,
            bus_to_communications   => bus_to_communications ,
            bus_from_communications => bus_from_communications
        );
------------------------------------------------------------------------
    u_main_system_control : entity work.main_system_control
    port map (
        core_clock                    => core_clock,
        bus_to_main_system_control    => bus_from_communications      ,
        bus_from_main_system_control  => bus_from_main_system_control ,
        main_system_control_interface => main_system_control_interface);
------------------------------------------------------------------------
    u_hil_simulation : entity work.hil_simulation
    port map(
        core_clock              => core_clock,
        bus_to_hil_simulation   => bus_from_communications,
        bus_from_hil_simulation => bus_from_hil_simulation,
        rtl_inductor_current    => main_system_control_interface.boost_control_interface.inductor_current    ,
        rtl_input_voltage       => main_system_control_interface.boost_control_interface.input_voltage       ,
        rtl_dc_link_voltage     => main_system_control_interface.boost_control_interface.dc_link_voltage     ,
        boost_control_ready     => main_system_control_interface.boost_control_interface.boost_control_ready ,
        duty_ratio              => main_system_control_interface.boost_control_interface.duty_ratio
    );
------------------------------------------------------------------------
end rtl;
