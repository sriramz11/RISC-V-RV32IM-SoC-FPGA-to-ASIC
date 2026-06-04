`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 22:48:44
// Design Name: 
// Module Name: Dadda_Stage_1
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
module Dadda_stage1 (
    input  wire [543:0] pp_flat,
    output wire [65:0]  out_s3_0,
    output wire [65:0]  out_c3_0,
    output wire [65:0]  out_s3_1,
    output wire [65:0]  out_c3_1,
    output wire [65:0]  out_c1_4,
    output wire [65:0]  out_pp15
);
 
    // =========================================================================
    // Step 1 — Unpack 16 partial products from flat bus
    // =========================================================================
    wire [33:0] pp [0:15];
    genvar k;
    generate
        for (k = 0; k < 16; k = k + 1) begin : unpack
            assign pp[k] = pp_flat[k*34 +: 34];
        end
    endgenerate
 
    // =========================================================================
    // Step 2 — Sign-extend each 34-bit PP to 66 bits, shift by 2i
    //
    //   pp_s[i] = { (32-2i) sign bits | pp[i] | 2i zero bits }
    // =========================================================================
    wire [65:0] pp_s [0:15];
 
    assign pp_s[ 0] = {{32{pp[ 0][33]}}, pp[ 0]            };   // << 0
    assign pp_s[ 1] = {{30{pp[ 1][33]}}, pp[ 1],  2'b00    };   // << 2
    assign pp_s[ 2] = {{28{pp[ 2][33]}}, pp[ 2],  4'b0     };   // << 4
    assign pp_s[ 3] = {{26{pp[ 3][33]}}, pp[ 3],  6'b0     };   // << 6
    assign pp_s[ 4] = {{24{pp[ 4][33]}}, pp[ 4],  8'b0     };   // << 8
    assign pp_s[ 5] = {{22{pp[ 5][33]}}, pp[ 5], 10'b0     };   // << 10
    assign pp_s[ 6] = {{20{pp[ 6][33]}}, pp[ 6], 12'b0     };   // << 12
    assign pp_s[ 7] = {{18{pp[ 7][33]}}, pp[ 7], 14'b0     };   // << 14
    assign pp_s[ 8] = {{16{pp[ 8][33]}}, pp[ 8], 16'b0     };   // << 16
    assign pp_s[ 9] = {{14{pp[ 9][33]}}, pp[ 9], 18'b0     };   // << 18
    assign pp_s[10] = {{12{pp[10][33]}}, pp[10], 20'b0     };   // << 20
    assign pp_s[11] = {{10{pp[11][33]}}, pp[11], 22'b0     };   // << 22
    assign pp_s[12] = {{ 8{pp[12][33]}}, pp[12], 24'b0     };   // << 24
    assign pp_s[13] = {{ 6{pp[13][33]}}, pp[13], 26'b0     };   // << 26
    assign pp_s[14] = {{ 4{pp[14][33]}}, pp[14], 28'b0     };   // << 28
    assign pp_s[15] = {{ 2{pp[15][33]}}, pp[15], 30'b0     };   // << 30
 
    // =========================================================================
    // Stage 1 : 16 -> 11  (5 CSAs, pass-through: pp_s[15])
    // =========================================================================
    wire [65:0] s1_0, c1_0, s1_1, c1_1, s1_2, c1_2, s1_3, c1_3, s1_4, c1_4;
    wire [65:0] g1_0, g1_1, g1_2, g1_3, g1_4;
 
    assign s1_0 = pp_s[0]  ^ pp_s[1]  ^ pp_s[2];
    assign g1_0 = (pp_s[0] & pp_s[1]) | (pp_s[1] & pp_s[2]) | (pp_s[0] & pp_s[2]);
    assign c1_0 = {g1_0[64:0], 1'b0};
 
    assign s1_1 = pp_s[3]  ^ pp_s[4]  ^ pp_s[5];
    assign g1_1 = (pp_s[3] & pp_s[4]) | (pp_s[4] & pp_s[5]) | (pp_s[3] & pp_s[5]);
    assign c1_1 = {g1_1[64:0], 1'b0};
 
    assign s1_2 = pp_s[6]  ^ pp_s[7]  ^ pp_s[8];
    assign g1_2 = (pp_s[6] & pp_s[7]) | (pp_s[7] & pp_s[8]) | (pp_s[6] & pp_s[8]);
    assign c1_2 = {g1_2[64:0], 1'b0};
 
    assign s1_3 = pp_s[9]  ^ pp_s[10] ^ pp_s[11];
    assign g1_3 = (pp_s[9] & pp_s[10]) | (pp_s[10] & pp_s[11]) | (pp_s[9] & pp_s[11]);
    assign c1_3 = {g1_3[64:0], 1'b0};
 
    assign s1_4 = pp_s[12] ^ pp_s[13] ^ pp_s[14];
    assign g1_4 = (pp_s[12] & pp_s[13]) | (pp_s[13] & pp_s[14]) | (pp_s[12] & pp_s[14]);
    assign c1_4 = {g1_4[64:0], 1'b0};
 
    // live: s1_0,c1_0, s1_1,c1_1, s1_2,c1_2, s1_3,c1_3, s1_4,c1_4, pp_s[15] = 11
 
    // =========================================================================
    // Stage 2 : 11 -> 8  (3 CSAs, pass-throughs: c1_4, pp_s[15])
    // =========================================================================
    wire [65:0] s2_0, c2_0, s2_1, c2_1, s2_2, c2_2;
    wire [65:0] g2_0, g2_1, g2_2;
 
    assign s2_0 = s1_0  ^ c1_0  ^ s1_1;
    assign g2_0 = (s1_0 & c1_0) | (c1_0 & s1_1) | (s1_0 & s1_1);
    assign c2_0 = {g2_0[64:0], 1'b0};
 
    assign s2_1 = c1_1  ^ s1_2  ^ c1_2;
    assign g2_1 = (c1_1 & s1_2) | (s1_2 & c1_2) | (c1_1 & c1_2);
    assign c2_1 = {g2_1[64:0], 1'b0};
 
    assign s2_2 = s1_3  ^ c1_3  ^ s1_4;
    assign g2_2 = (s1_3 & c1_3) | (c1_3 & s1_4) | (s1_3 & s1_4);
    assign c2_2 = {g2_2[64:0], 1'b0};
 
    // live: s2_0,c2_0, s2_1,c2_1, s2_2,c2_2, c1_4, pp_s[15] = 8
 
    // =========================================================================
    // Stage 3 : 8 -> 6  (2 CSAs, pass-throughs: c1_4, pp_s[15])
    // =========================================================================
    wire [65:0] s3_0, c3_0, s3_1, c3_1;
    wire [65:0] g3_0, g3_1;
 
    assign s3_0 = s2_0  ^ c2_0  ^ s2_1;
    assign g3_0 = (s2_0 & c2_0) | (c2_0 & s2_1) | (s2_0 & s2_1);
    assign c3_0 = {g3_0[64:0], 1'b0};
 
    assign s3_1 = c2_1  ^ s2_2  ^ c2_2;
    assign g3_1 = (c2_1 & s2_2) | (s2_2 & c2_2) | (c2_1 & c2_2);
    assign c3_1 = {g3_1[64:0], 1'b0};
 
    // live: s3_0, c3_0, s3_1, c3_1, c1_4, pp_s[15] = 6  <-- pipeline boundary
 
    // =========================================================================
    // Drive outputs — these 6 x 66-bit signals go into the pipeline register
    // =========================================================================
    assign out_s3_0 = s3_0;
    assign out_c3_0 = c3_0;
    assign out_s3_1 = s3_1;
    assign out_c3_1 = c3_1;
    assign out_c1_4 = c1_4;      // pass-through from stage 1
    assign out_pp15 = pp_s[15];  // pass-through from sign-extension
 
endmodule
