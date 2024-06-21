library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    use work.real_to_fixed_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;

package voltage_control_pkg is

    type voltage_control_record is record
        v_error     : integer;
        piout       : integer;
        integrator  : integer;
        current_ref : integer;
        counter1    : natural;
        counter2    : natural;
    end record;

    constant init_voltage_control : voltage_control_record := (0,0,0,0, counter1 => 15, counter2 => 15);

    procedure create_voltage_control (
        signal self : inout voltage_control_record;
        signal voltage_multiplier : inout multiplier_record;
        proportional_gain : integer;
        integral_gain : integer
    );

    procedure request_voltage_control (
        signal self   : inout voltage_control_record;
        v_ref         : integer;
        v_measurement : integer);

end package voltage_control_pkg;

package body voltage_control_pkg is

    procedure create_voltage_control
    (
        signal self : inout voltage_control_record;
        signal voltage_multiplier : inout multiplier_record;
        proportional_gain : integer;
        integral_gain : integer
    ) is
    begin
        if self.counter1 < 2 then
            self.counter1 <= self.counter1 + 1;
        end if;
        CASE self.counter1 is
            WHEN 0 => multiply(voltage_multiplier , proportional_gain , self.v_error);
            WHEN 1 => multiply(voltage_multiplier , integral_gain , self.v_error);
            WHEN others => --do nothing
        end CASE;

        if multiplier_is_ready(voltage_multiplier) then
            self.counter2 <= self.counter2 + 1;
            CASE self.counter2 is
                WHEN 0 => 
                    self.piout <= get_int_multiplier_result(voltage_multiplier,15,7,11) + self.integrator;
                WHEN 1 => 
                    self.integrator  <= get_int_multiplier_result(voltage_multiplier,15,7,11) + self.integrator;
                    self.current_ref <= self.piout;
                    if self.piout > to_fixed(7.0, 11) then
                        self.current_ref <= to_fixed(7.0, 11);
                        self.integrator  <= self.integrator;
                    end if;
                    if self.piout < to_fixed(-7.0, 11) then
                        self.current_ref <= to_fixed(-7.0, 11);
                        self.integrator  <= self.integrator;
                    end if;
                WHEN others => --do nothing
            end CASE;
        end if;
        
    end create_voltage_control;

    procedure request_voltage_control
    (
        signal self : inout voltage_control_record;
        v_ref : integer;
        v_measurement : integer
    ) is
    begin
        self.v_error <= v_ref - v_measurement;
        self.counter1 <= 0;
        self.counter2 <= 0;
    end request_voltage_control;

end package body voltage_control_pkg;
