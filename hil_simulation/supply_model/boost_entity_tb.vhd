LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;
    use std.textio.all;

    use work.write_pkg.all;

    use work.multi_port_ram_pkg.all;

    use work.microinstruction_pkg.all;
    use work.simple_processor_pkg.all;
    use work.processor_configuration_pkg.all;
    use work.float_alu_pkg.all;
    use work.float_type_definitions_pkg.all;
    use work.float_to_real_conversions_pkg.all;

    use work.memory_processing_pkg.all;
    use work.float_assembler_pkg.all;
    use work.microinstruction_pkg.all;

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;

entity boost_model is
    port (
        simulator_clock      : in std_logic	;
        bus_to_boost_model   : in fpga_interconnect_record;
        bus_from_boost_model : out fpga_interconnect_record;
        rtl_current          : out real;
        rtl_voltage          : out real;
        ref_current          : out real;
        ref_voltage          : out real;

        program_ready        : out boolean;
        real_time            : out real
    );
end entity boost_model;


architecture rtl of boost_model is
    signal simulation_counter  : natural   := 0;
    signal realtime   : real := 0.0;

    constant initial_voltage : real := 100.0;

------------------------------------------------------------------------
    constant ram_contents : ram_array := build_boost_model(rl, l, c, (initial_voltage,initial_voltage, 0.5));
------------------------------------------------------------------------

    signal self                     : simple_processor_record := init_processor;
    signal ram_read_instruction_in  : ram_read_in_record  := (0, '0');
    signal ram_read_instruction_out : ram_read_out_record ;
    signal ram_read_data_in         : ram_read_in_record  := (0, '0');
    signal ram_read_data_out        : ram_read_out_record ;
    signal ram_read_2_data_in       : ram_read_in_record  := (0, '0');
    signal ram_read_2_data_out      : ram_read_out_record ;
    signal ram_read_3_data_in       : ram_read_in_record  := (0, '0');
    signal ram_read_3_data_out      : ram_read_out_record ;
    signal ram_write_port           : ram_write_in_record ;

    signal processor_is_ready : boolean := false;

    signal counter  : natural range 0 to 7 := 7;
    signal counter2 : natural range 0 to 7 := 7;

    signal result2 : real := 0.0;
    signal result3 : real := 0.0;

    signal float_alu : float_alu_record := init_float_alu;


    signal testi1 : real := 0.0;
    signal testi2 : real := 0.0;

    signal ready_pipeline : std_logic_vector(2 downto 0) := (others => '0');

    signal sequence_counter      : natural := 0;
    signal load_current_from_bus : natural range 0 to 2**16-1 := 0;
    signal voltage_from_bus      : natural range 0 to 2**16-1 := integer(100*2.0**7);
    signal duty_0_to_1           : natural range 0 to 2**16-1 := integer(0.5*2.0**15);


