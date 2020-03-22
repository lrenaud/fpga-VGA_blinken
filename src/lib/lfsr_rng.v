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


`define LFSR_WIDTH	64

module lfsr_rng(
	input CLK,
	output RND_BIT);

parameter	SEED='hACE1;

reg [(`LFSR_WIDTH-1):0] lfsr;
wire next_bit;


assign next_bit = ^{
/*	lfsr[0],
	lfsr[10],
	lfsr[12],
	lfsr[13],
	lfsr[15]
/**/ // 16
/*	lfsr[0],
	lfsr[2],
	lfsr[21],
	lfsr[31]
/**/ // 32
	lfsr[59],
	lfsr[60],
	lfsr[62],
	lfsr[63]
/**/ // 64
/*	lfsr[98],
	lfsr[100],
	lfsr[125],
	lfsr[127]
/**/ // 128
};
assign RND_BIT = lfsr[(`LFSR_WIDTH-1)];

initial begin
	lfsr <= SEED;
end

always @(posedge CLK)
begin
	lfsr <= {lfsr[(`LFSR_WIDTH-2):0], next_bit};
end

endmodule