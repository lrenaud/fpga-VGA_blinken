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
`include "lib/lfsr_rng.v"

//`define vga_720p
//`define vga_480p
//`define vga_1366x768

`include "lib/vga_timing.v"
`include "lib/vga_clkGen.v"
`include "lib/vga_sync.v"

module blinken(
    output [7:0] LED,
    input [7:0] SW,
    input CLK,
    output [3:0] SSD_AN,
    output [6:0] ssd_seg,
    output SSD_DP,
	
	output [2:0] vgaRed,
	output [2:0] vgaGreen,
	output [1:0] vgaBlue,
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

vga_clkGen UvgaClkMaster (
    .CLKIN_IN(CLK),
    .RST_IN(RST_IN),
    .CLKFX_OUT(PIXEL_CLK)
//    .CLKIN_IBUFG_OUT(CLKIN_IBUFG_OUT),
//    .CLK0_OUT(PIXEL_CLK)
);

wire vga_hot;
wire [2:0] RNG;
wire [12:0] locX;
wire [12:0] locY;

vga_sync UsyncBlock(
	.PIXEL_CLK(PIXEL_CLK),
	.locX(locX),
	.locY(locY),
	.in_image(vga_hot),
	.sync_h(Hsync),
	.sync_v(Vsync));


lfsr_rng UrngRed(
	.CLK(PIXEL_CLK),
	.RND_BIT(RNG[0])
	);
lfsr_rng UrngGrn(
	.CLK(PIXEL_CLK),
	.RND_BIT(RNG[1])
	);
lfsr_rng UrngBlue(
	.CLK(PIXEL_CLK),
	.RND_BIT(RNG[2])
	);


assign vgaRed =		3'b111	& {3{RNG[0]}};
assign vgaGreen =	3'b111	& {3{RNG[0]}};
assign vgaBlue =	2'b111	& {2{RNG[0]}};
//assign vgaGreen =	3{vga_hot}}		& {3{RNG[1]}};
//assign vgaBlue =	{2{vga_hot}}	& {2{RNG[2]}};
//assign vgaGreen = {3{vga_hot}}	& locX[4:2];
//assign vgaBlue =	{2{vga_hot}}	& locY[4:3];

////////////////////////////////////////////////////////////


endmodule
