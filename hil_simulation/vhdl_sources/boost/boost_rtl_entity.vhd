LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 

    use work.fpga_interconnect_pkg.all;

package boost_model_interface_pkg is

    type list_of_model_outputs is (inductor_current, dc_link_voltage, input_voltage);

    type input_record is record
        processor_requested_when_1 : std_logic;
        write_duty_when_1          : std_logic;
        dutyin                     : std_logic_vector(15 downto 0);
    end record;

    type output_record is record
        rtl_current          : std_logic_vector(15 downto 0);
        rtl_voltage          : std_logic_vector(15 downto 0);
        rtl_input_voltage    : std_logic_vector(15 downto 0);
        program_ready_when_1 : std_logic;
    end record;

    type boost_model_interface_record is record
        input : input_record;
        output : output_record;
    end record;

    /* constant init_boost_model_interface : boost_model_interface_record := (('0', '0', (14 => '1', others => '0')),((others => '0'), (others => '0'), '0', (others => '0'))); */

    view boost_model_interface_view of boost_model_interface_record is
        input : in;
        output : out;
    end view boost_model_interface_view;

    alias boost_model_interface_cview is boost_model_interface_view'converse;

    procedure create_boost_model_interface (
        signal self : view boost_model_interface_cview);

    procedure request_boost_calculation (
        signal self : view boost_model_interface_cview);

    procedure set_duty (
        signal self : view boost_model_interface_cview;
        duty : in natural range 0 to 2**16-1);

    impure function get_current ( signal self : boost_model_interface_record)
        return integer;

    impure function get_voltage ( signal self : boost_model_interface_record)
        return integer;

    impure function boost_model_is_ready ( signal self : boost_model_interface_record)
        return boolean;

    impure function get_measurement (
        signal self : boost_model_interface_record;
        measurement : list_of_model_outputs)
    return integer;

end package boost_model_interface_pkg;

