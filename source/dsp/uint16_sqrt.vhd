library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
    use work.alu16bit_pkg.all;

entity uint16_sqrt is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_div : in std_logic;
        data_to_invert : in signed(17 downto 0);

        si36_mpy1_result : in std_logic_vector(35 downto 0); 
        si36_mpy2_result : in std_logic_vector(35 downto 0); 
        si_mult_rdy : in std_logic;

        so18_div_mpy1_a : out std_logic_vector(17 downto 0); 
        so18_div_mpy1_b : out std_logic_vector(17 downto 0); 

        so18_div_mpy2_a : out std_logic_vector(17 downto 0); 
        so18_div_mpy2_b : out std_logic_vector(17 downto 0); 

        so_div_start_mpy : out std_logic; 

        so_div_busy : out std_logic;
        so_div_rdy : out std_logic;
        so18_div_out : out std_logic_vector(17 downto 0)
    );
end entity uint16_sqrt;

architecture rtl of uint16_sqrt is

    constant sqrt_magic_number : integer := 23232;
    -- constants optimized for max error of 10 units for 10bit sqrt using multiplicative normalized method

    function rounded_mpy
    (
        mpy_out : std_logic_vector(35 downto 0)
    )
    return std_logic_vector
    is
    begin
        if mpy_out(14) = '1' then
            return std_logic_vector((unsigned(mpy_out(30 downto 15)) + 1));
        else
            return mpy_out(30 downto 15);
        end if;
    end rounded_mpy;

begin

mnm_sqrt : process(core_clk)
    type t_division_states is (idle,m1,m2,m3,m4,rdy);
    variable st_division_states : t_division_states;

    function int_to_std_logic
    (
        data_A : integer
    )
    return std_logic_vector
    is
    begin
        return std_logic_vector(to_unsigned(data_A,18));
    end int_to_std_logic;
begin
    if rising_edge(core_clk) then
        if rstn = '0' then
        -- reset state
            st_division_states := idle;
            so_div_rdy <= '0';
            so_div_busy <= '0';
            so18_div_out <= (others => '0');
            so_div_start_mpy <= '0';
            so18_div_mpy1_a <= (others => '0');
            so18_div_mpy1_b <= (others => '0');
            so18_div_mpy2_a <= (others => '0');
            so18_div_mpy2_b <= (others => '0');
        else
            CASE st_division_states is 
                WHEN idle =>
                    so_div_rdy <= '0';
                    so18_div_out <= (others => '0');
                    -- invert data_to_invert

                    so18_div_mpy2_a <= (others => '0');
                    so18_div_mpy2_b <= (others => '0');
                    if si_start_div = '1' then
                        st_division_states := m1;
                        so18_div_mpy1_a <= int_to_std_logic(sqrt_magic_number); -- magic constant, tested to be optimal
                        so18_div_mpy1_b <= int_to_std_logic(to_integer(data_to_invert));
                        so_div_start_mpy <= '1';
                    else
                        st_division_states := idle;
                        so18_div_mpy1_a <= (others => '0');
                        so18_div_mpy1_b <= (others => '0');
                        so_div_start_mpy <= '0';
                    end if;
                WHEN m1 =>
                    so_div_rdy <= '0';
                    so18_div_out <= (others => '0');
                    if si_mult_rdy = '1' then
                        so18_div_mpy1_a <= "00"&rounded_mpy(si36_mpy1_result);
                        so18_div_mpy1_b <= "00"& not (rounded_mpy(si36_mpy1_result));

                        so18_div_mpy2_a <= "00"&(not rounded_mpy(si36_mpy1_result));
                        so18_div_mpy2_b <= int_to_std_logic(sqrt_magic_number); -- magic constant, tested to be optimal
                        so_div_start_mpy <= '1';
                        st_division_states := m2;
                    else
                        so_div_start_mpy <= '0';
                        st_division_states := m1;
                    end if;
                WHEN m2 =>
                    so_div_rdy <= '0';
                    so18_div_out <= (others => '0');
                    if si_mult_rdy = '1' then
                        so18_div_mpy1_a <= "00"&rounded_mpy(si36_mpy1_result);
                        so18_div_mpy1_b <= "00"&(not rounded_mpy(si36_mpy1_result));

                        so18_div_mpy2_a <= "00"&(not rounded_mpy(si36_mpy1_result));
                        so18_div_mpy2_b <= "00"&rounded_mpy(si36_mpy2_result);
                        st_division_states := m3;
                        so_div_start_mpy <= '1';
                    else
                        st_division_states := m2;
                        so_div_start_mpy <= '0';
                    end if;
                WHEN m3 =>
                    so_div_rdy <= '0';
                    so18_div_out <= (others => '0');
                    if si_mult_rdy = '1' then
                        so18_div_mpy1_a <= "00"&rounded_mpy(si36_mpy1_result);
                        so18_div_mpy1_b <= "00"&(not rounded_mpy(si36_mpy1_result));

                        so18_div_mpy2_a <= "00"&(not rounded_mpy(si36_mpy1_result));
                        so18_div_mpy2_b <= "00"&rounded_mpy(si36_mpy2_result);
                        st_division_states := rdy;
                        so_div_start_mpy <= '1';
                    else
                        st_division_states := m3;
                        so_div_start_mpy <= '0';
                    end if;
                WHEN rdy =>
                    so_div_start_mpy <= '0';
                    if si_mult_rdy = '1' then
                        so18_div_out <= "00"&rounded_mpy(si36_mpy2_result);
                        so_div_rdy <= '1';
                        st_division_states := idle;
                    else
                        st_division_states := rdy;
                        so_div_rdy <= '0';
                    end if;
                WHEN others => 
                    -- do nothing
            end CASE;
        end if; -- rstn
    end if; --rising_edge
end process mnm_sqrt;	

end rtl;
