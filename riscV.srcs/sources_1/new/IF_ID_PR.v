`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2026 21:55:05
// Design Name: 
// Module Name: IF_ID_PR
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
module IF_ID_PR(
                input clk, rst,
                input       [31:0]   PC_F,
                input       [31:0]   Inst_F,
                input       [31:0]   PC_plus4_F,
                input                stall_F, flush_F,
                
                
                
                
                output  reg [6:0]    opcode,
                output  reg [2:0]    funct3_D,
                output  reg [6:0]    funct7_D,
//                output  reg [31:0]   Inst_D,
                output  reg [4:0]    Rs1_D,
                output  reg [4:0]    Rs2_D,
                output  reg [31:0]   PC_D,
                output  reg [4:0]    Rd_D,
                output  reg [24:0]   Imm_D,
                output  reg [31:0]   PC_plus4_D,
                output  reg [11:0]   csr_add_D
                );

    always @(posedge clk or posedge rst)
        begin
            if(rst || flush_F)
            begin
                PC_D       <= 32'b0;
                PC_plus4_D <= 32'b0;
//                Inst_D     <= 32'b0;
                Rs1_D      <= 5'b0;
                Rs2_D      <= 5'b0;
                Rd_D       <= 5'b0;
                Imm_D      <= 25'b0;
                opcode     <= 7'b0000000;
                funct3_D   <= 3'b0;
                funct7_D   <= 7'b0;
                csr_add_D  <= 12'b0;
            end
            else if(!stall_F)
            begin
                PC_D       <= PC_F;
                PC_plus4_D <= PC_plus4_F;
//                Inst_D     <= Inst_F;
                Rs1_D      <= Inst_F[19:15];
                Rs2_D      <= Inst_F[24:20];
                Rd_D       <= Inst_F[11:7];
                Imm_D      <= Inst_F[31:7];
                opcode     <= Inst_F[6:0];
                funct3_D   <= Inst_F[14:12];
                funct7_D   <= Inst_F[31:25];
                csr_add_D  <= Inst_F[31:20];
            end
        end

endmodule