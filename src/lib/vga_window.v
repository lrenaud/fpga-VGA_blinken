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
// Description: Verify that the current pixel location is
//				bounded by the regions set in the parameter
//				and generate an "active" signal based upon
//				that bounding.
//				ALSO! Generate a "in border" signal for
//				assisting in drawing borders around boxes.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
////////////////////////////////////////////////////////////
`include "lib/vga_timing.v"

module vga_window(
		input [(`VGA_CNTR_BIT_WIDTH-1):0] X,
		input [(`VGA_CNTR_BIT_WIDTH-1):0] Y,
		output in_window,
		output on_border);

parameter x_hi	= `VGA_RES_H;
parameter x_lo	= 0;
parameter y_hi	= `VGA_RES_V;
parameter y_lo	= 0;

wire x_in;
wire y_in;

assign x_in = (X >= x_lo) && (X < x_hi);
assign y_in = (Y >= y_lo) && (Y < y_hi);
assign in_window = x_in & y_in;

assign on_border = 
	(x_lo == X) || 
	(x_hi == X) || 
	(y_lo == Y) || 
	(y_hi == Y);


endmodule