`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Dadda_tree
// Description: Fully-combinational Dadda reduction tree.
//              Merges the original Dadda_stage1 + Dadda_stage2 into a single
//              clock-free module.
//

//////////////////////////////////////////////////////////////////////////////////
module Dadda_tree (
    input  wire [543:0] pp_flat,    // 16 x 34-bit partial products (from Booth_PP)
    output wire [ 63:0] product     // 64-bit signed result
);

    // =========================================================================
    // Unpack 16 partial products
    // =========================================================================
    wire [33:0] pp [0:15];
    genvar k;
    generate
        for (k = 0; k < 16; k = k + 1) begin : unpack
            assign pp[k] = pp_flat[k*34 +: 34];
        end
    endgenerate

    wire [65:0] pp_s [0:15];

    assign pp_s[ 0] = {{32{pp[ 0][33]}}, pp[ 0]         };  // << 0
    assign pp_s[ 1] = {{30{pp[ 1][33]}}, pp[ 1],  2'b00 };  // << 2
    assign pp_s[ 2] = {{28{pp[ 2][33]}}, pp[ 2],  4'b0  };  // << 4
    assign pp_s[ 3] = {{26{pp[ 3][33]}}, pp[ 3],  6'b0  };  // << 6
    assign pp_s[ 4] = {{24{pp[ 4][33]}}, pp[ 4],  8'b0  };  // << 8
    assign pp_s[ 5] = {{22{pp[ 5][33]}}, pp[ 5], 10'b0  };  // << 10
    assign pp_s[ 6] = {{20{pp[ 6][33]}}, pp[ 6], 12'b0  };  // << 12
    assign pp_s[ 7] = {{18{pp[ 7][33]}}, pp[ 7], 14'b0  };  // << 14
    assign pp_s[ 8] = {{16{pp[ 8][33]}}, pp[ 8], 16'b0  };  // << 16
    assign pp_s[ 9] = {{14{pp[ 9][33]}}, pp[ 9], 18'b0  };  // << 18
    assign pp_s[10] = {{12{pp[10][33]}}, pp[10], 20'b0  };  // << 20
    assign pp_s[11] = {{10{pp[11][33]}}, pp[11], 22'b0  };  // << 22
    assign pp_s[12] = {{ 8{pp[12][33]}}, pp[12], 24'b0  };  // << 24
    assign pp_s[13] = {{ 6{pp[13][33]}}, pp[13], 26'b0  };  // << 26
    assign pp_s[14] = {{ 4{pp[14][33]}}, pp[14], 28'b0  };  // << 28
    assign pp_s[15] = {{ 2{pp[15][33]}}, pp[15], 30'b0  };  // << 30


    wire [65:0] s1_0, c1_0, g1_0;
    wire [65:0] s1_1, c1_1, g1_1;
    wire [65:0] s1_2, c1_2, g1_2;
    wire [65:0] s1_3, c1_3, g1_3;
    wire [65:0] s1_4, c1_4, g1_4;

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

    wire [65:0] s2_0, c2_0, g2_0;
    wire [65:0] s2_1, c2_1, g2_1;
    wire [65:0] s2_2, c2_2, g2_2;

    assign s2_0 = s1_0  ^ c1_0  ^ s1_1;
    assign g2_0 = (s1_0 & c1_0) | (c1_0 & s1_1) | (s1_0 & s1_1);
    assign c2_0 = {g2_0[64:0], 1'b0};

    assign s2_1 = c1_1  ^ s1_2  ^ c1_2;
    assign g2_1 = (c1_1 & s1_2) | (s1_2 & c1_2) | (c1_1 & c1_2);
    assign c2_1 = {g2_1[64:0], 1'b0};

    assign s2_2 = s1_3  ^ c1_3  ^ s1_4;
    assign g2_2 = (s1_3 & c1_3) | (c1_3 & s1_4) | (s1_3 & s1_4);
    assign c2_2 = {g2_2[64:0], 1'b0};


    wire [65:0] s3_0, c3_0, g3_0;
    wire [65:0] s3_1, c3_1, g3_1;

    assign s3_0 = s2_0  ^ c2_0  ^ s2_1;
    assign g3_0 = (s2_0 & c2_0) | (c2_0 & s2_1) | (s2_0 & s2_1);
    assign c3_0 = {g3_0[64:0], 1'b0};

    assign s3_1 = c2_1  ^ s2_2  ^ c2_2;
    assign g3_1 = (c2_1 & s2_2) | (s2_2 & c2_2) | (c2_1 & c2_2);
    assign c3_1 = {g3_1[64:0], 1'b0};


    wire [65:0] s4_0, c4_0, g4_0;
    wire [65:0] s4_1, c4_1, g4_1;

    assign s4_0 = s3_0  ^ c3_0  ^ s3_1;
    assign g4_0 = (s3_0 & c3_0) | (c3_0 & s3_1) | (s3_0 & s3_1);
    assign c4_0 = {g4_0[64:0], 1'b0};

    assign s4_1 = c3_1  ^ c1_4  ^ pp_s[15];
    assign g4_1 = (c3_1 & c1_4) | (c1_4 & pp_s[15]) | (c3_1 & pp_s[15]);
    assign c4_1 = {g4_1[64:0], 1'b0};


    wire [65:0] s5_0, c5_0, g5_0;

    assign s5_0 = s4_0  ^ c4_0  ^ s4_1;
    assign g5_0 = (s4_0 & c4_0) | (c4_0 & s4_1) | (s4_0 & s4_1);
    assign c5_0 = {g5_0[64:0], 1'b0};


    wire [65:0] final_s, final_c, g6_0;

    assign final_s = s5_0  ^ c5_0  ^ c4_1;
    assign g6_0    = (s5_0 & c5_0) | (c5_0 & c4_1) | (s5_0 & c4_1);
    assign final_c = {g6_0[64:0], 1'b0};

    wire [65:0] cpa_out;
    assign cpa_out = final_s + final_c;

    assign product = cpa_out[63:0];

endmodule