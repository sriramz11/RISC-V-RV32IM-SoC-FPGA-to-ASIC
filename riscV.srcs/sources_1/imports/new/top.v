`timescale 1ns / 1ps
//=============================================================================
// Module   : apb_soc_top
// Purpose  : Top-level integration of:
//              • apb_master        (processor ? APB bus)
//              • apb_slave_decoder (address decode + mux)
//              • gpio_updated      (16-bit GPIO peripheral)
//              • spi_apb_master_tx (SPI TX peripheral, write-only via APB)
//
// Reset    : Single active-LOW rst_n input.
//            GPIO module uses active-HIGH reset; inverted internally.
//
// Address Map:
//   0x0000_0000 – 0x0000_00FF  : GPIO
//   0x0000_0100 – 0x0000_01FF  : SPI
//=============================================================================
module apb_soc_top #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter SPI_CLK_DIV = 4       // SPI clock = sys_clk / (2 * SPI_CLK_DIV)
)(
    input  wire                  clk,
    input  wire                  rst,         // Active-LOW system reset

    // ---- Processor Interface ----
    input  wire [ADDR_WIDTH-1:0] proc_addr,
    input  wire [DATA_WIDTH-1:0] proc_wdata,
    input  wire                  proc_wr_en,
    input  wire                  proc_req,
    output wire [DATA_WIDTH-1:0] proc_rdata,
    output wire                  proc_ack,

    // ---- GPIO Physical IO (16-bit) ----
    inout  wire [15:0]           gpio_pins,
    output wire                  gpio_interrupt, // Route where needed in system

    // ---- SPI Physical IO ----
    output wire                  spi_sclk,
    output wire                  spi_mosi,
    output wire                  spi_ss_n
);


    // Internal APB Bus wires (Master <-> Decoder)
    wire [ADDR_WIDTH-1:0] apb_addr;
    wire [DATA_WIDTH-1:0] apb_wdata;
    wire                  apb_write;
    wire                  apb_sel;
    wire                  apb_enable;
    wire [DATA_WIDTH-1:0] apb_rdata;
    wire                  apb_ready;

    // GPIO Peripheral wires (Decoder <-> GPIO)
    wire                  gpio_sel;
    wire [ADDR_WIDTH-1:0] gpio_addr;
    wire [DATA_WIDTH-1:0] gpio_wdata;
    wire                  gpio_write;
    wire                  gpio_enable;
    wire [DATA_WIDTH-1:0] gpio_rdata;
    wire                  gpio_ready;

    // SPI Peripheral wires (Decoder <-> SPI)
    wire                  spi_sel;
    wire [ADDR_WIDTH-1:0] spi_addr;
    wire [DATA_WIDTH-1:0] spi_wdata;
    wire                  spi_write;
    wire                  spi_enable;
    wire                  spi_ready;

    // APB Master
    apb_master #(
        .ADDR_WIDTH (ADDR_WIDTH),
        .DATA_WIDTH (DATA_WIDTH)
    ) u_apb_master (
        .clk        (clk),
        .rst      (rst),
        .proc_addr  (proc_addr),
        .proc_wdata (proc_wdata),
        .proc_wr_en (proc_wr_en),
        .proc_req   (proc_req),
        .proc_rdata (proc_rdata),
        .proc_ack   (proc_ack),
        .apb_addr   (apb_addr),
        .apb_wdata  (apb_wdata),
        .apb_write  (apb_write),
        .apb_sel    (apb_sel),
        .apb_enable (apb_enable),
        .apb_rdata  (apb_rdata),
        .apb_ready  (apb_ready)
    );

    // APB Slave Decoder
    apb_slave_decoder #(
        .ADDR_WIDTH (ADDR_WIDTH),
        .DATA_WIDTH (DATA_WIDTH)
    ) u_apb_decoder (
        
        // From master
        .apb_addr    (apb_addr),
        .apb_wdata   (apb_wdata),
        .apb_write   (apb_write),
        .apb_sel     (apb_sel),
        .apb_enable  (apb_enable),
        // To master (read-data + ready mux)
        .apb_rdata   (apb_rdata),
        .apb_ready   (apb_ready),
        // GPIO signals
        .gpio_sel    (gpio_sel),
        .gpio_addr   (gpio_addr),
        .gpio_wdata  (gpio_wdata),
        .gpio_write  (gpio_write),
        .gpio_enable (gpio_enable),
        .gpio_rdata  (gpio_rdata),
        .gpio_ready  (gpio_ready),
        // SPI signals (write-only; no rdata)
        .spi_sel     (spi_sel),
        .spi_addr    (spi_addr),
        .spi_wdata   (spi_wdata),
        .spi_write   (spi_write),
        .spi_enable  (spi_enable),
        .spi_ready   (spi_ready)
    );

    // GPIO Peripheral
    gpio_updated u_gpio (
        .clk         (clk),
        .reset       (rst),   // Active-HIGH (inverted from rst_n)
        .wdata       (gpio_wdata),
        .addr        (gpio_addr),
        .hwen        (gpio_write),
        .gpio_enable (gpio_enable),
        .gpio_select (gpio_sel),
        .gpio_ready  (gpio_ready),
        .pins        (gpio_pins),
        .rdata       (gpio_rdata),
        .interrupt   (gpio_interrupt)
    );

    // SPI Peripheral
    spi_apb_master_tx #(
        .CLK_DIV    (SPI_CLK_DIV)
    ) u_spi (
        .clk        (clk),
        .rst      (rst),
        .apb_addr   (spi_addr),
        .apb_wdata  (spi_wdata),
        .apb_write  (spi_write),
        .apb_sel    (spi_sel),
        .apb_enable (spi_enable),
        .apb_ready  (spi_ready),
        .sclk       (spi_sclk),
        .mosi       (spi_mosi),
        .ss_n       (spi_ss_n)
    );

endmodule