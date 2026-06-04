module forwarding_mux (
    input wire [1:0] Hazard_mux_sel_1,
    input wire [1:0] Hazard_mux_sel_2,
    input wire [31:0] rs1_E,
    input wire [31:0] rs_M,
    input wire [31:0] rs_W,
    input wire [31:0] rs2_E,
    output reg [31:0] rs1,
    output reg [31:0] rs2
);

  always@(*) begin
    case (Hazard_mux_sel_1)
        2'b00: rs1 = rs1_E;
        2'b01: rs1 = rs_M;
        2'b10: rs1 = rs_W;
        default: rs1 = rs1_E; // Default to rs1_E if no match
    endcase

    case (Hazard_mux_sel_2)
        2'b00: rs2 = rs2_E;
        2'b01: rs2 = rs_M;
        2'b10: rs2 = rs_W;
        default: rs2 = rs2_E; // Default to rs2_E if no match
    endcase
  end

endmodule