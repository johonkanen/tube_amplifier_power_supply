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

   signal adc_measurement : integer range 0 to 2**16-1;
   signal simulation_running : boolean;
   signal simulator_clock : std_logic;
   signal clocked_reset : std_logic;
   constant clock_per : time := 7.8125 ns;
   constant clock_half_per : time := 3.90625 ns;
   constant simtime_in_clocks : integer := 80;
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

    clocked_reset_generator : process(simulator_clock, rstn)
    begin
        if rstn = '0' then
        -- reset state
            clocked_reset <= '0';
    
        elsif rising_edge(simulator_clock) then
            clocked_reset <= '1';
    
        end if; -- rstn
    end process clocked_reset_generator;	
    ------------------------------------------------------------------------
------------------------------------------------------------------------
    adc_test : process
    begin
        -- reset state
                rstn <= '0';
            wait for 3 ns;
                rstn <= '1';
                idle_adc(max_11115_data_in);
            wait for 10 ns;
                start_adc(max_11115_data_in);
            wait for 10 ns;
                idle_adc(max_11115_data_in);
            wait for 100 ns;
            wait;
    end process adc_test;	
------------------------------------------------------------------------
    max_11115_clocks <= (adc_clock => simulator_clock, reset_n => clocked_reset);
    max_11115_FPGA_in <= (adc_serial_data => '1');
    max_11115_CS <= max_11115_FPGA_out.adc_chip_select;
    max_11115_spi_clock <= max_11115_FPGA_out.adc_spi_clock;
    adc_measurement <= max_11115_data_out.adc_measurement_data;
    u_max_11115 : max_11115
    generic map(4, 14, 16, 1)
    port map
    (
        max_11115_clocks,
        max_11115_FPGA_in, 
        max_11115_FPGA_out,
        max_11115_data_in, 
        max_11115_data_out
    );
end sim;
