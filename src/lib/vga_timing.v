////////////////////////////////////////////////////////////
// Top level VGA timing define tool. `include this bugger to
// get the timings for various display resolutions provided.
// Should make it a bit easier for me to screw with display
// resolution changes at a later date.
/////


`ifndef __VGA_TIMES_SET_H
	`define VGA_CNTR_BIT_WIDTH	13

    `ifdef vga_480p
        `define __VGA_TIMES_SET_H
        `define VGA_PX_CLK      30_090_000
        `define VGA_RES_H       853
        `define VGA_RES_V       480
        `define VGA_FPORCH_H    32
        `define VGA_FPORCH_V    9
        `define VGA_SYNC_H      112
        `define VGA_SYNC_H_POL  1'b0
        `define VGA_SYNC_V      5
        `define VGA_SYNC_V_POL  1'b0
        `define VGA_BPORCH_H    32
        `define VGA_BPORCH_V    10

		`define ISE_DCM_MULTIPLY		9
		`define ISE_DCM_DIVIDE			15
    `else
		`ifdef vga_720p
			`define __VGA_TIMES_SET_H
			`define VGA_PX_CLK      73_780_000
			`define VGA_RES_H       1280
			`define VGA_RES_V       720
			`define VGA_FPORCH_H    32
			`define VGA_FPORCH_V    15
			`define VGA_SYNC_H      280
			`define VGA_SYNC_H_POL  1'b0
			`define VGA_SYNC_V      7
			`define VGA_SYNC_V_POL  1'b0
			`define VGA_BPORCH_H    32
			`define VGA_BPORCH_V    15

			`define ISE_DCM_MULTIPLY		31
			`define ISE_DCM_DIVIDE			21
		`else
			`ifdef vga_1366x768
				`define __VGA_TIMES_SET_H
				`define VGA_PX_CLK      84_490_000
				`define VGA_RES_H       1360
				`define VGA_RES_V       768
				`define VGA_FPORCH_H    32
				`define VGA_FPORCH_V    15
				`define VGA_SYNC_H      320
				`define VGA_SYNC_H_POL  1'b0
				`define VGA_SYNC_V      8
				`define VGA_SYNC_V_POL  1'b0
				`define VGA_BPORCH_H    32
				`define VGA_BPORCH_V    16

				`define ISE_DCM_MULTIPLY		27
				`define ISE_DCM_DIVIDE			16
			`else
				`ifdef vga_1600x900
					`define __VGA_TIMES_SET_H
					`define VGA_PX_CLK      120_420_000
					`define VGA_RES_H       1600
					`define VGA_RES_V       900
					`define VGA_FPORCH_H    32
					`define VGA_FPORCH_V    18
					`define VGA_SYNC_H      456
					`define VGA_SYNC_H_POL  1'b0
					`define VGA_SYNC_V      9
					`define VGA_SYNC_V_POL  1'b0
					`define VGA_BPORCH_H    32
					`define VGA_BPORCH_V    19

					`define ISE_DCM_MULTIPLY		12
					`define ISE_DCM_DIVIDE			5
				`else
					`ifdef vga_1440x1080
						`define __VGA_TIMES_SET_H
						`define VGA_PX_CLK      138_180_000
						`define VGA_RES_H       1440
						`define VGA_RES_V       1080
						`define VGA_FPORCH_H    32
						`define VGA_FPORCH_V    15
						`define VGA_SYNC_H      280
						`define VGA_SYNC_H_POL  1'b0
						`define VGA_SYNC_V      7
						`define VGA_SYNC_V_POL  1'b0
						`define VGA_BPORCH_H    32
						`define VGA_BPORCH_V    15

						`define ISE_DCM_MULTIPLY		22
						`define ISE_DCM_DIVIDE			8
					`endif // 1440
				`endif // 1600
			`endif // 1366x768
		`endif // 720p
    `endif // 480p

    `ifndef __VGA_TIMES_SET_H
        // Default 1080p @ 59Hz
        `define VGA_PX_CLK      193_160_000
        `define VGA_RES_H       1920
        `define VGA_RES_V       1080
        `define VGA_FPORCH_H    32
        `define VGA_FPORCH_V    22
        `define VGA_SYNC_H      696
        `define VGA_SYNC_H_POL  1'b0
        `define VGA_SYNC_V      11
        `define VGA_SYNC_V_POL  1'b1
        `define VGA_BPORCH_H    32
        `define VGA_BPORCH_V    22

		`define ISE_DCM_MULTIPLY		27
		`define ISE_DCM_DIVIDE			7
    `endif

	/*`ifndef __VGA_TIMES_SET_H
        // Default 1080p @ 60Hz
        `define VGA_PX_CLK      183_970_000
        `define VGA_RES_H       1920
        `define VGA_RES_V       1080
        `define VGA_FPORCH_H    32
        `define VGA_FPORCH_V    22
        `define VGA_SYNC_H      688
        `define VGA_SYNC_H_POL  1'b0
        `define VGA_SYNC_V      11
        `define VGA_SYNC_V_POL  1'b0
        `define VGA_BPORCH_H    32
        `define VGA_BPORCH_V    22

		`define ISE_DCM_MULTIPLY		11
		`define ISE_DCM_DIVIDE			3
    `endif*/

    `define VGA_MAX_H   (`VGA_SYNC_H + `VGA_FPORCH_H + `VGA_RES_H + `VGA_BPORCH_H)
    `define VGA_MAX_V   (`VGA_SYNC_V + `VGA_FPORCH_V + `VGA_RES_V + `VGA_BPORCH_V)
    `define VGA_SYNC_START_H   (`VGA_RES_H + `VGA_BPORCH_H)
    `define VGA_SYNC_START_V   (`VGA_RES_V + `VGA_BPORCH_V)
    `define VGA_SYNC_STOP_H   (`VGA_SYNC_H + `VGA_SYNC_START_H)
    `define VGA_SYNC_STOP_V   (`VGA_SYNC_V + `VGA_SYNC_START_V)

`endif
