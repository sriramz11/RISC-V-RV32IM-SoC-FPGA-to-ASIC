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


// IP VLNV: xilinx.com:module_ref:csr:1.0
// IP Revision: 1

(* X_CORE_INFO = "csr,Vivado 2020.2" *)
(* CHECK_LICENSE_TYPE = "RiscV_BD_csr_0_0,csr,{}" *)
(* CORE_GENERATION_INFO = "RiscV_BD_csr_0_0,csr,{x_ipProduct=Vivado 2020.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=csr,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module RiscV_BD_csr_0_0 (
  clk,
  rst,
  csr_addr,
  csr_op,
  csr_wen,
  rs1_data,
  instr_retired,
  csr_exc,
  pc_current,
  csr_rdata,
  mtvec_out,
  mepc_out,
  mstatus_mie
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN RiscV_BD_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [11 : 0] csr_addr;
input wire [1 : 0] csr_op;
input wire csr_wen;
input wire [31 : 0] rs1_data;
input wire instr_retired;
input wire csr_exc;
input wire [31 : 0] pc_current;
output wire [31 : 0] csr_rdata;
output wire [31 : 0] mtvec_out;
output wire [31 : 0] mepc_out;
output wire mstatus_mie;

  csr inst (
    .clk(clk),
    .rst(rst),
    .csr_addr(csr_addr),
    .csr_op(csr_op),
    .csr_wen(csr_wen),
    .rs1_data(rs1_data),
    .instr_retired(instr_retired),
    .csr_exc(csr_exc),
    .pc_current(pc_current),
    .csr_rdata(csr_rdata),
    .mtvec_out(mtvec_out),
    .mepc_out(mepc_out),
    .mstatus_mie(mstatus_mie)
  );
endmodule
