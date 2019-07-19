library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work;
    use work.vendor_specifics_pkg.all;
    use work.alu16bit_pkg.all;
    use work.alu_routines_pkg.all;

entity alu16bit is
    port (
        core_clk : in std_logic;
        rstn : in std_logic;

        si_start_alu : in std_logic;
        alu_command : in t_alu_commands;
        data1 : in signed(17 downto 0);
        data2 : in signed(17 downto 0);

        so_alu_busy : out std_logic;
        so_alu_rdy : out std_logic;
        so18_alu_data : out signed(17 downto 0)
    );
end entity alu16bit;

architecture rtl of alu16bit is

    component combi_mult_18x18 is 
        port (
            CLK : in std_logic;
            A : in std_logic_vector(17 downto 0);
            B : in std_logic_vector(17 downto 0);
            P : out std_logic_vector(35 downto 0)
        );
    end component;

    signal mpy1_a : std_logic_vector(17 downto 0); 
    signal mpy1_b : std_logic_vector(17 downto 0); 
    signal mpy1_result : std_logic_vector(35 downto 0); 

    signal mpy2_a : std_logic_vector(17 downto 0); 
    signal mpy2_b : std_logic_vector(17 downto 0); 
    signal mpy2_result : std_logic_vector(35 downto 0); 
    signal r1_si_start_alu : std_logic;  
    signal busy : std_logic;

    signal mult1_rdy : std_logic;
    signal start_mpy : std_logic; 
    signal alu_mux_pos : t_alu_commands; 
begin

mpy1 : combi_mult_18x18
    port map(core_clk, mpy1_a, mpy1_b, mpy1_result);

mpy2 : combi_mult_18x18
    port map(core_clk, mpy2_a, mpy2_b, mpy2_result);

alu_commands : process(core_clk)
        type t_alu_states is (idle,mult,div,sqrt);
        variable st_alu_states : t_alu_states;
    begin
        if rising_edge(core_clk) then
            if rstn = '0' then
            -- reset state
                start_mpy <= '0';
                r1_si_start_alu <= si_start_alu;
                st_alu_states := idle;
                mpy1_a <= (others => '0');
                mpy1_b <= (others => '0');
                mpy2_a <= (others => '0');
                mpy2_b <= (others => '0');
                so18_alu_data <= (others => '0');
            else
                r1_si_start_alu <= si_start_alu;
                --alu states
                CASE st_alu_states is 
                    WHEN idle =>
                        if r1_si_start_alu = not si_start_alu then
                            CASE alu_command is
                                WHEN add =>
                                WHEN sub =>
                                WHEN a_mpy_b =>
                                    mpy1_a <= std_logic_vector(data1);
                                    mpy1_b <= std_logic_vector(data2);
                                    so_alu_busy <= '1';
                                    start_mpy <= '1';
                                    st_alu_states := mult;
                                WHEN a_div_b =>
                                WHEN sqrt_a =>
                                WHEN others =>
                            end CASE;
                        else
                            st_alu_states := idle;
                            so_alu_busy <= '0';
                            so_alu_rdy <= '0';
                        end if;
                    WHEN mult =>
                        if mult1_rdy = '1' then
                            --alu out <= multiplier out
                            st_alu_states := idle;
                            so_alu_busy <= '0';
                            so_alu_rdy <= '1';
                            so18_alu_data <= signed(mpy1_result(17 downto 0));
                        else 
                            so_alu_rdy <= '0';
                            so_alu_busy <= '1';
                            st_alu_states := mult;
                            so18_alu_data <= (others => '0');
                        end if;
                    WHEN others =>
                        st_alu_states := idle;
                    end CASE;
            end if; -- rstn
        end if; --rising_edge
    end process ;	

mult1 : process(core_clk)
    type t_multiplier_states is (idle,mult);
    variable st_multiplier_states : t_multiplier_states;
begin
    if rising_edge(core_clk) then
        if rstn = '0' then
        -- reset state
            st_multiplier_states := idle;
            mult1_rdy <= '0';
        else
            CASE st_multiplier_states is 
                WHEN idle =>
                    if start_mpy = '1' then
                        st_multiplier_states := mult;
                    else
                        st_multiplier_states := idle;
                    end if;
                    mult1_rdy <= '0';
                WHEN mult =>
                    mult1_rdy <= '1';
                WHEN others => 
                    -- do nothing
            end CASE;
        end if; -- rstn
    end if; --rising_edge
end process mult1;	

end rtl;