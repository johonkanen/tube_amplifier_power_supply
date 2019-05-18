// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.10.3.144
// Netlist written on Sat May 18 23:33:29 2019
//
// Verilog Description of module main_pll
//

module main_pll (CLKI, CLKOP, CLKOS, CLKOS2, LOCK) /* synthesis NGD_DRC_MASK=1 */ ;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(12[8:16])
    input CLKI;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(14[9:13])
    output CLKOP;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(15[9:14])
    output CLKOS;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(16[9:14])
    output CLKOS2;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(17[9:15])
    output LOCK;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(18[9:13])
    
    wire CLKI /* synthesis is_clock=1 */ ;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(14[9:13])
    wire CLKOP /* synthesis is_clock=1 */ ;   // c:/users/jari/mycodeprojects/tube_psu/lfe5u/ecp5u_specifics/ecp5_ip_components/main_pll/main_pll.vhd(15[9:14])
    
    wire scuba_vlo, VCC_net;
    
    VLO scuba_vlo_inst (.Z(scuba_vlo));
    EHXPLLL PLLInst_0 (.CLKI(CLKI), .CLKFB(CLKOP), .PHASESEL0(scuba_vlo), 
            .PHASESEL1(scuba_vlo), .PHASEDIR(scuba_vlo), .PHASESTEP(scuba_vlo), 
            .PHASELOADREG(scuba_vlo), .STDBY(scuba_vlo), .PLLWAKESYNC(scuba_vlo), 
            .RST(scuba_vlo), .ENCLKOP(scuba_vlo), .ENCLKOS(scuba_vlo), 
            .ENCLKOS2(scuba_vlo), .ENCLKOS3(scuba_vlo), .CLKOP(CLKOP), 
            .CLKOS(CLKOS), .CLKOS2(CLKOS2), .LOCK(LOCK)) /* synthesis syn_black_box=true, FREQUENCY_PIN_CLKOS2="240.000000", FREQUENCY_PIN_CLKOS="120.000000", FREQUENCY_PIN_CLKOP="240.000000", FREQUENCY_PIN_CLKI="50.000000", ICP_CURRENT="6", LPF_RESISTOR="16", syn_instantiated=1 */ ;
    defparam PLLInst_0.CLKI_DIV = 5;
    defparam PLLInst_0.CLKFB_DIV = 24;
    defparam PLLInst_0.CLKOP_DIV = 3;
    defparam PLLInst_0.CLKOS_DIV = 6;
    defparam PLLInst_0.CLKOS2_DIV = 3;
    defparam PLLInst_0.CLKOS3_DIV = 1;
    defparam PLLInst_0.CLKOP_ENABLE = "ENABLED";
    defparam PLLInst_0.CLKOS_ENABLE = "ENABLED";
    defparam PLLInst_0.CLKOS2_ENABLE = "ENABLED";
    defparam PLLInst_0.CLKOS3_ENABLE = "DISABLED";
    defparam PLLInst_0.CLKOP_CPHASE = 2;
    defparam PLLInst_0.CLKOS_CPHASE = 5;
    defparam PLLInst_0.CLKOS2_CPHASE = 2;
    defparam PLLInst_0.CLKOS3_CPHASE = 0;
    defparam PLLInst_0.CLKOP_FPHASE = 0;
    defparam PLLInst_0.CLKOS_FPHASE = 0;
    defparam PLLInst_0.CLKOS2_FPHASE = 0;
    defparam PLLInst_0.CLKOS3_FPHASE = 0;
    defparam PLLInst_0.FEEDBK_PATH = "CLKOP";
    defparam PLLInst_0.CLKOP_TRIM_POL = "FALLING";
    defparam PLLInst_0.CLKOP_TRIM_DELAY = 0;
    defparam PLLInst_0.CLKOS_TRIM_POL = "FALLING";
    defparam PLLInst_0.CLKOS_TRIM_DELAY = 0;
    defparam PLLInst_0.OUTDIVIDER_MUXA = "DIVA";
    defparam PLLInst_0.OUTDIVIDER_MUXB = "DIVB";
    defparam PLLInst_0.OUTDIVIDER_MUXC = "DIVC";
    defparam PLLInst_0.OUTDIVIDER_MUXD = "DIVD";
    defparam PLLInst_0.PLL_LOCK_MODE = 0;
    defparam PLLInst_0.PLL_LOCK_DELAY = 200;
    defparam PLLInst_0.STDBY_ENABLE = "DISABLED";
    defparam PLLInst_0.REFIN_RESET = "DISABLED";
    defparam PLLInst_0.SYNC_ENABLE = "DISABLED";
    defparam PLLInst_0.INT_LOCK_STICKY = "ENABLED";
    defparam PLLInst_0.DPHASE_SOURCE = "DISABLED";
    defparam PLLInst_0.PLLRST_ENA = "DISABLED";
    defparam PLLInst_0.INTFB_WAKE = "DISABLED";
    GSR GSR_INST (.GSR(VCC_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    VHI i86 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

