`timescale 1ns / 1ps
//=============================================================================
// Module   : spi_apb_master_tx
// Purpose  : SPI Master (Mode 0: CPOL=0 CPHA=0) driven via APB.
//            Write-only from APB perspective; no rdata returned to bus.
//
// Register Map (apb_addr[5:2]):
//   4'd0  CTRL   – Write any value to trigger transfer (uses last TXDATA)
//   4'd1  TXDATA – 8-bit TX data register  [7:0]
//   (Status register removed from APB – busy is internal only)
//
// Changes from original:
//   + apb_sel input added (guards writes to SETUP phase accesses)
//   - apb_rdata output removed (SPI is write-only from APB perspective)
//=============================================================================
module spi_apb_master_tx #(
    parameter CLK_DIV = 4   // SPI clock = sys_clk / (2 * CLK_DIV)
)(
    input  wire        clk,
    input  wire        rst,       // Active-LOW reset

    // APB Slave Interface (write-only)
    input  wire [31:0] apb_addr,
    input  wire [31:0] apb_wdata,
    input  wire        apb_write,
    input  wire        apb_sel,     // Added: gates writes to ACCESS phase only
    input  wire        apb_enable,
    output wire        apb_ready,   // Always 1 (single-cycle accept)

    // SPI Physical Interface (Mode 0)
    output reg         sclk,
    output reg         mosi,
    output reg         ss_n,
    output reg spi_ready
);

    // apb_ready is always 1; SPI accepts writes immediately
    assign apb_ready = 1'b1;

    // -------------------------------------------------------------------------
    // APB Write registers
    // -------------------------------------------------------------------------
    reg [7:0] tx_reg;      // Data to be shifted out
    reg       start_req;   // Pulse: request a new SPI transfer
    reg       busy;        // 1 while a transfer is in progress

    // Write is valid in ACCESS phase: sel & enable & write
    wire apb_wr_valid = apb_sel&& apb_enable &&apb_write;

    always @(posedge clk or  posedge rst) begin
        if (rst) begin
            tx_reg    <= 8'h00;
            start_req <= 1'b0;
        end else begin
            if (apb_wr_valid) begin
                case (apb_addr[11:8])
                  
                    4'b0001:begin
                               tx_reg    <= apb_wdata[7:0];
                               start_req <=1'b1;
                               spi_ready<= 1; end 
                                 // TXDATA
                    default: ;
                endcase
            end else if (busy) begin
                start_req <= 1'b0;   // Clear start after transfer begins
            end
        end
    end

    // -------------------------------------------------------------------------
    // SPI Clock generation (enabled only during transfer)
    // -------------------------------------------------------------------------
    reg [7:0] clk_cnt;
    reg       spi_clk_en;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_cnt <= 8'd0;
            sclk    <= 1'b0;
        end else if (spi_clk_en) begin
            if (clk_cnt == CLK_DIV - 1) begin
                clk_cnt <= 8'd0;
                sclk    <= ~sclk;
            end else begin
                clk_cnt <= clk_cnt + 1'b1;
            end
        end else begin
            clk_cnt <= 8'd0;
            sclk    <= 1'b0;
        end
    end

    // -------------------------------------------------------------------------
    // SCLK edge detection (falling edge -> shift MOSI; slave samples on rise)
    // -------------------------------------------------------------------------
    reg  sclk_d;
    wire sclk_fall;

    always @(posedge clk or posedge rst) begin
        if (rst) sclk_d <= 1'b0;
        else        sclk_d <= sclk;
    end

    assign sclk_fall = sclk_d & ~sclk;

    // -------------------------------------------------------------------------
    // SPI Transfer FSM
    // -------------------------------------------------------------------------
    localparam IDLE     = 1'b0,
               TRANSFER = 1'b1;

    reg       state;
    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;

    always @(posedge clk or posedge  rst) begin
        if (rst) begin
            state      <= IDLE;
            ss_n       <= 1'b1;
            busy       <= 1'b0;
            spi_clk_en <= 1'b0;
            mosi       <= 1'b0;
            bit_cnt    <= 3'd0;
            shift_reg  <= 8'd0;
        end else begin
            case (state)

                IDLE: begin
                    ss_n       <= 1'b1;
                    busy       <= 1'b0;
                    spi_clk_en <= 1'b0;

                    if (start_req) begin
                        // Pre-shift: MSB goes onto MOSI immediately, rest into shift_reg
                        mosi       <= tx_reg[7];
                        shift_reg  <= {tx_reg[6:0], 1'b0};
                        bit_cnt    <= 3'd7;
                        ss_n       <= 1'b0;
                        busy       <= 1'b1;
                        spi_clk_en <= 1'b1;
                        state      <= TRANSFER;
                    end
                end

                TRANSFER: begin
                    if (sclk_fall) begin
                        if (bit_cnt == 3'd0) begin
                            // Last bit done – de-assert chip select and clock
                            spi_clk_en <= 1'b0;
                            ss_n       <= 1'b1;
                            mosi       <= 1'b0;
                            state      <= IDLE;
                          
                        end else begin
                            // Drive next bit; slave samples on rising edge
                            mosi      <= shift_reg[7];
                            shift_reg <= {shift_reg[6:0], 1'b0};
                            bit_cnt   <= bit_cnt - 1'b1;
                        end
                    end
                end

            endcase
        end
    end

endmodule