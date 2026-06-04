module  alu_fixed_point_mux (
    input wire fixed_pmux_E,
    input wire [31:0]alu_output,
    input wire [31:0] fixed_point_output,
    output wire [31:0] final_output
);

assign final_output = fixed_pmux_E ? fixed_point_output : alu_output;

endmodule