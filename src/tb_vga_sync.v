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
// Revision: ~
// Revision 0.01 - File Created
// Additional Comments: 
//
////////////////////////////////////////////////////////////
`define vga_480p
`include "lib/vga_timing.v"
`include "lib/vga_sync.v"

module tb_vga_sync;

reg px_clk;

wire [12:0] X;
wire [12:0] Y;
wire in_frame;
wire sync_h;
wire sync_v;

vga_sync Uut(
	.PIXEL_CLK(px_clk),
	.locX(X),
	.locY(Y),
	.in_image(in_frame),
	.sync_h(sync_h),
	.sync_v(sync_v)
);

initial begin
	#10
	repeat (2*`VGA_MAX_V*`VGA_MAX_H) @(posedge px_clk);

	$finish;
end

always #5 px_clk = (px_clk === 1'b0);

endmodule