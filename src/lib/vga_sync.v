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
`include "lib/vga_timing.v"

module vga_sync(
	input PIXEL_CLK,
	output [12:0] locX,
	output [12:0] locY,
	output in_image,
	output in_image_x,
	output in_image_y,
	output sync_h,
	output sync_v);

reg [(`VGA_CNTR_BIT_WIDTH-1):0] cntX_px;
reg [(`VGA_CNTR_BIT_WIDTH-1):0] cntY_px;

assign locX = cntX_px;
assign locY = cntY_px;

wire vga_hot;
wire vga_hot_x;
wire vga_hot_y;

assign in_image = vga_hot;
assign in_image_y = vga_hot_y;
assign in_image_x = vga_hot_x;

always @(posedge PIXEL_CLK)
begin
	cntX_px <= cntX_px + 1;
	if (cntX_px >= `VGA_MAX_H) begin
		cntX_px <= 0;
		cntY_px <= cntY_px + 1;
		if (cntY_px >= `VGA_MAX_V) begin
			cntY_px <= 0;
		end
	end
end

assign vga_hot_x = (cntX_px < `VGA_RES_H);
assign vga_hot_y = (cntY_px < `VGA_RES_V);
assign vga_hot = vga_hot_x & vga_hot_y;

assign sync_h = (cntX_px > `VGA_SYNC_START_H) & (cntX_px < `VGA_SYNC_STOP_H);
assign sync_v = (cntY_px > `VGA_SYNC_START_V) & (cntY_px < `VGA_SYNC_STOP_V);

endmodule