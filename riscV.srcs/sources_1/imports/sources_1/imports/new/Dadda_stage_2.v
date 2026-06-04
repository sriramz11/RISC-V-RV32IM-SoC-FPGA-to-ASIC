`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 22:48:18
// Design Name: 
// Module Name: Dadda_stage_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Dadda_stage2 (
    input  wire [65:0] in_s3_0,
    input  wire [65:0] in_c3_0,
    input  wire [65:0] in_s3_1,
    input  wire [65:0] in_c3_1,
    input  wire [65:0] in_c1_4,
    input  wire [65:0] in_pp15,
    output wire [63:0] product
);
 
    // =========================================================================
    // Stage 4 : 6 -> 4  (2 CSAs)
    // =========================================================================
    wire [65:0] s4_0, c4_0, s4_1, c4_1;
    wire [65:0] g4_0, g4_1;
 
    assign s4_0 = in_s3_0 ^ in_c3_0  ^ in_s3_1;
    assign g4_0 = (in_s3_0 & in_c3_0) | (in_c3_0 & in_s3_1) | (in_s3_0 & in_s3_1);
    assign c4_0 = {g4_0[64:0], 1'b0};
 
    assign s4_1 = in_c3_1 ^ in_c1_4  ^ in_pp15;
    assign g4_1 = (in_c3_1 & in_c1_4) | (in_c1_4 & in_pp15) | (in_c3_1 & in_pp15);
    assign c4_1 = {g4_1[64:0], 1'b0};
 
    // live: s4_0, c4_0, s4_1, c4_1 = 4
 
    // =========================================================================
    // Stage 5 : 4 -> 3  (1 CSA, pass-through: c4_1)
    // =========================================================================
    wire [65:0] s5_0, c5_0;
    wire [65:0] g5_0;
 
    assign s5_0 = s4_0  ^ c4_0  ^ s4_1;
    assign g5_0 = (s4_0 & c4_0) | (c4_0 & s4_1) | (s4_0 & s4_1);
    assign c5_0 = {g5_0[64:0], 1'b0};
 
    // live: s5_0, c5_0, c4_1 = 3
 
    // =========================================================================
    // Stage 6 : 3 -> 2  (1 CSA)
    // =========================================================================
    wire [65:0] final_s, final_c;
    wire [65:0] g6_0;
 
    assign final_s = s5_0  ^ c5_0  ^ c4_1;
    assign g6_0    = (s5_0 & c5_0) | (c5_0 & c4_1) | (s5_0 & c4_1);
    assign final_c = {g6_0[64:0], 1'b0};
 

    wire [65:0] cpa_out;
    assign cpa_out = final_s + final_c;
 
    assign product = cpa_out[63:0];
 
endmodule
