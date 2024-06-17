library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;

package half_bridge_current_control_pkg is

---------------------------------------------
    type current_control_record is record
        ikp           : int;
        iki           : int;
        i_error       : int;
        pi_result     : int;
        pi_out        : int;
        duty          : int;
        udc           : int;
        integrator    : int;
        pi_high_limit : int;
        pi_low_limit  : int;
        counter1      : natural range 0 to 7;
        counter2      : natural range 0 to 7;
        is_ready : boolean;
    end record;

    function init_current_control (
        ikp : real;
        iki : real;
        number_of_fractional_bits : natural)
    return current_control_record;

---------------------------------------------
    procedure create_current_control ( 
        signal self               : inout current_control_record;
        signal multiplier         : inout multiplier_record;
        signal divider            : inout division_record;
        signal divider_multiplier : inout multiplier_record;
        udc                       : in integer;
        uin                       : in integer;
        duty_max                  : in integer;
        duty_min                  : in integer);
---------------------------------------------
    procedure request_current_control (
        signal self : inout current_control_record;
        i_ref            : in integer;
        inductor_current : in integer);
---------------------------------------------
    function current_control_is_ready ( self : current_control_record)
        return boolean;
---------------------------------------------

end package half_bridge_current_control_pkg;

package body half_bridge_current_control_pkg is

    function init_current_control
    (
        ikp : real;
        iki : real;
        number_of_fractional_bits : natural
    )
    return current_control_record
    is
    begin
        
     return (to_fixed(ikp, number_of_fractional_bits), to_fixed(iki, number_of_fractional_bits), 0, 0, 0,0,0,0,0,0,  7, 7, false);
    end init_current_control;

---------------------------------------------
    procedure create_current_control 
    ( 
        signal self               : inout current_control_record;
        signal multiplier         : inout multiplier_record;
        signal divider            : inout division_record;
        signal divider_multiplier : inout multiplier_record;
        udc                       : in integer;
        uin                       : in integer;
        duty_max                  : in integer;
        duty_min                  : in integer
    )
    is
    begin
        self.is_ready <= false;
        if self.counter1 < 4 then
            self.counter1 <= self.counter1 + 1;
        end if;
        CASE self.counter1 is
            WHEN 0 => multiply(multiplier , self.i_error , self.ikp);
                request_division(divider , to_fixed(1.0, number_of_fractional_bits => 7) , udc) ;
            WHEN 1 => multiply(multiplier , udc          , duty_max);
            WHEN 2 => multiply(multiplier , udc          , duty_min);
            WHEN 3 => multiply(multiplier , self.i_error , self.iki);

            WHEN others => -- do nothing
        end CASE;

        CASE self.counter2 is
            WHEN 0 =>
                if multiplier_is_ready(multiplier) then
                    self.pi_result <= get_int_multiplier_result(multiplier, 7,11, target_radix => 7) + self.integrator;
                    self.counter2 <= self.counter2 + 1;
                end if;
            WHEN 1 => self.pi_low_limit  <= uin - get_int_multiplier_result(multiplier,7,15, target_radix => 7);
                    self.counter2 <= self.counter2 + 1;
            WHEN 2 => self.pi_high_limit <= uin - get_int_multiplier_result(multiplier,7,15, target_radix => 7);
                    self.counter2 <= self.counter2 + 1;
            WHEN 3 => 
                self.counter2   <= self.counter2 + 1;
                self.integrator <= self.integrator + get_int_multiplier_result(multiplier, 7, 11, target_radix => 7);
                self.pi_out     <= self.pi_result;
                if self.pi_result < self.pi_low_limit then
                    self.pi_out     <= self.pi_low_limit;
                    self.integrator <= self.integrator;
                end if;
                if self.pi_result > self.pi_high_limit then
                    self.pi_out     <= self.pi_high_limit;
                    self.integrator <= self.integrator;
                end if;
            WHEN 4 =>
                if division_is_ready(divider_multiplier, divider) then
                    multiply(multiplier, uin-self.pi_out, get_division_result(divider_multiplier, divider, radix => 20));
                    self.counter2 <= self.counter2 + 1;
                end if;
            WHEN 5 =>
                if multiplier_is_ready(multiplier) then
                    self.duty     <= to_integer(get_multiplier_result(multiplier, 7, 20, target_radix => 15));
                    self.counter2 <= self.counter2 + 1;
                    self.is_ready <= true;
                end if;
            WHEN others =>
        end CASE;
        
    end create_current_control;

---------------------------------------------
    procedure request_current_control
    (
        signal self : inout current_control_record;
        i_ref            : in integer;
        inductor_current : in integer
    )
    is
    begin
            self.counter1 <= 0;
            self.counter2 <= 0;
            self.i_error <= i_ref - inductor_current;
        
    end request_current_control;
---------------------------------------------
    function current_control_is_ready
    (
        self : current_control_record
    )
    return boolean
    is
    begin
        return self.is_ready;
    end current_control_is_ready;
---------------------------------------------
end package body half_bridge_current_control_pkg;
