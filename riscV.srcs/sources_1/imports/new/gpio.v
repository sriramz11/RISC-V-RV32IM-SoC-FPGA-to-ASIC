/*
`timescale 1ns / 1ps
//=============================================================================
// Module   : gpio_updated
// Purpose  : General-Purpose I/O peripheral with interrupt support.
//            Pins reduced to 16 bits to satisfy Xilinx Vivado IO placement.
//
// Register Map (via APB):
//   0x00  gpio_data        - Output data register
//   0x04  gpio_dir         - Direction (1=output, 0=input) per bit
//   0x08  gpio_int_polarity- Interrupt polarity (1=fall, 0=rise) per bit
//   0x0C  gpio_int_mask    - Interrupt mask (1=enabled) per bit
//   0x10  gpio_int_enable  - Global interrupt enable (bit 0)
//   0x14  pins_r           - Sampled pin state (read-only)
//   0x18  gpio_int_status  - Interrupt status; write 1 to clear per bit
//
// Note: wdata/rdata are 32-bit for APB compatibility;
//       upper 16 bits are ignored on write / zero on read.
//=============================================================================
module gpio_updated (
    input  wire        clk,
    input  wire        reset,      // Active-HIGH reset (inverted from rst_n at top)

    // APB Slave interface (mapped by decoder)
    input  wire [31:0] wdata,
    input  wire [31:0] addr,
    input  wire        hwen,        // Write enable  (gpio_write from decoder)
    input  wire        gpio_enable, // APB ENABLE phase
    input  wire        gpio_select, // APB SEL signal

    output wire        gpio_ready,  // Always 1 (single-cycle peripheral)
    output reg  [31:0] rdata,       // Read-data back to APB master

    // Physical IO (16-bit to stay within FPGA IO bank limits)
    inout  wire [15:0] pins,

    // Interrupt output (leave unconnected at top; user routes as needed)
    output wire        interrupt
);

    // -------------------------------------------------------------------------
    // Internal registers (16-bit wide for pin-related, 1-bit for global enable)
    // -------------------------------------------------------------------------
    reg [15:0] gpio_data;          // Output data
    reg [15:0] gpio_dir;           // Direction: 1=output, 0=input
    reg [15:0] gpio_int_polarity;  // 1=falling-edge detect, 0=rising-edge detect
    reg [15:0] gpio_int_mask;      // 1=interrupt for this pin is enabled
    reg        gpio_int_enable;    // Global interrupt enable
    reg [15:0] gpio_int_status;    // Interrupt status flags
    reg [15:0] pins_r;             // Previous (registered) polarity-adjusted pin values

    // -------------------------------------------------------------------------
    // Derived wires
    // -------------------------------------------------------------------------
    wire [15:0] pol_pins;          // Polarity-adjusted pin values
    wire [15:0] rising_edge_det;   // Rising edge on pol_pins (after polarity flip)
    wire [15:0] mask_int;          // Masked pending interrupts
    wire        write_clear;       // Pulse: write to status-clear register
    wire [15:0] clear_mask;        // Bits to clear in int_status

    // -------------------------------------------------------------------------
    // Tri-state IO buffers (per-bit)
    // -------------------------------------------------------------------------
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : gpio_tristate
            assign pins[i] = gpio_dir[i] ? gpio_data[i] : 1'bz;
        end
    endgenerate

    // -------------------------------------------------------------------------
    // Interrupt edge detection
    // Polarity register flips the sense: pol_pins = pins XOR polarity
    //   polarity[i]=0 -> rising  edge on real pin triggers interrupt
    //   polarity[i]=1 -> falling edge on real pin triggers interrupt
    // -------------------------------------------------------------------------
    assign pol_pins        = pins ^ gpio_int_polarity;
    assign rising_edge_det = ~pins_r & pol_pins;   // Detected edge (post-polarity)
    assign mask_int        = rising_edge_det & gpio_int_mask;

    // -------------------------------------------------------------------------
    // Latch polarity-adjusted pins each cycle for edge detection
    // -------------------------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset)
            pins_r <= 16'b0;
        else
            pins_r <= pol_pins;
    end

    // -------------------------------------------------------------------------
    // Interrupt status register
    //   Set  : on any masked edge event
    //   Clear: write 1 to bit in register 0x18
    // -------------------------------------------------------------------------
    assign write_clear = hwen && gpio_enable && gpio_select && (addr == 32'h0000_0018);
    assign clear_mask  = write_clear ? wdata[15:0] : 16'b0;

    always @(posedge clk or posedge reset) begin
        if (reset)
            gpio_int_status <= 16'b0;
        else
            gpio_int_status <= (gpio_int_status | mask_int) & ~clear_mask;
    end

    // -------------------------------------------------------------------------
    // APB Write – configuration registers
    // -------------------------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            gpio_data        <= 16'b0;
            gpio_dir         <= 16'b0;
            gpio_int_polarity<= 16'b0;
            gpio_int_mask    <= 16'b0;
            gpio_int_enable  <= 1'b0;
        end else if (hwen && gpio_enable && gpio_select) begin
            case (addr)
                32'h0000_0000: gpio_data         <= wdata[15:0];
                32'h0000_0004: gpio_dir          <= wdata[15:0];
                32'h0000_0008: gpio_int_polarity <= wdata[15:0];
                32'h0000_000C: gpio_int_mask     <= wdata[15:0];
                32'h0000_0010: gpio_int_enable   <= wdata[0];
                // 0x14 read-only (pins_r), 0x18 handled by clear logic
                default: ;
            endcase
        end
    end

    // -------------------------------------------------------------------------
    // APB Read (combinatorial)
    // Active only when not writing (hwen=0) and peripheral is selected/enabled
    // -------------------------------------------------------------------------
    always @(*) begin
        if (~hwen && gpio_enable && gpio_select) begin
            case (addr)
                32'h0000_0000: rdata = {16'b0, gpio_data};
                32'h0000_0004: rdata = {16'b0, gpio_dir};
                32'h0000_0008: rdata = {16'b0, gpio_int_polarity};
                32'h0000_000C: rdata = {16'b0, gpio_int_mask};
                32'h0000_0010: rdata = {31'b0, gpio_int_enable};
                32'h0000_0014: rdata = {16'b0, pins_r};
                32'h0000_0018: rdata = {16'b0, gpio_int_status};
                default:       rdata = 32'b0;
            endcase
        end else begin
            rdata = 32'b0;
        end
    end

    // -------------------------------------------------------------------------
    // Interrupt output
    // -------------------------------------------------------------------------
    assign interrupt  = gpio_int_enable & (|gpio_int_status);

    // Always-ready: GPIO is single-cycle combinatorial read / registered write
    assign gpio_ready = 1'b1;

endmodule
*/



