library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
    use work.alu_routines_pkg.all;

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
        so18_sincos_out : out signed(17 downto 0)
    );
end entity sin_cos16bit;

architecture rtl of sin_cos16bit is

-- sin constants s1 51472 s3 84635 s5 40720
-- cos constants c0 16384 c2 80805 c4 64473

-- +/- pi/4 range sine and cosine approximation
--   z = angle^2;
--
--   prod = z*s5;
--   prod = z*(s3) - prod);
--   sin16 = (s1-prod)*angle;
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

    signal alu_ctrl : alu_control_signals;

    function std_to_bool
    (
        logic_in : std_logic
    )
    return boolean
    is
    begin
        if logic_in = '1' then
           return true;
        else
          return false;
        end if; 
    end std_to_bool;
    signal input_angle : int18;

begin
        input_angle <= to_integer(s16_angle);

        alu_ctrl.mult_result <= si36_mpy1_result;
  --      si36_mpy2_result;
        alu_ctrl.mult_is_ready <= std_to_bool(si_mult_rdy);
        so18_sincos_mpy1_a  <= alu_ctrl.mult_a;
        so18_sincos_mpy1_b  <= alu_ctrl.mult_b;
        --so18_sincos_mpy2_a  <= 
        --so18_sincos_mpy2_b  <= alu_ctrl.mult
        so_sincos_start_mpy <= alu_ctrl.start_alu_mpy;

sin_cos : process(core_clk)
    variable program_counter : integer range 0 to 7;
    variable mult1_result : sign36;
    variable angle2 : sign36;

    impure function "*"(a : integer := 0; b : integer := 0) return signed is
    begin
       alu_mult(a, b, alu_ctrl, mult1_result, program_counter);
    end function;

begin
    if rising_edge(core_clk) then
        CASE program_counter is 
            WHEN 0 =>
                so_sincos_rdy <= '0';
                so18_sincos_out <= (others => '0');

                so18_sincos_mpy1_a <= (others => '0');
                so18_sincos_mpy1_b <= (others => '0');
                so18_sincos_mpy2_a <= (others => '0');
                so18_sincos_mpy2_b <= (others => '0');
                so_sincos_start_mpy <= '0';

                if si_start_sin_cos = '1' then
                    -- square input
                    angle2 := input_angle * input_angle;
                else
                    program_counter := 0;
                end if;
                so_sincos_rdy <= '0';
            WHEN 1 =>
                mult1_result := angle2(33 downto 16) * sin_factors.s5; 
                so_sincos_rdy <= '0';
            WHEN 2 =>
                mult1_result := angle2(33 downto 16) * (sin_factors.s3 - (mult1_result(30 downto 13))); 
                so_sincos_rdy <= '0';
            WHEN 3 =>
                mult1_result := (sin_factors.s1 - mult1_result(30 downto 13)) * input_angle; 
                so_sincos_rdy <= '0';
            WHEN 4 =>
                so18_sincos_out <= mult1_result(30 downto 13);
                so_sincos_rdy <= '1';
            WHEN others => 
                program_counter := 0;
        end CASE;

        if rstn = '0' then
            program_counter := 0;
        end if; -- rstn
    end if; --rising_edge
end process sin_cos;	

end rtl;
