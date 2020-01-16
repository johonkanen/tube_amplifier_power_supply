--VHDL instantiation template

component ip_cores is
    port (adc_clock_CLKI: in std_logic;
        adc_clock_CLKOP: out std_logic;
        adc_clock_LOCK: out std_logic;
        main_pll_CLKI: in std_logic;
        main_pll_CLKOP: out std_logic;
        main_pll_CLKOS: out std_logic;
        main_pll_LOCK: out std_logic
    );
    
end component ip_cores; -- sbp_module=true 
_inst: ip_cores port map (main_pll_CLKI => __,main_pll_CLKOP => __,main_pll_CLKOS => __,
            main_pll_LOCK => __,adc_clock_CLKI => __,adc_clock_CLKOP => __,
            adc_clock_LOCK => __);
