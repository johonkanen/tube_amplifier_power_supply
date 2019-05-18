-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "02/11/2019 18:38:19"
                                                            
-- Vhdl Test Bench template for design  :  top
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY top_vhd_tst IS
END top_vhd_tst;
ARCHITECTURE top_arch OF top_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL pi_ada_sdata : STD_LOGIC;
SIGNAL pi_adb_sdata : STD_LOGIC;
SIGNAL pi_ext_ad1_sdata : STD_LOGIC;
SIGNAL pi_ext_ad2_sdata : STD_LOGIC;
SIGNAL pi_uart_rx : STD_LOGIC;
SIGNAL po2_DHB_pri_pwm : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL po2_DHB_sec_pwm : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL po2_ht_pri_pwm : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL po2_ht_sec_pwm : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL po2_pfc_pwm : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL po3_ada_muxsel : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL po3_adb_muxsel : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL po3_led1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL po3_led2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL po3_led3 : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL po_ada_clk : STD_LOGIC;
SIGNAL po_ada_cs : STD_LOGIC;
SIGNAL po_adb_clk : STD_LOGIC;
SIGNAL po_adb_cs : STD_LOGIC;
SIGNAL po_aux_pwm : STD_LOGIC;
SIGNAL po_bypass_relay : STD_LOGIC;
SIGNAL po_ext_ad1_clk : STD_LOGIC;
SIGNAL po_ext_ad1_cs : STD_LOGIC;
SIGNAL po_ext_ad2_clk : STD_LOGIC;
SIGNAL po_ext_ad2_cs : STD_LOGIC;
SIGNAL po_testio_1 : STD_LOGIC;
SIGNAL po_testio_2 : STD_LOGIC;
SIGNAL po_uart_tx : STD_LOGIC;
SIGNAL xclk32mhz : STD_LOGIC;
COMPONENT top
	PORT (
	pi_ada_sdata : IN STD_LOGIC;
	pi_adb_sdata : IN STD_LOGIC;
	pi_ext_ad1_sdata : IN STD_LOGIC;
	pi_ext_ad2_sdata : IN STD_LOGIC;
	pi_uart_rx : IN STD_LOGIC;
	po2_DHB_pri_pwm : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
	po2_DHB_sec_pwm : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
	po2_ht_pri_pwm : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
	po2_ht_sec_pwm : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
	po2_pfc_pwm : BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
	po3_ada_muxsel : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0);
	po3_adb_muxsel : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0);
	po3_led1 : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0);
	po3_led2 : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0);
	po3_led3 : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0);
	po_ada_clk : BUFFER STD_LOGIC;
	po_ada_cs : BUFFER STD_LOGIC;
	po_adb_clk : BUFFER STD_LOGIC;
	po_adb_cs : BUFFER STD_LOGIC;
	po_aux_pwm : BUFFER STD_LOGIC;
	po_bypass_relay : BUFFER STD_LOGIC;
	po_ext_ad1_clk : BUFFER STD_LOGIC;
	po_ext_ad1_cs : BUFFER STD_LOGIC;
	po_ext_ad2_clk : BUFFER STD_LOGIC;
	po_ext_ad2_cs : BUFFER STD_LOGIC;
	po_testio_1 : BUFFER STD_LOGIC;
	po_testio_2 : BUFFER STD_LOGIC;
	po_uart_tx : BUFFER STD_LOGIC;
	xclk32mhz : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : top
	PORT MAP (
-- list connections between master ports and signals
	pi_ada_sdata => pi_ada_sdata,
	pi_adb_sdata => pi_adb_sdata,
	pi_ext_ad1_sdata => pi_ext_ad1_sdata,
	pi_ext_ad2_sdata => pi_ext_ad2_sdata,
	pi_uart_rx => pi_uart_rx,
	po2_DHB_pri_pwm => po2_DHB_pri_pwm,
	po2_DHB_sec_pwm => po2_DHB_sec_pwm,
	po2_ht_pri_pwm => po2_ht_pri_pwm,
	po2_ht_sec_pwm => po2_ht_sec_pwm,
	po2_pfc_pwm => po2_pfc_pwm,
	po3_ada_muxsel => po3_ada_muxsel,
	po3_adb_muxsel => po3_adb_muxsel,
	po3_led1 => po3_led1,
	po3_led2 => po3_led2,
	po3_led3 => po3_led3,
	po_ada_clk => po_ada_clk,
	po_ada_cs => po_ada_cs,
	po_adb_clk => po_adb_clk,
	po_adb_cs => po_adb_cs,
	po_aux_pwm => po_aux_pwm,
	po_bypass_relay => po_bypass_relay,
	po_ext_ad1_clk => po_ext_ad1_clk,
	po_ext_ad1_cs => po_ext_ad1_cs,
	po_ext_ad2_clk => po_ext_ad2_clk,
	po_ext_ad2_cs => po_ext_ad2_cs,
	po_testio_1 => po_testio_1,
	po_testio_2 => po_testio_2,
	po_uart_tx => po_uart_tx,
	xclk32mhz => xclk32mhz
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END top_arch;
