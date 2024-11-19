module converter (
    input logic [7:0] ascii_in,   // ASCII input character (binary format)
    output logic [6:0] seg_out   // 7-segment display output (A-G)
);

    always_comb begin
        case (ascii_in)
            // Letters
				8'b01001000: seg_out = 7'b0001001; // 'H' 
				8'b01000101: seg_out = 7'b0000110; // 'E'
				8'b01001100: seg_out = 7'b1000111; // 'L' 
				8'b01001111: seg_out = 7'b1000000; // 'O' 
				// Numbers
				8'b00110001: seg_out = 7'b1111001; // '1' 
				8'b00110010: seg_out = 7'b0100100; // '2' 
				8'b00110011: seg_out = 7'b0110000; // '3' 
				8'b00110100: seg_out = 7'b0011001; // '4' 
            // Space
            8'b00100000: seg_out = 7'b1111111; // ' ' (blank)

            // Default (unknown character)
            default: seg_out = 7'b111111; // All segments off
        endcase
    end
endmodule