begin
    real_time <= realtime;


    rtl_current <= result2;
    rtl_voltage <= result3;
    ref_current <= 0.0;
    ref_voltage <= 0.0;


    stimulus : process(simulator_clock)

        variable boost_model : boost_model_record := (0.0, initial_voltage);

        variable ref_input_voltage : real := 100.0;
        variable ref_load_current  : real := 0.0;
        variable ref_duty          : real := 0.5;

        variable used_instruction : t_instruction;
        variable inductor_current : real := 0.0;
        variable dc_link_voltage  : real := initial_voltage;
        file file_handler         : text open write_mode is "boost_entity_tb.dat";


    begin





        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;
            if simulation_counter = 0 then
                init_simfile(file_handler, ("time", "volt", "curr", "vref", "iref"));
            end if;

            init_bus(bus_from_boost_model);
            connect_data_to_address(bus_to_boost_model, bus_from_boost_model, 1 , load_current_from_bus);
            connect_data_to_address(bus_to_boost_model, bus_from_boost_model, 2 , voltage_from_bus);
            connect_data_to_address(bus_to_boost_model, bus_from_boost_model, 3 , duty_0_to_1);

            --------------------
            create_simple_processor (
                self                     ,
                ram_read_instruction_in  ,
                ram_read_instruction_out ,
                ram_read_data_in         ,
                ram_read_data_out        ,
                ram_write_port           ,
                used_instruction);

            init_ram_read(ram_read_2_data_in);
            init_ram_read(ram_read_3_data_in);
            create_float_alu(float_alu);

            create_memory_process_pipeline(
             self                     ,
             float_alu                ,
             used_instruction         ,
             ram_read_instruction_out ,
             ram_read_data_in         ,
             ram_read_data_out        ,
             ram_read_2_data_in       ,
             ram_read_2_data_out      ,
             ram_read_3_data_in       ,
             ram_read_3_data_out      ,
             ram_write_port          );

             if ram_write_port.write_requested = '1' and ram_write_port.address = udc then
                 result3 <= to_real(to_float(ram_write_port.data));
             end if;

             if ram_write_port.write_requested = '1' and ram_write_port.address = current_addr then
                 result2 <= to_real(to_float(ram_write_port.data));
             end if;

            ------------------------------------------------------------------------
            ------------------------------------------------------------------------

            if simulation_counter = 0 then
                request_processor(self, 128);
                realtime <= realtime + timestep;
                write_to(file_handler,(realtime, result3, result2, boost_model.dc_link_voltage, boost_model.inductor_current));
                boost_model := calculate_boost(self => boost_model, duty => ref_duty, load_current => ref_load_current, input_voltage => ref_input_voltage);
            end if;

            ready_pipeline <= ready_pipeline(ready_pipeline'left-1 downto 0) & '0';
            if program_is_ready(self) then
                ready_pipeline(0) <= '1';
            end if;

            if ready_pipeline(ready_pipeline'left) = '1' then
                realtime <= realtime + timestep;
                boost_model := calculate_boost(boost_model, ref_duty, ref_load_current, ref_input_voltage);
                write_to(file_handler,(realtime, result3, result2, boost_model.dc_link_voltage, boost_model.inductor_current));
                request_processor(self, 128);

                ref_duty := real(duty_0_to_1)/2.0**15;
                write_data_to_ram(ram_write_port, duty, to_std_logic_vector(to_float(ref_duty)));
                sequence_counter <= 0;

            end if;

            CASE sequence_counter is
                WHEN 0 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 1 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 2 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 3 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 4 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 5 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 6 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 7 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 8 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 9 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 10 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 11 =>
                        sequence_counter <= sequence_counter + 1;
                WHEN 12 =>
                        sequence_counter <= sequence_counter + 1;
                        ref_input_voltage := real(voltage_from_bus) / 2.0**7;
                        write_data_to_ram(ram_write_port, input_voltage_addr, to_std_logic_vector(to_float(ref_input_voltage)));
                WHEN 13 =>
                        sequence_counter <= sequence_counter + 1;
                        ref_load_current := -real(load_current_from_bus)/2.0**11;
                        write_data_to_ram(ram_write_port, iload, to_std_logic_vector(to_float(ref_load_current)));
                        sequence_counter <= sequence_counter + 1;
                WHEN others => --do nothing
            end CASE;


        end if; -- rising_edge
    end process stimulus;	

------------------------------------------------------------------------
    u_mpram : entity work.ram_read_x4_write_x1
    generic map(ram_contents)
    port map(
    simulator_clock          ,
    ram_read_instruction_in  ,
    ram_read_instruction_out ,
    ram_read_data_in         ,
    ram_read_data_out        ,
    ram_read_2_data_in       ,
    ram_read_2_data_out      ,
    ram_read_3_data_in       ,
    ram_read_3_data_out      ,
    ram_write_port);
------------------------------------------------------------------------


end rtl;
------------------------------------------------------------------------
------------------------------------------------------------------------

LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

library vunit_lib;
context vunit_lib.vunit_context;

    use work.fpga_interconnect_pkg.all;
    use work.real_to_fixed_pkg.all;

entity boost_entity_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of boost_entity_tb is

    constant clock_period      : time    := 1 ns;
    constant stoptime : real := 10.0e-3;
    
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

    signal rtl_current : real := 0.0;
    signal rtl_voltage : real := 0.0;
    signal ref_current : real := 0.0;
    signal ref_voltage : real := 0.0;

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

        constant load_10A     : std_logic_vector(15 downto 0) := to_fixed(number => 10.0, bit_width => 16, number_of_fractional_bits => 11);
        constant voltage_120V : std_logic_vector(15 downto 0) := to_fixed(number => 120.0, bit_width => 16, number_of_fractional_bits => 15-7);
    begin
        if rising_edge(simulator_clock) then
            init_bus(bus_from_stimulus);
            if realtime > 2.0e-3 then
                write_data_to_address(bus_from_stimulus, 3, integer(0.25*2.0**15));
            end if;

            if realtime > 4.0e-3 then
                write_data_to_address(bus_from_stimulus, 2, integer(120*2.0**7));
                input_voltage_0_to_512 <= integer(120*2.0**7);
            end if;

            if realtime > 6.0e-3 then
                write_data_to_address(bus_from_stimulus, 1, load_10a);
            end if;

            /* if program_is_ready */
        end if; --rising_edge
    end process stimulus;	
------------------------------------------------------------------------

    u_boost_model : entity work.boost_model
    port map(
        simulator_clock        => simulator_clock      ,
        bus_to_boost_model     => bus_from_stimulus    ,
        bus_from_boost_model   => bus_from_boost_model ,

        rtl_current => rtl_current,
        rtl_voltage => rtl_voltage,
        ref_current => ref_current,
        ref_voltage => ref_voltage,


        program_ready        => processor_ready      ,
        real_time            => realtime);
------------------------------------------------------------------------
end vunit_simulation;
