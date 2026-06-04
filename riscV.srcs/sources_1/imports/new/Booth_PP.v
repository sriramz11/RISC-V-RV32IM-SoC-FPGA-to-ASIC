`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2026 19:43:39
// Design Name: 
// Module Name: Booth_PP
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


module Booth_PP(
    input  [31:0] Rs1,
    input  [31:0] Rs2,
    output [543:0] partial_prod_flat   // ? wire, not reg
);

// +A, +2A, -A, -2A  computed once, shared by all lanes
wire [33:0] pos_a  = {{2{Rs1[31]}}, Rs1};
wire [33:0] pos_2a = {Rs1[31], Rs1, 1'b0};
wire [33:0] neg_a  = ~pos_a  + 34'd1;
wire [33:0] neg_2a = ~pos_2a + 34'd1;

genvar k;
generate
    for (k = 0; k < 16; k = k + 1) begin : booth_lane

        // Each lane has its OWN sel and pp ? no sharing
        wire [2:0] sel_k = (k == 0) 
                         ? {Rs2[1], Rs2[0], 1'b0}
                         : {Rs2[2*k+1], Rs2[2*k], Rs2[2*k-1]};

        wire [33:0] pp_k = (sel_k == 3'b001 || sel_k == 3'b010) ? pos_a  :
                           (sel_k == 3'b011)                     ? pos_2a :
                           (sel_k == 3'b100)                     ? neg_2a :
                           (sel_k == 3'b101 || sel_k == 3'b110) ? neg_a  :
                                                                   34'd0;

        assign partial_prod_flat[k*34 +: 34] = pp_k;
    end
endgenerate

endmodule