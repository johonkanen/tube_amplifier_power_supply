library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.max_11115_pkg.all;

entity max_11115 is
    generic (
        g_adc_clock_divisor : integer;
        g_adc_clocks_in_conversion : integer;
        g_adc_clocks_in_frame : integer
    );
    port (
        max_11115_clocks : in max_11115_clock_group;

        max_11115_FPGA_in : in max_11115_FPGA_input_group;
        max_11115_FPGA_out : out max_11115_FPGA_output_group;

        max_11115_data_in : in max_11115_data_input_group;
        max_11115_data_out : out max_11115_data_output_group
    );
end max_11115;

architecture rtl of max_11115 is
    alias adc_clock : std_logic is max_11115_clocks.adc_clock;
    alias reset_n : std_logic is max_11115_clocks.reset_n;

    signal adc_spi_clock : std_logic; 
    signal adc_spi_clock_div : integer range 0 to 2**12-1;



------------------------------------------------------------------------
    procedure enable_ext_adc ( signal adc_CS : out std_logic) is
    begin
        adc_CS <= '0';
    end enable_ext_adc;
------------------------------------------------------------------------     
    procedure disable_ext_adc ( signal adc_CS : out std_logic) is
    begin
        adc_CS <= '1';
    end disable_ext_adc;
------------------------------------------------------------------------
    procedure increment ( counter : inout integer) is
    begin
        counter := counter + 1;
    end increment;
------------------------------------------------------------------------
    procedure increment_and_wrap ( signal counter : inout integer; constant wrap_value : integer) is
    begin
        counter <= counter + 1;
        if counter = wrap_value - 1 then
            counter <= 0;
        end if;
    end increment_and_wrap;
------------------------------------------------------------------------
begin

    chip_select_driver : process(adc_clock)
        variable adc_clock_divisor_counter : integer range 0 to 2**10-1;
        constant adc_enabled : std_logic := '0'; 
        constant adc_disabled : std_logic := '1'; 

        type t_adc_control is (idle, conversion);
        variable st_adc_control : t_adc_control;

    begin
        if rising_edge(adc_clock) then
            if reset_n = '0' then
            -- reset state
                max_11115_FPGA_out.adc_chip_select <= adc_disabled;
                adc_clock_divisor_counter := 0;
            else
                disable_ext_adc(max_11115_FPGA_out.adc_chip_select);
                CASE st_adc_control is
                    WHEN idle =>

                        adc_clock_divisor_counter := 0;
                        st_adc_control := idle;
                        if max_11115_data_in.adc_conversion_requested then
                            st_adc_control := conversion;
                            enable_ext_adc(max_11115_FPGA_out.adc_chip_select);
                        end if;
                    WHEN conversion =>

                        increment(adc_clock_divisor_counter);

                        if adc_clock_divisor_counter < (g_adc_clocks_in_conversion - 2)*g_adc_clock_divisor + 2 then
                            enable_ext_adc(max_11115_FPGA_out.adc_chip_select);
                        end if;

                        if adc_clock_divisor_counter = (g_adc_clocks_in_frame - 1)*g_adc_clock_divisor then 
                            st_adc_control := idle;
                        end if;
                end CASE;
            end if;
        end if;
    end process;


    adc_spi_clock_driver : process(adc_clock)
        variable adc_clock_counter : integer range 0 to 2**5-1;
        variable adc_clock_divisor_counter : integer range 0 to 2**10-1;
        constant adc_enabled : std_logic := '0'; 
        constant adc_disabled : std_logic := '1'; 

        type t_adc_control is (idle, conversion);
        variable st_adc_control : t_adc_control;

    begin
        if rising_edge(adc_clock) then
            if reset_n = '0' then
            -- reset state
                adc_clock_counter := 0;
                adc_clock_divisor_counter := 0;
                adc_spi_clock_div <= 0;
            else
                max_11115_FPGA_out.adc_spi_clock <= '1';
                CASE st_adc_control is
                    WHEN idle =>
                        adc_clock_counter := 0;
                        adc_spi_clock_div <= 0;

                        st_adc_control := idle;
                        if max_11115_data_in.adc_conversion_requested then
                            st_adc_control := conversion;
                        end if;
                    WHEN conversion =>

                        increment_and_wrap(adc_spi_clock_div, g_adc_clock_divisor);

                        if adc_spi_clock_div = g_adc_clock_divisor -1 then
                            increment(adc_clock_counter);
                        end if;

                        if adc_spi_clock_div < g_adc_clock_divisor/2 then
                            max_11115_FPGA_out.adc_spi_clock <= '0';
                        end if;

                        if adc_clock_counter = g_adc_clocks_in_frame -1 then
                            st_adc_control := idle;
                        end if;
                end CASE;
            end if;
        end if;
    end process adc_spi_clock_driver;	
end rtl;
