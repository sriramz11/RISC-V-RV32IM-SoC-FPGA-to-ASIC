//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Mon Apr 20 14:35:25 2026
//Host        : Jaswanth_K running 64-bit major release  (build 9200)
//Command     : generate_target RiscV_BD_wrapper.bd
//Design      : RiscV_BD_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module RiscV_BD_wrapper
   (clk_0,
    gpio_pins_0,
    reset_0,
    spi_mosi_0,
    spi_sclk_0,
    spi_ss_n_0);
  input clk_0;
  inout [15:0]gpio_pins_0;
  input reset_0;
  output spi_mosi_0;
  output spi_sclk_0;
  output spi_ss_n_0;

  wire clk_0;
  wire [15:0]gpio_pins_0;
  wire reset_0;
  wire spi_mosi_0;
  wire spi_sclk_0;
  wire spi_ss_n_0;

  RiscV_BD RiscV_BD_i
       (.clk_0(clk_0),
        .gpio_pins_0(gpio_pins_0),
        .reset_0(reset_0),
        .spi_mosi_0(spi_mosi_0),
        .spi_sclk_0(spi_sclk_0),
        .spi_ss_n_0(spi_ss_n_0));
endmodule
