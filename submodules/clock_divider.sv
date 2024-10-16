module clock_divider(
	 input wire clk_in,    // 50 MHz input clock
	 input wire reset,     // Reset signal (active low)
	 output reg clk_out    // 1 Hz clock output for LED
);
	 // Parameters for input and output frequencies
	 parameter integer f_input = 50000000;  // 50 MHz
	 parameter integer f_output = 1;        // 1 Hz

	 // Calculate the number of cycles needed to toggle the output clock
	 localparam integer toggle = f_input / (2 * f_output);  // 25,000,000 cycles

	 // 26-bit counter to track input clock cycles
	 reg [25:0] counter = 0;

	 // Always block to handle clock division and reset logic
always @(posedge clk_in or negedge reset) begin
 if (!reset) begin  // Reset is synchronized with clk_in
	  counter <= 0;
	  clk_out <= 0;
 end else if (counter == toggle - 1) begin
	  clk_out <= ~clk_out;
	  counter <= 0;
 end else begin
	  counter <= counter + 1;
 end
end

endmodule