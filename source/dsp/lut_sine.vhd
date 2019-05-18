library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.NUMERIC_STD.all;

entity lut_sine is
    port(
	    lut_clk : in std_logic;
	    
	    si_std11_pirad : in std_logic_vector(10 downto 0);
	    so_sign16_sine : out std_logic_vector(15 downto 0)
	);
end lut_sine;

architecture rtl of lut_sine is

component rom1port_16x512 IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END component;



    signal r_std9_sine_address : std_logic_vector(8 downto 0);
    signal r_std16_sine_0_to_pi4 : std_logic_vector(15 downto 0);

begin

sine_0_to_2pi_table : rom1port_16x512
	PORT MAP
	(
		address	=> r_std9_sine_address, 
		clock	=> lut_clk, 
		q => r_std16_sine_0_to_pi4 
	);



    getsine : process(lut_clk)

    begin
	if rising_edge(lut_clk) then
	    CASE si_std11_pirad(10 downto 9) is
		    WHEN "00" =>
			    r_std9_sine_address <= si_std11_pirad(8 downto 0);
			    so_sign16_sine <= r_std16_sine_0_to_pi4;
		    WHEN "01" =>
			    r_std9_sine_address <= not si_std11_pirad(8 downto 0);
			    so_sign16_sine <= r_std16_sine_0_to_pi4;
		    WHEN "10" =>
			    r_std9_sine_address <= si_std11_pirad(8 downto 0);
			    so_sign16_sine <= not r_std16_sine_0_to_pi4 + '1';
		    WHEN "11" =>
			    r_std9_sine_address <= not si_std11_pirad(8 downto 0);
			    so_sign16_sine <= not r_std16_sine_0_to_pi4 + '1';
            WHEN others =>
        -- do nothing, only for simulation purposes
	    end CASE;
	end if;
    end process getsine;

end rtl;
