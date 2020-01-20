library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.phase_modulator_pkg.all;

entity phase_modulator is
    port (
        phase_modulator_clocks : in phase_modulator_clock_group;

        phase_modulator_FPGA_out : out phase_modulator_FPGA_output_group;

        phase_modulator_data_in : in phase_modulator_data_input_group;
        phase_modulator_data_out : out phase_modulator_data_output_group
    );
end entity phase_modulator;

architecture rtl of phase_modulator is

    

begin


end rtl;
