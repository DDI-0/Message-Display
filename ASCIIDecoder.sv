module ASCIIDecoder(
	input[7:0] ASCIIc,
	input wire reset,
	output reg[7:0] hex
	
);
	
always @(*) begin
	case(ASCIIc)
	
		8'h27: hex = 8'b11011111; // "'" 
		8'h20: hex = 8'b11111111; // "space" 
		8'h48: hex = 8'b10001001; // "H" 
		8'h45: hex = 8'b10000110; // "E"
		8'h4C: hex = 8'b11000111; // "L"
		8'h4F: hex = 8'b11000000; // "O"
		8'h43: hex = 8'b11000110; // "C"
		8'h50: hex = 8'b10001101; // "P"
		8'h2E: hex = 8'b01111111; // "."
		8'h49: hex = 8'b11001111; // "I"
		
	default: hex = 8'b00000000; // everything is on
 endcase
end
endmodule 
