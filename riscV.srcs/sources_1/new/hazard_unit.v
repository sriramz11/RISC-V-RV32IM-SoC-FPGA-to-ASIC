`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2026 09:37:50
// Design Name: 
// Module Name: foward
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


module hazard_unit(
input [4:0]rdmem,rs1ex,rs2ex,rdwb,rdex,rs1id,rs2id,
input memtoreg,condition_stall,jump_branch_flush,mul_stall,processor_request, processor_wen, peripheral_load,proc_ack,
output  reg mem_sel_s1,mem_sel_s2,wb_sel_s1,wb_sel_s2,stall_pc,stall_ifid,flushe,flushd,stall_idex,stall_exmem,stall_memwb
    );
    
   always@(*) begin
                            stall_pc   = 0;
                            stall_ifid = 0;
                            stall_idex = 0;
                            stall_exmem= 0;
                            stall_memwb= 0;
                            flushe     = 0;
                            mem_sel_s1 = 0;
                            mem_sel_s2 = 0;
                            wb_sel_s1  = 0;
                            wb_sel_s2  = 0;
                            flushd     = 0;
                            
                                     
                                      
      if (rdmem == rs1ex && rdmem != 0)
           mem_sel_s1 = 1;
        else if (rdwb == rs1ex && rdwb != 0)
            wb_sel_s1 = 1;            
                         if ((rdmem == rs2ex) && (rdmem != 0))
                               mem_sel_s2 = 1;
                         else if ((rdwb == rs2ex) && (rdwb != 0))
                                   wb_sel_s2 = 1;              
                                     
        
     //for the load instruction
        
        if(memtoreg && rdex!=0)
        
         begin 
                if(rdex==rs1id || rdex==rs2id)begin
                        stall_pc=1;
                        stall_ifid=1;
                        flushe=1;
                        end
                        
             end      
             
   
   //for branch instruction for 2 cycle branch 1 for checking condition and the other for 
   //calculating the address
   
   
   if(condition_stall) begin
                        stall_pc=1;
                        stall_ifid=1;
                        stall_idex=1; end
                        
    if(jump_branch_flush) begin
                       flushe=1;
                       flushd=1; end                    
        // for multiplier we need to stall
        
     if(mul_stall)  begin
                        stall_pc=1;
                        stall_ifid=1;
                        stall_idex=1;
                        stall_exmem = 1;
                        stall_memwb =1; 
                        end
              
   if(processor_request && peripheral_load && !proc_ack) begin
                        stall_pc=1;
                        stall_ifid=1;
                        stall_idex=1;
                        stall_exmem = 1;
                        stall_memwb =1; 
                        end
                        
    if(processor_request && !peripheral_load && !proc_ack) begin
                        stall_pc=1;
                        stall_ifid=1;
                        stall_idex=1;
                        stall_exmem = 1;
                        end
  end

    
endmodule