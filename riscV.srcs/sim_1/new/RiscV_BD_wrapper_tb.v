`timescale 1 ps / 1 ps

module RiscV_BD_wrapper_tb;

    // Inputs
    reg clk_0;
    reg reset_0;

    // Instantiate DUT
    RiscV_BD_wrapper uut (
        .clk_0      (clk_0),              
      
        .reset_0    (reset_0)
    );

    // Clock generation: 10 ps period
    initial clk_0 = 0;
    always #10000 clk_0 = ~clk_0;

    // Stimulus
    initial begin
        // Apply reset
        reset_0 = 1;

        #50000;

        // Release reset
        reset_0 = 0;

        // Run simulation for some time
        #2000000;

        $display("Simulation complete.");
        $finish;
    end

endmodule