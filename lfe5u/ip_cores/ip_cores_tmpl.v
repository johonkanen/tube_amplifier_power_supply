//Verilog instantiation template

ip_cores _inst (.main_pll_CLKI(), .main_pll_CLKOP(), .main_pll_CLKOS(), 
         .main_pll_LOCK(), .adc_clock_CLKI(), .adc_clock_CLKOP(), .adc_clock_LOCK(), 
         .multiplier_18x18_DataA(), .multiplier_18x18_DataB(), .multiplier_18x18_Result(), 
         .multiplier_18x18_Aclr(), .multiplier_18x18_ClkEn(), .multiplier_18x18_Clock());