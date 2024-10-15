// message storage(rom)
module MessageStorage(
    input [3:0] addr,       // 4-bit address 
    input wire reset,
    output reg [7:0] char_out  // 8-bit ASCII character output
);

    reg [7:0] message[15:0];  // 16x8 ROM to store the message 

    initial begin  // Initialize the array with the message
        message[0] = 8'h27; // '
        message[1] = 8'h27; // '
        message[2] = 8'h20; // space
        message[3] = 8'h48; // H
        message[4] = 8'h45; // E
        message[5] = 8'h4C; // L
        message[6] = 8'h4C; // L
        message[7] = 8'h4F; // O
        message[8] = 8'h20; // space
        message[9] = 8'h43; // C
        message[10] = 8'h4C; // L
        message[11] = 8'h49; // I
        message[12] = 8'h50; // P
        message[13] = 8'h2E; // .
        message[14] = 8'h27; // '
        message[15] = 8'h27; // '
    end

    always @(*) begin
        char_out = message[addr];  // Output the ASCII character at the given address
    end

endmodule
