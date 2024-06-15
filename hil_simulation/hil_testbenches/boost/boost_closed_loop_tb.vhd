LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;
    use std.textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.fpga_interconnect_pkg.all;
    use work.real_to_fixed_pkg.all;
    use work.write_pkg.all;
    use work.boost_model_pkg.all;
    use work.multiplier_pkg.all;
    use work.division_pkg.all;

entity boost_closed_loop_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of boost_closed_loop_tb is

    constant clock_period     : time    := 1 ns;
    constant stoptime         : real    := 60.0e-3;
    signal simulation_counter : natural := 0;
    
    signal simulator_clock     : std_logic := '0';
    -----------------------------------
    -- simulation specific signals ----
    ------------------------------------------------------------------------

    signal realtime   : real := 0.0;

    signal bus_from_stimulus    : fpga_interconnect_record := init_fpga_interconnect;
    signal bus_from_boost_model : fpga_interconnect_record := init_fpga_interconnect;

    signal processor_ready : boolean := false;

    signal duty_0_to_1            : natural range 0 to 2**16-1 := integer(0.5 * 2.0**15);
    signal input_voltage_0_to_512 : natural range 0 to 2**16-1 := integer(100.0 * 2.0**7);

    signal rtl_current : integer range -2**15 to 2**15-1 := 0;
    signal rtl_voltage : integer range -2**15 to 2**15-1 := 0;
    signal ref_current : real := 0.0;
    signal ref_voltage : real := 0.0;

    constant cl_parameters : boost_model_parameters_record := (
        inductance  => 500.0e-6 ,
        capacitance => 320.0e-6 ,
        rl          => 240.0e-3 ,
        timestep    => 4.0e-6);

    signal calculation_interval : real := 1.0/30.0e3;
    signal interrupt_time : real := calculation_interval;

    constant dutymax : integer := integer(0.92 * 2**15);
    constant dutymin  : integer := integer(0.08 * 2**15);

    signal pi_high_limit : integer := 0;
    signal pi_low_limit : integer := 0;


    signal ikp        : int := integer(1.0 * 2.0**7);
    signal iki        : int := 0*integer(8.0 * 2.0**7);
    signal iref       : int := integer(7.0*2.0**11);
    signal check_duty : real := 0.0;

    type current_control_record is record
        data       : std_logic;
        i_error    : int;
        pi_result  : int;
        pi_out     : int;
        duty       : int;
        integrator : integer;
        counter1   : natural range 0 to 15;
        counter2   : natural range 0 to 15;
    end record;

    constant init_current_control : current_control_record := ('0', 0,0,0,0,0,  15, 15);

    signal current_control : current_control_record := init_current_control;

    signal multiplier         : multiplier_record := init_multiplier;
    signal divider            : division_record   := init_division;
    signal divider_multiplier : multiplier_record := init_multiplier;

------------------------------------------------------------------------
begin

------------------------------------------------------------------------
    simtime : process
    begin
        test_runner_setup(runner, runner_cfg);
        wait until realtime > stoptime;
        test_runner_cleanup(runner); -- Simulation ends here
        wait;
    end process simtime;	

    simulator_clock <= not simulator_clock after clock_period/2.0;
