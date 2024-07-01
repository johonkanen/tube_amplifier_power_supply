LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 

    use work.fpga_interconnect_pkg.all;

package boost_model_interface_pkg is

    type boost_model_interface_record is record
        bus_to_boost_model   : fpga_interconnect_record;
        bus_from_boost_model : fpga_interconnect_record;
    end record;

    view boost_model_interface_view of boost_model_interface_record is 
        bus_to_boost_model   : in;
        bus_from_boost_model : out;
    end view boost_model_interface_view;

end package boost_model_interface_pkg;

-----------------------------
LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

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
    use work.boost_model_interface_pkg.all;

    use work.float_to_integer_converter_pkg.all;
    use work.float_multiplier_pkg.all;
    use work.float_arithmetic_operations_pkg.all;

entity boost_model is
    generic(boost_model_parameters : boost_model_parameters_record;
            initial_voltage : real := 100.0
           );
    port (
        clock           : in std_logic	;
        boost_model_bus : view boost_model_interface_view;

        processor_requested : in boolean;

        write_duty : in boolean;
        dutyin       : in natural range 0 to 2**16-1;

        rtl_current     : out integer range -2**15 to 2**15-1;
        rtl_voltage     : out integer range -2**15 to 2**15-1;

        program_ready   : out boolean
    );
end entity boost_model;


architecture rtl of boost_model is
    signal simulation_counter  : natural range 0 to 15   := 0;

------------------------------------------------------------------------
    constant ram_contents : ram_array := build_boost_model(boost_model_parameters, (initial_voltage,initial_voltage, 0.5));
------------------------------------------------------------------------
    alias bus_to_boost_model is boost_model_bus.bus_to_boost_model;
    alias bus_from_boost_model is boost_model_bus.bus_from_boost_model;

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

    signal float_alu : float_alu_record := init_float_alu;

    signal ready_pipeline : std_logic_vector(2 downto 0) := (others => '0');

    signal sequence_counter      : natural range 0 to 31      := 0;
    signal load_current_from_bus : std_logic_vector(15 downto 0);
    signal voltage_from_bus      : natural range 0 to 2**16-1 := integer(100*2.0**7);
    signal duty_0_to_1           : natural range 0 to 2**16-1 := integer(0.5*2.0**15);

    signal float_to_integer_converter : float_to_integer_converter_record := init_float_to_integer_converter;
    signal float_multiplier           : float_multiplier_record := init_float_multiplier;
    signal float_to_int_counter       : natural := 0;
    signal int_to_float_counter       : natural := 0;
    signal int_to_float_ready_counter : natural := 0;

    signal float_duty          : float_record := to_float(0.0);
    signal float_load_current  : float_record := to_float(0.0);
    signal float_input_voltage : float_record := to_float(0.0);
    signal measured_current    : integer range -2**15 to 2**15-1 := 0;
    signal measured_voltage    : integer range -2**15 to 2**15-1 := 0;

    signal state_counter : natural range 0 to 7 := 7;

begin
    program_ready <= program_is_ready(self);
    rtl_current   <= measured_current;
    rtl_voltage   <= measured_voltage;

    stimulus : process(clock)
        variable used_instruction : t_instruction;
    begin
        if rising_edge(clock) then

            init_bus(bus_from_boost_model);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , 1 , load_current_from_bus);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , 2 , voltage_from_bus);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , 3 , duty_0_to_1);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , 4 , measured_current);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , 5 , measured_voltage);
            if write_duty then
                duty_0_to_1 <= dutyin;
            end if;

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

            create_float_to_integer_converter(float_to_integer_converter);
            create_float_multiplier(float_multiplier);

            if ram_write_port.write_requested = '1' and ram_write_port.address = udc then
                convert_float_to_integer(float_to_integer_converter, to_float(ram_write_port.data), 6);
                float_to_int_counter <= 0;
            end if;

            if ram_write_port.write_requested = '1' and ram_write_port.address = current_addr then
                convert_float_to_integer(float_to_integer_converter, to_float(ram_write_port.data), 7);
            end if;

            case float_to_int_counter is
                WHEN 0 => 
                    if float_to_int_conversion_is_ready(float_to_integer_converter) then
                        measured_voltage <= get_converted_integer(float_to_integer_converter);
                        float_to_int_counter <= float_to_int_counter + 1;
                    end if;
                WHEN 1 => 
                    if float_to_int_conversion_is_ready(float_to_integer_converter) then
                        measured_current <= get_converted_integer(float_to_integer_converter);
                        float_to_int_counter <= float_to_int_counter + 1;
                    end if;
                WHEN others => 
            end case;

            ------------------------------------------------------------------------
            ------------------------------------------------------------------------

            if simulation_counter = 0 then
                request_processor(self, 128);
                simulation_counter <= simulation_counter + 1;
            end if;

            ready_pipeline <= ready_pipeline(ready_pipeline'left-1 downto 0) & '0';
            if program_is_ready(self) then
                ready_pipeline(0) <= '1';
                int_to_float_ready_counter <= 0;
                int_to_float_counter <= 1;
                convert_integer_to_float(float_to_integer_converter, voltage_from_bus, 7);
            end if;

            CASE int_to_float_counter is
                WHEN 1 =>
                    convert_integer_to_float(float_to_integer_converter, to_integer(signed(load_current_from_bus)), 11);
                    int_to_float_counter <= int_to_float_counter + 1;
                WHEN 2 =>
                    convert_integer_to_float(float_to_integer_converter, duty_0_to_1, 15);
                    int_to_float_counter <= int_to_float_counter + 1;
                WHEN others => -- do nothing
            end CASE;

            if int_to_float_conversion_is_ready(float_to_integer_converter) then
                CASE int_to_float_ready_counter is
                    WHEN 0 =>
                        float_input_voltage <= get_converted_float(float_to_integer_converter);
                        int_to_float_ready_counter <= int_to_float_ready_counter + 1;
                    WHEN 1 =>
                        float_load_current <= -get_converted_float(float_to_integer_converter);
                        int_to_float_ready_counter <= int_to_float_ready_counter + 1;
                    WHEN 2 =>
                        float_duty <= get_converted_float(float_to_integer_converter);
                        int_to_float_ready_counter <= int_to_float_ready_counter + 1;
                    WHEN others => --do nothing
                end CASE;
            end if; 
                    

            if ready_pipeline(ready_pipeline'left) = '1' then
                request_processor(self, program_start_address => 128);
                write_data_to_ram(ram_write_port, duty, to_std_logic_vector(float_duty));
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
                        write_data_to_ram(ram_write_port, input_voltage_addr, to_std_logic_vector(float_input_voltage));
                WHEN 13 =>
                        sequence_counter <= sequence_counter + 1;
                        write_data_to_ram(ram_write_port, iload, to_std_logic_vector(float_load_current));
                        sequence_counter <= sequence_counter + 1;
                WHEN others => --do nothing
            end CASE;

        end if; -- rising_edge
    end process stimulus;	

------------------------------------------------------------------------
    u_mpram : entity work.ram_read_x4_write_x1
    generic map(ram_contents)
    port map(
    clock          ,
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
