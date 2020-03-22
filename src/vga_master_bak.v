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
`include "lib/ssd_decode_hex.v"
`define vga_1080p
`include "lib/vga_timing.v"

module blinken(
    output [7:0] LED,
    input [7:0] SW,
    input CLK,
    output [3:0] SSD_AN,
    output [6:0] ssd_seg,
    output SSD_DP,
	
	output [3:1] vgaRed,
	output [3:1] vgaGreen,
	output [3:2] vgaBlue,
	output Hsync,
	output Vsync);

wire [7:0] LED_MASK;
wire [6:0] ssd_seg_an;




assign LED_MASK  = 8'hA5;
assign LED = LED_MASK ^ SW;

assign SSD_AN = 4'b1011;
assign SSD_DP = 1'h0;

assign ssd_seg = ~ssd_seg_an;

ssd_decode_hex Ussd1(
	.value(SW[3:0]),
	.a(ssd_seg_an[0]),
	.b(ssd_seg_an[1]),
	.c(ssd_seg_an[2]),
	.d(ssd_seg_an[3]),
	.e(ssd_seg_an[4]),
	.f(ssd_seg_an[5]),
	.g(ssd_seg_an[6])
);

////////////////////////////////////////////////////////////

wire PIXEL_CLK;
wire RST_IN;

assign RST_IN = 0;

clkGen UxilinxClkDiv (
    .CLKIN_IN(CLK),
    .RST_IN(RST_IN),
    .CLKFX_OUT(PIXEL_CLK)
//    .CLKIN_IBUFG_OUT(CLKIN_IBUFG_OUT),
//    .CLK0_OUT(PIXEL_CLK)
);

reg [12:0] cntX_px;
reg [12:0] cntY_px;

wire vga_hot;
wire vga_hot_x;
wire vga_hot_y;
assign vgaRed = 3'b101 & vga_hot;
assign vgaGreen = 3'b001 & vga_hot;
assign vgaBlue = 3'b01 & vga_hot;

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

assign vga_hot_x = (cntX_px > `VGA_RES_H);
assign vga_hot_y = (cntY_px > `VGA_RES_V);
assign vga_hot = vga_hot_x & vga_hot_y;

assign Hsync = (cntX_px > `VGA_SYNC_START_H) & (cntX_px < `VGA_SYNC_STOP_H);
assign Vsync = (cntY_px > `VGA_SYNC_START_V) & (cntY_px < `VGA_SYNC_STOP_V);

////////////////////////////////////////////////////////////




endmodule
