module register_file (
    // ── Clock 
    input  wire        clk,
    input  wire        syn_rst,

    // ── Read Port 1 
    input  wire [4:0]  rs1,          
    output wire [31:0] rd_data1,     

    // ── Read Port 2 
    input  wire [4:0]  rs2,          
    output wire [31:0] rd_data2,     

    // ── Write Port 
    input  wire [4:0]  rd,          
    input  wire [31:0] wr_data,     
    input  wire        reg_write     
);
integer i;
    // 32 registers, each 32 bits wide
    reg [31:0] registers [0:31];

    
    always @(negedge clk) begin
        if (syn_rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end 
        else if (reg_write && (rd != 5'b00000)) begin   // x0 is hardwired to 0; writes to it are ignored
            registers[rd] <= wr_data;
        end
    end

    assign rd_data1 = (rs1 == 5'b00000) ? 32'b0 : registers[rs1];
    assign rd_data2 = (rs2 == 5'b00000) ? 32'b0 : registers[rs2];

endmodule