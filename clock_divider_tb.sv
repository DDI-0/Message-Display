`timescale 1ns/1ps  // Define simulation time units

module clock_divider_tb;

    // Testbench Signals
    reg clk_in;
    reg reset;
    wire clk_out;

    // Instantiate the clock divider module
    clock_divider #(
        .f_input(100),  // 100 Hz input clock for quick simulation
        .f_output(1)    // 1 Hz desired output clock
    ) uut (
        .clk_in(clk_in),
        .reset(reset),
        .clk_out(clk_out)
    );

    // Generate input clock (100 Hz = 10 ms period)
    always begin
        #5 clk_in = ~clk_in;  // Toggle every 5 ns (100 Hz frequency)
    end

    // Testbench Procedure
    initial begin
        // Initialize signals
        clk_in = 0;
        reset = 0;

        // Apply reset
        $display("Applying reset...");
        reset = 1;
        #20;  // Hold reset for 20 ns
        reset = 0;
        $display("Reset released.");

        // Wait for some time to observe clk_out toggling
        $display("Observing output clock behavior...");
        #5000;  // Wait 5,000 ns (5 us) to observe clk_out changes

        // Finish simulation
        $display("Simulation complete.");
        $stop;
    end

endmodule