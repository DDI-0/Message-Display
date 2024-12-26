
module max10_adc(		
	input logic pll_clk,
	input logic chsel,
	input logic soc,
	input logic tsen,
	output logic dout,
	output logic eoc,
	output logic clk_dft
);