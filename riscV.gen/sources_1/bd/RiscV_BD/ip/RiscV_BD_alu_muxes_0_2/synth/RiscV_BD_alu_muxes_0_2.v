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


// IP VLNV: xilinx.com:module_ref:alu_muxes:1.0
// IP Revision: 1

(* X_CORE_INFO = "alu_muxes,Vivado 2020.2" *)
(* CHECK_LICENSE_TYPE = "RiscV_BD_alu_muxes_0_2,alu_muxes,{}" *)
(* CORE_GENERATION_INFO = "RiscV_BD_alu_muxes_0_2,alu_muxes,{x_ipProduct=Vivado 2020.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=alu_muxes,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module RiscV_BD_alu_muxes_0_2 (
  mux1_sel,
  mux2_sel,
  alu_mux_sel,
  condition_mux_sel,
  branch_mux_sel,
  mux1_in,
  mux2_in,
  alu_mux_in,
  condition,
  branch_E,
  ALUSrc,
  ALUOpCtrl,
  pc_Plus_4,
  immediate,
  rs1,
  rs2,
  alu_input_1,
  alu_input_2,
  alu_op,
  condition_out,
  alu_branch
);

input wire mux1_sel;
input wire mux2_sel;
input wire alu_mux_sel;
input wire condition_mux_sel;
input wire branch_mux_sel;
input wire mux1_in;
input wire mux2_in;
input wire [3 : 0] alu_mux_in;
input wire condition;
input wire branch_E;
input wire [1 : 0] ALUSrc;
input wire [3 : 0] ALUOpCtrl;
input wire [31 : 0] pc_Plus_4;
input wire [31 : 0] immediate;
input wire [31 : 0] rs1;
input wire [31 : 0] rs2;
output wire [31 : 0] alu_input_1;
output wire [31 : 0] alu_input_2;
output wire [3 : 0] alu_op;
output wire condition_out;
output wire alu_branch;

  alu_muxes inst (
    .mux1_sel(mux1_sel),
    .mux2_sel(mux2_sel),
    .alu_mux_sel(alu_mux_sel),
    .condition_mux_sel(condition_mux_sel),
    .branch_mux_sel(branch_mux_sel),
    .mux1_in(mux1_in),
    .mux2_in(mux2_in),
    .alu_mux_in(alu_mux_in),
    .condition(condition),
    .branch_E(branch_E),
    .ALUSrc(ALUSrc),
    .ALUOpCtrl(ALUOpCtrl),
    .pc_Plus_4(pc_Plus_4),
    .immediate(immediate),
    .rs1(rs1),
    .rs2(rs2),
    .alu_input_1(alu_input_1),
    .alu_input_2(alu_input_2),
    .alu_op(alu_op),
    .condition_out(condition_out),
    .alu_branch(alu_branch)
  );
endmodule
