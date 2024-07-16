library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    -- ram package defines instruction bit widths
    use work.ram_configuration_pkg.ram_bit_width;

package processor_configuration_pkg is

    constant instruction_bit_width     : natural := ram_bit_width;
    constant register_bit_width        : natural := ram_bit_width;

    constant number_of_registers       : natural := 5;
    constant number_of_pipeline_stages : natural := 10 + work.denormalizer_pipeline_pkg.pipeline_configuration 
                                                       + work.normalizer_pipeline_pkg.normalizer_pipeline_configuration;
    type t_command is (
        program_end ,
        nop         ,
        add         ,
        sub         ,
        mpy         ,
        mpy_add     ,
        neg_mpy_add ,
        mpy_sub     ,

        neg_mpy     ,
        a_more_than_b_and_c_positive ,

        save        ,
        load
    );

    subtype comm is std_logic_vector(31 downto 28);
    subtype dest is std_logic_vector(27 downto 21);
    subtype arg1 is std_logic_vector(20 downto 14);
    subtype arg2 is std_logic_vector(13 downto 7);
    subtype arg3 is std_logic_vector(6 downto 0);
    subtype long_arg is std_logic_vector(27 downto 0);

end package processor_configuration_pkg;