------------------------------------------------------------------------

    stimulus : process(simulator_clock)

        constant load_10A     : std_logic_vector(15 downto 0) := to_fixed(number => 10.0  , bit_width => 16 , number_of_fractional_bits => 11);
        constant voltage_120V : std_logic_vector(15 downto 0) := to_fixed(number => 120.0 , bit_width => 16 , number_of_fractional_bits => 15-7);
        file file_handler     : text open write_mode is "boost_current_closed_loop.dat";

        variable ref_input_voltage : real := 100.0;
        variable ref_load_current  : real := 0.0;
        variable ref_duty          : real := 0.5;

        constant initial_voltage : real := 100.0;

        variable inductor_current : real := 0.0;
        variable dc_link_voltage  : real := initial_voltage;
        variable boost_model      : boost_model_record := (0.0, initial_voltage);
    -----------------------------------------------
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
            if self.counter1 < 4 then
                self.counter1 <= self.counter1 + 1;
            end if;
            CASE self.counter1 is
                WHEN 0 => multiply(multiplier , self.i_error , ikp);
                WHEN 1 => multiply(multiplier , udc     , duty_max);
                WHEN 2 => multiply(multiplier , udc     , duty_min);
                WHEN 3 => multiply(multiplier , self.i_error , iki);
                
                WHEN others => -- do nothing
            end CASE;

            if multiplier_is_ready(multiplier) then
                self.counter2 <= self.counter2 + 1;
                if self.counter2 = 0 then
                    self.pi_result <= get_int_multiplier_result(multiplier, 7,11, target_radix => 7);
                end if;
            end if;
                
            CASE self.counter2 is
                WHEN 1 => pi_low_limit  <= uin - get_int_multiplier_result(multiplier,7,15, target_radix => 7);
                WHEN 2 => pi_high_limit <= uin - get_int_multiplier_result(multiplier,7,15, target_radix => 7);
                WHEN 3 => 
                    self.integrator <= self.integrator + get_multiplier_result(multiplier, radix => 7);
                    self.pi_out <= self.pi_result;
                    if self.pi_result < pi_low_limit then
                        self.pi_out <= pi_low_limit;
                        self.integrator <= self.integrator;
                    end if;
                    if self.pi_result > pi_high_limit then
                        self.pi_out <= pi_high_limit;
                        self.integrator <= self.integrator;
                    end if;
                WHEN 4 =>
                    if division_is_ready(divider_multiplier, divider) then
                        multiply(multiplier, uin-self.pi_out, get_division_result(divider_multiplier, divider, radix => 20));
                        self.counter2 <= self.counter2 + 1;
                    end if;
                WHEN 5 =>
                    if multiplier_is_ready(multiplier) then
                        self.duty <=  to_integer(get_multiplier_result(multiplier, 7, 20, target_radix => 15));
                        self.counter2 <= self.counter2 + 1;
                    end if;
                WHEN others =>
            end CASE;
            
        end create_current_control;

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

                request_division(divider , 2**7 , integer(boost_model.dc_link_voltage*2.0**7)) ;
                
                
                current_control.i_error <= i_ref - inductor_current;
            
        end request_current_control;

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr", "vref", "iref"));
                boost_model := calculate_boost(self => boost_model, parameters => init_parameters, duty => ref_duty, load_current => ref_load_current, input_voltage => ref_input_voltage);
            end if;

            init_bus(bus_from_stimulus);
            if realtime > 2.0e-3 then
                write_data_to_address(bus_from_stimulus, 3, integer(ref_duty*2.0**15));
            end if;

            if realtime > 4.0e-3 then
                ref_input_voltage := 120.0;
                write_data_to_address(bus_from_stimulus, 2, integer(ref_input_voltage*2.0**7));
                input_voltage_0_to_512 <= integer(120*2.0**7);
            end if;

            if realtime > 6.0e-3 then
                ref_load_current := -4.0;
                write_data_to_address(bus_from_stimulus, 1, to_fixed(number => abs(ref_load_current), bit_width => 16, number_of_fractional_bits => 11));
            end if;

            ---------------------
            
            create_divider_and_multiplier(divider,divider_multiplier);
            create_multiplier(multiplier);
            create_current_control(current_control,multiplier, divider, divider_multiplier,
                                    integer(boost_model.dc_link_voltage*2.0**7),
                                    integer(ref_input_voltage*2.0**7),
                                    dutymax,
                                    dutymin);

            if realtime >= interrupt_time then
                interrupt_time <= realtime + calculation_interval;
                request_current_control(current_control, iref, integer(boost_model.inductor_current*2.0**11));
            end if;


            CASE current_control.counter2 is
                WHEN 5 =>
                    if multiplier_is_ready(multiplier) then
                        ref_duty := to_real(to_integer(get_multiplier_result(multiplier, 7, 20, target_radix => 15)), number_of_fractional_bits => 15);
                    end if;
                WHEN others =>
                    boost_model := calculate_boost(self => boost_model, parameters => init_parameters, duty => ref_duty, load_current => ref_load_current, input_voltage => ref_input_voltage);
                    write_to(file_handler,(realtime, to_real(rtl_voltage, number_of_fractional_bits => 6), to_real(rtl_current, number_of_fractional_bits => 7), boost_model.dc_link_voltage, boost_model.inductor_current));
                    realtime <= realtime + work.boost_model_pkg.timestep;
            end CASE;


        end if; --rising_edge
    end process stimulus;	
------------------------------------------------------------------------

    /* u_boost_model : entity work.boost_model */
    /* port map( */
    /*     clock => simulator_clock , */

    /*     bus_to_boost_model     => bus_from_stimulus    , */
    /*     bus_from_boost_model   => bus_from_boost_model , */

    /*     rtl_current => rtl_current , */
    /*     rtl_voltage => rtl_voltage , */

    /*     program_ready        => processor_ready); */
------------------------------------------------------------------------
end vunit_simulation;