package body boost_model_interface_pkg is

    procedure create_boost_model_interface
    (
        signal self : view boost_model_interface_cview
    ) is
    begin
        self.input.processor_requested_when_1 <= '0';
        self.input.write_duty_when_1 <= '0';
        
    end create_boost_model_interface;

    procedure request_boost_calculation
    (
        signal self : view boost_model_interface_cview
    ) is
    begin
        self.input.processor_requested_when_1 <= '1';
    end request_boost_calculation;

    procedure set_duty
    (
        signal self : view boost_model_interface_cview;
        duty : in natural range 0 to 2**16-1
    ) is
    begin
        self.input.write_duty_when_1 <= '1';
        self.input.dutyin     <= std_logic_vector(to_unsigned(duty,16));
    end set_duty;

    impure function get_current
    (
        signal self : boost_model_interface_record
    )
    return integer
    is
    begin
        return to_integer(signed(self.output.rtl_current));
    end get_current;

    impure function get_voltage
    (
        signal self : boost_model_interface_record
    )
    return integer
    is
    begin
        return to_integer(signed(self.output.rtl_voltage));
    end get_voltage;

    impure function boost_model_is_ready
    (
        signal self : boost_model_interface_record
    )
    return boolean
    is
    begin
        return self.output.program_ready_when_1 = '1';
    end boost_model_is_ready;

    impure function get_measurement
    (
        signal self : boost_model_interface_record;
        measurement : list_of_model_outputs
    )
    return integer
    is
        variable retval : std_logic_vector(self.output.rtl_current'range);
    begin
        case measurement is
            WHEN inductor_current =>
                retval := self.output.rtl_current;
            WHEN dc_link_voltage =>
                retval := self.output.rtl_voltage;
            WHEN input_voltage =>
                retval := self.output.rtl_input_voltage;
        end CASE;
                
        return to_integer(signed(retval));
        
    end get_measurement;

end package body boost_model_interface_pkg;

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
    use work.float_arithmetic_operations_pkg.all;

    use work.memory_processing_pkg.all;
    use work.float_assembler_pkg.all;
    use work.microinstruction_pkg.all;

    use work.boost_model_pkg.all;

    use work.fpga_interconnect_pkg.all;
    use work.boost_model_interface_pkg.all;

    use work.float_to_integer_converter_pkg.all;
    use work.float_multiplier_pkg.all;

entity boost_model is
    generic(boost_model_parameters : boost_model_parameters_record;
            initial_voltage        : real    := 100.0 ;
            load_current_address   : natural := 1     ;
            input_voltage_address  : natural := 2     ;
            boost_current_address  : natural := 4     ;
            boost_voltage_address  : natural := 5
           );
    port (
        clock : in std_logic;
        bus_to_boost_model    : in fpga_interconnect_record;
        bus_from_boost_model  : out fpga_interconnect_record;
        boost_in : in input_record;
        boost_out : out output_record
        /* boost_model_interface : view boost_model_interface_view */
    );
end entity boost_model;


architecture rtl of boost_model is

------------------------------------------------------------------------
    constant ram_contents : ram_array := build_boost_model(boost_model_parameters, (initial_voltage,initial_voltage, 0.5));
------------------------------------------------------------------------
    /* alias boost_in is boost_model_interface.input; */
    /* alias boost_out is boost_model_interface.output; */

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

begin
    boost_out.program_ready_when_1 <= ready_pipeline(ready_pipeline'left);
    boost_out.rtl_current          <= std_logic_vector(to_signed(measured_current,16));
    boost_out.rtl_voltage          <= std_logic_vector(to_signed(measured_voltage,16));
    boost_out.rtl_input_voltage    <= std_logic_vector(to_signed(voltage_from_bus,16));

    stimulus : process(clock)
        variable used_instruction : t_instruction;
    begin
        if rising_edge(clock) then

            init_bus(bus_from_boost_model);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , load_current_address , load_current_from_bus);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , input_voltage_address , voltage_from_bus);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , boost_current_address , measured_current);
            connect_data_to_address(bus_to_boost_model , bus_from_boost_model , boost_voltage_address , measured_voltage);

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

            CASE decode(used_instruction) is
                WHEN neg_mpy | a_more_than_b_and_c_positive =>
                    request_data_from_ram(ram_read_data_in   , get_arg1(used_instruction));
                    request_data_from_ram(ram_read_2_data_in , get_arg2(used_instruction));
                    request_data_from_ram(ram_read_3_data_in , get_arg3(used_instruction));
                
                WHEN others => --do nothing
            end CASE; --decode(used_instruction)

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

            used_instruction := self.instruction_pipeline(2);
            CASE decode(used_instruction) is
                WHEN neg_mpy =>
                    madd(float_alu                                  ,
                        -to_float(get_ram_data(ram_read_data_out))  ,
                        to_float(get_ram_data(ram_read_2_data_out)) ,
                        to_float(0.0));
                WHEN a_more_than_b_and_c_positive =>

                    if to_float(get_ram_data(ram_read_data_out)) > to_float(get_ram_data(ram_read_2_data_out))
                        or to_float(get_ram_data(ram_read_3_data_out)) > to_float(0.0) then

                        self.instruction_pipeline(3)(0) <= '1';
                    else
                        self.instruction_pipeline(3)(0) <= '0';
                    end if;
                
                WHEN others => --do nothing
            end CASE; --decode(used_instruction)

            used_instruction := self.instruction_pipeline(3 + alu_timing.madd_pipeline_depth-1);
            CASE decode(used_instruction) is
                WHEN neg_mpy =>
                    write_data_to_ram(ram_write_port, get_dest(used_instruction), to_std_logic_vector(get_add_result(float_alu)));
                WHEN others => -- do nothing
            end CASE;

            used_instruction := self.instruction_pipeline(3 + alu_timing.madd_pipeline_depth-2);
            CASE decode(used_instruction) is
                WHEN a_more_than_b_and_c_positive =>
                    if used_instruction(0) = '1' then
                        write_data_to_ram(ram_write_port, get_dest(used_instruction), to_std_logic_vector(get_add_result(float_alu)));
                    end if;
                WHEN others => -- do nothing
            end CASE;

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
                    convert_integer_to_float(float_to_integer_converter, to_integer(signed(boost_in.dutyin)), 15);
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
                    
            if boost_in.processor_requested_when_1 = '1' then
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
