`timescale 1ns / 1ps  // Set time units and precision

module messagestorage_tb;  // Testbench has no ports

    // Testbench signals
    reg [3:0] addr;          // 4-bit address to test different ROM locations
    reg reset;               // Reset signal (not used, but declared for completeness)
    wire [7:0] display;      // Output wire to observe ROM data

    // Instantiate the messagestorage module
    messagestorage uut (
        .addr(addr),
        .reset(reset),
        .display(display)
    );

    // Simulation process
    initial begin
        // Initialize input signals
        reset = 0;  // Not used, but let's keep it consistent
        addr  = 4'b0000;

        // Wait 10 ns, then display the value at each address sequentially
        $display("Starting ROM test...");

        // Test all 16 ROM addresses
        repeat (16) begin
            #10;  // Wait 10 ns for each address change
            $display("Addr: %d -> Display: %h (%c)", addr, display, display);
            addr = addr + 1;
        end

        // Finish simulation
        #10;
        $display("Test completed.");
        $finish;
    end

endmodule
