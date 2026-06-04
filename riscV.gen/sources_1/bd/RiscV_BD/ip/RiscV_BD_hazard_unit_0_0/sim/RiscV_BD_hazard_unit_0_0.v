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


// IP VLNV: xilinx.com:module_ref:hazard_unit:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module RiscV_BD_hazard_unit_0_0 (
  rdmem,
  rs1ex,
  rs2ex,
  rdwb,
  rdex,
  rs1id,
  rs2id,
  memtoreg,
  condition_stall,
  jump_branch_flush,
  mul_stall,
  processor_request,
  processor_wen,
  peripheral_load,
  proc_ack,
  mem_sel_s1,
  mem_sel_s2,
  wb_sel_s1,
  wb_sel_s2,
  stall_pc,
  stall_ifid,
  flushe,
  flushd,
  stall_idex,
  stall_exmem,
  stall_memwb
);

input wire [4 : 0] rdmem;
input wire [4 : 0] rs1ex;
input wire [4 : 0] rs2ex;
input wire [4 : 0] rdwb;
input wire [4 : 0] rdex;
input wire [4 : 0] rs1id;
input wire [4 : 0] rs2id;
input wire memtoreg;
input wire condition_stall;
input wire jump_branch_flush;
input wire mul_stall;
input wire processor_request;
input wire processor_wen;
input wire peripheral_load;
input wire proc_ack;
output wire mem_sel_s1;
output wire mem_sel_s2;
output wire wb_sel_s1;
output wire wb_sel_s2;
output wire stall_pc;
output wire stall_ifid;
output wire flushe;
output wire flushd;
output wire stall_idex;
output wire stall_exmem;
output wire stall_memwb;

  hazard_unit inst (
    .rdmem(rdmem),
    .rs1ex(rs1ex),
    .rs2ex(rs2ex),
    .rdwb(rdwb),
    .rdex(rdex),
    .rs1id(rs1id),
    .rs2id(rs2id),
    .memtoreg(memtoreg),
    .condition_stall(condition_stall),
    .jump_branch_flush(jump_branch_flush),
    .mul_stall(mul_stall),
    .processor_request(processor_request),
    .processor_wen(processor_wen),
    .peripheral_load(peripheral_load),
    .proc_ack(proc_ack),
    .mem_sel_s1(mem_sel_s1),
    .mem_sel_s2(mem_sel_s2),
    .wb_sel_s1(wb_sel_s1),
    .wb_sel_s2(wb_sel_s2),
    .stall_pc(stall_pc),
    .stall_ifid(stall_ifid),
    .flushe(flushe),
    .flushd(flushd),
    .stall_idex(stall_idex),
    .stall_exmem(stall_exmem),
    .stall_memwb(stall_memwb)
  );
endmodule
