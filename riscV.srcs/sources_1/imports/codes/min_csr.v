
module csr (
    
    input  wire        clk,
    input  wire        rst,          

    
    input  wire [11:0] csr_addr,       
    input  wire [1:0]  csr_op,         
    input  wire        csr_wen,        
    input  wire [31:0] rs1_data,       

    input  wire        instr_retired,   
    input  wire        csr_exc,        
    input  wire [31:0] pc_current,     

    
    output reg  [31:0] csr_rdata,      

    
    output wire [31:0] mtvec_out,      
    output wire [31:0] mepc_out,       

    
    output wire        mstatus_mie     
);


    localparam CSR_MSTATUS  = 12'h300;
    localparam CSR_MTVEC    = 12'h305;
    localparam CSR_MEPC     = 12'h341;
    localparam CSR_MCYCLE   = 12'hC00;
    localparam CSR_MINSTRET = 12'hC02;


    reg [31:0] mcycle;      
    reg [31:0] minstret;    
    reg [31:0] mstatus;     
    reg [31:0] mtvec;       
    reg [31:0] mepc;        


    always @(*) begin
        case (csr_addr)
            CSR_MCYCLE  : csr_rdata = mcycle;
            CSR_MINSTRET: csr_rdata = minstret;  
            CSR_MSTATUS : csr_rdata = mstatus;  
            CSR_MTVEC   : csr_rdata = mtvec; 
            CSR_MEPC    : csr_rdata = mepc;
            default     : csr_rdata = 32'b0;  
        endcase
    end

    reg [31:0] csr_wdata;   

    always @(*) begin
        case (csr_op)
            2'b00:   csr_wdata = rs1_data;                // CSRRW
            2'b01:   csr_wdata = csr_rdata | rs1_data;    // CSRRS
            2'b10:   csr_wdata = csr_rdata & ~rs1_data;   // CSRRC
            default: csr_wdata = csr_rdata;               // No-op fallback
        endcase
    end


    always @(posedge clk) begin

    
        if (rst) begin
            mcycle   <= 32'b0;
            minstret <= 32'b0;
            mstatus  <= 32'b0;
            mtvec    <= 32'b0;
            mepc     <= 32'b0;

        end
        
        else if (csr_exc) begin //If both csr_wen and csr_exc are asserted simultaneously , csr_exc wins due to else if ordering.
            mepc              <= pc_current;
            mstatus[7]        <= mstatus[3];  // MPIE = old MIE
            mstatus[3]        <= 1'b0;        // MIE = 0 (disable interrupts)
            mcycle            <= mcycle + 1;  // cycle counter keeps running
    

        end 
        
        else if (csr_wen) begin
            case (csr_addr)
                CSR_MSTATUS: mstatus <= csr_wdata;
                CSR_MTVEC  : mtvec   <= csr_wdata;
                CSR_MEPC   : mepc    <= csr_wdata;
                default    : ;  // All other addresses: do nothing
            endcase
            mcycle   <= mcycle + 1;   // cycle counter still ticks
            minstret <= minstret + 1; // CSR instruction itself also retires

        end 
        
        else begin
            mcycle   <= mcycle + 1;
            if (instr_retired) 
            minstret <= minstret + 1;
        end

    end 


    assign mtvec_out    = mtvec;
    assign mepc_out     = mepc;
    assign mstatus_mie  = mstatus[3];  // MIE bit

endmodule
