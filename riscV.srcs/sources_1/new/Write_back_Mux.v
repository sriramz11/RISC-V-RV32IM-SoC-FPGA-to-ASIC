`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 22:29:49
// Design Name: 
// Module Name: Write_back_Mux
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


module Write_back_Mux(
    input [31:0] Alu_result_W,
    input [31:0] Read_data_W,
    input [31:0] Ex_Imm_W,
    input [31:0] PC_plus4_W,
    input [31:0] CSR_rdata_W,
    output reg [31:0] W_data,
    input [2:0] result_src_W
    );
    always @*
    begin
        case(result_src_W)
            3'b000: W_data = Alu_result_W;
            3'b001: W_data = Read_data_W;
            3'b010: W_data = Ex_Imm_W;
            3'b011: W_data = PC_plus4_W;
            3'b100: W_data = CSR_rdata_W;
            default: W_data = Alu_result_W;
        endcase    
    end
    
    
endmodule
