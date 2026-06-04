`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2026 14:41:27
// Design Name: 
// Module Name: ALU_OPER
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

module ALU_OPER(
    input                   clk,rst,
    input      signed[31:0] alu_in_1,
    input      signed[31:0] alu_in_2,
    input            [3:0] alu_oper,
    input                  branch_E,
    output reg signed[31:0] alu_out,
    output reg        branch_condi
    );
    
   
    
    parameter  ADD_BEQ   = 4'b0000;
    parameter  SUB_BNE   = 4'b0001;
    parameter  SLL_BLT   = 4'b0010;
    parameter  SLT_BGE   = 4'b0011;
    parameter  SLTU_BLTU = 4'b0100;
    parameter  XOR_BGEU  = 4'b0101;
    parameter  SRL       = 4'b0110;
    parameter  SRA       = 4'b0111;
    parameter  OR        = 4'b1000;
    parameter  AND       = 4'b1001;
    parameter  MUL       = 4'b1010;
    
    wire SLT_RES;
    wire SLTU_RES;
    wire [63:0]Mul_product;
    mul_top Mul(
                .clk(clk),
                .rst(rst),
                .Rs1(alu_in_1),
                .Rs2(alu_in_2),
                .product(Mul_product)
                );
     
    assign SLTU_RES = $unsigned(alu_in_1) < $unsigned(alu_in_2);
    assign SLT_RES  = alu_in_1[31] ^ alu_in_2[31] ? alu_in_1[31] : SLTU_RES;

    always @*
    begin
        alu_out      = 32'b0;
        branch_condi = 1'b0;
        if(branch_E == 1'b1)
        begin
            case(alu_oper[3:0])
               ADD_BEQ   : branch_condi = (alu_in_1 == alu_in_2)? 1 : 0;
               SUB_BNE   : branch_condi = (alu_in_1 != alu_in_2)? 1 : 0;
               SLL_BLT   : branch_condi = (alu_in_1 <  alu_in_2)? 1 : 0;
               SLT_BGE   : branch_condi = (alu_in_1 >= alu_in_2)? 1 : 0;
               SLTU_BLTU : branch_condi = ($unsigned(alu_in_1) <  $unsigned(alu_in_2));
               XOR_BGEU  : branch_condi = ($unsigned(alu_in_1) >= $unsigned(alu_in_2));
               default   : branch_condi = 1'b0;
            endcase
         end
         else if(branch_E == 1'b0)
         begin
            case(alu_oper[3:0])
                ADD_BEQ       : alu_out = alu_in_1 + alu_in_2;           
                SUB_BNE       : alu_out = alu_in_1 + ~alu_in_2 + 1'b1;   
                SLL_BLT       : alu_out = alu_in_1 << alu_in_2[4:0];     
                SLT_BGE       : alu_out = {31'b0,SLT_RES};               
                SLTU_BLTU     : alu_out = {31'b0,SLTU_RES};              
                XOR_BGEU      : alu_out = alu_in_1 ^ alu_in_2;           
                SRL           : alu_out = alu_in_1 >> alu_in_2[4:0];     
                SRA           : alu_out = alu_in_1 >>> alu_in_2[4:0];    
                OR            : alu_out = alu_in_1 | alu_in_2;           
                AND           : alu_out = alu_in_1 & alu_in_2;
                MUL           : alu_out = Mul_product[31:0];           
                default       : alu_out = 32'b0;                 
            endcase                
         end      
        end  
endmodule