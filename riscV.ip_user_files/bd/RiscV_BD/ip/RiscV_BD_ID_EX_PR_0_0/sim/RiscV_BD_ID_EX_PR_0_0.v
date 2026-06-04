// (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:ID_EX_PR:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module RiscV_BD_ID_EX_PR_0_0 (
  clk,
  rst,
  Reg_write_D,
  Result_src_D,
  mem_write_D,
  jump_D,
  branch_D,
  alu_op_ctrl_D,
  alu_src_D,
  inst_retired_D,
  fix_P_mux_D,
  load_src_D,
  PC_D,
  RS1_D,
  RS2_D,
  RD1_D,
  RD2_D,
  RD_D,
  Ex_Imm_D,
  PC_plus4_D,
  CSR_Rdata_D,
  stall_D,
  flush_D,
  mem2reg_D,
  processer_req_D,
  load_peripharal_D,
  peripheral_wen_D,
  processer_req_E,
  load_peripheral_E,
  peripheral_wen_E,
  Reg_write_E,
  Result_src_E,
  mem_write_E,
  jump_E,
  branch_E,
  alu_op_ctrl_E,
  alu_src_E,
  inst_retired_E,
  fix_P_mux_E,
  load_src_E,
  PC_E,
  RS1_E,
  RS2_E,
  RD1_E,
  RD2_E,
  RD_E,
  Ex_Imm_E,
  PC_plus4_E,
  CSR_Rdata_E,
  mem2reg_E
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN RiscV_BD_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire Reg_write_D;
input wire [2 : 0] Result_src_D;
input wire mem_write_D;
input wire jump_D;
input wire branch_D;
input wire [3 : 0] alu_op_ctrl_D;
input wire [1 : 0] alu_src_D;
input wire inst_retired_D;
input wire fix_P_mux_D;
input wire [2 : 0] load_src_D;
input wire [31 : 0] PC_D;
input wire [4 : 0] RS1_D;
input wire [4 : 0] RS2_D;
input wire [31 : 0] RD1_D;
input wire [31 : 0] RD2_D;
input wire [4 : 0] RD_D;
input wire [31 : 0] Ex_Imm_D;
input wire [31 : 0] PC_plus4_D;
input wire [31 : 0] CSR_Rdata_D;
input wire stall_D;
input wire flush_D;
input wire mem2reg_D;
input wire processer_req_D;
input wire load_peripharal_D;
input wire peripheral_wen_D;
output wire processer_req_E;
output wire load_peripheral_E;
output wire peripheral_wen_E;
output wire Reg_write_E;
output wire [2 : 0] Result_src_E;
output wire mem_write_E;
output wire jump_E;
output wire branch_E;
output wire [3 : 0] alu_op_ctrl_E;
output wire [1 : 0] alu_src_E;
output wire inst_retired_E;
output wire fix_P_mux_E;
output wire [2 : 0] load_src_E;
output wire [31 : 0] PC_E;
output wire [4 : 0] RS1_E;
output wire [4 : 0] RS2_E;
output wire [31 : 0] RD1_E;
output wire [31 : 0] RD2_E;
output wire [4 : 0] RD_E;
output wire [31 : 0] Ex_Imm_E;
output wire [31 : 0] PC_plus4_E;
output wire [31 : 0] CSR_Rdata_E;
output wire mem2reg_E;

  ID_EX_PR inst (
    .clk(clk),
    .rst(rst),
    .Reg_write_D(Reg_write_D),
    .Result_src_D(Result_src_D),
    .mem_write_D(mem_write_D),
    .jump_D(jump_D),
    .branch_D(branch_D),
    .alu_op_ctrl_D(alu_op_ctrl_D),
    .alu_src_D(alu_src_D),
    .inst_retired_D(inst_retired_D),
    .fix_P_mux_D(fix_P_mux_D),
    .load_src_D(load_src_D),
    .PC_D(PC_D),
    .RS1_D(RS1_D),
    .RS2_D(RS2_D),
    .RD1_D(RD1_D),
    .RD2_D(RD2_D),
    .RD_D(RD_D),
    .Ex_Imm_D(Ex_Imm_D),
    .PC_plus4_D(PC_plus4_D),
    .CSR_Rdata_D(CSR_Rdata_D),
    .stall_D(stall_D),
    .flush_D(flush_D),
    .mem2reg_D(mem2reg_D),
    .processer_req_D(processer_req_D),
    .load_peripharal_D(load_peripharal_D),
    .peripheral_wen_D(peripheral_wen_D),
    .processer_req_E(processer_req_E),
    .load_peripheral_E(load_peripheral_E),
    .peripheral_wen_E(peripheral_wen_E),
    .Reg_write_E(Reg_write_E),
    .Result_src_E(Result_src_E),
    .mem_write_E(mem_write_E),
    .jump_E(jump_E),
    .branch_E(branch_E),
    .alu_op_ctrl_E(alu_op_ctrl_E),
    .alu_src_E(alu_src_E),
    .inst_retired_E(inst_retired_E),
    .fix_P_mux_E(fix_P_mux_E),
    .load_src_E(load_src_E),
    .PC_E(PC_E),
    .RS1_E(RS1_E),
    .RS2_E(RS2_E),
    .RD1_E(RD1_E),
    .RD2_E(RD2_E),
    .RD_E(RD_E),
    .Ex_Imm_E(Ex_Imm_E),
    .PC_plus4_E(PC_plus4_E),
    .CSR_Rdata_E(CSR_Rdata_E),
    .mem2reg_E(mem2reg_E)
  );
endmodule
