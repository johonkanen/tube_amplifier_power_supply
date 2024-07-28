LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;
    use work.voltage_control_pkg.all;
    use work.half_bridge_current_control_pkg.all;

package pfc_control_pkg is

-------------------------------------
    type pfc_control_record is record
        current_control    : current_control_record;
        multiplier         : multiplier_record;
        voltage_control    : voltage_control_record;
        voltage_multiplier : multiplier_record;
        divider            : division_record  ;
        divider_multiplier : multiplier_record;
        pfc_ref_counter : natural range 0 to 15;
        pfc_sequence : natural range 0 to 15;
        current_measurement : int;

    end record;

    constant init_pfc_control : pfc_control_record := (
        current_control     => init_current_control(16.0 , 10.0 , number_of_fractional_bits => 7) ,
        multiplier          => init_multiplier           ,
        voltage_control     => init_voltage_control      ,
        voltage_multiplier  => init_multiplier           ,
        divider             => init_division             ,
        divider_multiplier  => init_multiplier           ,
        pfc_ref_counter     => 9,
        pfc_sequence        => 9,
        current_measurement => 0);

-------------------------------------
    procedure create_pfc_control (
        signal self : inout pfc_control_record;
        udc         : in integer;
        uin         : in integer;
        duty_max    : in integer;
        duty_min    : in integer;
        vkp : in integer;
        vki : in integer);

-------------------------------------
    procedure request_pfc_control (
        signal self : inout pfc_control_record;
        current_measurement : in integer;
        voltage_measurement : in integer);

-------------------------------------
    function current_control_is_ready ( self : pfc_control_record)
        return boolean;

-------------------------------------
    function get_duty ( self : pfc_control_record)
        return integer;

end package pfc_control_pkg;

package body pfc_control_pkg is

-------------------------------------
    procedure create_pfc_control
    (
        signal self : inout pfc_control_record;
        udc         : in integer;
        uin         : in integer;
        duty_max    : in integer;
        duty_min    : in integer;
        vkp         : in integer;
        vki         : in integer
    ) is
    begin
        create_divider_and_multiplier(self.divider,self.divider_multiplier);
        create_multiplier(self.multiplier);
        create_current_control(self.current_control , self.multiplier , self.divider , self.divider_multiplier ,
                               udc                  ,
                               uin                  ,
                               duty_max             ,
                               duty_min);

        create_multiplier(self.voltage_multiplier);
        create_voltage_control(self.voltage_control, self.voltage_multiplier,
        proportional_gain => vkp,
        integral_gain     => vki);

        CASE self.pfc_sequence is
            WHEN 0 => 
                multiply(self.multiplier, uin , to_fixed(1.0/325.0,15));
                self.pfc_sequence <= self.pfc_sequence + 1;
            WHEN 1 => 
                if multiplier_is_ready(self.multiplier) then
                    multiply(self.multiplier, self.voltage_control.current_ref , get_int_multiplier_result(self.multiplier,15,7, target_radix => 15));
                    self.pfc_sequence <= self.pfc_sequence + 1;
                end if;
            WHEN 2 => 
                if multiplier_is_ready(self.multiplier) then
                    request_current_control(self.current_control, 
                            get_multiplier_result(self.multiplier, 15),
                            self.current_measurement);
                    self.pfc_sequence <= self.pfc_sequence + 1;
                end if;
            WHEN others => --do nothing
        end CASE;
        
    end create_pfc_control;

-------------------------------------
    procedure request_pfc_control
    (
        signal self : inout pfc_control_record;
        current_measurement : in integer;
        voltage_measurement : in integer
    ) is
    begin
        self.pfc_sequence <= 0;
        self.current_measurement <= current_measurement;

        if self.pfc_ref_counter < 9 then
            self.pfc_ref_counter <= self.pfc_ref_counter + 1;
        else
            self.pfc_ref_counter <= 0;
            request_voltage_control(self.voltage_control, to_fixed(400.0 , 7) , voltage_measurement);
        end if;
    end request_pfc_control;

-------------------------------------
    function current_control_is_ready
    (
        self : pfc_control_record
    )
    return boolean
    is
    begin
        return current_control_is_ready(self.current_control);
    end current_control_is_ready;

-------------------------------------
    function get_duty
    (
        self : pfc_control_record
    )
    return integer
    is
    begin
        return get_int_multiplier_result(self.multiplier, 7, 20, target_radix => 15);
    end get_duty;

-------------------------------------
end package body pfc_control_pkg;
