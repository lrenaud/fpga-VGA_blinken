module ssd_decode_hex (
	input [3:0] value,
	output a,
	output b,
	output c,
	output d,
	output e,
	output f,
	output g //
);

	//wire a, b, c, d, e, f, g;

	reg [6:0] SSD;
	assign {a,b,c,d,e,f,g} = SSD;
	
	always @(*) begin
		case (value)
			4'h0: SSD = 7'h7E;
			4'h1: SSD = 7'h30;
			4'h2: SSD = 7'h6D;
			4'h3: SSD = 7'h79;
			4'h4: SSD = 7'h33;
			4'h5: SSD = 7'h5B;
			4'h6: SSD = 7'h5F;
			4'h7: SSD = 7'h70;
			4'h8: SSD = 7'h7F;
			4'h9: SSD = 7'h7B;
			4'hA: SSD = 7'h77;
			4'hB: SSD = 7'h1F;
			4'hC: SSD = 7'h4E;
			4'hD: SSD = 7'h3D;
			4'hE: SSD = 7'h4F;
			4'hF: SSD = 7'h47;
		endcase
	end

endmodule