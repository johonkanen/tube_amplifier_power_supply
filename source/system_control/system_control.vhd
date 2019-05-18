library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.NUMERIC_STD.all;

library work;
	use work.sys_ctrl_pkg.all;

entity system_control is
    port(
	    core_clk : in std_logic;
	    dsp_clk : in std_logic;
		ext_ad_clk : in std_logic;
	     
	    po_hb1_hi_lo : out std_logic_vector(1 downto 0);
	    po_hb2_hi_lo : out std_logic_vector(1 downto 0);

	    pi_uart_rx : in std_logic;
	    po_uart_tx : out std_logic;

	    po_ad1_cs : out std_logic;
	    po_ad1_clk : out std_logic;
	    po3_ad1_muxsel : out std_logic_vector(2 downto 0);
	    pi_ad1_sdata : in std_logic;

	    po_ad2_cs : out std_logic;
	    po_ad2_clk : out std_logic;
	    pi_ad2_sdata : in std_logic;
	    po3_ad2_muxsel : out std_logic_vector(2 downto 0);

	    si_tcmd_system_cmd : in tcmd_system_commands;
	    so_tcmd_rx_cmd : out t_rx_commands

	);
end system_control;

architecture rtl of system_control is

component seq_pi_control is 
	generic(
				gen_pi_sat_high : integer; 
				gen_pi_sat_low : integer;
				gen_left_shift_p_gain : integer;
				gen_offset_sign18 : integer
			);
    port(
	    pi_clk : in std_logic;
	    
	    si_start : in std_logic;
	    so_pi_busy : out std_logic;
	    so_pi_out_rdy : out std_logic;

	    so_sign18_pi_out : out signed(17 downto 0);

	    si_sign18_ref : in signed(17 downto 0);
	    si_sign18_meas : in signed(17 downto 0);

	    si_sign18_p_gain : in signed(17 downto 0);
	    si_sign18_i_gain : in signed(17 downto 0)
	);
end component;

