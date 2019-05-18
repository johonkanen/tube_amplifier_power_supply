library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.numeric_std.all;

library work;
	use work.sys_ctrl_pkg.all;

entity led_indicator is
	port(
			led_clk : in std_logic;
			si_tcmd_system_cmd : in tcmd_system_commands;
			po3_led1 : out std_logic_vector(2 downto 0);
			po3_led2 : out std_logic_vector(2 downto 0);
			po3_led3 : out std_logic_vector(2 downto 0)
		    );
end led_indicator;
    
architecture rtl of led_indicator is

	component led_driver is
    port(
			led_clk : in std_logic;
			po3_led1 : out std_logic_vector(2 downto 0);
			po3_led2 : out std_logic_vector(2 downto 0);
			po3_led3 : out std_logic_vector(2 downto 0);

			u9_led1_blu : in unsigned(8 downto 0);	
			u9_led1_grn : in unsigned(8 downto 0);	
			u9_led1_red : in unsigned(8 downto 0);	
	
			u9_led2_blu : in unsigned(8 downto 0);	
			u9_led2_grn : in unsigned(8 downto 0);	
			u9_led2_red : in unsigned(8 downto 0);	
	
			u9_led3_blu : in unsigned(8 downto 0);	
			u9_led3_grn : in unsigned(8 downto 0);	
			u9_led3_red : in unsigned(8 downto 0)
        );
	end component;

	signal r_u9_led1_blu : unsigned(8 downto 0); 	
	signal r_u9_led1_grn : unsigned(8 downto 0);	
	signal r_u9_led1_red : unsigned(8 downto 0);	

	signal r_u9_led2_blu : unsigned(8 downto 0);	
	signal r_u9_led2_grn : unsigned(8 downto 0);	
	signal r_u9_led2_red : unsigned(8 downto 0);	

	signal r_u9_led3_blu : unsigned(8 downto 0);	
	signal r_u9_led3_grn : unsigned(8 downto 0); 	
	signal r_u9_led3_red : unsigned(8 downto 0); 	

begin

led_control : led_driver 
	port map(
			led_clk => led_clk,
			po3_led1 => po3_led1,
			po3_led2 => po3_led2,
			po3_led3 => po3_led3, 

			u9_led1_blu => r_u9_led1_blu, 	
			u9_led1_grn => r_u9_led1_grn,	
			u9_led1_red => r_u9_led1_red,	
	
			u9_led2_blu => r_u9_led2_blu,	
			u9_led2_grn => r_u9_led2_grn,	
			u9_led2_red => r_u9_led2_red,	
	
			u9_led3_blu => r_u9_led3_blu,	
			u9_led3_grn => r_u9_led3_grn, 	
			u9_led3_red => r_u9_led3_red
		);

	led_colors : process(led_clk)

	begin

	    if rising_edge(led_clk) then
		CASE  si_tcmd_system_cmd is
		    WHEN init =>

			r_u9_led1_blu <=(others=>'0'); 	
			r_u9_led1_grn <= to_unsigned(80,9);
			r_u9_led1_red <=(others=>'0');	
	
			r_u9_led2_blu <=(others=>'0');	
			r_u9_led2_grn <= to_unsigned(80,9);
			r_u9_led2_red <=(others=>'0');	
	
			r_u9_led3_blu <=(others=>'0');	
			r_u9_led3_grn <= to_unsigned(80,9);
			r_u9_led3_red <=(others=>'0');

		    WHEN charge_dc_link =>
			r_u9_led1_blu <=(others=>'0'); 	
			r_u9_led1_grn <= (others=>'0');	
			r_u9_led1_red <= to_unsigned(80,9);	
	
			r_u9_led2_blu <=(others=>'0');	
			r_u9_led2_grn <= (others=>'0');	
			r_u9_led2_red <= to_unsigned(80,9);	
	
			r_u9_led3_blu <=(others=>'0');	
			r_u9_led3_grn <= (others=>'0');	
			r_u9_led3_red <= to_unsigned(80,9);

		    WHEN bypass_relay =>
			r_u9_led1_blu <= to_unsigned(40,9); 	
			r_u9_led1_grn <=  to_unsigned(80,9);
			r_u9_led1_red <=(others=>'0');		
	
			r_u9_led2_blu <= to_unsigned(40,9); 
			r_u9_led2_grn <=  to_unsigned(80,9);
			r_u9_led2_red <=(others=>'0');		
	
			r_u9_led3_blu <= to_unsigned(40,9); 
			r_u9_led3_grn <= to_unsigned(80,9); 
			r_u9_led3_red <= (others=>'0');	

		    WHEN start_aux =>
			r_u9_led1_blu <= to_unsigned(80,9); 	
			r_u9_led1_grn <= (others=>'0');	
			r_u9_led1_red <= (others=>'0');	
	
			r_u9_led2_blu <=to_unsigned(80,9);	
			r_u9_led2_grn <= (others=>'0');
			r_u9_led2_red <= (others=>'0');	
	
			r_u9_led3_blu <=to_unsigned(80,9);	
			r_u9_led3_grn <= (others=>'0');	
			r_u9_led3_red <=(others=>'0');

		    WHEN others =>
			r_u9_led1_blu <=(others=>'0'); 	
			r_u9_led1_grn <=(others=>'0');	
			r_u9_led1_red <=to_unsigned(80,9);	
	
			r_u9_led2_blu <=(others=>'0');	
			r_u9_led2_grn <=(others=>'0');	
			r_u9_led2_red <=to_unsigned(80,9);	
	
			r_u9_led3_blu <=(others=>'0');	
			r_u9_led3_grn <=(others=>'0'); 	
			r_u9_led3_red <=to_unsigned(80,9);
		    end CASE;
		end if;
	    end process;

end rtl;
