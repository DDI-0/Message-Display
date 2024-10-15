module TopLevel(
    input wire clk_in,       // 50 MHz input clock
    input wire reset,        // Reset signal (shared)
    input wire [3:0] addr,   // Address to read a character from ROM (MessageStorage)
    output wire [7:0] hex_top   // Final 8-bit hex output
);

    // Internal signals
    wire [7:0] char_out_top;  // ASCII character output from MessageStorage
    wire clk_out_top;             // 1 Hz clock output from clock divider

    // Instantiate Clock Divider (50 MHz to 1 Hz)
    clock_divider clk_div (
        .clk_in(clk_in),      // 50 MHz input clock
        .reset(reset),        // Reset signal
        .clk_out(clk_out_top)     // 1 Hz clock output
    );

    // Instantiate MessageStorage
    MessageStorage msg_storage (
        .addr(addr),          // Address input from TopLevel
        .reset(reset),        // Reset input
        .char_out(char_out_top) // ASCII output to ASCIIDecoder
    );

    // Instantiate ASCIIDecoder
    ASCIIDecoder decoder (
        .ASCIIc(char_out_top),  // ASCII input from MessageStorage
        .reset(reset),          // Reset input
        .hex_converter(hex_top)     // Hexadecimal output
    );

endmodule
