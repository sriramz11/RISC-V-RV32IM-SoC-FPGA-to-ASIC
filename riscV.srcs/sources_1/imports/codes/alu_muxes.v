module alu_muxes (

    // control inputs
    input  wire mux1_sel,
    input  wire mux2_sel,
    input  wire alu_mux_sel,
    input  wire condition_mux_sel,
    input  wire branch_mux_sel,

    // mux override inputs
    input  wire mux1_in,
    input  wire mux2_in,
    input  wire [3:0] alu_mux_in,
    input  wire condition,
    input  wire branch_E,

    // normal control signals
    input  wire [1:0] ALUSrc,
    input  wire [3:0] ALUOpCtrl,


    // datapath inputs
    input  wire [31:0] pc_Plus_4,
    input  wire [31:0] immediate,
    input  wire [31:0] rs1,
    input  wire [31:0] rs2,



    output wire [31:0] alu_input_1,
    output wire [31:0] alu_input_2,
    output wire [3:0] alu_op,
    output wire condition_out,
    output wire alu_branch

  
    );

  wire alu_in_1_mux_sel;
  wire alu_in_2_mux_sel;


assign alu_in_1_mux_sel = mux1_sel ? mux1_in : ALUSrc[1];
assign alu_in_2_mux_sel = mux2_sel ? mux2_in : ALUSrc[0];

assign alu_input_1 = alu_in_1_mux_sel ? pc_Plus_4 : rs1;
assign alu_input_2 = alu_in_2_mux_sel ? immediate : rs2;

assign alu_op = alu_mux_sel ? alu_mux_in : ALUOpCtrl;
assign condition_out = condition_mux_sel ? 1'b1 : condition;

assign alu_branch = branch_mux_sel ? 1'b0 : branch_E;


endmodule