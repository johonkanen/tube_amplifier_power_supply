-- 
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
------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.boost_control_interface_pkg.all;

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_rtl_entity_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;
    use work.half_bridge_current_control_pkg.all;
    use work.voltage_control_pkg.all;

package boost_control_pkg is

    type boost_control_record is record
        current_control    : current_control_record          ;
        voltage_control    : voltage_control_record          ;
        vkp                : integer                         ;
        vki                : integer                         ;
        control_counter    : natural range 0 to 2**15-1      ;
        reference_voltage  : integer range -2**15 to 2**15-1 ;
        multiplier         : multiplier_record               ;
        voltage_multiplier : multiplier_record               ;
        divider            : division_record                 ;
        divider_multiplier : multiplier_record               ;
    end record;

    constant init_boost_control_record : boost_control_record := (
        current_control    => init_current_control(16.0 , 8.0/4 , number_of_fractional_bits => 7) ,
        voltage_control    => init_voltage_control      ,
        vkp                => to_fixed(0.25             , 15)   ,
        vki                => to_fixed(0.016125         , 15)   ,
        control_counter    => 0                         ,
        reference_voltage  => to_fixed(205.0            , 7)    ,
        multiplier         => init_multiplier           ,
        voltage_multiplier => init_multiplier           ,
        divider            => init_division             ,
        divider_multiplier => init_multiplier);

    procedure create_boost_control (
        signal self : inout boost_control_record;
        signal boost_control_interface : view boost_control_interface_view);

end package boost_control_pkg;

package body boost_control_pkg is

        procedure create_boost_control
        (
            signal self : inout boost_control_record;
            signal boost_control_interface : view boost_control_interface_view

        ) is
            alias inductor_current      is boost_control_interface.inductor_current    ;
            alias input_voltage         is boost_control_interface.input_voltage       ;
            alias dc_link_voltage       is boost_control_interface.dc_link_voltage     ;
            alias boost_control_ready   is boost_control_interface.boost_control_ready ;
            alias duty_ratio            is boost_control_interface.duty_ratio          ;

            constant vkp     : integer := to_fixed(0.5     , 15);
            constant vki     : integer := to_fixed(0.016125/4.0 , 15);
            constant dutymax : integer := to_fixed(0.90, number_of_fractional_bits => 15);
            constant dutymin : integer := to_fixed(0.10, number_of_fractional_bits => 15);

        begin
            create_multiplier(self.voltage_multiplier);
            create_voltage_control(self.voltage_control, self.voltage_multiplier,
            proportional_gain => vkp,
            integral_gain     => vki);

            create_divider_and_multiplier(self.divider,self.divider_multiplier);
            create_multiplier(self.multiplier);

            create_current_control(self.current_control  , self.multiplier , self.divider , self.divider_multiplier ,
                                    dc_link_voltage ,
                                    input_voltage   ,
                                    dutymax         ,
                                    dutymin);
            
        end create_boost_control;

end package body boost_control_pkg;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.boost_control_interface_pkg.all;

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_rtl_entity_interface_pkg.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;
    use work.half_bridge_current_control_pkg.all;
    use work.voltage_control_pkg.all;
    use work.tubepsu_addresses_pkg;

    use work.boost_control_pkg.all;

entity boost_control is
    port (
        core_clock            : in std_logic;
        boost_control_bus_in  : in fpga_interconnect_record;
        boost_control_bus_out : out fpga_interconnect_record;

        boost_control_interface : view boost_control_interface_view
    );
end entity boost_control;


architecture rtl of boost_control is
            alias inductor_current      is boost_control_interface.inductor_current    ;
            alias input_voltage         is boost_control_interface.input_voltage       ;
            alias dc_link_voltage       is boost_control_interface.dc_link_voltage     ;
            alias boost_control_ready   is boost_control_interface.boost_control_ready ;
            alias duty_ratio            is boost_control_interface.duty_ratio          ;

    signal vkp : integer := to_fixed(0.25     , 15);
    signal vki : integer := to_fixed(0.016125 , 15);

    signal control_counter       : natural range 0 to 2**15-1      := 0;
    signal reference_voltage     : integer range -2**15 to 2**15-1 := to_fixed(205.0,7);
    
    signal self : boost_control_record := init_boost_control_record;

begin
    duty_ratio          <= get_int_multiplier_result(self.multiplier, 7, 20, target_radix => 15);
    boost_control_ready <= current_control_is_ready(self.current_control);

    control_procedure : process(core_clock)

    begin
        if rising_edge(core_clock) then
            init_bus(boost_control_bus_out);
            connect_data_to_address(boost_control_bus_in, boost_control_bus_out, tubepsu_addresses_pkg.reference_voltage_address, reference_voltage);

            create_boost_control(self);


            if control_counter < 128e6/120e3 then
                control_counter <= control_counter + 1;
            else
                control_counter <= 0;
                request_current_control(self.current_control, self.voltage_control.current_ref, inductor_current*2**4);
                request_voltage_control(self.voltage_control, reference_voltage , dc_link_voltage*2);
            end if;

        end if; --rising_edge
    end process control_procedure;	

end rtl;
