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


// IP VLNV: xilinx.com:module_ref:EX_MA_PR:1.0
// IP Revision: 1

(* X_CORE_INFO = "EX_MA_PR,Vivado 2020.2" *)
(* CHECK_LICENSE_TYPE = "RiscV_BD_EX_MA_PR_0_0,EX_MA_PR,{}" *)
(* CORE_GENERATION_INFO = "RiscV_BD_EX_MA_PR_0_0,EX_MA_PR,{x_ipProduct=Vivado 2020.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=EX_MA_PR,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module RiscV_BD_EX_MA_PR_0_0 (
  clk,
  rst,
  reg_write_E,
  load_src_E,
  Result_src_E,
  mem_write_E,
  inst_retired_E,
  proces_req_E,
  peripheral_wen_E,
  load_peripharal_E,
  ALU_result_E,
  write_data_E,
  RD_E,
  Ex_Imm_E,
  PC_plus4_E,
  CSR_Rdata_E,
  stall_E,
  reg_write_M,
  Result_src_M,
  mem_write_M,
  inst_retired_M,
  load_src_M,
  ALU_result_M,
  write_data_M,
  RD_M,
  Ex_Imm_M,
  PC_plus4_M,
  CSR_Rdata_M,
  proces_req_M,
  peripheral_wen_M,
  load_peripharal_M
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN RiscV_BD_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire reg_write_E;
input wire [2 : 0] load_src_E;
input wire [2 : 0] Result_src_E;
input wire mem_write_E;
input wire inst_retired_E;
input wire proces_req_E;
input wire peripheral_wen_E;
input wire load_peripharal_E;
input wire [31 : 0] ALU_result_E;
input wire [31 : 0] write_data_E;
input wire [4 : 0] RD_E;
input wire [31 : 0] Ex_Imm_E;
input wire [31 : 0] PC_plus4_E;
input wire [31 : 0] CSR_Rdata_E;
input wire stall_E;
output wire reg_write_M;
output wire [2 : 0] Result_src_M;
output wire mem_write_M;
output wire inst_retired_M;
output wire [2 : 0] load_src_M;
output wire [31 : 0] ALU_result_M;
output wire [31 : 0] write_data_M;
output wire [4 : 0] RD_M;
output wire [31 : 0] Ex_Imm_M;
output wire [31 : 0] PC_plus4_M;
output wire [31 : 0] CSR_Rdata_M;
output wire proces_req_M;
output wire peripheral_wen_M;
output wire load_peripharal_M;

  EX_MA_PR inst (
    .clk(clk),
    .rst(rst),
    .reg_write_E(reg_write_E),
    .load_src_E(load_src_E),
    .Result_src_E(Result_src_E),
    .mem_write_E(mem_write_E),
    .inst_retired_E(inst_retired_E),
    .proces_req_E(proces_req_E),
    .peripheral_wen_E(peripheral_wen_E),
    .load_peripharal_E(load_peripharal_E),
    .ALU_result_E(ALU_result_E),
    .write_data_E(write_data_E),
    .RD_E(RD_E),
    .Ex_Imm_E(Ex_Imm_E),
    .PC_plus4_E(PC_plus4_E),
    .CSR_Rdata_E(CSR_Rdata_E),
    .stall_E(stall_E),
    .reg_write_M(reg_write_M),
    .Result_src_M(Result_src_M),
    .mem_write_M(mem_write_M),
    .inst_retired_M(inst_retired_M),
    .load_src_M(load_src_M),
    .ALU_result_M(ALU_result_M),
    .write_data_M(write_data_M),
    .RD_M(RD_M),
    .Ex_Imm_M(Ex_Imm_M),
    .PC_plus4_M(PC_plus4_M),
    .CSR_Rdata_M(CSR_Rdata_M),
    .proces_req_M(proces_req_M),
    .peripheral_wen_M(peripheral_wen_M),
    .load_peripharal_M(load_peripharal_M)
  );
endmodule
