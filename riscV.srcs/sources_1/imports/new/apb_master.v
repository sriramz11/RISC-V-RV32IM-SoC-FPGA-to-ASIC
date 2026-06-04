`timescale 1ns / 1ps
//=============================================================================
// Module   : apb_master
// Purpose  : Bridges processor interface to APB bus (3-state FSM)
// States   : IDLE -> SETUP -> ACCESS -> IDLE
//=============================================================================
module apb_master #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  wire                  clk,
    input  wire                  rst,      

    // Processor Interface
    input  wire [ADDR_WIDTH-1:0] proc_addr,
    input  wire [DATA_WIDTH-1:0] proc_wdata,
    input  wire                  proc_wr_en,
    input  wire                  proc_req,
    output wire [DATA_WIDTH-1:0] proc_rdata,
    output wire                  proc_ack,

    // APB Bus Interface
    output wire [ADDR_WIDTH-1:0] apb_addr,
    output wire [DATA_WIDTH-1:0] apb_wdata,
    output wire                  apb_write,
    output wire                  apb_sel,
    output wire                  apb_enable,
    input  wire [DATA_WIDTH-1:0] apb_rdata,
    input  wire                  apb_ready
);

    localparam IDLE   = 2'b00;
    localparam SETUP  = 2'b01;
    localparam ACCESS = 2'b10;

    reg [1:0]            state, next_state;
    reg [ADDR_WIDTH-1:0] addr_reg;
    reg [DATA_WIDTH-1:0] wdata_reg;
    reg                  wr_en_reg;

    // -------------------------------------------------------------------------
    // Output assignments
    // -------------------------------------------------------------------------
    assign apb_addr   = addr_reg;
    assign apb_wdata  = wdata_reg;
    assign apb_write  = wr_en_reg;
    assign apb_sel    = (state == SETUP || state == ACCESS);
    assign apb_enable = (state == ACCESS);

    // proc_ack is combinatorial: valid only in ACCESS when slave is ready
    assign proc_ack   = (state == ACCESS) && apb_ready;
    assign proc_rdata = ((state == ACCESS) && apb_ready && !wr_en_reg)
                        ? apb_rdata : {DATA_WIDTH{1'b0}};

    // -------------------------------------------------------------------------
    // Sequential state register + address capture
    // -------------------------------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= IDLE;
            addr_reg  <= {ADDR_WIDTH{1'b0}};
            wdata_reg <= {DATA_WIDTH{1'b0}};
            wr_en_reg <= 1'b0;
        end else begin
            state <= next_state;
            // Capture processor signals at the start of a transaction (IDLE->SETUP)
            if (state == IDLE && proc_req) begin
                addr_reg  <= proc_addr;
                wdata_reg <= proc_wdata;
                wr_en_reg <= proc_wr_en;
            end
        end
    end

    // -------------------------------------------------------------------------
    // Next-state logic (combinatorial)
    // -------------------------------------------------------------------------
    always @(*) begin
        next_state = state;
        case (state)
            IDLE   : if (proc_req)  next_state = SETUP;
            SETUP  :                next_state = ACCESS;
            ACCESS : if (apb_ready) next_state = IDLE;
            default:                next_state = IDLE;
        endcase
    end

endmodule