component sign_18x18_mult IS
	PORT
	(
		clock		: IN STD_LOGIC ;
		dataa		: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (17 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (35 DOWNTO 0)
	);
END component;

component ref_gen is
    port(
	    ref_clk : in std_logic;
	    rstn : in std_logic; 
	    si_u12_cycletime : in unsigned(11 downto 0);
	    so_ref_rdy : out std_logic;
	    so_s16_ref : out std_logic_vector(15 downto 0)
	);
end component;

component ext_ad_spi3w is
	port( 
			si_spi_clk 	 : in std_logic; 
			 
			-- physical signals to ext ad converter
			po_spi_cs 	 : out std_logic;
			po_spi_clk_out : out std_logic;
			pi_spi_serial : in std_logic; 
 
			si_spi_start	 : in std_logic; 
			 
			 
			-- ext spi control signals
			s_spi_busy	 : out std_logic; 
			-- output signal indicating word is ready to be read 
			s_spi_rdy	 : out std_logic; 
			-- output buffer
			b_spi_rx : out std_logic_vector(15 downto 0)  
		);	
end component; 

component dummy_modulation is
port(
	clk256mhz : in std_logic; -- main clock input
	dsp_clk : in std_logic;
	rstn : in std_logic;

	po_hb1_hi_lo : out std_logic_vector(1 downto 0);
	po_hb2_hi_lo : out std_logic_vector(1 downto 0);

	so_std_ada_start : out std_logic;
	so_std_adb_start : out std_logic;
	--si_std16_pwm_period_clks : in std_logic_vector(15 downto 0;
	--si_std8_deadtime : in std_logic_vector(7 downto 0);

	si_std16_mod_index : in std_logic_vector(15 downto 0)

    );
    end component;

component command_shell is
    port(
	    core_clk : in std_logic;

	    po3_ad1_muxsel : out std_logic_vector(2 downto 0); 
	    po3_ad2_muxsel : out std_logic_vector(2 downto 0); 

	    po_uart_tx_serial : out std_logic;
	    pi_uart_rx_serial : in std_logic;

	    uart_rx_data : out unsigned(15 downto 0);
	    txmux : out std_logic_vector(3 downto 0);

	    si_uart_start_event	: in std_logic;
	    si16_uart_tx_data	: in std_logic_vector(15 downto 0);

	    so_tcmd_rx_cmd : out t_rx_commands
	);
end component;

    signal r_si_uart_start_event : std_logic; 	 
    signal r_si16_uart_tx_data : std_logic_vector(15 downto 0);

    signal r_so_ref_rdy : std_logic;
    signal r_so_s16_ref : std_logic_vector(15 downto 0);

    type t_catch_ref is (idle,catch, finish);

    signal dummy_dutymux2 : std_logic_vector(2 downto 0);


    signal r_so_std_ada_start : std_logic;
    signal r_so_std_adb_start : std_logic;

    signal r_si_spi_start : std_logic;
    signal r_s_spi_busy : std_logic;

    signal r_std16_spi_rx_ad1 : std_logic_vector(15 downto 0);
    signal r_std16_spi_rx_ad2 : std_logic_vector(15 downto 0);
    signal r_s_spi_busy_2 : std_logic;
    signal txmux : std_logic_vector(3 downto 0);
    signal dutymux : std_logic;
    signal uart_rx_data : unsigned(15 downto 0);

    signal r_so_pi_busy : std_logic;
    signal so_pi_out_rdy : std_logic;
    signal r_so_sign18_pi_out : signed(17 downto 0);
    signal r_si_sign18_ref : signed(17 downto 0);
    signal r_si_sign18_meas : signed(17 downto 0);

    signal dummy_dutymux : std_logic_vector(2 downto 0);

    signal std_ad1_spi_rdy : std_logic;

    signal current_ctrl_done : std_logic;
    signal r_sign18_current_ref : signed(17 downto 0);
    signal r_current_ctrl_rdy : std_logic;
    signal dummy_current_busy : std_logic;
    signal purkkaratkaisu : signed(17 downto 0);
	

begin

voltage_ctrl : seq_pi_control
    generic map(
		    gen_pi_sat_high => 9000,
		    gen_pi_sat_low => -9000,
		    gen_offset_sign18 => 34775,
		    gen_left_shift_p_gain => 1
		)
    port map(
	    pi_clk => dsp_clk,

	    
	    si_start => std_ad1_spi_rdy,
	    so_pi_busy => r_so_pi_busy,
	    so_pi_out_rdy => so_pi_out_rdy,

	    so_sign18_pi_out =>r_sign18_current_ref,

	    si_sign18_ref =>resize(shift_right(signed(r_so_s16_ref),0),18),
	    si_sign18_meas =>signed(resize(shift_left(unsigned(r_std16_spi_rx_ad2),4),18)),

	    si_sign18_p_gain => 18d"50000",
	    si_sign18_i_gain => 18d"1915"
	);
current_ctrl : seq_pi_control
    generic map(
		    gen_pi_sat_high => 32767,
		    gen_pi_sat_low => -32767,
		    gen_offset_sign18 => 32919,
		    gen_left_shift_p_gain => 2
		)
    port map(
	    pi_clk => dsp_clk,
	    
	    si_start => so_pi_out_rdy,
	    so_pi_busy => dummy_current_busy,
	    so_pi_out_rdy => current_ctrl_done,

	    so_sign18_pi_out =>  r_so_sign18_pi_out,

	    si_sign18_ref => r_sign18_current_ref,
	    si_sign18_meas =>signed(resize(shift_left(unsigned(r_std16_spi_rx_ad1),4),18)),

	    si_sign18_p_gain => 18d"14992",
	    si_sign18_i_gain => 18d"1363"
	);

-- r_std16_spi_rx_ad1 is unsigned number between 0 and 4095
r_si_sign18_meas <= signed(resize(shift_left(unsigned(r_std16_spi_rx_ad2),4),18));
	    
-- sine ranges from -32767 to 32767
r_si_sign18_ref <=  resize(signed(r_so_s16_ref(15 downto 1)),18);

ad1 : ext_ad_spi3w 
	port map( 
			si_spi_clk 	=> ext_ad_clk,  
			 
			-- physical signals to ext ad converter
			po_spi_cs => po_ad1_cs,
			po_spi_clk_out => po_ad1_clk,
			pi_spi_serial => pi_ad1_sdata,
 
			si_spi_start =>r_si_spi_start, 
			 
			-- ext spi control signals
			s_spi_busy	 => r_s_spi_busy,
			-- output signal indicating word is ready to be read 
			s_spi_rdy => std_ad1_spi_rdy,
			-- output buffer
			b_spi_rx => r_std16_spi_rx_ad1 
		);	

ad2 : ext_ad_spi3w 
	port map( 
			si_spi_clk 	=> ext_ad_clk,  
			 
			-- physical signals to ext ad converter
			po_spi_cs => po_ad2_cs,
			po_spi_clk_out => po_ad2_clk,
			pi_spi_serial => pi_ad2_sdata,
 
			si_spi_start =>r_si_spi_start, 
			 
			-- ext spi control signals
			s_spi_busy	 => r_s_spi_busy_2,
			-- output signal indicating word is ready to be read 
			s_spi_rdy => r_si_uart_start_event,
			-- output buffer
			b_spi_rx => r_std16_spi_rx_ad2 
		);	

rx_commands : command_shell	
    port map(
		core_clk => core_clk,
		
		po_uart_tx_serial => po_uart_tx,
		pi_uart_rx_serial => pi_uart_rx,

		po3_ad1_muxsel => dummy_dutymux2,
		po3_ad2_muxsel => dummy_dutymux, 

		uart_rx_data => uart_rx_data, 
		txmux =>txmux, 

		si_uart_start_event => r_so_std_ada_start,
		si16_uart_tx_data =>r_std16_spi_rx_ad1,
		
		so_tcmd_rx_cmd => so_tcmd_rx_cmd 
	    );
po3_ad2_muxsel <= "010";
po3_ad1_muxsel <= "110";
r_si16_uart_tx_data <=r_std16_spi_rx_ad1;

testijeejee : dummy_modulation 
    port map(
	    clk256mhz => core_clk ,
		dsp_clk => dsp_clk, 
	    rstn => '1',
		
		so_std_ada_start => r_so_std_ada_start, 
		so_std_adb_start => r_so_std_adb_start, 

	    po_hb1_hi_lo => po_hb1_hi_lo,
	    po_hb2_hi_lo => po_hb2_hi_lo, 

	    --si_std16_pwm_period_clks : in std_logic_vector(15 downto 0;
	    --si_std8_deadtime : in std_logic_vector(7 downto 0);

	    si_std16_mod_index => std_logic_vector(r_so_sign18_pi_out(15 downto 0))

	);

testref : ref_gen
    port map(
	    ref_clk => dsp_clk,
	    rstn => '1',
	    si_u12_cycletime => (others=>'0'),
	    so_ref_rdy => r_so_ref_rdy,
	    so_s16_ref => r_so_s16_ref
	);

    process(core_clk)
		variable ss_catch_ref : t_catch_ref;
		variable v_si_spi_start : std_logic;
		variable v_s_spi_busy : std_logic;
    begin
	if rising_edge(core_clk) then
	    CASE ss_catch_ref is
		WHEN idle =>
		    if r_so_std_ada_start = '1' then
				v_si_spi_start := '1';
				ss_catch_ref := catch;
		    else
				v_si_spi_start := '0';
				ss_catch_ref := idle;
		    end if;
		WHEN catch => 
			v_si_spi_start := '1';
			if v_s_spi_busy = '1' then
			    ss_catch_ref := idle;
			else
			    ss_catch_ref := catch;
			end if;
		WHEN others=> 
		    ss_catch_ref := idle;
	    end CASE;
	end if;
	r_si_spi_start <= v_si_spi_start;
	v_s_spi_busy := r_s_spi_busy;
    end process;

end rtl;
