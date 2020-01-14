


--
-- Verific VHDL Description of module ip_cores
--

library ieee ;
use ieee.std_logic_1164.all ;

entity ip_cores is
    port (adc_clock_CLKI: in std_logic;
        adc_clock_CLKOP: out std_logic;
        adc_clock_LOCK: out std_logic;
        main_pll_CLKI: in std_logic;
        main_pll_CLKOP: out std_logic;
        main_pll_CLKOS: out std_logic;
        main_pll_LOCK: out std_logic
    );
    
end entity ip_cores; -- sbp_module=true 

architecture ip_cores of ip_cores is 
    component adc_clock is
        port (CLKI: in std_logic;
            CLKOP: out std_logic;
            LOCK: out std_logic
        );
        
    end component adc_clock; -- not_need_bbox=true 
    
    
    component main_pll is
        port (CLKI: in std_logic;
            CLKOP: out std_logic;
            CLKOS: out std_logic;
            LOCK: out std_logic
        );
        
    end component main_pll; -- not_need_bbox=true 
    
    
    
begin
    adc_clock_inst: component adc_clock port map (CLKI=>adc_clock_CLKI,CLKOP=>adc_clock_CLKOP,
            LOCK=>adc_clock_LOCK);
    main_pll_inst: component main_pll port map (CLKI=>main_pll_CLKI,CLKOP=>main_pll_CLKOP,
            CLKOS=>main_pll_CLKOS,LOCK=>main_pll_LOCK);
    
end architecture ip_cores; -- sbp_module=true 

