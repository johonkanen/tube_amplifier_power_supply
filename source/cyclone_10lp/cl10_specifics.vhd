library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

package vendor_specifics_pkg is

    type system_clock_group is record
        core_clock     : std_logic;
        modulator_clock  : std_logic;
        modulator_clock2 : std_logic;
        pll_lock       : std_logic;
    end record;

    component main_pll IS
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC ;
		c2		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
    END component;

    COMPONENT combi_mult_18x18
      PORT (
        CLK : IN STD_LOGIC;
        A : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        P : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
      );
    END COMPONENT;

    COMPONENT dsp_ab_sum_c
      PORT (
        A : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        C : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        P : OUT STD_LOGIC_VECTOR(36 DOWNTO 0)
      );
    END COMPONENT;

   constant g_vendor_specific_uart_clks_per_bit : integer := 25;
   constant g_vendor_specific_RX_bytes_in_word : integer := 2;
   constant g_vendor_specific_TX_bytes_in_word : integer := 2;
end vendor_specifics_pkg;
