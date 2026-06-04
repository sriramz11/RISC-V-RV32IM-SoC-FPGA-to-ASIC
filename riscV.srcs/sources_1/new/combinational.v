`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2026 16:18:28
// Design Name: 
// Module Name: combinational
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


module combinational(
                     input  wire condition_out,    // AND gate input 1
                     input  wire Branch_E,    // AND gate input 2
                     input  wire flush_allow,   // Tri-state buffer enable
                     input  wire jump_E,    // OR gate second input (inverted)
                     output wire pc_mux_sel0    // Final output from OR gate
                     );
                     
        wire and_out;
        wire tri_out;
        assign and_out = condition_out & Branch_E;
        assign tri_out = flush_allow ? and_out : 1'b0;
        assign pc_mux_sel0 = jump_E | tri_out;    
endmodule
