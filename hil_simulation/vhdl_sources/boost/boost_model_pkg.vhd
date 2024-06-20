
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

package boost_model_pkg is
    constant inductance  :  real := 50.0e-6;
    constant capacitance :  real := 50.0e-6;
    constant rl          :  real := 0.24;
    constant timestep    :  real := 4.0e-6;

    constant boost_addr_offset :  natural := 33;


    type boost_model_record is record
        inductor_current : real;
        dc_link_voltage : real;
    end record;

    type boost_model_parameters_record is record
        inductance  : real;
        capacitance : real;
        rl          : real;
        timestep    : real;
    end record;

    constant init_parameters : boost_model_parameters_record := (
        inductance  ,
        capacitance ,
        rl          ,
        timestep    );

    function calculate_boost (
        self          : boost_model_record;
        parameters    : boost_model_parameters_record;
        duty          : real;
        load_current  : real;
        input_voltage : real
    )
    return boost_model_record;
----------------------------------------------------------------
    type initial_boost_model_values_record is record
        input_voltage   : real;
        dc_link_voltage : real;
        duty            : real;
    end record;

    function build_boost_model (inductor_res : real; inductor_gain : real; capacitor_gain : real; init_values : initial_boost_model_values_record)
    return ram_array;

    constant variables : variable_array := init_variables(21) + boost_addr_offset;

    alias input_voltage_addr is variables(0);
    alias udc                is variables(1);
    alias current_addr       is variables(2);
    alias c_addr             is variables(3);
    alias l_addr             is variables(4);
    alias r_addr             is variables(5);

    alias d_x_udc_m_uin    is variables(6);
    alias uL               is variables(7);
    alias duty             is variables(8);
    alias ic               is variables(9);
    alias iload            is variables(10);

    constant boost_program : program_array :=(
        pipelined_block(
            program_array'(
            write_instruction(neg_mpy_add , d_x_udc_m_uin , 
                duty , udc , input_voltage_addr),
            write_instruction(mpy_add , ic ,
                duty , current_addr, iload)
            )
        ) &
        pipelined_block(
            program_array'(
            write_instruction(neg_mpy_add , uL , 
                current_addr , r_addr, d_x_udc_m_uin),
            write_instruction(mpy_add , udc ,
                ic , c_addr, udc)
            )
        ) &
        pipelined_block(
            write_instruction(mpy_add , current_addr , 
                uL , l_addr, current_addr)
        ) &
        write_instruction(program_end));

end package boost_model_pkg;

package body boost_model_pkg is

    function calculate_boost
    (
        self          : boost_model_record;
        parameters    : boost_model_parameters_record;
        duty          : real;
        load_current  : real;
        input_voltage : real
    )
    return boost_model_record
    is
        variable retval : boost_model_record := self;
        constant l : real := parameters.timestep/parameters.inductance;
        constant c : real := parameters.timestep/parameters.capacitance;
    begin
        retval.inductor_current := retval.inductor_current + (input_voltage - retval.dc_link_voltage*duty - parameters.rl * retval.inductor_current)*l;
        retval.dc_link_voltage := retval.dc_link_voltage + (retval.inductor_current*duty + load_current)*c;

        return retval;
        
    end calculate_boost;

    function build_boost_model (inductor_res : real; inductor_gain : real; capacitor_gain : real; init_values : initial_boost_model_values_record)
    return ram_array
    is
        variable retval : ram_array := (others => (others => '0'));
    begin
        for i in boost_program'range loop
            retval(i + 128) := boost_program(i);
        end loop;
        retval(input_voltage_addr ) := to_std_logic_vector(to_float(init_values.input_voltage)  ) ;
        retval(udc                ) := to_std_logic_vector(to_float(init_values.dc_link_voltage)  ) ;
        retval(current_addr       ) := to_std_logic_vector(to_float(0.0  )  ) ;
        retval(c_addr             ) := to_std_logic_vector(to_float(capacitor_gain    )  ) ;
        retval(l_addr             ) := to_std_logic_vector(to_float(inductor_gain    )  ) ;
        retval(r_addr             ) := to_std_logic_vector(to_float(inductor_res    )  ) ;
        retval(duty               ) := to_std_logic_vector(to_float(init_values.duty )  ) ;
        retval(iload              ) := to_std_logic_vector(to_float(0.0  )  ) ;

        return retval;
    end build_boost_model;


end package body boost_model_pkg;
