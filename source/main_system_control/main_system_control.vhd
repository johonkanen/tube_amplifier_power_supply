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

    use work.boost_model_interface_pkg.all;
    use work.fpga_interconnect_pkg.all;
    use work.main_system_control_pkg.all;
    use work.main_state_machine_pkg.all;

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

    signal main_state_machine : main_state_machine_record := init_main_state_machine;

begin

    main : process(core_clock)
    begin
        if rising_edge(core_clock) then
            /* create_system_control(main_state_machine, '1' */
        end if; --rising_edge
    end process main;	

    u_boost_control : entity work.boost_control
    port map (
        core_clock => core_clock,

        boost_control_bus_in    => bus_to_main_system_control   ,
        boost_control_bus_out   => bus_from_main_system_control ,
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
