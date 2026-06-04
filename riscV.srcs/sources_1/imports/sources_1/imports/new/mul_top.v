`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2026 21:09:30
// Design Name: 
// Module Name: mul_top
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
// =============================================================================
// mult32x32_top.v
//
// 32 × 32 Signed Multiplier — 2-Stage Pipelined Top Level
//
// Pipeline structure
//
//   Cycle 1                          |  Cycle 2
//  ?????????????????????????????????????????????????????
//   Rs1, Rs2 ??? booth_radix4            |
//            pp_flat (comb.)         |
//            ?                       |
//         [PIPELINE REGISTER]  ???????  dadda_tree
//          pp_flat_r[543:0]              ?
//          valid_s1                   product (registered)
//                                     valid_out
//
// Latency    : 2 clock cycles  (first valid product appears 2 cycles after
//              first valid input)
// Throughput : 1 result per clock cycle  (fully pipelined — new Rs1/Rs2 accepted
//              every cycle)
//
// Ports
//   clk          — clock (rising-edge triggered)
//   rst_n        — asynchronous active-low reset
//   valid_in     — asserted the same cycle Rs1 and Rs2 are presented
//   Rs1[31:0]      — signed multiplicand
//   Rs2[31:0]      — signed multiplier
//   product[63:0]— signed 64-bit result, valid when valid_out is high
//   valid_out    — result on product[] is valid this cycle
// =============================================================================

module mul_top (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] Rs1,
    input  wire [31:0] Rs2,
    output reg  [63:0] product
);
 
    // =========================================================================
    // CYCLE 1 — Booth Radix-4 partial-product generation (combinational)
    // =========================================================================
    wire [543:0] pp_flat;
 
    Booth_PP u_booth (
        .Rs1              (Rs1),
        .Rs2              (Rs2),
        .partial_prod_flat(pp_flat)
    );
 
    // Pipeline register — end of Cycle 1
    reg [543:0] pp_flat_r;
 
    always @(posedge clk) begin
        if (rst) pp_flat_r <= 544'd0;
        else        pp_flat_r <= pp_flat;
    end
 
    // =========================================================================
    // CYCLE 2 — Dadda Stage 1 : reduces 16 rows to 6 rows (combinational)
    // =========================================================================
    wire [65:0] s3_0_w, c3_0_w, s3_1_w, c3_1_w, c1_4_w, pp15_w;
 
    Dadda_stage1 u_dadda1 (
        .pp_flat (pp_flat_r),
        .out_s3_0(s3_0_w),
        .out_c3_0(c3_0_w),
        .out_s3_1(s3_1_w),
        .out_c3_1(c3_1_w),
        .out_c1_4(c1_4_w),
        .out_pp15(pp15_w)
    );
 
    // Pipeline register — end of Cycle 2 (6 rows x 66 bits = 396 bits)
    reg [65:0] s3_0_r, c3_0_r, s3_1_r, c3_1_r, c1_4_r, pp15_r;
 
    always @(posedge clk) begin
        if (rst) begin
            s3_0_r <= 66'd0;
            c3_0_r <= 66'd0;
            s3_1_r <= 66'd0;
            c3_1_r <= 66'd0;
            c1_4_r <= 66'd0;
            pp15_r <= 66'd0;
        end else begin
            s3_0_r <= s3_0_w;
            c3_0_r <= c3_0_w;
            s3_1_r <= s3_1_w;
            c3_1_r <= c3_1_w;
            c1_4_r <= c1_4_w;
            pp15_r <= pp15_w;
        end
    end
 
    // =========================================================================
    // CYCLE 3 — Dadda Stage 2 : stages 4-6 + CPA (combinational)
    // =========================================================================
    wire [63:0] product_w;
 
    Dadda_stage2 u_dadda2 (
        .in_s3_0(s3_0_r),
        .in_c3_0(c3_0_r),
        .in_s3_1(s3_1_r),
        .in_c3_1(c3_1_r),
        .in_c1_4(c1_4_r),
        .in_pp15 (pp15_r),
        .product (product_w)
    );
 
    // Output register — end of Cycle 3
//    always @(posedge clk) begin
//        if (rst) product <= 64'd0;
//        else        product <= product_w;
//    end
    always@(*)
    begin
    if(rst) product = 64'd0;
    else product = product_w;
    end
endmodule
