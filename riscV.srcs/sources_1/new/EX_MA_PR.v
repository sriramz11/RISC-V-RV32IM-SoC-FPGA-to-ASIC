module EX_MA_PR(
                input        clk, rst,
                input        reg_write_E,
                input [2:0]  load_src_E,
                input [2:0]  Result_src_E,
                input        mem_write_E,
                input        inst_retired_E,
                
                input   proces_req_E,
                input  peripheral_wen_E,
                input load_peripharal_E,
                
                input [31:0] ALU_result_E,
                input [31:0] write_data_E,
                input [4:0]  RD_E,
                input [31:0] Ex_Imm_E,
                input [31:0] PC_plus4_E,
                input [31:0] CSR_Rdata_E, 
                input       stall_E,
                
                
                output reg        reg_write_M,
                output reg [2:0]  Result_src_M,
                output reg        mem_write_M,
                output reg        inst_retired_M,
                output reg [2:0]  load_src_M,                
                output reg [31:0] ALU_result_M,
                output reg [31:0] write_data_M,
                output reg [4:0]  RD_M,
                output reg [31:0] Ex_Imm_M,
                output reg [31:0] PC_plus4_M,
                output reg [31:0] CSR_Rdata_M, 

                output reg    proces_req_M,
                output reg   peripheral_wen_M,
                output reg   load_peripharal_M
                );
    always @(posedge clk or posedge rst)
    begin 
        if(rst)
        begin
                load_src_M  <= 3'b0;
               reg_write_M  <= 1'b0;
            inst_retired_M  <= 1'b0;
              Result_src_M  <= 3'b0;
               mem_write_M  <= 1'b0;
              ALU_result_M  <= 32'b0;
              write_data_M  <= 32'b0;
                      RD_M  <= 5'b0;
                  Ex_Imm_M  <= 32'b0;
                PC_plus4_M  <= 32'b0;
               CSR_Rdata_M  <= 32'b0;
                proces_req_M <= 1'b0;
                peripheral_wen_M <= 1'b0;
                load_peripharal_M <= 1'b0;
        end
        else if (stall_E)
        begin
                load_src_M      <= load_src_M;  
                reg_write_M     <= reg_write_M;
                inst_retired_M  <=  inst_retired_M;
                Result_src_M    <=  Result_src_M;
                mem_write_M     <=  mem_write_M;
                ALU_result_M    <=  ALU_result_M;
                write_data_M    <=  write_data_M;
                RD_M            <=  RD_M;
                Ex_Imm_M        <=  Ex_Imm_M;
                PC_plus4_M      <=  PC_plus4_M;
                CSR_Rdata_M     <=  CSR_Rdata_M; 
                proces_req_M    <=  proces_req_M;
                peripheral_wen_M <=  peripheral_wen_M;
                load_peripharal_M <=  load_peripharal_M;  
        end

        else
        begin
               load_src_M  <=  load_src_E;  
              reg_write_M  <=  reg_write_E;  
           inst_retired_M  <=  inst_retired_E;  
             Result_src_M  <=  Result_src_E;  
              mem_write_M  <=  mem_write_E;  
             ALU_result_M  <=  ALU_result_E; 
             write_data_M  <=  write_data_E; 
                     RD_M  <=  RD_E;  
                 Ex_Imm_M  <=  Ex_Imm_E;  
               PC_plus4_M  <=  PC_plus4_E;  
              CSR_Rdata_M  <=  CSR_Rdata_E;  
                proces_req_M    <=  proces_req_E;
                peripheral_wen_M <=  peripheral_wen_E;
                load_peripharal_M <=  load_peripharal_E;

        end
    end               

endmodule