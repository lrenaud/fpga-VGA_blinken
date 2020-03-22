`timescale 1ns / 1ps
`default_nettype none
////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:18 02/29/2020 
// Design Name: 
// Module Name:    blinken 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
////////////////////////////////////////////////////////////

module clk_div(
	input in,
	output out);

parameter bit_width = 24;
parameter half_period = 25_000;

reg clk_state;
reg [(bit_width-1):0] count;

assign out = clk_state;

initial begin
	clk_state <= 1'b0;
	count <= 'b0;
end

always @(posedge in) begin
	count <= count + 1'b1;
	if (count >= half_period) begin
		count <= 0;
		clk_state <= ~clk_state;
	end
end

endmodule