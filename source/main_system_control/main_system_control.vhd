library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.boost_control_interface_pkg.all;

package main_system_control_pkg is

    type main_system_control_record is record
        boost_control_interface : boost_control_interface_record;
    end record;

    view main_system_control_view of main_system_control_record is
        boost_control_interface : view boost_control_interface_view;
    end view main_system_control_view;

end package main_system_control_pkg;

------------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.tubepsu_addresses_pkg;

    use work.boost_model_interface_pkg.all;
    use work.fpga_interconnect_pkg.all;
    use work.main_system_control_pkg.all;
    use work.main_state_machine_pkg.all;
    use work.component_interconnect_pkg.all;

    use work.delay_timer_pkg.all;

entity main_system_control is
    port (
        core_clock : in std_logic;
        bus_to_main_system_control    : in fpga_interconnect_record;
        bus_from_main_system_control  : out fpga_interconnect_record;
        main_system_control_interface : view main_system_control_view
    );
end entity main_system_control;

architecture rtl of main_system_control is
    package dingelidong_pkg is new work.test_generic_pkg generic map(g_countertype => natural range 0 to 2**15-1, g_initval => 0);

    signal main_state_machine : main_state_machine_record := init_main_state_machine;
    signal component_interconnect_data_in : component_interconnect_data_input_group;
    signal dc_link_voltage : integer := 500;
    signal delay_timer_1ms_data_in  : delay_timer_data_input_group;
    signal delay_timer_1ms_data_out : delay_timer_data_output_group;

    signal bus_from_main : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_control : fpga_interconnect_record := init_fpga_interconnect;

begin

    bus_from_main_system_control <= bus_from_main and bus_from_boost_control;

------------------------------------------------------------------------
    u_delay_timer : entity work.delay_timer
    generic map (count_up_to => integer(10.0e-3*128.0e6))
    port map(core_clock,
    	  delay_timer_1ms_data_in,
    	  delay_timer_1ms_data_out);
------------------------------------------------------------------------

    main : process(core_clock)
    begin
        if rising_edge(core_clock) then
            init_bus(bus_from_main);
            connect_data_to_address(bus_to_main_system_control , bus_from_main , tubepsu_addresses_pkg.system_control_dc_link_address , dc_link_voltage);
            connect_read_only_data_to_address(bus_to_main_system_control , bus_from_main , tubepsu_addresses_pkg.system_control_test_address , t_system_states'pos(main_state_machine.st_main_states));

            create_system_control(
                main_state_machine             ,
                '1'                            ,
                component_interconnect_data_in ,
                delay_timer_1ms_data_in        ,
                delay_timer_1ms_data_out       ,
                dc_link_voltage);

            if write_to_address_is_requested(bus_to_main_system_control, tubepsu_addresses_pkg.system_control_test_address) then
                main_state_machine.st_main_states <= t_system_states'val(get_data(bus_to_main_system_control));
            end if;

        end if; --rising_edge
    end process main;	

    u_boost_control : entity work.boost_control
    generic map(dingelidong_pkg)
    port map (
        core_clock => core_clock,
        boost_control_bus_in    => bus_to_main_system_control ,
        boost_control_bus_out   => bus_from_boost_control     ,
        boost_control_interface => main_system_control_interface.boost_control_interface
    );

    /*
    u_dhb_control : entity work.dhb_control
    port map (
        core_clock => core_clock,

        boost_control_bus_in   => bus_to_main_system_control ,
        boost_control_bus_out  => bus_from_main_system_control   ,
        boost_control_interface => main_system_control_interface.boost_control_interface
    );
    */

    /*
    u_LLC_control : entity work.llc_control
    port map (
        core_clock => core_clock,

        boost_control_bus_in   => bus_to_main_system_control ,
        boost_control_bus_out  => bus_from_main_system_control   ,
        boost_control_interface => main_system_control_interface.boost_control_interface
    );
    */

end rtl;
