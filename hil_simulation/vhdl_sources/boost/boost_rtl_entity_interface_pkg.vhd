LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 

    use work.fpga_interconnect_pkg.all;

package boost_rtl_entity_interface_pkg is

    type list_of_model_outputs is (inductor_current, dc_link_voltage, input_voltage);

    type input_record is record
        processor_requested_when_1 : std_logic;
        write_input_voltage_when_1 : std_logic;
        boost_input_voltage        : std_logic_vector(15 downto 0);
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

    procedure set_input_voltage (
        signal self : view boost_model_interface_cview;
        input_voltage : in natural range 0 to 2**16-1);

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

end package boost_rtl_entity_interface_pkg;

package body boost_rtl_entity_interface_pkg is

    procedure create_boost_model_interface
    (
        signal self : view boost_model_interface_cview
    ) is
    begin
        self.input.processor_requested_when_1 <= '0';
        self.input.write_input_voltage_when_1 <= '0';
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

    procedure set_input_voltage
    (
        signal self : view boost_model_interface_cview;
        input_voltage : in natural range 0 to 2**16-1
    ) is
    begin
        self.input.write_input_voltage_when_1 <= '1';
        self.input.boost_input_voltage <= std_logic_vector(to_unsigned(input_voltage,16));
    end set_input_voltage;

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

end package body boost_rtl_entity_interface_pkg;
