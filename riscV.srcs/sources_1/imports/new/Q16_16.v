`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Q16_16_Mult
// Description: Fully-combinational Q16.16 signed fixed-point multiplier.
//
//  Format  (Q16.16):
//    Bit 31      – sign
//    Bits [30:16] – 15-bit integer magnitude (2's-complement with sign)
//    Bits [15: 0] – 16-bit fractional part
//
//  Arithmetic:
//    Two Q16.16 values are ordinary 32-bit 2's-complement integers scaled
//    by 2^-16.  Their raw 64-bit product is scaled by 2^-32, so the
//    Q16.16 result sits in bits [47:16] of the 64-bit product.
//                this condition.
//
//  Sub-modules (all combinational, no clock):
//    Booth_PP   – radix-4 modified Booth encoder  (16 partial products)
//    Dadda_tree – 6-stage Dadda CSA tree + CPA    (reduces 16 PPs -> 64-bit sum)
//
//////////////////////////////////////////////////////////////////////////////////
module Q16_16_Mult (
    input  wire signed [31:0] A,        // Q16.16 multiplicand
    input  wire signed [31:0] B,        // Q16.16 multiplier
    output wire signed [31:0] result,   // Q16.16 product  (bits [47:16] of raw)
    output wire               overflow  // 1 = result cannot fit in Q16.16
);

    // -------------------------------------------------------------------------
    // Step 1 – Generate 16 radix-4 Booth partial products
    // -------------------------------------------------------------------------
    wire [543:0] pp_flat;

    Booth_PP_FM u_booth (
        .Rs1             (A),
        .Rs2             (B),
        .partial_prod_flat (pp_flat)
    );

    // -------------------------------------------------------------------------
    // Step 2 – Reduce partial products to a single 64-bit sum
    // -------------------------------------------------------------------------
    wire [63:0] raw_product;

    Dadda_tree u_dadda (
        .pp_flat (pp_flat),
        .product (raw_product)
    );

    // -------------------------------------------------------------------------
    // Step 3 – Extract Q16.16 result from bits [47:16]
    // -------------------------------------------------------------------------
    assign result = raw_product[47:16];

    // -------------------------------------------------------------------------
    // Step 4 – Overflow detection
    // -------------------------------------------------------------------------
    wire sign_bit = raw_product[47];
    assign overflow = (raw_product[63:48] != {16{sign_bit}});

endmodule