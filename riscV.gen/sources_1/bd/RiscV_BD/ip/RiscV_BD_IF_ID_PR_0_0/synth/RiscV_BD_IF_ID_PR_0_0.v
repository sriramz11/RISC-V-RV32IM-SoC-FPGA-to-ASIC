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


// IP VLNV: xilinx.com:module_ref:IF_ID_PR:1.0
// IP Revision: 1

(* X_CORE_INFO = "IF_ID_PR,Vivado 2020.2" *)
(* CHECK_LICENSE_TYPE = "RiscV_BD_IF_ID_PR_0_0,IF_ID_PR,{}" *)
(* CORE_GENERATION_INFO = "RiscV_BD_IF_ID_PR_0_0,IF_ID_PR,{x_ipProduct=Vivado 2020.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=IF_ID_PR,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module RiscV_BD_IF_ID_PR_0_0 (
  clk,
  rst,
  PC_F,
  Inst_F,
  PC_plus4_F,
  stall_F,
  flush_F,
  opcode,
  funct3_D,
  funct7_D,
  Rs1_D,
  Rs2_D,
  PC_D,
  Rd_D,
  Imm_D,
  PC_plus4_D,
  csr_add_D
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN RiscV_BD_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [31 : 0] PC_F;
input wire [31 : 0] Inst_F;
input wire [31 : 0] PC_plus4_F;
input wire stall_F;
input wire flush_F;
output wire [6 : 0] opcode;
output wire [2 : 0] funct3_D;
output wire [6 : 0] funct7_D;
output wire [4 : 0] Rs1_D;
output wire [4 : 0] Rs2_D;
output wire [31 : 0] PC_D;
output wire [4 : 0] Rd_D;
output wire [24 : 0] Imm_D;
output wire [31 : 0] PC_plus4_D;
output wire [11 : 0] csr_add_D;

  IF_ID_PR inst (
    .clk(clk),
    .rst(rst),
    .PC_F(PC_F),
    .Inst_F(Inst_F),
    .PC_plus4_F(PC_plus4_F),
    .stall_F(stall_F),
    .flush_F(flush_F),
    .opcode(opcode),
    .funct3_D(funct3_D),
    .funct7_D(funct7_D),
    .Rs1_D(Rs1_D),
    .Rs2_D(Rs2_D),
    .PC_D(PC_D),
    .Rd_D(Rd_D),
    .Imm_D(Imm_D),
    .PC_plus4_D(PC_plus4_D),
    .csr_add_D(csr_add_D)
  );
endmodule
