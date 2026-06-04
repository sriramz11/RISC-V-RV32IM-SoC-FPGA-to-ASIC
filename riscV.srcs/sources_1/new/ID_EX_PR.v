module ID_EX_PR(
                input clk, rst, 
                input           Reg_write_D,
                input [2:0]     Result_src_D,
                input           mem_write_D,
                input           jump_D,
                input           branch_D,
                input [3:0]     alu_op_ctrl_D,
                input [1:0]     alu_src_D,
                input           inst_retired_D,
                input           fix_P_mux_D,
                input [2:0]     load_src_D,                
                
                input [31:0]    PC_D, 
                input [4:0]    RS1_D,
                input [4:0]    RS2_D,               
                input [31:0]    RD1_D,
                input [31:0]    RD2_D,               
                input [4:0]     RD_D,                
                input [31:0]    Ex_Imm_D, 
                input [31:0]    PC_plus4_D,               
                input [31:0]    CSR_Rdata_D,                
                input stall_D, flush_D,
                input mem2reg_D,
                
                
                input processer_req_D,
                input load_peripharal_D,
                input peripheral_wen_D,
                
                output reg processer_req_E,
                output reg load_peripheral_E,
                output reg peripheral_wen_E,
                     
                      
                output reg          Reg_write_E, 
                output reg  [2:0]   Result_src_E,
                output reg          mem_write_E,       
                output reg          jump_E,            
                output reg          branch_E,
                output reg   [3:0]  alu_op_ctrl_E,     
                output reg   [1:0]  alu_src_E,          
                output reg          inst_retired_E,                
                output reg          fix_P_mux_E,
                output reg  [2:0]   load_src_E,
                
                output reg  [31:0]  PC_E,
                output reg  [4:0]  RS1_E,      
                output reg  [4:0]  RS2_E,          
                output reg  [31:0]  RD1_E,      
                output reg  [31:0]  RD2_E,      
                output reg  [4:0]   RD_E,        
                       
                output reg  [31:0]  Ex_Imm_E,   
                output reg  [31:0]  PC_plus4_E, 
                output reg  [31:0]  CSR_Rdata_E,
                output reg mem2reg_E              
                );
                
    always @(posedge clk or posedge rst)
    begin
        if(rst || flush_D)
        begin
                load_src_E  <= 3'b0;
               fix_P_mux_E  <= 1'b0;
               Reg_write_E  <= 1'b0;
                    jump_E  <= 1'b0;
                  branch_E  <= 1'b0;
            inst_retired_E  <= 1'b0;
              Result_src_E  <= 3'b0;
               mem_write_E  <= 1'b0;
             alu_op_ctrl_E  <= 4'b0;
                 alu_src_E  <= 2'b0;
                     RS1_E  <= 5'b0;
                     RS2_E  <= 5'b0;
                     RD1_E  <= 32'b0;
                     RD2_E  <= 32'b0;
                      RD_E  <= 5'b0;
                      PC_E  <= 32'b0;
                  Ex_Imm_E  <= 32'b0;
                PC_plus4_E  <= 32'b0;
               CSR_Rdata_E  <= 32'b0;
                 mem2reg_E  <= 1'b0; 
                 processer_req_E <= 1'b0;
                 load_peripheral_E <= 1'b0;
                 peripheral_wen_E <= 1'b0;        
        end
        else if(!stall_D)
        begin
                load_src_E  <=  load_src_D;     
               Reg_write_E  <=  Reg_write_D;     
                    jump_E  <=  jump_D;          
                  branch_E  <=  branch_D; 
             fix_P_mux_E  <=  fix_P_mux_D;
             inst_retired_E  <=  inst_retired_D;  
              Result_src_E  <=  Result_src_D;   
               mem_write_E  <=  mem_write_D;     
             alu_op_ctrl_E  <=  alu_op_ctrl_D;   
                 alu_src_E  <=  alu_src_D;
                     RS1_E  <=  RS1_D;
                     RS2_E  <=  RS2_D;       
                     RD1_E  <=  RD1_D;           
                     RD2_E  <=  RD2_D;           
                      RD_E  <=  RD_D;            
                      PC_E  <=  PC_D;            
                  Ex_Imm_E  <=  Ex_Imm_D;        
                PC_plus4_E  <=  PC_plus4_D;      
               CSR_Rdata_E  <=  CSR_Rdata_D;
                  mem2reg_E <=  mem2reg_D;
                  processer_req_E <=  processer_req_D;
                  load_peripheral_E <=  load_peripharal_D;
                  peripheral_wen_E <=  peripheral_wen_D;

        end
    end

endmodule