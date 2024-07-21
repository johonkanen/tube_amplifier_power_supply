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

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_model_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;
    use work.half_bridge_current_control_pkg.all;
    use work.voltage_control_pkg.all;
    use work.tubepsu_addresses_pkg;

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

    alias inductor_current      is boost_control_interface.inductor_current    ;
    alias input_voltage         is boost_control_interface.input_voltage       ;
    alias dc_link_voltage       is boost_control_interface.dc_link_voltage     ;
    alias boost_control_ready   is boost_control_interface.boost_control_ready ;
    alias duty_ratio            is boost_control_interface.duty_ratio          ;

    signal current_control : current_control_record := init_current_control(16.0, 8.0/4, number_of_fractional_bits => 7);
    signal self : voltage_control_record := init_voltage_control;
    signal vkp : integer := to_fixed(0.25     , 15);
    signal vki : integer := to_fixed(0.016125 , 15);

    signal control_counter       : countertype := init_countertype;
    signal reference_voltage     : integer range -2**15 to 2**15-1 := to_fixed(205.0,7);
    
    signal multiplier         : multiplier_record := init_multiplier;
    signal voltage_multiplier : multiplier_record := init_multiplier;
    signal divider            : division_record   := init_division;
    signal divider_multiplier : multiplier_record := init_multiplier;

begin
    duty_ratio          <= get_int_multiplier_result(multiplier, 7, 20, target_radix => 15);
    boost_control_ready <= current_control_is_ready(current_control);

    control_procedure : process(core_clock)
        constant dutymax : integer := to_fixed(0.90, number_of_fractional_bits => 15);
        constant dutymin : integer := to_fixed(0.10, number_of_fractional_bits => 15);
        constant vkp     : integer := to_fixed(0.5     , 15);
        constant vki     : integer := to_fixed(0.016125/4.0 , 15);
    begin
        if rising_edge(core_clock) then
            init_bus(boost_control_bus_out);
            connect_data_to_address(boost_control_bus_in, boost_control_bus_out, tubepsu_addresses_pkg.reference_voltage_address, reference_voltage);

            create_multiplier(voltage_multiplier);
            create_voltage_control(self, voltage_multiplier,
            proportional_gain => vkp,
            integral_gain     => vki);

            create_divider_and_multiplier(divider,divider_multiplier);
            create_multiplier(multiplier);
            create_current_control(current_control  , multiplier , divider , divider_multiplier ,
                                    dc_link_voltage ,
                                    input_voltage   ,
                                    dutymax         ,
                                    dutymin);

            if control_counter < 128e6/120e3 then
                control_counter <= control_counter + 1;
            else
                control_counter <= init_countertype;
                request_current_control(current_control, self.current_ref, inductor_current*2**4);
                request_voltage_control(self, reference_voltage , dc_link_voltage*2);
            end if;

        end if; --rising_edge
    end process control_procedure;	

end rtl;