`timescale 1ns / 1ps
//=============================================================================
// Module   : gpio_updated
// Purpose  : 16-bit GPIO peripheral with interrupt support.
//
// Synthesis notes:
//   (* keep = "true" *)       – Vivado keeps the full register array intact
//                               instead of splitting into unrelated single-bit
//                               logic cells. Post-implementation waveform then
//                               shows coherent bus values, not individual bits.
//   (* dont_touch = "true" *) – Prevents aggressive logic removal on the module.
//
// Register Map (APB byte address via gpio_addr):
//   0x00  gpio_data[15:0]         – Output data
//   0x04  gpio_dir[15:0]          – Direction (1=output, 0=input)
//   0x08  gpio_int_polarity[15:0] – Interrupt polarity (1=falling, 0=rising)
//   0x0C  gpio_int_mask[15:0]     – Interrupt mask (1=enabled per bit)
//   0x10  gpio_int_enable         – Global interrupt enable [bit 0]
//   0x14  pins_r[15:0]            – Sampled pin state (read-only)
//   0x18  gpio_int_status[15:0]   – Interrupt status; write-1-to-clear
//=============================================================================
(* dont_touch = "true" *)
module gpio_updated (
    input  wire        clk,
    input  wire        reset,        // Active-HIGH (inverted from rst_n at top)

    // APB Slave signals from apb_slave_decoder
    input  wire [31:0] wdata,
    input  wire [31:0] addr,
    input  wire        hwen,          // Write enable = gpio_write
    input  wire        gpio_enable,   // APB ENABLE phase
    input  wire        gpio_select,   // APB SEL signal

    output wire        gpio_ready,    // Always 1 – single-cycle peripheral
    output reg  [31:0] rdata,         // Read-data returned to master

    // 16-bit physical IO (keeps total board IO within Vivado placement limits)
    inout  wire [15:0] pins,

    // Interrupt – routed at top level where needed
    output wire        interrupt
);

    // =========================================================================
    // Configuration registers
    // (* keep = "true" *) prevents synthesis from splitting the array into
    // individual unconnected FF instances that appear as "single logic" in the
    // post-implementation waveform viewer.
    // =========================================================================
    (* keep = "true" *) reg [15:0] gpio_data;
    (* keep = "true" *) reg [15:0] gpio_dir;
    (* keep = "true" *) reg [15:0] gpio_int_polarity;
    (* keep = "true" *) reg [15:0] gpio_int_mask;
    (* keep = "true" *) reg        gpio_int_enable;
    (* keep = "true" *) reg [15:0] gpio_int_status;
    (* keep = "true" *) reg [15:0] pins_r;

    // =========================================================================
    // Tri-state IO buffers (one IOBUF primitive per pin)
    // =========================================================================
    genvar gi;
    generate
        for (gi = 0; gi < 16; gi = gi + 1) begin : gpio_tristate
            assign pins[gi] = gpio_dir[gi] ? gpio_data[gi] : 1'bz;
        end
    endgenerate

    // =========================================================================
    // Interrupt edge detection
    //   pol_pins        = pins XOR polarity  (normalise: rising = trigger sense)
    //   rising_edge_det = ~pins_r & pol_pins (detect 0->1 after normalisation)
    //   mask_int        = events that pass through the interrupt mask
    // =========================================================================
    (* keep = "true" *) wire [15:0] pol_pins;
    (* keep = "true" *) wire [15:0] rising_edge_det;
    (* keep = "true" *) wire [15:0] mask_int;

    assign pol_pins        = pins ^ gpio_int_polarity;
    assign rising_edge_det = ~pins_r & pol_pins;
    assign mask_int        = rising_edge_det & gpio_int_mask;

    // =========================================================================
    // Polarity-adjusted pin sampling (provides previous cycle value for edge det)
    // =========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset)
            pins_r <= 16'b0;
        else
            pins_r <= pol_pins;
    end

    // =========================================================================
    // Interrupt status register
    //   Set  : any masked edge event
    //   Clear: processor writes 1 to the bit at address 0x18
    // =========================================================================
    (* keep = "true" *) wire        write_clear;
    (* keep = "true" *) wire [15:0] clear_mask;

    assign write_clear = hwen & gpio_enable & gpio_select & (addr == 32'h0000_0018);
    assign clear_mask  = write_clear ? wdata[15:0] : 16'b0;

    always @(posedge clk or posedge reset) begin
        if (reset)
            gpio_int_status <= 16'b0;
        else
            gpio_int_status <= (gpio_int_status | mask_int) & ~clear_mask;
    end

    // =========================================================================
    // APB Write – configuration registers (clocked, write during ACCESS phase)
    // =========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            gpio_data         <= 16'b0;
            gpio_dir          <= 16'b0;
            gpio_int_polarity <= 16'b0;
            gpio_int_mask     <= 16'b0;
            gpio_int_enable   <= 1'b0;
        end else if (hwen && gpio_enable && gpio_select) begin
            case (addr)
                32'h0000_0000: gpio_data         <= wdata[15:0];
                32'h0000_0004: gpio_dir          <= wdata[15:0];
                32'h0000_0008: gpio_int_polarity <= wdata[15:0];
                32'h0000_000C: gpio_int_mask     <= wdata[15:0];
                32'h0000_0010: gpio_int_enable   <= wdata[0];
                // 0x14 pins_r read-only; 0x18 handled by clear logic
                default: ;
            endcase
        end
    end

    // =========================================================================
    // APB Read (fully combinatorial – no registered read-data path needed
    // because gpio_ready = 1 permanently)
    // =========================================================================
    always @(*) begin
        if (~hwen && gpio_enable && gpio_select) begin
            case (addr)
                32'h0000_0000: rdata = {16'b0, gpio_data};
                32'h0000_0004: rdata = {16'b0, gpio_dir};
                32'h0000_0008: rdata = {16'b0, gpio_int_polarity};
                32'h0000_000C: rdata = {16'b0, gpio_int_mask};
                32'h0000_0010: rdata = {31'b0, gpio_int_enable};
                32'h0000_0014: rdata = {16'b0, pins_r};
                32'h0000_0018: rdata = {16'b0, gpio_int_status};
                default:       rdata = 32'b0;
            endcase
        end else begin
            rdata = 32'b0;
        end
    end

    // =========================================================================
    // Interrupt output and ready
    // =========================================================================
    assign interrupt  = gpio_int_enable & (|gpio_int_status);
    assign gpio_ready = 1'b1;

endmodule