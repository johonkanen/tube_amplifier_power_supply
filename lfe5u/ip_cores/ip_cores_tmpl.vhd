--VHDL instantiation template

component ip_cores is
    port (multiplier_18x18_DataA: in std_logic_vector(17 downto 0);
        multiplier_18x18_DataB: in std_logic_vector(17 downto 0);
        multiplier_18x18_Result: out std_logic_vector(35 downto 0);
        adc_clock_CLKI: in std_logic;
        adc_clock_CLKOP: out std_logic;
        adc_clock_LOCK: out std_logic;
        main_pll_CLKI: in std_logic;
        main_pll_CLKOP: out std_logic;
        main_pll_CLKOS: out std_logic;
        main_pll_LOCK: out std_logic;
        multiplier_18x18_Aclr: in std_logic;
        multiplier_18x18_ClkEn: in std_logic;
        multiplier_18x18_Clock: in std_logic
    );
    
end component ip_cores; -- sbp_module=true 
_inst: ip_cores port map (main_pll_CLKI => __,main_pll_CLKOP => __,main_pll_CLKOS => __,
            main_pll_LOCK => __,adc_clock_CLKI => __,adc_clock_CLKOP => __,
            adc_clock_LOCK => __,multiplier_18x18_DataA => __,multiplier_18x18_DataB => __,
            multiplier_18x18_Result => __,multiplier_18x18_Aclr => __,multiplier_18x18_ClkEn => __,
            multiplier_18x18_Clock => __);
