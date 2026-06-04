`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2026 15:02:09
// Design Name: 
// Module Name: pc
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
module pc(
    input clk, reset,
    input stall,                  // Stall signal: holds PC when high
    input [31:0] pc_alu,
    input [31:0] pc_mtvec,
    input [31:0] pc_mepc,
    input [1:0] pc_mux_sel,
    output [31:0] pc_inc,
    //output  [31:0] pc_mem,
    output reg [31:0] pc_f
    );
    
    
reg [31:0]pc_p;
    always@(*) begin
//    if (reset)
//            pc_p <= 32'd0;            
//    else
//    begin
        case(pc_mux_sel)
            2'b00: pc_p = pc_inc;
            2'b01: pc_p = pc_alu;
            2'b10: pc_p = pc_mtvec;
            2'b11: pc_p = pc_mepc;
            default: pc_p = pc_inc;
        endcase
//    end
    end
    
    assign pc_inc = pc_f + 32'd4;
    //assign pc_mem = pc_p;
    //assign pc_mem = pc_f[9:2];


    always@(posedge clk) begin
        if (reset)
            pc_f <= 32'd0;
        else if (!stall)          // Only update PC when not stalled
            pc_f <= pc_p;
        else if(stall)
            pc_f <= pc_f;
            
        // If stall is high, pc_f retains its current value implicitly
    end
    
endmodule