//Copyright (C) 1991-2012 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//altfp_log CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Stratix V" PIPELINE=21 WIDTH_EXP=8 WIDTH_MAN=23 clk_en clock data result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



//altbarrel_shift CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Stratix V" PIPELINE=1 SHIFTDIR="LEFT" WIDTH=32 WIDTHDIST=5 aclr clk_en clock data distance result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = reg 33 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altbarrel_shift_kud
	( 
	aclr,
	clk_en,
	clock,
	data,
	distance,
	result) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [31:0]  data;
	input   [4:0]  distance;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clk_en;
	tri0   clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[0:0]	dir_pipe;
	reg	[31:0]	sbit_piper1d;
	wire  [5:0]  dir_w;
	wire  direction_w;
	wire  [15:0]  pad_w;
	wire  [191:0]  sbit_w;
	wire  [4:0]  sel_w;
	wire  [159:0]  smux_w;

	// synopsys translate_off
	initial
		dir_pipe = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) dir_pipe <= 1'b0;
		else if  (clk_en == 1'b1)   dir_pipe <= {dir_w[4]};
	// synopsys translate_off
	initial
		sbit_piper1d = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sbit_piper1d <= 32'b0;
		else if  (clk_en == 1'b1)   sbit_piper1d <= smux_w[159:128];
	assign
		dir_w = {dir_pipe[0], dir_w[3:0], direction_w},
		direction_w = 1'b0,
		pad_w = {16{1'b0}},
		result = sbit_w[191:160],
		sbit_w = {sbit_piper1d, smux_w[127:0], data},
		sel_w = {distance[4:0]},
		smux_w = {((({32{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[143:128], pad_w[15:0]}) | ({32{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[159:144]})) | ({32{(~ sel_w[4])}} & sbit_w[159:128])), ((({32{(sel_w[3] & (~ dir_w[3]))}} & {sbit_w[119:96], pad_w[7:0]}) | ({32{(sel_w[3] & dir_w[3])}} & {pad_w[7:0], sbit_w[127:104]})) | ({32{(~ sel_w[3])}} & sbit_w[127:96])), ((({32{(sel_w[2] & (~ dir_w[2]))}} & {sbit_w[91:64], pad_w[3:0]}) | ({32{(sel_w[2] & dir_w[2])}} & {pad_w[3:0], sbit_w[95:68]})) | ({32{(~ sel_w[2])}} & sbit_w[95:64])), ((({32{(sel_w[1] & (~ dir_w[1]))}} & {sbit_w[61:32], pad_w[1:0]}) | ({32{(sel_w[1] & dir_w[1])}} & {pad_w[1:0], sbit_w[63:34]})) | ({32{(~ sel_w[1])}} & sbit_w[63:32])), ((({32{(sel_w[0] & (~ dir_w[0]))}} & {sbit_w[30:0], pad_w[0]}) | ({32{(sel_w[0] & dir_w[0])}} & {pad_w[0], sbit_w[31:1]})) | ({32{(~ sel_w[0])}} & sbit_w[31:0]))};
endmodule //acl_fp_log_s5_altbarrel_shift_kud


//altbarrel_shift CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Stratix V" SHIFTDIR="LEFT" WIDTH=64 WIDTHDIST=6 data distance result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altbarrel_shift_sbb
	( 
	data,
	distance,
	result) ;
	input   [63:0]  data;
	input   [5:0]  distance;
	output   [63:0]  result;

	wire  [6:0]  dir_w;
	wire  direction_w;
	wire  [31:0]  pad_w;
	wire  [447:0]  sbit_w;
	wire  [5:0]  sel_w;
	wire  [383:0]  smux_w;

	assign
		dir_w = {dir_w[5:0], direction_w},
		direction_w = 1'b0,
		pad_w = {32{1'b0}},
		result = sbit_w[447:384],
		sbit_w = {smux_w[383:0], data},
		sel_w = {distance[5:0]},
		smux_w = {((({64{(sel_w[5] & (~ dir_w[5]))}} & {sbit_w[351:320], pad_w[31:0]}) | ({64{(sel_w[5] & dir_w[5])}} & {pad_w[31:0], sbit_w[383:352]})) | ({64{(~ sel_w[5])}} & sbit_w[383:320])), ((({64{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[303:256], pad_w[15:0]}) | ({64{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[319:272]})) | ({64{(~ sel_w[4])}} & sbit_w[319:256])), ((({64{(sel_w[3] & (~ dir_w[3]))}} & {sbit_w[247:192], pad_w[7:0]}) | ({64{(sel_w[3] & dir_w[3])}} & {pad_w[7:0], sbit_w[255:200]})) | ({64{(~ sel_w[3])}} & sbit_w[255:192])), ((({64{(sel_w[2] & (~ dir_w[2]))}} & {sbit_w[187:128], pad_w[3:0]}) | ({64{(sel_w[2] & dir_w[2])}} & {pad_w[3:0], sbit_w[191:132]})) | ({64{(~ sel_w[2])}} & sbit_w[191:128])), ((({64{(sel_w[1] & (~ dir_w[1]))}} & {sbit_w[125:64], pad_w[1:0]}) | ({64{(sel_w[1] & dir_w[1])}} & {pad_w[1:0], sbit_w[127:66]})) | ({64{(~ sel_w[1])}} & sbit_w[127:64])), ((({64{(sel_w[0] & (~ dir_w[0]))}} & {sbit_w[62:0], pad_w[0]}) | ({64{(sel_w[0] & dir_w[0])}} & {pad_w[0], sbit_w[63:1]})) | ({64{(~ sel_w[0])}} & sbit_w[63:0]))};
endmodule //acl_fp_log_s5_altbarrel_shift_sbb


//altbarrel_shift CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Stratix V" PIPELINE=1 SHIFTDIR="RIGHT" WIDTH=32 WIDTHDIST=5 aclr clk_en clock data distance result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = reg 33 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altbarrel_shift_72e
	( 
	aclr,
	clk_en,
	clock,
	data,
	distance,
	result) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [31:0]  data;
	input   [4:0]  distance;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clk_en;
	tri0   clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[0:0]	dir_pipe;
	reg	[31:0]	sbit_piper1d;
	wire  [5:0]  dir_w;
	wire  direction_w;
	wire  [15:0]  pad_w;
	wire  [191:0]  sbit_w;
	wire  [4:0]  sel_w;
	wire  [159:0]  smux_w;

	// synopsys translate_off
	initial
		dir_pipe = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) dir_pipe <= 1'b0;
		else if  (clk_en == 1'b1)   dir_pipe <= {dir_w[4]};
	// synopsys translate_off
	initial
		sbit_piper1d = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sbit_piper1d <= 32'b0;
		else if  (clk_en == 1'b1)   sbit_piper1d <= smux_w[159:128];
	assign
		dir_w = {dir_pipe[0], dir_w[3:0], direction_w},
		direction_w = 1'b1,
		pad_w = {16{1'b0}},
		result = sbit_w[191:160],
		sbit_w = {sbit_piper1d, smux_w[127:0], data},
		sel_w = {distance[4:0]},
		smux_w = {((({32{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[143:128], pad_w[15:0]}) | ({32{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[159:144]})) | ({32{(~ sel_w[4])}} & sbit_w[159:128])), ((({32{(sel_w[3] & (~ dir_w[3]))}} & {sbit_w[119:96], pad_w[7:0]}) | ({32{(sel_w[3] & dir_w[3])}} & {pad_w[7:0], sbit_w[127:104]})) | ({32{(~ sel_w[3])}} & sbit_w[127:96])), ((({32{(sel_w[2] & (~ dir_w[2]))}} & {sbit_w[91:64], pad_w[3:0]}) | ({32{(sel_w[2] & dir_w[2])}} & {pad_w[3:0], sbit_w[95:68]})) | ({32{(~ sel_w[2])}} & sbit_w[95:64])), ((({32{(sel_w[1] & (~ dir_w[1]))}} & {sbit_w[61:32], pad_w[1:0]}) | ({32{(sel_w[1] & dir_w[1])}} & {pad_w[1:0], sbit_w[63:34]})) | ({32{(~ sel_w[1])}} & sbit_w[63:32])), ((({32{(sel_w[0] & (~ dir_w[0]))}} & {sbit_w[30:0], pad_w[0]}) | ({32{(sel_w[0] & dir_w[0])}} & {pad_w[0], sbit_w[31:1]})) | ({32{(~ sel_w[0])}} & sbit_w[31:0]))};
endmodule //acl_fp_log_s5_altbarrel_shift_72e


//altfp_log_and_or CBX_AUTO_BLACKBOX="ALL" LUT_INPUT_COUNT=6 OPERATION="AND" PIPELINE=3 WIDTH=8 aclr clken clock data result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = reg 4 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_and_or_h9b
	( 
	aclr,
	clken,
	clock,
	data,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [7:0]  data;
	output   result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [7:0]  data;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[1:0]	connection_dffe0;
	reg	[0:0]	connection_dffe1;
	reg	connection_dffe2;
	wire  [7:0]  connection_r0_w;
	wire  [1:0]  connection_r1_w;
	wire  [0:0]  connection_r2_w;
	wire  [7:0]  operation_r1_w;
	wire  [1:0]  operation_r2_w;

	// synopsys translate_off
	initial
		connection_dffe0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe0 <= 2'b0;
		else if  (clken == 1'b1)   connection_dffe0 <= {operation_r1_w[7], operation_r1_w[5]};
	// synopsys translate_off
	initial
		connection_dffe1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe1 <= 1'b0;
		else if  (clken == 1'b1)   connection_dffe1 <= {operation_r2_w[1]};
	// synopsys translate_off
	initial
		connection_dffe2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe2 <= 1'b0;
		else if  (clken == 1'b1)   connection_dffe2 <= connection_r2_w[0];
	assign
		connection_r0_w = data,
		connection_r1_w = connection_dffe0,
		connection_r2_w = connection_dffe1,
		operation_r1_w = {(operation_r1_w[6] & connection_r0_w[7]), connection_r0_w[6], (operation_r1_w[4] & connection_r0_w[5]), (operation_r1_w[3] & connection_r0_w[4]), (operation_r1_w[2] & connection_r0_w[3]), (operation_r1_w[1] & connection_r0_w[2]), (operation_r1_w[0] & connection_r0_w[1]), connection_r0_w[0]},
		operation_r2_w = {(operation_r2_w[0] & connection_r1_w[1]), connection_r1_w[0]},
		result = connection_dffe2;
endmodule //acl_fp_log_s5_altfp_log_and_or_h9b


//altfp_log_and_or CBX_AUTO_BLACKBOX="ALL" LUT_INPUT_COUNT=6 OPERATION="OR" PIPELINE=3 WIDTH=8 aclr clken clock data result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = reg 4 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_and_or_v6b
	( 
	aclr,
	clken,
	clock,
	data,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [7:0]  data;
	output   result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [7:0]  data;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[1:0]	connection_dffe0;
	reg	[0:0]	connection_dffe1;
	reg	connection_dffe2;
	wire  [7:0]  connection_r0_w;
	wire  [1:0]  connection_r1_w;
	wire  [0:0]  connection_r2_w;
	wire  [7:0]  operation_r1_w;
	wire  [1:0]  operation_r2_w;

	// synopsys translate_off
	initial
		connection_dffe0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe0 <= 2'b0;
		else if  (clken == 1'b1)   connection_dffe0 <= {operation_r1_w[7], operation_r1_w[5]};
	// synopsys translate_off
	initial
		connection_dffe1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe1 <= 1'b0;
		else if  (clken == 1'b1)   connection_dffe1 <= {operation_r2_w[1]};
	// synopsys translate_off
	initial
		connection_dffe2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe2 <= 1'b0;
		else if  (clken == 1'b1)   connection_dffe2 <= connection_r2_w[0];
	assign
		connection_r0_w = data,
		connection_r1_w = connection_dffe0,
		connection_r2_w = connection_dffe1,
		operation_r1_w = {(operation_r1_w[6] | connection_r0_w[7]), connection_r0_w[6], (operation_r1_w[4] | connection_r0_w[5]), (operation_r1_w[3] | connection_r0_w[4]), (operation_r1_w[2] | connection_r0_w[3]), (operation_r1_w[1] | connection_r0_w[2]), (operation_r1_w[0] | connection_r0_w[1]), connection_r0_w[0]},
		operation_r2_w = {(operation_r2_w[0] | connection_r1_w[1]), connection_r1_w[0]},
		result = connection_dffe2;
endmodule //acl_fp_log_s5_altfp_log_and_or_v6b


//altfp_log_and_or CBX_AUTO_BLACKBOX="ALL" LUT_INPUT_COUNT=6 OPERATION="OR" PIPELINE=3 WIDTH=23 aclr clken clock data result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = reg 6 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_and_or_c8b
	( 
	aclr,
	clken,
	clock,
	data,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [22:0]  data;
	output   result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [22:0]  data;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[3:0]	connection_dffe0;
	reg	[0:0]	connection_dffe1;
	reg	connection_dffe2;
	wire  [22:0]  connection_r0_w;
	wire  [3:0]  connection_r1_w;
	wire  [0:0]  connection_r2_w;
	wire  [22:0]  operation_r1_w;
	wire  [3:0]  operation_r2_w;

	// synopsys translate_off
	initial
		connection_dffe0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe0 <= 4'b0;
		else if  (clken == 1'b1)   connection_dffe0 <= {operation_r1_w[22], operation_r1_w[17], operation_r1_w[11], operation_r1_w[5]};
	// synopsys translate_off
	initial
		connection_dffe1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe1 <= 1'b0;
		else if  (clken == 1'b1)   connection_dffe1 <= {operation_r2_w[3]};
	// synopsys translate_off
	initial
		connection_dffe2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) connection_dffe2 <= 1'b0;
		else if  (clken == 1'b1)   connection_dffe2 <= connection_r2_w[0];
	assign
		connection_r0_w = data,
		connection_r1_w = connection_dffe0,
		connection_r2_w = connection_dffe1,
		operation_r1_w = {(operation_r1_w[21] | connection_r0_w[22]), (operation_r1_w[20] | connection_r0_w[21]), (operation_r1_w[19] | connection_r0_w[20]), (operation_r1_w[18] | connection_r0_w[19]), connection_r0_w[18], (operation_r1_w[16] | connection_r0_w[17]), (operation_r1_w[15] | connection_r0_w[16]), (operation_r1_w[14] | connection_r0_w[15]), (operation_r1_w[13] | connection_r0_w[14]), (operation_r1_w[12] | connection_r0_w[13]), connection_r0_w[12], (operation_r1_w[10] | connection_r0_w[11]), (operation_r1_w[9] | connection_r0_w[10]), (operation_r1_w[8] | connection_r0_w[9]), (operation_r1_w[7] | connection_r0_w[8]), (operation_r1_w[6] | connection_r0_w[7]), connection_r0_w[6], (operation_r1_w[4] | connection_r0_w[5]), (operation_r1_w[3] | connection_r0_w[4]), (operation_r1_w[2] | connection_r0_w[3]), (operation_r1_w[1] | connection_r0_w[2]), (operation_r1_w[0] | connection_r0_w[1]), connection_r0_w[0]},
		operation_r2_w = {(operation_r2_w[2] | connection_r1_w[3]), (operation_r2_w[1] | connection_r1_w[2]), (operation_r2_w[0] | connection_r1_w[1]), connection_r1_w[0]},
		result = connection_dffe2;
endmodule //acl_fp_log_s5_altfp_log_and_or_c8b


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="ADD" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=39 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_s0e
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [38:0]  dataa;
	input   [38:0]  datab;
	output   [38:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [38:0]  dataa;
	tri0   [38:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_csa_lower_cout;
	wire  [19:0]   wire_csa_lower_result;
	wire  [18:0]   wire_csa_upper0_result;
	wire  [18:0]   wire_csa_upper1_result;
	wire  [38:0]  result_w;

	lpm_add_sub   csa_lower
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(wire_csa_lower_cout),
	.dataa(dataa[19:0]),
	.datab(datab[19:0]),
	.overflow(),
	.result(wire_csa_lower_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_lower.lpm_direction = "ADD",
		csa_lower.lpm_pipeline = 1,
		csa_lower.lpm_representation = "UNSIGNED",
		csa_lower.lpm_width = 20,
		csa_lower.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper0
	( 
	.aclr(aclr),
	.cin(1'b0),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[38:20]),
	.datab(datab[38:20]),
	.overflow(),
	.result(wire_csa_upper0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper0.lpm_direction = "ADD",
		csa_upper0.lpm_pipeline = 1,
		csa_upper0.lpm_representation = "UNSIGNED",
		csa_upper0.lpm_width = 19,
		csa_upper0.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper1
	( 
	.aclr(aclr),
	.cin(1'b1),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[38:20]),
	.datab(datab[38:20]),
	.overflow(),
	.result(wire_csa_upper1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper1.lpm_direction = "ADD",
		csa_upper1.lpm_pipeline = 1,
		csa_upper1.lpm_representation = "UNSIGNED",
		csa_upper1.lpm_width = 19,
		csa_upper1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = {(({19{(~ wire_csa_lower_cout)}} & wire_csa_upper0_result) | ({19{wire_csa_lower_cout}} & wire_csa_upper1_result)), wire_csa_lower_result};
endmodule //acl_fp_log_s5_altfp_log_csa_s0e


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="ADD" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=31 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_k0e
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [30:0]  dataa;
	input   [30:0]  datab;
	output   [30:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [30:0]  dataa;
	tri0   [30:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_csa_lower_cout;
	wire  [15:0]   wire_csa_lower_result;
	wire  [14:0]   wire_csa_upper0_result;
	wire  [14:0]   wire_csa_upper1_result;
	wire  [30:0]  result_w;

	lpm_add_sub   csa_lower
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(wire_csa_lower_cout),
	.dataa(dataa[15:0]),
	.datab(datab[15:0]),
	.overflow(),
	.result(wire_csa_lower_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_lower.lpm_direction = "ADD",
		csa_lower.lpm_pipeline = 1,
		csa_lower.lpm_representation = "UNSIGNED",
		csa_lower.lpm_width = 16,
		csa_lower.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper0
	( 
	.aclr(aclr),
	.cin(1'b0),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[30:16]),
	.datab(datab[30:16]),
	.overflow(),
	.result(wire_csa_upper0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper0.lpm_direction = "ADD",
		csa_upper0.lpm_pipeline = 1,
		csa_upper0.lpm_representation = "UNSIGNED",
		csa_upper0.lpm_width = 15,
		csa_upper0.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper1
	( 
	.aclr(aclr),
	.cin(1'b1),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[30:16]),
	.datab(datab[30:16]),
	.overflow(),
	.result(wire_csa_upper1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper1.lpm_direction = "ADD",
		csa_upper1.lpm_pipeline = 1,
		csa_upper1.lpm_representation = "UNSIGNED",
		csa_upper1.lpm_width = 15,
		csa_upper1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = {(({15{(~ wire_csa_lower_cout)}} & wire_csa_upper0_result) | ({15{wire_csa_lower_cout}} & wire_csa_upper1_result)), wire_csa_lower_result};
endmodule //acl_fp_log_s5_altfp_log_csa_k0e


//altfp_log_csa CARRY_SELECT="NO" CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=8 dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_0nc
	( 
	dataa,
	datab,
	result) ;
	input   [7:0]  dataa;
	input   [7:0]  datab;
	output   [7:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [7:0]  dataa;
	tri0   [7:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [7:0]   wire_add_sub1_result;
	wire  [7:0]  result_w;

	lpm_add_sub   add_sub1
	( 
	.cout(),
	.dataa(dataa),
	.datab(datab),
	.overflow(),
	.result(wire_add_sub1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub1.lpm_direction = "SUB",
		add_sub1.lpm_representation = "UNSIGNED",
		add_sub1.lpm_width = 8,
		add_sub1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = wire_add_sub1_result;
endmodule //acl_fp_log_s5_altfp_log_csa_0nc


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=12 dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_d4b
	( 
	dataa,
	datab,
	result) ;
	input   [11:0]  dataa;
	input   [11:0]  datab;
	output   [11:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [11:0]  dataa;
	tri0   [11:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [11:0]   wire_add_sub2_result;
	wire  [11:0]  result_w;

	lpm_add_sub   add_sub2
	( 
	.cout(),
	.dataa(dataa),
	.datab(datab),
	.overflow(),
	.result(wire_add_sub2_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub2.lpm_direction = "SUB",
		add_sub2.lpm_representation = "UNSIGNED",
		add_sub2.lpm_width = 12,
		add_sub2.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = wire_add_sub2_result;
endmodule //acl_fp_log_s5_altfp_log_csa_d4b


//altfp_log_csa CARRY_SELECT="NO" CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=6 dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_umc
	( 
	dataa,
	datab,
	result) ;
	input   [5:0]  dataa;
	input   [5:0]  datab;
	output   [5:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [5:0]  dataa;
	tri0   [5:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [5:0]   wire_add_sub3_result;
	wire  [5:0]  result_w;

	lpm_add_sub   add_sub3
	( 
	.cout(),
	.dataa(dataa),
	.datab(datab),
	.overflow(),
	.result(wire_add_sub3_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub3.lpm_direction = "SUB",
		add_sub3.lpm_representation = "UNSIGNED",
		add_sub3.lpm_width = 6,
		add_sub3.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = wire_add_sub3_result;
endmodule //acl_fp_log_s5_altfp_log_csa_umc


//altfp_log_csa CARRY_SELECT="NO" CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=26 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_nlf
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [25:0]  dataa;
	input   [25:0]  datab;
	output   [25:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [25:0]  dataa;
	tri0   [25:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [25:0]   wire_add_sub4_result;
	wire  [25:0]  result_w;

	lpm_add_sub   add_sub4
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa),
	.datab(datab),
	.overflow(),
	.result(wire_add_sub4_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub4.lpm_direction = "SUB",
		add_sub4.lpm_pipeline = 1,
		add_sub4.lpm_representation = "UNSIGNED",
		add_sub4.lpm_width = 26,
		add_sub4.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = wire_add_sub4_result;
endmodule //acl_fp_log_s5_altfp_log_csa_nlf


//altfp_log_csa CARRY_SELECT="NO" CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_PIPELINE=2 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=8 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_8kf
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [7:0]  dataa;
	input   [7:0]  datab;
	output   [7:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [7:0]  dataa;
	tri0   [7:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [7:0]   wire_add_sub5_result;
	wire  [7:0]  result_w;

	lpm_add_sub   add_sub5
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa),
	.datab(datab),
	.overflow(),
	.result(wire_add_sub5_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		add_sub5.lpm_direction = "SUB",
		add_sub5.lpm_pipeline = 2,
		add_sub5.lpm_representation = "UNSIGNED",
		add_sub5.lpm_width = 8,
		add_sub5.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = wire_add_sub5_result;
endmodule //acl_fp_log_s5_altfp_log_csa_8kf


//altfp_log_rr_block CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Stratix V" WIDTH_ALMOSTLOG=39 WIDTH_Y0=25 WIDTH_Z=26 a0_in aclr almostlog clk_en clock y0_in z
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="ADD" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=29 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_r0e
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [28:0]  dataa;
	input   [28:0]  datab;
	output   [28:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [28:0]  dataa;
	tri0   [28:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_csa_lower_cout;
	wire  [14:0]   wire_csa_lower_result;
	wire  [13:0]   wire_csa_upper0_result;
	wire  [13:0]   wire_csa_upper1_result;
	wire  [28:0]  result_w;

	lpm_add_sub   csa_lower
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(wire_csa_lower_cout),
	.dataa(dataa[14:0]),
	.datab(datab[14:0]),
	.overflow(),
	.result(wire_csa_lower_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_lower.lpm_direction = "ADD",
		csa_lower.lpm_pipeline = 1,
		csa_lower.lpm_representation = "UNSIGNED",
		csa_lower.lpm_width = 15,
		csa_lower.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper0
	( 
	.aclr(aclr),
	.cin(1'b0),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[28:15]),
	.datab(datab[28:15]),
	.overflow(),
	.result(wire_csa_upper0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper0.lpm_direction = "ADD",
		csa_upper0.lpm_pipeline = 1,
		csa_upper0.lpm_representation = "UNSIGNED",
		csa_upper0.lpm_width = 14,
		csa_upper0.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper1
	( 
	.aclr(aclr),
	.cin(1'b1),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[28:15]),
	.datab(datab[28:15]),
	.overflow(),
	.result(wire_csa_upper1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper1.lpm_direction = "ADD",
		csa_upper1.lpm_pipeline = 1,
		csa_upper1.lpm_representation = "UNSIGNED",
		csa_upper1.lpm_width = 14,
		csa_upper1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = {(({14{(~ wire_csa_lower_cout)}} & wire_csa_upper0_result) | ({14{wire_csa_lower_cout}} & wire_csa_upper1_result)), wire_csa_lower_result};
endmodule //acl_fp_log_s5_altfp_log_csa_r0e


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="ADD" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=26 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_o0e
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [25:0]  dataa;
	input   [25:0]  datab;
	output   [25:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [25:0]  dataa;
	tri0   [25:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_csa_lower_cout;
	wire  [12:0]   wire_csa_lower_result;
	wire  [12:0]   wire_csa_upper0_result;
	wire  [12:0]   wire_csa_upper1_result;
	wire  [25:0]  result_w;

	lpm_add_sub   csa_lower
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(wire_csa_lower_cout),
	.dataa(dataa[12:0]),
	.datab(datab[12:0]),
	.overflow(),
	.result(wire_csa_lower_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_lower.lpm_direction = "ADD",
		csa_lower.lpm_pipeline = 1,
		csa_lower.lpm_representation = "UNSIGNED",
		csa_lower.lpm_width = 13,
		csa_lower.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper0
	( 
	.aclr(aclr),
	.cin(1'b0),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[25:13]),
	.datab(datab[25:13]),
	.overflow(),
	.result(wire_csa_upper0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper0.lpm_direction = "ADD",
		csa_upper0.lpm_pipeline = 1,
		csa_upper0.lpm_representation = "UNSIGNED",
		csa_upper0.lpm_width = 13,
		csa_upper0.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper1
	( 
	.aclr(aclr),
	.cin(1'b1),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[25:13]),
	.datab(datab[25:13]),
	.overflow(),
	.result(wire_csa_upper1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper1.lpm_direction = "ADD",
		csa_upper1.lpm_pipeline = 1,
		csa_upper1.lpm_representation = "UNSIGNED",
		csa_upper1.lpm_width = 13,
		csa_upper1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = {(({13{(~ wire_csa_lower_cout)}} & wire_csa_upper0_result) | ({13{wire_csa_lower_cout}} & wire_csa_upper1_result)), wire_csa_lower_result};
endmodule //acl_fp_log_s5_altfp_log_csa_o0e


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=31 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_l1e
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [30:0]  dataa;
	input   [30:0]  datab;
	output   [30:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [30:0]  dataa;
	tri0   [30:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_csa_lower_cout;
	wire  [15:0]   wire_csa_lower_result;
	wire  [14:0]   wire_csa_upper0_result;
	wire  [14:0]   wire_csa_upper1_result;
	wire  [30:0]  result_w;

	lpm_add_sub   csa_lower
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(wire_csa_lower_cout),
	.dataa(dataa[15:0]),
	.datab(datab[15:0]),
	.overflow(),
	.result(wire_csa_lower_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_lower.lpm_direction = "SUB",
		csa_lower.lpm_pipeline = 1,
		csa_lower.lpm_representation = "UNSIGNED",
		csa_lower.lpm_width = 16,
		csa_lower.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper0
	( 
	.aclr(aclr),
	.cin(1'b0),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[30:16]),
	.datab(datab[30:16]),
	.overflow(),
	.result(wire_csa_upper0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper0.lpm_direction = "SUB",
		csa_upper0.lpm_pipeline = 1,
		csa_upper0.lpm_representation = "UNSIGNED",
		csa_upper0.lpm_width = 15,
		csa_upper0.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper1
	( 
	.aclr(aclr),
	.cin(1'b1),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[30:16]),
	.datab(datab[30:16]),
	.overflow(),
	.result(wire_csa_upper1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper1.lpm_direction = "SUB",
		csa_upper1.lpm_pipeline = 1,
		csa_upper1.lpm_representation = "UNSIGNED",
		csa_upper1.lpm_width = 15,
		csa_upper1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = {(({15{(~ wire_csa_lower_cout)}} & wire_csa_upper0_result) | ({15{wire_csa_lower_cout}} & wire_csa_upper1_result)), wire_csa_lower_result};
endmodule //acl_fp_log_s5_altfp_log_csa_l1e


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=29 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_s1e
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [28:0]  dataa;
	input   [28:0]  datab;
	output   [28:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [28:0]  dataa;
	tri0   [28:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_csa_lower_cout;
	wire  [14:0]   wire_csa_lower_result;
	wire  [13:0]   wire_csa_upper0_result;
	wire  [13:0]   wire_csa_upper1_result;
	wire  [28:0]  result_w;

	lpm_add_sub   csa_lower
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(wire_csa_lower_cout),
	.dataa(dataa[14:0]),
	.datab(datab[14:0]),
	.overflow(),
	.result(wire_csa_lower_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_lower.lpm_direction = "SUB",
		csa_lower.lpm_pipeline = 1,
		csa_lower.lpm_representation = "UNSIGNED",
		csa_lower.lpm_width = 15,
		csa_lower.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper0
	( 
	.aclr(aclr),
	.cin(1'b0),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[28:15]),
	.datab(datab[28:15]),
	.overflow(),
	.result(wire_csa_upper0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper0.lpm_direction = "SUB",
		csa_upper0.lpm_pipeline = 1,
		csa_upper0.lpm_representation = "UNSIGNED",
		csa_upper0.lpm_width = 14,
		csa_upper0.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper1
	( 
	.aclr(aclr),
	.cin(1'b1),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[28:15]),
	.datab(datab[28:15]),
	.overflow(),
	.result(wire_csa_upper1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper1.lpm_direction = "SUB",
		csa_upper1.lpm_pipeline = 1,
		csa_upper1.lpm_representation = "UNSIGNED",
		csa_upper1.lpm_width = 14,
		csa_upper1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = {(({14{(~ wire_csa_lower_cout)}} & wire_csa_upper0_result) | ({14{wire_csa_lower_cout}} & wire_csa_upper1_result)), wire_csa_lower_result};
endmodule //acl_fp_log_s5_altfp_log_csa_s1e


//altfp_log_csa CBX_AUTO_BLACKBOX="ALL" LPM_DIRECTION="SUB" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=26 aclr clken clock dataa datab result
//VERSION_BEGIN 12.0 cbx_altbarrel_shift 2012:05:31:20:08:02:SJ cbx_altfp_log 2012:05:31:20:08:02:SJ cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_altsquare 2012:05:31:20:08:02:SJ cbx_cycloneii 2012:05:31:20:08:02:SJ cbx_lpm_add_sub 2012:05:31:20:08:02:SJ cbx_lpm_compare 2012:05:31:20:08:02:SJ cbx_lpm_mult 2012:05:31:20:08:02:SJ cbx_lpm_mux 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ cbx_padd 2012:05:31:20:08:02:SJ cbx_stratix 2012:05:31:20:08:02:SJ cbx_stratixii 2012:05:31:20:08:02:SJ cbx_util_mgl 2012:05:31:20:08:02:SJ  VERSION_END

//synthesis_resources = lpm_add_sub 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_csa_p1e
	( 
	aclr,
	clken,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clken;
	input   clock;
	input   [25:0]  dataa;
	input   [25:0]  datab;
	output   [25:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clken;
	tri0   clock;
	tri0   [25:0]  dataa;
	tri0   [25:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_csa_lower_cout;
	wire  [12:0]   wire_csa_lower_result;
	wire  [12:0]   wire_csa_upper0_result;
	wire  [12:0]   wire_csa_upper1_result;
	wire  [25:0]  result_w;

	lpm_add_sub   csa_lower
	( 
	.aclr(aclr),
	.clken(clken),
	.clock(clock),
	.cout(wire_csa_lower_cout),
	.dataa(dataa[12:0]),
	.datab(datab[12:0]),
	.overflow(),
	.result(wire_csa_lower_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_lower.lpm_direction = "SUB",
		csa_lower.lpm_pipeline = 1,
		csa_lower.lpm_representation = "UNSIGNED",
		csa_lower.lpm_width = 13,
		csa_lower.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper0
	( 
	.aclr(aclr),
	.cin(1'b0),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[25:13]),
	.datab(datab[25:13]),
	.overflow(),
	.result(wire_csa_upper0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper0.lpm_direction = "SUB",
		csa_upper0.lpm_pipeline = 1,
		csa_upper0.lpm_representation = "UNSIGNED",
		csa_upper0.lpm_width = 13,
		csa_upper0.lpm_type = "lpm_add_sub";
	lpm_add_sub   csa_upper1
	( 
	.aclr(aclr),
	.cin(1'b1),
	.clken(clken),
	.clock(clock),
	.cout(),
	.dataa(dataa[25:13]),
	.datab(datab[25:13]),
	.overflow(),
	.result(wire_csa_upper1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		csa_upper1.lpm_direction = "SUB",
		csa_upper1.lpm_pipeline = 1,
		csa_upper1.lpm_representation = "UNSIGNED",
		csa_upper1.lpm_width = 13,
		csa_upper1.lpm_type = "lpm_add_sub";
	assign
		result = result_w,
		result_w = {(({13{(~ wire_csa_lower_cout)}} & wire_csa_upper0_result) | ({13{wire_csa_lower_cout}} & wire_csa_upper1_result)), wire_csa_lower_result};
endmodule //acl_fp_log_s5_altfp_log_csa_p1e

//synthesis_resources = lpm_add_sub 27 lpm_mult 4 lpm_mux 5 reg 531 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_range_reduction_0sd
	( 
	a0_in,
	aclr,
	almostlog,
	clk_en,
	clock,
	y0_in,
	z) ;
	input   [4:0]  a0_in;
	input   aclr;
	output   [38:0]  almostlog;
	input   clk_en;
	input   clock;
	input   [24:0]  y0_in;
	output   [25:0]  z;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clk_en;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [38:0]   wire_add0_1_result;
	wire  [38:0]   wire_add0_2_result;
	wire  [38:0]   wire_add0_3_result;
	wire  [30:0]   wire_add1_1_result;
	wire  [28:0]   wire_add1_2_result;
	wire  [25:0]   wire_add1_3_result;
	wire  [30:0]   wire_sub1_1_result;
	wire  [28:0]   wire_sub1_2_result;
	wire  [25:0]   wire_sub1_3_result;
	reg	[4:0]	A_pipe0_reg0;
	reg	[4:0]	A_pipe0_reg1;
	reg	[4:0]	A_pipe0_reg2;
	reg	[3:0]	A_wire1_reg0;
	reg	[3:0]	A_wire2_reg0;
	reg	[3:0]	A_wire3_reg0;
	reg	[20:0]	B_wire1_reg0;
	reg	[26:0]	B_wire2_reg0;
	reg	[24:0]	B_wire3_reg0;
	reg	[30:0]	P_pipe0_reg0;
	reg	[28:0]	P_pipe1_reg0;
	reg	[28:0]	P_pipe2_reg0;
	reg	[22:0]	P_pipe3_reg0;
	reg	[38:0]	S_pipe22_reg0;
	reg	[38:0]	S_pipe23_reg0;
	reg	[38:0]	S_pipe24_reg0;
	reg	[38:0]	S_wire1_reg0;
	reg	[38:0]	S_wire2_reg0;
	reg	[38:0]	S_wire3_reg0;
	reg	[24:0]	Z_wire1_reg0;
	reg	[30:0]	Z_wire2_reg0;
	reg	[28:0]	Z_wire3_reg0;
	wire  [30:0]   wire_mult0_result;
	wire  [28:0]   wire_mult1_result;
	wire  [28:0]   wire_mult2_result;
	wire  [22:0]   wire_mult3_result;
	wire  [5:0]   wire_InvTable0_result;
	wire  [38:0]   wire_LogTable0_result;
	wire  [34:0]   wire_LogTable1_result;
	wire  [31:0]   wire_LogTable2_result;
	wire  [28:0]   wire_LogTable3_result;
	wire  [3:0]  A1_is_all_zero;
	wire  [3:0]  A1_is_not_zero;
	wire  [3:0]  A_all_zero2;
	wire  [3:0]  A_all_zero3;
	wire  [4:0]  A_pipe0;
	wire  [3:0]  A_pipe11;
	wire  [3:0]  A_pipe12;
	wire  [3:0]  A_pipe13;
	wire  [4:0]  A_wire0;
	wire  [3:0]  A_wire1;
	wire  [3:0]  A_wire2;
	wire  [3:0]  A_wire3;
	wire  [30:0]  B_pad_wire1;
	wire  [28:0]  B_pad_wire2;
	wire  [25:0]  B_pad_wire3;
	wire  [20:0]  B_pipe1;
	wire  [26:0]  B_pipe2;
	wire  [24:0]  B_pipe3;
	wire  [20:0]  B_wire1;
	wire  [26:0]  B_wire2;
	wire  [24:0]  B_wire3;
	wire  [30:0]  epsZ_pad_wire1;
	wire  [28:0]  epsZ_pad_wire2;
	wire  [25:0]  epsZ_pad_wire3;
	wire  [30:0]  epsZ_wire1;
	wire  [39:0]  epsZ_wire2;
	wire  [40:0]  epsZ_wire3;
	wire  [5:0]  InvA0;
	wire  [38:0]  L_wire0;
	wire  [34:0]  L_wire1;
	wire  [31:0]  L_wire2;
	wire  [28:0]  L_wire3;
	wire  [30:0]  mux0_data0;
	wire  [30:0]  mux0_data1;
	wire  [30:0]  P_pad_wire1;
	wire  [28:0]  P_pad_wire2;
	wire  [25:0]  P_pad_wire3;
	wire  [30:0]  P_pipe0;
	wire  [28:0]  P_pipe1;
	wire  [28:0]  P_pipe2;
	wire  [22:0]  P_pipe3;
	wire  [30:0]  P_wire0;
	wire  [28:0]  P_wire1;
	wire  [28:0]  P_wire2;
	wire  [22:0]  P_wire3;
	wire  [38:0]  S_pipe11;
	wire  [38:0]  S_pipe12;
	wire  [38:0]  S_pipe13;
	wire  [38:0]  S_pipe22;
	wire  [38:0]  S_pipe23;
	wire  [38:0]  S_pipe24;
	wire  [38:0]  S_wire1;
	wire  [38:0]  S_wire2;
	wire  [38:0]  S_wire3;
	wire  [38:0]  S_wire4;
	wire  [24:0]  Z_pipe1;
	wire  [30:0]  Z_pipe2;
	wire  [28:0]  Z_pipe3;
	wire  [24:0]  Z_wire1;
	wire  [30:0]  Z_wire2;
	wire  [28:0]  Z_wire3;
	wire  [25:0]  Z_wire4;
	wire  [24:0]  ZM_wire1;
	wire  [24:0]  ZM_wire2;
	wire  [18:0]  ZM_wire3;

	acl_fp_log_s5_altfp_log_csa_s0e   add0_1
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(S_pipe11),
	.datab({{4{1'b0}}, L_wire1}),
	.result(wire_add0_1_result));
	acl_fp_log_s5_altfp_log_csa_s0e   add0_2
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(S_pipe12),
	.datab({{7{1'b0}}, L_wire2}),
	.result(wire_add0_2_result));
	acl_fp_log_s5_altfp_log_csa_s0e   add0_3
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(S_pipe13),
	.datab({{10{1'b0}}, L_wire3}),
	.result(wire_add0_3_result));
	acl_fp_log_s5_altfp_log_csa_k0e   add1_1
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(B_pad_wire1),
	.datab(epsZ_pad_wire1),
	.result(wire_add1_1_result));
	acl_fp_log_s5_altfp_log_csa_r0e   add1_2
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(B_pad_wire2),
	.datab(epsZ_pad_wire2),
	.result(wire_add1_2_result));
	acl_fp_log_s5_altfp_log_csa_o0e   add1_3
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(B_pad_wire3),
	.datab(epsZ_pad_wire3),
	.result(wire_add1_3_result));
	acl_fp_log_s5_altfp_log_csa_l1e   sub1_1
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(wire_add1_1_result),
	.datab(P_pad_wire1),
	.result(wire_sub1_1_result));
	acl_fp_log_s5_altfp_log_csa_s1e   sub1_2
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(wire_add1_2_result),
	.datab(P_pad_wire2),
	.result(wire_sub1_2_result));
	acl_fp_log_s5_altfp_log_csa_p1e   sub1_3
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(wire_add1_3_result),
	.datab(P_pad_wire3),
	.result(wire_sub1_3_result));
	// synopsys translate_off
	initial
		A_pipe0_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) A_pipe0_reg0 <= 5'b0;
		else if  (clk_en == 1'b1)   A_pipe0_reg0 <= A_pipe0;
	// synopsys translate_off
	initial
		A_pipe0_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) A_pipe0_reg1 <= 5'b0;
		else if  (clk_en == 1'b1)   A_pipe0_reg1 <= A_pipe0_reg0;
	// synopsys translate_off
	initial
		A_pipe0_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) A_pipe0_reg2 <= 5'b0;
		else if  (clk_en == 1'b1)   A_pipe0_reg2 <= A_pipe0_reg1;
	// synopsys translate_off
	initial
		A_wire1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) A_wire1_reg0 <= 4'b0;
		else if  (clk_en == 1'b1)   A_wire1_reg0 <= A_wire1;
	// synopsys translate_off
	initial
		A_wire2_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) A_wire2_reg0 <= 4'b0;
		else if  (clk_en == 1'b1)   A_wire2_reg0 <= A_wire2;
	// synopsys translate_off
	initial
		A_wire3_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) A_wire3_reg0 <= 4'b0;
		else if  (clk_en == 1'b1)   A_wire3_reg0 <= A_wire3;
	// synopsys translate_off
	initial
		B_wire1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) B_wire1_reg0 <= 21'b0;
		else if  (clk_en == 1'b1)   B_wire1_reg0 <= B_wire1;
	// synopsys translate_off
	initial
		B_wire2_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) B_wire2_reg0 <= 27'b0;
		else if  (clk_en == 1'b1)   B_wire2_reg0 <= B_wire2;
	// synopsys translate_off
	initial
		B_wire3_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) B_wire3_reg0 <= 25'b0;
		else if  (clk_en == 1'b1)   B_wire3_reg0 <= B_wire3;
	// synopsys translate_off
	initial
		P_pipe0_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) P_pipe0_reg0 <= 31'b0;
		else if  (clk_en == 1'b1)   P_pipe0_reg0 <= P_pipe0;
	// synopsys translate_off
	initial
		P_pipe1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) P_pipe1_reg0 <= 29'b0;
		else if  (clk_en == 1'b1)   P_pipe1_reg0 <= P_pipe1;
	// synopsys translate_off
	initial
		P_pipe2_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) P_pipe2_reg0 <= 29'b0;
		else if  (clk_en == 1'b1)   P_pipe2_reg0 <= P_pipe2;
	// synopsys translate_off
	initial
		P_pipe3_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) P_pipe3_reg0 <= 23'b0;
		else if  (clk_en == 1'b1)   P_pipe3_reg0 <= P_pipe3;
	// synopsys translate_off
	initial
		S_pipe22_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) S_pipe22_reg0 <= 39'b0;
		else if  (clk_en == 1'b1)   S_pipe22_reg0 <= S_pipe22;
	// synopsys translate_off
	initial
		S_pipe23_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) S_pipe23_reg0 <= 39'b0;
		else if  (clk_en == 1'b1)   S_pipe23_reg0 <= S_pipe23;
	// synopsys translate_off
	initial
		S_pipe24_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) S_pipe24_reg0 <= 39'b0;
		else if  (clk_en == 1'b1)   S_pipe24_reg0 <= S_pipe24;
	// synopsys translate_off
	initial
		S_wire1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) S_wire1_reg0 <= 39'b0;
		else if  (clk_en == 1'b1)   S_wire1_reg0 <= S_wire1;
	// synopsys translate_off
	initial
		S_wire2_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) S_wire2_reg0 <= 39'b0;
		else if  (clk_en == 1'b1)   S_wire2_reg0 <= S_wire2;
	// synopsys translate_off
	initial
		S_wire3_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) S_wire3_reg0 <= 39'b0;
		else if  (clk_en == 1'b1)   S_wire3_reg0 <= S_wire3;
	// synopsys translate_off
	initial
		Z_wire1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Z_wire1_reg0 <= 25'b0;
		else if  (clk_en == 1'b1)   Z_wire1_reg0 <= Z_wire1;
	// synopsys translate_off
	initial
		Z_wire2_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Z_wire2_reg0 <= 31'b0;
		else if  (clk_en == 1'b1)   Z_wire2_reg0 <= Z_wire2;
	// synopsys translate_off
	initial
		Z_wire3_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Z_wire3_reg0 <= 29'b0;
		else if  (clk_en == 1'b1)   Z_wire3_reg0 <= Z_wire3;
	lpm_mult   mult0
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(InvA0),
	.datab(y0_in),
	.result(wire_mult0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		mult0.lpm_pipeline = 2,
		mult0.lpm_representation = "UNSIGNED",
		mult0.lpm_widtha = 6,
		mult0.lpm_widthb = 25,
		mult0.lpm_widthp = 31,
		mult0.lpm_type = "lpm_mult";
	lpm_mult   mult1
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(A_wire1),
	.datab(ZM_wire1),
	.result(wire_mult1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		mult1.lpm_pipeline = 1,
		mult1.lpm_representation = "UNSIGNED",
		mult1.lpm_widtha = 4,
		mult1.lpm_widthb = 25,
		mult1.lpm_widthp = 29,
		mult1.lpm_type = "lpm_mult";
	lpm_mult   mult2
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(A_wire2),
	.datab(ZM_wire2),
	.result(wire_mult2_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		mult2.lpm_pipeline = 1,
		mult2.lpm_representation = "UNSIGNED",
		mult2.lpm_widtha = 4,
		mult2.lpm_widthb = 25,
		mult2.lpm_widthp = 29,
		mult2.lpm_type = "lpm_mult";
	lpm_mult   mult3
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(A_wire3),
	.datab(ZM_wire3),
	.result(wire_mult3_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		mult3.lpm_pipeline = 1,
		mult3.lpm_representation = "UNSIGNED",
		mult3.lpm_widtha = 4,
		mult3.lpm_widthb = 19,
		mult3.lpm_widthp = 23,
		mult3.lpm_type = "lpm_mult";
	lpm_mux   InvTable0
	( 
	.data({6'b100001, {2{6'b100010}}, {2{6'b100011}}, {2{6'b100100}}, 6'b100101, {2{6'b100110}}, 6'b100111, 6'b101000, {2{6'b101001}}, 6'b101010, 6'b101011, 6'b010110, {2{6'b010111}}, {2{6'b011000}}, {2{6'b011001}}, 6'b011010, {2{6'b011011}}, 6'b011100, 6'b011101, 6'b011110, 6'b011111, {2{6'b100000}}}),
	.result(wire_InvTable0_result),
	.sel(a0_in)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		InvTable0.lpm_size = 32,
		InvTable0.lpm_width = 6,
		InvTable0.lpm_widths = 5,
		InvTable0.lpm_type = "lpm_mux";
	lpm_mux   LogTable0
	( 
	.data({39'b111110000001111101011001001111000110001, {2{39'b111100000111101011100111100111111111100}}, {2{39'b111010010000111100101101011101010001110}}, {2{39'b111000011101100011111000100100011101011}}, 39'b110110101101010101011010000011111100001, {2{39'b110101000000000110011111000111101011001}}, 39'b110011010101101101001010110001100001100, 39'b110001101110000000010000011100001100110, {2{39'b110000001000110111001111001001010100010}}, 39'b101110100110001010001101010100010101001, 39'b101101000101110001110101000101000111110, 39'b010111111110101111101000111011110110000, {2{39'b010101001000101010111000000111001110001}}, {2{39'b010010011010010110001000010001001101001}}, {2{39'b001111110011001000111000110110010110011}}, 39'b001101010010011111011010011110010001010, {2{39'b001010110111111010000000110101101010100}}, 39'b001000100010111100011101000001000100111, 39'b000110010011001101011110010111010101100, 39'b000100001000010110011000101101011001111, 39'b000010000010000010101110110001001111001, {2{{39{1'b0}}}}}),
	.result(wire_LogTable0_result),
	.sel(A_wire0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		LogTable0.lpm_size = 32,
		LogTable0.lpm_width = 39,
		LogTable0.lpm_widths = 5,
		LogTable0.lpm_type = "lpm_mux";
	lpm_mux   LogTable1
	( 
	.data({35'b11100110010110111001111001101110111, 35'b11010101011101111001011010000111110, 35'b11000100101001010101000010100100111, 35'b10110011111001001010011110010110101, 35'b10100011001101010111011010100001011, 35'b10010010100101111001100101111100011, 35'b10000010000010101110110001001111001, 35'b01110001100011110100101110110000010, 35'b01101001010101111101010100100011000, 35'b01011000111101011000010111100001101, 35'b01001000101000111110110001111111101, 35'b00111000011000101110011100001001100, 35'b00101000001100100101001111110010110, 35'b00011000000100100001001000010100010, 35'b00001000000000100000000010101010111, {35{1'b0}}}),
	.result(wire_LogTable1_result),
	.sel(A_pipe11)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		LogTable1.lpm_size = 16,
		LogTable1.lpm_width = 35,
		LogTable1.lpm_widths = 4,
		LogTable1.lpm_type = "lpm_mux";
	lpm_mux   LogTable2
	( 
	.data({32'b11101000110100110011111101101000, 32'b11011000101101110000111000001100, 32'b11001000100111001110001110000010, 32'b10111000100001001011111101000110, 32'b10101000011011101010000011010111, 32'b10011000010110101000011110110010, 32'b10001000010010000111001101010110, 32'b01111000001110000110001101000000, 32'b01101000001010100101011011110000, 32'b01011000000111100100110111100100, 32'b01001000000101000100011110011011, 32'b00111000000011000100001110010011, 32'b00101000000001100100000101001101, 32'b00011000000000100100000001001000, 32'b00001000000000000100000000000010, {32{1'b0}}}),
	.result(wire_LogTable2_result),
	.sel(A_pipe12)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		LogTable2.lpm_size = 16,
		LogTable2.lpm_width = 32,
		LogTable2.lpm_widths = 4,
		LogTable2.lpm_type = "lpm_mux";
	lpm_mux   LogTable3
	( 
	.data({29'b11101000000110100100101111111, 29'b11011000000101101100101100110, 29'b11001000000100111000101010001, 29'b10111000000100001000100111111, 29'b10101000000011011100100110000, 29'b10011000000010110100100100011, 29'b10001000000010010000100011001, 29'b01111000000001110000100010001, 29'b01101000000001010100100001011, 29'b01011000000000111100100000110, 29'b01001000000000101000100000011, 29'b00111000000000011000100000001, 29'b00101000000000001100100000000, 29'b00011000000000000100100000000, 29'b00001000000000000000100000000, {29{1'b0}}}),
	.result(wire_LogTable3_result),
	.sel(A_pipe13)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		LogTable3.lpm_size = 16,
		LogTable3.lpm_width = 29,
		LogTable3.lpm_widths = 4,
		LogTable3.lpm_type = "lpm_mux";
	assign
		A1_is_all_zero = {(A_pipe11[3] | A1_is_all_zero[2]), (A_pipe11[2] | A1_is_all_zero[1]), (A_pipe11[1] | A1_is_all_zero[0]), A_pipe11[0]},
		A1_is_not_zero = {((~ A_pipe11[3]) & A1_is_not_zero[2]), (A_pipe11[2] | A1_is_not_zero[1]), (A_pipe11[1] | A1_is_not_zero[0]), A_pipe11[0]},
		A_all_zero2 = {((~ A_pipe12[3]) & A_all_zero2[2]), ((~ A_pipe12[2]) & A_all_zero2[1]), ((~ A_pipe12[1]) & A_all_zero2[0]), (~ A_pipe12[0])},
		A_all_zero3 = {((~ A_pipe13[3]) & A_all_zero3[2]), ((~ A_pipe13[2]) & A_all_zero3[1]), ((~ A_pipe13[1]) & A_all_zero3[0]), (~ A_pipe13[0])},
		A_pipe0 = a0_in,
		A_pipe11 = A_wire1_reg0,
		A_pipe12 = A_wire2_reg0,
		A_pipe13 = A_wire3_reg0,
		A_wire0 = A_pipe0_reg2,
		A_wire1 = Z_wire1[24:21],
		A_wire2 = Z_wire2[30:27],
		A_wire3 = Z_wire3[28:25],
		almostlog = S_wire4,
		B_pad_wire1 = {1'b0, B_pipe1, {9{1'b0}}},
		B_pad_wire2 = {1'b0, B_pipe2, 1'b0},
		B_pad_wire3 = {1'b0, B_pipe3},
		B_pipe1 = B_wire1_reg0,
		B_pipe2 = B_wire2_reg0,
		B_pipe3 = B_wire3_reg0,
		B_wire1 = Z_wire1[20:0],
		B_wire2 = Z_wire2[26:0],
		B_wire3 = Z_wire3[24:0],
		epsZ_pad_wire1 = epsZ_wire1[30:0],
		epsZ_pad_wire2 = epsZ_wire2[39:11],
		epsZ_pad_wire3 = epsZ_wire3[40:15],
		epsZ_wire1 = ({31{A1_is_all_zero[3]}} & (({31{(~ A1_is_not_zero[3])}} & mux0_data0) | ({31{A1_is_not_zero[3]}} & mux0_data1))),
		epsZ_wire2 = {1'b0, (~ A_all_zero2[3]), {7{1'b0}}, ({31{(~ A_all_zero2[3])}} & Z_pipe2)},
		epsZ_wire3 = {1'b0, (~ A_all_zero3[3]), {10{1'b0}}, ({29{(~ A_all_zero3[3])}} & Z_pipe3)},
		InvA0 = wire_InvTable0_result,
		L_wire0 = wire_LogTable0_result,
		L_wire1 = wire_LogTable1_result,
		L_wire2 = wire_LogTable2_result,
		L_wire3 = wire_LogTable3_result,
		mux0_data0 = {1'b1, {4{1'b0}}, Z_pipe1, 1'b0},
		mux0_data1 = {1'b0, 1'b1, {4{1'b0}}, Z_pipe1},
		P_pad_wire1 = {1'b0, P_wire1, 1'b0},
		P_pad_wire2 = {{4{1'b0}}, P_wire2[28:4]},
		P_pad_wire3 = {{7{1'b0}}, P_wire3[22:4]},
		P_pipe0 = wire_mult0_result,
		P_pipe1 = wire_mult1_result,
		P_pipe2 = wire_mult2_result,
		P_pipe3 = wire_mult3_result,
		P_wire0 = P_pipe0_reg0,
		P_wire1 = P_pipe1_reg0,
		P_wire2 = P_pipe2_reg0,
		P_wire3 = P_pipe3_reg0,
		S_pipe11 = S_wire1_reg0,
		S_pipe12 = S_wire2_reg0,
		S_pipe13 = S_wire3_reg0,
		S_pipe22 = wire_add0_1_result,
		S_pipe23 = wire_add0_2_result,
		S_pipe24 = wire_add0_3_result,
		S_wire1 = L_wire0,
		S_wire2 = S_pipe22_reg0,
		S_wire3 = S_pipe23_reg0,
		S_wire4 = S_pipe24_reg0,
		z = Z_wire4,
		Z_pipe1 = Z_wire1_reg0,
		Z_pipe2 = Z_wire2_reg0,
		Z_pipe3 = Z_wire3_reg0,
		Z_wire1 = P_wire0[24:0],
		Z_wire2 = wire_sub1_1_result,
		Z_wire3 = wire_sub1_2_result,
		Z_wire4 = wire_sub1_3_result,
		ZM_wire1 = Z_wire1,
		ZM_wire2 = Z_wire2[30:6],
		ZM_wire3 = Z_wire3[28:10];
endmodule //acl_fp_log_s5_range_reduction_0sd


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" PIPELINE=1 WIDTH=64 WIDTHAD=6 aclr clk_en clock data q
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" PIPELINE=0 WIDTH=32 WIDTHAD=5 data q
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=16 WIDTHAD=4 data q
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=8 WIDTHAD=3 data q
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=4 WIDTHAD=2 data q
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=2 WIDTHAD=1 data q
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_3v7
	( 
	data,
	q) ;
	input   [1:0]  data;
	output   [0:0]  q;


	assign
		q = {data[1]};
endmodule //acl_fp_log_s5_altpriority_encoder_3v7


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=2 WIDTHAD=1 data q zero
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_3e8
	( 
	data,
	q,
	zero) ;
	input   [1:0]  data;
	output   [0:0]  q;
	output   zero;


	assign
		q = {data[1]},
		zero = (~ (data[0] | data[1]));
endmodule //acl_fp_log_s5_altpriority_encoder_3e8

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_6v7
	( 
	data,
	q) ;
	input   [3:0]  data;
	output   [1:0]  q;

	wire  [0:0]   wire_altpriority_encoder14_q;
	wire  [0:0]   wire_altpriority_encoder15_q;
	wire  wire_altpriority_encoder15_zero;

	acl_fp_log_s5_altpriority_encoder_3v7   altpriority_encoder14
	( 
	.data(data[1:0]),
	.q(wire_altpriority_encoder14_q));
	acl_fp_log_s5_altpriority_encoder_3e8   altpriority_encoder15
	( 
	.data(data[3:2]),
	.q(wire_altpriority_encoder15_q),
	.zero(wire_altpriority_encoder15_zero));
	assign
		q = {(~ wire_altpriority_encoder15_zero), ((wire_altpriority_encoder15_zero & wire_altpriority_encoder14_q) | ((~ wire_altpriority_encoder15_zero) & wire_altpriority_encoder15_q))};
endmodule //acl_fp_log_s5_altpriority_encoder_6v7


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=4 WIDTHAD=2 data q zero
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_6e8
	( 
	data,
	q,
	zero) ;
	input   [3:0]  data;
	output   [1:0]  q;
	output   zero;

	wire  [0:0]   wire_altpriority_encoder16_q;
	wire  wire_altpriority_encoder16_zero;
	wire  [0:0]   wire_altpriority_encoder17_q;
	wire  wire_altpriority_encoder17_zero;

	acl_fp_log_s5_altpriority_encoder_3e8   altpriority_encoder16
	( 
	.data(data[1:0]),
	.q(wire_altpriority_encoder16_q),
	.zero(wire_altpriority_encoder16_zero));
	acl_fp_log_s5_altpriority_encoder_3e8   altpriority_encoder17
	( 
	.data(data[3:2]),
	.q(wire_altpriority_encoder17_q),
	.zero(wire_altpriority_encoder17_zero));
	assign
		q = {(~ wire_altpriority_encoder17_zero), ((wire_altpriority_encoder17_zero & wire_altpriority_encoder16_q) | ((~ wire_altpriority_encoder17_zero) & wire_altpriority_encoder17_q))},
		zero = (wire_altpriority_encoder16_zero & wire_altpriority_encoder17_zero);
endmodule //acl_fp_log_s5_altpriority_encoder_6e8

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_bv7
	( 
	data,
	q) ;
	input   [7:0]  data;
	output   [2:0]  q;

	wire  [1:0]   wire_altpriority_encoder12_q;
	wire  [1:0]   wire_altpriority_encoder13_q;
	wire  wire_altpriority_encoder13_zero;

	acl_fp_log_s5_altpriority_encoder_6v7   altpriority_encoder12
	( 
	.data(data[3:0]),
	.q(wire_altpriority_encoder12_q));
	acl_fp_log_s5_altpriority_encoder_6e8   altpriority_encoder13
	( 
	.data(data[7:4]),
	.q(wire_altpriority_encoder13_q),
	.zero(wire_altpriority_encoder13_zero));
	assign
		q = {(~ wire_altpriority_encoder13_zero), (({2{wire_altpriority_encoder13_zero}} & wire_altpriority_encoder12_q) | ({2{(~ wire_altpriority_encoder13_zero)}} & wire_altpriority_encoder13_q))};
endmodule //acl_fp_log_s5_altpriority_encoder_bv7


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=8 WIDTHAD=3 data q zero
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_be8
	( 
	data,
	q,
	zero) ;
	input   [7:0]  data;
	output   [2:0]  q;
	output   zero;

	wire  [1:0]   wire_altpriority_encoder18_q;
	wire  wire_altpriority_encoder18_zero;
	wire  [1:0]   wire_altpriority_encoder19_q;
	wire  wire_altpriority_encoder19_zero;

	acl_fp_log_s5_altpriority_encoder_6e8   altpriority_encoder18
	( 
	.data(data[3:0]),
	.q(wire_altpriority_encoder18_q),
	.zero(wire_altpriority_encoder18_zero));
	acl_fp_log_s5_altpriority_encoder_6e8   altpriority_encoder19
	( 
	.data(data[7:4]),
	.q(wire_altpriority_encoder19_q),
	.zero(wire_altpriority_encoder19_zero));
	assign
		q = {(~ wire_altpriority_encoder19_zero), (({2{wire_altpriority_encoder19_zero}} & wire_altpriority_encoder18_q) | ({2{(~ wire_altpriority_encoder19_zero)}} & wire_altpriority_encoder19_q))},
		zero = (wire_altpriority_encoder18_zero & wire_altpriority_encoder19_zero);
endmodule //acl_fp_log_s5_altpriority_encoder_be8

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_r08
	( 
	data,
	q) ;
	input   [15:0]  data;
	output   [3:0]  q;

	wire  [2:0]   wire_altpriority_encoder10_q;
	wire  [2:0]   wire_altpriority_encoder11_q;
	wire  wire_altpriority_encoder11_zero;

	acl_fp_log_s5_altpriority_encoder_bv7   altpriority_encoder10
	( 
	.data(data[7:0]),
	.q(wire_altpriority_encoder10_q));
	acl_fp_log_s5_altpriority_encoder_be8   altpriority_encoder11
	( 
	.data(data[15:8]),
	.q(wire_altpriority_encoder11_q),
	.zero(wire_altpriority_encoder11_zero));
	assign
		q = {(~ wire_altpriority_encoder11_zero), (({3{wire_altpriority_encoder11_zero}} & wire_altpriority_encoder10_q) | ({3{(~ wire_altpriority_encoder11_zero)}} & wire_altpriority_encoder11_q))};
endmodule //acl_fp_log_s5_altpriority_encoder_r08


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=16 WIDTHAD=4 data q zero
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_rf8
	( 
	data,
	q,
	zero) ;
	input   [15:0]  data;
	output   [3:0]  q;
	output   zero;

	wire  [2:0]   wire_altpriority_encoder20_q;
	wire  wire_altpriority_encoder20_zero;
	wire  [2:0]   wire_altpriority_encoder21_q;
	wire  wire_altpriority_encoder21_zero;

	acl_fp_log_s5_altpriority_encoder_be8   altpriority_encoder20
	( 
	.data(data[7:0]),
	.q(wire_altpriority_encoder20_q),
	.zero(wire_altpriority_encoder20_zero));
	acl_fp_log_s5_altpriority_encoder_be8   altpriority_encoder21
	( 
	.data(data[15:8]),
	.q(wire_altpriority_encoder21_q),
	.zero(wire_altpriority_encoder21_zero));
	assign
		q = {(~ wire_altpriority_encoder21_zero), (({3{wire_altpriority_encoder21_zero}} & wire_altpriority_encoder20_q) | ({3{(~ wire_altpriority_encoder21_zero)}} & wire_altpriority_encoder21_q))},
		zero = (wire_altpriority_encoder20_zero & wire_altpriority_encoder21_zero);
endmodule //acl_fp_log_s5_altpriority_encoder_rf8

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_tv8
	( 
	data,
	q) ;
	input   [31:0]  data;
	output   [4:0]  q;

	wire  [3:0]   wire_altpriority_encoder8_q;
	wire  [3:0]   wire_altpriority_encoder9_q;
	wire  wire_altpriority_encoder9_zero;

	acl_fp_log_s5_altpriority_encoder_r08   altpriority_encoder8
	( 
	.data(data[15:0]),
	.q(wire_altpriority_encoder8_q));
	acl_fp_log_s5_altpriority_encoder_rf8   altpriority_encoder9
	( 
	.data(data[31:16]),
	.q(wire_altpriority_encoder9_q),
	.zero(wire_altpriority_encoder9_zero));
	assign
		q = {(~ wire_altpriority_encoder9_zero), (({4{wire_altpriority_encoder9_zero}} & wire_altpriority_encoder8_q) | ({4{(~ wire_altpriority_encoder9_zero)}} & wire_altpriority_encoder9_q))};
endmodule //acl_fp_log_s5_altpriority_encoder_tv8


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" PIPELINE=0 WIDTH=32 WIDTHAD=5 data q zero
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_te9
	( 
	data,
	q,
	zero) ;
	input   [31:0]  data;
	output   [4:0]  q;
	output   zero;

	wire  [3:0]   wire_altpriority_encoder22_q;
	wire  wire_altpriority_encoder22_zero;
	wire  [3:0]   wire_altpriority_encoder23_q;
	wire  wire_altpriority_encoder23_zero;

	acl_fp_log_s5_altpriority_encoder_rf8   altpriority_encoder22
	( 
	.data(data[15:0]),
	.q(wire_altpriority_encoder22_q),
	.zero(wire_altpriority_encoder22_zero));
	acl_fp_log_s5_altpriority_encoder_rf8   altpriority_encoder23
	( 
	.data(data[31:16]),
	.q(wire_altpriority_encoder23_q),
	.zero(wire_altpriority_encoder23_zero));
	assign
		q = {(~ wire_altpriority_encoder23_zero), (({4{wire_altpriority_encoder23_zero}} & wire_altpriority_encoder22_q) | ({4{(~ wire_altpriority_encoder23_zero)}} & wire_altpriority_encoder23_q))},
		zero = (wire_altpriority_encoder22_zero & wire_altpriority_encoder23_zero);
endmodule //acl_fp_log_s5_altpriority_encoder_te9

//synthesis_resources = reg 6 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_uja
	( 
	aclr,
	clk_en,
	clock,
	data,
	q) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [63:0]  data;
	output   [5:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clk_en;
	tri0   clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [4:0]   wire_altpriority_encoder6_q;
	wire  [4:0]   wire_altpriority_encoder7_q;
	wire  wire_altpriority_encoder7_zero;
	reg	[5:0]	pipeline_q_dffe;
	wire  [5:0]  tmp_q_wire;

	acl_fp_log_s5_altpriority_encoder_tv8   altpriority_encoder6
	( 
	.data(data[31:0]),
	.q(wire_altpriority_encoder6_q));
	acl_fp_log_s5_altpriority_encoder_te9   altpriority_encoder7
	( 
	.data(data[63:32]),
	.q(wire_altpriority_encoder7_q),
	.zero(wire_altpriority_encoder7_zero));
	// synopsys translate_off
	initial
		pipeline_q_dffe = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) pipeline_q_dffe <= 6'b0;
		else if  (clk_en == 1'b1)   pipeline_q_dffe <= tmp_q_wire;
	assign
		q = pipeline_q_dffe,
		tmp_q_wire = {(~ wire_altpriority_encoder7_zero), (({5{wire_altpriority_encoder7_zero}} & wire_altpriority_encoder6_q) | ({5{(~ wire_altpriority_encoder7_zero)}} & wire_altpriority_encoder7_q))};
endmodule //acl_fp_log_s5_altpriority_encoder_uja


//altpriority_encoder CBX_AUTO_BLACKBOX="ALL" LSB_PRIORITY="NO" WIDTH=32 WIDTHAD=5 data q
//VERSION_BEGIN 12.0 cbx_altpriority_encoder 2012:05:31:20:08:02:SJ cbx_mgl 2012:05:31:20:10:16:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altpriority_encoder_q08
	( 
	data,
	q) ;
	input   [31:0]  data;
	output   [4:0]  q;

	wire  [3:0]   wire_altpriority_encoder24_q;
	wire  [3:0]   wire_altpriority_encoder25_q;
	wire  wire_altpriority_encoder25_zero;

	acl_fp_log_s5_altpriority_encoder_r08   altpriority_encoder24
	( 
	.data(data[15:0]),
	.q(wire_altpriority_encoder24_q));
	acl_fp_log_s5_altpriority_encoder_rf8   altpriority_encoder25
	( 
	.data(data[31:16]),
	.q(wire_altpriority_encoder25_q),
	.zero(wire_altpriority_encoder25_zero));
	assign
		q = {(~ wire_altpriority_encoder25_zero), (({4{wire_altpriority_encoder25_zero}} & wire_altpriority_encoder24_q) | ({4{(~ wire_altpriority_encoder25_zero)}} & wire_altpriority_encoder25_q))};
endmodule //acl_fp_log_s5_altpriority_encoder_q08

//synthesis_resources = altsquare 1 lpm_add_sub 42 lpm_mult 5 lpm_mux 5 mux21 31 reg 1563 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  acl_fp_log_s5_altfp_log_82b
	( 
	clk_en,
	clock,
	data,
	result) ;
	input   clk_en;
	input   clock;
	input   [31:0]  data;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   clk_en;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [31:0]   wire_Lshiftsmall_result;
	wire  [63:0]   wire_lzc_norm_L_result;
	wire  [31:0]   wire_Rshiftsmall_result;
	wire  wire_exp_nan_result;
	wire  wire_exp_zero_result;
	wire  wire_man_inf_result;
	wire  wire_man_nan_result;
	wire  [38:0]   wire_add1_result;
	wire  [30:0]   wire_add2_result;
	wire  [7:0]   wire_exp_biase_sub_result;
	wire  [11:0]   wire_sub1_result;
	wire  [7:0]   wire_sub2_result;
	wire  [5:0]   wire_sub3_result;
	wire  [25:0]   wire_sub4_result;
	wire  [7:0]   wire_sub5_result;
	wire  [7:0]   wire_sub6_result;
	wire  [38:0]   wire_range_reduction_almostlog;
	wire  [25:0]   wire_range_reduction_z;
	wire  [5:0]   wire_lzc_norm_E_q;
	wire  [4:0]   wire_lzoc_q;
	wire  [13:0]   wire_squarer_result;
	reg	[34:0]	absELog2_pipe_reg0;
	reg	[34:0]	absELog2_pipe_reg1;
	reg	[34:0]	absELog2_pipe_reg2;
	reg	[11:0]	absZ0_pipe_reg0;
	reg	[11:0]	absZ0_pipe_reg1;
	reg	[11:0]	absZ0_pipe_reg2;
	reg	[11:0]	absZ0_pipe_reg3;
	reg	[11:0]	absZ0_pipe_reg4;
	reg	[11:0]	absZ0_pipe_reg5;
	reg	[11:0]	absZ0_pipe_reg6;
	reg	[11:0]	absZ0_pipe_reg7;
	reg	[11:0]	absZ0_pipe_reg8;
	reg	[11:0]	absZ0_pipe_reg9;
	reg	[11:0]	absZ0s_pipe1_reg0;
	reg	[11:0]	absZ0s_pipe1_reg1;
	reg	[11:0]	absZ0s_pipe1_reg2;
	reg	[11:0]	absZ0s_pipe1_reg3;
	reg	[11:0]	absZ0s_reg0;
	reg	[38:0]	almostLog_pipe_reg0;
	reg	[38:0]	almostLog_pipe_reg1;
	reg	[38:0]	almostLog_pipe_reg2;
	reg	[0:0]	doRR_reg0;
	reg	[0:0]	doRR_reg1;
	reg	[7:0]	E0_pipe_reg0;
	reg	[7:0]	E0_pipe_reg1;
	reg	[7:0]	E0_pipe_reg2;
	reg	[7:0]	E0_pipe_reg3;
	reg	[7:0]	E0_pipe_reg4;
	reg	[7:0]	E0_pipe_reg5;
	reg	[7:0]	E0_pipe_reg6;
	reg	[7:0]	E0_pipe_reg7;
	reg	[7:0]	E0_pipe_reg8;
	reg	[7:0]	E0_pipe_reg9;
	reg	[4:0]	E_normal_pipe_reg0;
	reg	[0:0]	exp_is_ebiase_pipe_reg0;
	reg	[0:0]	exp_is_ebiase_pipe_reg1;
	reg	[0:0]	exp_is_ebiase_pipe_reg2;
	reg	[0:0]	input_is_infinity_pipe_reg0;
	reg	[0:0]	input_is_infinity_pipe_reg1;
	reg	[0:0]	input_is_infinity_pipe_reg10;
	reg	[0:0]	input_is_infinity_pipe_reg11;
	reg	[0:0]	input_is_infinity_pipe_reg12;
	reg	[0:0]	input_is_infinity_pipe_reg13;
	reg	[0:0]	input_is_infinity_pipe_reg14;
	reg	[0:0]	input_is_infinity_pipe_reg15;
	reg	[0:0]	input_is_infinity_pipe_reg16;
	reg	[0:0]	input_is_infinity_pipe_reg17;
	reg	[0:0]	input_is_infinity_pipe_reg2;
	reg	[0:0]	input_is_infinity_pipe_reg3;
	reg	[0:0]	input_is_infinity_pipe_reg4;
	reg	[0:0]	input_is_infinity_pipe_reg5;
	reg	[0:0]	input_is_infinity_pipe_reg6;
	reg	[0:0]	input_is_infinity_pipe_reg7;
	reg	[0:0]	input_is_infinity_pipe_reg8;
	reg	[0:0]	input_is_infinity_pipe_reg9;
	reg	[0:0]	input_is_nan_pipe_reg0;
	reg	[0:0]	input_is_nan_pipe_reg1;
	reg	[0:0]	input_is_nan_pipe_reg10;
	reg	[0:0]	input_is_nan_pipe_reg11;
	reg	[0:0]	input_is_nan_pipe_reg12;
	reg	[0:0]	input_is_nan_pipe_reg13;
	reg	[0:0]	input_is_nan_pipe_reg14;
	reg	[0:0]	input_is_nan_pipe_reg15;
	reg	[0:0]	input_is_nan_pipe_reg16;
	reg	[0:0]	input_is_nan_pipe_reg17;
	reg	[0:0]	input_is_nan_pipe_reg2;
	reg	[0:0]	input_is_nan_pipe_reg3;
	reg	[0:0]	input_is_nan_pipe_reg4;
	reg	[0:0]	input_is_nan_pipe_reg5;
	reg	[0:0]	input_is_nan_pipe_reg6;
	reg	[0:0]	input_is_nan_pipe_reg7;
	reg	[0:0]	input_is_nan_pipe_reg8;
	reg	[0:0]	input_is_nan_pipe_reg9;
	reg	[0:0]	input_is_one_pipe_reg0;
	reg	[0:0]	input_is_one_pipe_reg1;
	reg	[0:0]	input_is_one_pipe_reg10;
	reg	[0:0]	input_is_one_pipe_reg11;
	reg	[0:0]	input_is_one_pipe_reg12;
	reg	[0:0]	input_is_one_pipe_reg13;
	reg	[0:0]	input_is_one_pipe_reg14;
	reg	[0:0]	input_is_one_pipe_reg15;
	reg	[0:0]	input_is_one_pipe_reg16;
	reg	[0:0]	input_is_one_pipe_reg17;
	reg	[0:0]	input_is_one_pipe_reg2;
	reg	[0:0]	input_is_one_pipe_reg3;
	reg	[0:0]	input_is_one_pipe_reg4;
	reg	[0:0]	input_is_one_pipe_reg5;
	reg	[0:0]	input_is_one_pipe_reg6;
	reg	[0:0]	input_is_one_pipe_reg7;
	reg	[0:0]	input_is_one_pipe_reg8;
	reg	[0:0]	input_is_one_pipe_reg9;
	reg	[0:0]	input_is_zero_pipe_reg0;
	reg	[0:0]	input_is_zero_pipe_reg1;
	reg	[0:0]	input_is_zero_pipe_reg10;
	reg	[0:0]	input_is_zero_pipe_reg11;
	reg	[0:0]	input_is_zero_pipe_reg12;
	reg	[0:0]	input_is_zero_pipe_reg13;
	reg	[0:0]	input_is_zero_pipe_reg14;
	reg	[0:0]	input_is_zero_pipe_reg15;
	reg	[0:0]	input_is_zero_pipe_reg16;
	reg	[0:0]	input_is_zero_pipe_reg17;
	reg	[0:0]	input_is_zero_pipe_reg2;
	reg	[0:0]	input_is_zero_pipe_reg3;
	reg	[0:0]	input_is_zero_pipe_reg4;
	reg	[0:0]	input_is_zero_pipe_reg5;
	reg	[0:0]	input_is_zero_pipe_reg6;
	reg	[0:0]	input_is_zero_pipe_reg7;
	reg	[0:0]	input_is_zero_pipe_reg8;
	reg	[0:0]	input_is_zero_pipe_reg9;
	reg	[46:0]	Log_normal_normd_pipe_reg0;
	reg	[46:0]	Log_normal_reg0;
	reg	[26:0]	Log_small_normd_pipe_reg0;
	reg	[26:0]	Log_small_normd_pipe_reg1;
	reg	[5:0]	Lshiftval_reg0;
	reg	[5:0]	Lshiftval_reg1;
	reg	[5:0]	Lshiftval_reg2;
	reg	[5:0]	Lshiftval_reg3;
	reg	[4:0]	lzo_pipe1_reg0;
	reg	[4:0]	lzo_pipe1_reg1;
	reg	[4:0]	lzo_pipe1_reg2;
	reg	[4:0]	lzo_pipe1_reg3;
	reg	[4:0]	lzo_pipe1_reg4;
	reg	[4:0]	lzo_pipe1_reg5;
	reg	[4:0]	lzo_pipe1_reg6;
	reg	[4:0]	lzo_pipe1_reg7;
	reg	[4:0]	lzo_pipe1_reg8;
	reg	[4:0]	lzo_pipe1_reg9;
	reg	[4:0]	lzo_reg0;
	reg	[4:0]	lzo_reg1;
	reg	[4:0]	lzo_reg2;
	reg	[4:0]	lzo_reg3;
	reg	[4:0]	lzo_reg4;
	reg	[4:0]	lzo_reg5;
	reg	[4:0]	lzo_reg6;
	reg	[4:0]	lzo_reg7;
	reg	[0:0]	sign_data_reg0;
	reg	[0:0]	sign_data_reg1;
	reg	[0:0]	sign_data_reg2;
	reg	[0:0]	small_flag_pipe_reg0;
	reg	[0:0]	small_flag_pipe_reg1;
	reg	[0:0]	small_flag_pipe_reg2;
	reg	[0:0]	small_flag_pipe_reg3;
	reg	[0:0]	small_flag_pipe_reg4;
	reg	[0:0]	small_flag_pipe_reg5;
	reg	[0:0]	small_flag_pipe_reg6;
	reg	[0:0]	small_flag_pipe_reg7;
	reg	[0:0]	small_flag_pipe_reg8;
	reg	[0:0]	small_flag_pipe_reg9;
	reg	[0:0]	sR_pipe1_reg0;
	reg	[0:0]	sR_pipe1_reg1;
	reg	[0:0]	sR_pipe1_reg2;
	reg	[0:0]	sR_pipe1_reg3;
	reg	[0:0]	sR_pipe1_reg4;
	reg	[0:0]	sR_pipe1_reg5;
	reg	[0:0]	sR_pipe1_reg6;
	reg	[0:0]	sR_pipe1_reg7;
	reg	[0:0]	sR_pipe1_reg8;
	reg	[0:0]	sR_pipe1_reg9;
	reg	[0:0]	sR_pipe2_reg0;
	reg	[0:0]	sR_pipe2_reg1;
	reg	[0:0]	sR_pipe2_reg2;
	reg	[0:0]	sR_pipe2_reg3;
	reg	[0:0]	sR_pipe2_reg4;
	reg	[0:0]	sR_pipe2_reg5;
	reg	[0:0]	sR_pipe3_reg0;
	reg	[0:0]	sR_pipe3_reg1;
	reg	[0:0]	sR_pipe3_reg2;
	reg	[0:0]	sR_pipe3_reg3;
	reg	[0:0]	sR_pipe3_reg4;
	reg	[13:0]	Z2o2_pipe_reg0;
	reg	[13:0]	Z2o2_small_s_pipe_reg0;
	reg	[25:0]	Zfinal_reg0;
	reg	[25:0]	Zfinal_reg1;
	wire  [28:0]   wire_addsub1_result;
	wire  [46:0]   wire_addsub2_result;
	wire  [34:0]   wire_mult1_result;
	wire	[30:0]wire_mux_result0a_dataout;
	wire  [7:0]  absE;
	wire  [34:0]  absELog2;
	wire  [46:0]  absELog2_pad;
	wire  [34:0]  absELog2_pipe;
	wire  [11:0]  absZ0;
	wire  [11:0]  absZ0_pipe;
	wire  [11:0]  absZ0s;
	wire  [11:0]  absZ0s_pipe1;
	wire  [11:0]  absZ0s_pipe2;
	wire aclr;
	wire  [38:0]  almostLog;
	wire  [38:0]  almostLog_pipe;
	wire  [7:0]  data_exp_is_ebiase;
	wire  doRR;
	wire  doRR_pipe;
	wire  [7:0]  E0;
	wire  [7:0]  E0_is_zero;
	wire  [7:0]  E0_pipe;
	wire  [1:0]  E0_sub;
	wire  [7:0]  E0offset;
	wire  [4:0]  E_normal;
	wire  [4:0]  E_normal_pipe;
	wire  [7:0]  E_small;
	wire  [30:0]  EFR;
	wire  [7:0]  ER;
	wire  exp_all_one;
	wire  exp_all_zero;
	wire  [7:0]  exp_biase;
	wire  [7:0]  exp_data;
	wire  exp_is_ebiase;
	wire  exp_is_ebiase_pipe;
	wire  First_bit;
	wire  input_is_infinity;
	wire  input_is_infinity_pipe;
	wire  input_is_nan;
	wire  input_is_nan_pipe;
	wire  input_is_one;
	wire  input_is_one_pipe;
	wire  input_is_zero;
	wire  input_is_zero_pipe;
	wire  [25:0]  Log1p_normal;
	wire  [26:0]  Log2;
	wire  [26:0]  Log_g;
	wire  [46:0]  Log_normal;
	wire  [46:0]  Log_normal_normd;
	wire  [46:0]  Log_normal_normd_pipe;
	wire  [46:0]  Log_normal_pipe;
	wire  [28:0]  Log_small;
	wire  [26:0]  Log_small1;
	wire  [26:0]  Log_small2;
	wire  [26:0]  Log_small_normd;
	wire  [26:0]  Log_small_normd_pipe;
	wire  [38:0]  LogF_normal;
	wire  [46:0]  LogF_normal_pad;
	wire  [5:0]  Lshiftval;
	wire  [4:0]  lzo;
	wire  [4:0]  lzo_pipe1;
	wire  [4:0]  lzo_pipe2;
	wire  [24:0]  man_above_half;
	wire  man_all_zero;
	wire  [24:0]  man_below_half;
	wire  [22:0]  man_data;
	wire  man_not_zero;
	wire  [4:0]  pfinal_s;
	wire  round;
	wire  [5:0]  Rshiftval;
	wire  sign_data;
	wire  sign_data_pipe;
	wire  small_flag;
	wire  small_flag_pipe;
	wire  [12:0]  squarerIn;
	wire  [12:0]  squarerIn0;
	wire  [12:0]  squarerIn1;
	wire  sR;
	wire  sR_pipe1;
	wire  sR_pipe2;
	wire  sR_pipe3;
	wire  [2:0]  sticky;
	wire  [24:0]  Y0;
	wire  [13:0]  Z2o2;
	wire  [13:0]  Z2o2_pipe;
	wire  [28:0]  Z2o2_small;
	wire  [13:0]  Z2o2_small_s;
	wire  [13:0]  Z2o2_small_s_pipe;
	wire  [28:0]  Z_small;
	wire  [25:0]  Zfinal;
	wire  [25:0]  Zfinal_pipe;

	acl_fp_log_s5_altbarrel_shift_kud   Lshiftsmall
	( 
	.aclr(aclr),
	.clk_en(clk_en),
	.clock(clock),
	.data({absZ0, {20{1'b0}}}),
	.distance(Lshiftval[4:0]),
	.result(wire_Lshiftsmall_result));
	acl_fp_log_s5_altbarrel_shift_sbb   lzc_norm_L
	( 
	.data({Log_normal_pipe, {17{1'b0}}}),
	.distance((~ wire_lzc_norm_E_q)),
	.result(wire_lzc_norm_L_result));
	acl_fp_log_s5_altbarrel_shift_72e   Rshiftsmall
	( 
	.aclr(aclr),
	.clk_en(clk_en),
	.clock(clock),
	.data({Z2o2, {18{1'b0}}}),
	.distance(Rshiftval[4:0]),
	.result(wire_Rshiftsmall_result));
	acl_fp_log_s5_altfp_log_and_or_h9b   exp_nan
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.data(exp_data),
	.result(wire_exp_nan_result));
	acl_fp_log_s5_altfp_log_and_or_v6b   exp_zero
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.data(exp_data),
	.result(wire_exp_zero_result));
	acl_fp_log_s5_altfp_log_and_or_c8b   man_inf
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.data(man_data),
	.result(wire_man_inf_result));
	acl_fp_log_s5_altfp_log_and_or_c8b   man_nan
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.data(man_data),
	.result(wire_man_nan_result));
	acl_fp_log_s5_altfp_log_csa_s0e   add1
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa({{13{1'b0}}, Log1p_normal}),
	.datab(almostLog),
	.result(wire_add1_result));
	acl_fp_log_s5_altfp_log_csa_k0e   add2
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa({ER, Log_g[26:4]}),
	.datab({{30{1'b0}}, round}),
	.result(wire_add2_result));
	acl_fp_log_s5_altfp_log_csa_0nc   exp_biase_sub
	( 
	.dataa(exp_data),
	.datab(exp_biase),
	.result(wire_exp_biase_sub_result));
	acl_fp_log_s5_altfp_log_csa_d4b   sub1
	( 
	.dataa({12{1'b0}}),
	.datab(Y0[11:0]),
	.result(wire_sub1_result));
	acl_fp_log_s5_altfp_log_csa_0nc   sub2
	( 
	.dataa({8{1'b0}}),
	.datab(E0),
	.result(wire_sub2_result));
	acl_fp_log_s5_altfp_log_csa_umc   sub3
	( 
	.dataa({1'b0, lzo}),
	.datab({1'b0, pfinal_s}),
	.result(wire_sub3_result));
	acl_fp_log_s5_altfp_log_csa_nlf   sub4
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(Zfinal_pipe),
	.datab({{14{1'b0}}, Z2o2[13:2]}),
	.result(wire_sub4_result));
	acl_fp_log_s5_altfp_log_csa_8kf   sub5
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa({1'b0, {5{1'b1}}, E0_sub}),
	.datab({{3{1'b0}}, lzo_pipe2}),
	.result(wire_sub5_result));
	acl_fp_log_s5_altfp_log_csa_0nc   sub6
	( 
	.dataa(E0offset),
	.datab({{3{1'b0}}, (~ E_normal)}),
	.result(wire_sub6_result));
	acl_fp_log_s5_range_reduction_0sd   range_reduction
	( 
	.a0_in(man_data[22:18]),
	.aclr(aclr),
	.almostlog(wire_range_reduction_almostlog),
	.clk_en(clk_en),
	.clock(clock),
	.y0_in(Y0),
	.z(wire_range_reduction_z));
	acl_fp_log_s5_altpriority_encoder_uja   lzc_norm_E
	( 
	.aclr(aclr),
	.clk_en(clk_en),
	.clock(clock),
	.data({Log_normal, 17'b00000000000000001}),
	.q(wire_lzc_norm_E_q));
	acl_fp_log_s5_altpriority_encoder_q08   lzoc
	( 
	.data({({23{First_bit}} ^ Y0[23:1]), 9'b000000001}),
	.q(wire_lzoc_q));
	altsquare   squarer
	( 
	.aclr(aclr),
	.clock(clock),
	.data(squarerIn),
	.ena(clk_en),
	.result(wire_squarer_result));
	defparam
		squarer.data_width = 13,
		squarer.pipeline = 1,
		squarer.representation = "UNSIGNED",
		squarer.result_alignment = "MSB",
		squarer.result_width = 14,
		squarer.lpm_type = "altsquare";
	// synopsys translate_off
	initial
		absELog2_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absELog2_pipe_reg0 <= 35'b0;
		else if  (clk_en == 1'b1)   absELog2_pipe_reg0 <= absELog2_pipe;
	// synopsys translate_off
	initial
		absELog2_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absELog2_pipe_reg1 <= 35'b0;
		else if  (clk_en == 1'b1)   absELog2_pipe_reg1 <= absELog2_pipe_reg0;
	// synopsys translate_off
	initial
		absELog2_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absELog2_pipe_reg2 <= 35'b0;
		else if  (clk_en == 1'b1)   absELog2_pipe_reg2 <= absELog2_pipe_reg1;
	// synopsys translate_off
	initial
		absZ0_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg0 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg0 <= absZ0_pipe;
	// synopsys translate_off
	initial
		absZ0_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg1 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg1 <= absZ0_pipe_reg0;
	// synopsys translate_off
	initial
		absZ0_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg2 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg2 <= absZ0_pipe_reg1;
	// synopsys translate_off
	initial
		absZ0_pipe_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg3 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg3 <= absZ0_pipe_reg2;
	// synopsys translate_off
	initial
		absZ0_pipe_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg4 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg4 <= absZ0_pipe_reg3;
	// synopsys translate_off
	initial
		absZ0_pipe_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg5 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg5 <= absZ0_pipe_reg4;
	// synopsys translate_off
	initial
		absZ0_pipe_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg6 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg6 <= absZ0_pipe_reg5;
	// synopsys translate_off
	initial
		absZ0_pipe_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg7 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg7 <= absZ0_pipe_reg6;
	// synopsys translate_off
	initial
		absZ0_pipe_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg8 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg8 <= absZ0_pipe_reg7;
	// synopsys translate_off
	initial
		absZ0_pipe_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0_pipe_reg9 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0_pipe_reg9 <= absZ0_pipe_reg8;
	// synopsys translate_off
	initial
		absZ0s_pipe1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0s_pipe1_reg0 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0s_pipe1_reg0 <= absZ0s_pipe1;
	// synopsys translate_off
	initial
		absZ0s_pipe1_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0s_pipe1_reg1 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0s_pipe1_reg1 <= absZ0s_pipe1_reg0;
	// synopsys translate_off
	initial
		absZ0s_pipe1_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0s_pipe1_reg2 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0s_pipe1_reg2 <= absZ0s_pipe1_reg1;
	// synopsys translate_off
	initial
		absZ0s_pipe1_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0s_pipe1_reg3 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0s_pipe1_reg3 <= absZ0s_pipe1_reg2;
	// synopsys translate_off
	initial
		absZ0s_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) absZ0s_reg0 <= 12'b0;
		else if  (clk_en == 1'b1)   absZ0s_reg0 <= absZ0s;
	// synopsys translate_off
	initial
		almostLog_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) almostLog_pipe_reg0 <= 39'b0;
		else if  (clk_en == 1'b1)   almostLog_pipe_reg0 <= almostLog_pipe;
	// synopsys translate_off
	initial
		almostLog_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) almostLog_pipe_reg1 <= 39'b0;
		else if  (clk_en == 1'b1)   almostLog_pipe_reg1 <= almostLog_pipe_reg0;
	// synopsys translate_off
	initial
		almostLog_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) almostLog_pipe_reg2 <= 39'b0;
		else if  (clk_en == 1'b1)   almostLog_pipe_reg2 <= almostLog_pipe_reg1;
	// synopsys translate_off
	initial
		doRR_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) doRR_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   doRR_reg0 <= doRR;
	// synopsys translate_off
	initial
		doRR_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) doRR_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   doRR_reg1 <= doRR_reg0;
	// synopsys translate_off
	initial
		E0_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg0 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg0 <= E0_pipe;
	// synopsys translate_off
	initial
		E0_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg1 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg1 <= E0_pipe_reg0;
	// synopsys translate_off
	initial
		E0_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg2 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg2 <= E0_pipe_reg1;
	// synopsys translate_off
	initial
		E0_pipe_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg3 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg3 <= E0_pipe_reg2;
	// synopsys translate_off
	initial
		E0_pipe_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg4 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg4 <= E0_pipe_reg3;
	// synopsys translate_off
	initial
		E0_pipe_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg5 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg5 <= E0_pipe_reg4;
	// synopsys translate_off
	initial
		E0_pipe_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg6 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg6 <= E0_pipe_reg5;
	// synopsys translate_off
	initial
		E0_pipe_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg7 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg7 <= E0_pipe_reg6;
	// synopsys translate_off
	initial
		E0_pipe_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg8 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg8 <= E0_pipe_reg7;
	// synopsys translate_off
	initial
		E0_pipe_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E0_pipe_reg9 <= 8'b0;
		else if  (clk_en == 1'b1)   E0_pipe_reg9 <= E0_pipe_reg8;
	// synopsys translate_off
	initial
		E_normal_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) E_normal_pipe_reg0 <= 5'b0;
		else if  (clk_en == 1'b1)   E_normal_pipe_reg0 <= E_normal_pipe;
	// synopsys translate_off
	initial
		exp_is_ebiase_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exp_is_ebiase_pipe_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   exp_is_ebiase_pipe_reg0 <= exp_is_ebiase_pipe;
	// synopsys translate_off
	initial
		exp_is_ebiase_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exp_is_ebiase_pipe_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   exp_is_ebiase_pipe_reg1 <= exp_is_ebiase_pipe_reg0;
	// synopsys translate_off
	initial
		exp_is_ebiase_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exp_is_ebiase_pipe_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   exp_is_ebiase_pipe_reg2 <= exp_is_ebiase_pipe_reg1;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg0 <= input_is_infinity_pipe;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg1 <= input_is_infinity_pipe_reg0;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg10 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg10 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg10 <= input_is_infinity_pipe_reg9;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg11 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg11 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg11 <= input_is_infinity_pipe_reg10;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg12 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg12 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg12 <= input_is_infinity_pipe_reg11;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg13 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg13 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg13 <= input_is_infinity_pipe_reg12;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg14 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg14 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg14 <= input_is_infinity_pipe_reg13;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg15 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg15 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg15 <= input_is_infinity_pipe_reg14;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg16 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg16 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg16 <= input_is_infinity_pipe_reg15;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg17 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg17 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg17 <= input_is_infinity_pipe_reg16;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg2 <= input_is_infinity_pipe_reg1;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg3 <= input_is_infinity_pipe_reg2;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg4 <= input_is_infinity_pipe_reg3;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg5 <= input_is_infinity_pipe_reg4;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg6 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg6 <= input_is_infinity_pipe_reg5;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg7 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg7 <= input_is_infinity_pipe_reg6;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg8 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg8 <= input_is_infinity_pipe_reg7;
	// synopsys translate_off
	initial
		input_is_infinity_pipe_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_infinity_pipe_reg9 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_infinity_pipe_reg9 <= input_is_infinity_pipe_reg8;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg0 <= input_is_nan_pipe;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg1 <= input_is_nan_pipe_reg0;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg10 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg10 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg10 <= input_is_nan_pipe_reg9;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg11 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg11 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg11 <= input_is_nan_pipe_reg10;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg12 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg12 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg12 <= input_is_nan_pipe_reg11;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg13 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg13 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg13 <= input_is_nan_pipe_reg12;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg14 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg14 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg14 <= input_is_nan_pipe_reg13;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg15 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg15 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg15 <= input_is_nan_pipe_reg14;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg16 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg16 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg16 <= input_is_nan_pipe_reg15;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg17 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg17 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg17 <= input_is_nan_pipe_reg16;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg2 <= input_is_nan_pipe_reg1;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg3 <= input_is_nan_pipe_reg2;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg4 <= input_is_nan_pipe_reg3;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg5 <= input_is_nan_pipe_reg4;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg6 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg6 <= input_is_nan_pipe_reg5;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg7 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg7 <= input_is_nan_pipe_reg6;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg8 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg8 <= input_is_nan_pipe_reg7;
	// synopsys translate_off
	initial
		input_is_nan_pipe_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_nan_pipe_reg9 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_nan_pipe_reg9 <= input_is_nan_pipe_reg8;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg0 <= input_is_one_pipe;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg1 <= input_is_one_pipe_reg0;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg10 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg10 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg10 <= input_is_one_pipe_reg9;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg11 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg11 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg11 <= input_is_one_pipe_reg10;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg12 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg12 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg12 <= input_is_one_pipe_reg11;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg13 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg13 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg13 <= input_is_one_pipe_reg12;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg14 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg14 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg14 <= input_is_one_pipe_reg13;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg15 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg15 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg15 <= input_is_one_pipe_reg14;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg16 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg16 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg16 <= input_is_one_pipe_reg15;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg17 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg17 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg17 <= input_is_one_pipe_reg16;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg2 <= input_is_one_pipe_reg1;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg3 <= input_is_one_pipe_reg2;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg4 <= input_is_one_pipe_reg3;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg5 <= input_is_one_pipe_reg4;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg6 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg6 <= input_is_one_pipe_reg5;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg7 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg7 <= input_is_one_pipe_reg6;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg8 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg8 <= input_is_one_pipe_reg7;
	// synopsys translate_off
	initial
		input_is_one_pipe_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_one_pipe_reg9 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_one_pipe_reg9 <= input_is_one_pipe_reg8;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg0 <= input_is_zero_pipe;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg1 <= input_is_zero_pipe_reg0;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg10 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg10 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg10 <= input_is_zero_pipe_reg9;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg11 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg11 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg11 <= input_is_zero_pipe_reg10;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg12 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg12 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg12 <= input_is_zero_pipe_reg11;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg13 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg13 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg13 <= input_is_zero_pipe_reg12;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg14 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg14 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg14 <= input_is_zero_pipe_reg13;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg15 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg15 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg15 <= input_is_zero_pipe_reg14;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg16 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg16 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg16 <= input_is_zero_pipe_reg15;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg17 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg17 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg17 <= input_is_zero_pipe_reg16;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg2 <= input_is_zero_pipe_reg1;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg3 <= input_is_zero_pipe_reg2;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg4 <= input_is_zero_pipe_reg3;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg5 <= input_is_zero_pipe_reg4;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg6 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg6 <= input_is_zero_pipe_reg5;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg7 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg7 <= input_is_zero_pipe_reg6;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg8 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg8 <= input_is_zero_pipe_reg7;
	// synopsys translate_off
	initial
		input_is_zero_pipe_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) input_is_zero_pipe_reg9 <= 1'b0;
		else if  (clk_en == 1'b1)   input_is_zero_pipe_reg9 <= input_is_zero_pipe_reg8;
	// synopsys translate_off
	initial
		Log_normal_normd_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Log_normal_normd_pipe_reg0 <= 47'b0;
		else if  (clk_en == 1'b1)   Log_normal_normd_pipe_reg0 <= Log_normal_normd_pipe;
	// synopsys translate_off
	initial
		Log_normal_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Log_normal_reg0 <= 47'b0;
		else if  (clk_en == 1'b1)   Log_normal_reg0 <= Log_normal;
	// synopsys translate_off
	initial
		Log_small_normd_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Log_small_normd_pipe_reg0 <= 27'b0;
		else if  (clk_en == 1'b1)   Log_small_normd_pipe_reg0 <= Log_small_normd_pipe;
	// synopsys translate_off
	initial
		Log_small_normd_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Log_small_normd_pipe_reg1 <= 27'b0;
		else if  (clk_en == 1'b1)   Log_small_normd_pipe_reg1 <= Log_small_normd_pipe_reg0;
	// synopsys translate_off
	initial
		Lshiftval_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Lshiftval_reg0 <= 6'b0;
		else if  (clk_en == 1'b1)   Lshiftval_reg0 <= Lshiftval;
	// synopsys translate_off
	initial
		Lshiftval_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Lshiftval_reg1 <= 6'b0;
		else if  (clk_en == 1'b1)   Lshiftval_reg1 <= Lshiftval_reg0;
	// synopsys translate_off
	initial
		Lshiftval_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Lshiftval_reg2 <= 6'b0;
		else if  (clk_en == 1'b1)   Lshiftval_reg2 <= Lshiftval_reg1;
	// synopsys translate_off
	initial
		Lshiftval_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Lshiftval_reg3 <= 6'b0;
		else if  (clk_en == 1'b1)   Lshiftval_reg3 <= Lshiftval_reg2;
	// synopsys translate_off
	initial
		lzo_pipe1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg0 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg0 <= lzo_pipe1;
	// synopsys translate_off
	initial
		lzo_pipe1_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg1 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg1 <= lzo_pipe1_reg0;
	// synopsys translate_off
	initial
		lzo_pipe1_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg2 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg2 <= lzo_pipe1_reg1;
	// synopsys translate_off
	initial
		lzo_pipe1_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg3 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg3 <= lzo_pipe1_reg2;
	// synopsys translate_off
	initial
		lzo_pipe1_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg4 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg4 <= lzo_pipe1_reg3;
	// synopsys translate_off
	initial
		lzo_pipe1_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg5 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg5 <= lzo_pipe1_reg4;
	// synopsys translate_off
	initial
		lzo_pipe1_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg6 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg6 <= lzo_pipe1_reg5;
	// synopsys translate_off
	initial
		lzo_pipe1_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg7 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg7 <= lzo_pipe1_reg6;
	// synopsys translate_off
	initial
		lzo_pipe1_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg8 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg8 <= lzo_pipe1_reg7;
	// synopsys translate_off
	initial
		lzo_pipe1_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_pipe1_reg9 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_pipe1_reg9 <= lzo_pipe1_reg8;
	// synopsys translate_off
	initial
		lzo_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg0 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg0 <= lzo;
	// synopsys translate_off
	initial
		lzo_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg1 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg1 <= lzo_reg0;
	// synopsys translate_off
	initial
		lzo_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg2 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg2 <= lzo_reg1;
	// synopsys translate_off
	initial
		lzo_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg3 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg3 <= lzo_reg2;
	// synopsys translate_off
	initial
		lzo_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg4 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg4 <= lzo_reg3;
	// synopsys translate_off
	initial
		lzo_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg5 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg5 <= lzo_reg4;
	// synopsys translate_off
	initial
		lzo_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg6 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg6 <= lzo_reg5;
	// synopsys translate_off
	initial
		lzo_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) lzo_reg7 <= 5'b0;
		else if  (clk_en == 1'b1)   lzo_reg7 <= lzo_reg6;
	// synopsys translate_off
	initial
		sign_data_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_data_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_data_reg0 <= sign_data;
	// synopsys translate_off
	initial
		sign_data_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_data_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_data_reg1 <= sign_data_reg0;
	// synopsys translate_off
	initial
		sign_data_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_data_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_data_reg2 <= sign_data_reg1;
	// synopsys translate_off
	initial
		small_flag_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg0 <= small_flag_pipe;
	// synopsys translate_off
	initial
		small_flag_pipe_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg1 <= small_flag_pipe_reg0;
	// synopsys translate_off
	initial
		small_flag_pipe_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg2 <= small_flag_pipe_reg1;
	// synopsys translate_off
	initial
		small_flag_pipe_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg3 <= small_flag_pipe_reg2;
	// synopsys translate_off
	initial
		small_flag_pipe_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg4 <= small_flag_pipe_reg3;
	// synopsys translate_off
	initial
		small_flag_pipe_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg5 <= small_flag_pipe_reg4;
	// synopsys translate_off
	initial
		small_flag_pipe_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg6 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg6 <= small_flag_pipe_reg5;
	// synopsys translate_off
	initial
		small_flag_pipe_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg7 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg7 <= small_flag_pipe_reg6;
	// synopsys translate_off
	initial
		small_flag_pipe_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg8 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg8 <= small_flag_pipe_reg7;
	// synopsys translate_off
	initial
		small_flag_pipe_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) small_flag_pipe_reg9 <= 1'b0;
		else if  (clk_en == 1'b1)   small_flag_pipe_reg9 <= small_flag_pipe_reg8;
	// synopsys translate_off
	initial
		sR_pipe1_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg0 <= sR_pipe1;
	// synopsys translate_off
	initial
		sR_pipe1_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg1 <= sR_pipe1_reg0;
	// synopsys translate_off
	initial
		sR_pipe1_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg2 <= sR_pipe1_reg1;
	// synopsys translate_off
	initial
		sR_pipe1_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg3 <= sR_pipe1_reg2;
	// synopsys translate_off
	initial
		sR_pipe1_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg4 <= sR_pipe1_reg3;
	// synopsys translate_off
	initial
		sR_pipe1_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg5 <= sR_pipe1_reg4;
	// synopsys translate_off
	initial
		sR_pipe1_reg6 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg6 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg6 <= sR_pipe1_reg5;
	// synopsys translate_off
	initial
		sR_pipe1_reg7 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg7 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg7 <= sR_pipe1_reg6;
	// synopsys translate_off
	initial
		sR_pipe1_reg8 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg8 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg8 <= sR_pipe1_reg7;
	// synopsys translate_off
	initial
		sR_pipe1_reg9 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe1_reg9 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe1_reg9 <= sR_pipe1_reg8;
	// synopsys translate_off
	initial
		sR_pipe2_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe2_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe2_reg0 <= sR_pipe2;
	// synopsys translate_off
	initial
		sR_pipe2_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe2_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe2_reg1 <= sR_pipe2_reg0;
	// synopsys translate_off
	initial
		sR_pipe2_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe2_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe2_reg2 <= sR_pipe2_reg1;
	// synopsys translate_off
	initial
		sR_pipe2_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe2_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe2_reg3 <= sR_pipe2_reg2;
	// synopsys translate_off
	initial
		sR_pipe2_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe2_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe2_reg4 <= sR_pipe2_reg3;
	// synopsys translate_off
	initial
		sR_pipe2_reg5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe2_reg5 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe2_reg5 <= sR_pipe2_reg4;
	// synopsys translate_off
	initial
		sR_pipe3_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe3_reg0 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe3_reg0 <= sR_pipe3;
	// synopsys translate_off
	initial
		sR_pipe3_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe3_reg1 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe3_reg1 <= sR_pipe3_reg0;
	// synopsys translate_off
	initial
		sR_pipe3_reg2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe3_reg2 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe3_reg2 <= sR_pipe3_reg1;
	// synopsys translate_off
	initial
		sR_pipe3_reg3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe3_reg3 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe3_reg3 <= sR_pipe3_reg2;
	// synopsys translate_off
	initial
		sR_pipe3_reg4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sR_pipe3_reg4 <= 1'b0;
		else if  (clk_en == 1'b1)   sR_pipe3_reg4 <= sR_pipe3_reg3;
	// synopsys translate_off
	initial
		Z2o2_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Z2o2_pipe_reg0 <= 14'b0;
		else if  (clk_en == 1'b1)   Z2o2_pipe_reg0 <= Z2o2_pipe;
	// synopsys translate_off
	initial
		Z2o2_small_s_pipe_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Z2o2_small_s_pipe_reg0 <= 14'b0;
		else if  (clk_en == 1'b1)   Z2o2_small_s_pipe_reg0 <= Z2o2_small_s_pipe;
	// synopsys translate_off
	initial
		Zfinal_reg0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Zfinal_reg0 <= 26'b0;
		else if  (clk_en == 1'b1)   Zfinal_reg0 <= Zfinal;
	// synopsys translate_off
	initial
		Zfinal_reg1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) Zfinal_reg1 <= 26'b0;
		else if  (clk_en == 1'b1)   Zfinal_reg1 <= Zfinal_reg0;
	lpm_add_sub   addsub1
	( 
	.add_sub(sR_pipe3),
	.clken(clk_en),
	.clock(clock),
	.cout(),
	.dataa(Z_small),
	.datab(Z2o2_small),
	.overflow(),
	.result(wire_addsub1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		addsub1.lpm_pipeline = 2,
		addsub1.lpm_representation = "UNSIGNED",
		addsub1.lpm_width = 29,
		addsub1.lpm_type = "lpm_add_sub";
	lpm_add_sub   addsub2
	( 
	.add_sub((~ sR_pipe3)),
	.clken(clk_en),
	.clock(clock),
	.cout(),
	.dataa(absELog2_pad),
	.datab(LogF_normal_pad),
	.overflow(),
	.result(wire_addsub2_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		addsub2.lpm_pipeline = 2,
		addsub2.lpm_representation = "UNSIGNED",
		addsub2.lpm_width = 47,
		addsub2.lpm_type = "lpm_add_sub";
	lpm_mult   mult1
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(absE),
	.datab(Log2),
	.result(wire_mult1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		mult1.lpm_pipeline = 3,
		mult1.lpm_representation = "UNSIGNED",
		mult1.lpm_widtha = 8,
		mult1.lpm_widthb = 27,
		mult1.lpm_widthp = 35,
		mult1.lpm_type = "lpm_mult";
	assign		wire_mux_result0a_dataout = ((((input_is_zero | input_is_infinity) | input_is_nan) | input_is_one) === 1'b1) ? {{8{((~ input_is_one) | input_is_nan)}}, input_is_nan, {22{1'b0}}} : EFR;
	assign
		absE = (({8{(~ sR_pipe2)}} & E0) | ({8{sR_pipe2}} & wire_sub2_result)),
		absELog2 = absELog2_pipe_reg2,
		absELog2_pad = {absELog2, {12{1'b0}}},
		absELog2_pipe = wire_mult1_result,
		absZ0 = absZ0_pipe_reg9,
		absZ0_pipe = (({12{(~ sR_pipe1)}} & Y0[11:0]) | ({12{sR_pipe1}} & wire_sub1_result)),
		absZ0s = wire_Lshiftsmall_result[31:20],
		absZ0s_pipe1 = absZ0s_reg0,
		absZ0s_pipe2 = absZ0s_pipe1_reg3,
		aclr = 1'b0,
		almostLog = almostLog_pipe_reg2,
		almostLog_pipe = wire_range_reduction_almostlog,
		data_exp_is_ebiase = {((~ exp_data[7]) & data_exp_is_ebiase[6]), (exp_data[6] & data_exp_is_ebiase[5]), (exp_data[5] & data_exp_is_ebiase[4]), (exp_data[4] & data_exp_is_ebiase[3]), (exp_data[3] & data_exp_is_ebiase[2]), (exp_data[2] & data_exp_is_ebiase[1]), (exp_data[1] & data_exp_is_ebiase[0]), exp_data[0]},
		doRR = Lshiftval[5],
		doRR_pipe = doRR_reg1,
		E0 = E0_pipe_reg9,
		E0_is_zero = {((~ E0[7]) & E0_is_zero[6]), ((~ E0[6]) & E0_is_zero[5]), ((~ E0[5]) & E0_is_zero[4]), ((~ E0[4]) & E0_is_zero[3]), ((~ E0[3]) & E0_is_zero[2]), ((~ E0[2]) & E0_is_zero[1]), ((~ E0[1]) & E0_is_zero[0]), (~ E0[0])},
		E0_pipe = wire_exp_biase_sub_result,
		E0_sub = {(Log_small[28] | Log_small[27]), (Log_small[28] | (~ Log_small[27]))},
		E0offset = 8'b10000110,
		E_normal = E_normal_pipe_reg0,
		E_normal_pipe = wire_lzc_norm_E_q[4:0],
		E_small = wire_sub5_result,
		EFR = wire_add2_result,
		ER = (({8{(~ small_flag)}} & wire_sub6_result) | ({8{small_flag}} & E_small)),
		exp_all_one = wire_exp_nan_result,
		exp_all_zero = wire_exp_zero_result,
		exp_biase = {7'b0111111, (~ First_bit)},
		exp_data = data[30:23],
		exp_is_ebiase = exp_is_ebiase_pipe_reg2,
		exp_is_ebiase_pipe = data_exp_is_ebiase[7],
		First_bit = man_data[22],
		input_is_infinity = input_is_infinity_pipe_reg17,
		input_is_infinity_pipe = (exp_all_one & (~ man_all_zero)),
		input_is_nan = input_is_nan_pipe_reg17,
		input_is_nan_pipe = ((exp_all_one & man_not_zero) | sign_data_pipe),
		input_is_one = input_is_one_pipe_reg17,
		input_is_one_pipe = (exp_is_ebiase & (~ man_all_zero)),
		input_is_zero = input_is_zero_pipe_reg17,
		input_is_zero_pipe = (~ exp_all_zero),
		Log1p_normal = wire_sub4_result,
		Log2 = 27'b101100010111001000011000000,
		Log_g = (({27{(~ small_flag)}} & Log_normal_normd[45:19]) | ({27{small_flag}} & {Log_small_normd[25:0], 1'b0})),
		Log_normal = wire_addsub2_result,
		Log_normal_normd = Log_normal_normd_pipe_reg0,
		Log_normal_normd_pipe = wire_lzc_norm_L_result[63:17],
		Log_normal_pipe = Log_normal_reg0,
		Log_small = wire_addsub1_result,
		Log_small1 = (({27{(~ Log_small[27])}} & Log_small[26:0]) | ({27{Log_small[27]}} & Log_small[27:1])),
		Log_small2 = (({27{(~ Log_small[28])}} & Log_small1) | ({27{Log_small[28]}} & Log_small[28:2])),
		Log_small_normd = Log_small_normd_pipe_reg1,
		Log_small_normd_pipe = Log_small2,
		LogF_normal = wire_add1_result,
		LogF_normal_pad = {{8{LogF_normal[38]}}, LogF_normal},
		Lshiftval = wire_sub3_result,
		lzo = lzo_pipe1_reg9,
		lzo_pipe1 = (~ wire_lzoc_q),
		lzo_pipe2 = lzo_reg7,
		man_above_half = {1'b0, 1'b1, man_data},
		man_all_zero = wire_man_inf_result,
		man_below_half = {1'b1, man_data, 1'b0},
		man_data = data[22:0],
		man_not_zero = wire_man_nan_result,
		pfinal_s = 5'b01101,
		result = {(((sR | input_is_zero) | input_is_nan) & (~ input_is_one)), wire_mux_result0a_dataout},
		round = (Log_g[3] & (Log_g[4] | sticky[2])),
		Rshiftval = Lshiftval_reg3,
		sign_data = data[31],
		sign_data_pipe = sign_data_reg2,
		small_flag = small_flag_pipe_reg9,
		small_flag_pipe = ((~ doRR) & E0_is_zero[7]),
		squarerIn = (({13{(~ doRR_pipe)}} & squarerIn0) | ({13{doRR_pipe}} & squarerIn1)),
		squarerIn0 = {absZ0s_pipe1, 1'b0},
		squarerIn1 = Zfinal[25:13],
		sR = sR_pipe3_reg4,
		sR_pipe1 = (~ (data_exp_is_ebiase[7] | exp_data[7])),
		sR_pipe2 = sR_pipe1_reg9,
		sR_pipe3 = sR_pipe2_reg5,
		sticky = {(Log_g[2] | sticky[1]), (Log_g[1] | sticky[0]), Log_g[0]},
		Y0 = (({25{(~ First_bit)}} & man_below_half) | ({25{First_bit}} & man_above_half)),
		Z2o2 = Z2o2_pipe_reg0,
		Z2o2_pipe = wire_squarer_result,
		Z2o2_small = {{13{1'b0}}, Z2o2_small_s, {2{1'b0}}},
		Z2o2_small_s = Z2o2_small_s_pipe_reg0,
		Z2o2_small_s_pipe = wire_Rshiftsmall_result[31:18],
		Z_small = {absZ0s_pipe2, {17{1'b0}}},
		Zfinal = wire_range_reduction_z,
		Zfinal_pipe = Zfinal_reg1;
endmodule //acl_fp_log_s5_altfp_log_82b
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module acl_fp_log_s5 (
	enable,
	clock,
	dataa,
	result);

	input	  enable;
	input	  clock;
	input	[31:0]  dataa;
	output	[31:0]  result;

	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

	acl_fp_log_s5_altfp_log_82b	acl_fp_log_s5_altfp_log_82b_component (
				.clk_en (enable),
				.clock (clock),
				.data (dataa),
				.result (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix V"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altfp_log"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "21"
// Retrieval info: CONSTANT: WIDTH_EXP NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_MAN NUMERIC "23"
// Retrieval info: USED_PORT: clk_en 0 0 0 0 INPUT NODEFVAL "clk_en"
// Retrieval info: CONNECT: @clk_en 0 0 0 0 clk_en 0 0 0 0
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: USED_PORT: data 0 0 32 0 INPUT NODEFVAL "data[31..0]"
// Retrieval info: CONNECT: @data 0 0 32 0 data 0 0 32 0
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: GEN_FILE: TYPE_NORMAL acl_fp_log_s5.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL acl_fp_log_s5.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL acl_fp_log_s5.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL acl_fp_log_s5_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL acl_fp_log_s5_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL acl_fp_log_s5.inc TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL acl_fp_log_s5.cmp TRUE TRUE
// Retrieval info: LIB_FILE: lpm
