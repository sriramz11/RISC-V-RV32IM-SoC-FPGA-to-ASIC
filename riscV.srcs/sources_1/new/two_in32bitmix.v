`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2026 18:05:38
// Design Name: 
// Module Name: two_in32bitmix
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


module two_in32bitmix(
input [31:0]in1,in2,
input sel,
output [31:0] result
    );
    
 assign result=sel?in1:in2;
    
    
    
    
endmodule
