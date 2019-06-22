// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun 22 21:35:56 2019
// Host        : Jari-Pelikone running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force ./output/cpu_impl_netlist.v -mode timesim -sdf_anno true
// Design      : top
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7s15ftgb196-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module UART_RX
   (r_RX_busy_reg_0,
    \FSM_onehot_rx_next_state_reg[0] ,
    \FSM_onehot_rx_next_state_reg[0]_0 ,
    \FSM_onehot_rx_next_state_reg[0]_1 ,
    D,
    pi_uart_rx,
    clk_out1,
    \FSM_onehot_rx_next_state_reg[2] ,
    \FSM_onehot_rx_next_state_reg[2]_0 ,
    \FSM_onehot_rx_next_state_reg[2]_1 ,
    route_RX_data_out);
  output r_RX_busy_reg_0;
  output \FSM_onehot_rx_next_state_reg[0] ;
  output \FSM_onehot_rx_next_state_reg[0]_0 ;
  output \FSM_onehot_rx_next_state_reg[0]_1 ;
  output [7:0]D;
  input pi_uart_rx;
  input clk_out1;
  input \FSM_onehot_rx_next_state_reg[2] ;
  input \FSM_onehot_rx_next_state_reg[2]_0 ;
  input \FSM_onehot_rx_next_state_reg[2]_1 ;
  input route_RX_data_out;

  wire [7:0]D;
  wire \FSM_onehot_rx_next_state_reg[0] ;
  wire \FSM_onehot_rx_next_state_reg[0]_0 ;
  wire \FSM_onehot_rx_next_state_reg[0]_1 ;
  wire \FSM_onehot_rx_next_state_reg[2] ;
  wire \FSM_onehot_rx_next_state_reg[2]_0 ;
  wire \FSM_onehot_rx_next_state_reg[2]_1 ;
  wire clk_out1;
  wire pi_uart_rx;
  wire \r_Bit_Index[0]_i_1_n_0 ;
  wire \r_Bit_Index[1]_i_1_n_0 ;
  wire \r_Bit_Index[2]_i_1_n_0 ;
  wire \r_Bit_Index[2]_i_2__0_n_0 ;
  wire \r_Bit_Index[2]_i_3_n_0 ;
  wire \r_Bit_Index_reg_n_0_[0] ;
  wire \r_Bit_Index_reg_n_0_[1] ;
  wire \r_Bit_Index_reg_n_0_[2] ;
  wire \r_Clk_Count[0]_i_1__0_n_0 ;
  wire \r_Clk_Count[1]_i_1_n_0 ;
  wire \r_Clk_Count[2]_i_1__0_n_0 ;
  wire \r_Clk_Count[3]_i_1_n_0 ;
  wire \r_Clk_Count[3]_i_2_n_0 ;
  wire \r_Clk_Count[3]_i_3_n_0 ;
  wire \r_Clk_Count[3]_i_4_n_0 ;
  wire \r_Clk_Count[4]_i_1__0_n_0 ;
  wire \r_Clk_Count[5]_i_1__0_n_0 ;
  wire \r_Clk_Count[5]_i_2__0_n_0 ;
  wire [5:0]r_Clk_Count_0;
  wire \r_RX_Byte[0]_i_1_n_0 ;
  wire \r_RX_Byte[1]_i_1_n_0 ;
  wire \r_RX_Byte[2]_i_1_n_0 ;
  wire \r_RX_Byte[3]_i_1_n_0 ;
  wire \r_RX_Byte[4]_i_1_n_0 ;
  wire \r_RX_Byte[5]_i_1_n_0 ;
  wire \r_RX_Byte[6]_i_1_n_0 ;
  wire \r_RX_Byte[7]_i_1_n_0 ;
  wire r_RX_Data;
  wire r_RX_Data_R;
  wire r_RX_busy_i_1_n_0;
  wire r_RX_busy_reg_0;
  wire [0:0]r_SM_Main;
  wire \r_SM_Main[0]_i_1_n_0 ;
  wire \r_SM_Main[0]_i_2_n_0 ;
  wire \r_SM_Main[0]_i_3_n_0 ;
  wire \r_SM_Main[1]_i_1_n_0 ;
  wire \r_SM_Main[2]_i_1_n_0 ;
  wire \r_SM_Main[2]_i_2_n_0 ;
  wire \r_SM_Main_reg_n_0_[0] ;
  wire \r_SM_Main_reg_n_0_[1] ;
  wire \r_SM_Main_reg_n_0_[2] ;
  wire route_RX_data_out;

  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT5 #(
    .INIT(32'hAAAAAEEE)) 
    \FSM_onehot_rx_next_state[1]_i_1 
       (.I0(\FSM_onehot_rx_next_state_reg[2] ),
        .I1(\FSM_onehot_rx_next_state_reg[2]_1 ),
        .I2(\FSM_onehot_rx_next_state_reg[2]_0 ),
        .I3(r_RX_busy_reg_0),
        .I4(route_RX_data_out),
        .O(\FSM_onehot_rx_next_state_reg[0]_1 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT5 #(
    .INIT(32'hCCCCC888)) 
    \FSM_onehot_rx_next_state[2]_i_1 
       (.I0(\FSM_onehot_rx_next_state_reg[2] ),
        .I1(\FSM_onehot_rx_next_state_reg[2]_1 ),
        .I2(\FSM_onehot_rx_next_state_reg[2]_0 ),
        .I3(r_RX_busy_reg_0),
        .I4(route_RX_data_out),
        .O(\FSM_onehot_rx_next_state_reg[0]_0 ));
  LUT4 #(
    .INIT(16'hDC50)) 
    j_i_1
       (.I0(\FSM_onehot_rx_next_state_reg[2] ),
        .I1(r_RX_busy_reg_0),
        .I2(\FSM_onehot_rx_next_state_reg[2]_0 ),
        .I3(\FSM_onehot_rx_next_state_reg[2]_1 ),
        .O(\FSM_onehot_rx_next_state_reg[0] ));
  LUT6 #(
    .INIT(64'h2626262626262600)) 
    \r_Bit_Index[0]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[0] ),
        .I1(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I2(\r_SM_Main[0]_i_2_n_0 ),
        .I3(\r_SM_Main_reg_n_0_[2] ),
        .I4(\r_SM_Main_reg_n_0_[0] ),
        .I5(\r_SM_Main_reg_n_0_[1] ),
        .O(\r_Bit_Index[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6A6A6A00)) 
    \r_Bit_Index[1]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[1] ),
        .I1(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_SM_Main_reg_n_0_[2] ),
        .I4(\r_Bit_Index[2]_i_3_n_0 ),
        .O(\r_Bit_Index[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAA6AAA6AAA0000)) 
    \r_Bit_Index[2]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[2] ),
        .I1(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_Bit_Index_reg_n_0_[1] ),
        .I4(\r_SM_Main_reg_n_0_[2] ),
        .I5(\r_Bit_Index[2]_i_3_n_0 ),
        .O(\r_Bit_Index[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \r_Bit_Index[2]_i_2__0 
       (.I0(\r_SM_Main[2]_i_2_n_0 ),
        .I1(\r_SM_Main_reg_n_0_[1] ),
        .I2(\r_SM_Main_reg_n_0_[2] ),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_Bit_Index[2]_i_2__0_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \r_Bit_Index[2]_i_3 
       (.I0(\r_SM_Main_reg_n_0_[0] ),
        .I1(\r_SM_Main_reg_n_0_[1] ),
        .O(\r_Bit_Index[2]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Bit_Index[0]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Bit_Index[1]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Bit_Index[2]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[2] ),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    \r_Clk_Count[0]_i_1__0 
       (.I0(\r_Clk_Count[3]_i_3_n_0 ),
        .I1(r_Clk_Count_0[0]),
        .O(\r_Clk_Count[0]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'hAEFFEA00)) 
    \r_Clk_Count[1]_i_1 
       (.I0(\r_Clk_Count[3]_i_2_n_0 ),
        .I1(\r_Clk_Count[3]_i_3_n_0 ),
        .I2(r_Clk_Count_0[0]),
        .I3(\r_Clk_Count[5]_i_1__0_n_0 ),
        .I4(r_Clk_Count_0[1]),
        .O(\r_Clk_Count[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2888)) 
    \r_Clk_Count[2]_i_1__0 
       (.I0(\r_Clk_Count[3]_i_3_n_0 ),
        .I1(r_Clk_Count_0[2]),
        .I2(r_Clk_Count_0[1]),
        .I3(r_Clk_Count_0[0]),
        .O(\r_Clk_Count[2]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'hAEFFEA00)) 
    \r_Clk_Count[3]_i_1 
       (.I0(\r_Clk_Count[3]_i_2_n_0 ),
        .I1(\r_Clk_Count[3]_i_3_n_0 ),
        .I2(\r_Clk_Count[3]_i_4_n_0 ),
        .I3(\r_Clk_Count[5]_i_1__0_n_0 ),
        .I4(r_Clk_Count_0[3]),
        .O(\r_Clk_Count[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0020)) 
    \r_Clk_Count[3]_i_2 
       (.I0(r_RX_Data),
        .I1(r_SM_Main),
        .I2(\r_SM_Main_reg_n_0_[0] ),
        .I3(\r_SM_Main_reg_n_0_[1] ),
        .O(\r_Clk_Count[3]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hCAC0)) 
    \r_Clk_Count[3]_i_3 
       (.I0(r_SM_Main),
        .I1(\r_SM_Main[2]_i_2_n_0 ),
        .I2(\r_SM_Main_reg_n_0_[1] ),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_Clk_Count[3]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \r_Clk_Count[3]_i_4 
       (.I0(r_Clk_Count_0[2]),
        .I1(r_Clk_Count_0[0]),
        .I2(r_Clk_Count_0[1]),
        .O(\r_Clk_Count[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h2888888888888888)) 
    \r_Clk_Count[4]_i_1__0 
       (.I0(\r_Clk_Count[3]_i_3_n_0 ),
        .I1(r_Clk_Count_0[4]),
        .I2(r_Clk_Count_0[1]),
        .I3(r_Clk_Count_0[0]),
        .I4(r_Clk_Count_0[2]),
        .I5(r_Clk_Count_0[3]),
        .O(\r_Clk_Count[4]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'h0F0B0F0F)) 
    \r_Clk_Count[5]_i_1__0 
       (.I0(\r_SM_Main_reg_n_0_[1] ),
        .I1(r_RX_Data),
        .I2(\r_SM_Main_reg_n_0_[2] ),
        .I3(r_SM_Main),
        .I4(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_Clk_Count[5]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'h2A80AA00)) 
    \r_Clk_Count[5]_i_2__0 
       (.I0(\r_Clk_Count[3]_i_3_n_0 ),
        .I1(r_Clk_Count_0[3]),
        .I2(r_Clk_Count_0[4]),
        .I3(r_Clk_Count_0[5]),
        .I4(\r_Clk_Count[3]_i_4_n_0 ),
        .O(\r_Clk_Count[5]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    \r_Clk_Count[5]_i_3__0 
       (.I0(r_Clk_Count_0[1]),
        .I1(r_Clk_Count_0[0]),
        .I2(r_Clk_Count_0[2]),
        .I3(r_Clk_Count_0[5]),
        .I4(r_Clk_Count_0[4]),
        .I5(r_Clk_Count_0[3]),
        .O(r_SM_Main));
  FDRE \r_Clk_Count_reg[0] 
       (.C(clk_out1),
        .CE(\r_Clk_Count[5]_i_1__0_n_0 ),
        .D(\r_Clk_Count[0]_i_1__0_n_0 ),
        .Q(r_Clk_Count_0[0]),
        .R(1'b0));
  FDRE \r_Clk_Count_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Clk_Count[1]_i_1_n_0 ),
        .Q(r_Clk_Count_0[1]),
        .R(1'b0));
  FDRE \r_Clk_Count_reg[2] 
       (.C(clk_out1),
        .CE(\r_Clk_Count[5]_i_1__0_n_0 ),
        .D(\r_Clk_Count[2]_i_1__0_n_0 ),
        .Q(r_Clk_Count_0[2]),
        .R(1'b0));
  FDRE \r_Clk_Count_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Clk_Count[3]_i_1_n_0 ),
        .Q(r_Clk_Count_0[3]),
        .R(1'b0));
  FDRE \r_Clk_Count_reg[4] 
       (.C(clk_out1),
        .CE(\r_Clk_Count[5]_i_1__0_n_0 ),
        .D(\r_Clk_Count[4]_i_1__0_n_0 ),
        .Q(r_Clk_Count_0[4]),
        .R(1'b0));
  FDRE \r_Clk_Count_reg[5] 
       (.C(clk_out1),
        .CE(\r_Clk_Count[5]_i_1__0_n_0 ),
        .D(\r_Clk_Count[5]_i_2__0_n_0 ),
        .Q(r_Clk_Count_0[5]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFEFFFF00020000)) 
    \r_RX_Byte[0]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[2] ),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(\r_Bit_Index_reg_n_0_[0] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[0]),
        .O(\r_RX_Byte[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \r_RX_Byte[1]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[0] ),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(\r_Bit_Index_reg_n_0_[2] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[1]),
        .O(\r_RX_Byte[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \r_RX_Byte[2]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[2] ),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(\r_Bit_Index_reg_n_0_[0] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[2]),
        .O(\r_RX_Byte[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \r_RX_Byte[3]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[2] ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_Bit_Index_reg_n_0_[1] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[3]),
        .O(\r_RX_Byte[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \r_RX_Byte[4]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(\r_Bit_Index_reg_n_0_[2] ),
        .I3(\r_Bit_Index_reg_n_0_[0] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[4]),
        .O(\r_RX_Byte[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \r_RX_Byte[5]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[0] ),
        .I2(\r_Bit_Index_reg_n_0_[2] ),
        .I3(\r_Bit_Index_reg_n_0_[1] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[5]),
        .O(\r_RX_Byte[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \r_RX_Byte[6]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[2] ),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(\r_Bit_Index_reg_n_0_[0] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[6]),
        .O(\r_RX_Byte[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFF80000000)) 
    \r_RX_Byte[7]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_Bit_Index_reg_n_0_[0] ),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(\r_Bit_Index_reg_n_0_[2] ),
        .I4(\r_Bit_Index[2]_i_2__0_n_0 ),
        .I5(D[7]),
        .O(\r_RX_Byte[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[0]_i_1_n_0 ),
        .Q(D[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[1]_i_1_n_0 ),
        .Q(D[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[2]_i_1_n_0 ),
        .Q(D[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[3]_i_1_n_0 ),
        .Q(D[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[4]_i_1_n_0 ),
        .Q(D[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[5]_i_1_n_0 ),
        .Q(D[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[6]_i_1_n_0 ),
        .Q(D[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_RX_Byte_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_RX_Byte[7]_i_1_n_0 ),
        .Q(D[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    r_RX_Data_R_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(pi_uart_rx),
        .Q(r_RX_Data_R),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    r_RX_Data_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_RX_Data_R),
        .Q(r_RX_Data),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFF01000)) 
    r_RX_busy_i_1
       (.I0(\r_SM_Main_reg_n_0_[2] ),
        .I1(\r_SM_Main[2]_i_2_n_0 ),
        .I2(\r_SM_Main_reg_n_0_[1] ),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .I4(r_RX_busy_reg_0),
        .O(r_RX_busy_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    r_RX_busy_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_RX_busy_i_1_n_0),
        .Q(r_RX_busy_reg_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFF20102000)) 
    \r_SM_Main[0]_i_1 
       (.I0(\r_SM_Main_reg_n_0_[0] ),
        .I1(\r_SM_Main_reg_n_0_[2] ),
        .I2(\r_SM_Main_reg_n_0_[1] ),
        .I3(\r_SM_Main[2]_i_2_n_0 ),
        .I4(\r_SM_Main[0]_i_2_n_0 ),
        .I5(\r_SM_Main[0]_i_3_n_0 ),
        .O(\r_SM_Main[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \r_SM_Main[0]_i_2 
       (.I0(\r_Bit_Index_reg_n_0_[2] ),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .O(\r_SM_Main[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0008000B)) 
    \r_SM_Main[0]_i_3 
       (.I0(r_SM_Main),
        .I1(\r_SM_Main_reg_n_0_[0] ),
        .I2(\r_SM_Main_reg_n_0_[1] ),
        .I3(\r_SM_Main_reg_n_0_[2] ),
        .I4(r_RX_Data),
        .O(\r_SM_Main[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FF330404)) 
    \r_SM_Main[1]_i_1 
       (.I0(r_RX_Data),
        .I1(\r_SM_Main_reg_n_0_[0] ),
        .I2(r_SM_Main),
        .I3(\r_SM_Main[2]_i_2_n_0 ),
        .I4(\r_SM_Main_reg_n_0_[1] ),
        .I5(\r_SM_Main_reg_n_0_[2] ),
        .O(\r_SM_Main[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0400)) 
    \r_SM_Main[2]_i_1 
       (.I0(\r_SM_Main[2]_i_2_n_0 ),
        .I1(\r_SM_Main_reg_n_0_[1] ),
        .I2(\r_SM_Main_reg_n_0_[2] ),
        .I3(\r_SM_Main_reg_n_0_[0] ),
        .O(\r_SM_Main[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h777777777777777F)) 
    \r_SM_Main[2]_i_2 
       (.I0(r_Clk_Count_0[5]),
        .I1(r_Clk_Count_0[4]),
        .I2(r_Clk_Count_0[3]),
        .I3(r_Clk_Count_0[2]),
        .I4(r_Clk_Count_0[0]),
        .I5(r_Clk_Count_0[1]),
        .O(\r_SM_Main[2]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_SM_Main_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_SM_Main[0]_i_1_n_0 ),
        .Q(\r_SM_Main_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_SM_Main_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_SM_Main[1]_i_1_n_0 ),
        .Q(\r_SM_Main_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_SM_Main_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_SM_Main[2]_i_1_n_0 ),
        .Q(\r_SM_Main_reg_n_0_[2] ),
        .R(1'b0));
endmodule

module UART_TX
   (po_uart_tx,
    route_uart_tx_done,
    \FSM_onehot_next_state_reg[3] ,
    clk_out1,
    tx_start_reg,
    Q,
    \r_TX_Data_reg[7]_0 );
  output po_uart_tx;
  output route_uart_tx_done;
  output \FSM_onehot_next_state_reg[3] ;
  input clk_out1;
  input tx_start_reg;
  input [3:0]Q;
  input [7:0]\r_TX_Data_reg[7]_0 ;

  wire \FSM_onehot_next_state_reg[3] ;
  wire \FSM_sequential_r_SM_Main[0]_i_1_n_0 ;
  wire \FSM_sequential_r_SM_Main[0]_i_2_n_0 ;
  wire \FSM_sequential_r_SM_Main[0]_i_3_n_0 ;
  wire \FSM_sequential_r_SM_Main[0]_i_4_n_0 ;
  wire \FSM_sequential_r_SM_Main[1]_i_1_n_0 ;
  wire \FSM_sequential_r_SM_Main[2]_i_1_n_0 ;
  wire \FSM_sequential_r_SM_Main[2]_i_2_n_0 ;
  wire [3:0]Q;
  wire clk_out1;
  wire po_uart_tx;
  wire \r_Bit_Index[0]_i_1_n_0 ;
  wire \r_Bit_Index[1]_i_1_n_0 ;
  wire \r_Bit_Index[2]_i_1_n_0 ;
  wire \r_Bit_Index[2]_i_2_n_0 ;
  wire \r_Bit_Index_reg_n_0_[0] ;
  wire \r_Bit_Index_reg_n_0_[1] ;
  wire \r_Bit_Index_reg_n_0_[2] ;
  wire [5:0]r_Clk_Count;
  wire r_Clk_Count0;
  wire r_Clk_Count_1;
  wire [5:0]r_Clk_Count_reg;
  wire [2:0]r_SM_Main;
  wire [7:0]r_TX_Data;
  wire r_TX_Data_0;
  wire [7:0]\r_TX_Data_reg[7]_0 ;
  wire r_TX_Done_i_1_n_0;
  wire route_TX_Serial;
  wire route_TX_Serial_i_2_n_0;
  wire route_TX_Serial_i_3_n_0;
  wire route_TX_Serial_i_4_n_0;
  wire route_TX_Serial_i_5_n_0;
  wire route_TX_Serial_i_6_n_0;
  wire route_TX_Serial_i_7_n_0;
  wire route_uart_tx_done;
  wire tx_start_reg;

  LUT6 #(
    .INIT(64'hFFFFFFFFAA30AA00)) 
    \FSM_sequential_r_SM_Main[0]_i_1 
       (.I0(\FSM_sequential_r_SM_Main[0]_i_2_n_0 ),
        .I1(\FSM_sequential_r_SM_Main[0]_i_3_n_0 ),
        .I2(\FSM_sequential_r_SM_Main[0]_i_4_n_0 ),
        .I3(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ),
        .I4(r_SM_Main[1]),
        .I5(r_TX_Data_0),
        .O(\FSM_sequential_r_SM_Main[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_r_SM_Main[0]_i_2 
       (.I0(r_SM_Main[0]),
        .I1(r_SM_Main[2]),
        .O(\FSM_sequential_r_SM_Main[0]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \FSM_sequential_r_SM_Main[0]_i_3 
       (.I0(\r_Bit_Index_reg_n_0_[0] ),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .O(\FSM_sequential_r_SM_Main[0]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \FSM_sequential_r_SM_Main[0]_i_4 
       (.I0(r_SM_Main[2]),
        .I1(r_SM_Main[0]),
        .I2(\r_Bit_Index_reg_n_0_[2] ),
        .O(\FSM_sequential_r_SM_Main[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT4 #(
    .INIT(16'h00D2)) 
    \FSM_sequential_r_SM_Main[1]_i_1 
       (.I0(r_SM_Main[0]),
        .I1(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ),
        .I2(r_SM_Main[1]),
        .I3(r_SM_Main[2]),
        .O(\FSM_sequential_r_SM_Main[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \FSM_sequential_r_SM_Main[2]_i_1 
       (.I0(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ),
        .I1(r_SM_Main[1]),
        .I2(r_SM_Main[2]),
        .I3(r_SM_Main[0]),
        .O(\FSM_sequential_r_SM_Main[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h777777777777777F)) 
    \FSM_sequential_r_SM_Main[2]_i_2 
       (.I0(r_Clk_Count_reg[5]),
        .I1(r_Clk_Count_reg[4]),
        .I2(r_Clk_Count_reg[2]),
        .I3(r_Clk_Count_reg[3]),
        .I4(r_Clk_Count_reg[0]),
        .I5(r_Clk_Count_reg[1]),
        .O(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "s_idle:000,s_tx_start_bit:001,s_tx_data_bits:010,s_cleanup:100,s_tx_stop_bit:011" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_r_SM_Main_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_sequential_r_SM_Main[0]_i_1_n_0 ),
        .Q(r_SM_Main[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "s_idle:000,s_tx_start_bit:001,s_tx_data_bits:010,s_cleanup:100,s_tx_stop_bit:011" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_r_SM_Main_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_sequential_r_SM_Main[1]_i_1_n_0 ),
        .Q(r_SM_Main[1]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "s_idle:000,s_tx_start_bit:001,s_tx_data_bits:010,s_cleanup:100,s_tx_stop_bit:011" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_r_SM_Main_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_sequential_r_SM_Main[2]_i_1_n_0 ),
        .Q(r_SM_Main[2]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT5 #(
    .INIT(32'hAAAAAA90)) 
    \r_Bit_Index[0]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[0] ),
        .I1(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ),
        .I2(r_SM_Main[1]),
        .I3(r_SM_Main[0]),
        .I4(r_SM_Main[2]),
        .O(\r_Bit_Index[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h9A00AAAA)) 
    \r_Bit_Index[1]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[1] ),
        .I1(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(r_SM_Main[1]),
        .I4(\r_Bit_Index[2]_i_2_n_0 ),
        .O(\r_Bit_Index[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9AAA0000AAAAAAAA)) 
    \r_Bit_Index[2]_i_1 
       (.I0(\r_Bit_Index_reg_n_0_[2] ),
        .I1(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[0] ),
        .I3(\r_Bit_Index_reg_n_0_[1] ),
        .I4(r_SM_Main[1]),
        .I5(\r_Bit_Index[2]_i_2_n_0 ),
        .O(\r_Bit_Index[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r_Bit_Index[2]_i_2 
       (.I0(r_SM_Main[0]),
        .I1(r_SM_Main[2]),
        .O(\r_Bit_Index[2]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Bit_Index[0]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Bit_Index[1]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_Bit_Index_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_Bit_Index[2]_i_1_n_0 ),
        .Q(\r_Bit_Index_reg_n_0_[2] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h000077770000777F)) 
    \r_Clk_Count[0]_i_1 
       (.I0(r_Clk_Count_reg[4]),
        .I1(r_Clk_Count_reg[5]),
        .I2(r_Clk_Count_reg[2]),
        .I3(r_Clk_Count_reg[3]),
        .I4(r_Clk_Count_reg[0]),
        .I5(r_Clk_Count_reg[1]),
        .O(r_Clk_Count[0]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT4 #(
    .INIT(16'h0770)) 
    \r_Clk_Count[1]_i_1 
       (.I0(r_Clk_Count_reg[4]),
        .I1(r_Clk_Count_reg[5]),
        .I2(r_Clk_Count_reg[0]),
        .I3(r_Clk_Count_reg[1]),
        .O(r_Clk_Count[1]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT5 #(
    .INIT(32'h07777000)) 
    \r_Clk_Count[2]_i_1 
       (.I0(r_Clk_Count_reg[4]),
        .I1(r_Clk_Count_reg[5]),
        .I2(r_Clk_Count_reg[1]),
        .I3(r_Clk_Count_reg[0]),
        .I4(r_Clk_Count_reg[2]),
        .O(r_Clk_Count[2]));
  LUT6 #(
    .INIT(64'h007F7F7F00808080)) 
    \r_Clk_Count[3]_i_1 
       (.I0(r_Clk_Count_reg[1]),
        .I1(r_Clk_Count_reg[0]),
        .I2(r_Clk_Count_reg[2]),
        .I3(r_Clk_Count_reg[5]),
        .I4(r_Clk_Count_reg[4]),
        .I5(r_Clk_Count_reg[3]),
        .O(r_Clk_Count[3]));
  LUT6 #(
    .INIT(64'h15555557C0000000)) 
    \r_Clk_Count[4]_i_1 
       (.I0(r_Clk_Count_reg[5]),
        .I1(r_Clk_Count_reg[1]),
        .I2(r_Clk_Count_reg[0]),
        .I3(r_Clk_Count_reg[3]),
        .I4(r_Clk_Count_reg[2]),
        .I5(r_Clk_Count_reg[4]),
        .O(r_Clk_Count[4]));
  LUT3 #(
    .INIT(8'h01)) 
    \r_Clk_Count[5]_i_1 
       (.I0(r_SM_Main[2]),
        .I1(r_SM_Main[0]),
        .I2(r_SM_Main[1]),
        .O(r_Clk_Count0));
  LUT3 #(
    .INIT(8'h32)) 
    \r_Clk_Count[5]_i_2 
       (.I0(r_SM_Main[1]),
        .I1(r_SM_Main[2]),
        .I2(r_SM_Main[0]),
        .O(r_Clk_Count_1));
  LUT6 #(
    .INIT(64'h5555555780000000)) 
    \r_Clk_Count[5]_i_3 
       (.I0(r_Clk_Count_reg[4]),
        .I1(r_Clk_Count_reg[1]),
        .I2(r_Clk_Count_reg[0]),
        .I3(r_Clk_Count_reg[3]),
        .I4(r_Clk_Count_reg[2]),
        .I5(r_Clk_Count_reg[5]),
        .O(r_Clk_Count[5]));
  FDRE \r_Clk_Count_reg[0] 
       (.C(clk_out1),
        .CE(r_Clk_Count_1),
        .D(r_Clk_Count[0]),
        .Q(r_Clk_Count_reg[0]),
        .R(r_Clk_Count0));
  FDRE \r_Clk_Count_reg[1] 
       (.C(clk_out1),
        .CE(r_Clk_Count_1),
        .D(r_Clk_Count[1]),
        .Q(r_Clk_Count_reg[1]),
        .R(r_Clk_Count0));
  FDRE \r_Clk_Count_reg[2] 
       (.C(clk_out1),
        .CE(r_Clk_Count_1),
        .D(r_Clk_Count[2]),
        .Q(r_Clk_Count_reg[2]),
        .R(r_Clk_Count0));
  FDRE \r_Clk_Count_reg[3] 
       (.C(clk_out1),
        .CE(r_Clk_Count_1),
        .D(r_Clk_Count[3]),
        .Q(r_Clk_Count_reg[3]),
        .R(r_Clk_Count0));
  FDRE \r_Clk_Count_reg[4] 
       (.C(clk_out1),
        .CE(r_Clk_Count_1),
        .D(r_Clk_Count[4]),
        .Q(r_Clk_Count_reg[4]),
        .R(r_Clk_Count0));
  FDRE \r_Clk_Count_reg[5] 
       (.C(clk_out1),
        .CE(r_Clk_Count_1),
        .D(r_Clk_Count[5]),
        .Q(r_Clk_Count_reg[5]),
        .R(r_Clk_Count0));
  LUT4 #(
    .INIT(16'h0100)) 
    \r_TX_Data[7]_i_1 
       (.I0(r_SM_Main[1]),
        .I1(r_SM_Main[0]),
        .I2(r_SM_Main[2]),
        .I3(tx_start_reg),
        .O(r_TX_Data_0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[0] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [0]),
        .Q(r_TX_Data[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[1] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [1]),
        .Q(r_TX_Data[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[2] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [2]),
        .Q(r_TX_Data[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[3] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [3]),
        .Q(r_TX_Data[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[4] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [4]),
        .Q(r_TX_Data[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[5] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [5]),
        .Q(r_TX_Data[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[6] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [6]),
        .Q(r_TX_Data[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_TX_Data_reg[7] 
       (.C(clk_out1),
        .CE(r_TX_Data_0),
        .D(\r_TX_Data_reg[7]_0 [7]),
        .Q(r_TX_Data[7]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT5 #(
    .INIT(32'hFEFE0424)) 
    r_TX_Done_i_1
       (.I0(r_SM_Main[0]),
        .I1(r_SM_Main[2]),
        .I2(r_SM_Main[1]),
        .I3(\FSM_sequential_r_SM_Main[2]_i_2_n_0 ),
        .I4(route_uart_tx_done),
        .O(r_TX_Done_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    r_TX_Done_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_TX_Done_i_1_n_0),
        .Q(route_uart_tx_done),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    route_TX_Serial_i_1
       (.I0(r_SM_Main[2]),
        .O(route_TX_Serial));
  LUT5 #(
    .INIT(32'hFFFEFEFF)) 
    route_TX_Serial_i_2
       (.I0(route_TX_Serial_i_3_n_0),
        .I1(route_TX_Serial_i_4_n_0),
        .I2(route_TX_Serial_i_5_n_0),
        .I3(r_SM_Main[1]),
        .I4(r_SM_Main[0]),
        .O(route_TX_Serial_i_2_n_0));
  LUT6 #(
    .INIT(64'h08080808FF080808)) 
    route_TX_Serial_i_3
       (.I0(route_TX_Serial_i_6_n_0),
        .I1(\r_Bit_Index[2]_i_2_n_0 ),
        .I2(\r_Bit_Index_reg_n_0_[2] ),
        .I3(route_TX_Serial_i_7_n_0),
        .I4(\r_Bit_Index_reg_n_0_[0] ),
        .I5(\r_Bit_Index_reg_n_0_[1] ),
        .O(route_TX_Serial_i_3_n_0));
  LUT6 #(
    .INIT(64'h4540000000000000)) 
    route_TX_Serial_i_4
       (.I0(\r_Bit_Index_reg_n_0_[0] ),
        .I1(r_TX_Data[6]),
        .I2(\r_Bit_Index_reg_n_0_[1] ),
        .I3(r_TX_Data[4]),
        .I4(\r_Bit_Index_reg_n_0_[2] ),
        .I5(\r_Bit_Index[2]_i_2_n_0 ),
        .O(route_TX_Serial_i_4_n_0));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    route_TX_Serial_i_5
       (.I0(\r_Bit_Index_reg_n_0_[0] ),
        .I1(\r_Bit_Index_reg_n_0_[1] ),
        .I2(r_TX_Data[7]),
        .I3(\r_Bit_Index_reg_n_0_[2] ),
        .I4(r_SM_Main[0]),
        .I5(r_SM_Main[2]),
        .O(route_TX_Serial_i_5_n_0));
  LUT5 #(
    .INIT(32'hB833B800)) 
    route_TX_Serial_i_6
       (.I0(r_TX_Data[3]),
        .I1(\r_Bit_Index_reg_n_0_[0] ),
        .I2(r_TX_Data[2]),
        .I3(\r_Bit_Index_reg_n_0_[1] ),
        .I4(r_TX_Data[0]),
        .O(route_TX_Serial_i_6_n_0));
  LUT5 #(
    .INIT(32'h000C000A)) 
    route_TX_Serial_i_7
       (.I0(r_TX_Data[1]),
        .I1(r_TX_Data[5]),
        .I2(r_SM_Main[2]),
        .I3(r_SM_Main[0]),
        .I4(\r_Bit_Index_reg_n_0_[2] ),
        .O(route_TX_Serial_i_7_n_0));
  FDRE route_TX_Serial_reg
       (.C(clk_out1),
        .CE(route_TX_Serial),
        .D(route_TX_Serial_i_2_n_0),
        .Q(po_uart_tx),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFF0111FFFF0000)) 
    tx_start_i_1
       (.I0(Q[3]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(route_uart_tx_done),
        .I4(Q[1]),
        .I5(tx_start_reg),
        .O(\FSM_onehot_next_state_reg[3] ));
endmodule

module ad_control
   (po_spi_cs_reg,
    po_spi_cs_reg_0,
    po_ada_clk_OBUF,
    po_adb_clk_OBUF,
    E,
    so_spi_rdy_reg,
    D,
    \jeemux_reg[0] ,
    \b_spi_rx_reg[6] ,
    \jeemux_reg[1] ,
    so_spi_rdy_reg_0,
    so_spi_rdy_reg_1,
    so_spi_rdy_reg_2,
    \b_spi_rx_reg[15] ,
    \po3_ada_muxsel_reg[2]_0 ,
    clk_out1,
    \r_si16_uart_tx_data_reg[15] ,
    \r_si16_uart_tx_data_reg[15]_0 ,
    \r_si16_uart_tx_data_reg[15]_1 ,
    locked,
    Q,
    dly_complete,
    si_uart_start_event,
    zero_cross_event_reg,
    \r_si16_uart_tx_data_reg[2] ,
    \r_si16_uart_tx_data_reg[2]_0 ,
    \b_spi_rx_reg[0] ,
    \b_spi_rx_reg[0]_0 ,
    lopt,
    lopt_1,
    lopt_2,
    lopt_3,
    lopt_4,
    lopt_5);
  output po_spi_cs_reg;
  output po_spi_cs_reg_0;
  output po_ada_clk_OBUF;
  output po_adb_clk_OBUF;
  output [0:0]E;
  output so_spi_rdy_reg;
  output [1:0]D;
  output \jeemux_reg[0] ;
  output \b_spi_rx_reg[6] ;
  output \jeemux_reg[1] ;
  output so_spi_rdy_reg_0;
  output so_spi_rdy_reg_1;
  output so_spi_rdy_reg_2;
  output [12:0]\b_spi_rx_reg[15] ;
  output [2:0]\po3_ada_muxsel_reg[2]_0 ;
  input clk_out1;
  input \r_si16_uart_tx_data_reg[15] ;
  input \r_si16_uart_tx_data_reg[15]_0 ;
  input \r_si16_uart_tx_data_reg[15]_1 ;
  input locked;
  input [4:0]Q;
  input dly_complete;
  input si_uart_start_event;
  input zero_cross_event_reg;
  input \r_si16_uart_tx_data_reg[2] ;
  input [2:0]\r_si16_uart_tx_data_reg[2]_0 ;
  input [0:0]\b_spi_rx_reg[0] ;
  input [0:0]\b_spi_rx_reg[0]_0 ;
  output lopt;
  output lopt_1;
  output lopt_2;
  output lopt_3;
  output lopt_4;
  output lopt_5;

  wire [1:0]D;
  wire [0:0]E;
  wire [4:0]Q;
  wire ada_n_2;
  wire ada_n_3;
  wire ada_n_4;
  wire [0:0]\b_spi_rx_reg[0] ;
  wire [0:0]\b_spi_rx_reg[0]_0 ;
  wire [12:0]\b_spi_rx_reg[15] ;
  wire \b_spi_rx_reg[6] ;
  wire clk_out1;
  wire dly_complete;
  wire \jeemux_reg[0] ;
  wire \jeemux_reg[1] ;
  wire locked;
  wire [10:0]plusOp__0;
  wire \po3_ada_muxsel_reg[0]_lopt_replica_1 ;
  wire \po3_ada_muxsel_reg[1]_lopt_replica_1 ;
  wire [2:0]\po3_ada_muxsel_reg[2]_0 ;
  wire \po3_ada_muxsel_reg[2]_lopt_replica_1 ;
  wire po_ada_clk_OBUF;
  wire po_adb_clk_OBUF;
  wire po_spi_cs_reg;
  wire po_spi_cs_reg_0;
  wire \r_si16_uart_tx_data[15]_i_3_n_0 ;
  wire \r_si16_uart_tx_data_reg[15] ;
  wire \r_si16_uart_tx_data_reg[15]_0 ;
  wire \r_si16_uart_tx_data_reg[15]_1 ;
  wire \r_si16_uart_tx_data_reg[2] ;
  wire [2:0]\r_si16_uart_tx_data_reg[2]_0 ;
  wire r_si_uart_start_event;
  wire [2:0]\r_so_adb_ctrl[std3_ad_address] ;
  wire si_ada_start;
  wire si_uart_start_event;
  wire \so_ada_ctrl[std3_ad_address] ;
  wire \so_ada_ctrl[std3_ad_address][0]_i_1_n_0 ;
  wire \so_ada_ctrl[std3_ad_address][1]_i_1_n_0 ;
  wire \so_ada_ctrl[std3_ad_address][2]_i_2_n_0 ;
  wire \so_ada_ctrl[std3_ad_address][2]_i_3_n_0 ;
  wire \so_ada_ctrl[std3_ad_address][2]_i_4_n_0 ;
  wire so_sh_rdy;
  wire so_spi_rdy_reg;
  wire so_spi_rdy_reg_0;
  wire so_spi_rdy_reg_1;
  wire so_spi_rdy_reg_2;
  wire [2:0]st_ada_seq_nxt;
  wire [2:0]st_ada_seq_nxt_1;
  wire [6:0]test_ad;
  wire \test_ad[0]_i_1_n_0 ;
  wire \test_ad[1]_i_1_n_0 ;
  wire \test_ad[2]_i_1_n_0 ;
  wire \test_ad[3]_i_1_n_0 ;
  wire \test_ad[4]_i_1_n_0 ;
  wire \test_ad[5]_i_1_n_0 ;
  wire \test_ad[6]_i_2_n_0 ;
  wire \test_ad[6]_i_3_n_0 ;
  wire \test_ad[6]_i_4_n_0 ;
  wire \test_ad[6]_i_5_n_0 ;
  wire \test_ad[6]_i_6_n_0 ;
  wire test_ad_0;
  wire \trig_cnt[10]_i_2_n_0 ;
  wire [10:0]trig_cnt_reg;
  wire zero_cross_event_reg;

  assign lopt = \po3_ada_muxsel_reg[0]_lopt_replica_1 ;
  assign lopt_2 = \po3_ada_muxsel_reg[1]_lopt_replica_1 ;
  assign lopt_4 = \po3_ada_muxsel_reg[2]_lopt_replica_1 ;
  adc_wrapper ada
       (.Q(\r_so_adb_ctrl[std3_ad_address] ),
        .SR(po_spi_cs_reg_0),
        .\b_spi_rx_reg[0] (\b_spi_rx_reg[0] ),
        .\b_spi_rx_reg[15] (\b_spi_rx_reg[15] ),
        .\b_spi_rx_reg[1] (ada_n_2),
        .clk_out1(clk_out1),
        .\jeemux_reg[1] (ada_n_3),
        .\jeemux_reg[2] (ada_n_4),
        .po_ada_clk_OBUF(po_ada_clk_OBUF),
        .\r_si16_uart_tx_data_reg[1] (\r_si16_uart_tx_data_reg[15]_1 ),
        .\r_si16_uart_tx_data_reg[1]_0 (\r_si16_uart_tx_data_reg[15] ),
        .\r_si16_uart_tx_data_reg[1]_1 (\r_si16_uart_tx_data_reg[15]_0 ),
        .si_ada_start(si_ada_start));
  adc_wrapper_0 adb
       (.D(D),
        .E(so_sh_rdy),
        .\FSM_onehot_st_main_states_reg[0] (Q),
        .\FSM_onehot_st_main_states_reg[4] (E),
        .Q(\r_so_adb_ctrl[std3_ad_address] ),
        .SR(po_spi_cs_reg),
        .\b_spi_rx_reg[0] (\b_spi_rx_reg[0]_0 ),
        .\b_spi_rx_reg[6] (\b_spi_rx_reg[6] ),
        .clk_out1(clk_out1),
        .dly_complete(dly_complete),
        .\jeemux_reg[0] (\jeemux_reg[0] ),
        .\jeemux_reg[1] (\jeemux_reg[1] ),
        .locked(locked),
        .po_adb_clk_OBUF(po_adb_clk_OBUF),
        .\r_si16_uart_tx_data_reg[0] (ada_n_3),
        .\r_si16_uart_tx_data_reg[15] (\r_si16_uart_tx_data_reg[15]_1 ),
        .\r_si16_uart_tx_data_reg[15]_0 (\r_si16_uart_tx_data_reg[15] ),
        .\r_si16_uart_tx_data_reg[15]_1 (\r_si16_uart_tx_data_reg[15]_0 ),
        .\r_si16_uart_tx_data_reg[1] (ada_n_2),
        .\r_si16_uart_tx_data_reg[2] (ada_n_4),
        .\r_si16_uart_tx_data_reg[2]_0 (\r_si16_uart_tx_data_reg[2] ),
        .\r_si16_uart_tx_data_reg[2]_1 (\r_si16_uart_tx_data_reg[2]_0 ),
        .\r_si16_uart_tx_data_reg[4] (\r_si16_uart_tx_data[15]_i_3_n_0 ),
        .r_si_uart_start_event(r_si_uart_start_event),
        .si_ada_start(si_ada_start),
        .si_uart_start_event(si_uart_start_event),
        .so_spi_rdy_reg(so_spi_rdy_reg),
        .so_spi_rdy_reg_0(so_spi_rdy_reg_0),
        .so_spi_rdy_reg_1(so_spi_rdy_reg_1),
        .so_spi_rdy_reg_2(so_spi_rdy_reg_2),
        .zero_cross_event_reg(zero_cross_event_reg));
  FDRE \po3_ada_muxsel_reg[0] 
       (.C(clk_out1),
        .CE(so_sh_rdy),
        .D(st_ada_seq_nxt[0]),
        .Q(\po3_ada_muxsel_reg[2]_0 [0]),
        .R(1'b0));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \po3_ada_muxsel_reg[0]_lopt_replica 
       (.C(clk_out1),
        .CE(so_sh_rdy),
        .D(st_ada_seq_nxt[0]),
        .Q(\po3_ada_muxsel_reg[0]_lopt_replica_1 ),
        .R(1'b0));
  FDRE \po3_ada_muxsel_reg[1] 
       (.C(clk_out1),
        .CE(so_sh_rdy),
        .D(st_ada_seq_nxt[1]),
        .Q(\po3_ada_muxsel_reg[2]_0 [1]),
        .R(1'b0));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \po3_ada_muxsel_reg[1]_lopt_replica 
       (.C(clk_out1),
        .CE(so_sh_rdy),
        .D(st_ada_seq_nxt[1]),
        .Q(\po3_ada_muxsel_reg[1]_lopt_replica_1 ),
        .R(1'b0));
  FDRE \po3_ada_muxsel_reg[2] 
       (.C(clk_out1),
        .CE(so_sh_rdy),
        .D(st_ada_seq_nxt[2]),
        .Q(\po3_ada_muxsel_reg[2]_0 [2]),
        .R(1'b0));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \po3_ada_muxsel_reg[2]_lopt_replica 
       (.C(clk_out1),
        .CE(so_sh_rdy),
        .D(st_ada_seq_nxt[2]),
        .Q(\po3_ada_muxsel_reg[2]_lopt_replica_1 ),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h6)) 
    \r_si16_uart_tx_data[15]_i_3 
       (.I0(\r_so_adb_ctrl[std3_ad_address] [0]),
        .I1(\r_si16_uart_tx_data_reg[15]_0 ),
        .O(\r_si16_uart_tx_data[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF40FF0420100201)) 
    r_si_uart_start_event_i_2
       (.I0(\r_so_adb_ctrl[std3_ad_address] [2]),
        .I1(\r_so_adb_ctrl[std3_ad_address] [1]),
        .I2(\r_so_adb_ctrl[std3_ad_address] [0]),
        .I3(\r_si16_uart_tx_data_reg[15] ),
        .I4(\r_si16_uart_tx_data_reg[15]_0 ),
        .I5(\r_si16_uart_tx_data_reg[15]_1 ),
        .O(r_si_uart_start_event));
  FDRE si_ada_start_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(test_ad_0),
        .Q(si_ada_start),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \so_ada_ctrl[std3_ad_address][0]_i_1 
       (.I0(test_ad[3]),
        .I1(test_ad[5]),
        .I2(test_ad[1]),
        .O(\so_ada_ctrl[std3_ad_address][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \so_ada_ctrl[std3_ad_address][1]_i_1 
       (.I0(test_ad[3]),
        .I1(test_ad[6]),
        .I2(test_ad[2]),
        .O(\so_ada_ctrl[std3_ad_address][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \so_ada_ctrl[std3_ad_address][2]_i_2 
       (.I0(test_ad[6]),
        .I1(test_ad[5]),
        .I2(test_ad[4]),
        .O(\so_ada_ctrl[std3_ad_address][2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100010116)) 
    \so_ada_ctrl[std3_ad_address][2]_i_3 
       (.I0(test_ad[1]),
        .I1(test_ad[2]),
        .I2(test_ad[4]),
        .I3(test_ad[6]),
        .I4(test_ad[5]),
        .I5(test_ad[3]),
        .O(\so_ada_ctrl[std3_ad_address][2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \so_ada_ctrl[std3_ad_address][2]_i_4 
       (.I0(test_ad[2]),
        .I1(test_ad[6]),
        .I2(test_ad[3]),
        .I3(test_ad[5]),
        .I4(test_ad[4]),
        .I5(test_ad[1]),
        .O(\so_ada_ctrl[std3_ad_address][2]_i_4_n_0 ));
  FDRE \so_ada_ctrl_reg[std3_ad_address][0] 
       (.C(clk_out1),
        .CE(\so_ada_ctrl[std3_ad_address] ),
        .D(\so_ada_ctrl[std3_ad_address][0]_i_1_n_0 ),
        .Q(\r_so_adb_ctrl[std3_ad_address] [0]),
        .R(1'b0));
  FDRE \so_ada_ctrl_reg[std3_ad_address][1] 
       (.C(clk_out1),
        .CE(\so_ada_ctrl[std3_ad_address] ),
        .D(\so_ada_ctrl[std3_ad_address][1]_i_1_n_0 ),
        .Q(\r_so_adb_ctrl[std3_ad_address] [1]),
        .R(1'b0));
  FDRE \so_ada_ctrl_reg[std3_ad_address][2] 
       (.C(clk_out1),
        .CE(\so_ada_ctrl[std3_ad_address] ),
        .D(\so_ada_ctrl[std3_ad_address][2]_i_2_n_0 ),
        .Q(\r_so_adb_ctrl[std3_ad_address] [2]),
        .R(1'b0));
  MUXF7 \so_ada_ctrl_reg[std3_ad_address][2]_i_1 
       (.I0(\so_ada_ctrl[std3_ad_address][2]_i_3_n_0 ),
        .I1(\so_ada_ctrl[std3_ad_address][2]_i_4_n_0 ),
        .O(\so_ada_ctrl[std3_ad_address] ),
        .S(test_ad[0]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'h0000AAAB)) 
    \st_ada_seq_nxt[0]_i_1 
       (.I0(test_ad[2]),
        .I1(test_ad[6]),
        .I2(test_ad[3]),
        .I3(test_ad[4]),
        .I4(test_ad[1]),
        .O(st_ada_seq_nxt_1[0]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \st_ada_seq_nxt[1]_i_1 
       (.I0(test_ad[1]),
        .I1(test_ad[3]),
        .I2(test_ad[0]),
        .O(st_ada_seq_nxt_1[1]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \st_ada_seq_nxt[2]_i_1 
       (.I0(test_ad[3]),
        .I1(test_ad[5]),
        .I2(test_ad[4]),
        .O(st_ada_seq_nxt_1[2]));
  FDRE \st_ada_seq_nxt_reg[0] 
       (.C(clk_out1),
        .CE(\so_ada_ctrl[std3_ad_address] ),
        .D(st_ada_seq_nxt_1[0]),
        .Q(st_ada_seq_nxt[0]),
        .R(1'b0));
  FDRE \st_ada_seq_nxt_reg[1] 
       (.C(clk_out1),
        .CE(\so_ada_ctrl[std3_ad_address] ),
        .D(st_ada_seq_nxt_1[1]),
        .Q(st_ada_seq_nxt[1]),
        .R(1'b0));
  FDRE \st_ada_seq_nxt_reg[2] 
       (.C(clk_out1),
        .CE(\so_ada_ctrl[std3_ad_address] ),
        .D(st_ada_seq_nxt_1[2]),
        .Q(st_ada_seq_nxt[2]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \test_ad[0]_i_1 
       (.I0(trig_cnt_reg[5]),
        .I1(trig_cnt_reg[4]),
        .I2(trig_cnt_reg[3]),
        .O(\test_ad[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \test_ad[1]_i_1 
       (.I0(trig_cnt_reg[4]),
        .I1(trig_cnt_reg[5]),
        .I2(trig_cnt_reg[3]),
        .O(\test_ad[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \test_ad[2]_i_1 
       (.I0(trig_cnt_reg[5]),
        .I1(trig_cnt_reg[4]),
        .I2(trig_cnt_reg[3]),
        .O(\test_ad[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \test_ad[3]_i_1 
       (.I0(trig_cnt_reg[5]),
        .I1(trig_cnt_reg[3]),
        .O(\test_ad[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \test_ad[4]_i_1 
       (.I0(trig_cnt_reg[5]),
        .I1(trig_cnt_reg[4]),
        .I2(trig_cnt_reg[3]),
        .O(\test_ad[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \test_ad[5]_i_1 
       (.I0(trig_cnt_reg[5]),
        .I1(trig_cnt_reg[4]),
        .O(\test_ad[5]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \test_ad[6]_i_1 
       (.I0(trig_cnt_reg[1]),
        .I1(trig_cnt_reg[0]),
        .I2(\test_ad[6]_i_3_n_0 ),
        .O(test_ad_0));
  LUT2 #(
    .INIT(4'h8)) 
    \test_ad[6]_i_2 
       (.I0(trig_cnt_reg[3]),
        .I1(trig_cnt_reg[4]),
        .O(\test_ad[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF000000000000088)) 
    \test_ad[6]_i_3 
       (.I0(\test_ad[6]_i_4_n_0 ),
        .I1(\test_ad[6]_i_5_n_0 ),
        .I2(\test_ad[6]_i_6_n_0 ),
        .I3(trig_cnt_reg[8]),
        .I4(trig_cnt_reg[5]),
        .I5(trig_cnt_reg[2]),
        .O(\test_ad[6]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h81)) 
    \test_ad[6]_i_4 
       (.I0(trig_cnt_reg[3]),
        .I1(trig_cnt_reg[6]),
        .I2(trig_cnt_reg[9]),
        .O(\test_ad[6]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h81)) 
    \test_ad[6]_i_5 
       (.I0(trig_cnt_reg[4]),
        .I1(trig_cnt_reg[7]),
        .I2(trig_cnt_reg[10]),
        .O(\test_ad[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0100000000000081)) 
    \test_ad[6]_i_6 
       (.I0(trig_cnt_reg[4]),
        .I1(trig_cnt_reg[7]),
        .I2(trig_cnt_reg[10]),
        .I3(trig_cnt_reg[9]),
        .I4(trig_cnt_reg[6]),
        .I5(trig_cnt_reg[3]),
        .O(\test_ad[6]_i_6_n_0 ));
  FDRE \test_ad_reg[0] 
       (.C(clk_out1),
        .CE(test_ad_0),
        .D(\test_ad[0]_i_1_n_0 ),
        .Q(test_ad[0]),
        .R(1'b0));
  FDRE \test_ad_reg[1] 
       (.C(clk_out1),
        .CE(test_ad_0),
        .D(\test_ad[1]_i_1_n_0 ),
        .Q(test_ad[1]),
        .R(1'b0));
  FDRE \test_ad_reg[2] 
       (.C(clk_out1),
        .CE(test_ad_0),
        .D(\test_ad[2]_i_1_n_0 ),
        .Q(test_ad[2]),
        .R(1'b0));
  FDRE \test_ad_reg[3] 
       (.C(clk_out1),
        .CE(test_ad_0),
        .D(\test_ad[3]_i_1_n_0 ),
        .Q(test_ad[3]),
        .R(1'b0));
  FDRE \test_ad_reg[4] 
       (.C(clk_out1),
        .CE(test_ad_0),
        .D(\test_ad[4]_i_1_n_0 ),
        .Q(test_ad[4]),
        .R(1'b0));
  FDRE \test_ad_reg[5] 
       (.C(clk_out1),
        .CE(test_ad_0),
        .D(\test_ad[5]_i_1_n_0 ),
        .Q(test_ad[5]),
        .R(1'b0));
  FDRE \test_ad_reg[6] 
       (.C(clk_out1),
        .CE(test_ad_0),
        .D(\test_ad[6]_i_2_n_0 ),
        .Q(test_ad[6]),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \trig_cnt[0]_i_1 
       (.I0(trig_cnt_reg[0]),
        .O(plusOp__0[0]));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \trig_cnt[10]_i_1 
       (.I0(trig_cnt_reg[9]),
        .I1(trig_cnt_reg[7]),
        .I2(\trig_cnt[10]_i_2_n_0 ),
        .I3(trig_cnt_reg[6]),
        .I4(trig_cnt_reg[8]),
        .I5(trig_cnt_reg[10]),
        .O(plusOp__0[10]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \trig_cnt[10]_i_2 
       (.I0(trig_cnt_reg[4]),
        .I1(trig_cnt_reg[2]),
        .I2(trig_cnt_reg[0]),
        .I3(trig_cnt_reg[1]),
        .I4(trig_cnt_reg[3]),
        .I5(trig_cnt_reg[5]),
        .O(\trig_cnt[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \trig_cnt[1]_i_1 
       (.I0(trig_cnt_reg[0]),
        .I1(trig_cnt_reg[1]),
        .O(plusOp__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \trig_cnt[2]_i_1 
       (.I0(trig_cnt_reg[1]),
        .I1(trig_cnt_reg[0]),
        .I2(trig_cnt_reg[2]),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \trig_cnt[3]_i_1 
       (.I0(trig_cnt_reg[2]),
        .I1(trig_cnt_reg[0]),
        .I2(trig_cnt_reg[1]),
        .I3(trig_cnt_reg[3]),
        .O(plusOp__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \trig_cnt[4]_i_1 
       (.I0(trig_cnt_reg[3]),
        .I1(trig_cnt_reg[1]),
        .I2(trig_cnt_reg[0]),
        .I3(trig_cnt_reg[2]),
        .I4(trig_cnt_reg[4]),
        .O(plusOp__0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \trig_cnt[5]_i_1 
       (.I0(trig_cnt_reg[4]),
        .I1(trig_cnt_reg[2]),
        .I2(trig_cnt_reg[0]),
        .I3(trig_cnt_reg[1]),
        .I4(trig_cnt_reg[3]),
        .I5(trig_cnt_reg[5]),
        .O(plusOp__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \trig_cnt[6]_i_1 
       (.I0(\trig_cnt[10]_i_2_n_0 ),
        .I1(trig_cnt_reg[6]),
        .O(plusOp__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \trig_cnt[7]_i_1 
       (.I0(trig_cnt_reg[6]),
        .I1(\trig_cnt[10]_i_2_n_0 ),
        .I2(trig_cnt_reg[7]),
        .O(plusOp__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \trig_cnt[8]_i_1 
       (.I0(trig_cnt_reg[7]),
        .I1(\trig_cnt[10]_i_2_n_0 ),
        .I2(trig_cnt_reg[6]),
        .I3(trig_cnt_reg[8]),
        .O(plusOp__0[8]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'hF7FF0800)) 
    \trig_cnt[9]_i_1 
       (.I0(trig_cnt_reg[8]),
        .I1(trig_cnt_reg[6]),
        .I2(\trig_cnt[10]_i_2_n_0 ),
        .I3(trig_cnt_reg[7]),
        .I4(trig_cnt_reg[9]),
        .O(plusOp__0[9]));
  FDRE \trig_cnt_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[0]),
        .Q(trig_cnt_reg[0]),
        .R(1'b0));
  FDRE \trig_cnt_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[10]),
        .Q(trig_cnt_reg[10]),
        .R(1'b0));
  FDRE \trig_cnt_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[1]),
        .Q(trig_cnt_reg[1]),
        .R(1'b0));
  FDRE \trig_cnt_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[2]),
        .Q(trig_cnt_reg[2]),
        .R(1'b0));
  FDRE \trig_cnt_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[3]),
        .Q(trig_cnt_reg[3]),
        .R(1'b0));
  FDRE \trig_cnt_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[4]),
        .Q(trig_cnt_reg[4]),
        .R(1'b0));
  FDRE \trig_cnt_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[5]),
        .Q(trig_cnt_reg[5]),
        .R(1'b0));
  FDRE \trig_cnt_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[6]),
        .Q(trig_cnt_reg[6]),
        .R(1'b0));
  FDRE \trig_cnt_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[7]),
        .Q(trig_cnt_reg[7]),
        .R(1'b0));
  FDRE \trig_cnt_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[8]),
        .Q(trig_cnt_reg[8]),
        .R(1'b0));
  FDRE \trig_cnt_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp__0[9]),
        .Q(trig_cnt_reg[9]),
        .R(1'b0));
endmodule

module adc_wrapper
   (SR,
    po_ada_clk_OBUF,
    \b_spi_rx_reg[1] ,
    \jeemux_reg[1] ,
    \jeemux_reg[2] ,
    \b_spi_rx_reg[15] ,
    clk_out1,
    si_ada_start,
    Q,
    \r_si16_uart_tx_data_reg[1] ,
    \r_si16_uart_tx_data_reg[1]_0 ,
    \r_si16_uart_tx_data_reg[1]_1 ,
    \b_spi_rx_reg[0] );
  output [0:0]SR;
  output po_ada_clk_OBUF;
  output \b_spi_rx_reg[1] ;
  output \jeemux_reg[1] ;
  output \jeemux_reg[2] ;
  output [12:0]\b_spi_rx_reg[15] ;
  input clk_out1;
  input si_ada_start;
  input [2:0]Q;
  input \r_si16_uart_tx_data_reg[1] ;
  input \r_si16_uart_tx_data_reg[1]_0 ;
  input \r_si16_uart_tx_data_reg[1]_1 ;
  input [0:0]\b_spi_rx_reg[0] ;

  wire [2:0]Q;
  wire [0:0]SR;
  wire [0:0]\b_spi_rx_reg[0] ;
  wire [12:0]\b_spi_rx_reg[15] ;
  wire \b_spi_rx_reg[1] ;
  wire clk_out1;
  wire \jeemux_reg[1] ;
  wire \jeemux_reg[2] ;
  wire po_ada_clk_OBUF;
  wire \r_si16_uart_tx_data_reg[1] ;
  wire \r_si16_uart_tx_data_reg[1]_0 ;
  wire \r_si16_uart_tx_data_reg[1]_1 ;
  wire si_ada_start;

  ext_ad_spi3w_1 onboard_adc
       (.Q(Q),
        .\b_spi_rx_reg[0]_0 (\b_spi_rx_reg[0] ),
        .\b_spi_rx_reg[15]_0 (\b_spi_rx_reg[15] ),
        .\b_spi_rx_reg[1]_0 (\b_spi_rx_reg[1] ),
        .clk_out1(clk_out1),
        .\jeemux_reg[1] (\jeemux_reg[1] ),
        .\jeemux_reg[2] (\jeemux_reg[2] ),
        .po_ada_clk_OBUF(po_ada_clk_OBUF),
        .po_spi_cs_reg_0(SR),
        .\r_si16_uart_tx_data_reg[1] (\r_si16_uart_tx_data_reg[1] ),
        .\r_si16_uart_tx_data_reg[1]_0 (\r_si16_uart_tx_data_reg[1]_0 ),
        .\r_si16_uart_tx_data_reg[1]_1 (\r_si16_uart_tx_data_reg[1]_1 ),
        .si_ada_start(si_ada_start));
endmodule

(* ORIG_REF_NAME = "adc_wrapper" *) 
module adc_wrapper_0
   (SR,
    po_adb_clk_OBUF,
    E,
    \FSM_onehot_st_main_states_reg[4] ,
    so_spi_rdy_reg,
    D,
    \jeemux_reg[0] ,
    \b_spi_rx_reg[6] ,
    \jeemux_reg[1] ,
    so_spi_rdy_reg_0,
    so_spi_rdy_reg_1,
    so_spi_rdy_reg_2,
    clk_out1,
    si_ada_start,
    Q,
    locked,
    \FSM_onehot_st_main_states_reg[0] ,
    \r_si16_uart_tx_data_reg[15] ,
    \r_si16_uart_tx_data_reg[4] ,
    \r_si16_uart_tx_data_reg[15]_0 ,
    dly_complete,
    r_si_uart_start_event,
    \r_si16_uart_tx_data_reg[15]_1 ,
    si_uart_start_event,
    zero_cross_event_reg,
    \r_si16_uart_tx_data_reg[2] ,
    \r_si16_uart_tx_data_reg[2]_0 ,
    \r_si16_uart_tx_data_reg[2]_1 ,
    \r_si16_uart_tx_data_reg[1] ,
    \r_si16_uart_tx_data_reg[0] ,
    \b_spi_rx_reg[0] );
  output [0:0]SR;
  output po_adb_clk_OBUF;
  output [0:0]E;
  output [0:0]\FSM_onehot_st_main_states_reg[4] ;
  output so_spi_rdy_reg;
  output [1:0]D;
  output \jeemux_reg[0] ;
  output \b_spi_rx_reg[6] ;
  output \jeemux_reg[1] ;
  output so_spi_rdy_reg_0;
  output so_spi_rdy_reg_1;
  output so_spi_rdy_reg_2;
  input clk_out1;
  input si_ada_start;
  input [2:0]Q;
  input locked;
  input [4:0]\FSM_onehot_st_main_states_reg[0] ;
  input \r_si16_uart_tx_data_reg[15] ;
  input \r_si16_uart_tx_data_reg[4] ;
  input \r_si16_uart_tx_data_reg[15]_0 ;
  input dly_complete;
  input r_si_uart_start_event;
  input \r_si16_uart_tx_data_reg[15]_1 ;
  input si_uart_start_event;
  input zero_cross_event_reg;
  input \r_si16_uart_tx_data_reg[2] ;
  input \r_si16_uart_tx_data_reg[2]_0 ;
  input [2:0]\r_si16_uart_tx_data_reg[2]_1 ;
  input \r_si16_uart_tx_data_reg[1] ;
  input \r_si16_uart_tx_data_reg[0] ;
  input [0:0]\b_spi_rx_reg[0] ;

  wire [1:0]D;
  wire [0:0]E;
  wire [4:0]\FSM_onehot_st_main_states_reg[0] ;
  wire [0:0]\FSM_onehot_st_main_states_reg[4] ;
  wire [2:0]Q;
  wire [0:0]SR;
  wire [0:0]\b_spi_rx_reg[0] ;
  wire \b_spi_rx_reg[6] ;
  wire clk_out1;
  wire dly_complete;
  wire \jeemux_reg[0] ;
  wire \jeemux_reg[1] ;
  wire locked;
  wire po_adb_clk_OBUF;
  wire \r_si16_uart_tx_data_reg[0] ;
  wire \r_si16_uart_tx_data_reg[15] ;
  wire \r_si16_uart_tx_data_reg[15]_0 ;
  wire \r_si16_uart_tx_data_reg[15]_1 ;
  wire \r_si16_uart_tx_data_reg[1] ;
  wire \r_si16_uart_tx_data_reg[2] ;
  wire \r_si16_uart_tx_data_reg[2]_0 ;
  wire [2:0]\r_si16_uart_tx_data_reg[2]_1 ;
  wire \r_si16_uart_tx_data_reg[4] ;
  wire r_si_uart_start_event;
  wire si_ada_start;
  wire si_uart_start_event;
  wire so_spi_rdy_reg;
  wire so_spi_rdy_reg_0;
  wire so_spi_rdy_reg_1;
  wire so_spi_rdy_reg_2;
  wire zero_cross_event_reg;

  ext_ad_spi3w onboard_adc
       (.D(D),
        .E(E),
        .\FSM_onehot_st_main_states_reg[0] (\FSM_onehot_st_main_states_reg[0] ),
        .\FSM_onehot_st_main_states_reg[4] (\FSM_onehot_st_main_states_reg[4] ),
        .Q(Q),
        .\b_spi_rx_reg[0]_0 (\b_spi_rx_reg[0] ),
        .\b_spi_rx_reg[6]_0 (\b_spi_rx_reg[6] ),
        .clk_out1(clk_out1),
        .dly_complete(dly_complete),
        .\jeemux_reg[0] (\jeemux_reg[0] ),
        .\jeemux_reg[1] (\jeemux_reg[1] ),
        .locked(locked),
        .po_adb_clk_OBUF(po_adb_clk_OBUF),
        .po_spi_cs_reg_0(SR),
        .\r_si16_uart_tx_data_reg[0] (\r_si16_uart_tx_data_reg[0] ),
        .\r_si16_uart_tx_data_reg[15] (\r_si16_uart_tx_data_reg[15] ),
        .\r_si16_uart_tx_data_reg[15]_0 (\r_si16_uart_tx_data_reg[15]_0 ),
        .\r_si16_uart_tx_data_reg[15]_1 (\r_si16_uart_tx_data_reg[15]_1 ),
        .\r_si16_uart_tx_data_reg[1] (\r_si16_uart_tx_data_reg[1] ),
        .\r_si16_uart_tx_data_reg[2] (\r_si16_uart_tx_data_reg[2] ),
        .\r_si16_uart_tx_data_reg[2]_0 (\r_si16_uart_tx_data_reg[2]_0 ),
        .\r_si16_uart_tx_data_reg[2]_1 (\r_si16_uart_tx_data_reg[2]_1 ),
        .\r_si16_uart_tx_data_reg[4] (\r_si16_uart_tx_data_reg[4] ),
        .r_si_uart_start_event(r_si_uart_start_event),
        .si_ada_start(si_ada_start),
        .si_uart_start_event(si_uart_start_event),
        .so_spi_rdy_reg_0(so_spi_rdy_reg),
        .so_spi_rdy_reg_1(so_spi_rdy_reg_0),
        .so_spi_rdy_reg_2(so_spi_rdy_reg_1),
        .so_spi_rdy_reg_3(so_spi_rdy_reg_2),
        .zero_cross_event_reg(zero_cross_event_reg));
endmodule

module data_control
   (SR,
    po_spi_cs_reg,
    po_uart_tx,
    po_spi_cs_reg_0,
    po_spi_cs_reg_1,
    \po4_dhb_pwm[pri_high] ,
    \po4_dhb_pwm[pri_low] ,
    \po4_dhb_pwm[sec_high] ,
    \po4_dhb_pwm[sec_low] ,
    \po4_ht_pwm[pri_high] ,
    \po4_ht_pwm[pri_low] ,
    \po2_pfc_pwm[ac1] ,
    po_ada_clk_OBUF,
    po_adb_clk_OBUF,
    po_ext_ad1_clk_OBUF,
    po_ext_ad2_clk_OBUF,
    E,
    D,
    \b_spi_rx_reg[6] ,
    \po3_ada_muxsel_reg[2] ,
    clk_out1,
    pi_uart_rx,
    locked,
    Q,
    dly_complete,
    zero_cross_event_reg,
    \b_spi_rx_reg[0] ,
    \b_spi_rx_reg[0]_0 ,
    lopt,
    lopt_1,
    lopt_2,
    lopt_3,
    lopt_4,
    lopt_5,
    lopt_6,
    lopt_7,
    lopt_8,
    lopt_9,
    lopt_10,
    lopt_11);
  output [0:0]SR;
  output [0:0]po_spi_cs_reg;
  output po_uart_tx;
  output [0:0]po_spi_cs_reg_0;
  output [0:0]po_spi_cs_reg_1;
  output \po4_dhb_pwm[pri_high] ;
  output \po4_dhb_pwm[pri_low] ;
  output \po4_dhb_pwm[sec_high] ;
  output \po4_dhb_pwm[sec_low] ;
  output \po4_ht_pwm[pri_high] ;
  output \po4_ht_pwm[pri_low] ;
  output \po2_pfc_pwm[ac1] ;
  output po_ada_clk_OBUF;
  output po_adb_clk_OBUF;
  output po_ext_ad1_clk_OBUF;
  output po_ext_ad2_clk_OBUF;
  output [0:0]E;
  output [1:0]D;
  output \b_spi_rx_reg[6] ;
  output [2:0]\po3_ada_muxsel_reg[2] ;
  input clk_out1;
  input pi_uart_rx;
  input locked;
  input [4:0]Q;
  input dly_complete;
  input zero_cross_event_reg;
  input [0:0]\b_spi_rx_reg[0] ;
  input [0:0]\b_spi_rx_reg[0]_0 ;
  output lopt;
  output lopt_1;
  output lopt_2;
  output lopt_3;
  output lopt_4;
  output lopt_5;
  output lopt_6;
  output lopt_7;
  output lopt_8;
  output lopt_9;
  output lopt_10;
  output lopt_11;

  wire [1:0]D;
  wire [0:0]E;
  wire [4:0]Q;
  wire [0:0]SR;
  wire [0:0]\b_spi_rx_reg[0] ;
  wire [0:0]\b_spi_rx_reg[0]_0 ;
  wire \b_spi_rx_reg[6] ;
  wire clk_out1;
  wire dly_complete;
  wire \heater_control/r_piu12_per_ctrl ;
  wire \jeemux_reg_n_0_[0] ;
  wire \jeemux_reg_n_0_[1] ;
  wire \jeemux_reg_n_0_[2] ;
  wire locked;
  wire lopt;
  wire lopt_10;
  wire lopt_2;
  wire lopt_4;
  wire lopt_6;
  wire lopt_8;
  wire onboard_ad_control_n_10;
  wire onboard_ad_control_n_11;
  wire onboard_ad_control_n_12;
  wire onboard_ad_control_n_13;
  wire onboard_ad_control_n_14;
  wire onboard_ad_control_n_15;
  wire onboard_ad_control_n_16;
  wire onboard_ad_control_n_17;
  wire onboard_ad_control_n_18;
  wire onboard_ad_control_n_19;
  wire onboard_ad_control_n_20;
  wire onboard_ad_control_n_21;
  wire onboard_ad_control_n_22;
  wire onboard_ad_control_n_23;
  wire onboard_ad_control_n_24;
  wire onboard_ad_control_n_25;
  wire onboard_ad_control_n_26;
  wire onboard_ad_control_n_5;
  wire onboard_ad_control_n_8;
  wire p_0_in0;
  wire pi_uart_rx;
  wire \po2_pfc_pwm[ac1] ;
  wire [2:0]\po3_ada_muxsel_reg[2] ;
  wire \po4_dhb_pwm[pri_high] ;
  wire \po4_dhb_pwm[pri_low] ;
  wire \po4_dhb_pwm[sec_high] ;
  wire \po4_dhb_pwm[sec_low] ;
  wire \po4_ht_pwm[pri_high] ;
  wire \po4_ht_pwm[pri_low] ;
  wire po_ada_clk_OBUF;
  wire po_adb_clk_OBUF;
  wire po_ext_ad1_clk_OBUF;
  wire po_ext_ad2_clk_OBUF;
  wire [0:0]po_spi_cs_reg;
  wire [0:0]po_spi_cs_reg_0;
  wire [0:0]po_spi_cs_reg_1;
  wire po_uart_tx;
  wire \r_si16_uart_tx_data[2]_i_3_n_0 ;
  wire [13:0]r_so16_uart_rx_data;
  wire r_so_uart_rx_rdy;
  wire rstn;
  wire [15:0]si16_uart_tx_data;
  wire si_uart_start_event;
  wire so_ext_ad1_start;
  wire supply_ctrl_layer_n_8;
  wire \testidata[15]_i_1_n_0 ;
  wire \testidata[7]_i_1_n_0 ;
  wire \uart1/route_rx_ready_event ;
  wire uart_n_1;
  wire uart_n_23;
  wire uart_n_24;
  wire uart_n_25;
  wire uart_n_26;
  wire uart_n_27;
  wire uart_n_4;
  wire uart_n_5;
  wire uart_n_6;
  wire uart_n_8;
  wire zero_cross_event_reg;
  wire NLW_onboard_ad_control_lopt_1_UNCONNECTED;
  wire NLW_onboard_ad_control_lopt_3_UNCONNECTED;
  wire NLW_onboard_ad_control_lopt_5_UNCONNECTED;
  wire NLW_supply_ctrl_layer_lopt_1_UNCONNECTED;
  wire NLW_supply_ctrl_layer_lopt_3_UNCONNECTED;
  wire NLW_supply_ctrl_layer_lopt_5_UNCONNECTED;

  ext_ad_control ext_adc
       (.SR(po_spi_cs_reg_0),
        .clk_out1(clk_out1),
        .po_ext_ad1_clk_OBUF(po_ext_ad1_clk_OBUF),
        .po_ext_ad2_clk_OBUF(po_ext_ad2_clk_OBUF),
        .po_spi_cs_reg(po_spi_cs_reg_1),
        .so_ext_ad1_start(so_ext_ad1_start));
  FDRE \jeemux_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(uart_n_26),
        .Q(\jeemux_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \jeemux_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(uart_n_25),
        .Q(\jeemux_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \jeemux_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(uart_n_24),
        .Q(\jeemux_reg_n_0_[2] ),
        .R(1'b0));
  ad_control onboard_ad_control
       (.D(D),
        .E(E),
        .Q(Q),
        .\b_spi_rx_reg[0] (\b_spi_rx_reg[0] ),
        .\b_spi_rx_reg[0]_0 (\b_spi_rx_reg[0]_0 ),
        .\b_spi_rx_reg[15] ({onboard_ad_control_n_14,onboard_ad_control_n_15,onboard_ad_control_n_16,onboard_ad_control_n_17,onboard_ad_control_n_18,onboard_ad_control_n_19,onboard_ad_control_n_20,onboard_ad_control_n_21,onboard_ad_control_n_22,onboard_ad_control_n_23,onboard_ad_control_n_24,onboard_ad_control_n_25,onboard_ad_control_n_26}),
        .\b_spi_rx_reg[6] (\b_spi_rx_reg[6] ),
        .clk_out1(clk_out1),
        .dly_complete(dly_complete),
        .\jeemux_reg[0] (onboard_ad_control_n_8),
        .\jeemux_reg[1] (onboard_ad_control_n_10),
        .locked(locked),
        .lopt(lopt_2),
        .lopt_1(NLW_onboard_ad_control_lopt_1_UNCONNECTED),
        .lopt_2(lopt_4),
        .lopt_3(NLW_onboard_ad_control_lopt_3_UNCONNECTED),
        .lopt_4(lopt_6),
        .lopt_5(NLW_onboard_ad_control_lopt_5_UNCONNECTED),
        .\po3_ada_muxsel_reg[2]_0 (\po3_ada_muxsel_reg[2] ),
        .po_ada_clk_OBUF(po_ada_clk_OBUF),
        .po_adb_clk_OBUF(po_adb_clk_OBUF),
        .po_spi_cs_reg(SR),
        .po_spi_cs_reg_0(po_spi_cs_reg),
        .\r_si16_uart_tx_data_reg[15] (\jeemux_reg_n_0_[2] ),
        .\r_si16_uart_tx_data_reg[15]_0 (\jeemux_reg_n_0_[0] ),
        .\r_si16_uart_tx_data_reg[15]_1 (\jeemux_reg_n_0_[1] ),
        .\r_si16_uart_tx_data_reg[2] (\r_si16_uart_tx_data[2]_i_3_n_0 ),
        .\r_si16_uart_tx_data_reg[2]_0 (si16_uart_tx_data[2:0]),
        .si_uart_start_event(si_uart_start_event),
        .so_spi_rdy_reg(onboard_ad_control_n_5),
        .so_spi_rdy_reg_0(onboard_ad_control_n_11),
        .so_spi_rdy_reg_1(onboard_ad_control_n_12),
        .so_spi_rdy_reg_2(onboard_ad_control_n_13),
        .zero_cross_event_reg(zero_cross_event_reg));
  LUT2 #(
    .INIT(4'h8)) 
    \r_si16_uart_tx_data[2]_i_3 
       (.I0(\jeemux_reg_n_0_[1] ),
        .I1(\jeemux_reg_n_0_[2] ),
        .O(\r_si16_uart_tx_data[2]_i_3_n_0 ));
  FDRE \r_si16_uart_tx_data_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(onboard_ad_control_n_13),
        .Q(si16_uart_tx_data[0]),
        .R(1'b0));
  FDRE \r_si16_uart_tx_data_reg[10] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_19),
        .Q(si16_uart_tx_data[10]),
        .R(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[11] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_18),
        .Q(si16_uart_tx_data[11]),
        .R(onboard_ad_control_n_10));
  FDSE \r_si16_uart_tx_data_reg[12] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_17),
        .Q(si16_uart_tx_data[12]),
        .S(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[13] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_16),
        .Q(si16_uart_tx_data[13]),
        .R(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[14] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_15),
        .Q(si16_uart_tx_data[14]),
        .R(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[15] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_14),
        .Q(si16_uart_tx_data[15]),
        .R(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(onboard_ad_control_n_12),
        .Q(si16_uart_tx_data[1]),
        .R(1'b0));
  FDRE \r_si16_uart_tx_data_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(onboard_ad_control_n_11),
        .Q(si16_uart_tx_data[2]),
        .R(1'b0));
  FDRE \r_si16_uart_tx_data_reg[3] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_26),
        .Q(si16_uart_tx_data[3]),
        .R(onboard_ad_control_n_10));
  FDSE \r_si16_uart_tx_data_reg[4] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_25),
        .Q(si16_uart_tx_data[4]),
        .S(onboard_ad_control_n_10));
  FDSE \r_si16_uart_tx_data_reg[5] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_24),
        .Q(si16_uart_tx_data[5]),
        .S(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[6] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_23),
        .Q(si16_uart_tx_data[6]),
        .R(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[7] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_22),
        .Q(si16_uart_tx_data[7]),
        .R(onboard_ad_control_n_10));
  FDRE \r_si16_uart_tx_data_reg[8] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_21),
        .Q(si16_uart_tx_data[8]),
        .R(onboard_ad_control_n_10));
  FDSE \r_si16_uart_tx_data_reg[9] 
       (.C(clk_out1),
        .CE(onboard_ad_control_n_5),
        .D(onboard_ad_control_n_20),
        .Q(si16_uart_tx_data[9]),
        .S(onboard_ad_control_n_10));
  FDRE r_si_uart_start_event_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(onboard_ad_control_n_8),
        .Q(si_uart_start_event),
        .R(1'b0));
  sw_supply_ctrl supply_ctrl_layer
       (.E(uart_n_27),
        .Q({p_0_in0,uart_n_8,r_so16_uart_rx_data}),
        .clk_out1(clk_out1),
        .\jihuu_reg[rstn]_0 (supply_ctrl_layer_n_8),
        .\jihuu_reg[rstn]_1 (uart_n_6),
        .lopt(lopt),
        .lopt_1(NLW_supply_ctrl_layer_lopt_1_UNCONNECTED),
        .lopt_2(lopt_8),
        .lopt_3(NLW_supply_ctrl_layer_lopt_3_UNCONNECTED),
        .lopt_4(lopt_10),
        .lopt_5(NLW_supply_ctrl_layer_lopt_5_UNCONNECTED),
        .\po2_pfc_pwm[ac1] (\po2_pfc_pwm[ac1] ),
        .\po4_dhb_pwm[pri_high] (\po4_dhb_pwm[pri_high] ),
        .\po4_dhb_pwm[pri_low] (\po4_dhb_pwm[pri_low] ),
        .\po4_dhb_pwm[sec_high] (\po4_dhb_pwm[sec_high] ),
        .\po4_dhb_pwm[sec_low] (\po4_dhb_pwm[sec_low] ),
        .\po4_ht_pwm[pri_high] (\po4_ht_pwm[pri_high] ),
        .\po4_ht_pwm[pri_low] (\po4_ht_pwm[pri_low] ),
        .\r_piu12_per_ctrl_reg[0] (\heater_control/r_piu12_per_ctrl ),
        .r_si_rstn_reg(uart_n_23),
        .r_so_uart_rx_rdy(r_so_uart_rx_rdy),
        .rstn(rstn),
        .so_ext_ad1_start(so_ext_ad1_start));
  LUT4 #(
    .INIT(16'h0008)) 
    \testidata[15]_i_1 
       (.I0(\uart1/route_rx_ready_event ),
        .I1(uart_n_5),
        .I2(uart_n_1),
        .I3(uart_n_4),
        .O(\testidata[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \testidata[7]_i_1 
       (.I0(uart_n_5),
        .I1(uart_n_1),
        .I2(\uart1/route_rx_ready_event ),
        .I3(uart_n_4),
        .O(\testidata[7]_i_1_n_0 ));
  uart_event_ctrl uart
       (.D(si16_uart_tx_data),
        .E({\testidata[15]_i_1_n_0 ,\testidata[7]_i_1_n_0 }),
        .\FSM_onehot_rx_next_state_reg[0] (uart_n_4),
        .\FSM_onehot_rx_next_state_reg[1] (uart_n_5),
        .Q({p_0_in0,uart_n_8,r_so16_uart_rx_data}),
        .clk_out1(clk_out1),
        .j_reg(uart_n_1),
        .\jeemux_reg[0] (\jeemux_reg_n_0_[0] ),
        .\jeemux_reg[1] (\jeemux_reg_n_0_[1] ),
        .\jeemux_reg[2] (\jeemux_reg_n_0_[2] ),
        .\jihuu_reg[rstn] (supply_ctrl_layer_n_8),
        .pi_uart_rx(pi_uart_rx),
        .po_uart_tx(po_uart_tx),
        .r_so_uart_rx_rdy(r_so_uart_rx_rdy),
        .\route_RX_data_out_reg[0] (uart_n_6),
        .\route_RX_data_out_reg[0]_0 (uart_n_23),
        .\route_RX_data_out_reg[0]_1 (uart_n_26),
        .\route_RX_data_out_reg[12] (\heater_control/r_piu12_per_ctrl ),
        .\route_RX_data_out_reg[13] (uart_n_27),
        .\route_RX_data_out_reg[1] (uart_n_25),
        .\route_RX_data_out_reg[2] (uart_n_24),
        .route_rx_ready_event(\uart1/route_rx_ready_event ),
        .rstn(rstn),
        .si_uart_start_event(si_uart_start_event));
endmodule

module ext_ad_control
   (SR,
    po_spi_cs_reg,
    po_ext_ad1_clk_OBUF,
    po_ext_ad2_clk_OBUF,
    clk_out1,
    so_ext_ad1_start);
  output [0:0]SR;
  output [0:0]po_spi_cs_reg;
  output po_ext_ad1_clk_OBUF;
  output po_ext_ad2_clk_OBUF;
  input clk_out1;
  input so_ext_ad1_start;

  wire [0:0]SR;
  wire clk_out1;
  wire po_ext_ad1_clk_OBUF;
  wire po_ext_ad2_clk_OBUF;
  wire [0:0]po_spi_cs_reg;
  wire so_ext_ad1_start;

  ext_ad_spi3w__parameterized1 dhb_ad_driver
       (.SR(po_spi_cs_reg),
        .clk_out1(clk_out1),
        .po_ext_ad2_clk_OBUF(po_ext_ad2_clk_OBUF),
        .so_ext_ad1_start(so_ext_ad1_start));
  ext_ad_spi3w__parameterized1_2 heater_ad_driver
       (.SR(SR),
        .clk_out1(clk_out1),
        .po_ext_ad1_clk_OBUF(po_ext_ad1_clk_OBUF),
        .so_ext_ad1_start(so_ext_ad1_start));
endmodule

module ext_ad_spi3w
   (po_spi_cs_reg_0,
    po_adb_clk_OBUF,
    E,
    \FSM_onehot_st_main_states_reg[4] ,
    so_spi_rdy_reg_0,
    D,
    \jeemux_reg[0] ,
    \b_spi_rx_reg[6]_0 ,
    \jeemux_reg[1] ,
    so_spi_rdy_reg_1,
    so_spi_rdy_reg_2,
    so_spi_rdy_reg_3,
    clk_out1,
    si_ada_start,
    Q,
    locked,
    \FSM_onehot_st_main_states_reg[0] ,
    \r_si16_uart_tx_data_reg[15] ,
    \r_si16_uart_tx_data_reg[4] ,
    \r_si16_uart_tx_data_reg[15]_0 ,
    dly_complete,
    r_si_uart_start_event,
    \r_si16_uart_tx_data_reg[15]_1 ,
    si_uart_start_event,
    zero_cross_event_reg,
    \r_si16_uart_tx_data_reg[2] ,
    \r_si16_uart_tx_data_reg[2]_0 ,
    \r_si16_uart_tx_data_reg[2]_1 ,
    \r_si16_uart_tx_data_reg[1] ,
    \r_si16_uart_tx_data_reg[0] ,
    \b_spi_rx_reg[0]_0 );
  output po_spi_cs_reg_0;
  output po_adb_clk_OBUF;
  output [0:0]E;
  output [0:0]\FSM_onehot_st_main_states_reg[4] ;
  output so_spi_rdy_reg_0;
  output [1:0]D;
  output \jeemux_reg[0] ;
  output \b_spi_rx_reg[6]_0 ;
  output \jeemux_reg[1] ;
  output so_spi_rdy_reg_1;
  output so_spi_rdy_reg_2;
  output so_spi_rdy_reg_3;
  input clk_out1;
  input si_ada_start;
  input [2:0]Q;
  input locked;
  input [4:0]\FSM_onehot_st_main_states_reg[0] ;
  input \r_si16_uart_tx_data_reg[15] ;
  input \r_si16_uart_tx_data_reg[4] ;
  input \r_si16_uart_tx_data_reg[15]_0 ;
  input dly_complete;
  input r_si_uart_start_event;
  input \r_si16_uart_tx_data_reg[15]_1 ;
  input si_uart_start_event;
  input zero_cross_event_reg;
  input \r_si16_uart_tx_data_reg[2] ;
  input \r_si16_uart_tx_data_reg[2]_0 ;
  input [2:0]\r_si16_uart_tx_data_reg[2]_1 ;
  input \r_si16_uart_tx_data_reg[1] ;
  input \r_si16_uart_tx_data_reg[0] ;
  input [0:0]\b_spi_rx_reg[0]_0 ;

  wire [1:0]D;
  wire [0:0]E;
  wire \FSM_onehot_st_main_states[2]_i_2_n_0 ;
  wire \FSM_onehot_st_main_states[2]_i_3_n_0 ;
  wire \FSM_onehot_st_main_states[2]_i_4_n_0 ;
  wire \FSM_onehot_st_main_states[4]_i_4_n_0 ;
  wire [4:0]\FSM_onehot_st_main_states_reg[0] ;
  wire [0:0]\FSM_onehot_st_main_states_reg[4] ;
  wire [2:0]Q;
  wire \b_spi_rx[0]_i_1__0_n_0 ;
  wire \b_spi_rx[10]_i_1__0_n_0 ;
  wire \b_spi_rx[11]_i_1__0_n_0 ;
  wire \b_spi_rx[12]_i_1__0_n_0 ;
  wire \b_spi_rx[13]_i_1__0_n_0 ;
  wire \b_spi_rx[14]_i_1__0_n_0 ;
  wire \b_spi_rx[15]_i_1__0_n_0 ;
  wire \b_spi_rx[1]_i_1__0_n_0 ;
  wire \b_spi_rx[2]_i_1__0_n_0 ;
  wire \b_spi_rx[3]_i_1__0_n_0 ;
  wire \b_spi_rx[4]_i_1__0_n_0 ;
  wire \b_spi_rx[5]_i_1__0_n_0 ;
  wire \b_spi_rx[6]_i_1__0_n_0 ;
  wire \b_spi_rx[7]_i_1__0_n_0 ;
  wire \b_spi_rx[8]_i_1__0_n_0 ;
  wire \b_spi_rx[9]_i_1__0_n_0 ;
  wire [0:0]\b_spi_rx_reg[0]_0 ;
  wire \b_spi_rx_reg[6]_0 ;
  wire clk_out1;
  wire dly_complete;
  wire [4:1]i0__0;
  wire \i[0]_i_1__0_n_0 ;
  wire \i[4]_i_1__0_n_0 ;
  wire [4:0]i_reg;
  wire \jeemux_reg[0] ;
  wire \jeemux_reg[1] ;
  wire locked;
  wire po_adb_clk_OBUF;
  wire po_spi_clk_out_i_1__0_n_0;
  wire po_spi_clk_out_i_2__0_n_0;
  wire po_spi_cs_i_1__0_n_0;
  wire po_spi_cs_i_2__0_n_0;
  wire po_spi_cs_reg_0;
  wire \r_si16_uart_tx_data_reg[0] ;
  wire \r_si16_uart_tx_data_reg[15] ;
  wire \r_si16_uart_tx_data_reg[15]_0 ;
  wire \r_si16_uart_tx_data_reg[15]_1 ;
  wire \r_si16_uart_tx_data_reg[1] ;
  wire \r_si16_uart_tx_data_reg[2] ;
  wire \r_si16_uart_tx_data_reg[2]_0 ;
  wire [2:0]\r_si16_uart_tx_data_reg[2]_1 ;
  wire \r_si16_uart_tx_data_reg[4] ;
  wire r_si_uart_start_event;
  wire \r_so_adb_ctrl[ad_rdy_trigger] ;
  wire [15:0]\r_so_adb_ctrl[std16_ad_bus] ;
  wire si_ada_start;
  wire si_uart_start_event;
  wire so_sh_rdy_i_1_n_0;
  wire so_sh_rdy_i_2_n_0;
  wire so_spi_rdy_i_1_n_0;
  wire so_spi_rdy_reg_0;
  wire so_spi_rdy_reg_1;
  wire so_spi_rdy_reg_2;
  wire so_spi_rdy_reg_3;
  wire \spi_clk_div[1]_i_2__0_n_0 ;
  wire \spi_clk_div[3]_i_2__0_n_0 ;
  wire \spi_clk_div[7]_i_2__0_n_0 ;
  wire [7:0]spi_clk_div__0;
  wire [7:0]spi_clk_div_reg;
  wire \spi_process_count[0]_i_1__0_n_0 ;
  wire \spi_process_count[1]_i_1__0_n_0 ;
  wire \spi_process_count[2]_i_1__2_n_0 ;
  wire \spi_process_count[3]_i_1__2_n_0 ;
  wire \spi_process_count[4]_i_1__2_n_0 ;
  wire \spi_process_count[5]_i_1__2_n_0 ;
  wire \spi_process_count[6]_i_1__2_n_0 ;
  wire \spi_process_count[7]_i_1__2_n_0 ;
  wire \spi_process_count[7]_i_2__2_n_0 ;
  wire [7:0]spi_process_count_reg;
  wire zero_cross_event1_out;
  wire zero_cross_event_i_2_n_0;
  wire zero_cross_event_i_3_n_0;
  wire zero_cross_event_i_5_n_0;
  wire zero_cross_event_reg;

  LUT5 #(
    .INIT(32'hBBABAAAA)) 
    \FSM_onehot_st_main_states[1]_i_1 
       (.I0(\FSM_onehot_st_main_states_reg[0] [0]),
        .I1(\FSM_onehot_st_main_states[2]_i_2_n_0 ),
        .I2(\r_so_adb_ctrl[std16_ad_bus] [11]),
        .I3(\FSM_onehot_st_main_states[2]_i_3_n_0 ),
        .I4(\FSM_onehot_st_main_states_reg[0] [1]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hF4F4FFF444444444)) 
    \FSM_onehot_st_main_states[2]_i_1 
       (.I0(dly_complete),
        .I1(\FSM_onehot_st_main_states_reg[0] [2]),
        .I2(\FSM_onehot_st_main_states[2]_i_2_n_0 ),
        .I3(\r_so_adb_ctrl[std16_ad_bus] [11]),
        .I4(\FSM_onehot_st_main_states[2]_i_3_n_0 ),
        .I5(\FSM_onehot_st_main_states_reg[0] [1]),
        .O(D[1]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_st_main_states[2]_i_2 
       (.I0(\r_so_adb_ctrl[std16_ad_bus] [12]),
        .I1(\r_so_adb_ctrl[std16_ad_bus] [14]),
        .I2(\r_so_adb_ctrl[std16_ad_bus] [15]),
        .I3(\r_so_adb_ctrl[std16_ad_bus] [13]),
        .O(\FSM_onehot_st_main_states[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000000001555FFFF)) 
    \FSM_onehot_st_main_states[2]_i_3 
       (.I0(\r_so_adb_ctrl[std16_ad_bus] [7]),
        .I1(\r_so_adb_ctrl[std16_ad_bus] [5]),
        .I2(\r_so_adb_ctrl[std16_ad_bus] [6]),
        .I3(zero_cross_event_i_2_n_0),
        .I4(\r_so_adb_ctrl[std16_ad_bus] [8]),
        .I5(\FSM_onehot_st_main_states[2]_i_4_n_0 ),
        .O(\FSM_onehot_st_main_states[2]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_onehot_st_main_states[2]_i_4 
       (.I0(\r_so_adb_ctrl[std16_ad_bus] [10]),
        .I1(\r_so_adb_ctrl[std16_ad_bus] [9]),
        .O(\FSM_onehot_st_main_states[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_onehot_st_main_states[4]_i_2 
       (.I0(\FSM_onehot_st_main_states_reg[0] [4]),
        .I1(\FSM_onehot_st_main_states_reg[0] [2]),
        .I2(\FSM_onehot_st_main_states_reg[0] [3]),
        .I3(\FSM_onehot_st_main_states_reg[0] [0]),
        .I4(\FSM_onehot_st_main_states[4]_i_4_n_0 ),
        .O(\FSM_onehot_st_main_states_reg[4] ));
  LUT5 #(
    .INIT(32'h08000000)) 
    \FSM_onehot_st_main_states[4]_i_4 
       (.I0(Q[0]),
        .I1(Q[2]),
        .I2(Q[1]),
        .I3(\FSM_onehot_st_main_states_reg[0] [1]),
        .I4(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .O(\FSM_onehot_st_main_states[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \b_spi_rx[0]_i_1__0 
       (.I0(i_reg[3]),
        .I1(i_reg[2]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1__0_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[0]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000100000000000)) 
    \b_spi_rx[10]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[10]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \b_spi_rx[11]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[11]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \b_spi_rx[12]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1__0_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[12]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h2000000000000000)) 
    \b_spi_rx[13]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1__0_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[13]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \b_spi_rx[14]_i_1__0 
       (.I0(i_reg[2]),
        .I1(i_reg[0]),
        .I2(i_reg[1]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[14]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000020000000000)) 
    \b_spi_rx[15]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[3]),
        .I3(i_reg[4]),
        .I4(i_reg[2]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[15]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0010000000000000)) 
    \b_spi_rx[1]_i_1__0 
       (.I0(i_reg[3]),
        .I1(i_reg[2]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1__0_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[1]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \b_spi_rx[2]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[2]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \b_spi_rx[3]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[3]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000100000000000)) 
    \b_spi_rx[4]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1__0_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[4]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \b_spi_rx[5]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1__0_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[5]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000010000000000)) 
    \b_spi_rx[6]_i_1__0 
       (.I0(i_reg[1]),
        .I1(i_reg[0]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[6]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \b_spi_rx[7]_i_1__0 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[3]),
        .I3(i_reg[2]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1__0_n_0 ),
        .O(\b_spi_rx[7]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0004000000000000)) 
    \b_spi_rx[8]_i_1__0 
       (.I0(i_reg[2]),
        .I1(i_reg[3]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1__0_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[8]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0040000000000000)) 
    \b_spi_rx[9]_i_1__0 
       (.I0(i_reg[2]),
        .I1(i_reg[3]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1__0_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[9]_i_1__0_n_0 ));
  FDRE \b_spi_rx_reg[0] 
       (.C(clk_out1),
        .CE(\b_spi_rx[0]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [0]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[10] 
       (.C(clk_out1),
        .CE(\b_spi_rx[10]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [10]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[11] 
       (.C(clk_out1),
        .CE(\b_spi_rx[11]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [11]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[12] 
       (.C(clk_out1),
        .CE(\b_spi_rx[12]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [12]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[13] 
       (.C(clk_out1),
        .CE(\b_spi_rx[13]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [13]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[14] 
       (.C(clk_out1),
        .CE(\b_spi_rx[14]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [14]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[15] 
       (.C(clk_out1),
        .CE(\b_spi_rx[15]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [15]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[1] 
       (.C(clk_out1),
        .CE(\b_spi_rx[1]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [1]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[2] 
       (.C(clk_out1),
        .CE(\b_spi_rx[2]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [2]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[3] 
       (.C(clk_out1),
        .CE(\b_spi_rx[3]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [3]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[4] 
       (.C(clk_out1),
        .CE(\b_spi_rx[4]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [4]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[5] 
       (.C(clk_out1),
        .CE(\b_spi_rx[5]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [5]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[6] 
       (.C(clk_out1),
        .CE(\b_spi_rx[6]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [6]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[7] 
       (.C(clk_out1),
        .CE(\b_spi_rx[7]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [7]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[8] 
       (.C(clk_out1),
        .CE(\b_spi_rx[8]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [8]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[9] 
       (.C(clk_out1),
        .CE(\b_spi_rx[9]_i_1__0_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\r_so_adb_ctrl[std16_ad_bus] [9]),
        .R(po_spi_cs_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \i[0]_i_1__0 
       (.I0(i_reg[0]),
        .O(\i[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \i[1]_i_1__0 
       (.I0(i_reg[1]),
        .I1(i_reg[0]),
        .O(i0__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \i[2]_i_1__0 
       (.I0(i_reg[2]),
        .I1(i_reg[0]),
        .I2(i_reg[1]),
        .O(i0__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \i[3]_i_1__0 
       (.I0(i_reg[3]),
        .I1(i_reg[1]),
        .I2(i_reg[0]),
        .I3(i_reg[2]),
        .O(i0__0[3]));
  LUT4 #(
    .INIT(16'h0004)) 
    \i[4]_i_1__0 
       (.I0(spi_clk_div_reg[3]),
        .I1(spi_clk_div_reg[2]),
        .I2(spi_clk_div_reg[0]),
        .I3(\spi_clk_div[3]_i_2__0_n_0 ),
        .O(\i[4]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'hFFFE0001)) 
    \i[4]_i_2__0 
       (.I0(i_reg[3]),
        .I1(i_reg[1]),
        .I2(i_reg[0]),
        .I3(i_reg[2]),
        .I4(i_reg[4]),
        .O(i0__0[4]));
  FDSE \i_reg[0] 
       (.C(clk_out1),
        .CE(\i[4]_i_1__0_n_0 ),
        .D(\i[0]_i_1__0_n_0 ),
        .Q(i_reg[0]),
        .S(po_spi_cs_reg_0));
  FDSE \i_reg[1] 
       (.C(clk_out1),
        .CE(\i[4]_i_1__0_n_0 ),
        .D(i0__0[1]),
        .Q(i_reg[1]),
        .S(po_spi_cs_reg_0));
  FDSE \i_reg[2] 
       (.C(clk_out1),
        .CE(\i[4]_i_1__0_n_0 ),
        .D(i0__0[2]),
        .Q(i_reg[2]),
        .S(po_spi_cs_reg_0));
  FDSE \i_reg[3] 
       (.C(clk_out1),
        .CE(\i[4]_i_1__0_n_0 ),
        .D(i0__0[3]),
        .Q(i_reg[3]),
        .S(po_spi_cs_reg_0));
  FDRE \i_reg[4] 
       (.C(clk_out1),
        .CE(\i[4]_i_1__0_n_0 ),
        .D(i0__0[4]),
        .Q(i_reg[4]),
        .R(po_spi_cs_reg_0));
  LUT4 #(
    .INIT(16'h4F70)) 
    po_spi_clk_out_i_1__0
       (.I0(si_ada_start),
        .I1(po_spi_cs_reg_0),
        .I2(po_spi_clk_out_i_2__0_n_0),
        .I3(po_adb_clk_OBUF),
        .O(po_spi_clk_out_i_1__0_n_0));
  LUT5 #(
    .INIT(32'hABAAAABA)) 
    po_spi_clk_out_i_2__0
       (.I0(po_spi_cs_reg_0),
        .I1(\spi_clk_div[3]_i_2__0_n_0 ),
        .I2(spi_clk_div_reg[2]),
        .I3(spi_clk_div_reg[3]),
        .I4(spi_clk_div_reg[0]),
        .O(po_spi_clk_out_i_2__0_n_0));
  FDRE po_spi_clk_out_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_clk_out_i_1__0_n_0),
        .Q(po_adb_clk_OBUF),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h55550C00)) 
    po_spi_cs_i_1__0
       (.I0(si_ada_start),
        .I1(po_spi_cs_i_2__0_n_0),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(po_spi_cs_reg_0),
        .O(po_spi_cs_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    po_spi_cs_i_2__0
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[5]),
        .I2(spi_process_count_reg[2]),
        .I3(spi_process_count_reg[3]),
        .I4(spi_process_count_reg[6]),
        .I5(spi_process_count_reg[7]),
        .O(po_spi_cs_i_2__0_n_0));
  FDRE po_spi_cs_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_cs_i_1__0_n_0),
        .Q(po_spi_cs_reg_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hBBBBABBB8888A888)) 
    \r_si16_uart_tx_data[0]_i_1 
       (.I0(\r_si16_uart_tx_data_reg[0] ),
        .I1(so_spi_rdy_reg_0),
        .I2(\r_si16_uart_tx_data_reg[2]_0 ),
        .I3(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .I4(\r_si16_uart_tx_data_reg[15]_1 ),
        .I5(\r_si16_uart_tx_data_reg[2]_1 [0]),
        .O(so_spi_rdy_reg_3));
  LUT4 #(
    .INIT(16'h0100)) 
    \r_si16_uart_tx_data[15]_i_1 
       (.I0(\r_si16_uart_tx_data_reg[15] ),
        .I1(\r_si16_uart_tx_data_reg[15]_0 ),
        .I2(\r_si16_uart_tx_data_reg[15]_1 ),
        .I3(so_spi_rdy_reg_0),
        .O(\jeemux_reg[1] ));
  LUT6 #(
    .INIT(64'h0000000800002002)) 
    \r_si16_uart_tx_data[15]_i_2 
       (.I0(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .I1(Q[2]),
        .I2(\r_si16_uart_tx_data_reg[15] ),
        .I3(Q[1]),
        .I4(\r_si16_uart_tx_data_reg[4] ),
        .I5(\r_si16_uart_tx_data_reg[15]_0 ),
        .O(so_spi_rdy_reg_0));
  LUT6 #(
    .INIT(64'hBBBBABBB8888A888)) 
    \r_si16_uart_tx_data[1]_i_1 
       (.I0(\r_si16_uart_tx_data_reg[1] ),
        .I1(so_spi_rdy_reg_0),
        .I2(\r_si16_uart_tx_data_reg[2]_0 ),
        .I3(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .I4(\r_si16_uart_tx_data_reg[15]_1 ),
        .I5(\r_si16_uart_tx_data_reg[2]_1 [1]),
        .O(so_spi_rdy_reg_2));
  LUT6 #(
    .INIT(64'hBBBBABBB8888A888)) 
    \r_si16_uart_tx_data[2]_i_1 
       (.I0(\r_si16_uart_tx_data_reg[2] ),
        .I1(so_spi_rdy_reg_0),
        .I2(\r_si16_uart_tx_data_reg[2]_0 ),
        .I3(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .I4(\r_si16_uart_tx_data_reg[15]_1 ),
        .I5(\r_si16_uart_tx_data_reg[2]_1 [2]),
        .O(so_spi_rdy_reg_1));
  LUT6 #(
    .INIT(64'hEAAAFFFF2AAA0000)) 
    r_si_uart_start_event_i_1
       (.I0(r_si_uart_start_event),
        .I1(\r_si16_uart_tx_data_reg[15]_1 ),
        .I2(\r_si16_uart_tx_data_reg[15] ),
        .I3(\r_si16_uart_tx_data_reg[15]_0 ),
        .I4(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .I5(si_uart_start_event),
        .O(\jeemux_reg[0] ));
  LUT5 #(
    .INIT(32'h8B888888)) 
    so_sh_rdy_i_1
       (.I0(E),
        .I1(po_spi_cs_reg_0),
        .I2(spi_process_count_reg[1]),
        .I3(spi_process_count_reg[0]),
        .I4(so_sh_rdy_i_2_n_0),
        .O(so_sh_rdy_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    so_sh_rdy_i_2
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[5]),
        .I2(spi_process_count_reg[2]),
        .I3(spi_process_count_reg[3]),
        .I4(spi_process_count_reg[7]),
        .I5(spi_process_count_reg[6]),
        .O(so_sh_rdy_i_2_n_0));
  FDRE so_sh_rdy_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(so_sh_rdy_i_1_n_0),
        .Q(E),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h40)) 
    so_spi_rdy_i_1
       (.I0(spi_process_count_reg[0]),
        .I1(spi_process_count_reg[1]),
        .I2(po_spi_cs_i_2__0_n_0),
        .O(so_spi_rdy_i_1_n_0));
  FDRE so_spi_rdy_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(so_spi_rdy_i_1_n_0),
        .Q(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .R(po_spi_cs_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \spi_clk_div[0]_i_1__0 
       (.I0(spi_clk_div_reg[0]),
        .O(spi_clk_div__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h00FFFD00)) 
    \spi_clk_div[1]_i_1__0 
       (.I0(spi_clk_div_reg[3]),
        .I1(\spi_clk_div[1]_i_2__0_n_0 ),
        .I2(spi_clk_div_reg[2]),
        .I3(spi_clk_div_reg[0]),
        .I4(spi_clk_div_reg[1]),
        .O(spi_clk_div__0[1]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_clk_div[1]_i_2__0 
       (.I0(spi_clk_div_reg[5]),
        .I1(spi_clk_div_reg[4]),
        .I2(spi_clk_div_reg[7]),
        .I3(spi_clk_div_reg[6]),
        .O(\spi_clk_div[1]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \spi_clk_div[2]_i_1__0 
       (.I0(spi_clk_div_reg[1]),
        .I1(spi_clk_div_reg[0]),
        .I2(spi_clk_div_reg[2]),
        .O(spi_clk_div__0[2]));
  LUT5 #(
    .INIT(32'h3FAFC000)) 
    \spi_clk_div[3]_i_1__0 
       (.I0(\spi_clk_div[3]_i_2__0_n_0 ),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(spi_clk_div_reg[3]),
        .O(spi_clk_div__0[3]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_clk_div[3]_i_2__0 
       (.I0(spi_clk_div_reg[6]),
        .I1(spi_clk_div_reg[7]),
        .I2(spi_clk_div_reg[4]),
        .I3(spi_clk_div_reg[5]),
        .I4(spi_clk_div_reg[1]),
        .O(\spi_clk_div[3]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \spi_clk_div[4]_i_1__0 
       (.I0(spi_clk_div_reg[3]),
        .I1(spi_clk_div_reg[2]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[1]),
        .I4(spi_clk_div_reg[4]),
        .O(spi_clk_div__0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \spi_clk_div[5]_i_1__0 
       (.I0(spi_clk_div_reg[4]),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(spi_clk_div_reg[3]),
        .I5(spi_clk_div_reg[5]),
        .O(spi_clk_div__0[5]));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_clk_div[6]_i_1__0 
       (.I0(\spi_clk_div[7]_i_2__0_n_0 ),
        .I1(spi_clk_div_reg[6]),
        .O(spi_clk_div__0[6]));
  LUT3 #(
    .INIT(8'hD2)) 
    \spi_clk_div[7]_i_1__0 
       (.I0(spi_clk_div_reg[6]),
        .I1(\spi_clk_div[7]_i_2__0_n_0 ),
        .I2(spi_clk_div_reg[7]),
        .O(spi_clk_div__0[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \spi_clk_div[7]_i_2__0 
       (.I0(spi_clk_div_reg[4]),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(spi_clk_div_reg[3]),
        .I5(spi_clk_div_reg[5]),
        .O(\spi_clk_div[7]_i_2__0_n_0 ));
  FDRE \spi_clk_div_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[0]),
        .Q(spi_clk_div_reg[0]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[1]),
        .Q(spi_clk_div_reg[1]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[2]),
        .Q(spi_clk_div_reg[2]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[3]),
        .Q(spi_clk_div_reg[3]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[4]),
        .Q(spi_clk_div_reg[4]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[5]),
        .Q(spi_clk_div_reg[5]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[6]),
        .Q(spi_clk_div_reg[6]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__0[7]),
        .Q(spi_clk_div_reg[7]),
        .R(po_spi_cs_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \spi_process_count[0]_i_1__0 
       (.I0(spi_process_count_reg[0]),
        .O(\spi_process_count[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \spi_process_count[1]_i_1__0 
       (.I0(spi_process_count_reg[0]),
        .I1(spi_process_count_reg[1]),
        .O(\spi_process_count[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \spi_process_count[2]_i_1__2 
       (.I0(spi_process_count_reg[1]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[2]),
        .O(\spi_process_count[2]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \spi_process_count[3]_i_1__2 
       (.I0(spi_process_count_reg[2]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[1]),
        .I3(spi_process_count_reg[3]),
        .O(\spi_process_count[3]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \spi_process_count[4]_i_1__2 
       (.I0(spi_process_count_reg[3]),
        .I1(spi_process_count_reg[1]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[2]),
        .I4(spi_process_count_reg[4]),
        .O(\spi_process_count[4]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \spi_process_count[5]_i_1__2 
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[2]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(spi_process_count_reg[3]),
        .I5(spi_process_count_reg[5]),
        .O(\spi_process_count[5]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \spi_process_count[6]_i_1__2 
       (.I0(\spi_process_count[7]_i_2__2_n_0 ),
        .I1(spi_process_count_reg[6]),
        .O(\spi_process_count[6]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \spi_process_count[7]_i_1__2 
       (.I0(spi_process_count_reg[6]),
        .I1(\spi_process_count[7]_i_2__2_n_0 ),
        .I2(spi_process_count_reg[7]),
        .O(\spi_process_count[7]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \spi_process_count[7]_i_2__2 
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[2]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(spi_process_count_reg[3]),
        .I5(spi_process_count_reg[5]),
        .O(\spi_process_count[7]_i_2__2_n_0 ));
  FDRE \spi_process_count_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[0]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[0]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[1]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[1]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[2]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[2]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[3]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[3]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[4]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[4]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[5]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[5]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[6]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[6]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[7]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[7]),
        .R(po_spi_cs_reg_0));
  LUT5 #(
    .INIT(32'h07FF0700)) 
    zero_cross_event_i_1
       (.I0(zero_cross_event_i_2_n_0),
        .I1(\r_so_adb_ctrl[std16_ad_bus] [6]),
        .I2(zero_cross_event_i_3_n_0),
        .I3(zero_cross_event1_out),
        .I4(zero_cross_event_reg),
        .O(\b_spi_rx_reg[6]_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    zero_cross_event_i_2
       (.I0(\r_so_adb_ctrl[std16_ad_bus] [2]),
        .I1(\r_so_adb_ctrl[std16_ad_bus] [3]),
        .I2(\r_so_adb_ctrl[std16_ad_bus] [1]),
        .I3(\r_so_adb_ctrl[std16_ad_bus] [0]),
        .I4(\r_so_adb_ctrl[std16_ad_bus] [4]),
        .O(zero_cross_event_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFEEEEF)) 
    zero_cross_event_i_3
       (.I0(\FSM_onehot_st_main_states[2]_i_4_n_0 ),
        .I1(zero_cross_event_i_5_n_0),
        .I2(\r_so_adb_ctrl[std16_ad_bus] [6]),
        .I3(\r_so_adb_ctrl[std16_ad_bus] [4]),
        .I4(\r_so_adb_ctrl[std16_ad_bus] [5]),
        .I5(\FSM_onehot_st_main_states[2]_i_2_n_0 ),
        .O(zero_cross_event_i_3_n_0));
  LUT6 #(
    .INIT(64'h0400000000000000)) 
    zero_cross_event_i_4
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(\r_so_adb_ctrl[ad_rdy_trigger] ),
        .I4(locked),
        .I5(\FSM_onehot_st_main_states_reg[0] [3]),
        .O(zero_cross_event1_out));
  LUT3 #(
    .INIT(8'hFB)) 
    zero_cross_event_i_5
       (.I0(\r_so_adb_ctrl[std16_ad_bus] [8]),
        .I1(\r_so_adb_ctrl[std16_ad_bus] [11]),
        .I2(\r_so_adb_ctrl[std16_ad_bus] [7]),
        .O(zero_cross_event_i_5_n_0));
endmodule

(* ORIG_REF_NAME = "ext_ad_spi3w" *) 
module ext_ad_spi3w_1
   (po_spi_cs_reg_0,
    po_ada_clk_OBUF,
    \b_spi_rx_reg[1]_0 ,
    \jeemux_reg[1] ,
    \jeemux_reg[2] ,
    \b_spi_rx_reg[15]_0 ,
    clk_out1,
    si_ada_start,
    Q,
    \r_si16_uart_tx_data_reg[1] ,
    \r_si16_uart_tx_data_reg[1]_0 ,
    \r_si16_uart_tx_data_reg[1]_1 ,
    \b_spi_rx_reg[0]_0 );
  output po_spi_cs_reg_0;
  output po_ada_clk_OBUF;
  output \b_spi_rx_reg[1]_0 ;
  output \jeemux_reg[1] ;
  output \jeemux_reg[2] ;
  output [12:0]\b_spi_rx_reg[15]_0 ;
  input clk_out1;
  input si_ada_start;
  input [2:0]Q;
  input \r_si16_uart_tx_data_reg[1] ;
  input \r_si16_uart_tx_data_reg[1]_0 ;
  input \r_si16_uart_tx_data_reg[1]_1 ;
  input [0:0]\b_spi_rx_reg[0]_0 ;

  wire [2:0]Q;
  wire \b_spi_rx[0]_i_1_n_0 ;
  wire \b_spi_rx[10]_i_1_n_0 ;
  wire \b_spi_rx[11]_i_1_n_0 ;
  wire \b_spi_rx[12]_i_1_n_0 ;
  wire \b_spi_rx[13]_i_1_n_0 ;
  wire \b_spi_rx[14]_i_1_n_0 ;
  wire \b_spi_rx[15]_i_1_n_0 ;
  wire \b_spi_rx[1]_i_1_n_0 ;
  wire \b_spi_rx[2]_i_1_n_0 ;
  wire \b_spi_rx[3]_i_1_n_0 ;
  wire \b_spi_rx[4]_i_1_n_0 ;
  wire \b_spi_rx[5]_i_1_n_0 ;
  wire \b_spi_rx[6]_i_1_n_0 ;
  wire \b_spi_rx[7]_i_1_n_0 ;
  wire \b_spi_rx[8]_i_1_n_0 ;
  wire \b_spi_rx[9]_i_1_n_0 ;
  wire [0:0]\b_spi_rx_reg[0]_0 ;
  wire [12:0]\b_spi_rx_reg[15]_0 ;
  wire \b_spi_rx_reg[1]_0 ;
  wire \b_spi_rx_reg_n_0_[0] ;
  wire \b_spi_rx_reg_n_0_[1] ;
  wire \b_spi_rx_reg_n_0_[2] ;
  wire clk_out1;
  wire [4:1]i0;
  wire \i[0]_i_1_n_0 ;
  wire \i[4]_i_1_n_0 ;
  wire [4:0]i_reg;
  wire \jeemux_reg[1] ;
  wire \jeemux_reg[2] ;
  wire [7:0]plusOp;
  wire po_ada_clk_OBUF;
  wire po_spi_clk_out_i_1_n_0;
  wire po_spi_clk_out_i_2_n_0;
  wire po_spi_cs_i_1_n_0;
  wire po_spi_cs_i_2_n_0;
  wire po_spi_cs_reg_0;
  wire \r_si16_uart_tx_data_reg[1] ;
  wire \r_si16_uart_tx_data_reg[1]_0 ;
  wire \r_si16_uart_tx_data_reg[1]_1 ;
  wire si_ada_start;
  wire [7:0]spi_clk_div;
  wire \spi_clk_div[1]_i_2_n_0 ;
  wire \spi_clk_div[3]_i_2_n_0 ;
  wire \spi_clk_div[7]_i_2_n_0 ;
  wire [7:0]spi_clk_div_reg;
  wire \spi_process_count[7]_i_2__1_n_0 ;
  wire [7:0]spi_process_count_reg;

  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \b_spi_rx[0]_i_1 
       (.I0(i_reg[3]),
        .I1(i_reg[2]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000100000000000)) 
    \b_spi_rx[10]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \b_spi_rx[11]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \b_spi_rx[12]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2000000000000000)) 
    \b_spi_rx[13]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \b_spi_rx[14]_i_1 
       (.I0(i_reg[2]),
        .I1(i_reg[0]),
        .I2(i_reg[1]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000020000000000)) 
    \b_spi_rx[15]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[3]),
        .I3(i_reg[4]),
        .I4(i_reg[2]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0010000000000000)) 
    \b_spi_rx[1]_i_1 
       (.I0(i_reg[3]),
        .I1(i_reg[2]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \b_spi_rx[2]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \b_spi_rx[3]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000100000000000)) 
    \b_spi_rx[4]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \b_spi_rx[5]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[4]),
        .I2(\i[4]_i_1_n_0 ),
        .I3(i_reg[1]),
        .I4(i_reg[3]),
        .I5(i_reg[2]),
        .O(\b_spi_rx[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000010000000000)) 
    \b_spi_rx[6]_i_1 
       (.I0(i_reg[1]),
        .I1(i_reg[0]),
        .I2(i_reg[2]),
        .I3(i_reg[3]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \b_spi_rx[7]_i_1 
       (.I0(i_reg[0]),
        .I1(i_reg[1]),
        .I2(i_reg[3]),
        .I3(i_reg[2]),
        .I4(i_reg[4]),
        .I5(\i[4]_i_1_n_0 ),
        .O(\b_spi_rx[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0004000000000000)) 
    \b_spi_rx[8]_i_1 
       (.I0(i_reg[2]),
        .I1(i_reg[3]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0040000000000000)) 
    \b_spi_rx[9]_i_1 
       (.I0(i_reg[2]),
        .I1(i_reg[3]),
        .I2(i_reg[0]),
        .I3(i_reg[4]),
        .I4(\i[4]_i_1_n_0 ),
        .I5(i_reg[1]),
        .O(\b_spi_rx[9]_i_1_n_0 ));
  FDRE \b_spi_rx_reg[0] 
       (.C(clk_out1),
        .CE(\b_spi_rx[0]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg_n_0_[0] ),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[10] 
       (.C(clk_out1),
        .CE(\b_spi_rx[10]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [7]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[11] 
       (.C(clk_out1),
        .CE(\b_spi_rx[11]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [8]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[12] 
       (.C(clk_out1),
        .CE(\b_spi_rx[12]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [9]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[13] 
       (.C(clk_out1),
        .CE(\b_spi_rx[13]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [10]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[14] 
       (.C(clk_out1),
        .CE(\b_spi_rx[14]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [11]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[15] 
       (.C(clk_out1),
        .CE(\b_spi_rx[15]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [12]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[1] 
       (.C(clk_out1),
        .CE(\b_spi_rx[1]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg_n_0_[1] ),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[2] 
       (.C(clk_out1),
        .CE(\b_spi_rx[2]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg_n_0_[2] ),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[3] 
       (.C(clk_out1),
        .CE(\b_spi_rx[3]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [0]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[4] 
       (.C(clk_out1),
        .CE(\b_spi_rx[4]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [1]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[5] 
       (.C(clk_out1),
        .CE(\b_spi_rx[5]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [2]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[6] 
       (.C(clk_out1),
        .CE(\b_spi_rx[6]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [3]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[7] 
       (.C(clk_out1),
        .CE(\b_spi_rx[7]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [4]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[8] 
       (.C(clk_out1),
        .CE(\b_spi_rx[8]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [5]),
        .R(po_spi_cs_reg_0));
  FDRE \b_spi_rx_reg[9] 
       (.C(clk_out1),
        .CE(\b_spi_rx[9]_i_1_n_0 ),
        .D(\b_spi_rx_reg[0]_0 ),
        .Q(\b_spi_rx_reg[15]_0 [6]),
        .R(po_spi_cs_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \i[0]_i_1 
       (.I0(i_reg[0]),
        .O(\i[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \i[1]_i_1 
       (.I0(i_reg[1]),
        .I1(i_reg[0]),
        .O(i0[1]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \i[2]_i_1 
       (.I0(i_reg[2]),
        .I1(i_reg[0]),
        .I2(i_reg[1]),
        .O(i0[2]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \i[3]_i_1 
       (.I0(i_reg[3]),
        .I1(i_reg[1]),
        .I2(i_reg[0]),
        .I3(i_reg[2]),
        .O(i0[3]));
  LUT4 #(
    .INIT(16'h0004)) 
    \i[4]_i_1 
       (.I0(spi_clk_div_reg[3]),
        .I1(spi_clk_div_reg[2]),
        .I2(spi_clk_div_reg[0]),
        .I3(\spi_clk_div[3]_i_2_n_0 ),
        .O(\i[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFE0001)) 
    \i[4]_i_2 
       (.I0(i_reg[3]),
        .I1(i_reg[1]),
        .I2(i_reg[0]),
        .I3(i_reg[2]),
        .I4(i_reg[4]),
        .O(i0[4]));
  FDSE \i_reg[0] 
       (.C(clk_out1),
        .CE(\i[4]_i_1_n_0 ),
        .D(\i[0]_i_1_n_0 ),
        .Q(i_reg[0]),
        .S(po_spi_cs_reg_0));
  FDSE \i_reg[1] 
       (.C(clk_out1),
        .CE(\i[4]_i_1_n_0 ),
        .D(i0[1]),
        .Q(i_reg[1]),
        .S(po_spi_cs_reg_0));
  FDSE \i_reg[2] 
       (.C(clk_out1),
        .CE(\i[4]_i_1_n_0 ),
        .D(i0[2]),
        .Q(i_reg[2]),
        .S(po_spi_cs_reg_0));
  FDSE \i_reg[3] 
       (.C(clk_out1),
        .CE(\i[4]_i_1_n_0 ),
        .D(i0[3]),
        .Q(i_reg[3]),
        .S(po_spi_cs_reg_0));
  FDRE \i_reg[4] 
       (.C(clk_out1),
        .CE(\i[4]_i_1_n_0 ),
        .D(i0[4]),
        .Q(i_reg[4]),
        .R(po_spi_cs_reg_0));
  LUT4 #(
    .INIT(16'h4F70)) 
    po_spi_clk_out_i_1
       (.I0(si_ada_start),
        .I1(po_spi_cs_reg_0),
        .I2(po_spi_clk_out_i_2_n_0),
        .I3(po_ada_clk_OBUF),
        .O(po_spi_clk_out_i_1_n_0));
  LUT5 #(
    .INIT(32'hABAAAABA)) 
    po_spi_clk_out_i_2
       (.I0(po_spi_cs_reg_0),
        .I1(\spi_clk_div[3]_i_2_n_0 ),
        .I2(spi_clk_div_reg[2]),
        .I3(spi_clk_div_reg[3]),
        .I4(spi_clk_div_reg[0]),
        .O(po_spi_clk_out_i_2_n_0));
  FDRE po_spi_clk_out_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_clk_out_i_1_n_0),
        .Q(po_ada_clk_OBUF),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h55550C00)) 
    po_spi_cs_i_1
       (.I0(si_ada_start),
        .I1(po_spi_cs_i_2_n_0),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(po_spi_cs_reg_0),
        .O(po_spi_cs_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    po_spi_cs_i_2
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[5]),
        .I2(spi_process_count_reg[2]),
        .I3(spi_process_count_reg[3]),
        .I4(spi_process_count_reg[6]),
        .I5(spi_process_count_reg[7]),
        .O(po_spi_cs_i_2_n_0));
  FDRE po_spi_cs_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_cs_i_1_n_0),
        .Q(po_spi_cs_reg_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFF09F701)) 
    \r_si16_uart_tx_data[0]_i_2 
       (.I0(\r_si16_uart_tx_data_reg[1] ),
        .I1(\r_si16_uart_tx_data_reg[1]_0 ),
        .I2(\r_si16_uart_tx_data_reg[1]_1 ),
        .I3(\b_spi_rx_reg_n_0_[0] ),
        .I4(Q[0]),
        .O(\jeemux_reg[1] ));
  LUT5 #(
    .INIT(32'hCAAACAA0)) 
    \r_si16_uart_tx_data[1]_i_2 
       (.I0(\b_spi_rx_reg_n_0_[1] ),
        .I1(Q[1]),
        .I2(\r_si16_uart_tx_data_reg[1] ),
        .I3(\r_si16_uart_tx_data_reg[1]_0 ),
        .I4(\r_si16_uart_tx_data_reg[1]_1 ),
        .O(\b_spi_rx_reg[1]_0 ));
  LUT5 #(
    .INIT(32'hCECDC4CD)) 
    \r_si16_uart_tx_data[2]_i_2 
       (.I0(\r_si16_uart_tx_data_reg[1]_0 ),
        .I1(\b_spi_rx_reg_n_0_[2] ),
        .I2(\r_si16_uart_tx_data_reg[1]_1 ),
        .I3(\r_si16_uart_tx_data_reg[1] ),
        .I4(Q[2]),
        .O(\jeemux_reg[2] ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \spi_clk_div[0]_i_1 
       (.I0(spi_clk_div_reg[0]),
        .O(spi_clk_div[0]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h00FFFD00)) 
    \spi_clk_div[1]_i_1 
       (.I0(spi_clk_div_reg[3]),
        .I1(\spi_clk_div[1]_i_2_n_0 ),
        .I2(spi_clk_div_reg[2]),
        .I3(spi_clk_div_reg[0]),
        .I4(spi_clk_div_reg[1]),
        .O(spi_clk_div[1]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_clk_div[1]_i_2 
       (.I0(spi_clk_div_reg[5]),
        .I1(spi_clk_div_reg[4]),
        .I2(spi_clk_div_reg[7]),
        .I3(spi_clk_div_reg[6]),
        .O(\spi_clk_div[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \spi_clk_div[2]_i_1 
       (.I0(spi_clk_div_reg[1]),
        .I1(spi_clk_div_reg[0]),
        .I2(spi_clk_div_reg[2]),
        .O(spi_clk_div[2]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h3FAFC000)) 
    \spi_clk_div[3]_i_1 
       (.I0(\spi_clk_div[3]_i_2_n_0 ),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(spi_clk_div_reg[3]),
        .O(spi_clk_div[3]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_clk_div[3]_i_2 
       (.I0(spi_clk_div_reg[6]),
        .I1(spi_clk_div_reg[7]),
        .I2(spi_clk_div_reg[4]),
        .I3(spi_clk_div_reg[5]),
        .I4(spi_clk_div_reg[1]),
        .O(\spi_clk_div[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \spi_clk_div[4]_i_1 
       (.I0(spi_clk_div_reg[3]),
        .I1(spi_clk_div_reg[2]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[1]),
        .I4(spi_clk_div_reg[4]),
        .O(spi_clk_div[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \spi_clk_div[5]_i_1 
       (.I0(spi_clk_div_reg[4]),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(spi_clk_div_reg[3]),
        .I5(spi_clk_div_reg[5]),
        .O(spi_clk_div[5]));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_clk_div[6]_i_1 
       (.I0(\spi_clk_div[7]_i_2_n_0 ),
        .I1(spi_clk_div_reg[6]),
        .O(spi_clk_div[6]));
  LUT3 #(
    .INIT(8'hD2)) 
    \spi_clk_div[7]_i_1 
       (.I0(spi_clk_div_reg[6]),
        .I1(\spi_clk_div[7]_i_2_n_0 ),
        .I2(spi_clk_div_reg[7]),
        .O(spi_clk_div[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \spi_clk_div[7]_i_2 
       (.I0(spi_clk_div_reg[4]),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(spi_clk_div_reg[3]),
        .I5(spi_clk_div_reg[5]),
        .O(\spi_clk_div[7]_i_2_n_0 ));
  FDRE \spi_clk_div_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[0]),
        .Q(spi_clk_div_reg[0]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[1]),
        .Q(spi_clk_div_reg[1]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[2]),
        .Q(spi_clk_div_reg[2]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[3]),
        .Q(spi_clk_div_reg[3]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[4]),
        .Q(spi_clk_div_reg[4]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[5]),
        .Q(spi_clk_div_reg[5]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[6]),
        .Q(spi_clk_div_reg[6]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_clk_div_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div[7]),
        .Q(spi_clk_div_reg[7]),
        .R(po_spi_cs_reg_0));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_process_count[0]_i_1 
       (.I0(spi_process_count_reg[0]),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \spi_process_count[1]_i_1 
       (.I0(spi_process_count_reg[0]),
        .I1(spi_process_count_reg[1]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \spi_process_count[2]_i_1__1 
       (.I0(spi_process_count_reg[1]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[2]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \spi_process_count[3]_i_1__1 
       (.I0(spi_process_count_reg[2]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[1]),
        .I3(spi_process_count_reg[3]),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \spi_process_count[4]_i_1__1 
       (.I0(spi_process_count_reg[3]),
        .I1(spi_process_count_reg[1]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[2]),
        .I4(spi_process_count_reg[4]),
        .O(plusOp[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \spi_process_count[5]_i_1__1 
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[2]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(spi_process_count_reg[3]),
        .I5(spi_process_count_reg[5]),
        .O(plusOp[5]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \spi_process_count[6]_i_1__1 
       (.I0(\spi_process_count[7]_i_2__1_n_0 ),
        .I1(spi_process_count_reg[6]),
        .O(plusOp[6]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \spi_process_count[7]_i_1__1 
       (.I0(spi_process_count_reg[6]),
        .I1(\spi_process_count[7]_i_2__1_n_0 ),
        .I2(spi_process_count_reg[7]),
        .O(plusOp[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \spi_process_count[7]_i_2__1 
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[2]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(spi_process_count_reg[3]),
        .I5(spi_process_count_reg[5]),
        .O(\spi_process_count[7]_i_2__1_n_0 ));
  FDRE \spi_process_count_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[0]),
        .Q(spi_process_count_reg[0]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[1]),
        .Q(spi_process_count_reg[1]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[2]),
        .Q(spi_process_count_reg[2]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[3]),
        .Q(spi_process_count_reg[3]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[4]),
        .Q(spi_process_count_reg[4]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[5]),
        .Q(spi_process_count_reg[5]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[6]),
        .Q(spi_process_count_reg[6]),
        .R(po_spi_cs_reg_0));
  FDRE \spi_process_count_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[7]),
        .Q(spi_process_count_reg[7]),
        .R(po_spi_cs_reg_0));
endmodule

(* ORIG_REF_NAME = "ext_ad_spi3w" *) 
module ext_ad_spi3w__parameterized1
   (SR,
    po_ext_ad2_clk_OBUF,
    clk_out1,
    so_ext_ad1_start);
  output [0:0]SR;
  output po_ext_ad2_clk_OBUF;
  input clk_out1;
  input so_ext_ad1_start;

  wire [0:0]SR;
  wire clk_out1;
  wire po_ext_ad2_clk_OBUF;
  wire po_spi_clk_out_i_1__2_n_0;
  wire po_spi_cs_i_1__2_n_0;
  wire po_spi_cs_i_2__2_n_0;
  wire so_ext_ad1_start;
  wire \spi_clk_div[1]_i_1__2_n_0 ;
  wire [2:0]spi_clk_div__2;
  wire [2:0]spi_clk_div_reg;
  wire \spi_process_count[0]_i_1__2_n_0 ;
  wire \spi_process_count[1]_i_1__2_n_0 ;
  wire \spi_process_count[2]_i_1__0_n_0 ;
  wire \spi_process_count[3]_i_1__0_n_0 ;
  wire \spi_process_count[4]_i_1__0_n_0 ;
  wire \spi_process_count[5]_i_1__0_n_0 ;
  wire \spi_process_count[6]_i_1__0_n_0 ;
  wire \spi_process_count[7]_i_1__0_n_0 ;
  wire \spi_process_count[7]_i_2__0_n_0 ;
  wire [7:0]spi_process_count_reg;

  LUT6 #(
    .INIT(64'h55553FFF5555C000)) 
    po_spi_clk_out_i_1__2
       (.I0(so_ext_ad1_start),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(SR),
        .I5(po_ext_ad2_clk_OBUF),
        .O(po_spi_clk_out_i_1__2_n_0));
  FDRE po_spi_clk_out_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_clk_out_i_1__2_n_0),
        .Q(po_ext_ad2_clk_OBUF),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h7444444444444444)) 
    po_spi_cs_i_1__2
       (.I0(so_ext_ad1_start),
        .I1(SR),
        .I2(po_spi_cs_i_2__2_n_0),
        .I3(spi_process_count_reg[2]),
        .I4(spi_process_count_reg[0]),
        .I5(spi_process_count_reg[1]),
        .O(po_spi_cs_i_1__2_n_0));
  LUT5 #(
    .INIT(32'h04000000)) 
    po_spi_cs_i_2__2
       (.I0(spi_process_count_reg[3]),
        .I1(spi_process_count_reg[5]),
        .I2(spi_process_count_reg[4]),
        .I3(spi_process_count_reg[7]),
        .I4(spi_process_count_reg[6]),
        .O(po_spi_cs_i_2__2_n_0));
  FDRE po_spi_cs_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_cs_i_1__2_n_0),
        .Q(SR),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_clk_div[0]_i_1__2 
       (.I0(spi_clk_div_reg[0]),
        .O(spi_clk_div__2[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \spi_clk_div[1]_i_1__2 
       (.I0(spi_clk_div_reg[1]),
        .I1(spi_clk_div_reg[0]),
        .O(\spi_clk_div[1]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \spi_clk_div[2]_i_1__2 
       (.I0(spi_clk_div_reg[1]),
        .I1(spi_clk_div_reg[0]),
        .I2(spi_clk_div_reg[2]),
        .O(spi_clk_div__2[2]));
  FDRE \spi_clk_div_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__2[0]),
        .Q(spi_clk_div_reg[0]),
        .R(SR));
  FDRE \spi_clk_div_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_clk_div[1]_i_1__2_n_0 ),
        .Q(spi_clk_div_reg[1]),
        .R(SR));
  FDRE \spi_clk_div_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__2[2]),
        .Q(spi_clk_div_reg[2]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \spi_process_count[0]_i_1__2 
       (.I0(spi_process_count_reg[0]),
        .O(\spi_process_count[0]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \spi_process_count[1]_i_1__2 
       (.I0(spi_process_count_reg[0]),
        .I1(spi_process_count_reg[1]),
        .O(\spi_process_count[1]_i_1__2_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \spi_process_count[2]_i_1__0 
       (.I0(spi_process_count_reg[1]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[2]),
        .O(\spi_process_count[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \spi_process_count[3]_i_1__0 
       (.I0(spi_process_count_reg[2]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[1]),
        .I3(spi_process_count_reg[3]),
        .O(\spi_process_count[3]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \spi_process_count[4]_i_1__0 
       (.I0(spi_process_count_reg[3]),
        .I1(spi_process_count_reg[1]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[2]),
        .I4(spi_process_count_reg[4]),
        .O(\spi_process_count[4]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \spi_process_count[5]_i_1__0 
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[2]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(spi_process_count_reg[3]),
        .I5(spi_process_count_reg[5]),
        .O(\spi_process_count[5]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'hF7FF0800)) 
    \spi_process_count[6]_i_1__0 
       (.I0(spi_process_count_reg[5]),
        .I1(spi_process_count_reg[3]),
        .I2(\spi_process_count[7]_i_2__0_n_0 ),
        .I3(spi_process_count_reg[4]),
        .I4(spi_process_count_reg[6]),
        .O(\spi_process_count[6]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \spi_process_count[7]_i_1__0 
       (.I0(spi_process_count_reg[6]),
        .I1(spi_process_count_reg[4]),
        .I2(\spi_process_count[7]_i_2__0_n_0 ),
        .I3(spi_process_count_reg[3]),
        .I4(spi_process_count_reg[5]),
        .I5(spi_process_count_reg[7]),
        .O(\spi_process_count[7]_i_1__0_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    \spi_process_count[7]_i_2__0 
       (.I0(spi_process_count_reg[1]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[2]),
        .O(\spi_process_count[7]_i_2__0_n_0 ));
  FDRE \spi_process_count_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[0]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[0]),
        .R(SR));
  FDRE \spi_process_count_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[1]_i_1__2_n_0 ),
        .Q(spi_process_count_reg[1]),
        .R(SR));
  FDRE \spi_process_count_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[2]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[2]),
        .R(SR));
  FDRE \spi_process_count_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[3]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[3]),
        .R(SR));
  FDRE \spi_process_count_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[4]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[4]),
        .R(SR));
  FDRE \spi_process_count_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[5]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[5]),
        .R(SR));
  FDRE \spi_process_count_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[6]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[6]),
        .R(SR));
  FDRE \spi_process_count_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[7]_i_1__0_n_0 ),
        .Q(spi_process_count_reg[7]),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "ext_ad_spi3w" *) 
module ext_ad_spi3w__parameterized1_2
   (SR,
    po_ext_ad1_clk_OBUF,
    clk_out1,
    so_ext_ad1_start);
  output [0:0]SR;
  output po_ext_ad1_clk_OBUF;
  input clk_out1;
  input so_ext_ad1_start;

  wire [0:0]SR;
  wire clk_out1;
  wire po_ext_ad1_clk_OBUF;
  wire po_spi_clk_out_i_1__1_n_0;
  wire po_spi_cs_i_1__1_n_0;
  wire po_spi_cs_i_2__1_n_0;
  wire so_ext_ad1_start;
  wire \spi_clk_div[1]_i_1__1_n_0 ;
  wire [2:0]spi_clk_div__1;
  wire [2:0]spi_clk_div_reg;
  wire \spi_process_count[0]_i_1__1_n_0 ;
  wire \spi_process_count[1]_i_1__1_n_0 ;
  wire \spi_process_count[2]_i_1_n_0 ;
  wire \spi_process_count[3]_i_1_n_0 ;
  wire \spi_process_count[4]_i_1_n_0 ;
  wire \spi_process_count[5]_i_1_n_0 ;
  wire \spi_process_count[6]_i_1_n_0 ;
  wire \spi_process_count[7]_i_1_n_0 ;
  wire \spi_process_count[7]_i_2_n_0 ;
  wire [7:0]spi_process_count_reg;

  LUT6 #(
    .INIT(64'h55553FFF5555C000)) 
    po_spi_clk_out_i_1__1
       (.I0(so_ext_ad1_start),
        .I1(spi_clk_div_reg[1]),
        .I2(spi_clk_div_reg[0]),
        .I3(spi_clk_div_reg[2]),
        .I4(SR),
        .I5(po_ext_ad1_clk_OBUF),
        .O(po_spi_clk_out_i_1__1_n_0));
  FDRE po_spi_clk_out_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_clk_out_i_1__1_n_0),
        .Q(po_ext_ad1_clk_OBUF),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h7444444444444444)) 
    po_spi_cs_i_1__1
       (.I0(so_ext_ad1_start),
        .I1(SR),
        .I2(po_spi_cs_i_2__1_n_0),
        .I3(spi_process_count_reg[2]),
        .I4(spi_process_count_reg[0]),
        .I5(spi_process_count_reg[1]),
        .O(po_spi_cs_i_1__1_n_0));
  LUT5 #(
    .INIT(32'h04000000)) 
    po_spi_cs_i_2__1
       (.I0(spi_process_count_reg[3]),
        .I1(spi_process_count_reg[5]),
        .I2(spi_process_count_reg[4]),
        .I3(spi_process_count_reg[7]),
        .I4(spi_process_count_reg[6]),
        .O(po_spi_cs_i_2__1_n_0));
  FDRE po_spi_cs_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(po_spi_cs_i_1__1_n_0),
        .Q(SR),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_clk_div[0]_i_1__1 
       (.I0(spi_clk_div_reg[0]),
        .O(spi_clk_div__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \spi_clk_div[1]_i_1__1 
       (.I0(spi_clk_div_reg[1]),
        .I1(spi_clk_div_reg[0]),
        .O(\spi_clk_div[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \spi_clk_div[2]_i_1__1 
       (.I0(spi_clk_div_reg[1]),
        .I1(spi_clk_div_reg[0]),
        .I2(spi_clk_div_reg[2]),
        .O(spi_clk_div__1[2]));
  FDRE \spi_clk_div_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__1[0]),
        .Q(spi_clk_div_reg[0]),
        .R(SR));
  FDRE \spi_clk_div_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_clk_div[1]_i_1__1_n_0 ),
        .Q(spi_clk_div_reg[1]),
        .R(SR));
  FDRE \spi_clk_div_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(spi_clk_div__1[2]),
        .Q(spi_clk_div_reg[2]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \spi_process_count[0]_i_1__1 
       (.I0(spi_process_count_reg[0]),
        .O(\spi_process_count[0]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \spi_process_count[1]_i_1__1 
       (.I0(spi_process_count_reg[0]),
        .I1(spi_process_count_reg[1]),
        .O(\spi_process_count[1]_i_1__1_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \spi_process_count[2]_i_1 
       (.I0(spi_process_count_reg[1]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[2]),
        .O(\spi_process_count[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \spi_process_count[3]_i_1 
       (.I0(spi_process_count_reg[2]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[1]),
        .I3(spi_process_count_reg[3]),
        .O(\spi_process_count[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \spi_process_count[4]_i_1 
       (.I0(spi_process_count_reg[3]),
        .I1(spi_process_count_reg[1]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[2]),
        .I4(spi_process_count_reg[4]),
        .O(\spi_process_count[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \spi_process_count[5]_i_1 
       (.I0(spi_process_count_reg[4]),
        .I1(spi_process_count_reg[2]),
        .I2(spi_process_count_reg[0]),
        .I3(spi_process_count_reg[1]),
        .I4(spi_process_count_reg[3]),
        .I5(spi_process_count_reg[5]),
        .O(\spi_process_count[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF7FF0800)) 
    \spi_process_count[6]_i_1 
       (.I0(spi_process_count_reg[5]),
        .I1(spi_process_count_reg[3]),
        .I2(\spi_process_count[7]_i_2_n_0 ),
        .I3(spi_process_count_reg[4]),
        .I4(spi_process_count_reg[6]),
        .O(\spi_process_count[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \spi_process_count[7]_i_1 
       (.I0(spi_process_count_reg[6]),
        .I1(spi_process_count_reg[4]),
        .I2(\spi_process_count[7]_i_2_n_0 ),
        .I3(spi_process_count_reg[3]),
        .I4(spi_process_count_reg[5]),
        .I5(spi_process_count_reg[7]),
        .O(\spi_process_count[7]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    \spi_process_count[7]_i_2 
       (.I0(spi_process_count_reg[1]),
        .I1(spi_process_count_reg[0]),
        .I2(spi_process_count_reg[2]),
        .O(\spi_process_count[7]_i_2_n_0 ));
  FDRE \spi_process_count_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[0]_i_1__1_n_0 ),
        .Q(spi_process_count_reg[0]),
        .R(SR));
  FDRE \spi_process_count_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[1]_i_1__1_n_0 ),
        .Q(spi_process_count_reg[1]),
        .R(SR));
  FDRE \spi_process_count_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[2]_i_1_n_0 ),
        .Q(spi_process_count_reg[2]),
        .R(SR));
  FDRE \spi_process_count_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[3]_i_1_n_0 ),
        .Q(spi_process_count_reg[3]),
        .R(SR));
  FDRE \spi_process_count_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[4]_i_1_n_0 ),
        .Q(spi_process_count_reg[4]),
        .R(SR));
  FDRE \spi_process_count_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[5]_i_1_n_0 ),
        .Q(spi_process_count_reg[5]),
        .R(SR));
  FDRE \spi_process_count_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[6]_i_1_n_0 ),
        .Q(spi_process_count_reg[6]),
        .R(SR));
  FDRE \spi_process_count_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\spi_process_count[7]_i_1_n_0 ),
        .Q(spi_process_count_reg[7]),
        .R(SR));
endmodule

module freq_modulator
   (\po4_ht_pwm[pri_high] ,
    \po4_ht_pwm[pri_low] ,
    clk_out1,
    \FSM_onehot_st_startup_reg[2]_0 ,
    Q,
    lopt,
    lopt_1,
    lopt_2,
    lopt_3);
  output \po4_ht_pwm[pri_high] ;
  output \po4_ht_pwm[pri_low] ;
  input clk_out1;
  input \FSM_onehot_st_startup_reg[2]_0 ;
  input [11:0]Q;
  output lopt;
  output lopt_1;
  output lopt_2;
  output lopt_3;

  wire \FSM_onehot_st_startup[0]_i_1_n_0 ;
  wire \FSM_onehot_st_startup[1]_i_1_n_0 ;
  wire \FSM_onehot_st_startup[2]_i_1_n_0 ;
  wire \FSM_onehot_st_startup[2]_i_2_n_0 ;
  wire \FSM_onehot_st_startup[2]_i_3_n_0 ;
  wire \FSM_onehot_st_startup[2]_i_4_n_0 ;
  wire \FSM_onehot_st_startup_reg[2]_0 ;
  wire \FSM_onehot_st_startup_reg_n_0_[1] ;
  wire [11:0]Q;
  wire clear;
  wire clk_out1;
  wire [13:0]dly_cntr;
  wire \dly_cntr[0]_i_1_n_0 ;
  wire \dly_cntr[13]_i_1_n_0 ;
  wire \dly_cntr[13]_i_3_n_0 ;
  wire \dly_cntr[13]_i_4_n_0 ;
  wire \dly_cntr[13]_i_5_n_0 ;
  wire dly_cntr_0;
  wire [2:0]dt_states;
  wire [11:0]jipijee;
  wire \jipijee[11]_i_2_n_0 ;
  wire \jipijee[11]_i_3_n_0 ;
  wire jipijee_1;
  wire [2:0]p_0_in;
  wire p_1_in;
  wire plusOp_carry__0_n_0;
  wire plusOp_carry__0_n_4;
  wire plusOp_carry__0_n_5;
  wire plusOp_carry__0_n_6;
  wire plusOp_carry__0_n_7;
  wire plusOp_carry__1_n_0;
  wire plusOp_carry__1_n_4;
  wire plusOp_carry__1_n_5;
  wire plusOp_carry__1_n_6;
  wire plusOp_carry__1_n_7;
  wire plusOp_carry__2_n_7;
  wire plusOp_carry_n_0;
  wire plusOp_carry_n_4;
  wire plusOp_carry_n_5;
  wire plusOp_carry_n_6;
  wire plusOp_carry_n_7;
  wire \po4_ht_pwm[pri_high] ;
  wire \po4_ht_pwm[pri_high]_i_1_n_0 ;
  wire \po4_ht_pwm[pri_low] ;
  wire \po4_ht_pwm_reg[pri_high]_lopt_replica_1 ;
  wire \po4_ht_pwm_reg[pri_low]_lopt_replica_1 ;
  wire \r_po2_ht_pri_pwm[0]_i_1_n_0 ;
  wire \r_po2_ht_pri_pwm[1]_i_1_n_0 ;
  wire \r_po2_ht_pri_pwm_reg_n_0_[0] ;
  wire [11:0]reg_u12_carrier;
  wire s_pulse;
  wire s_pulse_i_10_n_0;
  wire s_pulse_i_11_n_0;
  wire s_pulse_i_12_n_0;
  wire s_pulse_i_13_n_0;
  wire s_pulse_i_14_n_0;
  wire s_pulse_i_3_n_0;
  wire s_pulse_i_4_n_0;
  wire s_pulse_i_5_n_0;
  wire s_pulse_i_6_n_0;
  wire s_pulse_i_7_n_0;
  wire s_pulse_i_8_n_0;
  wire s_pulse_i_9_n_0;
  wire s_pulse_reg_i_1_n_2;
  wire s_pulse_reg_i_2_n_0;
  wire [10:0]u12_car_per_2;
  wire u12_carrier0_carry__0_i_1_n_0;
  wire u12_carrier0_carry__0_i_2_n_0;
  wire u12_carrier0_carry__0_i_3_n_0;
  wire u12_carrier0_carry__0_i_4_n_0;
  wire u12_carrier0_carry_i_1_n_0;
  wire u12_carrier0_carry_i_2_n_0;
  wire u12_carrier0_carry_i_3_n_0;
  wire u12_carrier0_carry_i_4_n_0;
  wire u12_carrier0_carry_i_5_n_0;
  wire u12_carrier0_carry_i_6_n_0;
  wire u12_carrier0_carry_i_7_n_0;
  wire u12_carrier0_carry_i_8_n_0;
  wire u12_carrier0_carry_n_0;
  wire \u12_carrier[0]_i_2_n_0 ;
  wire [11:0]u12_carrier_reg;
  wire \u12_carrier_reg[0]_i_1_n_0 ;
  wire \u12_carrier_reg[0]_i_1_n_4 ;
  wire \u12_carrier_reg[0]_i_1_n_5 ;
  wire \u12_carrier_reg[0]_i_1_n_6 ;
  wire \u12_carrier_reg[0]_i_1_n_7 ;
  wire \u12_carrier_reg[4]_i_1_n_0 ;
  wire \u12_carrier_reg[4]_i_1_n_4 ;
  wire \u12_carrier_reg[4]_i_1_n_5 ;
  wire \u12_carrier_reg[4]_i_1_n_6 ;
  wire \u12_carrier_reg[4]_i_1_n_7 ;
  wire \u12_carrier_reg[8]_i_1_n_4 ;
  wire \u12_carrier_reg[8]_i_1_n_5 ;
  wire \u12_carrier_reg[8]_i_1_n_6 ;
  wire \u12_carrier_reg[8]_i_1_n_7 ;
  wire u12_deadtime;
  wire \u12_deadtime[0]_i_3_n_0 ;
  wire \u12_deadtime[0]_i_4_n_0 ;
  wire \u12_deadtime[0]_i_5_n_0 ;
  wire \u12_deadtime[0]_i_6_n_0 ;
  wire \u12_deadtime[4]_i_2_n_0 ;
  wire \u12_deadtime[4]_i_3_n_0 ;
  wire \u12_deadtime[4]_i_4_n_0 ;
  wire \u12_deadtime[4]_i_5_n_0 ;
  wire \u12_deadtime[8]_i_2_n_0 ;
  wire \u12_deadtime[8]_i_3_n_0 ;
  wire \u12_deadtime[8]_i_4_n_0 ;
  wire \u12_deadtime[8]_i_5_n_0 ;
  wire [11:0]u12_deadtime_reg;
  wire \u12_deadtime_reg[0]_i_2_n_0 ;
  wire \u12_deadtime_reg[0]_i_2_n_4 ;
  wire \u12_deadtime_reg[0]_i_2_n_5 ;
  wire \u12_deadtime_reg[0]_i_2_n_6 ;
  wire \u12_deadtime_reg[0]_i_2_n_7 ;
  wire \u12_deadtime_reg[4]_i_1_n_0 ;
  wire \u12_deadtime_reg[4]_i_1_n_4 ;
  wire \u12_deadtime_reg[4]_i_1_n_5 ;
  wire \u12_deadtime_reg[4]_i_1_n_6 ;
  wire \u12_deadtime_reg[4]_i_1_n_7 ;
  wire \u12_deadtime_reg[8]_i_1_n_4 ;
  wire \u12_deadtime_reg[8]_i_1_n_5 ;
  wire \u12_deadtime_reg[8]_i_1_n_6 ;
  wire \u12_deadtime_reg[8]_i_1_n_7 ;
  wire u12_dt_dly1_carry__0_i_1_n_0;
  wire u12_dt_dly1_carry__0_i_2_n_0;
  wire u12_dt_dly1_carry__0_i_3_n_0;
  wire u12_dt_dly1_carry__0_i_4_n_0;
  wire u12_dt_dly1_carry__0_n_2;
  wire u12_dt_dly1_carry_i_1_n_0;
  wire u12_dt_dly1_carry_i_2_n_0;
  wire u12_dt_dly1_carry_i_3_n_0;
  wire u12_dt_dly1_carry_i_4_n_0;
  wire u12_dt_dly1_carry_i_5_n_0;
  wire u12_dt_dly1_carry_i_6_n_0;
  wire u12_dt_dly1_carry_i_7_n_0;
  wire u12_dt_dly1_carry_i_8_n_0;
  wire u12_dt_dly1_carry_n_0;
  wire \u12_dt_dly[0]_i_1_n_0 ;
  wire \u12_dt_dly[11]_i_1_n_0 ;
  wire \u12_dt_dly_reg[11]_i_2_n_5 ;
  wire \u12_dt_dly_reg[11]_i_2_n_6 ;
  wire \u12_dt_dly_reg[11]_i_2_n_7 ;
  wire \u12_dt_dly_reg[4]_i_1_n_0 ;
  wire \u12_dt_dly_reg[4]_i_1_n_4 ;
  wire \u12_dt_dly_reg[4]_i_1_n_5 ;
  wire \u12_dt_dly_reg[4]_i_1_n_6 ;
  wire \u12_dt_dly_reg[4]_i_1_n_7 ;
  wire \u12_dt_dly_reg[8]_i_1_n_0 ;
  wire \u12_dt_dly_reg[8]_i_1_n_4 ;
  wire \u12_dt_dly_reg[8]_i_1_n_5 ;
  wire \u12_dt_dly_reg[8]_i_1_n_6 ;
  wire \u12_dt_dly_reg[8]_i_1_n_7 ;
  wire \u12_dt_dly_reg_n_0_[0] ;
  wire \u12_dt_dly_reg_n_0_[10] ;
  wire \u12_dt_dly_reg_n_0_[11] ;
  wire \u12_dt_dly_reg_n_0_[1] ;
  wire \u12_dt_dly_reg_n_0_[2] ;
  wire \u12_dt_dly_reg_n_0_[3] ;
  wire \u12_dt_dly_reg_n_0_[4] ;
  wire \u12_dt_dly_reg_n_0_[5] ;
  wire \u12_dt_dly_reg_n_0_[6] ;
  wire \u12_dt_dly_reg_n_0_[7] ;
  wire \u12_dt_dly_reg_n_0_[8] ;
  wire \u12_dt_dly_reg_n_0_[9] ;
  wire [11:0]u12_period;
  wire u12_period0;
  wire u12_period_2;
  wire [2:0]NLW_plusOp_carry_CO_UNCONNECTED;
  wire [2:0]NLW_plusOp_carry__0_CO_UNCONNECTED;
  wire [2:0]NLW_plusOp_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_plusOp_carry__2_CO_UNCONNECTED;
  wire [3:1]NLW_plusOp_carry__2_O_UNCONNECTED;
  wire [3:0]NLW_s_pulse_reg_i_1_CO_UNCONNECTED;
  wire [3:0]NLW_s_pulse_reg_i_1_O_UNCONNECTED;
  wire [2:0]NLW_s_pulse_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_s_pulse_reg_i_2_O_UNCONNECTED;
  wire [2:0]NLW_u12_carrier0_carry_CO_UNCONNECTED;
  wire [3:0]NLW_u12_carrier0_carry_O_UNCONNECTED;
  wire [3:0]NLW_u12_carrier0_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_u12_carrier0_carry__0_O_UNCONNECTED;
  wire [2:0]\NLW_u12_carrier_reg[0]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_u12_carrier_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_u12_carrier_reg[8]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_u12_deadtime_reg[0]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_u12_deadtime_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_u12_deadtime_reg[8]_i_1_CO_UNCONNECTED ;
  wire [2:0]NLW_u12_dt_dly1_carry_CO_UNCONNECTED;
  wire [3:0]NLW_u12_dt_dly1_carry_O_UNCONNECTED;
  wire [3:0]NLW_u12_dt_dly1_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_u12_dt_dly1_carry__0_O_UNCONNECTED;
  wire [3:0]\NLW_u12_dt_dly_reg[11]_i_2_CO_UNCONNECTED ;
  wire [3:3]\NLW_u12_dt_dly_reg[11]_i_2_O_UNCONNECTED ;
  wire [2:0]\NLW_u12_dt_dly_reg[4]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_u12_dt_dly_reg[8]_i_1_CO_UNCONNECTED ;

  assign lopt = \po4_ht_pwm_reg[pri_high]_lopt_replica_1 ;
  assign lopt_2 = \po4_ht_pwm_reg[pri_low]_lopt_replica_1 ;
  LUT4 #(
    .INIT(16'h0F0E)) 
    \FSM_onehot_st_startup[0]_i_1 
       (.I0(u12_period0),
        .I1(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .I2(\FSM_onehot_st_startup_reg[2]_0 ),
        .I3(u12_period_2),
        .O(\FSM_onehot_st_startup[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'hC888)) 
    \FSM_onehot_st_startup[1]_i_1 
       (.I0(u12_period0),
        .I1(\FSM_onehot_st_startup_reg[2]_0 ),
        .I2(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .I3(\FSM_onehot_st_startup[2]_i_2_n_0 ),
        .O(\FSM_onehot_st_startup[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'h13001000)) 
    \FSM_onehot_st_startup[2]_i_1 
       (.I0(\FSM_onehot_st_startup[2]_i_2_n_0 ),
        .I1(u12_period0),
        .I2(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .I3(\FSM_onehot_st_startup_reg[2]_0 ),
        .I4(u12_period_2),
        .O(\FSM_onehot_st_startup[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
    \FSM_onehot_st_startup[2]_i_2 
       (.I0(\FSM_onehot_st_startup[2]_i_3_n_0 ),
        .I1(u12_deadtime_reg[5]),
        .I2(u12_deadtime_reg[4]),
        .I3(u12_deadtime_reg[7]),
        .I4(u12_deadtime_reg[6]),
        .I5(\FSM_onehot_st_startup[2]_i_4_n_0 ),
        .O(\FSM_onehot_st_startup[2]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_st_startup[2]_i_3 
       (.I0(u12_deadtime_reg[9]),
        .I1(u12_deadtime_reg[8]),
        .I2(u12_deadtime_reg[11]),
        .I3(u12_deadtime_reg[10]),
        .O(\FSM_onehot_st_startup[2]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_st_startup[2]_i_4 
       (.I0(u12_deadtime_reg[1]),
        .I1(u12_deadtime_reg[0]),
        .I2(u12_deadtime_reg[3]),
        .I3(u12_deadtime_reg[2]),
        .O(\FSM_onehot_st_startup[2]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "rampup:010,ready:100,init:001" *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_st_startup_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_onehot_st_startup[0]_i_1_n_0 ),
        .Q(u12_period0),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "rampup:010,ready:100,init:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_st_startup_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_onehot_st_startup[1]_i_1_n_0 ),
        .Q(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "rampup:010,ready:100,init:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_st_startup_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_onehot_st_startup[2]_i_1_n_0 ),
        .Q(u12_period_2),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h03A0)) 
    \dly_cntr[0]_i_1 
       (.I0(\dly_cntr[13]_i_3_n_0 ),
        .I1(u12_period0),
        .I2(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .I3(dly_cntr[0]),
        .O(\dly_cntr[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h222E)) 
    \dly_cntr[13]_i_1 
       (.I0(u12_period0),
        .I1(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .I2(\dly_cntr[13]_i_3_n_0 ),
        .I3(dly_cntr[0]),
        .O(\dly_cntr[13]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \dly_cntr[13]_i_2 
       (.I0(u12_period0),
        .I1(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .O(dly_cntr_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFBFF)) 
    \dly_cntr[13]_i_3 
       (.I0(\dly_cntr[13]_i_4_n_0 ),
        .I1(dly_cntr[4]),
        .I2(dly_cntr[5]),
        .I3(dly_cntr[6]),
        .I4(dly_cntr[7]),
        .I5(\dly_cntr[13]_i_5_n_0 ),
        .O(\dly_cntr[13]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \dly_cntr[13]_i_4 
       (.I0(dly_cntr[8]),
        .I1(dly_cntr[9]),
        .I2(dly_cntr[11]),
        .I3(dly_cntr[10]),
        .O(\dly_cntr[13]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFDFFFFFF)) 
    \dly_cntr[13]_i_5 
       (.I0(dly_cntr[1]),
        .I1(dly_cntr[12]),
        .I2(dly_cntr[13]),
        .I3(dly_cntr[3]),
        .I4(dly_cntr[2]),
        .O(\dly_cntr[13]_i_5_n_0 ));
  FDRE \dly_cntr_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\dly_cntr[0]_i_1_n_0 ),
        .Q(dly_cntr[0]),
        .R(1'b0));
  FDRE \dly_cntr_reg[10] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__1_n_6),
        .Q(dly_cntr[10]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[11] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__1_n_5),
        .Q(dly_cntr[11]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[12] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__1_n_4),
        .Q(dly_cntr[12]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[13] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__2_n_7),
        .Q(dly_cntr[13]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[1] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry_n_7),
        .Q(dly_cntr[1]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[2] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry_n_6),
        .Q(dly_cntr[2]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[3] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry_n_5),
        .Q(dly_cntr[3]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[4] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry_n_4),
        .Q(dly_cntr[4]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[5] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__0_n_7),
        .Q(dly_cntr[5]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[6] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__0_n_6),
        .Q(dly_cntr[6]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[7] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__0_n_5),
        .Q(dly_cntr[7]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[8] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__0_n_4),
        .Q(dly_cntr[8]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  FDRE \dly_cntr_reg[9] 
       (.C(clk_out1),
        .CE(dly_cntr_0),
        .D(plusOp_carry__1_n_7),
        .Q(dly_cntr[9]),
        .R(\dly_cntr[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFD37FDC7)) 
    \dt_states[0]_i_1 
       (.I0(u12_dt_dly1_carry__0_n_2),
        .I1(dt_states[1]),
        .I2(dt_states[0]),
        .I3(dt_states[2]),
        .I4(s_pulse),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'h0074)) 
    \dt_states[1]_i_1 
       (.I0(s_pulse),
        .I1(dt_states[0]),
        .I2(dt_states[1]),
        .I3(dt_states[2]),
        .O(p_0_in[1]));
  LUT5 #(
    .INIT(32'h000AC000)) 
    \dt_states[2]_i_1 
       (.I0(u12_dt_dly1_carry__0_n_2),
        .I1(s_pulse),
        .I2(dt_states[0]),
        .I3(dt_states[1]),
        .I4(dt_states[2]),
        .O(p_0_in[2]));
  FDRE \dt_states_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(p_0_in[0]),
        .Q(dt_states[0]),
        .R(1'b0));
  FDRE \dt_states_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(p_0_in[1]),
        .Q(dt_states[1]),
        .R(1'b0));
  FDRE \dt_states_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(p_0_in[2]),
        .Q(dt_states[2]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \jipijee[11]_i_1 
       (.I0(\jipijee[11]_i_2_n_0 ),
        .I1(\jipijee[11]_i_3_n_0 ),
        .O(jipijee_1));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \jipijee[11]_i_2 
       (.I0(u12_carrier_reg[2]),
        .I1(u12_carrier_reg[3]),
        .I2(u12_carrier_reg[0]),
        .I3(u12_carrier_reg[1]),
        .I4(u12_carrier_reg[5]),
        .I5(u12_carrier_reg[4]),
        .O(\jipijee[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \jipijee[11]_i_3 
       (.I0(u12_carrier_reg[8]),
        .I1(u12_carrier_reg[9]),
        .I2(u12_carrier_reg[6]),
        .I3(u12_carrier_reg[7]),
        .I4(u12_carrier_reg[11]),
        .I5(u12_carrier_reg[10]),
        .O(\jipijee[11]_i_3_n_0 ));
  FDRE \jipijee_reg[0] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[0]),
        .Q(jipijee[0]),
        .R(1'b0));
  FDRE \jipijee_reg[10] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[10]),
        .Q(jipijee[10]),
        .R(1'b0));
  FDRE \jipijee_reg[11] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[11]),
        .Q(jipijee[11]),
        .R(1'b0));
  FDRE \jipijee_reg[1] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[1]),
        .Q(jipijee[1]),
        .R(1'b0));
  FDRE \jipijee_reg[2] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[2]),
        .Q(jipijee[2]),
        .R(1'b0));
  FDRE \jipijee_reg[3] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[3]),
        .Q(jipijee[3]),
        .R(1'b0));
  FDRE \jipijee_reg[4] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[4]),
        .Q(jipijee[4]),
        .R(1'b0));
  FDRE \jipijee_reg[5] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[5]),
        .Q(jipijee[5]),
        .R(1'b0));
  FDRE \jipijee_reg[6] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[6]),
        .Q(jipijee[6]),
        .R(1'b0));
  FDRE \jipijee_reg[7] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[7]),
        .Q(jipijee[7]),
        .R(1'b0));
  FDRE \jipijee_reg[8] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[8]),
        .Q(jipijee[8]),
        .R(1'b0));
  FDRE \jipijee_reg[9] 
       (.C(clk_out1),
        .CE(jipijee_1),
        .D(u12_period[9]),
        .Q(jipijee[9]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry
       (.CI(1'b0),
        .CO({plusOp_carry_n_0,NLW_plusOp_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(dly_cntr[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({plusOp_carry_n_4,plusOp_carry_n_5,plusOp_carry_n_6,plusOp_carry_n_7}),
        .S(dly_cntr[4:1]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry__0
       (.CI(plusOp_carry_n_0),
        .CO({plusOp_carry__0_n_0,NLW_plusOp_carry__0_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({plusOp_carry__0_n_4,plusOp_carry__0_n_5,plusOp_carry__0_n_6,plusOp_carry__0_n_7}),
        .S(dly_cntr[8:5]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry__1
       (.CI(plusOp_carry__0_n_0),
        .CO({plusOp_carry__1_n_0,NLW_plusOp_carry__1_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({plusOp_carry__1_n_4,plusOp_carry__1_n_5,plusOp_carry__1_n_6,plusOp_carry__1_n_7}),
        .S(dly_cntr[12:9]));
  CARRY4 plusOp_carry__2
       (.CI(plusOp_carry__1_n_0),
        .CO(NLW_plusOp_carry__2_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_plusOp_carry__2_O_UNCONNECTED[3:1],plusOp_carry__2_n_7}),
        .S({1'b0,1'b0,1'b0,dly_cntr[13]}));
  LUT1 #(
    .INIT(2'h1)) 
    \po4_ht_pwm[pri_high]_i_1 
       (.I0(\FSM_onehot_st_startup_reg[2]_0 ),
        .O(\po4_ht_pwm[pri_high]_i_1_n_0 ));
  FDRE \po4_ht_pwm_reg[pri_high] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_po2_ht_pri_pwm_reg_n_0_[0] ),
        .Q(\po4_ht_pwm[pri_high] ),
        .R(\po4_ht_pwm[pri_high]_i_1_n_0 ));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \po4_ht_pwm_reg[pri_high]_lopt_replica 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_po2_ht_pri_pwm_reg_n_0_[0] ),
        .Q(\po4_ht_pwm_reg[pri_high]_lopt_replica_1 ),
        .R(\po4_ht_pwm[pri_high]_i_1_n_0 ));
  FDRE \po4_ht_pwm_reg[pri_low] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(p_1_in),
        .Q(\po4_ht_pwm[pri_low] ),
        .R(\po4_ht_pwm[pri_high]_i_1_n_0 ));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \po4_ht_pwm_reg[pri_low]_lopt_replica 
       (.C(clk_out1),
        .CE(1'b1),
        .D(p_1_in),
        .Q(\po4_ht_pwm_reg[pri_low]_lopt_replica_1 ),
        .R(\po4_ht_pwm[pri_high]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hE908)) 
    \r_po2_ht_pri_pwm[0]_i_1 
       (.I0(dt_states[1]),
        .I1(dt_states[0]),
        .I2(dt_states[2]),
        .I3(\r_po2_ht_pri_pwm_reg_n_0_[0] ),
        .O(\r_po2_ht_pri_pwm[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'hE504)) 
    \r_po2_ht_pri_pwm[1]_i_1 
       (.I0(dt_states[1]),
        .I1(dt_states[0]),
        .I2(dt_states[2]),
        .I3(p_1_in),
        .O(\r_po2_ht_pri_pwm[1]_i_1_n_0 ));
  FDRE \r_po2_ht_pri_pwm_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_po2_ht_pri_pwm[0]_i_1_n_0 ),
        .Q(\r_po2_ht_pri_pwm_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \r_po2_ht_pri_pwm_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\r_po2_ht_pri_pwm[1]_i_1_n_0 ),
        .Q(p_1_in),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[0]),
        .Q(reg_u12_carrier[0]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[10]),
        .Q(reg_u12_carrier[10]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[11]),
        .Q(reg_u12_carrier[11]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[1]),
        .Q(reg_u12_carrier[1]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[2]),
        .Q(reg_u12_carrier[2]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[3]),
        .Q(reg_u12_carrier[3]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[4]),
        .Q(reg_u12_carrier[4]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[5]),
        .Q(reg_u12_carrier[5]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[6]),
        .Q(reg_u12_carrier[6]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[7]),
        .Q(reg_u12_carrier[7]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[8]),
        .Q(reg_u12_carrier[8]),
        .R(1'b0));
  FDRE \reg_u12_carrier_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_carrier_reg[9]),
        .Q(reg_u12_carrier[9]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h2F02)) 
    s_pulse_i_10
       (.I0(reg_u12_carrier[0]),
        .I1(u12_car_per_2[0]),
        .I2(u12_car_per_2[1]),
        .I3(reg_u12_carrier[1]),
        .O(s_pulse_i_10_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    s_pulse_i_11
       (.I0(reg_u12_carrier[6]),
        .I1(u12_car_per_2[6]),
        .I2(reg_u12_carrier[7]),
        .I3(u12_car_per_2[7]),
        .O(s_pulse_i_11_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    s_pulse_i_12
       (.I0(reg_u12_carrier[4]),
        .I1(u12_car_per_2[4]),
        .I2(reg_u12_carrier[5]),
        .I3(u12_car_per_2[5]),
        .O(s_pulse_i_12_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    s_pulse_i_13
       (.I0(reg_u12_carrier[2]),
        .I1(u12_car_per_2[2]),
        .I2(reg_u12_carrier[3]),
        .I3(u12_car_per_2[3]),
        .O(s_pulse_i_13_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    s_pulse_i_14
       (.I0(reg_u12_carrier[0]),
        .I1(u12_car_per_2[0]),
        .I2(reg_u12_carrier[1]),
        .I3(u12_car_per_2[1]),
        .O(s_pulse_i_14_n_0));
  LUT3 #(
    .INIT(8'hF2)) 
    s_pulse_i_3
       (.I0(reg_u12_carrier[10]),
        .I1(u12_car_per_2[10]),
        .I2(reg_u12_carrier[11]),
        .O(s_pulse_i_3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    s_pulse_i_4
       (.I0(reg_u12_carrier[8]),
        .I1(u12_car_per_2[8]),
        .I2(u12_car_per_2[9]),
        .I3(reg_u12_carrier[9]),
        .O(s_pulse_i_4_n_0));
  LUT3 #(
    .INIT(8'h09)) 
    s_pulse_i_5
       (.I0(reg_u12_carrier[10]),
        .I1(u12_car_per_2[10]),
        .I2(reg_u12_carrier[11]),
        .O(s_pulse_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    s_pulse_i_6
       (.I0(reg_u12_carrier[8]),
        .I1(u12_car_per_2[8]),
        .I2(reg_u12_carrier[9]),
        .I3(u12_car_per_2[9]),
        .O(s_pulse_i_6_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    s_pulse_i_7
       (.I0(reg_u12_carrier[6]),
        .I1(u12_car_per_2[6]),
        .I2(u12_car_per_2[7]),
        .I3(reg_u12_carrier[7]),
        .O(s_pulse_i_7_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    s_pulse_i_8
       (.I0(reg_u12_carrier[4]),
        .I1(u12_car_per_2[4]),
        .I2(u12_car_per_2[5]),
        .I3(reg_u12_carrier[5]),
        .O(s_pulse_i_8_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    s_pulse_i_9
       (.I0(reg_u12_carrier[2]),
        .I1(u12_car_per_2[2]),
        .I2(u12_car_per_2[3]),
        .I3(reg_u12_carrier[3]),
        .O(s_pulse_i_9_n_0));
  FDRE s_pulse_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(s_pulse_reg_i_1_n_2),
        .Q(s_pulse),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 s_pulse_reg_i_1
       (.CI(s_pulse_reg_i_2_n_0),
        .CO({NLW_s_pulse_reg_i_1_CO_UNCONNECTED[3:2],s_pulse_reg_i_1_n_2,NLW_s_pulse_reg_i_1_CO_UNCONNECTED[0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,s_pulse_i_3_n_0,s_pulse_i_4_n_0}),
        .O(NLW_s_pulse_reg_i_1_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,s_pulse_i_5_n_0,s_pulse_i_6_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 s_pulse_reg_i_2
       (.CI(1'b0),
        .CO({s_pulse_reg_i_2_n_0,NLW_s_pulse_reg_i_2_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({s_pulse_i_7_n_0,s_pulse_i_8_n_0,s_pulse_i_9_n_0,s_pulse_i_10_n_0}),
        .O(NLW_s_pulse_reg_i_2_O_UNCONNECTED[3:0]),
        .S({s_pulse_i_11_n_0,s_pulse_i_12_n_0,s_pulse_i_13_n_0,s_pulse_i_14_n_0}));
  FDRE \u12_car_per_2_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[1]),
        .Q(u12_car_per_2[0]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[11]),
        .Q(u12_car_per_2[10]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[2]),
        .Q(u12_car_per_2[1]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[3]),
        .Q(u12_car_per_2[2]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[4]),
        .Q(u12_car_per_2[3]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[5]),
        .Q(u12_car_per_2[4]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[6]),
        .Q(u12_car_per_2[5]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[7]),
        .Q(u12_car_per_2[6]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[8]),
        .Q(u12_car_per_2[7]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[9]),
        .Q(u12_car_per_2[8]),
        .R(1'b0));
  FDRE \u12_car_per_2_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u12_period[10]),
        .Q(u12_car_per_2[9]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 u12_carrier0_carry
       (.CI(1'b0),
        .CO({u12_carrier0_carry_n_0,NLW_u12_carrier0_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({u12_carrier0_carry_i_1_n_0,u12_carrier0_carry_i_2_n_0,u12_carrier0_carry_i_3_n_0,u12_carrier0_carry_i_4_n_0}),
        .O(NLW_u12_carrier0_carry_O_UNCONNECTED[3:0]),
        .S({u12_carrier0_carry_i_5_n_0,u12_carrier0_carry_i_6_n_0,u12_carrier0_carry_i_7_n_0,u12_carrier0_carry_i_8_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 u12_carrier0_carry__0
       (.CI(u12_carrier0_carry_n_0),
        .CO({NLW_u12_carrier0_carry__0_CO_UNCONNECTED[3:2],clear,NLW_u12_carrier0_carry__0_CO_UNCONNECTED[0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,u12_carrier0_carry__0_i_1_n_0,u12_carrier0_carry__0_i_2_n_0}),
        .O(NLW_u12_carrier0_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,u12_carrier0_carry__0_i_3_n_0,u12_carrier0_carry__0_i_4_n_0}));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_carrier0_carry__0_i_1
       (.I0(u12_carrier_reg[11]),
        .I1(jipijee[11]),
        .I2(u12_carrier_reg[10]),
        .I3(jipijee[10]),
        .O(u12_carrier0_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_carrier0_carry__0_i_2
       (.I0(u12_carrier_reg[9]),
        .I1(jipijee[9]),
        .I2(u12_carrier_reg[8]),
        .I3(jipijee[8]),
        .O(u12_carrier0_carry__0_i_2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_carrier0_carry__0_i_3
       (.I0(jipijee[11]),
        .I1(u12_carrier_reg[11]),
        .I2(jipijee[10]),
        .I3(u12_carrier_reg[10]),
        .O(u12_carrier0_carry__0_i_3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_carrier0_carry__0_i_4
       (.I0(jipijee[9]),
        .I1(u12_carrier_reg[9]),
        .I2(jipijee[8]),
        .I3(u12_carrier_reg[8]),
        .O(u12_carrier0_carry__0_i_4_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_carrier0_carry_i_1
       (.I0(u12_carrier_reg[7]),
        .I1(jipijee[7]),
        .I2(u12_carrier_reg[6]),
        .I3(jipijee[6]),
        .O(u12_carrier0_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_carrier0_carry_i_2
       (.I0(u12_carrier_reg[5]),
        .I1(jipijee[5]),
        .I2(u12_carrier_reg[4]),
        .I3(jipijee[4]),
        .O(u12_carrier0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_carrier0_carry_i_3
       (.I0(u12_carrier_reg[3]),
        .I1(jipijee[3]),
        .I2(u12_carrier_reg[2]),
        .I3(jipijee[2]),
        .O(u12_carrier0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_carrier0_carry_i_4
       (.I0(u12_carrier_reg[1]),
        .I1(jipijee[1]),
        .I2(u12_carrier_reg[0]),
        .I3(jipijee[0]),
        .O(u12_carrier0_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_carrier0_carry_i_5
       (.I0(jipijee[7]),
        .I1(u12_carrier_reg[7]),
        .I2(jipijee[6]),
        .I3(u12_carrier_reg[6]),
        .O(u12_carrier0_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_carrier0_carry_i_6
       (.I0(jipijee[5]),
        .I1(u12_carrier_reg[5]),
        .I2(jipijee[4]),
        .I3(u12_carrier_reg[4]),
        .O(u12_carrier0_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_carrier0_carry_i_7
       (.I0(jipijee[3]),
        .I1(u12_carrier_reg[3]),
        .I2(jipijee[2]),
        .I3(u12_carrier_reg[2]),
        .O(u12_carrier0_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_carrier0_carry_i_8
       (.I0(jipijee[1]),
        .I1(u12_carrier_reg[1]),
        .I2(jipijee[0]),
        .I3(u12_carrier_reg[0]),
        .O(u12_carrier0_carry_i_8_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_carrier[0]_i_2 
       (.I0(u12_carrier_reg[0]),
        .O(\u12_carrier[0]_i_2_n_0 ));
  FDRE \u12_carrier_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1_n_7 ),
        .Q(u12_carrier_reg[0]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_carrier_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\u12_carrier_reg[0]_i_1_n_0 ,\NLW_u12_carrier_reg[0]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\u12_carrier_reg[0]_i_1_n_4 ,\u12_carrier_reg[0]_i_1_n_5 ,\u12_carrier_reg[0]_i_1_n_6 ,\u12_carrier_reg[0]_i_1_n_7 }),
        .S({u12_carrier_reg[3:1],\u12_carrier[0]_i_2_n_0 }));
  FDRE \u12_carrier_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1_n_5 ),
        .Q(u12_carrier_reg[10]),
        .R(clear));
  FDRE \u12_carrier_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1_n_4 ),
        .Q(u12_carrier_reg[11]),
        .R(clear));
  FDRE \u12_carrier_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1_n_6 ),
        .Q(u12_carrier_reg[1]),
        .R(clear));
  FDRE \u12_carrier_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1_n_5 ),
        .Q(u12_carrier_reg[2]),
        .R(clear));
  FDRE \u12_carrier_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1_n_4 ),
        .Q(u12_carrier_reg[3]),
        .R(clear));
  FDRE \u12_carrier_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1_n_7 ),
        .Q(u12_carrier_reg[4]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_carrier_reg[4]_i_1 
       (.CI(\u12_carrier_reg[0]_i_1_n_0 ),
        .CO({\u12_carrier_reg[4]_i_1_n_0 ,\NLW_u12_carrier_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\u12_carrier_reg[4]_i_1_n_4 ,\u12_carrier_reg[4]_i_1_n_5 ,\u12_carrier_reg[4]_i_1_n_6 ,\u12_carrier_reg[4]_i_1_n_7 }),
        .S(u12_carrier_reg[7:4]));
  FDRE \u12_carrier_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1_n_6 ),
        .Q(u12_carrier_reg[5]),
        .R(clear));
  FDRE \u12_carrier_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1_n_5 ),
        .Q(u12_carrier_reg[6]),
        .R(clear));
  FDRE \u12_carrier_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1_n_4 ),
        .Q(u12_carrier_reg[7]),
        .R(clear));
  FDRE \u12_carrier_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1_n_7 ),
        .Q(u12_carrier_reg[8]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_carrier_reg[8]_i_1 
       (.CI(\u12_carrier_reg[4]_i_1_n_0 ),
        .CO(\NLW_u12_carrier_reg[8]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\u12_carrier_reg[8]_i_1_n_4 ,\u12_carrier_reg[8]_i_1_n_5 ,\u12_carrier_reg[8]_i_1_n_6 ,\u12_carrier_reg[8]_i_1_n_7 }),
        .S(u12_carrier_reg[11:8]));
  FDRE \u12_carrier_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1_n_6 ),
        .Q(u12_carrier_reg[9]),
        .R(clear));
  LUT3 #(
    .INIT(8'h02)) 
    \u12_deadtime[0]_i_1 
       (.I0(\FSM_onehot_st_startup_reg_n_0_[1] ),
        .I1(dly_cntr[0]),
        .I2(\dly_cntr[13]_i_3_n_0 ),
        .O(u12_deadtime));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[0]_i_3 
       (.I0(u12_deadtime_reg[3]),
        .O(\u12_deadtime[0]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[0]_i_4 
       (.I0(u12_deadtime_reg[2]),
        .O(\u12_deadtime[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[0]_i_5 
       (.I0(u12_deadtime_reg[1]),
        .O(\u12_deadtime[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[0]_i_6 
       (.I0(u12_deadtime_reg[0]),
        .O(\u12_deadtime[0]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[4]_i_2 
       (.I0(u12_deadtime_reg[7]),
        .O(\u12_deadtime[4]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[4]_i_3 
       (.I0(u12_deadtime_reg[6]),
        .O(\u12_deadtime[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[4]_i_4 
       (.I0(u12_deadtime_reg[5]),
        .O(\u12_deadtime[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[4]_i_5 
       (.I0(u12_deadtime_reg[4]),
        .O(\u12_deadtime[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[8]_i_2 
       (.I0(u12_deadtime_reg[11]),
        .O(\u12_deadtime[8]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[8]_i_3 
       (.I0(u12_deadtime_reg[10]),
        .O(\u12_deadtime[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[8]_i_4 
       (.I0(u12_deadtime_reg[9]),
        .O(\u12_deadtime[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_deadtime[8]_i_5 
       (.I0(u12_deadtime_reg[8]),
        .O(\u12_deadtime[8]_i_5_n_0 ));
  FDRE \u12_deadtime_reg[0] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[0]_i_2_n_7 ),
        .Q(u12_deadtime_reg[0]),
        .R(u12_period0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_deadtime_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\u12_deadtime_reg[0]_i_2_n_0 ,\NLW_u12_deadtime_reg[0]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\u12_deadtime_reg[0]_i_2_n_4 ,\u12_deadtime_reg[0]_i_2_n_5 ,\u12_deadtime_reg[0]_i_2_n_6 ,\u12_deadtime_reg[0]_i_2_n_7 }),
        .S({\u12_deadtime[0]_i_3_n_0 ,\u12_deadtime[0]_i_4_n_0 ,\u12_deadtime[0]_i_5_n_0 ,\u12_deadtime[0]_i_6_n_0 }));
  FDRE \u12_deadtime_reg[10] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[8]_i_1_n_5 ),
        .Q(u12_deadtime_reg[10]),
        .R(u12_period0));
  FDRE \u12_deadtime_reg[11] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[8]_i_1_n_4 ),
        .Q(u12_deadtime_reg[11]),
        .R(u12_period0));
  FDRE \u12_deadtime_reg[1] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[0]_i_2_n_6 ),
        .Q(u12_deadtime_reg[1]),
        .R(u12_period0));
  FDSE \u12_deadtime_reg[2] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[0]_i_2_n_5 ),
        .Q(u12_deadtime_reg[2]),
        .S(u12_period0));
  FDSE \u12_deadtime_reg[3] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[0]_i_2_n_4 ),
        .Q(u12_deadtime_reg[3]),
        .S(u12_period0));
  FDRE \u12_deadtime_reg[4] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[4]_i_1_n_7 ),
        .Q(u12_deadtime_reg[4]),
        .R(u12_period0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_deadtime_reg[4]_i_1 
       (.CI(\u12_deadtime_reg[0]_i_2_n_0 ),
        .CO({\u12_deadtime_reg[4]_i_1_n_0 ,\NLW_u12_deadtime_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\u12_deadtime_reg[4]_i_1_n_4 ,\u12_deadtime_reg[4]_i_1_n_5 ,\u12_deadtime_reg[4]_i_1_n_6 ,\u12_deadtime_reg[4]_i_1_n_7 }),
        .S({\u12_deadtime[4]_i_2_n_0 ,\u12_deadtime[4]_i_3_n_0 ,\u12_deadtime[4]_i_4_n_0 ,\u12_deadtime[4]_i_5_n_0 }));
  FDRE \u12_deadtime_reg[5] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[4]_i_1_n_6 ),
        .Q(u12_deadtime_reg[5]),
        .R(u12_period0));
  FDSE \u12_deadtime_reg[6] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[4]_i_1_n_5 ),
        .Q(u12_deadtime_reg[6]),
        .S(u12_period0));
  FDSE \u12_deadtime_reg[7] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[4]_i_1_n_4 ),
        .Q(u12_deadtime_reg[7]),
        .S(u12_period0));
  FDRE \u12_deadtime_reg[8] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[8]_i_1_n_7 ),
        .Q(u12_deadtime_reg[8]),
        .R(u12_period0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_deadtime_reg[8]_i_1 
       (.CI(\u12_deadtime_reg[4]_i_1_n_0 ),
        .CO(\NLW_u12_deadtime_reg[8]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b1,1'b1,1'b1}),
        .O({\u12_deadtime_reg[8]_i_1_n_4 ,\u12_deadtime_reg[8]_i_1_n_5 ,\u12_deadtime_reg[8]_i_1_n_6 ,\u12_deadtime_reg[8]_i_1_n_7 }),
        .S({\u12_deadtime[8]_i_2_n_0 ,\u12_deadtime[8]_i_3_n_0 ,\u12_deadtime[8]_i_4_n_0 ,\u12_deadtime[8]_i_5_n_0 }));
  FDRE \u12_deadtime_reg[9] 
       (.C(clk_out1),
        .CE(u12_deadtime),
        .D(\u12_deadtime_reg[8]_i_1_n_6 ),
        .Q(u12_deadtime_reg[9]),
        .R(u12_period0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 u12_dt_dly1_carry
       (.CI(1'b0),
        .CO({u12_dt_dly1_carry_n_0,NLW_u12_dt_dly1_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({u12_dt_dly1_carry_i_1_n_0,u12_dt_dly1_carry_i_2_n_0,u12_dt_dly1_carry_i_3_n_0,u12_dt_dly1_carry_i_4_n_0}),
        .O(NLW_u12_dt_dly1_carry_O_UNCONNECTED[3:0]),
        .S({u12_dt_dly1_carry_i_5_n_0,u12_dt_dly1_carry_i_6_n_0,u12_dt_dly1_carry_i_7_n_0,u12_dt_dly1_carry_i_8_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 u12_dt_dly1_carry__0
       (.CI(u12_dt_dly1_carry_n_0),
        .CO({NLW_u12_dt_dly1_carry__0_CO_UNCONNECTED[3:2],u12_dt_dly1_carry__0_n_2,NLW_u12_dt_dly1_carry__0_CO_UNCONNECTED[0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,u12_dt_dly1_carry__0_i_1_n_0,u12_dt_dly1_carry__0_i_2_n_0}),
        .O(NLW_u12_dt_dly1_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,u12_dt_dly1_carry__0_i_3_n_0,u12_dt_dly1_carry__0_i_4_n_0}));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_dt_dly1_carry__0_i_1
       (.I0(u12_deadtime_reg[11]),
        .I1(\u12_dt_dly_reg_n_0_[11] ),
        .I2(u12_deadtime_reg[10]),
        .I3(\u12_dt_dly_reg_n_0_[10] ),
        .O(u12_dt_dly1_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_dt_dly1_carry__0_i_2
       (.I0(u12_deadtime_reg[9]),
        .I1(\u12_dt_dly_reg_n_0_[9] ),
        .I2(u12_deadtime_reg[8]),
        .I3(\u12_dt_dly_reg_n_0_[8] ),
        .O(u12_dt_dly1_carry__0_i_2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_dt_dly1_carry__0_i_3
       (.I0(\u12_dt_dly_reg_n_0_[11] ),
        .I1(u12_deadtime_reg[11]),
        .I2(\u12_dt_dly_reg_n_0_[10] ),
        .I3(u12_deadtime_reg[10]),
        .O(u12_dt_dly1_carry__0_i_3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_dt_dly1_carry__0_i_4
       (.I0(\u12_dt_dly_reg_n_0_[9] ),
        .I1(u12_deadtime_reg[9]),
        .I2(\u12_dt_dly_reg_n_0_[8] ),
        .I3(u12_deadtime_reg[8]),
        .O(u12_dt_dly1_carry__0_i_4_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_dt_dly1_carry_i_1
       (.I0(u12_deadtime_reg[7]),
        .I1(\u12_dt_dly_reg_n_0_[7] ),
        .I2(u12_deadtime_reg[6]),
        .I3(\u12_dt_dly_reg_n_0_[6] ),
        .O(u12_dt_dly1_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_dt_dly1_carry_i_2
       (.I0(u12_deadtime_reg[5]),
        .I1(\u12_dt_dly_reg_n_0_[5] ),
        .I2(u12_deadtime_reg[4]),
        .I3(\u12_dt_dly_reg_n_0_[4] ),
        .O(u12_dt_dly1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_dt_dly1_carry_i_3
       (.I0(u12_deadtime_reg[3]),
        .I1(\u12_dt_dly_reg_n_0_[3] ),
        .I2(u12_deadtime_reg[2]),
        .I3(\u12_dt_dly_reg_n_0_[2] ),
        .O(u12_dt_dly1_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    u12_dt_dly1_carry_i_4
       (.I0(u12_deadtime_reg[1]),
        .I1(\u12_dt_dly_reg_n_0_[1] ),
        .I2(u12_deadtime_reg[0]),
        .I3(\u12_dt_dly_reg_n_0_[0] ),
        .O(u12_dt_dly1_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_dt_dly1_carry_i_5
       (.I0(\u12_dt_dly_reg_n_0_[7] ),
        .I1(u12_deadtime_reg[7]),
        .I2(\u12_dt_dly_reg_n_0_[6] ),
        .I3(u12_deadtime_reg[6]),
        .O(u12_dt_dly1_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_dt_dly1_carry_i_6
       (.I0(\u12_dt_dly_reg_n_0_[5] ),
        .I1(u12_deadtime_reg[5]),
        .I2(\u12_dt_dly_reg_n_0_[4] ),
        .I3(u12_deadtime_reg[4]),
        .O(u12_dt_dly1_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_dt_dly1_carry_i_7
       (.I0(\u12_dt_dly_reg_n_0_[3] ),
        .I1(u12_deadtime_reg[3]),
        .I2(\u12_dt_dly_reg_n_0_[2] ),
        .I3(u12_deadtime_reg[2]),
        .O(u12_dt_dly1_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    u12_dt_dly1_carry_i_8
       (.I0(\u12_dt_dly_reg_n_0_[1] ),
        .I1(u12_deadtime_reg[1]),
        .I2(\u12_dt_dly_reg_n_0_[0] ),
        .I3(u12_deadtime_reg[0]),
        .O(u12_dt_dly1_carry_i_8_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_dt_dly[0]_i_1 
       (.I0(\u12_dt_dly_reg_n_0_[0] ),
        .O(\u12_dt_dly[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFBBF)) 
    \u12_dt_dly[11]_i_1 
       (.I0(dt_states[0]),
        .I1(u12_dt_dly1_carry__0_n_2),
        .I2(dt_states[2]),
        .I3(dt_states[1]),
        .O(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly[0]_i_1_n_0 ),
        .Q(\u12_dt_dly_reg_n_0_[0] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[11]_i_2_n_6 ),
        .Q(\u12_dt_dly_reg_n_0_[10] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[11]_i_2_n_5 ),
        .Q(\u12_dt_dly_reg_n_0_[11] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_dt_dly_reg[11]_i_2 
       (.CI(\u12_dt_dly_reg[8]_i_1_n_0 ),
        .CO(\NLW_u12_dt_dly_reg[11]_i_2_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_u12_dt_dly_reg[11]_i_2_O_UNCONNECTED [3],\u12_dt_dly_reg[11]_i_2_n_5 ,\u12_dt_dly_reg[11]_i_2_n_6 ,\u12_dt_dly_reg[11]_i_2_n_7 }),
        .S({1'b0,\u12_dt_dly_reg_n_0_[11] ,\u12_dt_dly_reg_n_0_[10] ,\u12_dt_dly_reg_n_0_[9] }));
  FDRE \u12_dt_dly_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[4]_i_1_n_7 ),
        .Q(\u12_dt_dly_reg_n_0_[1] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[4]_i_1_n_6 ),
        .Q(\u12_dt_dly_reg_n_0_[2] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[4]_i_1_n_5 ),
        .Q(\u12_dt_dly_reg_n_0_[3] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[4]_i_1_n_4 ),
        .Q(\u12_dt_dly_reg_n_0_[4] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_dt_dly_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\u12_dt_dly_reg[4]_i_1_n_0 ,\NLW_u12_dt_dly_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\u12_dt_dly_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\u12_dt_dly_reg[4]_i_1_n_4 ,\u12_dt_dly_reg[4]_i_1_n_5 ,\u12_dt_dly_reg[4]_i_1_n_6 ,\u12_dt_dly_reg[4]_i_1_n_7 }),
        .S({\u12_dt_dly_reg_n_0_[4] ,\u12_dt_dly_reg_n_0_[3] ,\u12_dt_dly_reg_n_0_[2] ,\u12_dt_dly_reg_n_0_[1] }));
  FDRE \u12_dt_dly_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[8]_i_1_n_7 ),
        .Q(\u12_dt_dly_reg_n_0_[5] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[8]_i_1_n_6 ),
        .Q(\u12_dt_dly_reg_n_0_[6] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[8]_i_1_n_5 ),
        .Q(\u12_dt_dly_reg_n_0_[7] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_dt_dly_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[8]_i_1_n_4 ),
        .Q(\u12_dt_dly_reg_n_0_[8] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_dt_dly_reg[8]_i_1 
       (.CI(\u12_dt_dly_reg[4]_i_1_n_0 ),
        .CO({\u12_dt_dly_reg[8]_i_1_n_0 ,\NLW_u12_dt_dly_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\u12_dt_dly_reg[8]_i_1_n_4 ,\u12_dt_dly_reg[8]_i_1_n_5 ,\u12_dt_dly_reg[8]_i_1_n_6 ,\u12_dt_dly_reg[8]_i_1_n_7 }),
        .S({\u12_dt_dly_reg_n_0_[8] ,\u12_dt_dly_reg_n_0_[7] ,\u12_dt_dly_reg_n_0_[6] ,\u12_dt_dly_reg_n_0_[5] }));
  FDRE \u12_dt_dly_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_dt_dly_reg[11]_i_2_n_7 ),
        .Q(\u12_dt_dly_reg_n_0_[9] ),
        .R(\u12_dt_dly[11]_i_1_n_0 ));
  FDRE \u12_period_reg[0] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[0]),
        .Q(u12_period[0]),
        .R(u12_period0));
  FDRE \u12_period_reg[10] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[10]),
        .Q(u12_period[10]),
        .R(u12_period0));
  FDRE \u12_period_reg[11] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[11]),
        .Q(u12_period[11]),
        .R(u12_period0));
  FDSE \u12_period_reg[1] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[1]),
        .Q(u12_period[1]),
        .S(u12_period0));
  FDRE \u12_period_reg[2] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[2]),
        .Q(u12_period[2]),
        .R(u12_period0));
  FDSE \u12_period_reg[3] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[3]),
        .Q(u12_period[3]),
        .S(u12_period0));
  FDSE \u12_period_reg[4] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[4]),
        .Q(u12_period[4]),
        .S(u12_period0));
  FDSE \u12_period_reg[5] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[5]),
        .Q(u12_period[5]),
        .S(u12_period0));
  FDRE \u12_period_reg[6] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[6]),
        .Q(u12_period[6]),
        .R(u12_period0));
  FDSE \u12_period_reg[7] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[7]),
        .Q(u12_period[7]),
        .S(u12_period0));
  FDSE \u12_period_reg[8] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[8]),
        .Q(u12_period[8]),
        .S(u12_period0));
  FDRE \u12_period_reg[9] 
       (.C(clk_out1),
        .CE(u12_period_2),
        .D(Q[9]),
        .Q(u12_period[9]),
        .R(u12_period0));
endmodule

module heater_ctrl
   (\po4_ht_pwm[pri_high] ,
    \po4_ht_pwm[pri_low] ,
    r_si_rstn_reg_0,
    clk_out1,
    r_si_rstn_reg_1,
    \r_piu12_per_ctrl_reg[0]_0 ,
    Q,
    lopt,
    lopt_1,
    lopt_2,
    lopt_3);
  output \po4_ht_pwm[pri_high] ;
  output \po4_ht_pwm[pri_low] ;
  output r_si_rstn_reg_0;
  input clk_out1;
  input r_si_rstn_reg_1;
  input [0:0]\r_piu12_per_ctrl_reg[0]_0 ;
  input [11:0]Q;
  output lopt;
  output lopt_1;
  output lopt_2;
  output lopt_3;

  wire [11:0]Q;
  wire clk_out1;
  wire lopt;
  wire lopt_2;
  wire [11:0]piu12_per_ctrl;
  wire \po4_ht_pwm[pri_high] ;
  wire \po4_ht_pwm[pri_low] ;
  wire [0:0]\r_piu12_per_ctrl_reg[0]_0 ;
  wire r_si_rstn_reg_0;
  wire r_si_rstn_reg_1;
  wire NLW_llc_modulator_lopt_1_UNCONNECTED;
  wire NLW_llc_modulator_lopt_3_UNCONNECTED;

  freq_modulator llc_modulator
       (.\FSM_onehot_st_startup_reg[2]_0 (r_si_rstn_reg_0),
        .Q(piu12_per_ctrl),
        .clk_out1(clk_out1),
        .lopt(lopt),
        .lopt_1(NLW_llc_modulator_lopt_1_UNCONNECTED),
        .lopt_2(lopt_2),
        .lopt_3(NLW_llc_modulator_lopt_3_UNCONNECTED),
        .\po4_ht_pwm[pri_high] (\po4_ht_pwm[pri_high] ),
        .\po4_ht_pwm[pri_low] (\po4_ht_pwm[pri_low] ));
  FDRE \r_piu12_per_ctrl_reg[0] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[0]),
        .Q(piu12_per_ctrl[0]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[10] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[10]),
        .Q(piu12_per_ctrl[10]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[11] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[11]),
        .Q(piu12_per_ctrl[11]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[1] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[1]),
        .Q(piu12_per_ctrl[1]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[2] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[2]),
        .Q(piu12_per_ctrl[2]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[3] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[3]),
        .Q(piu12_per_ctrl[3]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[4] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[4]),
        .Q(piu12_per_ctrl[4]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[5] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[5]),
        .Q(piu12_per_ctrl[5]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[6] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[6]),
        .Q(piu12_per_ctrl[6]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[7] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[7]),
        .Q(piu12_per_ctrl[7]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[8] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[8]),
        .Q(piu12_per_ctrl[8]),
        .R(1'b0));
  FDRE \r_piu12_per_ctrl_reg[9] 
       (.C(clk_out1),
        .CE(\r_piu12_per_ctrl_reg[0]_0 ),
        .D(Q[9]),
        .Q(piu12_per_ctrl[9]),
        .R(1'b0));
  FDRE r_si_rstn_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_rstn_reg_1),
        .Q(r_si_rstn_reg_0),
        .R(1'b0));
endmodule

module led_driver
   (\po3_led1[red] ,
    \po3_led1[green] ,
    \po3_led1[blue] ,
    \po3_led2[red] ,
    \po3_led2[green] ,
    \po3_led2[blue] ,
    \po3_led3[red] ,
    \po3_led3[green] ,
    \po3_led3[blue] ,
    clk_out1,
    Q,
    \po3_led3_reg[red]_0 ,
    \po3_led3_reg[blue]_0 );
  output \po3_led1[red] ;
  output \po3_led1[green] ;
  output \po3_led1[blue] ;
  output \po3_led2[red] ;
  output \po3_led2[green] ;
  output \po3_led2[blue] ;
  output \po3_led3[red] ;
  output \po3_led3[green] ;
  output \po3_led3[blue] ;
  input clk_out1;
  input [2:0]Q;
  input \po3_led3_reg[red]_0 ;
  input [3:0]\po3_led3_reg[blue]_0 ;

  wire [2:0]Q;
  wire \carrier[0]_i_1_n_0 ;
  wire \carrier[8]_i_2_n_0 ;
  wire [8:0]carrier_reg;
  wire clk_out1;
  wire p_0_in;
  wire [8:1]plusOp;
  wire \po3_led1[blue] ;
  wire \po3_led1[blue]_i_2_n_0 ;
  wire \po3_led1[blue]_i_3_n_0 ;
  wire \po3_led1[blue]_i_4_n_0 ;
  wire \po3_led1[blue]_i_5_n_0 ;
  wire \po3_led1[blue]_i_6_n_0 ;
  wire \po3_led1[blue]_i_7_n_0 ;
  wire \po3_led1[blue]_i_8_n_0 ;
  wire \po3_led1[green] ;
  wire \po3_led1[green]_i_10_n_0 ;
  wire \po3_led1[green]_i_3_n_0 ;
  wire \po3_led1[green]_i_4_n_0 ;
  wire \po3_led1[green]_i_5_n_0 ;
  wire \po3_led1[green]_i_6_n_0 ;
  wire \po3_led1[green]_i_7_n_0 ;
  wire \po3_led1[green]_i_8_n_0 ;
  wire \po3_led1[green]_i_9_n_0 ;
  wire \po3_led1[red] ;
  wire \po3_led1[red]_i_2_n_0 ;
  wire \po3_led1[red]_i_3_n_0 ;
  wire \po3_led1[red]_i_4_n_0 ;
  wire \po3_led1[red]_i_5_n_0 ;
  wire \po3_led1[red]_i_6_n_0 ;
  wire \po3_led1_reg[blue]_i_1_n_0 ;
  wire \po3_led1_reg[green]_i_1_n_3 ;
  wire \po3_led1_reg[green]_i_2_n_0 ;
  wire \po3_led2[blue] ;
  wire \po3_led2[blue]_i_2_n_0 ;
  wire \po3_led2[blue]_i_3_n_0 ;
  wire \po3_led2[blue]_i_4_n_0 ;
  wire \po3_led2[blue]_i_5_n_0 ;
  wire \po3_led2[blue]_i_6_n_0 ;
  wire \po3_led2[blue]_i_7_n_0 ;
  wire \po3_led2[blue]_i_8_n_0 ;
  wire \po3_led2[green] ;
  wire \po3_led2[green]_i_10_n_0 ;
  wire \po3_led2[green]_i_3_n_0 ;
  wire \po3_led2[green]_i_4_n_0 ;
  wire \po3_led2[green]_i_5_n_0 ;
  wire \po3_led2[green]_i_6_n_0 ;
  wire \po3_led2[green]_i_7_n_0 ;
  wire \po3_led2[green]_i_8_n_0 ;
  wire \po3_led2[green]_i_9_n_0 ;
  wire \po3_led2[red] ;
  wire \po3_led2[red]_i_2_n_0 ;
  wire \po3_led2[red]_i_3_n_0 ;
  wire \po3_led2[red]_i_4_n_0 ;
  wire \po3_led2[red]_i_5_n_0 ;
  wire \po3_led2[red]_i_6_n_0 ;
  wire \po3_led2_reg[blue]_i_1_n_0 ;
  wire \po3_led2_reg[green]_i_1_n_3 ;
  wire \po3_led2_reg[green]_i_2_n_0 ;
  wire \po3_led2_reg[red]_i_1_n_1 ;
  wire \po3_led3[blue] ;
  wire \po3_led3[blue]_i_2_n_0 ;
  wire \po3_led3[blue]_i_3_n_0 ;
  wire \po3_led3[blue]_i_4_n_0 ;
  wire \po3_led3[blue]_i_5_n_0 ;
  wire \po3_led3[blue]_i_6_n_0 ;
  wire \po3_led3[blue]_i_7_n_0 ;
  wire \po3_led3[blue]_i_8_n_0 ;
  wire \po3_led3[green] ;
  wire \po3_led3[green]_i_10_n_0 ;
  wire \po3_led3[green]_i_3_n_0 ;
  wire \po3_led3[green]_i_4_n_0 ;
  wire \po3_led3[green]_i_5_n_0 ;
  wire \po3_led3[green]_i_6_n_0 ;
  wire \po3_led3[green]_i_7_n_0 ;
  wire \po3_led3[green]_i_8_n_0 ;
  wire \po3_led3[green]_i_9_n_0 ;
  wire \po3_led3[red] ;
  wire \po3_led3[red]_i_2_n_0 ;
  wire \po3_led3[red]_i_3_n_0 ;
  wire \po3_led3[red]_i_4_n_0 ;
  wire \po3_led3[red]_i_5_n_0 ;
  wire \po3_led3[red]_i_6_n_0 ;
  wire [3:0]\po3_led3_reg[blue]_0 ;
  wire \po3_led3_reg[blue]_i_1_n_0 ;
  wire \po3_led3_reg[green]_i_1_n_3 ;
  wire \po3_led3_reg[green]_i_2_n_0 ;
  wire \po3_led3_reg[red]_0 ;
  wire \po3_led3_reg[red]_i_1_n_1 ;
  wire [2:0]\NLW_po3_led1_reg[blue]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led1_reg[blue]_i_1_O_UNCONNECTED ;
  wire [3:1]\NLW_po3_led1_reg[green]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led1_reg[green]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_po3_led1_reg[green]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led1_reg[green]_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_po3_led1_reg[red]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led1_reg[red]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_po3_led2_reg[blue]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led2_reg[blue]_i_1_O_UNCONNECTED ;
  wire [3:1]\NLW_po3_led2_reg[green]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led2_reg[green]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_po3_led2_reg[green]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led2_reg[green]_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_po3_led2_reg[red]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led2_reg[red]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_po3_led3_reg[blue]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led3_reg[blue]_i_1_O_UNCONNECTED ;
  wire [3:1]\NLW_po3_led3_reg[green]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led3_reg[green]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_po3_led3_reg[green]_i_2_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led3_reg[green]_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_po3_led3_reg[red]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_po3_led3_reg[red]_i_1_O_UNCONNECTED ;

  LUT1 #(
    .INIT(2'h1)) 
    \carrier[0]_i_1 
       (.I0(carrier_reg[0]),
        .O(\carrier[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \carrier[1]_i_1 
       (.I0(carrier_reg[0]),
        .I1(carrier_reg[1]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \carrier[2]_i_1 
       (.I0(carrier_reg[1]),
        .I1(carrier_reg[0]),
        .I2(carrier_reg[2]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \carrier[3]_i_1 
       (.I0(carrier_reg[2]),
        .I1(carrier_reg[0]),
        .I2(carrier_reg[1]),
        .I3(carrier_reg[3]),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \carrier[4]_i_1 
       (.I0(carrier_reg[3]),
        .I1(carrier_reg[1]),
        .I2(carrier_reg[0]),
        .I3(carrier_reg[2]),
        .I4(carrier_reg[4]),
        .O(plusOp[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \carrier[5]_i_1 
       (.I0(carrier_reg[4]),
        .I1(carrier_reg[2]),
        .I2(carrier_reg[0]),
        .I3(carrier_reg[1]),
        .I4(carrier_reg[3]),
        .I5(carrier_reg[5]),
        .O(plusOp[5]));
  LUT2 #(
    .INIT(4'h9)) 
    \carrier[6]_i_1 
       (.I0(\carrier[8]_i_2_n_0 ),
        .I1(carrier_reg[6]),
        .O(plusOp[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \carrier[7]_i_1 
       (.I0(carrier_reg[6]),
        .I1(\carrier[8]_i_2_n_0 ),
        .I2(carrier_reg[7]),
        .O(plusOp[7]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \carrier[8]_i_1 
       (.I0(carrier_reg[7]),
        .I1(\carrier[8]_i_2_n_0 ),
        .I2(carrier_reg[6]),
        .I3(carrier_reg[8]),
        .O(plusOp[8]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \carrier[8]_i_2 
       (.I0(carrier_reg[4]),
        .I1(carrier_reg[2]),
        .I2(carrier_reg[0]),
        .I3(carrier_reg[1]),
        .I4(carrier_reg[3]),
        .I5(carrier_reg[5]),
        .O(\carrier[8]_i_2_n_0 ));
  FDRE \carrier_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\carrier[0]_i_1_n_0 ),
        .Q(carrier_reg[0]),
        .R(1'b0));
  FDRE \carrier_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[1]),
        .Q(carrier_reg[1]),
        .R(1'b0));
  FDRE \carrier_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[2]),
        .Q(carrier_reg[2]),
        .R(1'b0));
  FDRE \carrier_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[3]),
        .Q(carrier_reg[3]),
        .R(1'b0));
  FDRE \carrier_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[4]),
        .Q(carrier_reg[4]),
        .R(1'b0));
  FDRE \carrier_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[5]),
        .Q(carrier_reg[5]),
        .R(1'b0));
  FDRE \carrier_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[6]),
        .Q(carrier_reg[6]),
        .R(1'b0));
  FDRE \carrier_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[7]),
        .Q(carrier_reg[7]),
        .R(1'b0));
  FDRE \carrier_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(plusOp[8]),
        .Q(carrier_reg[8]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led1[blue]_i_2 
       (.I0(carrier_reg[7]),
        .I1(carrier_reg[6]),
        .I2(\po3_led3_reg[blue]_0 [3]),
        .O(\po3_led1[blue]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h50D4)) 
    \po3_led1[blue]_i_3 
       (.I0(carrier_reg[5]),
        .I1(\po3_led3_reg[blue]_0 [1]),
        .I2(\po3_led3_reg[blue]_0 [2]),
        .I3(carrier_reg[4]),
        .O(\po3_led1[blue]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po3_led1[blue]_i_4 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[3]),
        .I2(\po3_led3_reg[blue]_0 [0]),
        .I3(carrier_reg[2]),
        .O(\po3_led1[blue]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led1[blue]_i_5 
       (.I0(carrier_reg[8]),
        .O(\po3_led1[blue]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led1[blue]_i_6 
       (.I0(\po3_led3_reg[blue]_0 [3]),
        .I1(carrier_reg[6]),
        .I2(carrier_reg[7]),
        .O(\po3_led1[blue]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po3_led1[blue]_i_7 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[5]),
        .I2(\po3_led3_reg[blue]_0 [1]),
        .I3(carrier_reg[4]),
        .O(\po3_led1[blue]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po3_led1[blue]_i_8 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[3]),
        .I2(\po3_led3_reg[blue]_0 [0]),
        .I3(carrier_reg[2]),
        .O(\po3_led1[blue]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led1[green]_i_10 
       (.I0(Q[0]),
        .I1(carrier_reg[0]),
        .I2(carrier_reg[1]),
        .O(\po3_led1[green]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led1[green]_i_3 
       (.I0(carrier_reg[8]),
        .O(\po3_led1[green]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led1[green]_i_4 
       (.I0(Q[2]),
        .I1(carrier_reg[5]),
        .O(\po3_led1[green]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led1[green]_i_5 
       (.I0(Q[1]),
        .I1(carrier_reg[3]),
        .O(\po3_led1[green]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led1[green]_i_6 
       (.I0(Q[0]),
        .I1(carrier_reg[1]),
        .O(\po3_led1[green]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \po3_led1[green]_i_7 
       (.I0(carrier_reg[6]),
        .I1(carrier_reg[7]),
        .O(\po3_led1[green]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led1[green]_i_8 
       (.I0(Q[2]),
        .I1(carrier_reg[4]),
        .I2(carrier_reg[5]),
        .O(\po3_led1[green]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led1[green]_i_9 
       (.I0(Q[1]),
        .I1(carrier_reg[2]),
        .I2(carrier_reg[3]),
        .O(\po3_led1[green]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led1[red]_i_2 
       (.I0(carrier_reg[7]),
        .I1(carrier_reg[6]),
        .I2(\po3_led3_reg[red]_0 ),
        .O(\po3_led1[red]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led1[red]_i_3 
       (.I0(carrier_reg[5]),
        .I1(carrier_reg[4]),
        .I2(\po3_led3_reg[red]_0 ),
        .O(\po3_led1[red]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led1[red]_i_4 
       (.I0(carrier_reg[8]),
        .O(\po3_led1[red]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led1[red]_i_5 
       (.I0(\po3_led3_reg[red]_0 ),
        .I1(carrier_reg[6]),
        .I2(carrier_reg[7]),
        .O(\po3_led1[red]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led1[red]_i_6 
       (.I0(\po3_led3_reg[red]_0 ),
        .I1(carrier_reg[4]),
        .I2(carrier_reg[5]),
        .O(\po3_led1[red]_i_6_n_0 ));
  FDRE \po3_led1_reg[blue] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led1[blue] ),
        .R(\po3_led1_reg[blue]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led1_reg[blue]_i_1 
       (.CI(1'b0),
        .CO({\po3_led1_reg[blue]_i_1_n_0 ,\NLW_po3_led1_reg[blue]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,\po3_led1[blue]_i_2_n_0 ,\po3_led1[blue]_i_3_n_0 ,\po3_led1[blue]_i_4_n_0 }),
        .O(\NLW_po3_led1_reg[blue]_i_1_O_UNCONNECTED [3:0]),
        .S({\po3_led1[blue]_i_5_n_0 ,\po3_led1[blue]_i_6_n_0 ,\po3_led1[blue]_i_7_n_0 ,\po3_led1[blue]_i_8_n_0 }));
  FDRE \po3_led1_reg[green] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led1[green] ),
        .R(\po3_led1_reg[green]_i_1_n_3 ));
  CARRY4 \po3_led1_reg[green]_i_1 
       (.CI(\po3_led1_reg[green]_i_2_n_0 ),
        .CO({\NLW_po3_led1_reg[green]_i_1_CO_UNCONNECTED [3:1],\po3_led1_reg[green]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_po3_led1_reg[green]_i_1_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\po3_led1[green]_i_3_n_0 }));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led1_reg[green]_i_2 
       (.CI(1'b0),
        .CO({\po3_led1_reg[green]_i_2_n_0 ,\NLW_po3_led1_reg[green]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,\po3_led1[green]_i_4_n_0 ,\po3_led1[green]_i_5_n_0 ,\po3_led1[green]_i_6_n_0 }),
        .O(\NLW_po3_led1_reg[green]_i_2_O_UNCONNECTED [3:0]),
        .S({\po3_led1[green]_i_7_n_0 ,\po3_led1[green]_i_8_n_0 ,\po3_led1[green]_i_9_n_0 ,\po3_led1[green]_i_10_n_0 }));
  FDRE \po3_led1_reg[red] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led1[red] ),
        .R(p_0_in));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led1_reg[red]_i_1 
       (.CI(1'b0),
        .CO({\NLW_po3_led1_reg[red]_i_1_CO_UNCONNECTED [3],p_0_in,\NLW_po3_led1_reg[red]_i_1_CO_UNCONNECTED [1:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\po3_led1[red]_i_2_n_0 ,\po3_led1[red]_i_3_n_0 }),
        .O(\NLW_po3_led1_reg[red]_i_1_O_UNCONNECTED [3:0]),
        .S({1'b0,\po3_led1[red]_i_4_n_0 ,\po3_led1[red]_i_5_n_0 ,\po3_led1[red]_i_6_n_0 }));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led2[blue]_i_2 
       (.I0(carrier_reg[7]),
        .I1(carrier_reg[6]),
        .I2(\po3_led3_reg[blue]_0 [3]),
        .O(\po3_led2[blue]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h50D4)) 
    \po3_led2[blue]_i_3 
       (.I0(carrier_reg[5]),
        .I1(\po3_led3_reg[blue]_0 [1]),
        .I2(\po3_led3_reg[blue]_0 [2]),
        .I3(carrier_reg[4]),
        .O(\po3_led2[blue]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po3_led2[blue]_i_4 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[3]),
        .I2(\po3_led3_reg[blue]_0 [0]),
        .I3(carrier_reg[2]),
        .O(\po3_led2[blue]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led2[blue]_i_5 
       (.I0(carrier_reg[8]),
        .O(\po3_led2[blue]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led2[blue]_i_6 
       (.I0(\po3_led3_reg[blue]_0 [3]),
        .I1(carrier_reg[6]),
        .I2(carrier_reg[7]),
        .O(\po3_led2[blue]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po3_led2[blue]_i_7 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[5]),
        .I2(\po3_led3_reg[blue]_0 [1]),
        .I3(carrier_reg[4]),
        .O(\po3_led2[blue]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po3_led2[blue]_i_8 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[3]),
        .I2(\po3_led3_reg[blue]_0 [0]),
        .I3(carrier_reg[2]),
        .O(\po3_led2[blue]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led2[green]_i_10 
       (.I0(Q[0]),
        .I1(carrier_reg[0]),
        .I2(carrier_reg[1]),
        .O(\po3_led2[green]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led2[green]_i_3 
       (.I0(carrier_reg[8]),
        .O(\po3_led2[green]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led2[green]_i_4 
       (.I0(Q[2]),
        .I1(carrier_reg[5]),
        .O(\po3_led2[green]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led2[green]_i_5 
       (.I0(Q[1]),
        .I1(carrier_reg[3]),
        .O(\po3_led2[green]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led2[green]_i_6 
       (.I0(Q[0]),
        .I1(carrier_reg[1]),
        .O(\po3_led2[green]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \po3_led2[green]_i_7 
       (.I0(carrier_reg[6]),
        .I1(carrier_reg[7]),
        .O(\po3_led2[green]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led2[green]_i_8 
       (.I0(Q[2]),
        .I1(carrier_reg[4]),
        .I2(carrier_reg[5]),
        .O(\po3_led2[green]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led2[green]_i_9 
       (.I0(Q[1]),
        .I1(carrier_reg[2]),
        .I2(carrier_reg[3]),
        .O(\po3_led2[green]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led2[red]_i_2 
       (.I0(carrier_reg[7]),
        .I1(carrier_reg[6]),
        .I2(\po3_led3_reg[red]_0 ),
        .O(\po3_led2[red]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led2[red]_i_3 
       (.I0(carrier_reg[5]),
        .I1(carrier_reg[4]),
        .I2(\po3_led3_reg[red]_0 ),
        .O(\po3_led2[red]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led2[red]_i_4 
       (.I0(carrier_reg[8]),
        .O(\po3_led2[red]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led2[red]_i_5 
       (.I0(\po3_led3_reg[red]_0 ),
        .I1(carrier_reg[6]),
        .I2(carrier_reg[7]),
        .O(\po3_led2[red]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led2[red]_i_6 
       (.I0(\po3_led3_reg[red]_0 ),
        .I1(carrier_reg[4]),
        .I2(carrier_reg[5]),
        .O(\po3_led2[red]_i_6_n_0 ));
  FDRE \po3_led2_reg[blue] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led2[blue] ),
        .R(\po3_led2_reg[blue]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led2_reg[blue]_i_1 
       (.CI(1'b0),
        .CO({\po3_led2_reg[blue]_i_1_n_0 ,\NLW_po3_led2_reg[blue]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,\po3_led2[blue]_i_2_n_0 ,\po3_led2[blue]_i_3_n_0 ,\po3_led2[blue]_i_4_n_0 }),
        .O(\NLW_po3_led2_reg[blue]_i_1_O_UNCONNECTED [3:0]),
        .S({\po3_led2[blue]_i_5_n_0 ,\po3_led2[blue]_i_6_n_0 ,\po3_led2[blue]_i_7_n_0 ,\po3_led2[blue]_i_8_n_0 }));
  FDRE \po3_led2_reg[green] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led2[green] ),
        .R(\po3_led2_reg[green]_i_1_n_3 ));
  CARRY4 \po3_led2_reg[green]_i_1 
       (.CI(\po3_led2_reg[green]_i_2_n_0 ),
        .CO({\NLW_po3_led2_reg[green]_i_1_CO_UNCONNECTED [3:1],\po3_led2_reg[green]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_po3_led2_reg[green]_i_1_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\po3_led2[green]_i_3_n_0 }));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led2_reg[green]_i_2 
       (.CI(1'b0),
        .CO({\po3_led2_reg[green]_i_2_n_0 ,\NLW_po3_led2_reg[green]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,\po3_led2[green]_i_4_n_0 ,\po3_led2[green]_i_5_n_0 ,\po3_led2[green]_i_6_n_0 }),
        .O(\NLW_po3_led2_reg[green]_i_2_O_UNCONNECTED [3:0]),
        .S({\po3_led2[green]_i_7_n_0 ,\po3_led2[green]_i_8_n_0 ,\po3_led2[green]_i_9_n_0 ,\po3_led2[green]_i_10_n_0 }));
  FDRE \po3_led2_reg[red] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led2[red] ),
        .R(\po3_led2_reg[red]_i_1_n_1 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led2_reg[red]_i_1 
       (.CI(1'b0),
        .CO({\NLW_po3_led2_reg[red]_i_1_CO_UNCONNECTED [3],\po3_led2_reg[red]_i_1_n_1 ,\NLW_po3_led2_reg[red]_i_1_CO_UNCONNECTED [1:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\po3_led2[red]_i_2_n_0 ,\po3_led2[red]_i_3_n_0 }),
        .O(\NLW_po3_led2_reg[red]_i_1_O_UNCONNECTED [3:0]),
        .S({1'b0,\po3_led2[red]_i_4_n_0 ,\po3_led2[red]_i_5_n_0 ,\po3_led2[red]_i_6_n_0 }));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led3[blue]_i_2 
       (.I0(carrier_reg[7]),
        .I1(carrier_reg[6]),
        .I2(\po3_led3_reg[blue]_0 [3]),
        .O(\po3_led3[blue]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h50D4)) 
    \po3_led3[blue]_i_3 
       (.I0(carrier_reg[5]),
        .I1(\po3_led3_reg[blue]_0 [1]),
        .I2(\po3_led3_reg[blue]_0 [2]),
        .I3(carrier_reg[4]),
        .O(\po3_led3[blue]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po3_led3[blue]_i_4 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[3]),
        .I2(\po3_led3_reg[blue]_0 [0]),
        .I3(carrier_reg[2]),
        .O(\po3_led3[blue]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led3[blue]_i_5 
       (.I0(carrier_reg[8]),
        .O(\po3_led3[blue]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led3[blue]_i_6 
       (.I0(\po3_led3_reg[blue]_0 [3]),
        .I1(carrier_reg[6]),
        .I2(carrier_reg[7]),
        .O(\po3_led3[blue]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po3_led3[blue]_i_7 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[5]),
        .I2(\po3_led3_reg[blue]_0 [1]),
        .I3(carrier_reg[4]),
        .O(\po3_led3[blue]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po3_led3[blue]_i_8 
       (.I0(\po3_led3_reg[blue]_0 [2]),
        .I1(carrier_reg[3]),
        .I2(\po3_led3_reg[blue]_0 [0]),
        .I3(carrier_reg[2]),
        .O(\po3_led3[blue]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led3[green]_i_10 
       (.I0(Q[0]),
        .I1(carrier_reg[0]),
        .I2(carrier_reg[1]),
        .O(\po3_led3[green]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led3[green]_i_3 
       (.I0(carrier_reg[8]),
        .O(\po3_led3[green]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led3[green]_i_4 
       (.I0(Q[2]),
        .I1(carrier_reg[5]),
        .O(\po3_led3[green]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led3[green]_i_5 
       (.I0(Q[1]),
        .I1(carrier_reg[3]),
        .O(\po3_led3[green]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \po3_led3[green]_i_6 
       (.I0(Q[0]),
        .I1(carrier_reg[1]),
        .O(\po3_led3[green]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \po3_led3[green]_i_7 
       (.I0(carrier_reg[6]),
        .I1(carrier_reg[7]),
        .O(\po3_led3[green]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led3[green]_i_8 
       (.I0(Q[2]),
        .I1(carrier_reg[4]),
        .I2(carrier_reg[5]),
        .O(\po3_led3[green]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h21)) 
    \po3_led3[green]_i_9 
       (.I0(Q[1]),
        .I1(carrier_reg[2]),
        .I2(carrier_reg[3]),
        .O(\po3_led3[green]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led3[red]_i_2 
       (.I0(carrier_reg[7]),
        .I1(carrier_reg[6]),
        .I2(\po3_led3_reg[red]_0 ),
        .O(\po3_led3[red]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \po3_led3[red]_i_3 
       (.I0(carrier_reg[5]),
        .I1(carrier_reg[4]),
        .I2(\po3_led3_reg[red]_0 ),
        .O(\po3_led3[red]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \po3_led3[red]_i_4 
       (.I0(carrier_reg[8]),
        .O(\po3_led3[red]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led3[red]_i_5 
       (.I0(\po3_led3_reg[red]_0 ),
        .I1(carrier_reg[6]),
        .I2(carrier_reg[7]),
        .O(\po3_led3[red]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h09)) 
    \po3_led3[red]_i_6 
       (.I0(\po3_led3_reg[red]_0 ),
        .I1(carrier_reg[4]),
        .I2(carrier_reg[5]),
        .O(\po3_led3[red]_i_6_n_0 ));
  FDRE \po3_led3_reg[blue] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led3[blue] ),
        .R(\po3_led3_reg[blue]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led3_reg[blue]_i_1 
       (.CI(1'b0),
        .CO({\po3_led3_reg[blue]_i_1_n_0 ,\NLW_po3_led3_reg[blue]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,\po3_led3[blue]_i_2_n_0 ,\po3_led3[blue]_i_3_n_0 ,\po3_led3[blue]_i_4_n_0 }),
        .O(\NLW_po3_led3_reg[blue]_i_1_O_UNCONNECTED [3:0]),
        .S({\po3_led3[blue]_i_5_n_0 ,\po3_led3[blue]_i_6_n_0 ,\po3_led3[blue]_i_7_n_0 ,\po3_led3[blue]_i_8_n_0 }));
  FDRE \po3_led3_reg[green] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led3[green] ),
        .R(\po3_led3_reg[green]_i_1_n_3 ));
  CARRY4 \po3_led3_reg[green]_i_1 
       (.CI(\po3_led3_reg[green]_i_2_n_0 ),
        .CO({\NLW_po3_led3_reg[green]_i_1_CO_UNCONNECTED [3:1],\po3_led3_reg[green]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_po3_led3_reg[green]_i_1_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\po3_led3[green]_i_3_n_0 }));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led3_reg[green]_i_2 
       (.CI(1'b0),
        .CO({\po3_led3_reg[green]_i_2_n_0 ,\NLW_po3_led3_reg[green]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,\po3_led3[green]_i_4_n_0 ,\po3_led3[green]_i_5_n_0 ,\po3_led3[green]_i_6_n_0 }),
        .O(\NLW_po3_led3_reg[green]_i_2_O_UNCONNECTED [3:0]),
        .S({\po3_led3[green]_i_7_n_0 ,\po3_led3[green]_i_8_n_0 ,\po3_led3[green]_i_9_n_0 ,\po3_led3[green]_i_10_n_0 }));
  FDRE \po3_led3_reg[red] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(1'b1),
        .Q(\po3_led3[red] ),
        .R(\po3_led3_reg[red]_i_1_n_1 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po3_led3_reg[red]_i_1 
       (.CI(1'b0),
        .CO({\NLW_po3_led3_reg[red]_i_1_CO_UNCONNECTED [3],\po3_led3_reg[red]_i_1_n_1 ,\NLW_po3_led3_reg[red]_i_1_CO_UNCONNECTED [1:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\po3_led3[red]_i_2_n_0 ,\po3_led3[red]_i_3_n_0 }),
        .O(\NLW_po3_led3_reg[red]_i_1_O_UNCONNECTED [3:0]),
        .S({1'b0,\po3_led3[red]_i_4_n_0 ,\po3_led3[red]_i_5_n_0 ,\po3_led3[red]_i_6_n_0 }));
endmodule

module pfc_control
   (\po2_pfc_pwm[ac1] ,
    clk_out1,
    r_so_uart_rx_rdy,
    u12_carrier_reg,
    Q,
    lopt,
    lopt_1);
  output \po2_pfc_pwm[ac1] ;
  input clk_out1;
  input r_so_uart_rx_rdy;
  input [11:0]u12_carrier_reg;
  input [15:0]Q;
  output lopt;
  output lopt_1;

  wire [15:0]Q;
  wire clk_out1;
  wire lopt;
  wire [0:0]p_0_in;
  wire \po2_pfc_pwm[ac1] ;
  wire \r_si16_uart_rx_data_reg_n_0_[0] ;
  wire \r_si16_uart_rx_data_reg_n_0_[10] ;
  wire \r_si16_uart_rx_data_reg_n_0_[11] ;
  wire \r_si16_uart_rx_data_reg_n_0_[13] ;
  wire \r_si16_uart_rx_data_reg_n_0_[14] ;
  wire \r_si16_uart_rx_data_reg_n_0_[15] ;
  wire \r_si16_uart_rx_data_reg_n_0_[1] ;
  wire \r_si16_uart_rx_data_reg_n_0_[2] ;
  wire \r_si16_uart_rx_data_reg_n_0_[3] ;
  wire \r_si16_uart_rx_data_reg_n_0_[4] ;
  wire \r_si16_uart_rx_data_reg_n_0_[5] ;
  wire \r_si16_uart_rx_data_reg_n_0_[6] ;
  wire \r_si16_uart_rx_data_reg_n_0_[7] ;
  wire \r_si16_uart_rx_data_reg_n_0_[8] ;
  wire \r_si16_uart_rx_data_reg_n_0_[9] ;
  wire r_si_rstn;
  wire r_si_rstn_i_1_n_0;
  wire r_si_rstn_i_2__0_n_0;
  wire r_si_rstn_i_3_n_0;
  wire r_si_rstn_i_4_n_0;
  wire [11:0]r_si_u12_pfc_duty;
  wire r_si_u12_pfc_duty_0;
  wire r_si_uart_ready_event;
  wire r_so_uart_rx_rdy;
  wire si_rstn;
  wire [11:0]si_u12_pfc_duty;
  wire [11:0]u12_carrier_reg;
  wire unstable_si_rstn;
  wire [11:0]unstable_si_u12_pfc_duty;
  wire NLW_pfc_gate_control_lopt_1_UNCONNECTED;

  pfc_modulator pfc_gate_control
       (.Q(si_u12_pfc_duty),
        .clk_out1(clk_out1),
        .lopt(lopt),
        .lopt_1(NLW_pfc_gate_control_lopt_1_UNCONNECTED),
        .\po2_pfc_pwm[ac1] (\po2_pfc_pwm[ac1] ),
        .si_rstn(si_rstn),
        .u12_carrier_reg(u12_carrier_reg));
  FDRE \r_si16_uart_rx_data_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[0]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[10]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[11]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[12] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[12]),
        .Q(p_0_in),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[13] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[13]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[14] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[14]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[15] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[15]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[1]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[2]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[3]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[4]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[5]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[6]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[7]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[8]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \r_si16_uart_rx_data_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(Q[9]),
        .Q(\r_si16_uart_rx_data_reg_n_0_[9] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h7FFF4000)) 
    r_si_rstn_i_1
       (.I0(\r_si16_uart_rx_data_reg_n_0_[0] ),
        .I1(r_si_rstn_i_2__0_n_0),
        .I2(r_si_rstn_i_3_n_0),
        .I3(r_si_rstn_i_4_n_0),
        .I4(r_si_rstn),
        .O(r_si_rstn_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    r_si_rstn_i_2__0
       (.I0(\r_si16_uart_rx_data_reg_n_0_[13] ),
        .I1(\r_si16_uart_rx_data_reg_n_0_[14] ),
        .I2(\r_si16_uart_rx_data_reg_n_0_[11] ),
        .I3(p_0_in),
        .I4(\r_si16_uart_rx_data_reg_n_0_[15] ),
        .I5(r_si_uart_ready_event),
        .O(r_si_rstn_i_2__0_n_0));
  LUT4 #(
    .INIT(16'h0400)) 
    r_si_rstn_i_3
       (.I0(\r_si16_uart_rx_data_reg_n_0_[2] ),
        .I1(\r_si16_uart_rx_data_reg_n_0_[1] ),
        .I2(\r_si16_uart_rx_data_reg_n_0_[4] ),
        .I3(\r_si16_uart_rx_data_reg_n_0_[3] ),
        .O(r_si_rstn_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    r_si_rstn_i_4
       (.I0(\r_si16_uart_rx_data_reg_n_0_[7] ),
        .I1(\r_si16_uart_rx_data_reg_n_0_[8] ),
        .I2(\r_si16_uart_rx_data_reg_n_0_[5] ),
        .I3(\r_si16_uart_rx_data_reg_n_0_[6] ),
        .I4(\r_si16_uart_rx_data_reg_n_0_[10] ),
        .I5(\r_si16_uart_rx_data_reg_n_0_[9] ),
        .O(r_si_rstn_i_4_n_0));
  FDRE r_si_rstn_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_rstn_i_1_n_0),
        .Q(r_si_rstn),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00020000)) 
    \r_si_u12_pfc_duty[11]_i_1 
       (.I0(p_0_in),
        .I1(\r_si16_uart_rx_data_reg_n_0_[13] ),
        .I2(\r_si16_uart_rx_data_reg_n_0_[14] ),
        .I3(\r_si16_uart_rx_data_reg_n_0_[15] ),
        .I4(r_si_uart_ready_event),
        .O(r_si_u12_pfc_duty_0));
  FDRE \r_si_u12_pfc_duty_reg[0] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[0] ),
        .Q(r_si_u12_pfc_duty[0]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[10] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[10] ),
        .Q(r_si_u12_pfc_duty[10]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[11] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[11] ),
        .Q(r_si_u12_pfc_duty[11]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[1] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[1] ),
        .Q(r_si_u12_pfc_duty[1]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[2] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[2] ),
        .Q(r_si_u12_pfc_duty[2]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[3] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[3] ),
        .Q(r_si_u12_pfc_duty[3]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[4] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[4] ),
        .Q(r_si_u12_pfc_duty[4]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[5] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[5] ),
        .Q(r_si_u12_pfc_duty[5]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[6] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[6] ),
        .Q(r_si_u12_pfc_duty[6]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[7] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[7] ),
        .Q(r_si_u12_pfc_duty[7]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[8] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[8] ),
        .Q(r_si_u12_pfc_duty[8]),
        .R(1'b0));
  FDRE \r_si_u12_pfc_duty_reg[9] 
       (.C(clk_out1),
        .CE(r_si_u12_pfc_duty_0),
        .D(\r_si16_uart_rx_data_reg_n_0_[9] ),
        .Q(r_si_u12_pfc_duty[9]),
        .R(1'b0));
  FDRE r_si_uart_ready_event_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_so_uart_rx_rdy),
        .Q(r_si_uart_ready_event),
        .R(1'b0));
  FDRE stable_si_rstn_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_rstn),
        .Q(si_rstn),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[0]),
        .Q(si_u12_pfc_duty[0]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[10]),
        .Q(si_u12_pfc_duty[10]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[11]),
        .Q(si_u12_pfc_duty[11]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[1]),
        .Q(si_u12_pfc_duty[1]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[2]),
        .Q(si_u12_pfc_duty[2]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[3]),
        .Q(si_u12_pfc_duty[3]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[4]),
        .Q(si_u12_pfc_duty[4]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[5]),
        .Q(si_u12_pfc_duty[5]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[6]),
        .Q(si_u12_pfc_duty[6]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[7]),
        .Q(si_u12_pfc_duty[7]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[8]),
        .Q(si_u12_pfc_duty[8]),
        .R(1'b0));
  FDRE \stable_si_u12_pfc_duty_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(unstable_si_u12_pfc_duty[9]),
        .Q(si_u12_pfc_duty[9]),
        .R(1'b0));
  FDRE unstable_si_rstn_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_rstn),
        .Q(unstable_si_rstn),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[0]),
        .Q(unstable_si_u12_pfc_duty[0]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[10]),
        .Q(unstable_si_u12_pfc_duty[10]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[11]),
        .Q(unstable_si_u12_pfc_duty[11]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[1]),
        .Q(unstable_si_u12_pfc_duty[1]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[2]),
        .Q(unstable_si_u12_pfc_duty[2]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[3]),
        .Q(unstable_si_u12_pfc_duty[3]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[4]),
        .Q(unstable_si_u12_pfc_duty[4]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[5]),
        .Q(unstable_si_u12_pfc_duty[5]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[6]),
        .Q(unstable_si_u12_pfc_duty[6]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[7]),
        .Q(unstable_si_u12_pfc_duty[7]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[8]),
        .Q(unstable_si_u12_pfc_duty[8]),
        .R(1'b0));
  FDRE \unstable_si_u12_pfc_duty_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(r_si_u12_pfc_duty[9]),
        .Q(unstable_si_u12_pfc_duty[9]),
        .R(1'b0));
endmodule

module pfc_modulator
   (\po2_pfc_pwm[ac1] ,
    clk_out1,
    u12_carrier_reg,
    Q,
    si_rstn,
    lopt,
    lopt_1);
  output \po2_pfc_pwm[ac1] ;
  input clk_out1;
  input [11:0]u12_carrier_reg;
  input [11:0]Q;
  input si_rstn;
  output lopt;
  output lopt_1;

  wire [11:0]Q;
  wire clk_out1;
  wire \po2_pfc_pwm[ac1] ;
  wire \po2_pfc_pwm[ac1]_i_1_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry__0_i_1_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry__0_i_2_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry__0_i_3_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry__0_i_4_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry__0_n_2 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_1_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_2_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_3_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_4_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_5_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_6_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_7_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_i_8_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]0_carry_n_0 ;
  wire \po2_pfc_pwm_reg[ac1]_lopt_replica_1 ;
  wire [11:0]safe_si_u12_pfc_duty;
  wire \safe_si_u12_pfc_duty[11]_i_2_n_0 ;
  wire safe_si_u12_pfc_duty_0;
  wire si_rstn;
  wire [11:0]u12_carrier_reg;
  wire [2:0]\NLW_po2_pfc_pwm_reg[ac1]0_carry_CO_UNCONNECTED ;
  wire [3:0]\NLW_po2_pfc_pwm_reg[ac1]0_carry_O_UNCONNECTED ;
  wire [3:0]\NLW_po2_pfc_pwm_reg[ac1]0_carry__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_po2_pfc_pwm_reg[ac1]0_carry__0_O_UNCONNECTED ;

  assign lopt = \po2_pfc_pwm_reg[ac1]_lopt_replica_1 ;
  LUT1 #(
    .INIT(2'h1)) 
    \po2_pfc_pwm[ac1]_i_1 
       (.I0(si_rstn),
        .O(\po2_pfc_pwm[ac1]_i_1_n_0 ));
  FDRE \po2_pfc_pwm_reg[ac1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\po2_pfc_pwm_reg[ac1]0_carry__0_n_2 ),
        .Q(\po2_pfc_pwm[ac1] ),
        .R(\po2_pfc_pwm[ac1]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po2_pfc_pwm_reg[ac1]0_carry 
       (.CI(1'b0),
        .CO({\po2_pfc_pwm_reg[ac1]0_carry_n_0 ,\NLW_po2_pfc_pwm_reg[ac1]0_carry_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\po2_pfc_pwm_reg[ac1]0_carry_i_1_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry_i_2_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry_i_3_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry_i_4_n_0 }),
        .O(\NLW_po2_pfc_pwm_reg[ac1]0_carry_O_UNCONNECTED [3:0]),
        .S({\po2_pfc_pwm_reg[ac1]0_carry_i_5_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry_i_6_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry_i_7_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry_i_8_n_0 }));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \po2_pfc_pwm_reg[ac1]0_carry__0 
       (.CI(\po2_pfc_pwm_reg[ac1]0_carry_n_0 ),
        .CO({\NLW_po2_pfc_pwm_reg[ac1]0_carry__0_CO_UNCONNECTED [3:2],\po2_pfc_pwm_reg[ac1]0_carry__0_n_2 ,\NLW_po2_pfc_pwm_reg[ac1]0_carry__0_CO_UNCONNECTED [0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\po2_pfc_pwm_reg[ac1]0_carry__0_i_1_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry__0_i_2_n_0 }),
        .O(\NLW_po2_pfc_pwm_reg[ac1]0_carry__0_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,\po2_pfc_pwm_reg[ac1]0_carry__0_i_3_n_0 ,\po2_pfc_pwm_reg[ac1]0_carry__0_i_4_n_0 }));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po2_pfc_pwm_reg[ac1]0_carry__0_i_1 
       (.I0(safe_si_u12_pfc_duty[11]),
        .I1(u12_carrier_reg[11]),
        .I2(safe_si_u12_pfc_duty[10]),
        .I3(u12_carrier_reg[10]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry__0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po2_pfc_pwm_reg[ac1]0_carry__0_i_2 
       (.I0(safe_si_u12_pfc_duty[9]),
        .I1(u12_carrier_reg[9]),
        .I2(safe_si_u12_pfc_duty[8]),
        .I3(u12_carrier_reg[8]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry__0_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po2_pfc_pwm_reg[ac1]0_carry__0_i_3 
       (.I0(safe_si_u12_pfc_duty[11]),
        .I1(u12_carrier_reg[11]),
        .I2(safe_si_u12_pfc_duty[10]),
        .I3(u12_carrier_reg[10]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry__0_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po2_pfc_pwm_reg[ac1]0_carry__0_i_4 
       (.I0(safe_si_u12_pfc_duty[9]),
        .I1(u12_carrier_reg[9]),
        .I2(safe_si_u12_pfc_duty[8]),
        .I3(u12_carrier_reg[8]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry__0_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_1 
       (.I0(safe_si_u12_pfc_duty[7]),
        .I1(u12_carrier_reg[7]),
        .I2(safe_si_u12_pfc_duty[6]),
        .I3(u12_carrier_reg[6]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_2 
       (.I0(safe_si_u12_pfc_duty[5]),
        .I1(u12_carrier_reg[5]),
        .I2(safe_si_u12_pfc_duty[4]),
        .I3(u12_carrier_reg[4]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_3 
       (.I0(safe_si_u12_pfc_duty[3]),
        .I1(u12_carrier_reg[3]),
        .I2(safe_si_u12_pfc_duty[2]),
        .I3(u12_carrier_reg[2]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_4 
       (.I0(safe_si_u12_pfc_duty[1]),
        .I1(u12_carrier_reg[1]),
        .I2(safe_si_u12_pfc_duty[0]),
        .I3(u12_carrier_reg[0]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_5 
       (.I0(safe_si_u12_pfc_duty[7]),
        .I1(u12_carrier_reg[7]),
        .I2(safe_si_u12_pfc_duty[6]),
        .I3(u12_carrier_reg[6]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_6 
       (.I0(safe_si_u12_pfc_duty[5]),
        .I1(u12_carrier_reg[5]),
        .I2(safe_si_u12_pfc_duty[4]),
        .I3(u12_carrier_reg[4]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_7 
       (.I0(safe_si_u12_pfc_duty[3]),
        .I1(u12_carrier_reg[3]),
        .I2(safe_si_u12_pfc_duty[2]),
        .I3(u12_carrier_reg[2]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \po2_pfc_pwm_reg[ac1]0_carry_i_8 
       (.I0(safe_si_u12_pfc_duty[1]),
        .I1(u12_carrier_reg[1]),
        .I2(safe_si_u12_pfc_duty[0]),
        .I3(u12_carrier_reg[0]),
        .O(\po2_pfc_pwm_reg[ac1]0_carry_i_8_n_0 ));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDRE #(
    .INIT(1'b0)) 
    \po2_pfc_pwm_reg[ac1]_lopt_replica 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\po2_pfc_pwm_reg[ac1]0_carry__0_n_2 ),
        .Q(\po2_pfc_pwm_reg[ac1]_lopt_replica_1 ),
        .R(\po2_pfc_pwm[ac1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \safe_si_u12_pfc_duty[11]_i_1 
       (.I0(si_rstn),
        .I1(Q[9]),
        .I2(Q[8]),
        .I3(Q[11]),
        .I4(Q[10]),
        .I5(\safe_si_u12_pfc_duty[11]_i_2_n_0 ),
        .O(safe_si_u12_pfc_duty_0));
  LUT5 #(
    .INIT(32'h01FFFFFF)) 
    \safe_si_u12_pfc_duty[11]_i_2 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[5]),
        .I3(Q[7]),
        .I4(Q[6]),
        .O(\safe_si_u12_pfc_duty[11]_i_2_n_0 ));
  FDRE \safe_si_u12_pfc_duty_reg[0] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[0]),
        .Q(safe_si_u12_pfc_duty[0]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[10] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[10]),
        .Q(safe_si_u12_pfc_duty[10]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[11] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[11]),
        .Q(safe_si_u12_pfc_duty[11]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[1] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[1]),
        .Q(safe_si_u12_pfc_duty[1]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[2] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[2]),
        .Q(safe_si_u12_pfc_duty[2]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[3] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[3]),
        .Q(safe_si_u12_pfc_duty[3]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[4] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[4]),
        .Q(safe_si_u12_pfc_duty[4]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[5] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[5]),
        .Q(safe_si_u12_pfc_duty[5]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[6] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[6]),
        .Q(safe_si_u12_pfc_duty[6]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[7] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[7]),
        .Q(safe_si_u12_pfc_duty[7]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[8] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[8]),
        .Q(safe_si_u12_pfc_duty[8]),
        .R(1'b0));
  FDRE \safe_si_u12_pfc_duty_reg[9] 
       (.C(clk_out1),
        .CE(safe_si_u12_pfc_duty_0),
        .D(Q[9]),
        .Q(safe_si_u12_pfc_duty[9]),
        .R(1'b0));
endmodule

module phase_modulator
   (\po4_dhb_pwm[pri_high] ,
    \po4_dhb_pwm[pri_low] ,
    \po4_dhb_pwm[sec_high] ,
    \po4_dhb_pwm[sec_low] ,
    clk_out1,
    DI,
    Q);
  output \po4_dhb_pwm[pri_high] ;
  output \po4_dhb_pwm[pri_low] ;
  output \po4_dhb_pwm[sec_high] ;
  output \po4_dhb_pwm[sec_low] ;
  input clk_out1;
  input [0:0]DI;
  input [11:0]Q;

  wire [0:0]DI;
  wire \FSM_sequential_st_dt_states[0]_i_1_n_0 ;
  wire \FSM_sequential_st_dt_states[0]_i_2_n_0 ;
  wire \FSM_sequential_st_dt_states[0]_i_3_n_0 ;
  wire \FSM_sequential_st_dt_states[1]_i_1_n_0 ;
  wire \FSM_sequential_st_dt_states[1]_i_2_n_0 ;
  wire \FSM_sequential_st_dt_states[1]_i_3_n_0 ;
  wire [11:0]Q;
  wire clk_out1;
  wire [7:0]dt_counter;
  wire \dt_counter[0]_i_1_n_0 ;
  wire \dt_counter[1]_i_1_n_0 ;
  wire \dt_counter[2]_i_1_n_0 ;
  wire \dt_counter[3]_i_1_n_0 ;
  wire \dt_counter[4]_i_1_n_0 ;
  wire \dt_counter[5]_i_1_n_0 ;
  wire \dt_counter[6]_i_1_n_0 ;
  wire \dt_counter[7]__0_i_1_n_0 ;
  wire \dt_counter[7]__0_i_3_n_0 ;
  wire \dt_counter[7]_i_1_n_0 ;
  wire \dt_counter[7]_i_2_n_0 ;
  wire \dt_counter[7]_i_3_n_0 ;
  wire \dt_counter_reg[0]__0_n_0 ;
  wire \dt_counter_reg[1]__0_n_0 ;
  wire \dt_counter_reg[2]__0_n_0 ;
  wire \dt_counter_reg[3]__0_n_0 ;
  wire \dt_counter_reg[4]__0_n_0 ;
  wire \dt_counter_reg[5]__0_n_0 ;
  wire \dt_counter_reg[6]__0_n_0 ;
  wire \dt_counter_reg[7]__0_n_0 ;
  wire i__carry__0_i_1__0_n_0;
  wire i__carry_i_1__0_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3__0_n_0;
  wire i__carry_i_4__0_n_0;
  wire i__carry_i_5__0_n_0;
  wire i__carry_i_6__0_n_0;
  wire i__carry_i_7__0_n_0;
  wire \po4_dhb_pwm[pri_high] ;
  wire \po4_dhb_pwm[pri_high]_i_1_n_0 ;
  wire \po4_dhb_pwm[pri_low] ;
  wire \po4_dhb_pwm[pri_low]_i_1_n_0 ;
  wire \po4_dhb_pwm[sec_high] ;
  wire \po4_dhb_pwm[sec_high]_i_1_n_0 ;
  wire \po4_dhb_pwm[sec_low] ;
  wire \po4_dhb_pwm[sec_low]_i_1_n_0 ;
  wire \s13_dhb_counter[0]_i_2_n_0 ;
  wire \s13_dhb_counter[0]_i_3_n_0 ;
  wire \s13_dhb_counter[0]_i_4_n_0 ;
  wire \s13_dhb_counter[0]_i_5_n_0 ;
  wire \s13_dhb_counter[0]_i_6_n_0 ;
  wire \s13_dhb_counter[0]_i_7_n_0 ;
  wire \s13_dhb_counter[0]_i_8_n_0 ;
  wire \s13_dhb_counter[4]_i_2_n_0 ;
  wire \s13_dhb_counter[4]_i_3_n_0 ;
  wire \s13_dhb_counter[4]_i_4_n_0 ;
  wire \s13_dhb_counter[4]_i_5_n_0 ;
  wire \s13_dhb_counter[4]_i_6_n_0 ;
  wire \s13_dhb_counter[4]_i_7_n_0 ;
  wire \s13_dhb_counter[4]_i_8_n_0 ;
  wire \s13_dhb_counter[4]_i_9_n_0 ;
  wire \s13_dhb_counter[8]_i_2_n_0 ;
  wire \s13_dhb_counter[8]_i_3_n_0 ;
  wire \s13_dhb_counter[8]_i_4_n_0 ;
  wire \s13_dhb_counter[8]_i_5_n_0 ;
  wire \s13_dhb_counter[8]_i_6_n_0 ;
  wire \s13_dhb_counter[8]_i_7_n_0 ;
  wire \s13_dhb_counter[8]_i_8_n_0 ;
  wire [11:0]s13_dhb_counter_reg;
  wire \s13_dhb_counter_reg[0]_i_1_n_0 ;
  wire \s13_dhb_counter_reg[0]_i_1_n_4 ;
  wire \s13_dhb_counter_reg[0]_i_1_n_5 ;
  wire \s13_dhb_counter_reg[0]_i_1_n_6 ;
  wire \s13_dhb_counter_reg[0]_i_1_n_7 ;
  wire \s13_dhb_counter_reg[4]_i_1_n_0 ;
  wire \s13_dhb_counter_reg[4]_i_1_n_4 ;
  wire \s13_dhb_counter_reg[4]_i_1_n_5 ;
  wire \s13_dhb_counter_reg[4]_i_1_n_6 ;
  wire \s13_dhb_counter_reg[4]_i_1_n_7 ;
  wire \s13_dhb_counter_reg[8]_i_1_n_4 ;
  wire \s13_dhb_counter_reg[8]_i_1_n_5 ;
  wire \s13_dhb_counter_reg[8]_i_1_n_6 ;
  wire \s13_dhb_counter_reg[8]_i_1_n_7 ;
  wire s_pri_pulse;
  wire s_sec_pulse;
  wire s_sec_pulse2_carry_i_1_n_0;
  wire s_sec_pulse2_carry_i_2_n_0;
  wire s_sec_pulse2_carry_i_3_n_0;
  wire s_sec_pulse2_carry_i_4_n_0;
  wire s_sec_pulse2_carry_n_0;
  wire s_sec_pulse_i_1_n_0;
  wire s_sec_pulse_i_2_n_0;
  wire [7:0]sel0;
  wire st_count_dir;
  wire st_count_dir1_carry__0_i_1_n_0;
  wire st_count_dir1_carry__0_i_2_n_0;
  wire st_count_dir1_carry__0_i_3_n_0;
  wire st_count_dir1_carry__0_i_4_n_0;
  wire st_count_dir1_carry__0_n_5;
  wire st_count_dir1_carry_i_1_n_0;
  wire st_count_dir1_carry_i_2_n_0;
  wire st_count_dir1_carry_i_3_n_0;
  wire st_count_dir1_carry_i_4_n_0;
  wire st_count_dir1_carry_i_5_n_0;
  wire st_count_dir1_carry_i_6_n_0;
  wire st_count_dir1_carry_n_0;
  wire \st_count_dir1_inferred__0/i__carry__0_n_6 ;
  wire \st_count_dir1_inferred__0/i__carry_n_0 ;
  wire st_count_dir_i_1_n_0;
  wire [1:0]st_dt_states;
  wire \st_dt_states[0]_i_1_n_0 ;
  wire \st_dt_states[0]_i_2_n_0 ;
  wire \st_dt_states[0]_i_3_n_0 ;
  wire \st_dt_states[1]_i_1_n_0 ;
  wire \st_dt_states[1]_i_2_n_0 ;
  wire [1:0]st_dt_states__0;
  wire \u12_phase_delay[0]_i_1_n_0 ;
  wire \u12_phase_delay[0]_i_3_n_0 ;
  wire [11:0]u12_phase_delay_reg;
  wire \u12_phase_delay_reg[0]_i_2_n_0 ;
  wire \u12_phase_delay_reg[0]_i_2_n_4 ;
  wire \u12_phase_delay_reg[0]_i_2_n_5 ;
  wire \u12_phase_delay_reg[0]_i_2_n_6 ;
  wire \u12_phase_delay_reg[0]_i_2_n_7 ;
  wire \u12_phase_delay_reg[4]_i_1_n_0 ;
  wire \u12_phase_delay_reg[4]_i_1_n_4 ;
  wire \u12_phase_delay_reg[4]_i_1_n_5 ;
  wire \u12_phase_delay_reg[4]_i_1_n_6 ;
  wire \u12_phase_delay_reg[4]_i_1_n_7 ;
  wire \u12_phase_delay_reg[8]_i_1_n_4 ;
  wire \u12_phase_delay_reg[8]_i_1_n_5 ;
  wire \u12_phase_delay_reg[8]_i_1_n_6 ;
  wire \u12_phase_delay_reg[8]_i_1_n_7 ;
  wire [2:0]\NLW_s13_dhb_counter_reg[0]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_s13_dhb_counter_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_s13_dhb_counter_reg[8]_i_1_CO_UNCONNECTED ;
  wire [2:0]NLW_s_sec_pulse2_carry_CO_UNCONNECTED;
  wire [3:0]NLW_s_sec_pulse2_carry_O_UNCONNECTED;
  wire [2:0]NLW_st_count_dir1_carry_CO_UNCONNECTED;
  wire [3:0]NLW_st_count_dir1_carry_O_UNCONNECTED;
  wire [3:0]NLW_st_count_dir1_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_st_count_dir1_carry__0_O_UNCONNECTED;
  wire [2:0]\NLW_st_count_dir1_inferred__0/i__carry_CO_UNCONNECTED ;
  wire [3:0]\NLW_st_count_dir1_inferred__0/i__carry_O_UNCONNECTED ;
  wire [3:0]\NLW_st_count_dir1_inferred__0/i__carry__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_st_count_dir1_inferred__0/i__carry__0_O_UNCONNECTED ;
  wire [2:0]\NLW_u12_phase_delay_reg[0]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_u12_phase_delay_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_u12_phase_delay_reg[8]_i_1_CO_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT4 #(
    .INIT(16'hFFC8)) 
    \FSM_sequential_st_dt_states[0]_i_1 
       (.I0(\dt_counter_reg[5]__0_n_0 ),
        .I1(st_dt_states__0[0]),
        .I2(\FSM_sequential_st_dt_states[0]_i_2_n_0 ),
        .I3(\FSM_sequential_st_dt_states[0]_i_3_n_0 ),
        .O(\FSM_sequential_st_dt_states[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \FSM_sequential_st_dt_states[0]_i_2 
       (.I0(\dt_counter_reg[7]__0_n_0 ),
        .I1(\dt_counter_reg[6]__0_n_0 ),
        .I2(\dt_counter_reg[4]__0_n_0 ),
        .I3(\dt_counter_reg[3]__0_n_0 ),
        .O(\FSM_sequential_st_dt_states[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBFFDF0F0BFFD0F0F)) 
    \FSM_sequential_st_dt_states[0]_i_3 
       (.I0(\dt_counter_reg[2]__0_n_0 ),
        .I1(\dt_counter_reg[0]__0_n_0 ),
        .I2(st_dt_states__0[1]),
        .I3(\dt_counter_reg[1]__0_n_0 ),
        .I4(st_dt_states__0[0]),
        .I5(s_sec_pulse),
        .O(\FSM_sequential_st_dt_states[0]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_sequential_st_dt_states[1]_i_1 
       (.I0(DI),
        .O(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hCCCD8CCC)) 
    \FSM_sequential_st_dt_states[1]_i_2 
       (.I0(\FSM_sequential_st_dt_states[1]_i_3_n_0 ),
        .I1(st_dt_states__0[1]),
        .I2(\dt_counter_reg[1]__0_n_0 ),
        .I3(\dt_counter_reg[0]__0_n_0 ),
        .I4(\dt_counter_reg[2]__0_n_0 ),
        .O(\FSM_sequential_st_dt_states[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF7FFFF)) 
    \FSM_sequential_st_dt_states[1]_i_3 
       (.I0(\dt_counter_reg[3]__0_n_0 ),
        .I1(\dt_counter_reg[4]__0_n_0 ),
        .I2(\dt_counter_reg[6]__0_n_0 ),
        .I3(\dt_counter_reg[7]__0_n_0 ),
        .I4(st_dt_states__0[0]),
        .I5(\dt_counter_reg[5]__0_n_0 ),
        .O(\FSM_sequential_st_dt_states[1]_i_3_n_0 ));
  (* FSM_ENCODED_STATES = "dt1:01,neg:10,dt2:11,pos:00" *) 
  FDRE \FSM_sequential_st_dt_states_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_sequential_st_dt_states[0]_i_1_n_0 ),
        .Q(st_dt_states__0[0]),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "dt1:01,neg:10,dt2:11,pos:00" *) 
  FDRE \FSM_sequential_st_dt_states_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_sequential_st_dt_states[1]_i_2_n_0 ),
        .Q(st_dt_states__0[1]),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \dt_counter[0]__0_i_1 
       (.I0(st_dt_states__0[0]),
        .I1(\dt_counter_reg[0]__0_n_0 ),
        .O(dt_counter[0]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dt_counter[0]_i_1 
       (.I0(st_dt_states[0]),
        .I1(sel0[0]),
        .O(\dt_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h48)) 
    \dt_counter[1]__0_i_1 
       (.I0(\dt_counter_reg[0]__0_n_0 ),
        .I1(st_dt_states__0[0]),
        .I2(\dt_counter_reg[1]__0_n_0 ),
        .O(dt_counter[1]));
  LUT3 #(
    .INIT(8'h48)) 
    \dt_counter[1]_i_1 
       (.I0(sel0[0]),
        .I1(st_dt_states[0]),
        .I2(sel0[1]),
        .O(\dt_counter[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'h7800)) 
    \dt_counter[2]__0_i_1 
       (.I0(\dt_counter_reg[1]__0_n_0 ),
        .I1(\dt_counter_reg[0]__0_n_0 ),
        .I2(\dt_counter_reg[2]__0_n_0 ),
        .I3(st_dt_states__0[0]),
        .O(dt_counter[2]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'h7800)) 
    \dt_counter[2]_i_1 
       (.I0(sel0[1]),
        .I1(sel0[0]),
        .I2(sel0[2]),
        .I3(st_dt_states[0]),
        .O(\dt_counter[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT5 #(
    .INIT(32'h7F008000)) 
    \dt_counter[3]__0_i_1 
       (.I0(\dt_counter_reg[1]__0_n_0 ),
        .I1(\dt_counter_reg[0]__0_n_0 ),
        .I2(\dt_counter_reg[2]__0_n_0 ),
        .I3(st_dt_states__0[0]),
        .I4(\dt_counter_reg[3]__0_n_0 ),
        .O(dt_counter[3]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT5 #(
    .INIT(32'h7F008000)) 
    \dt_counter[3]_i_1 
       (.I0(sel0[1]),
        .I1(sel0[0]),
        .I2(sel0[2]),
        .I3(st_dt_states[0]),
        .I4(sel0[3]),
        .O(\dt_counter[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF000080000000)) 
    \dt_counter[4]__0_i_1 
       (.I0(\dt_counter_reg[2]__0_n_0 ),
        .I1(\dt_counter_reg[0]__0_n_0 ),
        .I2(\dt_counter_reg[1]__0_n_0 ),
        .I3(\dt_counter_reg[3]__0_n_0 ),
        .I4(st_dt_states__0[0]),
        .I5(\dt_counter_reg[4]__0_n_0 ),
        .O(dt_counter[4]));
  LUT6 #(
    .INIT(64'h7FFF000080000000)) 
    \dt_counter[4]_i_1 
       (.I0(sel0[2]),
        .I1(sel0[0]),
        .I2(sel0[1]),
        .I3(sel0[3]),
        .I4(st_dt_states[0]),
        .I5(sel0[4]),
        .O(\dt_counter[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h84)) 
    \dt_counter[5]__0_i_1 
       (.I0(\dt_counter[7]__0_i_3_n_0 ),
        .I1(st_dt_states__0[0]),
        .I2(\dt_counter_reg[5]__0_n_0 ),
        .O(dt_counter[5]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'h84)) 
    \dt_counter[5]_i_1 
       (.I0(\dt_counter[7]_i_3_n_0 ),
        .I1(st_dt_states[0]),
        .I2(sel0[5]),
        .O(\dt_counter[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'h8C40)) 
    \dt_counter[6]__0_i_1 
       (.I0(\dt_counter[7]__0_i_3_n_0 ),
        .I1(st_dt_states__0[0]),
        .I2(\dt_counter_reg[5]__0_n_0 ),
        .I3(\dt_counter_reg[6]__0_n_0 ),
        .O(dt_counter[6]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h8C40)) 
    \dt_counter[6]_i_1 
       (.I0(\dt_counter[7]_i_3_n_0 ),
        .I1(st_dt_states[0]),
        .I2(sel0[5]),
        .I3(sel0[6]),
        .O(\dt_counter[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000FFEF0000)) 
    \dt_counter[7]__0_i_1 
       (.I0(\dt_counter_reg[1]__0_n_0 ),
        .I1(\dt_counter_reg[0]__0_n_0 ),
        .I2(\dt_counter_reg[2]__0_n_0 ),
        .I3(\FSM_sequential_st_dt_states[1]_i_3_n_0 ),
        .I4(DI),
        .I5(st_dt_states__0[1]),
        .O(\dt_counter[7]__0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT5 #(
    .INIT(32'hC600CC00)) 
    \dt_counter[7]__0_i_2 
       (.I0(\dt_counter_reg[6]__0_n_0 ),
        .I1(\dt_counter_reg[7]__0_n_0 ),
        .I2(\dt_counter[7]__0_i_3_n_0 ),
        .I3(st_dt_states__0[0]),
        .I4(\dt_counter_reg[5]__0_n_0 ),
        .O(dt_counter[7]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \dt_counter[7]__0_i_3 
       (.I0(\dt_counter_reg[4]__0_n_0 ),
        .I1(\dt_counter_reg[3]__0_n_0 ),
        .I2(\dt_counter_reg[2]__0_n_0 ),
        .I3(\dt_counter_reg[0]__0_n_0 ),
        .I4(\dt_counter_reg[1]__0_n_0 ),
        .O(\dt_counter[7]__0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000FFEF0000)) 
    \dt_counter[7]_i_1 
       (.I0(sel0[0]),
        .I1(sel0[1]),
        .I2(sel0[2]),
        .I3(\st_dt_states[1]_i_2_n_0 ),
        .I4(DI),
        .I5(st_dt_states[1]),
        .O(\dt_counter[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT5 #(
    .INIT(32'hC600CC00)) 
    \dt_counter[7]_i_2 
       (.I0(sel0[6]),
        .I1(sel0[7]),
        .I2(\dt_counter[7]_i_3_n_0 ),
        .I3(st_dt_states[0]),
        .I4(sel0[5]),
        .O(\dt_counter[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \dt_counter[7]_i_3 
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .I4(sel0[1]),
        .O(\dt_counter[7]_i_3_n_0 ));
  FDRE \dt_counter_reg[0] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[0]_i_1_n_0 ),
        .Q(sel0[0]),
        .R(1'b0));
  FDRE \dt_counter_reg[0]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[0]),
        .Q(\dt_counter_reg[0]__0_n_0 ),
        .R(1'b0));
  FDRE \dt_counter_reg[1] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[1]_i_1_n_0 ),
        .Q(sel0[1]),
        .R(1'b0));
  FDRE \dt_counter_reg[1]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[1]),
        .Q(\dt_counter_reg[1]__0_n_0 ),
        .R(1'b0));
  FDRE \dt_counter_reg[2] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[2]_i_1_n_0 ),
        .Q(sel0[2]),
        .R(1'b0));
  FDRE \dt_counter_reg[2]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[2]),
        .Q(\dt_counter_reg[2]__0_n_0 ),
        .R(1'b0));
  FDRE \dt_counter_reg[3] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[3]_i_1_n_0 ),
        .Q(sel0[3]),
        .R(1'b0));
  FDRE \dt_counter_reg[3]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[3]),
        .Q(\dt_counter_reg[3]__0_n_0 ),
        .R(1'b0));
  FDRE \dt_counter_reg[4] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[4]_i_1_n_0 ),
        .Q(sel0[4]),
        .R(1'b0));
  FDRE \dt_counter_reg[4]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[4]),
        .Q(\dt_counter_reg[4]__0_n_0 ),
        .R(1'b0));
  FDRE \dt_counter_reg[5] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[5]_i_1_n_0 ),
        .Q(sel0[5]),
        .R(1'b0));
  FDRE \dt_counter_reg[5]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[5]),
        .Q(\dt_counter_reg[5]__0_n_0 ),
        .R(1'b0));
  FDRE \dt_counter_reg[6] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[6]_i_1_n_0 ),
        .Q(sel0[6]),
        .R(1'b0));
  FDRE \dt_counter_reg[6]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[6]),
        .Q(\dt_counter_reg[6]__0_n_0 ),
        .R(1'b0));
  FDRE \dt_counter_reg[7] 
       (.C(clk_out1),
        .CE(\dt_counter[7]_i_1_n_0 ),
        .D(\dt_counter[7]_i_2_n_0 ),
        .Q(sel0[7]),
        .R(1'b0));
  FDRE \dt_counter_reg[7]__0 
       (.C(clk_out1),
        .CE(\dt_counter[7]__0_i_1_n_0 ),
        .D(dt_counter[7]),
        .Q(\dt_counter_reg[7]__0_n_0 ),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry__0_i_1__0
       (.I0(s13_dhb_counter_reg[10]),
        .I1(s13_dhb_counter_reg[11]),
        .O(i__carry__0_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    i__carry_i_1__0
       (.I0(s13_dhb_counter_reg[6]),
        .I1(s13_dhb_counter_reg[7]),
        .O(i__carry_i_1__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_2
       (.I0(s13_dhb_counter_reg[5]),
        .O(i__carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    i__carry_i_3__0
       (.I0(s13_dhb_counter_reg[2]),
        .I1(s13_dhb_counter_reg[3]),
        .O(i__carry_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry_i_4__0
       (.I0(s13_dhb_counter_reg[8]),
        .I1(s13_dhb_counter_reg[9]),
        .O(i__carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    i__carry_i_5__0
       (.I0(s13_dhb_counter_reg[6]),
        .I1(s13_dhb_counter_reg[7]),
        .O(i__carry_i_5__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry_i_6__0
       (.I0(s13_dhb_counter_reg[5]),
        .I1(s13_dhb_counter_reg[4]),
        .O(i__carry_i_6__0_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    i__carry_i_7__0
       (.I0(s13_dhb_counter_reg[2]),
        .I1(s13_dhb_counter_reg[3]),
        .O(i__carry_i_7__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    \po4_dhb_pwm[pri_high]_i_1 
       (.I0(st_dt_states[0]),
        .I1(st_dt_states[1]),
        .O(\po4_dhb_pwm[pri_high]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \po4_dhb_pwm[pri_low]_i_1 
       (.I0(st_dt_states[1]),
        .I1(st_dt_states[0]),
        .O(\po4_dhb_pwm[pri_low]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \po4_dhb_pwm[sec_high]_i_1 
       (.I0(st_dt_states__0[0]),
        .I1(st_dt_states__0[1]),
        .O(\po4_dhb_pwm[sec_high]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \po4_dhb_pwm[sec_low]_i_1 
       (.I0(st_dt_states__0[1]),
        .I1(st_dt_states__0[0]),
        .O(\po4_dhb_pwm[sec_low]_i_1_n_0 ));
  FDRE \po4_dhb_pwm_reg[pri_high] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\po4_dhb_pwm[pri_high]_i_1_n_0 ),
        .Q(\po4_dhb_pwm[pri_high] ),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  FDRE \po4_dhb_pwm_reg[pri_low] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\po4_dhb_pwm[pri_low]_i_1_n_0 ),
        .Q(\po4_dhb_pwm[pri_low] ),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  FDRE \po4_dhb_pwm_reg[sec_high] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\po4_dhb_pwm[sec_high]_i_1_n_0 ),
        .Q(\po4_dhb_pwm[sec_high] ),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  FDRE \po4_dhb_pwm_reg[sec_low] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\po4_dhb_pwm[sec_low]_i_1_n_0 ),
        .Q(\po4_dhb_pwm[sec_low] ),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[0]_i_2 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[0]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[0]_i_3 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[0]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[0]_i_4 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[0]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h7B)) 
    \s13_dhb_counter[0]_i_5 
       (.I0(st_count_dir),
        .I1(DI),
        .I2(s13_dhb_counter_reg[3]),
        .O(\s13_dhb_counter[0]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h7B)) 
    \s13_dhb_counter[0]_i_6 
       (.I0(st_count_dir),
        .I1(DI),
        .I2(s13_dhb_counter_reg[2]),
        .O(\s13_dhb_counter[0]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \s13_dhb_counter[0]_i_7 
       (.I0(st_count_dir),
        .I1(s13_dhb_counter_reg[1]),
        .I2(DI),
        .O(\s13_dhb_counter[0]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \s13_dhb_counter[0]_i_8 
       (.I0(s13_dhb_counter_reg[0]),
        .I1(DI),
        .O(\s13_dhb_counter[0]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[4]_i_2 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[4]_i_3 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[4]_i_4 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[4]_i_5 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[4]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h7B)) 
    \s13_dhb_counter[4]_i_6 
       (.I0(st_count_dir),
        .I1(DI),
        .I2(s13_dhb_counter_reg[7]),
        .O(\s13_dhb_counter[4]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h7B)) 
    \s13_dhb_counter[4]_i_7 
       (.I0(st_count_dir),
        .I1(DI),
        .I2(s13_dhb_counter_reg[6]),
        .O(\s13_dhb_counter[4]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h7B)) 
    \s13_dhb_counter[4]_i_8 
       (.I0(st_count_dir),
        .I1(DI),
        .I2(s13_dhb_counter_reg[5]),
        .O(\s13_dhb_counter[4]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \s13_dhb_counter[4]_i_9 
       (.I0(st_count_dir),
        .I1(s13_dhb_counter_reg[4]),
        .I2(DI),
        .O(\s13_dhb_counter[4]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[8]_i_2 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[8]_i_3 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s13_dhb_counter[8]_i_4 
       (.I0(DI),
        .I1(st_count_dir),
        .O(\s13_dhb_counter[8]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h48)) 
    \s13_dhb_counter[8]_i_5 
       (.I0(s13_dhb_counter_reg[11]),
        .I1(DI),
        .I2(st_count_dir),
        .O(\s13_dhb_counter[8]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \s13_dhb_counter[8]_i_6 
       (.I0(st_count_dir),
        .I1(s13_dhb_counter_reg[10]),
        .I2(DI),
        .O(\s13_dhb_counter[8]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \s13_dhb_counter[8]_i_7 
       (.I0(st_count_dir),
        .I1(s13_dhb_counter_reg[9]),
        .I2(DI),
        .O(\s13_dhb_counter[8]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \s13_dhb_counter[8]_i_8 
       (.I0(st_count_dir),
        .I1(s13_dhb_counter_reg[8]),
        .I2(DI),
        .O(\s13_dhb_counter[8]_i_8_n_0 ));
  FDRE \s13_dhb_counter_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[0]_i_1_n_7 ),
        .Q(s13_dhb_counter_reg[0]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \s13_dhb_counter_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\s13_dhb_counter_reg[0]_i_1_n_0 ,\NLW_s13_dhb_counter_reg[0]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\s13_dhb_counter[0]_i_2_n_0 ,\s13_dhb_counter[0]_i_3_n_0 ,\s13_dhb_counter[0]_i_4_n_0 ,DI}),
        .O({\s13_dhb_counter_reg[0]_i_1_n_4 ,\s13_dhb_counter_reg[0]_i_1_n_5 ,\s13_dhb_counter_reg[0]_i_1_n_6 ,\s13_dhb_counter_reg[0]_i_1_n_7 }),
        .S({\s13_dhb_counter[0]_i_5_n_0 ,\s13_dhb_counter[0]_i_6_n_0 ,\s13_dhb_counter[0]_i_7_n_0 ,\s13_dhb_counter[0]_i_8_n_0 }));
  FDRE \s13_dhb_counter_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[8]_i_1_n_5 ),
        .Q(s13_dhb_counter_reg[10]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[8]_i_1_n_4 ),
        .Q(s13_dhb_counter_reg[11]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[0]_i_1_n_6 ),
        .Q(s13_dhb_counter_reg[1]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[0]_i_1_n_5 ),
        .Q(s13_dhb_counter_reg[2]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[0]_i_1_n_4 ),
        .Q(s13_dhb_counter_reg[3]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[4]_i_1_n_7 ),
        .Q(s13_dhb_counter_reg[4]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \s13_dhb_counter_reg[4]_i_1 
       (.CI(\s13_dhb_counter_reg[0]_i_1_n_0 ),
        .CO({\s13_dhb_counter_reg[4]_i_1_n_0 ,\NLW_s13_dhb_counter_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\s13_dhb_counter[4]_i_2_n_0 ,\s13_dhb_counter[4]_i_3_n_0 ,\s13_dhb_counter[4]_i_4_n_0 ,\s13_dhb_counter[4]_i_5_n_0 }),
        .O({\s13_dhb_counter_reg[4]_i_1_n_4 ,\s13_dhb_counter_reg[4]_i_1_n_5 ,\s13_dhb_counter_reg[4]_i_1_n_6 ,\s13_dhb_counter_reg[4]_i_1_n_7 }),
        .S({\s13_dhb_counter[4]_i_6_n_0 ,\s13_dhb_counter[4]_i_7_n_0 ,\s13_dhb_counter[4]_i_8_n_0 ,\s13_dhb_counter[4]_i_9_n_0 }));
  FDRE \s13_dhb_counter_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[4]_i_1_n_6 ),
        .Q(s13_dhb_counter_reg[5]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[4]_i_1_n_5 ),
        .Q(s13_dhb_counter_reg[6]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[4]_i_1_n_4 ),
        .Q(s13_dhb_counter_reg[7]),
        .R(1'b0));
  FDRE \s13_dhb_counter_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[8]_i_1_n_7 ),
        .Q(s13_dhb_counter_reg[8]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \s13_dhb_counter_reg[8]_i_1 
       (.CI(\s13_dhb_counter_reg[4]_i_1_n_0 ),
        .CO(\NLW_s13_dhb_counter_reg[8]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,\s13_dhb_counter[8]_i_2_n_0 ,\s13_dhb_counter[8]_i_3_n_0 ,\s13_dhb_counter[8]_i_4_n_0 }),
        .O({\s13_dhb_counter_reg[8]_i_1_n_4 ,\s13_dhb_counter_reg[8]_i_1_n_5 ,\s13_dhb_counter_reg[8]_i_1_n_6 ,\s13_dhb_counter_reg[8]_i_1_n_7 }),
        .S({\s13_dhb_counter[8]_i_5_n_0 ,\s13_dhb_counter[8]_i_6_n_0 ,\s13_dhb_counter[8]_i_7_n_0 ,\s13_dhb_counter[8]_i_8_n_0 }));
  FDRE \s13_dhb_counter_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\s13_dhb_counter_reg[8]_i_1_n_6 ),
        .Q(s13_dhb_counter_reg[9]),
        .R(1'b0));
  FDRE s_pri_pulse_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(s13_dhb_counter_reg[11]),
        .Q(s_pri_pulse),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 s_sec_pulse2_carry
       (.CI(1'b0),
        .CO({s_sec_pulse2_carry_n_0,NLW_s_sec_pulse2_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_s_sec_pulse2_carry_O_UNCONNECTED[3:0]),
        .S({s_sec_pulse2_carry_i_1_n_0,s_sec_pulse2_carry_i_2_n_0,s_sec_pulse2_carry_i_3_n_0,s_sec_pulse2_carry_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    s_sec_pulse2_carry_i_1
       (.I0(Q[11]),
        .I1(u12_phase_delay_reg[11]),
        .I2(Q[10]),
        .I3(u12_phase_delay_reg[10]),
        .I4(u12_phase_delay_reg[9]),
        .I5(Q[9]),
        .O(s_sec_pulse2_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    s_sec_pulse2_carry_i_2
       (.I0(Q[8]),
        .I1(u12_phase_delay_reg[8]),
        .I2(Q[7]),
        .I3(u12_phase_delay_reg[7]),
        .I4(u12_phase_delay_reg[6]),
        .I5(Q[6]),
        .O(s_sec_pulse2_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    s_sec_pulse2_carry_i_3
       (.I0(Q[5]),
        .I1(u12_phase_delay_reg[5]),
        .I2(Q[4]),
        .I3(u12_phase_delay_reg[4]),
        .I4(u12_phase_delay_reg[3]),
        .I5(Q[3]),
        .O(s_sec_pulse2_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    s_sec_pulse2_carry_i_4
       (.I0(Q[2]),
        .I1(u12_phase_delay_reg[2]),
        .I2(Q[1]),
        .I3(u12_phase_delay_reg[1]),
        .I4(u12_phase_delay_reg[0]),
        .I5(Q[0]),
        .O(s_sec_pulse2_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFB00000004)) 
    s_sec_pulse_i_1
       (.I0(s_sec_pulse_i_2_n_0),
        .I1(s_sec_pulse2_carry_n_0),
        .I2(u12_phase_delay_reg[5]),
        .I3(u12_phase_delay_reg[7]),
        .I4(u12_phase_delay_reg[6]),
        .I5(s_sec_pulse),
        .O(s_sec_pulse_i_1_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    s_sec_pulse_i_2
       (.I0(u12_phase_delay_reg[9]),
        .I1(u12_phase_delay_reg[8]),
        .I2(u12_phase_delay_reg[11]),
        .I3(u12_phase_delay_reg[10]),
        .O(s_sec_pulse_i_2_n_0));
  FDRE s_sec_pulse_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(s_sec_pulse_i_1_n_0),
        .Q(s_sec_pulse),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 st_count_dir1_carry
       (.CI(1'b0),
        .CO({st_count_dir1_carry_n_0,NLW_st_count_dir1_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b1),
        .DI({1'b0,st_count_dir1_carry_i_1_n_0,st_count_dir1_carry_i_2_n_0,1'b0}),
        .O(NLW_st_count_dir1_carry_O_UNCONNECTED[3:0]),
        .S({st_count_dir1_carry_i_3_n_0,st_count_dir1_carry_i_4_n_0,st_count_dir1_carry_i_5_n_0,st_count_dir1_carry_i_6_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 st_count_dir1_carry__0
       (.CI(st_count_dir1_carry_n_0),
        .CO(NLW_st_count_dir1_carry__0_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,st_count_dir1_carry__0_i_1_n_0,st_count_dir1_carry__0_i_2_n_0}),
        .O({NLW_st_count_dir1_carry__0_O_UNCONNECTED[3],st_count_dir1_carry__0_n_5,NLW_st_count_dir1_carry__0_O_UNCONNECTED[1:0]}),
        .S({1'b0,1'b1,st_count_dir1_carry__0_i_3_n_0,st_count_dir1_carry__0_i_4_n_0}));
  LUT2 #(
    .INIT(4'h2)) 
    st_count_dir1_carry__0_i_1
       (.I0(s13_dhb_counter_reg[11]),
        .I1(s13_dhb_counter_reg[10]),
        .O(st_count_dir1_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    st_count_dir1_carry__0_i_2
       (.I0(s13_dhb_counter_reg[8]),
        .I1(s13_dhb_counter_reg[9]),
        .O(st_count_dir1_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    st_count_dir1_carry__0_i_3
       (.I0(s13_dhb_counter_reg[10]),
        .I1(s13_dhb_counter_reg[11]),
        .O(st_count_dir1_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    st_count_dir1_carry__0_i_4
       (.I0(s13_dhb_counter_reg[8]),
        .I1(s13_dhb_counter_reg[9]),
        .O(st_count_dir1_carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    st_count_dir1_carry_i_1
       (.I0(s13_dhb_counter_reg[4]),
        .I1(s13_dhb_counter_reg[5]),
        .O(st_count_dir1_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    st_count_dir1_carry_i_2
       (.I0(s13_dhb_counter_reg[2]),
        .I1(s13_dhb_counter_reg[3]),
        .O(st_count_dir1_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    st_count_dir1_carry_i_3
       (.I0(s13_dhb_counter_reg[6]),
        .I1(s13_dhb_counter_reg[7]),
        .O(st_count_dir1_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    st_count_dir1_carry_i_4
       (.I0(s13_dhb_counter_reg[4]),
        .I1(s13_dhb_counter_reg[5]),
        .O(st_count_dir1_carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    st_count_dir1_carry_i_5
       (.I0(s13_dhb_counter_reg[2]),
        .I1(s13_dhb_counter_reg[3]),
        .O(st_count_dir1_carry_i_5_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    st_count_dir1_carry_i_6
       (.I0(s13_dhb_counter_reg[0]),
        .I1(s13_dhb_counter_reg[1]),
        .O(st_count_dir1_carry_i_6_n_0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \st_count_dir1_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\st_count_dir1_inferred__0/i__carry_n_0 ,\NLW_st_count_dir1_inferred__0/i__carry_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,i__carry_i_1__0_n_0,i__carry_i_2_n_0,i__carry_i_3__0_n_0}),
        .O(\NLW_st_count_dir1_inferred__0/i__carry_O_UNCONNECTED [3:0]),
        .S({i__carry_i_4__0_n_0,i__carry_i_5__0_n_0,i__carry_i_6__0_n_0,i__carry_i_7__0_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \st_count_dir1_inferred__0/i__carry__0 
       (.CI(\st_count_dir1_inferred__0/i__carry_n_0 ),
        .CO(\NLW_st_count_dir1_inferred__0/i__carry__0_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,s13_dhb_counter_reg[11]}),
        .O({\NLW_st_count_dir1_inferred__0/i__carry__0_O_UNCONNECTED [3:2],\st_count_dir1_inferred__0/i__carry__0_n_6 ,\NLW_st_count_dir1_inferred__0/i__carry__0_O_UNCONNECTED [0]}),
        .S({1'b0,1'b0,1'b1,i__carry__0_i_1__0_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    st_count_dir_i_1
       (.I0(st_count_dir1_carry__0_n_5),
        .I1(st_count_dir),
        .I2(\st_count_dir1_inferred__0/i__carry__0_n_6 ),
        .O(st_count_dir_i_1_n_0));
  FDRE st_count_dir_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(st_count_dir_i_1_n_0),
        .Q(st_count_dir),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT4 #(
    .INIT(16'hFFC8)) 
    \st_dt_states[0]_i_1 
       (.I0(sel0[5]),
        .I1(st_dt_states[0]),
        .I2(\st_dt_states[0]_i_2_n_0 ),
        .I3(\st_dt_states[0]_i_3_n_0 ),
        .O(\st_dt_states[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \st_dt_states[0]_i_2 
       (.I0(sel0[7]),
        .I1(sel0[6]),
        .I2(sel0[4]),
        .I3(sel0[3]),
        .O(\st_dt_states[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBFFDF0F0BFFD0F0F)) 
    \st_dt_states[0]_i_3 
       (.I0(sel0[2]),
        .I1(sel0[1]),
        .I2(st_dt_states[1]),
        .I3(sel0[0]),
        .I4(st_dt_states[0]),
        .I5(s_pri_pulse),
        .O(\st_dt_states[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hCCCD8CCC)) 
    \st_dt_states[1]_i_1 
       (.I0(\st_dt_states[1]_i_2_n_0 ),
        .I1(st_dt_states[1]),
        .I2(sel0[1]),
        .I3(sel0[0]),
        .I4(sel0[2]),
        .O(\st_dt_states[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF7FFFF)) 
    \st_dt_states[1]_i_2 
       (.I0(sel0[3]),
        .I1(sel0[4]),
        .I2(sel0[6]),
        .I3(sel0[7]),
        .I4(st_dt_states[0]),
        .I5(sel0[5]),
        .O(\st_dt_states[1]_i_2_n_0 ));
  FDRE \st_dt_states_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\st_dt_states[0]_i_1_n_0 ),
        .Q(st_dt_states[0]),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  FDRE \st_dt_states_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\st_dt_states[1]_i_1_n_0 ),
        .Q(st_dt_states[1]),
        .R(\FSM_sequential_st_dt_states[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \u12_phase_delay[0]_i_1 
       (.I0(s_sec_pulse),
        .I1(s_pri_pulse),
        .O(\u12_phase_delay[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_phase_delay[0]_i_3 
       (.I0(u12_phase_delay_reg[0]),
        .O(\u12_phase_delay[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[0]_i_2_n_7 ),
        .Q(u12_phase_delay_reg[0]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_phase_delay_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\u12_phase_delay_reg[0]_i_2_n_0 ,\NLW_u12_phase_delay_reg[0]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\u12_phase_delay_reg[0]_i_2_n_4 ,\u12_phase_delay_reg[0]_i_2_n_5 ,\u12_phase_delay_reg[0]_i_2_n_6 ,\u12_phase_delay_reg[0]_i_2_n_7 }),
        .S({u12_phase_delay_reg[3:1],\u12_phase_delay[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[8]_i_1_n_5 ),
        .Q(u12_phase_delay_reg[10]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[8]_i_1_n_4 ),
        .Q(u12_phase_delay_reg[11]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[0]_i_2_n_6 ),
        .Q(u12_phase_delay_reg[1]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[0]_i_2_n_5 ),
        .Q(u12_phase_delay_reg[2]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[0]_i_2_n_4 ),
        .Q(u12_phase_delay_reg[3]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[4]_i_1_n_7 ),
        .Q(u12_phase_delay_reg[4]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_phase_delay_reg[4]_i_1 
       (.CI(\u12_phase_delay_reg[0]_i_2_n_0 ),
        .CO({\u12_phase_delay_reg[4]_i_1_n_0 ,\NLW_u12_phase_delay_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\u12_phase_delay_reg[4]_i_1_n_4 ,\u12_phase_delay_reg[4]_i_1_n_5 ,\u12_phase_delay_reg[4]_i_1_n_6 ,\u12_phase_delay_reg[4]_i_1_n_7 }),
        .S(u12_phase_delay_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[4]_i_1_n_6 ),
        .Q(u12_phase_delay_reg[5]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[4]_i_1_n_5 ),
        .Q(u12_phase_delay_reg[6]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[4]_i_1_n_4 ),
        .Q(u12_phase_delay_reg[7]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[8]_i_1_n_7 ),
        .Q(u12_phase_delay_reg[8]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_phase_delay_reg[8]_i_1 
       (.CI(\u12_phase_delay_reg[4]_i_1_n_0 ),
        .CO(\NLW_u12_phase_delay_reg[8]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\u12_phase_delay_reg[8]_i_1_n_4 ,\u12_phase_delay_reg[8]_i_1_n_5 ,\u12_phase_delay_reg[8]_i_1_n_6 ,\u12_phase_delay_reg[8]_i_1_n_7 }),
        .S(u12_phase_delay_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \u12_phase_delay_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_phase_delay_reg[8]_i_1_n_6 ),
        .Q(u12_phase_delay_reg[9]),
        .R(\u12_phase_delay[0]_i_1_n_0 ));
endmodule

module pll_256mhz
   (clk_out1,
    locked,
    clk_in1);
  output clk_out1;
  output locked;
  input clk_in1;

  wire clk_in1;
  wire clk_out1;
  wire locked;

  pll_256mhz_clk_wiz inst
       (.clk_in1(clk_in1),
        .clk_out1(clk_out1),
        .locked(locked));
endmodule

module pll_256mhz_clk_wiz
   (clk_out1,
    locked,
    clk_in1);
  output clk_out1;
  output locked;
  input clk_in1;

  wire clk_in1;
  wire clk_in1_pll_256mhz;
  wire clk_out1;
  wire clk_out1_pll_256mhz;
  wire clkfbout_buf_pll_256mhz;
  wire clkfbout_pll_256mhz;
  wire locked;
  wire NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED;
  wire NLW_mmcm_adv_inst_DRDY_UNCONNECTED;
  wire NLW_mmcm_adv_inst_PSDONE_UNCONNECTED;
  wire [15:0]NLW_mmcm_adv_inst_DO_UNCONNECTED;

  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkf_buf
       (.I(clkfbout_pll_256mhz),
        .O(clkfbout_buf_pll_256mhz));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUF #(
    .IOSTANDARD("DEFAULT")) 
    clkin1_ibufg
       (.I(clk_in1),
        .O(clk_in1_pll_256mhz));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout1_buf
       (.I(clk_out1_pll_256mhz),
        .O(clk_out1));
  (* BOX_TYPE = "PRIMITIVE" *) 
  MMCME2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT_F(31.000000),
    .CLKFBOUT_PHASE(0.000000),
    .CLKFBOUT_USE_FINE_PS("FALSE"),
    .CLKIN1_PERIOD(31.250000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE_F(3.875000),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT0_USE_FINE_PS("FALSE"),
    .CLKOUT1_DIVIDE(1),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT1_USE_FINE_PS("FALSE"),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT2_USE_FINE_PS("FALSE"),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT3_USE_FINE_PS("FALSE"),
    .CLKOUT4_CASCADE("FALSE"),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT4_USE_FINE_PS("FALSE"),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .CLKOUT5_USE_FINE_PS("FALSE"),
    .CLKOUT6_DIVIDE(1),
    .CLKOUT6_DUTY_CYCLE(0.500000),
    .CLKOUT6_PHASE(0.000000),
    .CLKOUT6_USE_FINE_PS("FALSE"),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PSEN_INVERTED(1'b0),
    .IS_PSINCDEC_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.010000),
    .REF_JITTER2(0.010000),
    .SS_EN("FALSE"),
    .SS_MODE("CENTER_HIGH"),
    .SS_MOD_PERIOD(10000),
    .STARTUP_WAIT("FALSE")) 
    mmcm_adv_inst
       (.CLKFBIN(clkfbout_buf_pll_256mhz),
        .CLKFBOUT(clkfbout_pll_256mhz),
        .CLKFBOUTB(NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED),
        .CLKFBSTOPPED(NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED),
        .CLKIN1(clk_in1_pll_256mhz),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKINSTOPPED(NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED),
        .CLKOUT0(clk_out1_pll_256mhz),
        .CLKOUT0B(NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED),
        .CLKOUT1(NLW_mmcm_adv_inst_CLKOUT1_UNCONNECTED),
        .CLKOUT1B(NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED),
        .CLKOUT2(NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED),
        .CLKOUT2B(NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED),
        .CLKOUT3(NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED),
        .CLKOUT3B(NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED),
        .CLKOUT4(NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED),
        .CLKOUT6(NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_mmcm_adv_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_mmcm_adv_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(locked),
        .PSCLK(1'b0),
        .PSDONE(NLW_mmcm_adv_inst_PSDONE_UNCONNECTED),
        .PSEN(1'b0),
        .PSINCDEC(1'b0),
        .PWRDWN(1'b0),
        .RST(1'b0));
endmodule

module sw_supply_ctrl
   (so_ext_ad1_start,
    \po4_dhb_pwm[pri_high] ,
    \po4_dhb_pwm[pri_low] ,
    \po4_dhb_pwm[sec_high] ,
    \po4_dhb_pwm[sec_low] ,
    \po4_ht_pwm[pri_high] ,
    \po4_ht_pwm[pri_low] ,
    \po2_pfc_pwm[ac1] ,
    \jihuu_reg[rstn]_0 ,
    rstn,
    clk_out1,
    r_so_uart_rx_rdy,
    \jihuu_reg[rstn]_1 ,
    r_si_rstn_reg,
    E,
    Q,
    \r_piu12_per_ctrl_reg[0] ,
    lopt,
    lopt_1,
    lopt_2,
    lopt_3,
    lopt_4,
    lopt_5);
  output so_ext_ad1_start;
  output \po4_dhb_pwm[pri_high] ;
  output \po4_dhb_pwm[pri_low] ;
  output \po4_dhb_pwm[sec_high] ;
  output \po4_dhb_pwm[sec_low] ;
  output \po4_ht_pwm[pri_high] ;
  output \po4_ht_pwm[pri_low] ;
  output \po2_pfc_pwm[ac1] ;
  output \jihuu_reg[rstn]_0 ;
  output rstn;
  input clk_out1;
  input r_so_uart_rx_rdy;
  input \jihuu_reg[rstn]_1 ;
  input r_si_rstn_reg;
  input [0:0]E;
  input [15:0]Q;
  input [0:0]\r_piu12_per_ctrl_reg[0] ;
  output lopt;
  output lopt_1;
  output lopt_2;
  output lopt_3;
  output lopt_4;
  output lopt_5;

  wire [0:0]E;
  wire [15:0]Q;
  wire clk_out1;
  wire dir;
  wire dir0;
  wire dir_i_2_n_0;
  wire dir_i_3_n_0;
  wire dir_i_4_n_0;
  wire \heater_cntr[0]_i_2_n_0 ;
  wire [11:0]heater_cntr_reg;
  wire \heater_cntr_reg[0]_i_1_n_0 ;
  wire \heater_cntr_reg[0]_i_1_n_4 ;
  wire \heater_cntr_reg[0]_i_1_n_5 ;
  wire \heater_cntr_reg[0]_i_1_n_6 ;
  wire \heater_cntr_reg[0]_i_1_n_7 ;
  wire \heater_cntr_reg[4]_i_1_n_0 ;
  wire \heater_cntr_reg[4]_i_1_n_4 ;
  wire \heater_cntr_reg[4]_i_1_n_5 ;
  wire \heater_cntr_reg[4]_i_1_n_6 ;
  wire \heater_cntr_reg[4]_i_1_n_7 ;
  wire \heater_cntr_reg[8]_i_1_n_4 ;
  wire \heater_cntr_reg[8]_i_1_n_5 ;
  wire \heater_cntr_reg[8]_i_1_n_6 ;
  wire \heater_cntr_reg[8]_i_1_n_7 ;
  wire \jihuu_reg[rstn]_0 ;
  wire \jihuu_reg[rstn]_1 ;
  wire [11:0]\jihuu_reg[s16_phase] ;
  wire lopt;
  wire lopt_2;
  wire lopt_4;
  wire \po2_pfc_pwm[ac1] ;
  wire \po4_dhb_pwm[pri_high] ;
  wire \po4_dhb_pwm[pri_low] ;
  wire \po4_dhb_pwm[sec_high] ;
  wire \po4_dhb_pwm[sec_low] ;
  wire \po4_ht_pwm[pri_high] ;
  wire \po4_ht_pwm[pri_low] ;
  wire [0:0]\r_piu12_per_ctrl_reg[0] ;
  wire r_si_rstn_reg;
  wire r_so_uart_rx_rdy;
  wire rstn;
  wire so_ext_ad1_start;
  wire so_ext_ad1_start_i_1_n_0;
  wire so_ext_ad1_start_i_2_n_0;
  wire so_ext_ad1_start_i_3_n_0;
  wire \u12_carrier[0]_i_2__0_n_0 ;
  wire \u12_carrier[0]_i_3_n_0 ;
  wire \u12_carrier[0]_i_4_n_0 ;
  wire \u12_carrier[0]_i_5_n_0 ;
  wire \u12_carrier[0]_i_6_n_0 ;
  wire \u12_carrier[4]_i_2_n_0 ;
  wire \u12_carrier[4]_i_3_n_0 ;
  wire \u12_carrier[4]_i_4_n_0 ;
  wire \u12_carrier[4]_i_5_n_0 ;
  wire \u12_carrier[8]_i_2_n_0 ;
  wire \u12_carrier[8]_i_3_n_0 ;
  wire \u12_carrier[8]_i_4_n_0 ;
  wire \u12_carrier[8]_i_5_n_0 ;
  wire [11:0]u12_carrier_reg;
  wire \u12_carrier_reg[0]_i_1__0_n_0 ;
  wire \u12_carrier_reg[0]_i_1__0_n_4 ;
  wire \u12_carrier_reg[0]_i_1__0_n_5 ;
  wire \u12_carrier_reg[0]_i_1__0_n_6 ;
  wire \u12_carrier_reg[0]_i_1__0_n_7 ;
  wire \u12_carrier_reg[4]_i_1__0_n_0 ;
  wire \u12_carrier_reg[4]_i_1__0_n_4 ;
  wire \u12_carrier_reg[4]_i_1__0_n_5 ;
  wire \u12_carrier_reg[4]_i_1__0_n_6 ;
  wire \u12_carrier_reg[4]_i_1__0_n_7 ;
  wire \u12_carrier_reg[8]_i_1__0_n_4 ;
  wire \u12_carrier_reg[8]_i_1__0_n_5 ;
  wire \u12_carrier_reg[8]_i_1__0_n_6 ;
  wire \u12_carrier_reg[8]_i_1__0_n_7 ;
  wire [2:0]\NLW_heater_cntr_reg[0]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_heater_cntr_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_heater_cntr_reg[8]_i_1_CO_UNCONNECTED ;
  wire NLW_heater_control_lopt_1_UNCONNECTED;
  wire NLW_heater_control_lopt_3_UNCONNECTED;
  wire NLW_pfc_control_ins_lopt_1_UNCONNECTED;
  wire [2:0]\NLW_u12_carrier_reg[0]_i_1__0_CO_UNCONNECTED ;
  wire [2:0]\NLW_u12_carrier_reg[4]_i_1__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_u12_carrier_reg[8]_i_1__0_CO_UNCONNECTED ;

  phase_modulator dhb_modulator
       (.DI(\jihuu_reg[rstn]_0 ),
        .Q(\jihuu_reg[s16_phase] ),
        .clk_out1(clk_out1),
        .\po4_dhb_pwm[pri_high] (\po4_dhb_pwm[pri_high] ),
        .\po4_dhb_pwm[pri_low] (\po4_dhb_pwm[pri_low] ),
        .\po4_dhb_pwm[sec_high] (\po4_dhb_pwm[sec_high] ),
        .\po4_dhb_pwm[sec_low] (\po4_dhb_pwm[sec_low] ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    dir_i_1
       (.I0(dir_i_2_n_0),
        .I1(dir_i_3_n_0),
        .I2(u12_carrier_reg[10]),
        .I3(u12_carrier_reg[9]),
        .O(dir0));
  LUT6 #(
    .INIT(64'hFFFFFEFE88808080)) 
    dir_i_2
       (.I0(u12_carrier_reg[8]),
        .I1(u12_carrier_reg[7]),
        .I2(u12_carrier_reg[6]),
        .I3(dir_i_4_n_0),
        .I4(u12_carrier_reg[5]),
        .I5(dir),
        .O(dir_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFF0F0FFFDF0F0)) 
    dir_i_3
       (.I0(u12_carrier_reg[0]),
        .I1(u12_carrier_reg[2]),
        .I2(u12_carrier_reg[11]),
        .I3(dir_i_4_n_0),
        .I4(dir),
        .I5(u12_carrier_reg[1]),
        .O(dir_i_3_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    dir_i_4
       (.I0(u12_carrier_reg[3]),
        .I1(u12_carrier_reg[4]),
        .O(dir_i_4_n_0));
  FDRE dir_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(dir0),
        .Q(dir),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \heater_cntr[0]_i_2 
       (.I0(heater_cntr_reg[0]),
        .O(\heater_cntr[0]_i_2_n_0 ));
  FDRE \heater_cntr_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[0]_i_1_n_7 ),
        .Q(heater_cntr_reg[0]),
        .R(so_ext_ad1_start_i_1_n_0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \heater_cntr_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\heater_cntr_reg[0]_i_1_n_0 ,\NLW_heater_cntr_reg[0]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\heater_cntr_reg[0]_i_1_n_4 ,\heater_cntr_reg[0]_i_1_n_5 ,\heater_cntr_reg[0]_i_1_n_6 ,\heater_cntr_reg[0]_i_1_n_7 }),
        .S({heater_cntr_reg[3:1],\heater_cntr[0]_i_2_n_0 }));
  FDRE \heater_cntr_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[8]_i_1_n_5 ),
        .Q(heater_cntr_reg[10]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[8]_i_1_n_4 ),
        .Q(heater_cntr_reg[11]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[0]_i_1_n_6 ),
        .Q(heater_cntr_reg[1]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[0]_i_1_n_5 ),
        .Q(heater_cntr_reg[2]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[0]_i_1_n_4 ),
        .Q(heater_cntr_reg[3]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[4]_i_1_n_7 ),
        .Q(heater_cntr_reg[4]),
        .R(so_ext_ad1_start_i_1_n_0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \heater_cntr_reg[4]_i_1 
       (.CI(\heater_cntr_reg[0]_i_1_n_0 ),
        .CO({\heater_cntr_reg[4]_i_1_n_0 ,\NLW_heater_cntr_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\heater_cntr_reg[4]_i_1_n_4 ,\heater_cntr_reg[4]_i_1_n_5 ,\heater_cntr_reg[4]_i_1_n_6 ,\heater_cntr_reg[4]_i_1_n_7 }),
        .S(heater_cntr_reg[7:4]));
  FDRE \heater_cntr_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[4]_i_1_n_6 ),
        .Q(heater_cntr_reg[5]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[4]_i_1_n_5 ),
        .Q(heater_cntr_reg[6]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[4]_i_1_n_4 ),
        .Q(heater_cntr_reg[7]),
        .R(so_ext_ad1_start_i_1_n_0));
  FDRE \heater_cntr_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[8]_i_1_n_7 ),
        .Q(heater_cntr_reg[8]),
        .R(so_ext_ad1_start_i_1_n_0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \heater_cntr_reg[8]_i_1 
       (.CI(\heater_cntr_reg[4]_i_1_n_0 ),
        .CO(\NLW_heater_cntr_reg[8]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\heater_cntr_reg[8]_i_1_n_4 ,\heater_cntr_reg[8]_i_1_n_5 ,\heater_cntr_reg[8]_i_1_n_6 ,\heater_cntr_reg[8]_i_1_n_7 }),
        .S(heater_cntr_reg[11:8]));
  FDRE \heater_cntr_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\heater_cntr_reg[8]_i_1_n_6 ),
        .Q(heater_cntr_reg[9]),
        .R(so_ext_ad1_start_i_1_n_0));
  heater_ctrl heater_control
       (.Q(Q[11:0]),
        .clk_out1(clk_out1),
        .lopt(lopt_2),
        .lopt_1(NLW_heater_control_lopt_1_UNCONNECTED),
        .lopt_2(lopt_4),
        .lopt_3(NLW_heater_control_lopt_3_UNCONNECTED),
        .\po4_ht_pwm[pri_high] (\po4_ht_pwm[pri_high] ),
        .\po4_ht_pwm[pri_low] (\po4_ht_pwm[pri_low] ),
        .\r_piu12_per_ctrl_reg[0]_0 (\r_piu12_per_ctrl_reg[0] ),
        .r_si_rstn_reg_0(rstn),
        .r_si_rstn_reg_1(r_si_rstn_reg));
  FDRE \jihuu_reg[rstn] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\jihuu_reg[rstn]_1 ),
        .Q(\jihuu_reg[rstn]_0 ),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][0] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[0]),
        .Q(\jihuu_reg[s16_phase] [0]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][10] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[10]),
        .Q(\jihuu_reg[s16_phase] [10]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][11] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[11]),
        .Q(\jihuu_reg[s16_phase] [11]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][1] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[1]),
        .Q(\jihuu_reg[s16_phase] [1]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][2] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[2]),
        .Q(\jihuu_reg[s16_phase] [2]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][3] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[3]),
        .Q(\jihuu_reg[s16_phase] [3]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][4] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[4]),
        .Q(\jihuu_reg[s16_phase] [4]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][5] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[5]),
        .Q(\jihuu_reg[s16_phase] [5]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][6] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[6]),
        .Q(\jihuu_reg[s16_phase] [6]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][7] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[7]),
        .Q(\jihuu_reg[s16_phase] [7]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][8] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[8]),
        .Q(\jihuu_reg[s16_phase] [8]),
        .R(1'b0));
  FDRE \jihuu_reg[s16_phase][9] 
       (.C(clk_out1),
        .CE(E),
        .D(Q[9]),
        .Q(\jihuu_reg[s16_phase] [9]),
        .R(1'b0));
  pfc_control pfc_control_ins
       (.Q(Q),
        .clk_out1(clk_out1),
        .lopt(lopt),
        .lopt_1(NLW_pfc_control_ins_lopt_1_UNCONNECTED),
        .\po2_pfc_pwm[ac1] (\po2_pfc_pwm[ac1] ),
        .r_so_uart_rx_rdy(r_so_uart_rx_rdy),
        .u12_carrier_reg(u12_carrier_reg));
  LUT5 #(
    .INIT(32'hFFFEEEEE)) 
    so_ext_ad1_start_i_1
       (.I0(heater_cntr_reg[11]),
        .I1(heater_cntr_reg[10]),
        .I2(so_ext_ad1_start_i_2_n_0),
        .I3(heater_cntr_reg[6]),
        .I4(so_ext_ad1_start_i_3_n_0),
        .O(so_ext_ad1_start_i_1_n_0));
  LUT6 #(
    .INIT(64'h8888888080808080)) 
    so_ext_ad1_start_i_2
       (.I0(heater_cntr_reg[5]),
        .I1(heater_cntr_reg[4]),
        .I2(heater_cntr_reg[3]),
        .I3(heater_cntr_reg[1]),
        .I4(heater_cntr_reg[0]),
        .I5(heater_cntr_reg[2]),
        .O(so_ext_ad1_start_i_2_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    so_ext_ad1_start_i_3
       (.I0(heater_cntr_reg[9]),
        .I1(heater_cntr_reg[8]),
        .I2(heater_cntr_reg[7]),
        .O(so_ext_ad1_start_i_3_n_0));
  FDRE so_ext_ad1_start_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(so_ext_ad1_start_i_1_n_0),
        .Q(so_ext_ad1_start),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \u12_carrier[0]_i_2__0 
       (.I0(dir),
        .O(\u12_carrier[0]_i_2__0_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[0]_i_3 
       (.I0(dir),
        .I1(u12_carrier_reg[3]),
        .O(\u12_carrier[0]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[0]_i_4 
       (.I0(dir),
        .I1(u12_carrier_reg[2]),
        .O(\u12_carrier[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[0]_i_5 
       (.I0(dir),
        .I1(u12_carrier_reg[1]),
        .O(\u12_carrier[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[0]_i_6 
       (.I0(dir),
        .I1(u12_carrier_reg[0]),
        .O(\u12_carrier[0]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[4]_i_2 
       (.I0(dir),
        .I1(u12_carrier_reg[7]),
        .O(\u12_carrier[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[4]_i_3 
       (.I0(dir),
        .I1(u12_carrier_reg[6]),
        .O(\u12_carrier[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[4]_i_4 
       (.I0(dir),
        .I1(u12_carrier_reg[5]),
        .O(\u12_carrier[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[4]_i_5 
       (.I0(dir),
        .I1(u12_carrier_reg[4]),
        .O(\u12_carrier[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[8]_i_2 
       (.I0(dir),
        .I1(u12_carrier_reg[11]),
        .O(\u12_carrier[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[8]_i_3 
       (.I0(dir),
        .I1(u12_carrier_reg[10]),
        .O(\u12_carrier[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[8]_i_4 
       (.I0(dir),
        .I1(u12_carrier_reg[9]),
        .O(\u12_carrier[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \u12_carrier[8]_i_5 
       (.I0(dir),
        .I1(u12_carrier_reg[8]),
        .O(\u12_carrier[8]_i_5_n_0 ));
  FDRE \u12_carrier_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1__0_n_7 ),
        .Q(u12_carrier_reg[0]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_carrier_reg[0]_i_1__0 
       (.CI(1'b0),
        .CO({\u12_carrier_reg[0]_i_1__0_n_0 ,\NLW_u12_carrier_reg[0]_i_1__0_CO_UNCONNECTED [2:0]}),
        .CYINIT(\u12_carrier[0]_i_2__0_n_0 ),
        .DI({dir,dir,dir,dir}),
        .O({\u12_carrier_reg[0]_i_1__0_n_4 ,\u12_carrier_reg[0]_i_1__0_n_5 ,\u12_carrier_reg[0]_i_1__0_n_6 ,\u12_carrier_reg[0]_i_1__0_n_7 }),
        .S({\u12_carrier[0]_i_3_n_0 ,\u12_carrier[0]_i_4_n_0 ,\u12_carrier[0]_i_5_n_0 ,\u12_carrier[0]_i_6_n_0 }));
  FDRE \u12_carrier_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1__0_n_5 ),
        .Q(u12_carrier_reg[10]),
        .R(1'b0));
  FDRE \u12_carrier_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1__0_n_4 ),
        .Q(u12_carrier_reg[11]),
        .R(1'b0));
  FDRE \u12_carrier_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1__0_n_6 ),
        .Q(u12_carrier_reg[1]),
        .R(1'b0));
  FDRE \u12_carrier_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1__0_n_5 ),
        .Q(u12_carrier_reg[2]),
        .R(1'b0));
  FDRE \u12_carrier_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[0]_i_1__0_n_4 ),
        .Q(u12_carrier_reg[3]),
        .R(1'b0));
  FDRE \u12_carrier_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1__0_n_7 ),
        .Q(u12_carrier_reg[4]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_carrier_reg[4]_i_1__0 
       (.CI(\u12_carrier_reg[0]_i_1__0_n_0 ),
        .CO({\u12_carrier_reg[4]_i_1__0_n_0 ,\NLW_u12_carrier_reg[4]_i_1__0_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({dir,dir,dir,dir}),
        .O({\u12_carrier_reg[4]_i_1__0_n_4 ,\u12_carrier_reg[4]_i_1__0_n_5 ,\u12_carrier_reg[4]_i_1__0_n_6 ,\u12_carrier_reg[4]_i_1__0_n_7 }),
        .S({\u12_carrier[4]_i_2_n_0 ,\u12_carrier[4]_i_3_n_0 ,\u12_carrier[4]_i_4_n_0 ,\u12_carrier[4]_i_5_n_0 }));
  FDRE \u12_carrier_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1__0_n_6 ),
        .Q(u12_carrier_reg[5]),
        .R(1'b0));
  FDRE \u12_carrier_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1__0_n_5 ),
        .Q(u12_carrier_reg[6]),
        .R(1'b0));
  FDRE \u12_carrier_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[4]_i_1__0_n_4 ),
        .Q(u12_carrier_reg[7]),
        .R(1'b0));
  FDRE \u12_carrier_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1__0_n_7 ),
        .Q(u12_carrier_reg[8]),
        .R(1'b0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \u12_carrier_reg[8]_i_1__0 
       (.CI(\u12_carrier_reg[4]_i_1__0_n_0 ),
        .CO(\NLW_u12_carrier_reg[8]_i_1__0_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,dir,dir,dir}),
        .O({\u12_carrier_reg[8]_i_1__0_n_4 ,\u12_carrier_reg[8]_i_1__0_n_5 ,\u12_carrier_reg[8]_i_1__0_n_6 ,\u12_carrier_reg[8]_i_1__0_n_7 }),
        .S({\u12_carrier[8]_i_2_n_0 ,\u12_carrier[8]_i_3_n_0 ,\u12_carrier[8]_i_4_n_0 ,\u12_carrier[8]_i_5_n_0 }));
  FDRE \u12_carrier_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\u12_carrier_reg[8]_i_1__0_n_6 ),
        .Q(u12_carrier_reg[9]),
        .R(1'b0));
endmodule

module system_control
   (\po3_led1[red] ,
    \po3_led1[green] ,
    \po3_led1[blue] ,
    \po3_led2[red] ,
    \po3_led2[green] ,
    \po3_led2[blue] ,
    \po3_led3[red] ,
    \po3_led3[green] ,
    \po3_led3[blue] ,
    po_adb_cs,
    po_ada_cs,
    po_uart_tx,
    Q,
    po_ext_ad1_cs,
    po_ext_ad2_cs,
    \po4_dhb_pwm[pri_high] ,
    \po4_dhb_pwm[pri_low] ,
    \po4_dhb_pwm[sec_high] ,
    \po4_dhb_pwm[sec_low] ,
    \po4_ht_pwm[pri_high] ,
    \po4_ht_pwm[pri_low] ,
    \po2_pfc_pwm[ac1] ,
    po_bypass_relay,
    po_ada_clk_OBUF,
    po_adb_clk_OBUF,
    po_ext_ad1_clk_OBUF,
    po_ext_ad2_clk_OBUF,
    clk_out1,
    pi_uart_rx,
    D,
    \b_spi_rx_reg[0] ,
    locked,
    lopt,
    lopt_1,
    lopt_2,
    lopt_3,
    lopt_4,
    lopt_5,
    lopt_6,
    lopt_7,
    lopt_8,
    lopt_9,
    lopt_10,
    lopt_11);
  output \po3_led1[red] ;
  output \po3_led1[green] ;
  output \po3_led1[blue] ;
  output \po3_led2[red] ;
  output \po3_led2[green] ;
  output \po3_led2[blue] ;
  output \po3_led3[red] ;
  output \po3_led3[green] ;
  output \po3_led3[blue] ;
  output po_adb_cs;
  output po_ada_cs;
  output po_uart_tx;
  output [2:0]Q;
  output po_ext_ad1_cs;
  output po_ext_ad2_cs;
  output \po4_dhb_pwm[pri_high] ;
  output \po4_dhb_pwm[pri_low] ;
  output \po4_dhb_pwm[sec_high] ;
  output \po4_dhb_pwm[sec_low] ;
  output \po4_ht_pwm[pri_high] ;
  output \po4_ht_pwm[pri_low] ;
  output \po2_pfc_pwm[ac1] ;
  output po_bypass_relay;
  output po_ada_clk_OBUF;
  output po_adb_clk_OBUF;
  output po_ext_ad1_clk_OBUF;
  output po_ext_ad2_clk_OBUF;
  input clk_out1;
  input pi_uart_rx;
  input [0:0]D;
  input [0:0]\b_spi_rx_reg[0] ;
  input locked;
  output lopt;
  output lopt_1;
  output lopt_2;
  output lopt_3;
  output lopt_4;
  output lopt_5;
  output lopt_6;
  output lopt_7;
  output lopt_8;
  output lopt_9;
  output lopt_10;
  output lopt_11;

  wire [0:0]D;
  wire \FSM_onehot_st_main_states[3]_i_1_n_0 ;
  wire \FSM_onehot_st_main_states[4]_i_1_n_0 ;
  wire \FSM_onehot_st_main_states[4]_i_3_n_0 ;
  wire \FSM_onehot_st_main_states_reg_n_0_[0] ;
  wire \FSM_onehot_st_main_states_reg_n_0_[1] ;
  wire \FSM_onehot_st_main_states_reg_n_0_[2] ;
  wire \FSM_onehot_st_main_states_reg_n_0_[3] ;
  wire \FSM_onehot_st_main_states_reg_n_0_[4] ;
  wire [2:0]Q;
  wire [0:0]\b_spi_rx_reg[0] ;
  wire clear;
  wire clk_out1;
  wire [21:1]data0;
  wire dly_complete;
  wire \dly_complete0_inferred__0/i__carry_n_0 ;
  wire dly_complete_i_1_n_0;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_6_n_0;
  wire i__carry__0_i_7_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2__0_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_6_n_0;
  wire i__carry_i_7_n_0;
  wire [6:4]\led1_color[u9_blu_duty]1_in ;
  wire \led1_color[u9_blu_duty][6]_i_1_n_0 ;
  wire [3:3]\led1_color[u9_grn_duty] ;
  wire [6:6]\led1_color[u9_red_duty] ;
  wire \led1_color_reg[u9_blu_duty_n_0_][2] ;
  wire \led1_color_reg[u9_blu_duty_n_0_][4] ;
  wire \led1_color_reg[u9_blu_duty_n_0_][5] ;
  wire \led1_color_reg[u9_blu_duty_n_0_][6] ;
  wire \led1_color_reg[u9_grn_duty_n_0_][1] ;
  wire \led1_color_reg[u9_grn_duty_n_0_][3] ;
  wire \led1_color_reg[u9_grn_duty_n_0_][5] ;
  wire \led1_color_reg[u9_red_duty_n_0_][6] ;
  wire locked;
  wire lopt;
  wire lopt_10;
  wire lopt_2;
  wire lopt_4;
  wire lopt_6;
  wire lopt_8;
  wire p_1_in;
  wire pi_uart_rx;
  wire [21:0]plusOp_0;
  wire plusOp_carry__0_n_0;
  wire plusOp_carry__1_n_0;
  wire plusOp_carry__2_n_0;
  wire plusOp_carry__3_n_0;
  wire plusOp_carry_n_0;
  wire \po2_pfc_pwm[ac1] ;
  wire \po3_led1[blue] ;
  wire \po3_led1[green] ;
  wire \po3_led1[red] ;
  wire \po3_led2[blue] ;
  wire \po3_led2[green] ;
  wire \po3_led2[red] ;
  wire \po3_led3[blue] ;
  wire \po3_led3[green] ;
  wire \po3_led3[red] ;
  wire \po4_dhb_pwm[pri_high] ;
  wire \po4_dhb_pwm[pri_low] ;
  wire \po4_dhb_pwm[sec_high] ;
  wire \po4_dhb_pwm[sec_low] ;
  wire \po4_ht_pwm[pri_high] ;
  wire \po4_ht_pwm[pri_low] ;
  wire po_ada_clk_OBUF;
  wire po_ada_cs;
  wire po_adb_clk_OBUF;
  wire po_adb_cs;
  wire po_bypass_relay;
  wire po_bypass_relay0_out;
  wire po_ext_ad1_clk_OBUF;
  wire po_ext_ad1_cs;
  wire po_ext_ad2_clk_OBUF;
  wire po_ext_ad2_cs;
  wire po_uart_tx;
  wire [22:0]sel0;
  wire start_dly;
  wire system_data_control_n_16;
  wire system_data_control_n_17;
  wire system_data_control_n_18;
  wire system_data_control_n_19;
  wire \u10_dly_cnt_reg_n_0_[0] ;
  wire \u10_dly_cnt_reg_n_0_[1] ;
  wire \u10_dly_cnt_reg_n_0_[5] ;
  wire [21:0]u22_init_dly_cnt;
  wire \u22_init_dly_cnt[0]_i_2_n_0 ;
  wire \u22_init_dly_cnt[0]_i_3_n_0 ;
  wire \u22_init_dly_cnt[0]_i_4_n_0 ;
  wire \u22_init_dly_cnt[0]_i_5_n_0 ;
  wire \u22_init_dly_cnt[0]_i_6_n_0 ;
  wire v_u10_dly_cnt;
  wire [21:0]v_u10_dly_cnt_reg;
  wire \v_u10_dly_cnt_reg[0]_i_2_n_0 ;
  wire \v_u10_dly_cnt_reg[0]_i_2_n_4 ;
  wire \v_u10_dly_cnt_reg[0]_i_2_n_5 ;
  wire \v_u10_dly_cnt_reg[0]_i_2_n_6 ;
  wire \v_u10_dly_cnt_reg[0]_i_2_n_7 ;
  wire \v_u10_dly_cnt_reg[12]_i_1_n_0 ;
  wire \v_u10_dly_cnt_reg[12]_i_1_n_4 ;
  wire \v_u10_dly_cnt_reg[12]_i_1_n_5 ;
  wire \v_u10_dly_cnt_reg[12]_i_1_n_6 ;
  wire \v_u10_dly_cnt_reg[12]_i_1_n_7 ;
  wire \v_u10_dly_cnt_reg[16]_i_1_n_0 ;
  wire \v_u10_dly_cnt_reg[16]_i_1_n_4 ;
  wire \v_u10_dly_cnt_reg[16]_i_1_n_5 ;
  wire \v_u10_dly_cnt_reg[16]_i_1_n_6 ;
  wire \v_u10_dly_cnt_reg[16]_i_1_n_7 ;
  wire \v_u10_dly_cnt_reg[20]_i_1_n_6 ;
  wire \v_u10_dly_cnt_reg[20]_i_1_n_7 ;
  wire \v_u10_dly_cnt_reg[4]_i_1_n_0 ;
  wire \v_u10_dly_cnt_reg[4]_i_1_n_4 ;
  wire \v_u10_dly_cnt_reg[4]_i_1_n_5 ;
  wire \v_u10_dly_cnt_reg[4]_i_1_n_6 ;
  wire \v_u10_dly_cnt_reg[4]_i_1_n_7 ;
  wire \v_u10_dly_cnt_reg[8]_i_1_n_0 ;
  wire \v_u10_dly_cnt_reg[8]_i_1_n_4 ;
  wire \v_u10_dly_cnt_reg[8]_i_1_n_5 ;
  wire \v_u10_dly_cnt_reg[8]_i_1_n_6 ;
  wire \v_u10_dly_cnt_reg[8]_i_1_n_7 ;
  wire zero_cross_event_reg_n_0;
  wire [2:0]\NLW_dly_complete0_inferred__0/i__carry_CO_UNCONNECTED ;
  wire [3:0]\NLW_dly_complete0_inferred__0/i__carry_O_UNCONNECTED ;
  wire [2:0]\NLW_dly_complete0_inferred__0/i__carry__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_dly_complete0_inferred__0/i__carry__0_O_UNCONNECTED ;
  wire [3:0]NLW_i__carry__0_i_5_CO_UNCONNECTED;
  wire [3:1]NLW_i__carry__0_i_5_O_UNCONNECTED;
  wire [2:0]NLW_i__carry__0_i_6_CO_UNCONNECTED;
  wire [2:0]NLW_i__carry__0_i_7_CO_UNCONNECTED;
  wire [2:0]NLW_i__carry_i_5_CO_UNCONNECTED;
  wire [2:0]NLW_i__carry_i_6_CO_UNCONNECTED;
  wire [2:0]NLW_i__carry_i_7_CO_UNCONNECTED;
  wire [2:0]NLW_plusOp_carry_CO_UNCONNECTED;
  wire [2:0]NLW_plusOp_carry__0_CO_UNCONNECTED;
  wire [2:0]NLW_plusOp_carry__1_CO_UNCONNECTED;
  wire [2:0]NLW_plusOp_carry__2_CO_UNCONNECTED;
  wire [2:0]NLW_plusOp_carry__3_CO_UNCONNECTED;
  wire [3:0]NLW_plusOp_carry__4_CO_UNCONNECTED;
  wire [3:1]NLW_plusOp_carry__4_O_UNCONNECTED;
  wire NLW_system_data_control_lopt_1_UNCONNECTED;
  wire NLW_system_data_control_lopt_11_UNCONNECTED;
  wire NLW_system_data_control_lopt_3_UNCONNECTED;
  wire NLW_system_data_control_lopt_5_UNCONNECTED;
  wire NLW_system_data_control_lopt_7_UNCONNECTED;
  wire NLW_system_data_control_lopt_9_UNCONNECTED;
  wire [2:0]\NLW_v_u10_dly_cnt_reg[0]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_v_u10_dly_cnt_reg[12]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_v_u10_dly_cnt_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_v_u10_dly_cnt_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_v_u10_dly_cnt_reg[20]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_v_u10_dly_cnt_reg[4]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_v_u10_dly_cnt_reg[8]_i_1_CO_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT4 #(
    .INIT(16'hF044)) 
    \FSM_onehot_st_main_states[3]_i_1 
       (.I0(zero_cross_event_reg_n_0),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .I2(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .I3(dly_complete),
        .O(\FSM_onehot_st_main_states[3]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_st_main_states[4]_i_1 
       (.I0(locked),
        .O(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT4 #(
    .INIT(16'hFEAA)) 
    \FSM_onehot_st_main_states[4]_i_3 
       (.I0(\FSM_onehot_st_main_states_reg_n_0_[4] ),
        .I1(zero_cross_event_reg_n_0),
        .I2(dly_complete),
        .I3(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .O(\FSM_onehot_st_main_states[4]_i_3_n_0 ));
  (* FSM_ENCODED_STATES = "init:00001,charge_dc_link:00010,bypass_relay:00100,start_aux:01000,system_running:10000" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_st_main_states_reg[0] 
       (.C(clk_out1),
        .CE(system_data_control_n_16),
        .D(1'b0),
        .Q(\FSM_onehot_st_main_states_reg_n_0_[0] ),
        .S(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "init:00001,charge_dc_link:00010,bypass_relay:00100,start_aux:01000,system_running:10000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_st_main_states_reg[1] 
       (.C(clk_out1),
        .CE(system_data_control_n_16),
        .D(system_data_control_n_18),
        .Q(\FSM_onehot_st_main_states_reg_n_0_[1] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "init:00001,charge_dc_link:00010,bypass_relay:00100,start_aux:01000,system_running:10000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_st_main_states_reg[2] 
       (.C(clk_out1),
        .CE(system_data_control_n_16),
        .D(system_data_control_n_17),
        .Q(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "init:00001,charge_dc_link:00010,bypass_relay:00100,start_aux:01000,system_running:10000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_st_main_states_reg[3] 
       (.C(clk_out1),
        .CE(system_data_control_n_16),
        .D(\FSM_onehot_st_main_states[3]_i_1_n_0 ),
        .Q(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "init:00001,charge_dc_link:00010,bypass_relay:00100,start_aux:01000,system_running:10000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_st_main_states_reg[4] 
       (.C(clk_out1),
        .CE(system_data_control_n_16),
        .D(\FSM_onehot_st_main_states[4]_i_3_n_0 ),
        .Q(\FSM_onehot_st_main_states_reg_n_0_[4] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  led_driver burn_leds
       (.Q({\led1_color_reg[u9_grn_duty_n_0_][5] ,\led1_color_reg[u9_grn_duty_n_0_][3] ,\led1_color_reg[u9_grn_duty_n_0_][1] }),
        .clk_out1(clk_out1),
        .\po3_led1[blue] (\po3_led1[blue] ),
        .\po3_led1[green] (\po3_led1[green] ),
        .\po3_led1[red] (\po3_led1[red] ),
        .\po3_led2[blue] (\po3_led2[blue] ),
        .\po3_led2[green] (\po3_led2[green] ),
        .\po3_led2[red] (\po3_led2[red] ),
        .\po3_led3[blue] (\po3_led3[blue] ),
        .\po3_led3[green] (\po3_led3[green] ),
        .\po3_led3[red] (\po3_led3[red] ),
        .\po3_led3_reg[blue]_0 ({\led1_color_reg[u9_blu_duty_n_0_][6] ,\led1_color_reg[u9_blu_duty_n_0_][5] ,\led1_color_reg[u9_blu_duty_n_0_][4] ,\led1_color_reg[u9_blu_duty_n_0_][2] }),
        .\po3_led3_reg[red]_0 (\led1_color_reg[u9_red_duty_n_0_][6] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \dly_complete0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\dly_complete0_inferred__0/i__carry_n_0 ,\NLW_dly_complete0_inferred__0/i__carry_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_dly_complete0_inferred__0/i__carry_O_UNCONNECTED [3:0]),
        .S({i__carry_i_1_n_0,i__carry_i_2__0_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \dly_complete0_inferred__0/i__carry__0 
       (.CI(\dly_complete0_inferred__0/i__carry_n_0 ),
        .CO({p_1_in,\NLW_dly_complete0_inferred__0/i__carry__0_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_dly_complete0_inferred__0/i__carry__0_O_UNCONNECTED [3:0]),
        .S({i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0}));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT3 #(
    .INIT(8'h80)) 
    dly_complete_i_1
       (.I0(sel0[22]),
        .I1(p_1_in),
        .I2(v_u10_dly_cnt),
        .O(dly_complete_i_1_n_0));
  FDRE dly_complete_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(dly_complete_i_1_n_0),
        .Q(dly_complete),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_1
       (.I0(plusOp_0[21]),
        .O(i__carry__0_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry__0_i_2
       (.I0(plusOp_0[20]),
        .I1(plusOp_0[19]),
        .I2(plusOp_0[18]),
        .O(i__carry__0_i_2_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry__0_i_3
       (.I0(plusOp_0[17]),
        .I1(plusOp_0[16]),
        .I2(plusOp_0[15]),
        .O(i__carry__0_i_3_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry__0_i_4
       (.I0(plusOp_0[14]),
        .I1(plusOp_0[13]),
        .I2(plusOp_0[12]),
        .O(i__carry__0_i_4_n_0));
  CARRY4 i__carry__0_i_5
       (.CI(i__carry__0_i_6_n_0),
        .CO(NLW_i__carry__0_i_5_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_i__carry__0_i_5_O_UNCONNECTED[3:1],plusOp_0[21]}),
        .S({1'b0,1'b0,1'b0,v_u10_dly_cnt_reg[21]}));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 i__carry__0_i_6
       (.CI(i__carry__0_i_7_n_0),
        .CO({i__carry__0_i_6_n_0,NLW_i__carry__0_i_6_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(plusOp_0[20:17]),
        .S(v_u10_dly_cnt_reg[20:17]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 i__carry__0_i_7
       (.CI(i__carry_i_5_n_0),
        .CO({i__carry__0_i_7_n_0,NLW_i__carry__0_i_7_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(plusOp_0[16:13]),
        .S(v_u10_dly_cnt_reg[16:13]));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry_i_1
       (.I0(plusOp_0[11]),
        .I1(plusOp_0[10]),
        .I2(plusOp_0[9]),
        .O(i__carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry_i_2__0
       (.I0(plusOp_0[8]),
        .I1(plusOp_0[7]),
        .I2(plusOp_0[6]),
        .O(i__carry_i_2__0_n_0));
  LUT4 #(
    .INIT(16'h0801)) 
    i__carry_i_3
       (.I0(plusOp_0[5]),
        .I1(\u10_dly_cnt_reg_n_0_[5] ),
        .I2(plusOp_0[3]),
        .I3(plusOp_0[4]),
        .O(i__carry_i_3_n_0));
  LUT5 #(
    .INIT(32'h00414100)) 
    i__carry_i_4
       (.I0(plusOp_0[2]),
        .I1(plusOp_0[1]),
        .I2(\u10_dly_cnt_reg_n_0_[1] ),
        .I3(\u10_dly_cnt_reg_n_0_[0] ),
        .I4(v_u10_dly_cnt_reg[0]),
        .O(i__carry_i_4_n_0));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 i__carry_i_5
       (.CI(i__carry_i_6_n_0),
        .CO({i__carry_i_5_n_0,NLW_i__carry_i_5_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(plusOp_0[12:9]),
        .S(v_u10_dly_cnt_reg[12:9]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 i__carry_i_6
       (.CI(i__carry_i_7_n_0),
        .CO({i__carry_i_6_n_0,NLW_i__carry_i_6_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(plusOp_0[8:5]),
        .S(v_u10_dly_cnt_reg[8:5]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 i__carry_i_7
       (.CI(1'b0),
        .CO({i__carry_i_7_n_0,NLW_i__carry_i_7_CO_UNCONNECTED[2:0]}),
        .CYINIT(v_u10_dly_cnt_reg[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(plusOp_0[4:1]),
        .S(v_u10_dly_cnt_reg[4:1]));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \led1_color[u9_blu_duty][4]_i_1 
       (.I0(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[0] ),
        .I2(\FSM_onehot_st_main_states_reg_n_0_[1] ),
        .O(\led1_color[u9_blu_duty]1_in [4]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \led1_color[u9_blu_duty][6]_i_1 
       (.I0(\FSM_onehot_st_main_states_reg_n_0_[1] ),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[0] ),
        .I2(\FSM_onehot_st_main_states_reg_n_0_[4] ),
        .I3(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .I4(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .O(\led1_color[u9_blu_duty][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \led1_color[u9_blu_duty][6]_i_2 
       (.I0(\FSM_onehot_st_main_states_reg_n_0_[1] ),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[0] ),
        .O(\led1_color[u9_blu_duty]1_in [6]));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \led1_color[u9_grn_duty][3]_i_1 
       (.I0(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[1] ),
        .O(\led1_color[u9_grn_duty] ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \led1_color[u9_red_duty][6]_i_1 
       (.I0(\FSM_onehot_st_main_states_reg_n_0_[4] ),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .I2(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .O(\led1_color[u9_red_duty] ));
  FDRE \led1_color_reg[u9_blu_duty][2] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .Q(\led1_color_reg[u9_blu_duty_n_0_][2] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDSE \led1_color_reg[u9_blu_duty][4] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\led1_color[u9_blu_duty]1_in [4]),
        .Q(\led1_color_reg[u9_blu_duty_n_0_][4] ),
        .S(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDRE \led1_color_reg[u9_blu_duty][5] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\led1_color[u9_blu_duty]1_in [5]),
        .Q(\led1_color_reg[u9_blu_duty_n_0_][5] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDSE \led1_color_reg[u9_blu_duty][6] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\led1_color[u9_blu_duty]1_in [6]),
        .Q(\led1_color_reg[u9_blu_duty_n_0_][6] ),
        .S(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDRE \led1_color_reg[u9_grn_duty][1] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .Q(\led1_color_reg[u9_grn_duty_n_0_][1] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDRE \led1_color_reg[u9_grn_duty][3] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\led1_color[u9_grn_duty] ),
        .Q(\led1_color_reg[u9_grn_duty_n_0_][3] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDRE \led1_color_reg[u9_grn_duty][5] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\FSM_onehot_st_main_states_reg_n_0_[1] ),
        .Q(\led1_color_reg[u9_grn_duty_n_0_][5] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDRE \led1_color_reg[u9_red_duty][6] 
       (.C(clk_out1),
        .CE(\led1_color[u9_blu_duty][6]_i_1_n_0 ),
        .D(\led1_color[u9_red_duty] ),
        .Q(\led1_color_reg[u9_red_duty_n_0_][6] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry
       (.CI(1'b0),
        .CO({plusOp_carry_n_0,NLW_plusOp_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(sel0[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S(sel0[4:1]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry__0
       (.CI(plusOp_carry_n_0),
        .CO({plusOp_carry__0_n_0,NLW_plusOp_carry__0_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(sel0[8:5]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry__1
       (.CI(plusOp_carry__0_n_0),
        .CO({plusOp_carry__1_n_0,NLW_plusOp_carry__1_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(sel0[12:9]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry__2
       (.CI(plusOp_carry__1_n_0),
        .CO({plusOp_carry__2_n_0,NLW_plusOp_carry__2_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S(sel0[16:13]));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 plusOp_carry__3
       (.CI(plusOp_carry__2_n_0),
        .CO({plusOp_carry__3_n_0,NLW_plusOp_carry__3_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S(sel0[20:17]));
  CARRY4 plusOp_carry__4
       (.CI(plusOp_carry__3_n_0),
        .CO(NLW_plusOp_carry__4_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_plusOp_carry__4_O_UNCONNECTED[3:1],data0[21]}),
        .S({1'b0,1'b0,1'b0,sel0[21]}));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    po_bypass_relay_i_1
       (.I0(locked),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[1] ),
        .I2(\FSM_onehot_st_main_states_reg_n_0_[0] ),
        .I3(\FSM_onehot_st_main_states_reg_n_0_[4] ),
        .I4(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .I5(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .O(po_bypass_relay0_out));
  FDRE po_bypass_relay_reg
       (.C(clk_out1),
        .CE(po_bypass_relay0_out),
        .D(\FSM_onehot_st_main_states_reg_n_0_[4] ),
        .Q(po_bypass_relay),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h0F04)) 
    start_dly_i_1
       (.I0(zero_cross_event_reg_n_0),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .I2(dly_complete),
        .I3(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .O(start_dly));
  FDRE start_dly_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(start_dly),
        .Q(sel0[22]),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  data_control system_data_control
       (.D({system_data_control_n_17,system_data_control_n_18}),
        .E(system_data_control_n_16),
        .Q({\FSM_onehot_st_main_states_reg_n_0_[4] ,\FSM_onehot_st_main_states_reg_n_0_[3] ,\FSM_onehot_st_main_states_reg_n_0_[2] ,\FSM_onehot_st_main_states_reg_n_0_[1] ,\FSM_onehot_st_main_states_reg_n_0_[0] }),
        .SR(po_adb_cs),
        .\b_spi_rx_reg[0] (D),
        .\b_spi_rx_reg[0]_0 (\b_spi_rx_reg[0] ),
        .\b_spi_rx_reg[6] (system_data_control_n_19),
        .clk_out1(clk_out1),
        .dly_complete(dly_complete),
        .locked(locked),
        .lopt(lopt),
        .lopt_1(NLW_system_data_control_lopt_1_UNCONNECTED),
        .lopt_10(lopt_10),
        .lopt_11(NLW_system_data_control_lopt_11_UNCONNECTED),
        .lopt_2(lopt_2),
        .lopt_3(NLW_system_data_control_lopt_3_UNCONNECTED),
        .lopt_4(lopt_4),
        .lopt_5(NLW_system_data_control_lopt_5_UNCONNECTED),
        .lopt_6(lopt_6),
        .lopt_7(NLW_system_data_control_lopt_7_UNCONNECTED),
        .lopt_8(lopt_8),
        .lopt_9(NLW_system_data_control_lopt_9_UNCONNECTED),
        .pi_uart_rx(pi_uart_rx),
        .\po2_pfc_pwm[ac1] (\po2_pfc_pwm[ac1] ),
        .\po3_ada_muxsel_reg[2] (Q),
        .\po4_dhb_pwm[pri_high] (\po4_dhb_pwm[pri_high] ),
        .\po4_dhb_pwm[pri_low] (\po4_dhb_pwm[pri_low] ),
        .\po4_dhb_pwm[sec_high] (\po4_dhb_pwm[sec_high] ),
        .\po4_dhb_pwm[sec_low] (\po4_dhb_pwm[sec_low] ),
        .\po4_ht_pwm[pri_high] (\po4_ht_pwm[pri_high] ),
        .\po4_ht_pwm[pri_low] (\po4_ht_pwm[pri_low] ),
        .po_ada_clk_OBUF(po_ada_clk_OBUF),
        .po_adb_clk_OBUF(po_adb_clk_OBUF),
        .po_ext_ad1_clk_OBUF(po_ext_ad1_clk_OBUF),
        .po_ext_ad2_clk_OBUF(po_ext_ad2_clk_OBUF),
        .po_spi_cs_reg(po_ada_cs),
        .po_spi_cs_reg_0(po_ext_ad1_cs),
        .po_spi_cs_reg_1(po_ext_ad2_cs),
        .po_uart_tx(po_uart_tx),
        .zero_cross_event_reg(zero_cross_event_reg_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    \u10_dly_cnt[1]_i_1 
       (.I0(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .I1(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .O(\led1_color[u9_blu_duty]1_in [5]));
  FDRE \u10_dly_cnt_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_onehot_st_main_states_reg_n_0_[2] ),
        .Q(\u10_dly_cnt_reg_n_0_[0] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDRE \u10_dly_cnt_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\led1_color[u9_blu_duty]1_in [5]),
        .Q(\u10_dly_cnt_reg_n_0_[1] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  FDRE \u10_dly_cnt_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_onehot_st_main_states_reg_n_0_[3] ),
        .Q(\u10_dly_cnt_reg_n_0_[5] ),
        .R(\FSM_onehot_st_main_states[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFFFFFE)) 
    \u22_init_dly_cnt[0]_i_1 
       (.I0(\u22_init_dly_cnt[0]_i_2_n_0 ),
        .I1(\u22_init_dly_cnt[0]_i_3_n_0 ),
        .I2(\u22_init_dly_cnt[0]_i_4_n_0 ),
        .I3(\u22_init_dly_cnt[0]_i_5_n_0 ),
        .I4(\u22_init_dly_cnt[0]_i_6_n_0 ),
        .I5(sel0[0]),
        .O(u22_init_dly_cnt[0]));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    \u22_init_dly_cnt[0]_i_2 
       (.I0(sel0[1]),
        .I1(sel0[20]),
        .I2(sel0[21]),
        .I3(sel0[3]),
        .I4(sel0[2]),
        .O(\u22_init_dly_cnt[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \u22_init_dly_cnt[0]_i_3 
       (.I0(sel0[12]),
        .I1(sel0[13]),
        .I2(sel0[15]),
        .I3(sel0[14]),
        .O(\u22_init_dly_cnt[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \u22_init_dly_cnt[0]_i_4 
       (.I0(sel0[17]),
        .I1(sel0[16]),
        .I2(sel0[18]),
        .I3(sel0[19]),
        .O(\u22_init_dly_cnt[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \u22_init_dly_cnt[0]_i_5 
       (.I0(sel0[9]),
        .I1(sel0[8]),
        .I2(sel0[11]),
        .I3(sel0[10]),
        .O(\u22_init_dly_cnt[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \u22_init_dly_cnt[0]_i_6 
       (.I0(sel0[5]),
        .I1(sel0[4]),
        .I2(sel0[7]),
        .I3(sel0[6]),
        .O(\u22_init_dly_cnt[0]_i_6_n_0 ));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[10]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[10]),
        .O(u22_init_dly_cnt[10]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[11]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[11]),
        .O(u22_init_dly_cnt[11]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[12]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[12]),
        .O(u22_init_dly_cnt[12]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[13]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[13]),
        .O(u22_init_dly_cnt[13]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[14]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[14]),
        .O(u22_init_dly_cnt[14]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[15]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[15]),
        .O(u22_init_dly_cnt[15]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[16]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[16]),
        .O(u22_init_dly_cnt[16]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[17]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[17]),
        .O(u22_init_dly_cnt[17]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[18]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[18]),
        .O(u22_init_dly_cnt[18]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[19]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[19]),
        .O(u22_init_dly_cnt[19]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[1]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[1]),
        .O(u22_init_dly_cnt[1]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[20]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[20]),
        .O(u22_init_dly_cnt[20]));
  LUT1 #(
    .INIT(2'h1)) 
    \u22_init_dly_cnt[21]_i_1 
       (.I0(sel0[22]),
        .O(clear));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[21]_i_2 
       (.I0(v_u10_dly_cnt),
        .I1(data0[21]),
        .O(u22_init_dly_cnt[21]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \u22_init_dly_cnt[21]_i_3 
       (.I0(\u22_init_dly_cnt[0]_i_6_n_0 ),
        .I1(\u22_init_dly_cnt[0]_i_5_n_0 ),
        .I2(\u22_init_dly_cnt[0]_i_4_n_0 ),
        .I3(\u22_init_dly_cnt[0]_i_3_n_0 ),
        .I4(\u22_init_dly_cnt[0]_i_2_n_0 ),
        .I5(sel0[0]),
        .O(v_u10_dly_cnt));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[2]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[2]),
        .O(u22_init_dly_cnt[2]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[3]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[3]),
        .O(u22_init_dly_cnt[3]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[4]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[4]),
        .O(u22_init_dly_cnt[4]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[5]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[5]),
        .O(u22_init_dly_cnt[5]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[6]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[6]),
        .O(u22_init_dly_cnt[6]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[7]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[7]),
        .O(u22_init_dly_cnt[7]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[8]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[8]),
        .O(u22_init_dly_cnt[8]));
  (* OPT_MODIFIED = "RETARGET" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \u22_init_dly_cnt[9]_i_1 
       (.I0(v_u10_dly_cnt),
        .I1(data0[9]),
        .O(u22_init_dly_cnt[9]));
  FDRE \u22_init_dly_cnt_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[0]),
        .Q(sel0[0]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[10] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[10]),
        .Q(sel0[10]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[11] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[11]),
        .Q(sel0[11]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[12] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[12]),
        .Q(sel0[12]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[13] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[13]),
        .Q(sel0[13]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[14] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[14]),
        .Q(sel0[14]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[15] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[15]),
        .Q(sel0[15]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[16] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[16]),
        .Q(sel0[16]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[17] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[17]),
        .Q(sel0[17]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[18] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[18]),
        .Q(sel0[18]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[19] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[19]),
        .Q(sel0[19]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[1]),
        .Q(sel0[1]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[20] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[20]),
        .Q(sel0[20]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[21] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[21]),
        .Q(sel0[21]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[2]),
        .Q(sel0[2]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[3] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[3]),
        .Q(sel0[3]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[4] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[4]),
        .Q(sel0[4]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[5] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[5]),
        .Q(sel0[5]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[6] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[6]),
        .Q(sel0[6]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[7] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[7]),
        .Q(sel0[7]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[8] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[8]),
        .Q(sel0[8]),
        .R(clear));
  FDRE \u22_init_dly_cnt_reg[9] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(u22_init_dly_cnt[9]),
        .Q(sel0[9]),
        .R(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \v_u10_dly_cnt[0]_i_3 
       (.I0(v_u10_dly_cnt_reg[0]),
        .O(plusOp_0[0]));
  FDRE \v_u10_dly_cnt_reg[0] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[0]_i_2_n_7 ),
        .Q(v_u10_dly_cnt_reg[0]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \v_u10_dly_cnt_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\v_u10_dly_cnt_reg[0]_i_2_n_0 ,\NLW_v_u10_dly_cnt_reg[0]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\v_u10_dly_cnt_reg[0]_i_2_n_4 ,\v_u10_dly_cnt_reg[0]_i_2_n_5 ,\v_u10_dly_cnt_reg[0]_i_2_n_6 ,\v_u10_dly_cnt_reg[0]_i_2_n_7 }),
        .S({v_u10_dly_cnt_reg[3:1],plusOp_0[0]}));
  FDRE \v_u10_dly_cnt_reg[10] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[8]_i_1_n_5 ),
        .Q(v_u10_dly_cnt_reg[10]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[11] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[8]_i_1_n_4 ),
        .Q(v_u10_dly_cnt_reg[11]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[12] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[12]_i_1_n_7 ),
        .Q(v_u10_dly_cnt_reg[12]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \v_u10_dly_cnt_reg[12]_i_1 
       (.CI(\v_u10_dly_cnt_reg[8]_i_1_n_0 ),
        .CO({\v_u10_dly_cnt_reg[12]_i_1_n_0 ,\NLW_v_u10_dly_cnt_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\v_u10_dly_cnt_reg[12]_i_1_n_4 ,\v_u10_dly_cnt_reg[12]_i_1_n_5 ,\v_u10_dly_cnt_reg[12]_i_1_n_6 ,\v_u10_dly_cnt_reg[12]_i_1_n_7 }),
        .S(v_u10_dly_cnt_reg[15:12]));
  FDRE \v_u10_dly_cnt_reg[13] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[12]_i_1_n_6 ),
        .Q(v_u10_dly_cnt_reg[13]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[14] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[12]_i_1_n_5 ),
        .Q(v_u10_dly_cnt_reg[14]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[15] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[12]_i_1_n_4 ),
        .Q(v_u10_dly_cnt_reg[15]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[16] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[16]_i_1_n_7 ),
        .Q(v_u10_dly_cnt_reg[16]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \v_u10_dly_cnt_reg[16]_i_1 
       (.CI(\v_u10_dly_cnt_reg[12]_i_1_n_0 ),
        .CO({\v_u10_dly_cnt_reg[16]_i_1_n_0 ,\NLW_v_u10_dly_cnt_reg[16]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\v_u10_dly_cnt_reg[16]_i_1_n_4 ,\v_u10_dly_cnt_reg[16]_i_1_n_5 ,\v_u10_dly_cnt_reg[16]_i_1_n_6 ,\v_u10_dly_cnt_reg[16]_i_1_n_7 }),
        .S(v_u10_dly_cnt_reg[19:16]));
  FDRE \v_u10_dly_cnt_reg[17] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[16]_i_1_n_6 ),
        .Q(v_u10_dly_cnt_reg[17]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[18] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[16]_i_1_n_5 ),
        .Q(v_u10_dly_cnt_reg[18]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[19] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[16]_i_1_n_4 ),
        .Q(v_u10_dly_cnt_reg[19]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[1] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[0]_i_2_n_6 ),
        .Q(v_u10_dly_cnt_reg[1]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[20] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[20]_i_1_n_7 ),
        .Q(v_u10_dly_cnt_reg[20]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \v_u10_dly_cnt_reg[20]_i_1 
       (.CI(\v_u10_dly_cnt_reg[16]_i_1_n_0 ),
        .CO(\NLW_v_u10_dly_cnt_reg[20]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_v_u10_dly_cnt_reg[20]_i_1_O_UNCONNECTED [3:2],\v_u10_dly_cnt_reg[20]_i_1_n_6 ,\v_u10_dly_cnt_reg[20]_i_1_n_7 }),
        .S({1'b0,1'b0,v_u10_dly_cnt_reg[21:20]}));
  FDRE \v_u10_dly_cnt_reg[21] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[20]_i_1_n_6 ),
        .Q(v_u10_dly_cnt_reg[21]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[2] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[0]_i_2_n_5 ),
        .Q(v_u10_dly_cnt_reg[2]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[3] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[0]_i_2_n_4 ),
        .Q(v_u10_dly_cnt_reg[3]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[4] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[4]_i_1_n_7 ),
        .Q(v_u10_dly_cnt_reg[4]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \v_u10_dly_cnt_reg[4]_i_1 
       (.CI(\v_u10_dly_cnt_reg[0]_i_2_n_0 ),
        .CO({\v_u10_dly_cnt_reg[4]_i_1_n_0 ,\NLW_v_u10_dly_cnt_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\v_u10_dly_cnt_reg[4]_i_1_n_4 ,\v_u10_dly_cnt_reg[4]_i_1_n_5 ,\v_u10_dly_cnt_reg[4]_i_1_n_6 ,\v_u10_dly_cnt_reg[4]_i_1_n_7 }),
        .S(v_u10_dly_cnt_reg[7:4]));
  FDRE \v_u10_dly_cnt_reg[5] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[4]_i_1_n_6 ),
        .Q(v_u10_dly_cnt_reg[5]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[6] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[4]_i_1_n_5 ),
        .Q(v_u10_dly_cnt_reg[6]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[7] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[4]_i_1_n_4 ),
        .Q(v_u10_dly_cnt_reg[7]),
        .R(clear));
  FDRE \v_u10_dly_cnt_reg[8] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[8]_i_1_n_7 ),
        .Q(v_u10_dly_cnt_reg[8]),
        .R(clear));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \v_u10_dly_cnt_reg[8]_i_1 
       (.CI(\v_u10_dly_cnt_reg[4]_i_1_n_0 ),
        .CO({\v_u10_dly_cnt_reg[8]_i_1_n_0 ,\NLW_v_u10_dly_cnt_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\v_u10_dly_cnt_reg[8]_i_1_n_4 ,\v_u10_dly_cnt_reg[8]_i_1_n_5 ,\v_u10_dly_cnt_reg[8]_i_1_n_6 ,\v_u10_dly_cnt_reg[8]_i_1_n_7 }),
        .S(v_u10_dly_cnt_reg[11:8]));
  FDRE \v_u10_dly_cnt_reg[9] 
       (.C(clk_out1),
        .CE(v_u10_dly_cnt),
        .D(\v_u10_dly_cnt_reg[8]_i_1_n_6 ),
        .Q(v_u10_dly_cnt_reg[9]),
        .R(clear));
  FDRE zero_cross_event_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(system_data_control_n_19),
        .Q(zero_cross_event_reg_n_0),
        .R(1'b0));
endmodule

(* ECO_CHECKSUM = "f22c1ac" *) 
(* NotValidForBitStream *)
module top
   (xclk32mhz,
    po_bypass_relay,
    \po2_pfc_pwm[ac1] ,
    \po2_pfc_pwm[ac2] ,
    \po4_ht_pwm[pri_high] ,
    \po4_ht_pwm[pri_low] ,
    \po4_ht_pwm[sync1] ,
    \po4_ht_pwm[sync2] ,
    \po4_dhb_pwm[pri_high] ,
    \po4_dhb_pwm[pri_low] ,
    \po4_dhb_pwm[sec_high] ,
    \po4_dhb_pwm[sec_low] ,
    pi_uart_rx,
    po_uart_tx,
    po_ada_cs,
    po_ada_clk,
    pi_ada_sdata,
    po3_ada_muxsel,
    po_adb_cs,
    po_adb_clk,
    pi_adb_sdata,
    po3_adb_muxsel,
    po_ext_ad1_cs,
    po_ext_ad1_clk,
    pi_ext_ad1_sdata,
    po_ext_ad2_cs,
    po_ext_ad2_clk,
    pi_ext_ad2_sdata,
    \po3_led1[red] ,
    \po3_led1[green] ,
    \po3_led1[blue] ,
    \po3_led2[red] ,
    \po3_led2[green] ,
    \po3_led2[blue] ,
    \po3_led3[red] ,
    \po3_led3[green] ,
    \po3_led3[blue] );
  input xclk32mhz;
  output po_bypass_relay;
  output \po2_pfc_pwm[ac1] ;
  output \po2_pfc_pwm[ac2] ;
  output \po4_ht_pwm[pri_high] ;
  output \po4_ht_pwm[pri_low] ;
  output \po4_ht_pwm[sync1] ;
  output \po4_ht_pwm[sync2] ;
  output \po4_dhb_pwm[pri_high] ;
  output \po4_dhb_pwm[pri_low] ;
  output \po4_dhb_pwm[sec_high] ;
  output \po4_dhb_pwm[sec_low] ;
  input pi_uart_rx;
  output po_uart_tx;
  output po_ada_cs;
  output po_ada_clk;
  input pi_ada_sdata;
  output [2:0]po3_ada_muxsel;
  output po_adb_cs;
  output po_adb_clk;
  input pi_adb_sdata;
  output [2:0]po3_adb_muxsel;
  output po_ext_ad1_cs;
  output po_ext_ad1_clk;
  input pi_ext_ad1_sdata;
  output po_ext_ad2_cs;
  output po_ext_ad2_clk;
  input pi_ext_ad2_sdata;
  output \po3_led1[red] ;
  output \po3_led1[green] ;
  output \po3_led1[blue] ;
  output \po3_led2[red] ;
  output \po3_led2[green] ;
  output \po3_led2[blue] ;
  output \po3_led3[red] ;
  output \po3_led3[green] ;
  output \po3_led3[blue] ;

  wire clk_256mhz;
  wire lopt;
  wire lopt_10;
  wire lopt_2;
  wire lopt_4;
  wire lopt_6;
  wire lopt_8;
  wire main_system_control_n_0;
  wire main_system_control_n_1;
  wire main_system_control_n_17;
  wire main_system_control_n_18;
  wire main_system_control_n_19;
  wire main_system_control_n_2;
  wire main_system_control_n_20;
  wire main_system_control_n_21;
  wire main_system_control_n_22;
  wire main_system_control_n_23;
  wire main_system_control_n_3;
  wire main_system_control_n_4;
  wire main_system_control_n_5;
  wire main_system_control_n_6;
  wire main_system_control_n_7;
  wire main_system_control_n_8;
  wire pi_ada_sdata;
  wire pi_ada_sdata_IBUF;
  wire pi_adb_sdata;
  wire pi_adb_sdata_IBUF;
  wire pi_uart_rx;
  wire pi_uart_rx_IBUF;
  wire \po2_pfc_pwm[ac1] ;
  wire \po2_pfc_pwm[ac2] ;
  wire [2:0]po3_ada_muxsel;
  wire [2:0]po3_adb_muxsel;
  wire [2:0]po3_adb_muxsel_OBUF;
  wire \po3_led1[blue] ;
  wire \po3_led1[green] ;
  wire \po3_led1[red] ;
  wire \po3_led2[blue] ;
  wire \po3_led2[green] ;
  wire \po3_led2[red] ;
  wire \po3_led3[blue] ;
  wire \po3_led3[green] ;
  wire \po3_led3[red] ;
  wire \po4_dhb_pwm[pri_high] ;
  wire \po4_dhb_pwm[pri_low] ;
  wire \po4_dhb_pwm[sec_high] ;
  wire \po4_dhb_pwm[sec_low] ;
  wire \po4_ht_pwm[pri_high] ;
  wire \po4_ht_pwm[pri_low] ;
  wire \po4_ht_pwm[sync1] ;
  wire \po4_ht_pwm[sync2] ;
  wire po_ada_clk;
  wire po_ada_clk_OBUF;
  wire po_ada_cs;
  wire po_ada_cs_OBUF;
  wire po_adb_clk;
  wire po_adb_clk_OBUF;
  wire po_adb_cs;
  wire po_adb_cs_OBUF;
  wire po_bypass_relay;
  wire po_bypass_relay_OBUF;
  wire po_ext_ad1_clk;
  wire po_ext_ad1_clk_OBUF;
  wire po_ext_ad1_cs;
  wire po_ext_ad1_cs_OBUF;
  wire po_ext_ad2_clk;
  wire po_ext_ad2_clk_OBUF;
  wire po_ext_ad2_cs;
  wire po_ext_ad2_cs_OBUF;
  wire po_uart_tx;
  wire po_uart_tx_OBUF;
  wire std_pll_lock;
  (* IBUF_LOW_PWR *) wire xclk32mhz;
  wire NLW_main_system_control_lopt_1_UNCONNECTED;
  wire NLW_main_system_control_lopt_11_UNCONNECTED;
  wire NLW_main_system_control_lopt_3_UNCONNECTED;
  wire NLW_main_system_control_lopt_5_UNCONNECTED;
  wire NLW_main_system_control_lopt_7_UNCONNECTED;
  wire NLW_main_system_control_lopt_9_UNCONNECTED;

initial begin
 $sdf_annotate("cpu_impl_netlist.sdf",,,,"tool_control");
end
  pll_256mhz core_clocks
       (.clk_in1(xclk32mhz),
        .clk_out1(clk_256mhz),
        .locked(std_pll_lock));
  system_control main_system_control
       (.D(pi_ada_sdata_IBUF),
        .Q(po3_adb_muxsel_OBUF),
        .\b_spi_rx_reg[0] (pi_adb_sdata_IBUF),
        .clk_out1(clk_256mhz),
        .locked(std_pll_lock),
        .lopt(lopt),
        .lopt_1(NLW_main_system_control_lopt_1_UNCONNECTED),
        .lopt_10(lopt_10),
        .lopt_11(NLW_main_system_control_lopt_11_UNCONNECTED),
        .lopt_2(lopt_2),
        .lopt_3(NLW_main_system_control_lopt_3_UNCONNECTED),
        .lopt_4(lopt_4),
        .lopt_5(NLW_main_system_control_lopt_5_UNCONNECTED),
        .lopt_6(lopt_6),
        .lopt_7(NLW_main_system_control_lopt_7_UNCONNECTED),
        .lopt_8(lopt_8),
        .lopt_9(NLW_main_system_control_lopt_9_UNCONNECTED),
        .pi_uart_rx(pi_uart_rx_IBUF),
        .\po2_pfc_pwm[ac1] (main_system_control_n_23),
        .\po3_led1[blue] (main_system_control_n_2),
        .\po3_led1[green] (main_system_control_n_1),
        .\po3_led1[red] (main_system_control_n_0),
        .\po3_led2[blue] (main_system_control_n_5),
        .\po3_led2[green] (main_system_control_n_4),
        .\po3_led2[red] (main_system_control_n_3),
        .\po3_led3[blue] (main_system_control_n_8),
        .\po3_led3[green] (main_system_control_n_7),
        .\po3_led3[red] (main_system_control_n_6),
        .\po4_dhb_pwm[pri_high] (main_system_control_n_17),
        .\po4_dhb_pwm[pri_low] (main_system_control_n_18),
        .\po4_dhb_pwm[sec_high] (main_system_control_n_19),
        .\po4_dhb_pwm[sec_low] (main_system_control_n_20),
        .\po4_ht_pwm[pri_high] (main_system_control_n_21),
        .\po4_ht_pwm[pri_low] (main_system_control_n_22),
        .po_ada_clk_OBUF(po_ada_clk_OBUF),
        .po_ada_cs(po_ada_cs_OBUF),
        .po_adb_clk_OBUF(po_adb_clk_OBUF),
        .po_adb_cs(po_adb_cs_OBUF),
        .po_bypass_relay(po_bypass_relay_OBUF),
        .po_ext_ad1_clk_OBUF(po_ext_ad1_clk_OBUF),
        .po_ext_ad1_cs(po_ext_ad1_cs_OBUF),
        .po_ext_ad2_clk_OBUF(po_ext_ad2_clk_OBUF),
        .po_ext_ad2_cs(po_ext_ad2_cs_OBUF),
        .po_uart_tx(po_uart_tx_OBUF));
  IBUF pi_ada_sdata_IBUF_inst
       (.I(pi_ada_sdata),
        .O(pi_ada_sdata_IBUF));
  IBUF pi_adb_sdata_IBUF_inst
       (.I(pi_adb_sdata),
        .O(pi_adb_sdata_IBUF));
  IBUF pi_uart_rx_IBUF_inst
       (.I(pi_uart_rx),
        .O(pi_uart_rx_IBUF));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po2_pfc_pwm[ac1]_INST_0 
       (.I(lopt),
        .O(\po2_pfc_pwm[ac1] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po2_pfc_pwm[ac2]_INST_0 
       (.I(main_system_control_n_23),
        .O(\po2_pfc_pwm[ac2] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po3_ada_muxsel_OBUF[0]_inst 
       (.I(lopt_2),
        .O(po3_ada_muxsel[0]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po3_ada_muxsel_OBUF[1]_inst 
       (.I(lopt_4),
        .O(po3_ada_muxsel[1]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po3_ada_muxsel_OBUF[2]_inst 
       (.I(lopt_6),
        .O(po3_ada_muxsel[2]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po3_adb_muxsel_OBUF[0]_inst 
       (.I(po3_adb_muxsel_OBUF[0]),
        .O(po3_adb_muxsel[0]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po3_adb_muxsel_OBUF[1]_inst 
       (.I(po3_adb_muxsel_OBUF[1]),
        .O(po3_adb_muxsel[1]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po3_adb_muxsel_OBUF[2]_inst 
       (.I(po3_adb_muxsel_OBUF[2]),
        .O(po3_adb_muxsel[2]));
  OBUF \po3_led1[blue]_INST_0 
       (.I(main_system_control_n_2),
        .O(\po3_led1[blue] ));
  OBUF \po3_led1[green]_INST_0 
       (.I(main_system_control_n_1),
        .O(\po3_led1[green] ));
  OBUF \po3_led1[red]_INST_0 
       (.I(main_system_control_n_0),
        .O(\po3_led1[red] ));
  OBUF \po3_led2[blue]_INST_0 
       (.I(main_system_control_n_5),
        .O(\po3_led2[blue] ));
  OBUF \po3_led2[green]_INST_0 
       (.I(main_system_control_n_4),
        .O(\po3_led2[green] ));
  OBUF \po3_led2[red]_INST_0 
       (.I(main_system_control_n_3),
        .O(\po3_led2[red] ));
  OBUF \po3_led3[blue]_INST_0 
       (.I(main_system_control_n_8),
        .O(\po3_led3[blue] ));
  OBUF \po3_led3[green]_INST_0 
       (.I(main_system_control_n_7),
        .O(\po3_led3[green] ));
  OBUF \po3_led3[red]_INST_0 
       (.I(main_system_control_n_6),
        .O(\po3_led3[red] ));
  OBUF \po4_dhb_pwm[pri_high]_INST_0 
       (.I(main_system_control_n_17),
        .O(\po4_dhb_pwm[pri_high] ));
  OBUF \po4_dhb_pwm[pri_low]_INST_0 
       (.I(main_system_control_n_18),
        .O(\po4_dhb_pwm[pri_low] ));
  OBUF \po4_dhb_pwm[sec_high]_INST_0 
       (.I(main_system_control_n_19),
        .O(\po4_dhb_pwm[sec_high] ));
  OBUF \po4_dhb_pwm[sec_low]_INST_0 
       (.I(main_system_control_n_20),
        .O(\po4_dhb_pwm[sec_low] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po4_ht_pwm[pri_high]_INST_0 
       (.I(lopt_8),
        .O(\po4_ht_pwm[pri_high] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po4_ht_pwm[pri_low]_INST_0 
       (.I(lopt_10),
        .O(\po4_ht_pwm[pri_low] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po4_ht_pwm[sync1]_INST_0 
       (.I(main_system_control_n_21),
        .O(\po4_ht_pwm[sync1] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF \po4_ht_pwm[sync2]_INST_0 
       (.I(main_system_control_n_22),
        .O(\po4_ht_pwm[sync2] ));
  OBUF po_ada_clk_OBUF_inst
       (.I(po_ada_clk_OBUF),
        .O(po_ada_clk));
  OBUF po_ada_cs_OBUF_inst
       (.I(po_ada_cs_OBUF),
        .O(po_ada_cs));
  OBUF po_adb_clk_OBUF_inst
       (.I(po_adb_clk_OBUF),
        .O(po_adb_clk));
  OBUF po_adb_cs_OBUF_inst
       (.I(po_adb_cs_OBUF),
        .O(po_adb_cs));
  OBUF po_bypass_relay_OBUF_inst
       (.I(po_bypass_relay_OBUF),
        .O(po_bypass_relay));
  OBUF po_ext_ad1_clk_OBUF_inst
       (.I(po_ext_ad1_clk_OBUF),
        .O(po_ext_ad1_clk));
  OBUF po_ext_ad1_cs_OBUF_inst
       (.I(po_ext_ad1_cs_OBUF),
        .O(po_ext_ad1_cs));
  OBUF po_ext_ad2_clk_OBUF_inst
       (.I(po_ext_ad2_clk_OBUF),
        .O(po_ext_ad2_clk));
  OBUF po_ext_ad2_cs_OBUF_inst
       (.I(po_ext_ad2_cs_OBUF),
        .O(po_ext_ad2_cs));
  OBUF po_uart_tx_OBUF_inst
       (.I(po_uart_tx_OBUF),
        .O(po_uart_tx));
endmodule

module uart
   (po_uart_tx,
    j_reg_0,
    r_RX_busy_reg,
    route_uart_tx_active,
    route_receive_ready_event_reg_0,
    \FSM_sequential_r_next_state_reg[1] ,
    \FSM_onehot_rx_next_state_reg[0]_0 ,
    \FSM_onehot_rx_next_state_reg[1]_0 ,
    \route_RX_data_out_reg[0]_0 ,
    \route_RX_data_out_reg[15]_0 ,
    \route_RX_data_out_reg[0]_1 ,
    \route_RX_data_out_reg[2]_0 ,
    \route_RX_data_out_reg[1]_0 ,
    \route_RX_data_out_reg[0]_2 ,
    \route_RX_data_out_reg[13]_0 ,
    \route_RX_data_out_reg[12]_0 ,
    pi_uart_rx,
    clk_out1,
    Q,
    \jihuu_reg[rstn] ,
    rstn,
    \jeemux_reg[2] ,
    \jeemux_reg[1] ,
    \jeemux_reg[0] ,
    E,
    route_tx_in_progress_reg_0,
    \route_uart_tx_data_reg[7]_0 );
  output po_uart_tx;
  output j_reg_0;
  output r_RX_busy_reg;
  output route_uart_tx_active;
  output route_receive_ready_event_reg_0;
  output \FSM_sequential_r_next_state_reg[1] ;
  output \FSM_onehot_rx_next_state_reg[0]_0 ;
  output \FSM_onehot_rx_next_state_reg[1]_0 ;
  output \route_RX_data_out_reg[0]_0 ;
  output [15:0]\route_RX_data_out_reg[15]_0 ;
  output \route_RX_data_out_reg[0]_1 ;
  output \route_RX_data_out_reg[2]_0 ;
  output \route_RX_data_out_reg[1]_0 ;
  output \route_RX_data_out_reg[0]_2 ;
  output [0:0]\route_RX_data_out_reg[13]_0 ;
  output [0:0]\route_RX_data_out_reg[12]_0 ;
  input pi_uart_rx;
  input clk_out1;
  input [1:0]Q;
  input \jihuu_reg[rstn] ;
  input rstn;
  input \jeemux_reg[2] ;
  input \jeemux_reg[1] ;
  input \jeemux_reg[0] ;
  input [1:0]E;
  input route_tx_in_progress_reg_0;
  input [15:0]\route_uart_tx_data_reg[7]_0 ;

  wire \/i__n_0 ;
  wire [1:0]E;
  wire \FSM_onehot_next_state[1]_i_1_n_0 ;
  wire \FSM_onehot_next_state[3]_i_1_n_0 ;
  wire \FSM_onehot_next_state_reg_n_0_[2] ;
  wire \FSM_onehot_rx_next_state_reg[0]_0 ;
  wire \FSM_onehot_rx_next_state_reg[1]_0 ;
  wire \FSM_sequential_r_next_state_reg[1] ;
  wire [1:0]Q;
  wire clk_out1;
  wire i_i_1_n_0;
  wire i_reg_n_0;
  wire j_reg_0;
  wire jeemux;
  wire \jeemux[2]_i_3_n_0 ;
  wire \jeemux_reg[0] ;
  wire \jeemux_reg[1] ;
  wire \jeemux_reg[2] ;
  wire \jihuu[rstn]_i_2_n_0 ;
  wire \jihuu[rstn]_i_3_n_0 ;
  wire \jihuu[rstn]_i_4_n_0 ;
  wire \jihuu_reg[rstn] ;
  wire pi_uart_rx;
  wire po_uart_tx;
  wire [7:0]r_RX_Byte;
  wire r_RX_busy_reg;
  wire r_si_rstn_i_2_n_0;
  wire route_RX_data_out;
  wire \route_RX_data_out_reg[0]_0 ;
  wire \route_RX_data_out_reg[0]_1 ;
  wire \route_RX_data_out_reg[0]_2 ;
  wire [0:0]\route_RX_data_out_reg[12]_0 ;
  wire [0:0]\route_RX_data_out_reg[13]_0 ;
  wire [15:0]\route_RX_data_out_reg[15]_0 ;
  wire \route_RX_data_out_reg[1]_0 ;
  wire \route_RX_data_out_reg[2]_0 ;
  wire route_receive_ready_event_i_1_n_0;
  wire route_receive_ready_event_reg_0;
  wire route_tx_in_progress;
  wire route_tx_in_progress0;
  wire route_tx_in_progress_i_1_n_0;
  wire route_tx_in_progress_reg_0;
  wire route_uart_tx_active;
  wire [7:0]route_uart_tx_data;
  wire \route_uart_tx_data[0]_i_1_n_0 ;
  wire \route_uart_tx_data[1]_i_1_n_0 ;
  wire \route_uart_tx_data[2]_i_1_n_0 ;
  wire \route_uart_tx_data[3]_i_1_n_0 ;
  wire \route_uart_tx_data[4]_i_1_n_0 ;
  wire \route_uart_tx_data[5]_i_1_n_0 ;
  wire \route_uart_tx_data[6]_i_1_n_0 ;
  wire \route_uart_tx_data[7]_i_1_n_0 ;
  wire route_uart_tx_data_0;
  wire [15:0]\route_uart_tx_data_reg[7]_0 ;
  wire route_uart_tx_done;
  wire rstn;
  wire [15:0]testidata;
  wire tx_start_reg_n_0;
  wire uartrx_n_1;
  wire uartrx_n_2;
  wire uartrx_n_3;
  wire uarttx_n_2;

  LUT6 #(
    .INIT(64'hFFFFFEEEFEEEFEEE)) 
    \/i_ 
       (.I0(route_uart_tx_data_0),
        .I1(route_tx_in_progress0),
        .I2(route_tx_in_progress),
        .I3(route_tx_in_progress_reg_0),
        .I4(\FSM_onehot_next_state_reg_n_0_[2] ),
        .I5(route_uart_tx_done),
        .O(\/i__n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    \FSM_onehot_next_state[1]_i_1 
       (.I0(route_tx_in_progress),
        .I1(i_reg_n_0),
        .I2(\FSM_onehot_next_state_reg_n_0_[2] ),
        .O(\FSM_onehot_next_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_onehot_next_state[3]_i_1 
       (.I0(\FSM_onehot_next_state_reg_n_0_[2] ),
        .I1(i_reg_n_0),
        .O(\FSM_onehot_next_state[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "idle:0001,wait_active:0100,reset_tx:1000,latch_word:0010" *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_next_state_reg[0] 
       (.C(clk_out1),
        .CE(\/i__n_0 ),
        .D(route_tx_in_progress0),
        .Q(route_tx_in_progress),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:0001,wait_active:0100,reset_tx:1000,latch_word:0010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_next_state_reg[1] 
       (.C(clk_out1),
        .CE(\/i__n_0 ),
        .D(\FSM_onehot_next_state[1]_i_1_n_0 ),
        .Q(route_uart_tx_data_0),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:0001,wait_active:0100,reset_tx:1000,latch_word:0010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_next_state_reg[2] 
       (.C(clk_out1),
        .CE(\/i__n_0 ),
        .D(route_uart_tx_data_0),
        .Q(\FSM_onehot_next_state_reg_n_0_[2] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:0001,wait_active:0100,reset_tx:1000,latch_word:0010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_next_state_reg[3] 
       (.C(clk_out1),
        .CE(\/i__n_0 ),
        .D(\FSM_onehot_next_state[3]_i_1_n_0 ),
        .Q(route_tx_in_progress0),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:001,wait_active:010,latch:100," *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_rx_next_state_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(route_RX_data_out),
        .Q(\FSM_onehot_rx_next_state_reg[0]_0 ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:001,wait_active:010,latch:100," *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rx_next_state_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(uartrx_n_3),
        .Q(\FSM_onehot_rx_next_state_reg[1]_0 ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:001,wait_active:010,latch:100," *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rx_next_state_reg[2] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(uartrx_n_2),
        .Q(route_RX_data_out),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h1C)) 
    i_i_1
       (.I0(route_tx_in_progress),
        .I1(route_uart_tx_data_0),
        .I2(i_reg_n_0),
        .O(i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(i_i_1_n_0),
        .Q(i_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    j_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(uartrx_n_1),
        .Q(j_reg_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \jeemux[0]_i_1 
       (.I0(\route_RX_data_out_reg[15]_0 [0]),
        .I1(jeemux),
        .I2(\jeemux_reg[0] ),
        .O(\route_RX_data_out_reg[0]_2 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \jeemux[1]_i_1 
       (.I0(\route_RX_data_out_reg[15]_0 [1]),
        .I1(jeemux),
        .I2(\jeemux_reg[1] ),
        .O(\route_RX_data_out_reg[1]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \jeemux[2]_i_1 
       (.I0(\route_RX_data_out_reg[15]_0 [2]),
        .I1(jeemux),
        .I2(\jeemux_reg[2] ),
        .O(\route_RX_data_out_reg[2]_0 ));
  LUT6 #(
    .INIT(64'h0888888800000000)) 
    \jeemux[2]_i_2 
       (.I0(\jihuu[rstn]_i_2_n_0 ),
        .I1(\jeemux[2]_i_3_n_0 ),
        .I2(\route_RX_data_out_reg[15]_0 [0]),
        .I3(\route_RX_data_out_reg[15]_0 [1]),
        .I4(\route_RX_data_out_reg[15]_0 [2]),
        .I5(\jihuu[rstn]_i_4_n_0 ),
        .O(jeemux));
  LUT4 #(
    .INIT(16'h0001)) 
    \jeemux[2]_i_3 
       (.I0(\route_RX_data_out_reg[15]_0 [4]),
        .I1(\route_RX_data_out_reg[15]_0 [3]),
        .I2(\route_RX_data_out_reg[15]_0 [6]),
        .I3(\route_RX_data_out_reg[15]_0 [5]),
        .O(\jeemux[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF4000)) 
    \jihuu[rstn]_i_1 
       (.I0(\route_RX_data_out_reg[15]_0 [0]),
        .I1(\jihuu[rstn]_i_2_n_0 ),
        .I2(\jihuu[rstn]_i_3_n_0 ),
        .I3(\jihuu[rstn]_i_4_n_0 ),
        .I4(\jihuu_reg[rstn] ),
        .O(\route_RX_data_out_reg[0]_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \jihuu[rstn]_i_2 
       (.I0(route_receive_ready_event_reg_0),
        .I1(\route_RX_data_out_reg[15]_0 [14]),
        .I2(\route_RX_data_out_reg[15]_0 [15]),
        .I3(\route_RX_data_out_reg[15]_0 [12]),
        .O(\jihuu[rstn]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \jihuu[rstn]_i_3 
       (.I0(\route_RX_data_out_reg[15]_0 [5]),
        .I1(\route_RX_data_out_reg[15]_0 [6]),
        .I2(\route_RX_data_out_reg[15]_0 [3]),
        .I3(\route_RX_data_out_reg[15]_0 [4]),
        .I4(\route_RX_data_out_reg[15]_0 [2]),
        .I5(\route_RX_data_out_reg[15]_0 [1]),
        .O(\jihuu[rstn]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \jihuu[rstn]_i_4 
       (.I0(\route_RX_data_out_reg[15]_0 [9]),
        .I1(\route_RX_data_out_reg[15]_0 [10]),
        .I2(\route_RX_data_out_reg[15]_0 [7]),
        .I3(\route_RX_data_out_reg[15]_0 [8]),
        .I4(\route_RX_data_out_reg[15]_0 [13]),
        .I5(\route_RX_data_out_reg[15]_0 [11]),
        .O(\jihuu[rstn]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000080)) 
    \jihuu[s16_phase][11]_i_1 
       (.I0(\route_RX_data_out_reg[15]_0 [13]),
        .I1(\route_RX_data_out_reg[15]_0 [12]),
        .I2(route_receive_ready_event_reg_0),
        .I3(\route_RX_data_out_reg[15]_0 [14]),
        .I4(\route_RX_data_out_reg[15]_0 [15]),
        .O(\route_RX_data_out_reg[13]_0 ));
  LUT5 #(
    .INIT(32'h01000000)) 
    \r_piu12_per_ctrl[11]_i_1 
       (.I0(\route_RX_data_out_reg[15]_0 [12]),
        .I1(\route_RX_data_out_reg[15]_0 [15]),
        .I2(\route_RX_data_out_reg[15]_0 [14]),
        .I3(route_receive_ready_event_reg_0),
        .I4(\route_RX_data_out_reg[15]_0 [13]),
        .O(\route_RX_data_out_reg[12]_0 ));
  LUT5 #(
    .INIT(32'h7FFF4000)) 
    r_si_rstn_i_1__0
       (.I0(\route_RX_data_out_reg[15]_0 [0]),
        .I1(\jihuu[rstn]_i_2_n_0 ),
        .I2(\jihuu[rstn]_i_4_n_0 ),
        .I3(r_si_rstn_i_2_n_0),
        .I4(rstn),
        .O(\route_RX_data_out_reg[0]_1 ));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    r_si_rstn_i_2
       (.I0(\route_RX_data_out_reg[15]_0 [4]),
        .I1(\route_RX_data_out_reg[15]_0 [3]),
        .I2(\route_RX_data_out_reg[15]_0 [2]),
        .I3(\route_RX_data_out_reg[15]_0 [1]),
        .I4(\route_RX_data_out_reg[15]_0 [6]),
        .I5(\route_RX_data_out_reg[15]_0 [5]),
        .O(r_si_rstn_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[0] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[0]),
        .Q(\route_RX_data_out_reg[15]_0 [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \route_RX_data_out_reg[10] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[10]),
        .Q(\route_RX_data_out_reg[15]_0 [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[11] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[11]),
        .Q(\route_RX_data_out_reg[15]_0 [11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[12] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[12]),
        .Q(\route_RX_data_out_reg[15]_0 [12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[13] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[13]),
        .Q(\route_RX_data_out_reg[15]_0 [13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[14] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[14]),
        .Q(\route_RX_data_out_reg[15]_0 [14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[15] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[15]),
        .Q(\route_RX_data_out_reg[15]_0 [15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \route_RX_data_out_reg[1] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[1]),
        .Q(\route_RX_data_out_reg[15]_0 [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \route_RX_data_out_reg[2] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[2]),
        .Q(\route_RX_data_out_reg[15]_0 [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[3] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[3]),
        .Q(\route_RX_data_out_reg[15]_0 [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[4] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[4]),
        .Q(\route_RX_data_out_reg[15]_0 [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[5] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[5]),
        .Q(\route_RX_data_out_reg[15]_0 [5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[6] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[6]),
        .Q(\route_RX_data_out_reg[15]_0 [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[7] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[7]),
        .Q(\route_RX_data_out_reg[15]_0 [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \route_RX_data_out_reg[8] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[8]),
        .Q(\route_RX_data_out_reg[15]_0 [8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \route_RX_data_out_reg[9] 
       (.C(clk_out1),
        .CE(route_RX_data_out),
        .D(testidata[9]),
        .Q(\route_RX_data_out_reg[15]_0 [9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hDC)) 
    route_receive_ready_event_i_1
       (.I0(\FSM_onehot_rx_next_state_reg[0]_0 ),
        .I1(route_RX_data_out),
        .I2(route_receive_ready_event_reg_0),
        .O(route_receive_ready_event_i_1_n_0));
  FDRE route_receive_ready_event_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(route_receive_ready_event_i_1_n_0),
        .Q(route_receive_ready_event_reg_0),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h00E2)) 
    route_tx_in_progress_i_1
       (.I0(route_uart_tx_active),
        .I1(route_tx_in_progress),
        .I2(route_tx_in_progress_reg_0),
        .I3(route_tx_in_progress0),
        .O(route_tx_in_progress_i_1_n_0));
  FDRE route_tx_in_progress_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(route_tx_in_progress_i_1_n_0),
        .Q(route_uart_tx_active),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[0]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [8]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [0]),
        .O(\route_uart_tx_data[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[1]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [9]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [1]),
        .O(\route_uart_tx_data[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[2]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [10]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [2]),
        .O(\route_uart_tx_data[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[3]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [11]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [3]),
        .O(\route_uart_tx_data[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[4]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [12]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [4]),
        .O(\route_uart_tx_data[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[5]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [13]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [5]),
        .O(\route_uart_tx_data[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[6]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [14]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [6]),
        .O(\route_uart_tx_data[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \route_uart_tx_data[7]_i_1 
       (.I0(\route_uart_tx_data_reg[7]_0 [15]),
        .I1(i_reg_n_0),
        .I2(\route_uart_tx_data_reg[7]_0 [7]),
        .O(\route_uart_tx_data[7]_i_1_n_0 ));
  FDRE \route_uart_tx_data_reg[0] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[0]_i_1_n_0 ),
        .Q(route_uart_tx_data[0]),
        .R(1'b0));
  FDRE \route_uart_tx_data_reg[1] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[1]_i_1_n_0 ),
        .Q(route_uart_tx_data[1]),
        .R(1'b0));
  FDRE \route_uart_tx_data_reg[2] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[2]_i_1_n_0 ),
        .Q(route_uart_tx_data[2]),
        .R(1'b0));
  FDRE \route_uart_tx_data_reg[3] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[3]_i_1_n_0 ),
        .Q(route_uart_tx_data[3]),
        .R(1'b0));
  FDRE \route_uart_tx_data_reg[4] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[4]_i_1_n_0 ),
        .Q(route_uart_tx_data[4]),
        .R(1'b0));
  FDRE \route_uart_tx_data_reg[5] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[5]_i_1_n_0 ),
        .Q(route_uart_tx_data[5]),
        .R(1'b0));
  FDRE \route_uart_tx_data_reg[6] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[6]_i_1_n_0 ),
        .Q(route_uart_tx_data[6]),
        .R(1'b0));
  FDRE \route_uart_tx_data_reg[7] 
       (.C(clk_out1),
        .CE(route_uart_tx_data_0),
        .D(\route_uart_tx_data[7]_i_1_n_0 ),
        .Q(route_uart_tx_data[7]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h06)) 
    route_uart_tx_start_i_1
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(route_uart_tx_active),
        .O(\FSM_sequential_r_next_state_reg[1] ));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[0] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[0]),
        .Q(testidata[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \testidata_reg[10] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[2]),
        .Q(testidata[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[11] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[3]),
        .Q(testidata[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[12] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[4]),
        .Q(testidata[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[13] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[5]),
        .Q(testidata[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[14] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[6]),
        .Q(testidata[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[15] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[7]),
        .Q(testidata[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \testidata_reg[1] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[1]),
        .Q(testidata[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \testidata_reg[2] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[2]),
        .Q(testidata[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[3] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[3]),
        .Q(testidata[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[4] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[4]),
        .Q(testidata[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[5] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[5]),
        .Q(testidata[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[6] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[6]),
        .Q(testidata[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[7] 
       (.C(clk_out1),
        .CE(E[0]),
        .D(r_RX_Byte[7]),
        .Q(testidata[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \testidata_reg[8] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[0]),
        .Q(testidata[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \testidata_reg[9] 
       (.C(clk_out1),
        .CE(E[1]),
        .D(r_RX_Byte[1]),
        .Q(testidata[9]),
        .R(1'b0));
  FDRE tx_start_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(uarttx_n_2),
        .Q(tx_start_reg_n_0),
        .R(1'b0));
  UART_RX uartrx
       (.D(r_RX_Byte),
        .\FSM_onehot_rx_next_state_reg[0] (uartrx_n_1),
        .\FSM_onehot_rx_next_state_reg[0]_0 (uartrx_n_2),
        .\FSM_onehot_rx_next_state_reg[0]_1 (uartrx_n_3),
        .\FSM_onehot_rx_next_state_reg[2] (\FSM_onehot_rx_next_state_reg[0]_0 ),
        .\FSM_onehot_rx_next_state_reg[2]_0 (j_reg_0),
        .\FSM_onehot_rx_next_state_reg[2]_1 (\FSM_onehot_rx_next_state_reg[1]_0 ),
        .clk_out1(clk_out1),
        .pi_uart_rx(pi_uart_rx),
        .r_RX_busy_reg_0(r_RX_busy_reg),
        .route_RX_data_out(route_RX_data_out));
  UART_TX uarttx
       (.\FSM_onehot_next_state_reg[3] (uarttx_n_2),
        .Q({route_tx_in_progress0,\FSM_onehot_next_state_reg_n_0_[2] ,route_uart_tx_data_0,route_tx_in_progress}),
        .clk_out1(clk_out1),
        .po_uart_tx(po_uart_tx),
        .\r_TX_Data_reg[7]_0 (route_uart_tx_data),
        .route_uart_tx_done(route_uart_tx_done),
        .tx_start_reg(tx_start_reg_n_0));
endmodule

module uart_event_ctrl
   (po_uart_tx,
    j_reg,
    route_rx_ready_event,
    r_so_uart_rx_rdy,
    \FSM_onehot_rx_next_state_reg[0] ,
    \FSM_onehot_rx_next_state_reg[1] ,
    \route_RX_data_out_reg[0] ,
    Q,
    \route_RX_data_out_reg[0]_0 ,
    \route_RX_data_out_reg[2] ,
    \route_RX_data_out_reg[1] ,
    \route_RX_data_out_reg[0]_1 ,
    \route_RX_data_out_reg[13] ,
    \route_RX_data_out_reg[12] ,
    pi_uart_rx,
    clk_out1,
    \jihuu_reg[rstn] ,
    rstn,
    \jeemux_reg[2] ,
    \jeemux_reg[1] ,
    \jeemux_reg[0] ,
    E,
    D,
    si_uart_start_event);
  output po_uart_tx;
  output j_reg;
  output route_rx_ready_event;
  output r_so_uart_rx_rdy;
  output \FSM_onehot_rx_next_state_reg[0] ;
  output \FSM_onehot_rx_next_state_reg[1] ;
  output \route_RX_data_out_reg[0] ;
  output [15:0]Q;
  output \route_RX_data_out_reg[0]_0 ;
  output \route_RX_data_out_reg[2] ;
  output \route_RX_data_out_reg[1] ;
  output \route_RX_data_out_reg[0]_1 ;
  output [0:0]\route_RX_data_out_reg[13] ;
  output [0:0]\route_RX_data_out_reg[12] ;
  input pi_uart_rx;
  input clk_out1;
  input \jihuu_reg[rstn] ;
  input rstn;
  input \jeemux_reg[2] ;
  input \jeemux_reg[1] ;
  input \jeemux_reg[0] ;
  input [1:0]E;
  input [15:0]D;
  input si_uart_start_event;

  wire [15:0]D;
  wire [1:0]E;
  wire \FSM_onehot_rx_next_state_reg[0] ;
  wire \FSM_onehot_rx_next_state_reg[1] ;
  wire \FSM_sequential_r_next_state[0]_i_1_n_0 ;
  wire \FSM_sequential_r_next_state[1]_i_1_n_0 ;
  wire [15:0]Q;
  wire clk_out1;
  wire j_reg;
  wire \jeemux_reg[0] ;
  wire \jeemux_reg[1] ;
  wire \jeemux_reg[2] ;
  wire \jihuu_reg[rstn] ;
  wire pi_uart_rx;
  wire po_uart_tx;
  wire [15:0]r15_uart_data_in__0;
  wire r15_uart_data_in__1;
  wire [1:0]r_next_state;
  wire r_so_uart_rx_rdy;
  wire \route_RX_data_out_reg[0] ;
  wire \route_RX_data_out_reg[0]_0 ;
  wire \route_RX_data_out_reg[0]_1 ;
  wire [0:0]\route_RX_data_out_reg[12] ;
  wire [0:0]\route_RX_data_out_reg[13] ;
  wire \route_RX_data_out_reg[1] ;
  wire \route_RX_data_out_reg[2] ;
  wire route_rx_ready_event;
  wire route_uart_tx_active;
  wire route_uart_tx_start_reg_n_0;
  wire rstn;
  wire si_uart_start_event;
  wire uart1_n_5;

  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT4 #(
    .INIT(16'hED48)) 
    \FSM_sequential_r_next_state[0]_i_1 
       (.I0(r_next_state[0]),
        .I1(route_uart_tx_active),
        .I2(r_next_state[1]),
        .I3(si_uart_start_event),
        .O(\FSM_sequential_r_next_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT4 #(
    .INIT(16'h8CBC)) 
    \FSM_sequential_r_next_state[1]_i_1 
       (.I0(si_uart_start_event),
        .I1(r_next_state[1]),
        .I2(r_next_state[0]),
        .I3(route_uart_tx_active),
        .O(\FSM_sequential_r_next_state[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "ack:01,latch:10,idle:00,ready:11" *) 
  FDRE \FSM_sequential_r_next_state_reg[0] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_sequential_r_next_state[0]_i_1_n_0 ),
        .Q(r_next_state[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "ack:01,latch:10,idle:00,ready:11" *) 
  FDRE \FSM_sequential_r_next_state_reg[1] 
       (.C(clk_out1),
        .CE(1'b1),
        .D(\FSM_sequential_r_next_state[1]_i_1_n_0 ),
        .Q(r_next_state[1]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h02)) 
    r15_uart_data_in
       (.I0(si_uart_start_event),
        .I1(r_next_state[0]),
        .I2(r_next_state[1]),
        .O(r15_uart_data_in__1));
  FDRE \r15_uart_data_in_reg[0] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[0]),
        .Q(r15_uart_data_in__0[0]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[10] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[10]),
        .Q(r15_uart_data_in__0[10]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[11] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[11]),
        .Q(r15_uart_data_in__0[11]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[12] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[12]),
        .Q(r15_uart_data_in__0[12]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[13] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[13]),
        .Q(r15_uart_data_in__0[13]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[14] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[14]),
        .Q(r15_uart_data_in__0[14]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[15] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[15]),
        .Q(r15_uart_data_in__0[15]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[1] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[1]),
        .Q(r15_uart_data_in__0[1]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[2] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[2]),
        .Q(r15_uart_data_in__0[2]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[3] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[3]),
        .Q(r15_uart_data_in__0[3]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[4] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[4]),
        .Q(r15_uart_data_in__0[4]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[5] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[5]),
        .Q(r15_uart_data_in__0[5]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[6] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[6]),
        .Q(r15_uart_data_in__0[6]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[7] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[7]),
        .Q(r15_uart_data_in__0[7]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[8] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[8]),
        .Q(r15_uart_data_in__0[8]),
        .R(1'b0));
  FDRE \r15_uart_data_in_reg[9] 
       (.C(clk_out1),
        .CE(r15_uart_data_in__1),
        .D(D[9]),
        .Q(r15_uart_data_in__0[9]),
        .R(1'b0));
  FDRE route_uart_tx_start_reg
       (.C(clk_out1),
        .CE(1'b1),
        .D(uart1_n_5),
        .Q(route_uart_tx_start_reg_n_0),
        .R(1'b0));
  uart uart1
       (.E(E),
        .\FSM_onehot_rx_next_state_reg[0]_0 (\FSM_onehot_rx_next_state_reg[0] ),
        .\FSM_onehot_rx_next_state_reg[1]_0 (\FSM_onehot_rx_next_state_reg[1] ),
        .\FSM_sequential_r_next_state_reg[1] (uart1_n_5),
        .Q(r_next_state),
        .clk_out1(clk_out1),
        .j_reg_0(j_reg),
        .\jeemux_reg[0] (\jeemux_reg[0] ),
        .\jeemux_reg[1] (\jeemux_reg[1] ),
        .\jeemux_reg[2] (\jeemux_reg[2] ),
        .\jihuu_reg[rstn] (\jihuu_reg[rstn] ),
        .pi_uart_rx(pi_uart_rx),
        .po_uart_tx(po_uart_tx),
        .r_RX_busy_reg(route_rx_ready_event),
        .\route_RX_data_out_reg[0]_0 (\route_RX_data_out_reg[0] ),
        .\route_RX_data_out_reg[0]_1 (\route_RX_data_out_reg[0]_0 ),
        .\route_RX_data_out_reg[0]_2 (\route_RX_data_out_reg[0]_1 ),
        .\route_RX_data_out_reg[12]_0 (\route_RX_data_out_reg[12] ),
        .\route_RX_data_out_reg[13]_0 (\route_RX_data_out_reg[13] ),
        .\route_RX_data_out_reg[15]_0 (Q),
        .\route_RX_data_out_reg[1]_0 (\route_RX_data_out_reg[1] ),
        .\route_RX_data_out_reg[2]_0 (\route_RX_data_out_reg[2] ),
        .route_receive_ready_event_reg_0(r_so_uart_rx_rdy),
        .route_tx_in_progress_reg_0(route_uart_tx_start_reg_n_0),
        .route_uart_tx_active(route_uart_tx_active),
        .\route_uart_tx_data_reg[7]_0 (r15_uart_data_in__0),
        .rstn(rstn));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
