library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
    use work.alu16bit_pkg.all;

entity sin_cos16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_sin_cos : in std_logic;
        s16_angle : in signed(17 downto 0);

        si36_mpy1_result : in std_logic_vector(35 downto 0); 
        si36_mpy2_result : in std_logic_vector(35 downto 0); 
        si_mult_rdy : in std_logic;

        so18_sincos_mpy1_a : out std_logic_vector(17 downto 0); 
        so18_sincos_mpy1_b : out std_logic_vector(17 downto 0); 

        so18_sincos_mpy2_a : out std_logic_vector(17 downto 0); 
        so18_sincos_mpy2_b : out std_logic_vector(17 downto 0); 

        so_sincos_start_mpy : out std_logic; 

        so_sincos_busy : out std_logic;
        so_sincos_rdy : out std_logic;
        so18_sincos_out : out std_logic_vector(17 downto 0)
    );
end entity sin_cos16bit;

architecture rtl of sin_cos16bit is

    subtype int18 is integer range -2**17 to 2**17-1;
-- sin constants s1 51472 s3 84635 s5 40720
-- cos constants c0 16384 c2 80805 c4 64473


--   z = angle^2;
--
--   prod = (z*s5);
--   summ = s3 - prod;
--   prod = (z*summ);
--   summ = s1-prod;
--
--   sin16 = summ*angle;
--
--   prod = (z*c4);
--   summ = c2-prod;
--   prod = z*summ;
--
--   cos16 = c0-prod;

    type sin_chebyshev18bit is record
        s1 : int18;
        s3 : int18;
        s5 : int18;    
    end record;
    constant sin_factors : sin_chebyshev18bit := (s1 => 51472, s3=> 84635, s5=> 40720);

    type cos_chebyshev18bit is record
        c0 : int18;
        c2 : int18;
        c4 : int18;    
    end record;
    constant cos_factors : cos_chebyshev18bit := (c0 => 16384, c2=> 80805, c4=> 64473);

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

div : process(core_clk)
    type t_sincos_states is (idle,m1,m2,m3, m4,rdy);
    variable st_sincos_states : t_sincos_states;
begin
    if rising_edge(core_clk) then
        if rstn = '0' then
        -- reset state
            st_sincos_states := idle;
            so_sincos_rdy <= '0';
            so_sincos_busy <= '0';
            so18_sincos_out <= (others => '0');
            so_sincos_start_mpy <= '0';
            so18_sincos_mpy1_a <= (others => '0');
            so18_sincos_mpy1_b <= (others => '0');
            so18_sincos_mpy2_a <= (others => '0');
            so18_sincos_mpy2_b <= (others => '0');
        else
            CASE st_sincos_states is 
                WHEN idle =>
                    so_sincos_rdy <= '0';
                    so18_sincos_out <= (others => '0');

                    so18_sincos_mpy2_a <= (others => '0');
                    so18_sincos_mpy2_b <= (others => '0');
                    if si_start_sin_cos = '1' then
                        st_sincos_states := m1;
                        -- calculate square of the input angle
                        so18_sincos_mpy1_a <= std_logic_vector(s16_angle);
                        so18_sincos_mpy1_b <= std_logic_vector(s16_angle);
                        so_sincos_start_mpy <= '1';
                    else
                        st_sincos_states := idle;
                        so18_sincos_mpy1_a <= (others => '0');
                        so18_sincos_mpy1_b <= (others => '0');
                        so_sincos_start_mpy <= '0';
                    end if;
                WHEN m1 =>
                    so_sincos_rdy <= '0';
                    so18_sincos_out <= (others => '0');
                    if si_mult_rdy = '1' then
                        so18_sincos_mpy1_a <= "00"&rounded_mpy(si36_mpy1_result);
                        so18_sincos_mpy1_b <= "00"& not (rounded_mpy(si36_mpy1_result));

                        so18_sincos_mpy2_a <= "00"&(not rounded_mpy(si36_mpy1_result));
                        --so18_sincos_mpy2_b <= inv_magic_number;
                        so_sincos_start_mpy <= '1';
                        st_sincos_states := m2;
                    else
                        so_sincos_start_mpy <= '0';
                        st_sincos_states := m1;
                    end if;
                WHEN m2 =>
                    so_sincos_rdy <= '0';
                    so18_sincos_out <= (others => '0');
                    if si_mult_rdy = '1' then
                        so18_sincos_mpy1_a <= "00"&rounded_mpy(si36_mpy1_result);
                        so18_sincos_mpy1_b <= "00"&(not rounded_mpy(si36_mpy1_result));

                        so18_sincos_mpy2_a <= "00"&(not rounded_mpy(si36_mpy1_result));
                        so18_sincos_mpy2_b <= "00"&rounded_mpy(si36_mpy2_result);
                        st_sincos_states := m3;
                        so_sincos_start_mpy <= '1';
                    else
                        st_sincos_states := m2;
                        so_sincos_start_mpy <= '0';
                    end if;
                WHEN m3 =>
                    so_sincos_rdy <= '0';
                    so18_sincos_out <= (others => '0');
                    if si_mult_rdy = '1' then
                        so18_sincos_mpy1_a <= "00"&rounded_mpy(si36_mpy1_result);
                        so18_sincos_mpy1_b <= "00"&(not rounded_mpy(si36_mpy1_result));

                        so18_sincos_mpy2_a <= "00"&(not rounded_mpy(si36_mpy1_result));
                        so18_sincos_mpy2_b <= "00"&rounded_mpy(si36_mpy2_result);
                        st_sincos_states := rdy;
                        so_sincos_start_mpy <= '1';
                    else
                        st_sincos_states := m3;
                        so_sincos_start_mpy <= '0';
                    end if;
                WHEN rdy =>
                    so_sincos_start_mpy <= '0';
                    if si_mult_rdy = '1' then
                        so18_sincos_out <= "00"&rounded_mpy(si36_mpy2_result);
                        so_sincos_rdy <= '1';
                        st_sincos_states := idle;
                    else
                        st_sincos_states := rdy;
                        so_sincos_rdy <= '0';
                    end if;
                WHEN others => 
                    st_sincos_states := idle;
            end CASE;
        end if; -- rstn
    end if; --rising_edge
end process div;	

end rtl;
