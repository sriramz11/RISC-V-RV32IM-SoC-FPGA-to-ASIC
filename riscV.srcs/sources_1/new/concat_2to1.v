module concat_2to1 (
    input  wire       in0,
    input  wire       in1,
    output wire [1:0] conct_out
);

    // Concatenate in1 (MSB) and in0 (LSB) to form a 2-bit output
    assign conct_out = {in1, in0};

endmodule








