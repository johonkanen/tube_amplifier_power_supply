library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

package vendor_specifics_pkg is

   component pll_1x256mhz is
   port (
       clk_out1: out  std_logic; 
       locked: out  std_logic; 
       clk_in1 : in  std_logic);
   end component;

    COMPONENT combi_mult_18x18
      PORT (
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

   constant g_vendor_specific_uart_clks_per_bit : integer := 50;
   constant g_vendor_specific_RX_bytes_in_word : integer := 2;
   constant g_vendor_specific_TX_bytes_in_word : integer := 2;
end vendor_specifics_pkg;
