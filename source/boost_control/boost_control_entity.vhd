library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package boost_control_interface_pkg is

    type boost_control_interface_record is record
        inductor_current      : integer range -2**15 to 2**15-1;
        input_voltage         : integer range -2**15 to 2**15-1;
        dc_link_voltage       : integer range -2**15 to 2**15-1;

        boost_control_ready   : boolean;
        duty_ratio            : natural range 0 to 2**16-1;
    end record;

    view boost_control_interface_view of boost_control_interface_record is
        inductor_current      : in;
        input_voltage         : in;
        dc_link_voltage       : in;

        boost_control_ready   : out;
        duty_ratio            : out;
    end view boost_control_interface_view;

end package boost_control_interface_pkg;

------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package test_generic_pkg is
    generic(type g_countertype;
           g_initval : g_countertype;
           function "+" ( left : g_countertype; right : integer) return g_countertype is <>;
           function "<" ( left : g_countertype; right : integer) return boolean is <>);
     

    subtype countertype is g_countertype;
    constant init_countertype : countertype := g_initval;

end package test_generic_pkg;
------------------------------------------------------------


library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.boost_control_interface_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_model_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.tubepsu_addresses_pkg;
    use work.pfc_control_pkg.all;

entity boost_control is
    generic(package testi_pkg is new work.test_generic_pkg generic map(<>));
    port (
        core_clock : in std_logic;
        boost_control_bus_in    : in fpga_interconnect_record;
        boost_control_bus_out   : out fpga_interconnect_record;
        boost_control_interface : view boost_control_interface_view
    );
end entity boost_control;


architecture rtl of boost_control is
    use testi_pkg.all;

    signal control_counter       : countertype := init_countertype;
    signal reference_voltage     : integer range -2**15 to 2**15-1 := to_fixed(205.0,7);
    
    signal pfc_control : pfc_control_record := init_pfc_control;
    alias self is pfc_control;

begin

    boost_control_interface.duty_ratio          <= get_duty(pfc_control);
    boost_control_interface.boost_control_ready <= current_control_is_ready(pfc_control);

    control_procedure : process(core_clock)
        constant duty_max : integer := to_fixed(0.90, number_of_fractional_bits => 15);
        constant duty_min : integer := to_fixed(0.10, number_of_fractional_bits => 15);
        constant vkp : integer := to_fixed(0.05          , 15);
        constant vki : integer := to_fixed(0.016125/10.0 , 15);
    begin
        if rising_edge(core_clock) then
            init_bus(boost_control_bus_out);
            connect_data_to_address(boost_control_bus_in, boost_control_bus_out, tubepsu_addresses_pkg.reference_voltage_address, reference_voltage);

            create_pfc_control(pfc_control, boost_control_interface.dc_link_voltage, boost_control_interface.input_voltage, duty_max, duty_min, vkp, vki);

            if control_counter < 128e6/30e3 then
                control_counter <= control_counter + 1;
            else
                control_counter <= init_countertype;
                request_pfc_control(pfc_control, boost_control_interface.inductor_current*2**4, boost_control_interface.dc_link_voltage*2, reference_voltage);
            end if;

        end if; --rising_edge
    end process control_procedure;	

end rtl;
