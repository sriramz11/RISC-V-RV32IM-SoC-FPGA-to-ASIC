`timescale 1ns / 1ps
//=============================================================================
// Module   : apb_slave_decoder
// Purpose  : Decodes APB address and routes to GPIO or SPI peripheral.
//            SPI is write-only; its rdata is NOT returned to the master.
//
// Address Map (bits [11:8]):
//   0x0___ (4'h0)  ->  GPIO  (0x0000_0000 – 0x0000_00FF)
//   0x1___ (4'h1)  ->  SPI   (0x0000_0100 – 0x0000_01FF)
//=============================================================================
module apb_slave_decoder #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  wire                  clk,


    // From APB Master
    input  wire [ADDR_WIDTH-1:0] apb_addr,
    input  wire [DATA_WIDTH-1:0] apb_wdata,
    input  wire                  apb_write,
    input  wire                  apb_sel,
    input  wire                  apb_enable,
    output wire [DATA_WIDTH-1:0] apb_rdata,
    output wire                  apb_ready,

    // ---- GPIO Slave ----
    output wire                  gpio_sel,
    output wire [ADDR_WIDTH-1:0] gpio_addr,
    output wire [DATA_WIDTH-1:0] gpio_wdata,
    output wire                  gpio_write,
    output wire                  gpio_enable,
    input  wire [DATA_WIDTH-1:0] gpio_rdata,   // GPIO read-back to master
    input  wire                  gpio_ready,

    // ---- SPI Slave (write-only; no rdata path) ----
    output wire                  spi_sel,
    output wire [ADDR_WIDTH-1:0] spi_addr,
    output wire [DATA_WIDTH-1:0] spi_wdata,
    output wire                  spi_write,
    output wire                  spi_enable,
    input  wire                  spi_ready     // Still needed for APB handshake
);

    // -------------------------------------------------------------------------
    // Address decode (bits [11:8])
    // -------------------------------------------------------------------------
    wire is_gpio = (apb_addr[11:8] == 4'h0);   // 0x000 – 0x0FF
    wire is_spi  = (apb_addr[11:8] == 4'h1);   // 0x100 – 0x1FF

    // -------------------------------------------------------------------------
    // GPIO Isolation
    // -------------------------------------------------------------------------
    assign gpio_sel    = apb_sel    && is_gpio;
    assign gpio_enable = apb_enable && is_gpio;
    assign gpio_write  = apb_write  && is_gpio;
    assign gpio_addr   = is_gpio ? apb_addr  : {ADDR_WIDTH{1'b0}};
    assign gpio_wdata  = is_gpio ? apb_wdata : {DATA_WIDTH{1'b0}};

    // -------------------------------------------------------------------------
    // SPI Isolation
    // -------------------------------------------------------------------------
    assign spi_sel     = apb_sel    && is_spi;
    assign spi_enable  = apb_enable && is_spi;
    assign spi_write   = apb_write  && is_spi;
    assign spi_addr    = is_spi  ? apb_addr  : {ADDR_WIDTH{1'b0}};
    assign spi_wdata   = is_spi  ? apb_wdata : {DATA_WIDTH{1'b0}};

    // -------------------------------------------------------------------------
    // Read-data mux  (SPI has no read-back; only GPIO rdata is returned)
    // -------------------------------------------------------------------------
    assign apb_rdata = is_gpio ? gpio_rdata : {DATA_WIDTH{1'b0}};

    // -------------------------------------------------------------------------
    // Ready mux – default 1'b1 to prevent bus hang on invalid address
    // -------------------------------------------------------------------------
    wire invalid_addr = apb_sel && !(is_gpio || is_spi);

    assign apb_ready = is_gpio      ? gpio_ready :
                       is_spi       ? spi_ready  :
                       invalid_addr ? 1'b1       : 1'b1;

endmodule