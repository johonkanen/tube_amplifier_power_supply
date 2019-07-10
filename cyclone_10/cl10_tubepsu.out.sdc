## Generated SDC file "cl10_tubepsu.out.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Wed Jul 10 14:34:15 2019"

##
## DEVICE  "10CL010YU256I7G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {xclk32mhz} -period 31.250 -waveform { 0.000 15.625 } [get_ports {xclk32mhz}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {core_clocks|core_clocks|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 8 -master_clock {xclk32mhz} [get_pins {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {core_clocks|core_clocks|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 4 -master_clock {xclk32mhz} [get_pins {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {core_clocks|core_clocks|altpll_component|auto_generated|pll1|clk[1]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

