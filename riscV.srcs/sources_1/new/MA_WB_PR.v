module MA_WB_PR(
                input clk,rst,
                input Reg_write_M,
                input [2:0]result_src_M,
                input inst_retired_M,
               
                input [31:0]alu_result_M,
                input [31:0]read_data_M,
                input [4:0] RD_M,
                input [31:0]Ex_imm_M,
                input [31:0] PC_plus4_M,
                input [31:0] CSR_Rdata_M,
                input stall_M,
                
                output reg         Reg_write_W,
                output reg [2:0]  result_src_W,
                output reg       inst_retired_W,
                
                output reg [31:0] alu_result_W,
                output reg [31:0]  read_data_W,
                output reg [4:0]          RD_W,
                output reg [31:0]     Ex_imm_W,
                output reg [31:0]   PC_plus4_W,
                output reg [31:0]  CSR_Rdata_W
                );
    always @(posedge clk )
    begin 
        if(rst)
        begin
              Reg_write_W <= 1'b0;
           inst_retired_W <= 1'b0;
             result_src_W <= 3'b0;
             alu_result_W <= 32'b0;
              read_data_W <= 32'b0;
                     RD_W <= 5'b0;
                 Ex_imm_W <= 32'b0;
               PC_plus4_W <= 32'b0;
              CSR_Rdata_W <= 32'b0; 
        end
        else if (stall_M) begin
                Reg_write_W    <= Reg_write_W;
                inst_retired_W <= inst_retired_W;
                result_src_W   <= result_src_W;
                alu_result_W   <= alu_result_W;
                read_data_W    <= read_data_W;
                RD_W           <= RD_W;
                Ex_imm_W       <= Ex_imm_W;
                PC_plus4_W     <= PC_plus4_W;
                CSR_Rdata_W    <= CSR_Rdata_W;
            
        end
        else
        begin
              Reg_write_W <= Reg_write_M;
           inst_retired_W <= inst_retired_M;
             result_src_W <= result_src_M;
             alu_result_W <= alu_result_M;
              read_data_W <= read_data_M;
                     RD_W <= RD_M;
                 Ex_imm_W <= Ex_imm_M;
               PC_plus4_W <= PC_plus4_M;
              CSR_Rdata_W <= CSR_Rdata_M;
        end 
    end
endmodule