LIBRARY ieee  ; 
LIBRARY std  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    USE ieee.std_logic_textio.all  ; 
    use ieee.math_real.all;
    USE std.textio.all  ; 

library work;
    use work.max_11115_pkg.all;

entity tb_max_11115 is
end;

architecture sim of tb_max_11115 is
   signal rstn : std_logic;

   signal simulation_running : boolean;
   signal simulator_clock : std_logic;
   constant clock_per : time := 1 ns;
   constant clock_half_per : time := 0.5 ns;
   constant simtime_in_clocks : integer := 80;
------------------------------------------------------------------------
   signal adc_chip_select : std_logic;
   signal adc_conversion_started : boolean;
   signal adc_spi_clock : std_logic;

------------------------------------------------------------------------
   signal max_11115_spi_clock : std_logic; 
   signal max_11115_CS : std_logic; 

   signal max_11115_clocks   : max_11115_clock_group;
   signal max_11115_FPGA_in  : max_11115_FPGA_input_group;
   signal max_11115_FPGA_out : max_11115_FPGA_output_group;
   signal max_11115_data_in  : max_11115_data_input_group;
   signal max_11115_data_out : max_11115_data_output_group;


begin

    simtime : process
    begin
        simulation_running <= true;
        wait for simtime_in_clocks*clock_per;
        simulation_running <= false;
        wait;
    end process simtime;	


    sim_clock_gen : process
    begin
        simulator_clock <= '0';
        simulator_clock <= '0';
        wait for clock_half_per;
        while simulation_running loop
            wait for clock_half_per;
                simulator_clock <= not simulator_clock;
            end loop;
        wait;
    end process;
------------------------------------------------------------------------
    adc_test : process
    begin
        -- reset state
            adc_conversion_started <= false;
                rstn <= '0';
            wait for 3 ns;
                rstn <= '1';

    
                idle_adc(max_11115_data_in);
            wait for 10 ns;
                adc_conversion_started <= true;
                start_adc(max_11115_data_in);
            wait for 1 ns;
                adc_conversion_started <= false;
            wait;
    end process adc_test;	
------------------------------------------------------------------------
    chip_select_driver : process(simulator_clock)
        variable adc_clock_counter : integer range 0 to 2**5-1;
        variable adc_clock_divisor_counter : integer range 0 to 2**5-1;
        constant adc_clock_divisor : integer := 4;
        constant adc_clocks_in_frame : integer := 16;
        constant adc_enabled : std_logic := '0'; 
        constant adc_disabled : std_logic := '1'; 

    begin
        if rising_edge(simulator_clock) then
            if rstn = '0' then
            -- reset state
                adc_chip_select <= adc_disabled;
                adc_clock_counter := 0;
                adc_clock_divisor_counter := 0;
                adc_spi_clock <= '1';
            else
                adc_spi_clock <= '1';
                CASE adc_chip_select is 
                    WHEN adc_disabled =>
                        adc_clock_counter := 0;
                        adc_clock_divisor_counter := 0;

                        adc_chip_select <= adc_disabled;
                        if adc_conversion_started then
                            adc_chip_select <= adc_enabled;
                            adc_spi_clock <= '0';
                        end if;
                    WHEN adc_enabled =>
                        adc_clock_divisor_counter := adc_clock_divisor_counter + 1;
                        if adc_clock_divisor_counter = adc_clock_divisor then
                            adc_clock_divisor_counter := 0;
                        end if;

                        if adc_clock_divisor_counter < adc_clock_divisor/2 then
                            adc_spi_clock <= '0';
                        end if;

                        if adc_clock_divisor_counter = adc_clock_divisor/2 then
                            adc_clock_counter := adc_clock_counter + 1;
                        end if;

                        adc_chip_select <= adc_enabled;
                        if adc_clock_counter = adc_clocks_in_frame - 1 then 
                            adc_chip_select <= adc_disabled;
                        end if;

                    WHEN others =>
                        -- do nothing
                end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process chip_select_driver;	
------------------------------------------------------------------------
    max_11115_clocks <= (adc_clock => simulator_clock, reset_n => rstn);
    max_11115_FPGA_in <= (adc_serial_data => '1');
    max_11115_CS <= max_11115_FPGA_out.adc_chip_select;
    max_11115_spi_clock <= max_11115_FPGA_out.adc_spi_clock;
    u_max_11115 : max_11115
    generic map(4, 14, 16)
    port map
    (
        max_11115_clocks,
        max_11115_FPGA_in, 
        max_11115_FPGA_out,
        max_11115_data_in, 
        max_11115_data_out
    );
end sim;
