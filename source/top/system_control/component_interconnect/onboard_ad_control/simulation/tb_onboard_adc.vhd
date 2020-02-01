LIBRARY ieee  ; 
LIBRARY std  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    USE ieee.std_logic_textio.all  ; 
    use ieee.math_real.all;
    USE std.textio.all  ; 

library onboard_adc_library;
    use onboard_adc_library.onboard_ad_control_pkg.all;

entity tb_onboard_adc is
end;

architecture sim of tb_onboard_adc is
    signal rstn : std_logic;

    signal simulation_running : boolean;
    signal simulator_clock : std_logic;
    constant clock_per : time := 1 ns;
    constant clock_half_per : time := 0.5 ns;
    constant simtime_in_clocks : integer := 2100;
------------------------------------------------------------------------
    signal onboard_ad_control_clocks   : onboard_ad_control_clock_group;
    signal onboard_ad_control_FPGA_in  : onboard_ad_control_FPGA_input_group;
    signal onboard_ad_control_FPGA_out : onboard_ad_control_FPGA_output_group;
    signal onboard_ad_control_data_in  : onboard_ad_control_data_input_group;
    signal onboard_ad_control_data_out : onboard_ad_control_data_output_group;
------------------------------------------------------------------------
    signal adc_measurement : integer;
    signal ad_channel : integer;
    signal clocked_reset : std_logic;
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
        rstn <= '0';
        simulator_clock <= '0';
        wait for clock_half_per;
        while simulation_running loop
            wait for clock_half_per;
                rstn <= '1';
                simulator_clock <= not simulator_clock;
            end loop;
        wait;
    end process;

    reset_gen : process(simulator_clock, rstn)
    begin
        if rstn = '0' then
        -- reset state
            clocked_reset <= '0';
    
        elsif rising_edge(simulator_clock) then
            clocked_reset <= '1';
    
        end if; -- rstn
    end process reset_gen;	
------------------------------------------------------------------------
    test_adc : process(simulator_clock)
        variable adc_test_counter : integer;
    begin
        if rising_edge(simulator_clock) then
            if clocked_reset = '0' then
            -- reset state
                adc_test_counter := 0;
                onboard_ad_control_data_in <=(false, 0, false, 0);
            else
                adc_test_counter := adc_test_counter + 1;
                if adc_test_counter = 896 then
                    adc_test_counter := 0;
                end if;

                onboard_ad_control_data_in.ada_start_request <= false;
                onboard_ad_control_data_in.adb_start_request <= false;
                CASE adc_test_counter is
                    WHEN 0 =>
                        onboard_ad_control_data_in <= trigger_adc(1);
                    WHEN 128 =>
                        onboard_ad_control_data_in <= trigger_adc(2);
                    WHEN 256 =>
                        onboard_ad_control_data_in <= trigger_adc(3);
                    WHEN 384 =>
                        onboard_ad_control_data_in <= trigger_adc(4);
                    WHEN 512 =>
                        onboard_ad_control_data_in <= trigger_adc(5);
                    WHEN 640 =>
                        onboard_ad_control_data_in <= trigger_adc(6);
                    WHEN 768 =>
                        onboard_ad_control_data_in <= trigger_adc(0);
                    WHEN others =>
                end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process test_adc;	
------------------------------------------------------------------------

    onboard_ad_control_FPGA_in.ada_data <= '1';
    onboard_ad_control_clocks <= (simulator_clock, simulator_clock, clocked_reset);
    ad_channel <= onboard_ad_control_data_out.ada_channel;
    u_onboard_ad_control : onboard_ad_control 
    port map(
        onboard_ad_control_clocks,   
        onboard_ad_control_FPGA_in,  
        onboard_ad_control_FPGA_out, 
        onboard_ad_control_data_in,
        onboard_ad_control_data_out 
    );
------------------------------------------------------------------------

end sim;
