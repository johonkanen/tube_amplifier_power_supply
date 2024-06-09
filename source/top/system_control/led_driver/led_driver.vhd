
architecture rtl of led_driver is

	signal carrier : unsigned(8 downto 0);

begin

	led1_pwm : process(led_clk) 
	begin
		if rising_edge(led_clk) then
            carrier <= carrier + 1;

            if carrier < led1_ctrl.u9_blu_duty then
                po3_led1.blue <= '0';
            else
                po3_led1.blue <= '1';
            end if;
            if carrier < led1_ctrl.u9_grn_duty then
                po3_led1.green <= '0';
            else
                po3_led1.green <= '1';
            end if;
            if carrier < led1_ctrl.u9_red_duty then
                po3_led1.red <= '0';
            else
                po3_led1.red <= '1';
            end if;

            if carrier < led2_ctrl.u9_blu_duty then
                po3_led2.blue <= '0';
            else
                po3_led2.blue <= '1';
            end if;
            if carrier < led2_ctrl.u9_grn_duty then
                po3_led2.green <= '0';
            else
                po3_led2.green <= '1';
            end if;
            if carrier < led2_ctrl.u9_red_duty then
                po3_led2.red <= '0';
            else
                po3_led2.red <= '1';
            end if;
		
            if carrier < led3_ctrl.u9_blu_duty then
                po3_led3.blue <= '0';
            else
                po3_led3.blue <= '1';
            end if;
            if carrier < led3_ctrl.u9_grn_duty then
                po3_led3.green <= '0';
            else
                po3_led3.green <= '1';
            end if;
            if carrier < led3_ctrl.u9_red_duty then
                po3_led3.red <= '0';
            else
                po3_led3.red <= '1';
            end if;
        end if;
    end process;
end rtl;
