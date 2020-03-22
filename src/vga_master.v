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
`include "lib/clk_div.v"


`define vga_720p
//`define vga_480p
//`define vga_1366x768
`include "lib/vga_timing.v"
`include "lib/vga_clkGen.v"
`include "lib/vga_sync.v"
`include "lib/vga_window.v"


////////////////////////////////////////////////////////////
module blinken(
    output [7:0] LED,
    input [7:0] SW,
    input EXT_CLK,
    output [3:0] SSD_AN,
    output [6:0] ssd_seg,
    output SSD_DP,
	
	output [2:0] vgaRed,
	output [2:0] vgaGreen,
	output [1:0] vgaBlue,
	output Hsync,
	output Vsync);
////////////////////////////////////////////////////////////
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

wire EXT_CLK_BUF;
wire clk_khz;
wire clk_sec;
wire clk_10sec;

clk_div #(
		.bit_width(16),
		.half_period(25_000)
	) Ucdv_khz (
	.in(EXT_CLK_BUF),
	.out(clk_khz)
);

clk_div #(
		.bit_width(12),
		.half_period(200)
	) Ucdv_hz (
	.in(clk_khz),
	.out(clk_sec)
);

clk_div #(
		.bit_width(12),
		.half_period(5000)
	) Ucdv_10s (
	.in(clk_khz),
	.out(clk_10sec)
);

wire [7:0] color_byte_raw;
reg [7:0] color_byte;

genvar i;
generate
	for (i = 0; i < 8; i=i+1) begin: rngBlockGen
	lfsr_rng #(.SEED(64'h1CA1_E070_10B4_0AD5 >> i)) UrngCol_gen(
		.CLK(clk_sec),
		.RND_BIT(color_byte_raw[i])
		);
	end
endgenerate

always @(posedge Vsync) begin
	color_byte <= color_byte_raw;
end

////////////////////////////////////////////////////////////

wire pixel_clk;
wire reset_clock;

assign reset_clock = 0;

vga_clkGen UvgaClkMaster (
    .CLKIN_IN(EXT_CLK),
    .RST_IN(reset_clock),
    .CLKFX_OUT(pixel_clk),
    .CLKIN_IBUFG_OUT(EXT_CLK_BUF)
//    .CLK0_OUT(pixel_clk)
);

wire vga_hot;
wire [2:0] RNG;
wire [12:0] locX;
wire [12:0] locY;

wire in_box;

vga_sync UsyncBlock(
	.PIXEL_CLK(pixel_clk),
	.locX(locX),
	.locY(locY),
	.in_image(vga_hot),
	.sync_h(Hsync),
	.sync_v(Vsync));


lfsr_rng #(.SEED(64'h1CA1_E070_10B4_0AD5)) UrngRed(
	.CLK(pixel_clk),
	.RND_BIT(RNG[0])
	);
lfsr_rng #(.SEED(64'h2E0F_9BAD_0A3C_3CC3)) UrngGrn(
	.CLK(pixel_clk),
	.RND_BIT(RNG[1])
	);
lfsr_rng #(.SEED(64'hDCC1_DE7C_865D_8AF3)) UrngBlue(
	.CLK(pixel_clk),
	.RND_BIT(RNG[2])
	);

vga_window #(	.x_hi(`VGA_RES_H-50),	.x_lo(50),
				.y_hi(`VGA_RES_V-100),		.y_lo(100)
	) UmiddleBoxCheck (
		.X(locX),
		.Y(locY),
		.in_window(in_box)
	);

reg [2:0] px_r;
reg [2:0] px_g;
reg [1:0] px_b;

assign vgaRed = px_r;
assign vgaGreen = px_g;
assign vgaBlue = px_b;

always @(posedge pixel_clk)
begin
	if (~vga_hot) begin
		px_r <= 3'b000;
		px_g <= 3'b000;
		px_b <= 2'b00;
	end else if (in_box) begin
		px_r <= color_byte[2:0];
		px_g <= color_byte[5:3];
		px_b <= color_byte[7:6];
	end else begin
		px_r <= {3{RNG[0]}};
		px_g <= {3{RNG[1]}};
		px_b <= {2{RNG[2]}};
	end
end

//assign vgaGreen =	3{vga_hot}}		& {3{RNG[1]}};
//assign vgaBlue =	{2{vga_hot}}	& {2{RNG[2]}};
//assign vgaGreen = {3{vga_hot}}	& locX[4:2];
//assign vgaBlue =	{2{vga_hot}}	& locY[4:3];

////////////////////////////////////////////////////////////


endmodule
