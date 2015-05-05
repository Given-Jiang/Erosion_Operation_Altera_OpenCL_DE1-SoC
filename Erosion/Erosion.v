// (C) 1992-2014 Altera Corporation. All rights reserved.                         
// Your use of Altera Corporation's design tools, logic functions and other       
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Altera MegaCore Function License Agreement, or other applicable     
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Altera and sold by   
// Altera or its authorized distributors.  Please refer to the applicable         
// agreement for further details.                                                 
    

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module erosion_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input [31:0] 		input_iterations,
		input 		valid_in,
		output 		stall_out,
		output 		valid_out,
		input 		stall_in,
		output 		lvb_bb0_cmp6,
		input [31:0] 		workgroup_size
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements a registered operation.
// 
wire local_bb0_cmp6_inputs_ready;
 reg local_bb0_cmp6_wii_reg_NO_SHIFT_REG;
 reg local_bb0_cmp6_valid_out_NO_SHIFT_REG;
wire local_bb0_cmp6_stall_in;
wire local_bb0_cmp6_output_regs_ready;
 reg local_bb0_cmp6_NO_SHIFT_REG;
wire local_bb0_cmp6_causedstall;

assign local_bb0_cmp6_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb0_cmp6_output_regs_ready = (~(local_bb0_cmp6_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_cmp6_valid_out_NO_SHIFT_REG) | ~(local_bb0_cmp6_stall_in))));
assign merge_node_stall_in_0 = (~(local_bb0_cmp6_wii_reg_NO_SHIFT_REG) & (~(local_bb0_cmp6_output_regs_ready) | ~(local_bb0_cmp6_inputs_ready)));
assign local_bb0_cmp6_causedstall = (local_bb0_cmp6_inputs_ready && (~(local_bb0_cmp6_output_regs_ready) && !(~(local_bb0_cmp6_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp6_NO_SHIFT_REG <= 'x;
		local_bb0_cmp6_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp6_NO_SHIFT_REG <= 'x;
			local_bb0_cmp6_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp6_output_regs_ready)
			begin
				local_bb0_cmp6_NO_SHIFT_REG <= (input_iterations == 32'h0);
				local_bb0_cmp6_valid_out_NO_SHIFT_REG <= local_bb0_cmp6_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_cmp6_stall_in))
				begin
					local_bb0_cmp6_valid_out_NO_SHIFT_REG <= local_bb0_cmp6_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp6_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp6_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp6_inputs_ready)
			begin
				local_bb0_cmp6_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg lvb_bb0_cmp6_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb0_cmp6_valid_out_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb0_cmp6_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign merge_node_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb0_cmp6 = lvb_bb0_cmp6_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb0_cmp6_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb0_cmp6_reg_NO_SHIFT_REG <= local_bb0_cmp6_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module erosion_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_img_in,
		input [63:0] 		input_img_out,
		input [31:0] 		input_iterations,
		input 		input_wii_cmp6,
		input 		valid_in_0,
		output 		stall_out_0,
		input 		input_forked_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input 		input_forked_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output 		valid_out_1,
		input 		stall_in_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input 		feedback_valid_in_55,
		output 		feedback_stall_out_55,
		input [3:0] 		feedback_data_in_55,
		input 		feedback_valid_in_0,
		output 		feedback_stall_out_0,
		input 		feedback_data_in_0,
		input 		feedback_valid_in_1,
		output 		feedback_stall_out_1,
		input 		feedback_data_in_1,
		output 		acl_pipelined_valid,
		input 		acl_pipelined_stall,
		output 		acl_pipelined_exiting_valid,
		output 		acl_pipelined_exiting_stall,
		input 		feedback_valid_in_53,
		output 		feedback_stall_out_53,
		input [3:0] 		feedback_data_in_53,
		input 		feedback_valid_in_52,
		output 		feedback_stall_out_52,
		input [63:0] 		feedback_data_in_52,
		output 		feedback_valid_out_53,
		input 		feedback_stall_in_53,
		output [3:0] 		feedback_data_out_53,
		output 		feedback_valid_out_0,
		input 		feedback_stall_in_0,
		output 		feedback_data_out_0,
		output 		feedback_valid_out_52,
		input 		feedback_stall_in_52,
		output [63:0] 		feedback_data_out_52,
		output 		feedback_valid_out_55,
		input 		feedback_stall_in_55,
		output [3:0] 		feedback_data_out_55,
		input [255:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [29:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [255:0] 		avm_local_bb1_ld__writedata,
		output [31:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		output 		local_bb1_ld__active,
		input 		clock2x,
		output 		feedback_valid_out_1,
		input 		feedback_stall_in_1,
		output 		feedback_data_out_1,
		input 		feedback_valid_in_34,
		output 		feedback_stall_out_34,
		input [7:0] 		feedback_data_in_34,
		input 		feedback_valid_in_35,
		output 		feedback_stall_out_35,
		input [7:0] 		feedback_data_in_35,
		input 		feedback_valid_in_33,
		output 		feedback_stall_out_33,
		input [7:0] 		feedback_data_in_33,
		input 		feedback_valid_in_32,
		output 		feedback_stall_out_32,
		input [7:0] 		feedback_data_in_32,
		input 		feedback_valid_in_31,
		output 		feedback_stall_out_31,
		input [7:0] 		feedback_data_in_31,
		input 		feedback_valid_in_30,
		output 		feedback_stall_out_30,
		input [7:0] 		feedback_data_in_30,
		input 		feedback_valid_in_28,
		output 		feedback_stall_out_28,
		input [7:0] 		feedback_data_in_28,
		input 		feedback_valid_in_27,
		output 		feedback_stall_out_27,
		input [7:0] 		feedback_data_in_27,
		input 		feedback_valid_in_26,
		output 		feedback_stall_out_26,
		input [7:0] 		feedback_data_in_26,
		input 		feedback_valid_in_20,
		output 		feedback_stall_out_20,
		input [7:0] 		feedback_data_in_20,
		input 		feedback_valid_in_19,
		output 		feedback_stall_out_19,
		input [7:0] 		feedback_data_in_19,
		input 		feedback_valid_in_21,
		output 		feedback_stall_out_21,
		input [7:0] 		feedback_data_in_21,
		input 		feedback_valid_in_22,
		output 		feedback_stall_out_22,
		input [7:0] 		feedback_data_in_22,
		input 		feedback_valid_in_23,
		output 		feedback_stall_out_23,
		input [7:0] 		feedback_data_in_23,
		input 		feedback_valid_in_24,
		output 		feedback_stall_out_24,
		input [7:0] 		feedback_data_in_24,
		input 		feedback_valid_in_54,
		output 		feedback_stall_out_54,
		input [10:0] 		feedback_data_in_54,
		input 		feedback_valid_in_25,
		output 		feedback_stall_out_25,
		input [7:0] 		feedback_data_in_25,
		input 		feedback_valid_in_29,
		output 		feedback_stall_out_29,
		input [7:0] 		feedback_data_in_29,
		output 		feedback_valid_out_35,
		input 		feedback_stall_in_35,
		output [7:0] 		feedback_data_out_35,
		output 		feedback_valid_out_31,
		input 		feedback_stall_in_31,
		output [7:0] 		feedback_data_out_31,
		output 		feedback_valid_out_30,
		input 		feedback_stall_in_30,
		output [7:0] 		feedback_data_out_30,
		output 		feedback_valid_out_29,
		input 		feedback_stall_in_29,
		output [7:0] 		feedback_data_out_29,
		input 		feedback_valid_in_13,
		output 		feedback_stall_out_13,
		input [7:0] 		feedback_data_in_13,
		input 		feedback_valid_in_14,
		output 		feedback_stall_out_14,
		input [7:0] 		feedback_data_in_14,
		input 		feedback_valid_in_15,
		output 		feedback_stall_out_15,
		input [7:0] 		feedback_data_in_15,
		input 		feedback_valid_in_16,
		output 		feedback_stall_out_16,
		input [7:0] 		feedback_data_in_16,
		input 		feedback_valid_in_17,
		output 		feedback_stall_out_17,
		input [7:0] 		feedback_data_in_17,
		input 		feedback_valid_in_18,
		output 		feedback_stall_out_18,
		input [7:0] 		feedback_data_in_18,
		output 		feedback_valid_out_3,
		input 		feedback_stall_in_3,
		output [7:0] 		feedback_data_out_3,
		output 		feedback_valid_out_18,
		input 		feedback_stall_in_18,
		output [7:0] 		feedback_data_out_18,
		output 		feedback_valid_out_20,
		input 		feedback_stall_in_20,
		output [7:0] 		feedback_data_out_20,
		output 		feedback_valid_out_21,
		input 		feedback_stall_in_21,
		output [7:0] 		feedback_data_out_21,
		output 		feedback_valid_out_22,
		input 		feedback_stall_in_22,
		output [7:0] 		feedback_data_out_22,
		input 		feedback_valid_in_3,
		output 		feedback_stall_out_3,
		input [7:0] 		feedback_data_in_3,
		input 		feedback_valid_in_10,
		output 		feedback_stall_out_10,
		input [7:0] 		feedback_data_in_10,
		input 		feedback_valid_in_8,
		output 		feedback_stall_out_8,
		input [7:0] 		feedback_data_in_8,
		input 		feedback_valid_in_7,
		output 		feedback_stall_out_7,
		input [7:0] 		feedback_data_in_7,
		input 		feedback_valid_in_9,
		output 		feedback_stall_out_9,
		input [7:0] 		feedback_data_in_9,
		input 		feedback_valid_in_12,
		output 		feedback_stall_out_12,
		input [7:0] 		feedback_data_in_12,
		input 		feedback_valid_in_11,
		output 		feedback_stall_out_11,
		input [7:0] 		feedback_data_in_11,
		output 		feedback_valid_out_23,
		input 		feedback_stall_in_23,
		output [7:0] 		feedback_data_out_23,
		output 		feedback_valid_out_12,
		input 		feedback_stall_in_12,
		output [7:0] 		feedback_data_out_12,
		output 		feedback_valid_out_13,
		input 		feedback_stall_in_13,
		output [7:0] 		feedback_data_out_13,
		output 		feedback_valid_out_14,
		input 		feedback_stall_in_14,
		output [7:0] 		feedback_data_out_14,
		output 		feedback_valid_out_15,
		input 		feedback_stall_in_15,
		output [7:0] 		feedback_data_out_15,
		output 		feedback_valid_out_16,
		input 		feedback_stall_in_16,
		output [7:0] 		feedback_data_out_16,
		output 		feedback_valid_out_17,
		input 		feedback_stall_in_17,
		output [7:0] 		feedback_data_out_17,
		input 		feedback_valid_in_40,
		output 		feedback_stall_out_40,
		input [7:0] 		feedback_data_in_40,
		input 		feedback_valid_in_41,
		output 		feedback_stall_out_41,
		input [7:0] 		feedback_data_in_41,
		input 		feedback_valid_in_42,
		output 		feedback_stall_out_42,
		input [7:0] 		feedback_data_in_42,
		input 		feedback_valid_in_36,
		output 		feedback_stall_out_36,
		input [7:0] 		feedback_data_in_36,
		input 		feedback_valid_in_37,
		output 		feedback_stall_out_37,
		input [7:0] 		feedback_data_in_37,
		input 		feedback_valid_in_38,
		output 		feedback_stall_out_38,
		input [7:0] 		feedback_data_in_38,
		input 		feedback_valid_in_39,
		output 		feedback_stall_out_39,
		input [7:0] 		feedback_data_in_39,
		input 		feedback_valid_in_6,
		output 		feedback_stall_out_6,
		input [7:0] 		feedback_data_in_6,
		input 		feedback_valid_in_5,
		output 		feedback_stall_out_5,
		input [7:0] 		feedback_data_in_5,
		input 		feedback_valid_in_4,
		output 		feedback_stall_out_4,
		input [7:0] 		feedback_data_in_4,
		output 		feedback_valid_out_54,
		input 		feedback_stall_in_54,
		output [10:0] 		feedback_data_out_54,
		output 		feedback_valid_out_19,
		input 		feedback_stall_in_19,
		output [7:0] 		feedback_data_out_19,
		output 		feedback_valid_out_9,
		input 		feedback_stall_in_9,
		output [7:0] 		feedback_data_out_9,
		output 		feedback_valid_out_7,
		input 		feedback_stall_in_7,
		output [7:0] 		feedback_data_out_7,
		output 		feedback_valid_out_6,
		input 		feedback_stall_in_6,
		output [7:0] 		feedback_data_out_6,
		output 		feedback_valid_out_8,
		input 		feedback_stall_in_8,
		output [7:0] 		feedback_data_out_8,
		output 		feedback_valid_out_10,
		input 		feedback_stall_in_10,
		output [7:0] 		feedback_data_out_10,
		input 		feedback_valid_in_48,
		output 		feedback_stall_out_48,
		input [7:0] 		feedback_data_in_48,
		input 		feedback_valid_in_43,
		output 		feedback_stall_out_43,
		input [7:0] 		feedback_data_in_43,
		input 		feedback_valid_in_44,
		output 		feedback_stall_out_44,
		input [7:0] 		feedback_data_in_44,
		input 		feedback_valid_in_46,
		output 		feedback_stall_out_46,
		input [7:0] 		feedback_data_in_46,
		input 		feedback_valid_in_47,
		output 		feedback_stall_out_47,
		input [7:0] 		feedback_data_in_47,
		input 		feedback_valid_in_45,
		output 		feedback_stall_out_45,
		input [7:0] 		feedback_data_in_45,
		output 		feedback_valid_out_41,
		input 		feedback_stall_in_41,
		output [7:0] 		feedback_data_out_41,
		output 		feedback_valid_out_42,
		input 		feedback_stall_in_42,
		output [7:0] 		feedback_data_out_42,
		output 		feedback_valid_out_43,
		input 		feedback_stall_in_43,
		output [7:0] 		feedback_data_out_43,
		output 		feedback_valid_out_37,
		input 		feedback_stall_in_37,
		output [7:0] 		feedback_data_out_37,
		output 		feedback_valid_out_38,
		input 		feedback_stall_in_38,
		output [7:0] 		feedback_data_out_38,
		output 		feedback_valid_out_39,
		input 		feedback_stall_in_39,
		output [7:0] 		feedback_data_out_39,
		output 		feedback_valid_out_40,
		input 		feedback_stall_in_40,
		output [7:0] 		feedback_data_out_40,
		input 		feedback_valid_in_49,
		output 		feedback_stall_out_49,
		input [7:0] 		feedback_data_in_49,
		input 		feedback_valid_in_50,
		output 		feedback_stall_out_50,
		input [7:0] 		feedback_data_in_50,
		input 		feedback_valid_in_51,
		output 		feedback_stall_out_51,
		input [7:0] 		feedback_data_in_51,
		output 		feedback_valid_out_49,
		input 		feedback_stall_in_49,
		output [7:0] 		feedback_data_out_49,
		output 		feedback_valid_out_44,
		input 		feedback_stall_in_44,
		output [7:0] 		feedback_data_out_44,
		output 		feedback_valid_out_45,
		input 		feedback_stall_in_45,
		output [7:0] 		feedback_data_out_45,
		output 		feedback_valid_out_47,
		input 		feedback_stall_in_47,
		output [7:0] 		feedback_data_out_47,
		output 		feedback_valid_out_48,
		input 		feedback_stall_in_48,
		output [7:0] 		feedback_data_out_48,
		output 		feedback_valid_out_46,
		input 		feedback_stall_in_46,
		output [7:0] 		feedback_data_out_46,
		input 		feedback_valid_in_2,
		output 		feedback_stall_out_2,
		input [7:0] 		feedback_data_in_2,
		output 		feedback_valid_out_50,
		input 		feedback_stall_in_50,
		output [7:0] 		feedback_data_out_50,
		output 		feedback_valid_out_51,
		input 		feedback_stall_in_51,
		output [7:0] 		feedback_data_out_51,
		output 		feedback_valid_out_36,
		input 		feedback_stall_in_36,
		output [7:0] 		feedback_data_out_36,
		output 		feedback_valid_out_33,
		input 		feedback_stall_in_33,
		output [7:0] 		feedback_data_out_33,
		output 		feedback_valid_out_34,
		input 		feedback_stall_in_34,
		output [7:0] 		feedback_data_out_34,
		output 		feedback_valid_out_32,
		input 		feedback_stall_in_32,
		output [7:0] 		feedback_data_out_32,
		output 		feedback_valid_out_27,
		input 		feedback_stall_in_27,
		output [7:0] 		feedback_data_out_27,
		output 		feedback_valid_out_26,
		input 		feedback_stall_in_26,
		output [7:0] 		feedback_data_out_26,
		output 		feedback_valid_out_25,
		input 		feedback_stall_in_25,
		output [7:0] 		feedback_data_out_25,
		output 		feedback_valid_out_28,
		input 		feedback_stall_in_28,
		output [7:0] 		feedback_data_out_28,
		output 		feedback_valid_out_24,
		input 		feedback_stall_in_24,
		output [7:0] 		feedback_data_out_24,
		output 		feedback_valid_out_11,
		input 		feedback_stall_in_11,
		output [7:0] 		feedback_data_out_11,
		output 		feedback_valid_out_5,
		input 		feedback_stall_in_5,
		output [7:0] 		feedback_data_out_5,
		output 		feedback_valid_out_4,
		input 		feedback_stall_in_4,
		output [7:0] 		feedback_data_out_4,
		output 		feedback_valid_out_2,
		input 		feedback_stall_in_2,
		output [7:0] 		feedback_data_out_2,
		input [255:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		output 		local_bb1_st_c0_exe1_active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg input_forked_0_staging_reg_NO_SHIFT_REG;
 reg local_lvm_forked_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg input_forked_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_forked_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_forked_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_0_staging_reg_NO_SHIFT_REG <= input_forked_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_1_staging_reg_NO_SHIFT_REG <= input_forked_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements a registered operation.
// 
wire local_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready;
 reg local_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
wire local_bb1_cleanups_pop55_acl_pop_i4_7_stall_in;
wire local_bb1_cleanups_pop55_acl_pop_i4_7_output_regs_ready;
wire [3:0] local_bb1_cleanups_pop55_acl_pop_i4_7_result;
wire local_bb1_cleanups_pop55_acl_pop_i4_7_fu_valid_out;
wire local_bb1_cleanups_pop55_acl_pop_i4_7_fu_stall_out;
 reg [3:0] local_bb1_cleanups_pop55_acl_pop_i4_7_NO_SHIFT_REG;
wire local_bb1_cleanups_pop55_acl_pop_i4_7_causedstall;

acl_pop local_bb1_cleanups_pop55_acl_pop_i4_7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_lvm_forked_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(4'h7),
	.stall_out(local_bb1_cleanups_pop55_acl_pop_i4_7_fu_stall_out),
	.valid_in(local_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready),
	.valid_out(local_bb1_cleanups_pop55_acl_pop_i4_7_fu_valid_out),
	.stall_in(~(local_bb1_cleanups_pop55_acl_pop_i4_7_output_regs_ready)),
	.data_out(local_bb1_cleanups_pop55_acl_pop_i4_7_result),
	.feedback_in(feedback_data_in_55),
	.feedback_valid_in(feedback_valid_in_55),
	.feedback_stall_out(feedback_stall_out_55)
);

defparam local_bb1_cleanups_pop55_acl_pop_i4_7_feedback.DATA_WIDTH = 4;
defparam local_bb1_cleanups_pop55_acl_pop_i4_7_feedback.STYLE = "REGULAR";

assign local_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cleanups_pop55_acl_pop_i4_7_output_regs_ready = (&(~(local_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_NO_SHIFT_REG) | ~(local_bb1_cleanups_pop55_acl_pop_i4_7_stall_in)));
assign merge_node_stall_in_0 = (local_bb1_cleanups_pop55_acl_pop_i4_7_fu_stall_out | ~(local_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready));
assign local_bb1_cleanups_pop55_acl_pop_i4_7_causedstall = (local_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready && (local_bb1_cleanups_pop55_acl_pop_i4_7_fu_stall_out && !(~(local_bb1_cleanups_pop55_acl_pop_i4_7_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cleanups_pop55_acl_pop_i4_7_NO_SHIFT_REG <= 'x;
		local_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_cleanups_pop55_acl_pop_i4_7_output_regs_ready)
		begin
			local_bb1_cleanups_pop55_acl_pop_i4_7_NO_SHIFT_REG <= local_bb1_cleanups_pop55_acl_pop_i4_7_result;
			local_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= local_bb1_cleanups_pop55_acl_pop_i4_7_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_cleanups_pop55_acl_pop_i4_7_stall_in))
			begin
				local_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_keep_going_forked_inputs_ready;
 reg local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG;
wire local_bb1_keep_going_forked_stall_in;
wire local_bb1_keep_going_forked_output_regs_ready;
wire local_bb1_keep_going_forked_keep_going;
wire local_bb1_keep_going_forked_fu_valid_out;
wire local_bb1_keep_going_forked_fu_stall_out;
 reg local_bb1_keep_going_forked_NO_SHIFT_REG;
wire local_bb1_keep_going_forked_feedback_pipelined;
wire local_bb1_keep_going_forked_causedstall;

acl_pipeline local_bb1_keep_going_forked_pipelined (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_lvm_forked_NO_SHIFT_REG),
	.stall_out(local_bb1_keep_going_forked_fu_stall_out),
	.valid_in(local_bb1_keep_going_forked_inputs_ready),
	.valid_out(local_bb1_keep_going_forked_fu_valid_out),
	.stall_in(~(local_bb1_keep_going_forked_output_regs_ready)),
	.data_out(local_bb1_keep_going_forked_keep_going),
	.initeration_in(feedback_data_in_0),
	.initeration_valid_in(feedback_valid_in_0),
	.initeration_stall_out(feedback_stall_out_0),
	.not_exitcond_in(feedback_data_in_1),
	.not_exitcond_valid_in(feedback_valid_in_1),
	.not_exitcond_stall_out(feedback_stall_out_1),
	.pipeline_valid_out(acl_pipelined_valid),
	.pipeline_stall_in(acl_pipelined_stall),
	.exiting_valid_out(acl_pipelined_exiting_valid)
);

defparam local_bb1_keep_going_forked_pipelined.FIFO_DEPTH = 2;
defparam local_bb1_keep_going_forked_pipelined.STYLE = "SPECULATIVE";

assign local_bb1_keep_going_forked_inputs_ready = merge_node_valid_out_1_NO_SHIFT_REG;
assign local_bb1_keep_going_forked_output_regs_ready = (&(~(local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG) | ~(local_bb1_keep_going_forked_stall_in)));
assign acl_pipelined_exiting_stall = acl_pipelined_stall;
assign merge_node_stall_in_1 = (local_bb1_keep_going_forked_fu_stall_out | ~(local_bb1_keep_going_forked_inputs_ready));
assign local_bb1_keep_going_forked_causedstall = (local_bb1_keep_going_forked_inputs_ready && (local_bb1_keep_going_forked_fu_stall_out && !(~(local_bb1_keep_going_forked_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_keep_going_forked_NO_SHIFT_REG <= 'x;
		local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_keep_going_forked_output_regs_ready)
		begin
			local_bb1_keep_going_forked_NO_SHIFT_REG <= local_bb1_keep_going_forked_keep_going;
			local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG <= local_bb1_keep_going_forked_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_keep_going_forked_stall_in))
			begin
				local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_initerations_pop53_acl_pop_i4_7_inputs_ready;
 reg local_bb1_initerations_pop53_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
wire local_bb1_initerations_pop53_acl_pop_i4_7_stall_in;
wire local_bb1_initerations_pop53_acl_pop_i4_7_output_regs_ready;
wire [3:0] local_bb1_initerations_pop53_acl_pop_i4_7_result;
wire local_bb1_initerations_pop53_acl_pop_i4_7_fu_valid_out;
wire local_bb1_initerations_pop53_acl_pop_i4_7_fu_stall_out;
 reg [3:0] local_bb1_initerations_pop53_acl_pop_i4_7_NO_SHIFT_REG;
wire local_bb1_initerations_pop53_acl_pop_i4_7_causedstall;

acl_pop local_bb1_initerations_pop53_acl_pop_i4_7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_lvm_forked_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(4'h7),
	.stall_out(local_bb1_initerations_pop53_acl_pop_i4_7_fu_stall_out),
	.valid_in(local_bb1_initerations_pop53_acl_pop_i4_7_inputs_ready),
	.valid_out(local_bb1_initerations_pop53_acl_pop_i4_7_fu_valid_out),
	.stall_in(~(local_bb1_initerations_pop53_acl_pop_i4_7_output_regs_ready)),
	.data_out(local_bb1_initerations_pop53_acl_pop_i4_7_result),
	.feedback_in(feedback_data_in_53),
	.feedback_valid_in(feedback_valid_in_53),
	.feedback_stall_out(feedback_stall_out_53)
);

defparam local_bb1_initerations_pop53_acl_pop_i4_7_feedback.DATA_WIDTH = 4;
defparam local_bb1_initerations_pop53_acl_pop_i4_7_feedback.STYLE = "REGULAR";

assign local_bb1_initerations_pop53_acl_pop_i4_7_inputs_ready = merge_node_valid_out_2_NO_SHIFT_REG;
assign local_bb1_initerations_pop53_acl_pop_i4_7_output_regs_ready = (&(~(local_bb1_initerations_pop53_acl_pop_i4_7_valid_out_NO_SHIFT_REG) | ~(local_bb1_initerations_pop53_acl_pop_i4_7_stall_in)));
assign merge_node_stall_in_2 = (local_bb1_initerations_pop53_acl_pop_i4_7_fu_stall_out | ~(local_bb1_initerations_pop53_acl_pop_i4_7_inputs_ready));
assign local_bb1_initerations_pop53_acl_pop_i4_7_causedstall = (local_bb1_initerations_pop53_acl_pop_i4_7_inputs_ready && (local_bb1_initerations_pop53_acl_pop_i4_7_fu_stall_out && !(~(local_bb1_initerations_pop53_acl_pop_i4_7_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_initerations_pop53_acl_pop_i4_7_NO_SHIFT_REG <= 'x;
		local_bb1_initerations_pop53_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_initerations_pop53_acl_pop_i4_7_output_regs_ready)
		begin
			local_bb1_initerations_pop53_acl_pop_i4_7_NO_SHIFT_REG <= local_bb1_initerations_pop53_acl_pop_i4_7_result;
			local_bb1_initerations_pop53_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= local_bb1_initerations_pop53_acl_pop_i4_7_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_initerations_pop53_acl_pop_i4_7_stall_in))
			begin
				local_bb1_initerations_pop53_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready;
 reg local_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_NO_SHIFT_REG;
wire local_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in;
wire local_bb1_indvars_iv16_pop52_acl_pop_i64_0_output_regs_ready;
wire [63:0] local_bb1_indvars_iv16_pop52_acl_pop_i64_0_result;
wire local_bb1_indvars_iv16_pop52_acl_pop_i64_0_fu_valid_out;
wire local_bb1_indvars_iv16_pop52_acl_pop_i64_0_fu_stall_out;
 reg [63:0] local_bb1_indvars_iv16_pop52_acl_pop_i64_0_NO_SHIFT_REG;
wire local_bb1_indvars_iv16_pop52_acl_pop_i64_0_causedstall;

acl_pop local_bb1_indvars_iv16_pop52_acl_pop_i64_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_lvm_forked_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(64'h0),
	.stall_out(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_fu_stall_out),
	.valid_in(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready),
	.valid_out(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_fu_valid_out),
	.stall_in(~(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_output_regs_ready)),
	.data_out(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_result),
	.feedback_in(feedback_data_in_52),
	.feedback_valid_in(feedback_valid_in_52),
	.feedback_stall_out(feedback_stall_out_52)
);

defparam local_bb1_indvars_iv16_pop52_acl_pop_i64_0_feedback.DATA_WIDTH = 64;
defparam local_bb1_indvars_iv16_pop52_acl_pop_i64_0_feedback.STYLE = "REGULAR";

assign local_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready = merge_node_valid_out_3_NO_SHIFT_REG;
assign local_bb1_indvars_iv16_pop52_acl_pop_i64_0_output_regs_ready = (&(~(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_NO_SHIFT_REG) | ~(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in)));
assign merge_node_stall_in_3 = (local_bb1_indvars_iv16_pop52_acl_pop_i64_0_fu_stall_out | ~(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready));
assign local_bb1_indvars_iv16_pop52_acl_pop_i64_0_causedstall = (local_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready && (local_bb1_indvars_iv16_pop52_acl_pop_i64_0_fu_stall_out && !(~(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_indvars_iv16_pop52_acl_pop_i64_0_NO_SHIFT_REG <= 'x;
		local_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_indvars_iv16_pop52_acl_pop_i64_0_output_regs_ready)
		begin
			local_bb1_indvars_iv16_pop52_acl_pop_i64_0_NO_SHIFT_REG <= local_bb1_indvars_iv16_pop52_acl_pop_i64_0_result;
			local_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_NO_SHIFT_REG <= local_bb1_indvars_iv16_pop52_acl_pop_i64_0_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in))
			begin
				local_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_forked_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_forked_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to161_forked_0_NO_SHIFT_REG;
 logic rnode_1to161_forked_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to161_forked_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_forked_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_forked_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_forked_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_forked_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_forked_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_forked_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_forked_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_forked_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_forked_NO_SHIFT_REG),
	.data_out(rnode_1to161_forked_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_forked_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_forked_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_1to161_forked_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_forked_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_forked_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to161_forked_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_forked_0_NO_SHIFT_REG = rnode_1to161_forked_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_forked_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_forked_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_forked_0_valid_out_NO_SHIFT_REG = rnode_1to161_forked_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_0;
wire rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_0;
 reg rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_1;
wire rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_1;
 reg rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready;
wire rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_local;
 reg rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_combined_valid;
 reg [3:0] rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_reg_NO_SHIFT_REG;
wire [3:0] rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7;

assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready = local_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7 = (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_reg_NO_SHIFT_REG : local_bb1_cleanups_pop55_acl_pop_i4_7_NO_SHIFT_REG);
assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_combined_valid = (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready);
assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_local = ((rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_0 & ~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_1 & ~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_1_NO_SHIFT_REG)));
assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_0 = (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_combined_valid & ~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_1 = (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_combined_valid & ~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_1_NO_SHIFT_REG));
assign local_bb1_cleanups_pop55_acl_pop_i4_7_stall_in = (|rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_local)
		begin
			if (~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_staging_reg_NO_SHIFT_REG <= local_bb1_cleanups_pop55_acl_pop_i4_7_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_combined_valid & (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_0)) & rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_local);
		rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_combined_valid & (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_1)) & rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_local);
	end
end


// This section implements a staging register.
// 
wire rstag_2to2_bb1_keep_going_forked_valid_out_0;
wire rstag_2to2_bb1_keep_going_forked_stall_in_0;
 reg rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_valid_out_1;
wire rstag_2to2_bb1_keep_going_forked_stall_in_1;
 reg rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_valid_out_2;
wire rstag_2to2_bb1_keep_going_forked_stall_in_2;
 reg rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_valid_out_3;
wire rstag_2to2_bb1_keep_going_forked_stall_in_3;
 reg rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_valid_out_4;
wire rstag_2to2_bb1_keep_going_forked_stall_in_4;
 reg rstag_2to2_bb1_keep_going_forked_consumed_4_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_inputs_ready;
wire rstag_2to2_bb1_keep_going_forked_stall_local;
 reg rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_combined_valid;
 reg rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked;

assign rstag_2to2_bb1_keep_going_forked_inputs_ready = local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG;
assign rstag_2to2_bb1_keep_going_forked = (rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG : local_bb1_keep_going_forked_NO_SHIFT_REG);
assign rstag_2to2_bb1_keep_going_forked_combined_valid = (rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_keep_going_forked_inputs_ready);
assign rstag_2to2_bb1_keep_going_forked_stall_local = ((rstag_2to2_bb1_keep_going_forked_stall_in_0 & ~(rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_keep_going_forked_stall_in_1 & ~(rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG)) | (rstag_2to2_bb1_keep_going_forked_stall_in_2 & ~(rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG)) | (rstag_2to2_bb1_keep_going_forked_stall_in_3 & ~(rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG)) | (rstag_2to2_bb1_keep_going_forked_stall_in_4 & ~(rstag_2to2_bb1_keep_going_forked_consumed_4_NO_SHIFT_REG)));
assign rstag_2to2_bb1_keep_going_forked_valid_out_0 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_keep_going_forked_valid_out_1 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG));
assign rstag_2to2_bb1_keep_going_forked_valid_out_2 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG));
assign rstag_2to2_bb1_keep_going_forked_valid_out_3 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG));
assign rstag_2to2_bb1_keep_going_forked_valid_out_4 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_4_NO_SHIFT_REG));
assign local_bb1_keep_going_forked_stall_in = (|rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_keep_going_forked_stall_local)
		begin
			if (~(rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_keep_going_forked_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG <= local_bb1_keep_going_forked_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_consumed_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_0)) & rstag_2to2_bb1_keep_going_forked_stall_local);
		rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_1)) & rstag_2to2_bb1_keep_going_forked_stall_local);
		rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_2)) & rstag_2to2_bb1_keep_going_forked_stall_local);
		rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_3)) & rstag_2to2_bb1_keep_going_forked_stall_local);
		rstag_2to2_bb1_keep_going_forked_consumed_4_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_4_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_4)) & rstag_2to2_bb1_keep_going_forked_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_next_initerations_stall_local;
wire [3:0] local_bb1_next_initerations;

assign local_bb1_next_initerations = (local_bb1_initerations_pop53_acl_pop_i4_7_NO_SHIFT_REG >> 4'h1);

// This section implements a staging register.
// 
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_0;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_0;
 reg rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_1;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_1;
 reg rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_2;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_2;
 reg rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_2_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_local;
 reg rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid;
 reg [63:0] rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0;

assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready = local_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_NO_SHIFT_REG;
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0 = (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_reg_NO_SHIFT_REG : local_bb1_indvars_iv16_pop52_acl_pop_i64_0_NO_SHIFT_REG);
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid = (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready);
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_local = ((rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_0 & ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_1 & ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_1_NO_SHIFT_REG)) | (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_2 & ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_2_NO_SHIFT_REG)));
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_0 = (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid & ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_1 = (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid & ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_1_NO_SHIFT_REG));
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_2 = (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid & ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_2_NO_SHIFT_REG));
assign local_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in = (|rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_local)
		begin
			if (~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_staging_reg_NO_SHIFT_REG <= local_bb1_indvars_iv16_pop52_acl_pop_i64_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid & (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_0)) & rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_local);
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid & (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_1)) & rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_local);
		rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_2_NO_SHIFT_REG <= (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_combined_valid & (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_consumed_2_NO_SHIFT_REG | ~(rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_2)) & rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_forked_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_161to162_forked_1_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_valid_out_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_stall_in_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_stall_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_forked_0_reg_162_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_161to162_forked_0_reg_162_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_161to162_forked_0_reg_162_NO_SHIFT_REG),
	.valid_in(rnode_161to162_forked_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_forked_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.data_out(rnode_161to162_forked_0_reg_162_NO_SHIFT_REG_fa),
	.valid_out({rnode_161to162_forked_0_valid_out_0_NO_SHIFT_REG, rnode_161to162_forked_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_161to162_forked_0_stall_in_0_NO_SHIFT_REG, rnode_161to162_forked_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_161to162_forked_0_reg_162_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_161to162_forked_0_reg_162_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_161to162_forked_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_forked_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_forked_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_forked_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_forked_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_forked_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_forked_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_forked_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_forked_0_reg_162_fifo.DATA_WIDTH = 1;
defparam rnode_161to162_forked_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_forked_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_forked_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_forked_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_forked_0_stall_in_NO_SHIFT_REG = rnode_161to162_forked_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_forked_0_NO_SHIFT_REG = rnode_161to162_forked_0_reg_162_NO_SHIFT_REG_fa;
assign rnode_161to162_forked_1_NO_SHIFT_REG = rnode_161to162_forked_0_reg_162_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb1_var__stall_local;
wire [3:0] local_bb1_var_;

assign local_bb1_var_ = (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7 & 4'h1);

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_2to161_bb1_keep_going_forked_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to161_bb1_keep_going_forked_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to161_bb1_keep_going_forked_0_NO_SHIFT_REG;
 logic rnode_2to161_bb1_keep_going_forked_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to161_bb1_keep_going_forked_0_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb1_keep_going_forked_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb1_keep_going_forked_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb1_keep_going_forked_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_2to161_bb1_keep_going_forked_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to161_bb1_keep_going_forked_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to161_bb1_keep_going_forked_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_2to161_bb1_keep_going_forked_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_2to161_bb1_keep_going_forked_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb1_keep_going_forked),
	.data_out(rnode_2to161_bb1_keep_going_forked_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_2to161_bb1_keep_going_forked_0_reg_161_fifo.DEPTH = 160;
defparam rnode_2to161_bb1_keep_going_forked_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_2to161_bb1_keep_going_forked_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to161_bb1_keep_going_forked_0_reg_161_fifo.IMPL = "ram";

assign rnode_2to161_bb1_keep_going_forked_0_reg_161_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb1_keep_going_forked_valid_out_0;
assign rstag_2to2_bb1_keep_going_forked_stall_in_0 = rnode_2to161_bb1_keep_going_forked_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_2to161_bb1_keep_going_forked_0_NO_SHIFT_REG = rnode_2to161_bb1_keep_going_forked_0_reg_161_NO_SHIFT_REG;
assign rnode_2to161_bb1_keep_going_forked_0_stall_in_reg_161_NO_SHIFT_REG = rnode_2to161_bb1_keep_going_forked_0_stall_in_NO_SHIFT_REG;
assign rnode_2to161_bb1_keep_going_forked_0_valid_out_NO_SHIFT_REG = rnode_2to161_bb1_keep_going_forked_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u0_stall_local;
wire [3:0] local_bb1_var__u0;

assign local_bb1_var__u0 = (local_bb1_next_initerations & 4'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx34_valid_out;
wire local_bb1_arrayidx34_stall_in;
wire local_bb1_arrayidx34_inputs_ready;
wire local_bb1_arrayidx34_stall_local;
wire [63:0] local_bb1_arrayidx34;

assign local_bb1_arrayidx34_inputs_ready = rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_0;
assign local_bb1_arrayidx34 = (input_img_out + rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0);
assign local_bb1_arrayidx34_valid_out = local_bb1_arrayidx34_inputs_ready;
assign local_bb1_arrayidx34_stall_local = local_bb1_arrayidx34_stall_in;
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_0 = (|local_bb1_arrayidx34_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx5_valid_out;
wire local_bb1_arrayidx5_stall_in;
wire local_bb1_arrayidx5_inputs_ready;
wire local_bb1_arrayidx5_stall_local;
wire [63:0] local_bb1_arrayidx5;

assign local_bb1_arrayidx5_inputs_ready = rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_1;
assign local_bb1_arrayidx5 = (input_img_in + rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0);
assign local_bb1_arrayidx5_valid_out = local_bb1_arrayidx5_inputs_ready;
assign local_bb1_arrayidx5_stall_local = local_bb1_arrayidx5_stall_in;
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_1 = (|local_bb1_arrayidx5_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_indvars_iv_next17_stall_local;
wire [63:0] local_bb1_indvars_iv_next17;

assign local_bb1_indvars_iv_next17 = (rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0 + 64'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni1_stall_local;
wire [31:0] local_bb1_c0_eni1;

assign local_bb1_c0_eni1[7:0] = 8'bxxxxxxxx;
assign local_bb1_c0_eni1[8] = rnode_161to162_forked_0_NO_SHIFT_REG;
assign local_bb1_c0_eni1[31:9] = 23'bxxxxxxxxxxxxxxxxxxxxxxx;

// This section implements an unregistered operation.
// 
wire local_bb1_first_cleanup_stall_local;
wire local_bb1_first_cleanup;

assign local_bb1_first_cleanup = (local_bb1_var_ != 4'h0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_bb1_keep_going_forked_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_1_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_valid_out_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_stall_in_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_stall_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb1_keep_going_forked_0_reg_162_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_161to162_bb1_keep_going_forked_0_reg_162_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_161to162_bb1_keep_going_forked_0_reg_162_NO_SHIFT_REG),
	.valid_in(rnode_161to162_bb1_keep_going_forked_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_bb1_keep_going_forked_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.data_out(rnode_161to162_bb1_keep_going_forked_0_reg_162_NO_SHIFT_REG_fa),
	.valid_out({rnode_161to162_bb1_keep_going_forked_0_valid_out_0_NO_SHIFT_REG, rnode_161to162_bb1_keep_going_forked_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_161to162_bb1_keep_going_forked_0_stall_in_0_NO_SHIFT_REG, rnode_161to162_bb1_keep_going_forked_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_161to162_bb1_keep_going_forked_0_reg_162_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_161to162_bb1_keep_going_forked_0_reg_162_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_161to162_bb1_keep_going_forked_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_bb1_keep_going_forked_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_bb1_keep_going_forked_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_bb1_keep_going_forked_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_bb1_keep_going_forked_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_2to161_bb1_keep_going_forked_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_bb1_keep_going_forked_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_bb1_keep_going_forked_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_bb1_keep_going_forked_0_reg_162_fifo.DATA_WIDTH = 1;
defparam rnode_161to162_bb1_keep_going_forked_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_bb1_keep_going_forked_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_bb1_keep_going_forked_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_2to161_bb1_keep_going_forked_0_valid_out_NO_SHIFT_REG;
assign rnode_2to161_bb1_keep_going_forked_0_stall_in_NO_SHIFT_REG = rnode_161to162_bb1_keep_going_forked_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_bb1_keep_going_forked_0_NO_SHIFT_REG = rnode_161to162_bb1_keep_going_forked_0_reg_162_NO_SHIFT_REG_fa;
assign rnode_161to162_bb1_keep_going_forked_1_NO_SHIFT_REG = rnode_161to162_bb1_keep_going_forked_0_reg_162_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb1_next_initerations_valid_out_0;
wire local_bb1_next_initerations_stall_in_0;
 reg local_bb1_next_initerations_consumed_0_NO_SHIFT_REG;
wire local_bb1_last_initeration_valid_out;
wire local_bb1_last_initeration_stall_in;
 reg local_bb1_last_initeration_consumed_0_NO_SHIFT_REG;
wire local_bb1_last_initeration_inputs_ready;
wire local_bb1_last_initeration_stall_local;
wire local_bb1_last_initeration;

assign local_bb1_last_initeration_inputs_ready = local_bb1_initerations_pop53_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
assign local_bb1_last_initeration = (local_bb1_var__u0 != 4'h0);
assign local_bb1_last_initeration_stall_local = ((local_bb1_next_initerations_stall_in_0 & ~(local_bb1_next_initerations_consumed_0_NO_SHIFT_REG)) | (local_bb1_last_initeration_stall_in & ~(local_bb1_last_initeration_consumed_0_NO_SHIFT_REG)));
assign local_bb1_next_initerations_valid_out_0 = (local_bb1_last_initeration_inputs_ready & ~(local_bb1_next_initerations_consumed_0_NO_SHIFT_REG));
assign local_bb1_last_initeration_valid_out = (local_bb1_last_initeration_inputs_ready & ~(local_bb1_last_initeration_consumed_0_NO_SHIFT_REG));
assign local_bb1_initerations_pop53_acl_pop_i4_7_stall_in = (|local_bb1_last_initeration_stall_local);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_next_initerations_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_last_initeration_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_next_initerations_consumed_0_NO_SHIFT_REG <= (local_bb1_last_initeration_inputs_ready & (local_bb1_next_initerations_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_initerations_stall_in_0)) & local_bb1_last_initeration_stall_local);
		local_bb1_last_initeration_consumed_0_NO_SHIFT_REG <= (local_bb1_last_initeration_inputs_ready & (local_bb1_last_initeration_consumed_0_NO_SHIFT_REG | ~(local_bb1_last_initeration_stall_in)) & local_bb1_last_initeration_stall_local);
	end
end


// Register node:
//  * latency = 173
//  * capacity = 173
 logic rnode_2to175_bb1_arrayidx34_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to175_bb1_arrayidx34_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to175_bb1_arrayidx34_0_NO_SHIFT_REG;
 logic rnode_2to175_bb1_arrayidx34_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to175_bb1_arrayidx34_0_reg_175_NO_SHIFT_REG;
 logic rnode_2to175_bb1_arrayidx34_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_2to175_bb1_arrayidx34_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_2to175_bb1_arrayidx34_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_2to175_bb1_arrayidx34_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to175_bb1_arrayidx34_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to175_bb1_arrayidx34_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_2to175_bb1_arrayidx34_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_2to175_bb1_arrayidx34_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1_arrayidx34),
	.data_out(rnode_2to175_bb1_arrayidx34_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_2to175_bb1_arrayidx34_0_reg_175_fifo.DEPTH = 174;
defparam rnode_2to175_bb1_arrayidx34_0_reg_175_fifo.DATA_WIDTH = 64;
defparam rnode_2to175_bb1_arrayidx34_0_reg_175_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to175_bb1_arrayidx34_0_reg_175_fifo.IMPL = "ram";

assign rnode_2to175_bb1_arrayidx34_0_reg_175_inputs_ready_NO_SHIFT_REG = local_bb1_arrayidx34_valid_out;
assign local_bb1_arrayidx34_stall_in = rnode_2to175_bb1_arrayidx34_0_stall_out_reg_175_NO_SHIFT_REG;
assign rnode_2to175_bb1_arrayidx34_0_NO_SHIFT_REG = rnode_2to175_bb1_arrayidx34_0_reg_175_NO_SHIFT_REG;
assign rnode_2to175_bb1_arrayidx34_0_stall_in_reg_175_NO_SHIFT_REG = rnode_2to175_bb1_arrayidx34_0_stall_in_NO_SHIFT_REG;
assign rnode_2to175_bb1_arrayidx34_0_valid_out_NO_SHIFT_REG = rnode_2to175_bb1_arrayidx34_0_valid_out_reg_175_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_lftr_wideiv18_stall_local;
wire [31:0] local_bb1_lftr_wideiv18;

assign local_bb1_lftr_wideiv18 = local_bb1_indvars_iv_next17[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_xor_stall_local;
wire local_bb1_xor;

assign local_bb1_xor = (local_bb1_first_cleanup ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni2_stall_local;
wire [31:0] local_bb1_c0_eni2;

assign local_bb1_c0_eni2[15:0] = local_bb1_c0_eni1[15:0];
assign local_bb1_c0_eni2[16] = rnode_161to162_bb1_keep_going_forked_0_NO_SHIFT_REG;
assign local_bb1_c0_eni2[31:17] = local_bb1_c0_eni1[31:17];

// This section implements a registered operation.
// 
wire local_bb1_initerations_push53_next_initerations_inputs_ready;
 reg local_bb1_initerations_push53_next_initerations_valid_out_NO_SHIFT_REG;
wire local_bb1_initerations_push53_next_initerations_stall_in;
wire local_bb1_initerations_push53_next_initerations_output_regs_ready;
wire [3:0] local_bb1_initerations_push53_next_initerations_result;
wire local_bb1_initerations_push53_next_initerations_fu_valid_out;
wire local_bb1_initerations_push53_next_initerations_fu_stall_out;
 reg [3:0] local_bb1_initerations_push53_next_initerations_NO_SHIFT_REG;
wire local_bb1_initerations_push53_next_initerations_causedstall;

acl_push local_bb1_initerations_push53_next_initerations_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(local_bb1_next_initerations),
	.stall_out(local_bb1_initerations_push53_next_initerations_fu_stall_out),
	.valid_in(local_bb1_initerations_push53_next_initerations_inputs_ready),
	.valid_out(local_bb1_initerations_push53_next_initerations_fu_valid_out),
	.stall_in(~(local_bb1_initerations_push53_next_initerations_output_regs_ready)),
	.data_out(local_bb1_initerations_push53_next_initerations_result),
	.feedback_out(feedback_data_out_53),
	.feedback_valid_out(feedback_valid_out_53),
	.feedback_stall_in(feedback_stall_in_53)
);

defparam local_bb1_initerations_push53_next_initerations_feedback.STALLFREE = 0;
defparam local_bb1_initerations_push53_next_initerations_feedback.DATA_WIDTH = 4;
defparam local_bb1_initerations_push53_next_initerations_feedback.FIFO_DEPTH = 2;
defparam local_bb1_initerations_push53_next_initerations_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_initerations_push53_next_initerations_feedback.STYLE = "REGULAR";

assign local_bb1_initerations_push53_next_initerations_inputs_ready = (local_bb1_next_initerations_valid_out_0 & rstag_2to2_bb1_keep_going_forked_valid_out_4);
assign local_bb1_initerations_push53_next_initerations_output_regs_ready = (&(~(local_bb1_initerations_push53_next_initerations_valid_out_NO_SHIFT_REG) | ~(local_bb1_initerations_push53_next_initerations_stall_in)));
assign local_bb1_next_initerations_stall_in_0 = (local_bb1_initerations_push53_next_initerations_fu_stall_out | ~(local_bb1_initerations_push53_next_initerations_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_4 = (local_bb1_initerations_push53_next_initerations_fu_stall_out | ~(local_bb1_initerations_push53_next_initerations_inputs_ready));
assign local_bb1_initerations_push53_next_initerations_causedstall = (local_bb1_initerations_push53_next_initerations_inputs_ready && (local_bb1_initerations_push53_next_initerations_fu_stall_out && !(~(local_bb1_initerations_push53_next_initerations_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_initerations_push53_next_initerations_NO_SHIFT_REG <= 'x;
		local_bb1_initerations_push53_next_initerations_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_initerations_push53_next_initerations_output_regs_ready)
		begin
			local_bb1_initerations_push53_next_initerations_NO_SHIFT_REG <= local_bb1_initerations_push53_next_initerations_result;
			local_bb1_initerations_push53_next_initerations_valid_out_NO_SHIFT_REG <= local_bb1_initerations_push53_next_initerations_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_initerations_push53_next_initerations_stall_in))
			begin
				local_bb1_initerations_push53_next_initerations_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_lastiniteration_last_initeration_inputs_ready;
 reg local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG;
wire local_bb1_lastiniteration_last_initeration_stall_in;
wire local_bb1_lastiniteration_last_initeration_output_regs_ready;
wire local_bb1_lastiniteration_last_initeration_result;
wire local_bb1_lastiniteration_last_initeration_fu_valid_out;
wire local_bb1_lastiniteration_last_initeration_fu_stall_out;
 reg local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG;
wire local_bb1_lastiniteration_last_initeration_causedstall;

acl_push local_bb1_lastiniteration_last_initeration_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(local_bb1_last_initeration),
	.stall_out(local_bb1_lastiniteration_last_initeration_fu_stall_out),
	.valid_in(local_bb1_lastiniteration_last_initeration_inputs_ready),
	.valid_out(local_bb1_lastiniteration_last_initeration_fu_valid_out),
	.stall_in(~(local_bb1_lastiniteration_last_initeration_output_regs_ready)),
	.data_out(local_bb1_lastiniteration_last_initeration_result),
	.feedback_out(feedback_data_out_0),
	.feedback_valid_out(feedback_valid_out_0),
	.feedback_stall_in(feedback_stall_in_0)
);

defparam local_bb1_lastiniteration_last_initeration_feedback.STALLFREE = 0;
defparam local_bb1_lastiniteration_last_initeration_feedback.DATA_WIDTH = 1;
defparam local_bb1_lastiniteration_last_initeration_feedback.FIFO_DEPTH = 2;
defparam local_bb1_lastiniteration_last_initeration_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_lastiniteration_last_initeration_feedback.STYLE = "REGULAR";

assign local_bb1_lastiniteration_last_initeration_inputs_ready = (local_bb1_last_initeration_valid_out & rstag_2to2_bb1_keep_going_forked_valid_out_2);
assign local_bb1_lastiniteration_last_initeration_output_regs_ready = (&(~(local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG) | ~(local_bb1_lastiniteration_last_initeration_stall_in)));
assign local_bb1_last_initeration_stall_in = (local_bb1_lastiniteration_last_initeration_fu_stall_out | ~(local_bb1_lastiniteration_last_initeration_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_2 = (local_bb1_lastiniteration_last_initeration_fu_stall_out | ~(local_bb1_lastiniteration_last_initeration_inputs_ready));
assign local_bb1_lastiniteration_last_initeration_causedstall = (local_bb1_lastiniteration_last_initeration_inputs_ready && (local_bb1_lastiniteration_last_initeration_fu_stall_out && !(~(local_bb1_lastiniteration_last_initeration_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG <= 'x;
		local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_lastiniteration_last_initeration_output_regs_ready)
		begin
			local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG <= local_bb1_lastiniteration_last_initeration_result;
			local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= local_bb1_lastiniteration_last_initeration_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_lastiniteration_last_initeration_stall_in))
			begin
				local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_arrayidx34_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb1_arrayidx34_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_175to176_bb1_arrayidx34_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_arrayidx34_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_175to176_bb1_arrayidx34_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_arrayidx34_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_arrayidx34_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_arrayidx34_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_arrayidx34_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_arrayidx34_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_arrayidx34_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_arrayidx34_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_arrayidx34_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(rnode_2to175_bb1_arrayidx34_0_NO_SHIFT_REG),
	.data_out(rnode_175to176_bb1_arrayidx34_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_arrayidx34_0_reg_176_fifo.DEPTH = 2;
defparam rnode_175to176_bb1_arrayidx34_0_reg_176_fifo.DATA_WIDTH = 64;
defparam rnode_175to176_bb1_arrayidx34_0_reg_176_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_175to176_bb1_arrayidx34_0_reg_176_fifo.IMPL = "ll_reg";

assign rnode_175to176_bb1_arrayidx34_0_reg_176_inputs_ready_NO_SHIFT_REG = rnode_2to175_bb1_arrayidx34_0_valid_out_NO_SHIFT_REG;
assign rnode_2to175_bb1_arrayidx34_0_stall_in_NO_SHIFT_REG = rnode_175to176_bb1_arrayidx34_0_stall_out_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_arrayidx34_0_NO_SHIFT_REG = rnode_175to176_bb1_arrayidx34_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_arrayidx34_0_stall_in_reg_176_NO_SHIFT_REG = rnode_175to176_bb1_arrayidx34_0_stall_in_NO_SHIFT_REG;
assign rnode_175to176_bb1_arrayidx34_0_valid_out_NO_SHIFT_REG = rnode_175to176_bb1_arrayidx34_0_valid_out_reg_176_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_exitcond19_stall_local;
wire local_bb1_exitcond19;

assign local_bb1_exitcond19 = (local_bb1_lftr_wideiv18 == input_iterations);

// This section implements an unregistered operation.
// 
wire local_bb1_first_cleanup_xor_or_stall_local;
wire local_bb1_first_cleanup_xor_or;

assign local_bb1_first_cleanup_xor_or = (input_wii_cmp6 | local_bb1_xor);

// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_3to179_bb1_initerations_push53_next_initerations_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_3to179_bb1_initerations_push53_next_initerations_0_NO_SHIFT_REG;
 logic rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_initerations_push53_next_initerations_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_3to179_bb1_initerations_push53_next_initerations_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_initerations_push53_next_initerations_NO_SHIFT_REG),
	.data_out(rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_fifo.DEPTH = 177;
defparam rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_fifo.DATA_WIDTH = 4;
defparam rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_fifo.IMPL = "ram";

assign rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_inputs_ready_NO_SHIFT_REG = local_bb1_initerations_push53_next_initerations_valid_out_NO_SHIFT_REG;
assign local_bb1_initerations_push53_next_initerations_stall_in = rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_initerations_push53_next_initerations_0_NO_SHIFT_REG = rnode_3to179_bb1_initerations_push53_next_initerations_0_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_in_reg_179_NO_SHIFT_REG = rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_in_NO_SHIFT_REG;
assign rnode_3to179_bb1_initerations_push53_next_initerations_0_valid_out_NO_SHIFT_REG = rnode_3to179_bb1_initerations_push53_next_initerations_0_valid_out_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG;
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_3to179_bb1_lastiniteration_last_initeration_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG),
	.data_out(rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_fifo.DEPTH = 177;
defparam rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_fifo.IMPL = "ram";

assign rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_inputs_ready_NO_SHIFT_REG = local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG;
assign local_bb1_lastiniteration_last_initeration_stall_in = rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG = rnode_3to179_bb1_lastiniteration_last_initeration_0_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_in_reg_179_NO_SHIFT_REG = rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
assign rnode_3to179_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG = rnode_3to179_bb1_lastiniteration_last_initeration_0_valid_out_reg_179_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u1_stall_local;
wire local_bb1_var__u1;

assign local_bb1_var__u1 = (input_wii_cmp6 | local_bb1_exitcond19);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_initerations_push53_next_initerations_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_179to180_bb1_initerations_push53_next_initerations_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_initerations_push53_next_initerations_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_initerations_push53_next_initerations_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_3to179_bb1_initerations_push53_next_initerations_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_fifo.DEPTH = 2;
defparam rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_fifo.DATA_WIDTH = 4;
defparam rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_fifo.IMPL = "ll_reg";

assign rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_3to179_bb1_initerations_push53_next_initerations_0_valid_out_NO_SHIFT_REG;
assign rnode_3to179_bb1_initerations_push53_next_initerations_0_stall_in_NO_SHIFT_REG = rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_initerations_push53_next_initerations_0_NO_SHIFT_REG = rnode_179to180_bb1_initerations_push53_next_initerations_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_in_reg_180_NO_SHIFT_REG = rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_in_NO_SHIFT_REG;
assign rnode_179to180_bb1_initerations_push53_next_initerations_0_valid_out_NO_SHIFT_REG = rnode_179to180_bb1_initerations_push53_next_initerations_0_valid_out_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_lastiniteration_last_initeration_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_3to179_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_fifo.DEPTH = 2;
defparam rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_fifo.IMPL = "ll_reg";

assign rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_3to179_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG;
assign rnode_3to179_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG = rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG = rnode_179to180_bb1_lastiniteration_last_initeration_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_in_reg_180_NO_SHIFT_REG = rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
assign rnode_179to180_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG = rnode_179to180_bb1_lastiniteration_last_initeration_0_valid_out_reg_180_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_notexit_stall_local;
wire local_bb1_notexit;

assign local_bb1_notexit = (local_bb1_var__u1 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_stall_local;
wire local_bb1_or;

assign local_bb1_or = (local_bb1_var__u1 | local_bb1_xor);

// This section implements an unregistered operation.
// 
wire local_bb1_masked_stall_local;
wire local_bb1_masked;

assign local_bb1_masked = (local_bb1_var__u1 & local_bb1_first_cleanup);

// This section implements an unregistered operation.
// 
wire local_bb1_cleanups_shl_stall_local;
wire [3:0] local_bb1_cleanups_shl;

assign local_bb1_cleanups_shl[3:1] = 3'h0;
assign local_bb1_cleanups_shl[0] = local_bb1_or;

// This section implements an unregistered operation.
// 
wire local_bb1_next_cleanups_valid_out;
wire local_bb1_next_cleanups_stall_in;
 reg local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG;
wire local_bb1_first_cleanup_valid_out_2;
wire local_bb1_first_cleanup_stall_in_2;
 reg local_bb1_first_cleanup_consumed_2_NO_SHIFT_REG;
wire local_bb1_masked_valid_out;
wire local_bb1_masked_stall_in;
 reg local_bb1_masked_consumed_0_NO_SHIFT_REG;
wire local_bb1_first_cleanup_xor_or_valid_out;
wire local_bb1_first_cleanup_xor_or_stall_in;
 reg local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG;
wire local_bb1_indvars_iv_next17_valid_out_0;
wire local_bb1_indvars_iv_next17_stall_in_0;
 reg local_bb1_indvars_iv_next17_consumed_0_NO_SHIFT_REG;
wire local_bb1_notexit_valid_out;
wire local_bb1_notexit_stall_in;
 reg local_bb1_notexit_consumed_0_NO_SHIFT_REG;
wire local_bb1_next_cleanups_inputs_ready;
wire local_bb1_next_cleanups_stall_local;
wire [3:0] local_bb1_next_cleanups;

assign local_bb1_next_cleanups_inputs_ready = (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_0 & rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_valid_out_1 & rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_valid_out_2);
assign local_bb1_next_cleanups = (rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7 << local_bb1_cleanups_shl);
assign local_bb1_next_cleanups_stall_local = ((local_bb1_next_cleanups_stall_in & ~(local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG)) | (local_bb1_first_cleanup_stall_in_2 & ~(local_bb1_first_cleanup_consumed_2_NO_SHIFT_REG)) | (local_bb1_masked_stall_in & ~(local_bb1_masked_consumed_0_NO_SHIFT_REG)) | (local_bb1_first_cleanup_xor_or_stall_in & ~(local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG)) | (local_bb1_indvars_iv_next17_stall_in_0 & ~(local_bb1_indvars_iv_next17_consumed_0_NO_SHIFT_REG)) | (local_bb1_notexit_stall_in & ~(local_bb1_notexit_consumed_0_NO_SHIFT_REG)));
assign local_bb1_next_cleanups_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG));
assign local_bb1_first_cleanup_valid_out_2 = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_first_cleanup_consumed_2_NO_SHIFT_REG));
assign local_bb1_masked_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_masked_consumed_0_NO_SHIFT_REG));
assign local_bb1_first_cleanup_xor_or_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG));
assign local_bb1_indvars_iv_next17_valid_out_0 = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_indvars_iv_next17_consumed_0_NO_SHIFT_REG));
assign local_bb1_notexit_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_notexit_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_0 = (local_bb1_next_cleanups_stall_local | ~(local_bb1_next_cleanups_inputs_ready));
assign rstag_2to2_bb1_cleanups_pop55_acl_pop_i4_7_stall_in_1 = (local_bb1_next_cleanups_stall_local | ~(local_bb1_next_cleanups_inputs_ready));
assign rstag_2to2_bb1_indvars_iv16_pop52_acl_pop_i64_0_stall_in_2 = (local_bb1_next_cleanups_stall_local | ~(local_bb1_next_cleanups_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_first_cleanup_consumed_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_masked_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_indvars_iv_next17_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_notexit_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_cleanups_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_first_cleanup_consumed_2_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_first_cleanup_consumed_2_NO_SHIFT_REG | ~(local_bb1_first_cleanup_stall_in_2)) & local_bb1_next_cleanups_stall_local);
		local_bb1_masked_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_masked_consumed_0_NO_SHIFT_REG | ~(local_bb1_masked_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG | ~(local_bb1_first_cleanup_xor_or_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_indvars_iv_next17_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_indvars_iv_next17_consumed_0_NO_SHIFT_REG | ~(local_bb1_indvars_iv_next17_stall_in_0)) & local_bb1_next_cleanups_stall_local);
		local_bb1_notexit_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_notexit_consumed_0_NO_SHIFT_REG | ~(local_bb1_notexit_stall_in)) & local_bb1_next_cleanups_stall_local);
	end
end


// This section implements a staging register.
// 
wire rstag_2to2_bb1_next_cleanups_valid_out;
wire rstag_2to2_bb1_next_cleanups_stall_in;
wire rstag_2to2_bb1_next_cleanups_inputs_ready;
wire rstag_2to2_bb1_next_cleanups_stall_local;
 reg rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_next_cleanups_combined_valid;
 reg [3:0] rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG;
wire [3:0] rstag_2to2_bb1_next_cleanups;

assign rstag_2to2_bb1_next_cleanups_inputs_ready = local_bb1_next_cleanups_valid_out;
assign rstag_2to2_bb1_next_cleanups = (rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG : local_bb1_next_cleanups);
assign rstag_2to2_bb1_next_cleanups_combined_valid = (rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_next_cleanups_inputs_ready);
assign rstag_2to2_bb1_next_cleanups_valid_out = rstag_2to2_bb1_next_cleanups_combined_valid;
assign rstag_2to2_bb1_next_cleanups_stall_local = rstag_2to2_bb1_next_cleanups_stall_in;
assign local_bb1_next_cleanups_stall_in = (|rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_next_cleanups_stall_local)
		begin
			if (~(rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_next_cleanups_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG <= local_bb1_next_cleanups;
		end
	end
end


// Register node:
//  * latency = 177
//  * capacity = 177
 logic rnode_2to179_bb1_masked_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to179_bb1_masked_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to179_bb1_masked_0_NO_SHIFT_REG;
 logic rnode_2to179_bb1_masked_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to179_bb1_masked_0_reg_179_NO_SHIFT_REG;
 logic rnode_2to179_bb1_masked_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_2to179_bb1_masked_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_2to179_bb1_masked_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_2to179_bb1_masked_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to179_bb1_masked_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to179_bb1_masked_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_2to179_bb1_masked_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_2to179_bb1_masked_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_masked),
	.data_out(rnode_2to179_bb1_masked_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_2to179_bb1_masked_0_reg_179_fifo.DEPTH = 178;
defparam rnode_2to179_bb1_masked_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_2to179_bb1_masked_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to179_bb1_masked_0_reg_179_fifo.IMPL = "ram";

assign rnode_2to179_bb1_masked_0_reg_179_inputs_ready_NO_SHIFT_REG = local_bb1_masked_valid_out;
assign local_bb1_masked_stall_in = rnode_2to179_bb1_masked_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_2to179_bb1_masked_0_NO_SHIFT_REG = rnode_2to179_bb1_masked_0_reg_179_NO_SHIFT_REG;
assign rnode_2to179_bb1_masked_0_stall_in_reg_179_NO_SHIFT_REG = rnode_2to179_bb1_masked_0_stall_in_NO_SHIFT_REG;
assign rnode_2to179_bb1_masked_0_valid_out_NO_SHIFT_REG = rnode_2to179_bb1_masked_0_valid_out_reg_179_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb1_first_cleanup_xor_or_valid_out_0;
wire rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0;
 reg rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or_valid_out_1;
wire rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1;
 reg rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready;
wire rstag_2to2_bb1_first_cleanup_xor_or_stall_local;
 reg rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or_combined_valid;
 reg rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or;

assign rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready = local_bb1_first_cleanup_xor_or_valid_out;
assign rstag_2to2_bb1_first_cleanup_xor_or = (rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG : local_bb1_first_cleanup_xor_or);
assign rstag_2to2_bb1_first_cleanup_xor_or_combined_valid = (rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready);
assign rstag_2to2_bb1_first_cleanup_xor_or_stall_local = ((rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0 & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1 & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG)));
assign rstag_2to2_bb1_first_cleanup_xor_or_valid_out_0 = (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_first_cleanup_xor_or_valid_out_1 = (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG));
assign local_bb1_first_cleanup_xor_or_stall_in = (|rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_first_cleanup_xor_or_stall_local)
		begin
			if (~(rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG <= local_bb1_first_cleanup_xor_or;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & (rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0)) & rstag_2to2_bb1_first_cleanup_xor_or_stall_local);
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & (rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1)) & rstag_2to2_bb1_first_cleanup_xor_or_stall_local);
	end
end


// This section implements a registered operation.
// 
wire local_bb1_indvars_iv16_push52_indvars_iv_next17_inputs_ready;
 reg local_bb1_indvars_iv16_push52_indvars_iv_next17_valid_out_NO_SHIFT_REG;
wire local_bb1_indvars_iv16_push52_indvars_iv_next17_stall_in;
wire local_bb1_indvars_iv16_push52_indvars_iv_next17_output_regs_ready;
wire [63:0] local_bb1_indvars_iv16_push52_indvars_iv_next17_result;
wire local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_valid_out;
wire local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_stall_out;
 reg [63:0] local_bb1_indvars_iv16_push52_indvars_iv_next17_NO_SHIFT_REG;
wire local_bb1_indvars_iv16_push52_indvars_iv_next17_causedstall;

acl_push local_bb1_indvars_iv16_push52_indvars_iv_next17_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(local_bb1_indvars_iv_next17),
	.stall_out(local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_stall_out),
	.valid_in(local_bb1_indvars_iv16_push52_indvars_iv_next17_inputs_ready),
	.valid_out(local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_valid_out),
	.stall_in(~(local_bb1_indvars_iv16_push52_indvars_iv_next17_output_regs_ready)),
	.data_out(local_bb1_indvars_iv16_push52_indvars_iv_next17_result),
	.feedback_out(feedback_data_out_52),
	.feedback_valid_out(feedback_valid_out_52),
	.feedback_stall_in(feedback_stall_in_52)
);

defparam local_bb1_indvars_iv16_push52_indvars_iv_next17_feedback.STALLFREE = 0;
defparam local_bb1_indvars_iv16_push52_indvars_iv_next17_feedback.DATA_WIDTH = 64;
defparam local_bb1_indvars_iv16_push52_indvars_iv_next17_feedback.FIFO_DEPTH = 2;
defparam local_bb1_indvars_iv16_push52_indvars_iv_next17_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_indvars_iv16_push52_indvars_iv_next17_feedback.STYLE = "REGULAR";

assign local_bb1_indvars_iv16_push52_indvars_iv_next17_inputs_ready = (local_bb1_indvars_iv_next17_valid_out_0 & rstag_2to2_bb1_keep_going_forked_valid_out_3);
assign local_bb1_indvars_iv16_push52_indvars_iv_next17_output_regs_ready = (&(~(local_bb1_indvars_iv16_push52_indvars_iv_next17_valid_out_NO_SHIFT_REG) | ~(local_bb1_indvars_iv16_push52_indvars_iv_next17_stall_in)));
assign local_bb1_indvars_iv_next17_stall_in_0 = (local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_stall_out | ~(local_bb1_indvars_iv16_push52_indvars_iv_next17_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_3 = (local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_stall_out | ~(local_bb1_indvars_iv16_push52_indvars_iv_next17_inputs_ready));
assign local_bb1_indvars_iv16_push52_indvars_iv_next17_causedstall = (local_bb1_indvars_iv16_push52_indvars_iv_next17_inputs_ready && (local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_stall_out && !(~(local_bb1_indvars_iv16_push52_indvars_iv_next17_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_indvars_iv16_push52_indvars_iv_next17_NO_SHIFT_REG <= 'x;
		local_bb1_indvars_iv16_push52_indvars_iv_next17_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_indvars_iv16_push52_indvars_iv_next17_output_regs_ready)
		begin
			local_bb1_indvars_iv16_push52_indvars_iv_next17_NO_SHIFT_REG <= local_bb1_indvars_iv16_push52_indvars_iv_next17_result;
			local_bb1_indvars_iv16_push52_indvars_iv_next17_valid_out_NO_SHIFT_REG <= local_bb1_indvars_iv16_push52_indvars_iv_next17_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_indvars_iv16_push52_indvars_iv_next17_stall_in))
			begin
				local_bb1_indvars_iv16_push52_indvars_iv_next17_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_2to2_bb1_notexit_valid_out;
wire rstag_2to2_bb1_notexit_stall_in;
wire rstag_2to2_bb1_notexit_inputs_ready;
wire rstag_2to2_bb1_notexit_stall_local;
 reg rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_notexit_combined_valid;
 reg rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb1_notexit;

assign rstag_2to2_bb1_notexit_inputs_ready = local_bb1_notexit_valid_out;
assign rstag_2to2_bb1_notexit = (rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG : local_bb1_notexit);
assign rstag_2to2_bb1_notexit_combined_valid = (rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_notexit_inputs_ready);
assign rstag_2to2_bb1_notexit_valid_out = rstag_2to2_bb1_notexit_combined_valid;
assign rstag_2to2_bb1_notexit_stall_local = rstag_2to2_bb1_notexit_stall_in;
assign local_bb1_notexit_stall_in = (|rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_notexit_stall_local)
		begin
			if (~(rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_notexit_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG <= local_bb1_notexit;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_cleanups_push55_next_cleanups_inputs_ready;
 reg local_bb1_cleanups_push55_next_cleanups_valid_out_NO_SHIFT_REG;
wire local_bb1_cleanups_push55_next_cleanups_stall_in;
wire local_bb1_cleanups_push55_next_cleanups_output_regs_ready;
wire [3:0] local_bb1_cleanups_push55_next_cleanups_result;
wire local_bb1_cleanups_push55_next_cleanups_fu_valid_out;
wire local_bb1_cleanups_push55_next_cleanups_fu_stall_out;
 reg [3:0] local_bb1_cleanups_push55_next_cleanups_NO_SHIFT_REG;
wire local_bb1_cleanups_push55_next_cleanups_causedstall;

acl_push local_bb1_cleanups_push55_next_cleanups_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(rstag_2to2_bb1_next_cleanups),
	.stall_out(local_bb1_cleanups_push55_next_cleanups_fu_stall_out),
	.valid_in(local_bb1_cleanups_push55_next_cleanups_inputs_ready),
	.valid_out(local_bb1_cleanups_push55_next_cleanups_fu_valid_out),
	.stall_in(~(local_bb1_cleanups_push55_next_cleanups_output_regs_ready)),
	.data_out(local_bb1_cleanups_push55_next_cleanups_result),
	.feedback_out(feedback_data_out_55),
	.feedback_valid_out(feedback_valid_out_55),
	.feedback_stall_in(feedback_stall_in_55)
);

defparam local_bb1_cleanups_push55_next_cleanups_feedback.STALLFREE = 0;
defparam local_bb1_cleanups_push55_next_cleanups_feedback.DATA_WIDTH = 4;
defparam local_bb1_cleanups_push55_next_cleanups_feedback.FIFO_DEPTH = 2;
defparam local_bb1_cleanups_push55_next_cleanups_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_cleanups_push55_next_cleanups_feedback.STYLE = "REGULAR";

assign local_bb1_cleanups_push55_next_cleanups_inputs_ready = (rstag_2to2_bb1_next_cleanups_valid_out & rstag_2to2_bb1_keep_going_forked_valid_out_1);
assign local_bb1_cleanups_push55_next_cleanups_output_regs_ready = (&(~(local_bb1_cleanups_push55_next_cleanups_valid_out_NO_SHIFT_REG) | ~(local_bb1_cleanups_push55_next_cleanups_stall_in)));
assign rstag_2to2_bb1_next_cleanups_stall_in = (local_bb1_cleanups_push55_next_cleanups_fu_stall_out | ~(local_bb1_cleanups_push55_next_cleanups_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_1 = (local_bb1_cleanups_push55_next_cleanups_fu_stall_out | ~(local_bb1_cleanups_push55_next_cleanups_inputs_ready));
assign local_bb1_cleanups_push55_next_cleanups_causedstall = (local_bb1_cleanups_push55_next_cleanups_inputs_ready && (local_bb1_cleanups_push55_next_cleanups_fu_stall_out && !(~(local_bb1_cleanups_push55_next_cleanups_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cleanups_push55_next_cleanups_NO_SHIFT_REG <= 'x;
		local_bb1_cleanups_push55_next_cleanups_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_cleanups_push55_next_cleanups_output_regs_ready)
		begin
			local_bb1_cleanups_push55_next_cleanups_NO_SHIFT_REG <= local_bb1_cleanups_push55_next_cleanups_result;
			local_bb1_cleanups_push55_next_cleanups_valid_out_NO_SHIFT_REG <= local_bb1_cleanups_push55_next_cleanups_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_cleanups_push55_next_cleanups_stall_in))
			begin
				local_bb1_cleanups_push55_next_cleanups_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_masked_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_masked_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1_masked_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_masked_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_masked_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_masked_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_masked_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_masked_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_masked_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_masked_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_masked_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_masked_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_masked_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_2to179_bb1_masked_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_masked_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_masked_0_reg_180_fifo.DEPTH = 2;
defparam rnode_179to180_bb1_masked_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_masked_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_179to180_bb1_masked_0_reg_180_fifo.IMPL = "ll_reg";

assign rnode_179to180_bb1_masked_0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_2to179_bb1_masked_0_valid_out_NO_SHIFT_REG;
assign rnode_2to179_bb1_masked_0_stall_in_NO_SHIFT_REG = rnode_179to180_bb1_masked_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_masked_0_NO_SHIFT_REG = rnode_179to180_bb1_masked_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_masked_0_stall_in_reg_180_NO_SHIFT_REG = rnode_179to180_bb1_masked_0_stall_in_NO_SHIFT_REG;
assign rnode_179to180_bb1_masked_0_valid_out_NO_SHIFT_REG = rnode_179to180_bb1_masked_0_valid_out_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 173
//  * capacity = 173
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG;
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_NO_SHIFT_REG;
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_valid_out_reg_175_NO_SHIFT_REG;
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_stall_in_reg_175_NO_SHIFT_REG;
 logic rnode_2to175_bb1_first_cleanup_xor_or_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to175_bb1_first_cleanup_xor_or_0_stall_in_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_2to175_bb1_first_cleanup_xor_or_0_valid_out_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_2to175_bb1_first_cleanup_xor_or_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb1_first_cleanup_xor_or),
	.data_out(rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_fifo.DEPTH = 174;
defparam rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_fifo.DATA_WIDTH = 1;
defparam rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_fifo.IMPL = "ram";

assign rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb1_first_cleanup_xor_or_valid_out_0;
assign rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0 = rnode_2to175_bb1_first_cleanup_xor_or_0_stall_out_reg_175_NO_SHIFT_REG;
assign rnode_2to175_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG = rnode_2to175_bb1_first_cleanup_xor_or_0_reg_175_NO_SHIFT_REG;
assign rnode_2to175_bb1_first_cleanup_xor_or_0_stall_in_reg_175_NO_SHIFT_REG = rnode_2to175_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_2to175_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG = rnode_2to175_bb1_first_cleanup_xor_or_0_valid_out_reg_175_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_ld__inputs_ready;
 reg local_bb1_ld__valid_out_NO_SHIFT_REG;
wire local_bb1_ld__stall_in;
wire local_bb1_ld__output_regs_ready;
wire local_bb1_ld__fu_stall_out;
wire local_bb1_ld__fu_valid_out;
wire [7:0] local_bb1_ld__lsu_dataout;
 reg [7:0] local_bb1_ld__NO_SHIFT_REG;
wire local_bb1_ld__causedstall;

lsu_top lsu_local_bb1_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_ld__fu_stall_out),
	.i_valid(local_bb1_ld__inputs_ready),
	.i_address(local_bb1_arrayidx5),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb1_first_cleanup_xor_or),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_ld__output_regs_ready)),
	.o_valid(local_bb1_ld__fu_valid_out),
	.o_readdata(local_bb1_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_ld__active),
	.avm_address(avm_local_bb1_ld__address),
	.avm_read(avm_local_bb1_ld__read),
	.avm_readdata(avm_local_bb1_ld__readdata),
	.avm_write(avm_local_bb1_ld__write),
	.avm_writeack(avm_local_bb1_ld__writeack),
	.avm_burstcount(avm_local_bb1_ld__burstcount),
	.avm_writedata(avm_local_bb1_ld__writedata),
	.avm_byteenable(avm_local_bb1_ld__byteenable),
	.avm_waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb1_ld__readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_ld_.AWIDTH = 30;
defparam lsu_local_bb1_ld_.WIDTH_BYTES = 1;
defparam lsu_local_bb1_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_.ALIGNMENT_BYTES = 1;
defparam lsu_local_bb1_ld_.READ = 1;
defparam lsu_local_bb1_ld_.ATOMIC = 0;
defparam lsu_local_bb1_ld_.WIDTH = 8;
defparam lsu_local_bb1_ld_.MWIDTH = 256;
defparam lsu_local_bb1_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld_.MEMORY_SIDE_MEM_LATENCY = 73;
defparam lsu_local_bb1_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb1_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb1_ld_.USECACHING = 0;
defparam lsu_local_bb1_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb1_ld_.ADDRSPACE = 1;
defparam lsu_local_bb1_ld_.STYLE = "BURST-COALESCED";

assign local_bb1_ld__inputs_ready = (local_bb1_arrayidx5_valid_out & rstag_2to2_bb1_first_cleanup_xor_or_valid_out_1);
assign local_bb1_ld__output_regs_ready = (&(~(local_bb1_ld__valid_out_NO_SHIFT_REG) | ~(local_bb1_ld__stall_in)));
assign local_bb1_arrayidx5_stall_in = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
assign rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1 = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
assign local_bb1_ld__causedstall = (local_bb1_ld__inputs_ready && (local_bb1_ld__fu_stall_out && !(~(local_bb1_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_ld__NO_SHIFT_REG <= 'x;
		local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_ld__output_regs_ready)
		begin
			local_bb1_ld__NO_SHIFT_REG <= local_bb1_ld__lsu_dataout;
			local_bb1_ld__valid_out_NO_SHIFT_REG <= local_bb1_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_ld__stall_in))
			begin
				local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_NO_SHIFT_REG;
 logic rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_indvars_iv16_push52_indvars_iv_next17_NO_SHIFT_REG),
	.data_out(rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_fifo.DEPTH = 177;
defparam rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_fifo.DATA_WIDTH = 64;
defparam rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_fifo.IMPL = "ram";

assign rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_inputs_ready_NO_SHIFT_REG = local_bb1_indvars_iv16_push52_indvars_iv_next17_valid_out_NO_SHIFT_REG;
assign local_bb1_indvars_iv16_push52_indvars_iv_next17_stall_in = rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_NO_SHIFT_REG = rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_reg_179_NO_SHIFT_REG = rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_NO_SHIFT_REG;
assign rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_NO_SHIFT_REG = rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_reg_179_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_notexitcond_notexit_inputs_ready;
 reg local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG;
wire local_bb1_notexitcond_notexit_stall_in;
wire local_bb1_notexitcond_notexit_output_regs_ready;
wire local_bb1_notexitcond_notexit_result;
wire local_bb1_notexitcond_notexit_fu_valid_out;
wire local_bb1_notexitcond_notexit_fu_stall_out;
 reg local_bb1_notexitcond_notexit_NO_SHIFT_REG;
wire local_bb1_notexitcond_notexit_causedstall;

acl_push local_bb1_notexitcond_notexit_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_first_cleanup),
	.predicate(1'b0),
	.data_in(rstag_2to2_bb1_notexit),
	.stall_out(local_bb1_notexitcond_notexit_fu_stall_out),
	.valid_in(local_bb1_notexitcond_notexit_inputs_ready),
	.valid_out(local_bb1_notexitcond_notexit_fu_valid_out),
	.stall_in(~(local_bb1_notexitcond_notexit_output_regs_ready)),
	.data_out(local_bb1_notexitcond_notexit_result),
	.feedback_out(feedback_data_out_1),
	.feedback_valid_out(feedback_valid_out_1),
	.feedback_stall_in(feedback_stall_in_1)
);

defparam local_bb1_notexitcond_notexit_feedback.STALLFREE = 0;
defparam local_bb1_notexitcond_notexit_feedback.DATA_WIDTH = 1;
defparam local_bb1_notexitcond_notexit_feedback.FIFO_DEPTH = 4;
defparam local_bb1_notexitcond_notexit_feedback.MIN_FIFO_LATENCY = 2;
defparam local_bb1_notexitcond_notexit_feedback.STYLE = "REGULAR";

assign local_bb1_notexitcond_notexit_inputs_ready = (local_bb1_first_cleanup_valid_out_2 & rstag_2to2_bb1_notexit_valid_out);
assign local_bb1_notexitcond_notexit_output_regs_ready = (&(~(local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG) | ~(local_bb1_notexitcond_notexit_stall_in)));
assign local_bb1_first_cleanup_stall_in_2 = (local_bb1_notexitcond_notexit_fu_stall_out | ~(local_bb1_notexitcond_notexit_inputs_ready));
assign rstag_2to2_bb1_notexit_stall_in = (local_bb1_notexitcond_notexit_fu_stall_out | ~(local_bb1_notexitcond_notexit_inputs_ready));
assign local_bb1_notexitcond_notexit_causedstall = (local_bb1_notexitcond_notexit_inputs_ready && (local_bb1_notexitcond_notexit_fu_stall_out && !(~(local_bb1_notexitcond_notexit_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_notexitcond_notexit_NO_SHIFT_REG <= 'x;
		local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_notexitcond_notexit_output_regs_ready)
		begin
			local_bb1_notexitcond_notexit_NO_SHIFT_REG <= local_bb1_notexitcond_notexit_result;
			local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= local_bb1_notexitcond_notexit_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_notexitcond_notexit_stall_in))
			begin
				local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_3to179_bb1_cleanups_push55_next_cleanups_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_3to179_bb1_cleanups_push55_next_cleanups_0_NO_SHIFT_REG;
 logic rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_cleanups_push55_next_cleanups_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_3to179_bb1_cleanups_push55_next_cleanups_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_cleanups_push55_next_cleanups_NO_SHIFT_REG),
	.data_out(rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_fifo.DEPTH = 177;
defparam rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_fifo.DATA_WIDTH = 4;
defparam rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_fifo.IMPL = "ram";

assign rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_inputs_ready_NO_SHIFT_REG = local_bb1_cleanups_push55_next_cleanups_valid_out_NO_SHIFT_REG;
assign local_bb1_cleanups_push55_next_cleanups_stall_in = rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_cleanups_push55_next_cleanups_0_NO_SHIFT_REG = rnode_3to179_bb1_cleanups_push55_next_cleanups_0_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_in_reg_179_NO_SHIFT_REG = rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_in_NO_SHIFT_REG;
assign rnode_3to179_bb1_cleanups_push55_next_cleanups_0_valid_out_NO_SHIFT_REG = rnode_3to179_bb1_cleanups_push55_next_cleanups_0_valid_out_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_first_cleanup_xor_or_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_first_cleanup_xor_or_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_first_cleanup_xor_or_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_first_cleanup_xor_or_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(rnode_2to175_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG),
	.data_out(rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_fifo.DEPTH = 2;
defparam rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_fifo.DATA_WIDTH = 1;
defparam rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_fifo.IMPL = "ll_reg";

assign rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_inputs_ready_NO_SHIFT_REG = rnode_2to175_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG;
assign rnode_2to175_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG = rnode_175to176_bb1_first_cleanup_xor_or_0_stall_out_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG = rnode_175to176_bb1_first_cleanup_xor_or_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_first_cleanup_xor_or_0_stall_in_reg_176_NO_SHIFT_REG = rnode_175to176_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_175to176_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG = rnode_175to176_bb1_first_cleanup_xor_or_0_valid_out_reg_176_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_162to162_bb1_ld__valid_out;
wire rstag_162to162_bb1_ld__stall_in;
wire rstag_162to162_bb1_ld__inputs_ready;
wire rstag_162to162_bb1_ld__stall_local;
 reg rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb1_ld__combined_valid;
 reg [7:0] rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG;
wire [7:0] rstag_162to162_bb1_ld_;

assign rstag_162to162_bb1_ld__inputs_ready = local_bb1_ld__valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb1_ld_ = (rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG ? rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG : local_bb1_ld__NO_SHIFT_REG);
assign rstag_162to162_bb1_ld__combined_valid = (rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG | rstag_162to162_bb1_ld__inputs_ready);
assign rstag_162to162_bb1_ld__valid_out = rstag_162to162_bb1_ld__combined_valid;
assign rstag_162to162_bb1_ld__stall_local = rstag_162to162_bb1_ld__stall_in;
assign local_bb1_ld__stall_in = (|rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb1_ld__stall_local)
		begin
			if (~(rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG <= rstag_162to162_bb1_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG <= local_bb1_ld__NO_SHIFT_REG;
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_fifo.DEPTH = 2;
defparam rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_fifo.DATA_WIDTH = 64;
defparam rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_fifo.IMPL = "ll_reg";

assign rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_NO_SHIFT_REG;
assign rnode_3to179_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_NO_SHIFT_REG = rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_NO_SHIFT_REG = rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_reg_180_NO_SHIFT_REG = rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_NO_SHIFT_REG;
assign rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_NO_SHIFT_REG = rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_3to179_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to179_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to179_bb1_notexitcond_notexit_0_NO_SHIFT_REG;
 logic rnode_3to179_bb1_notexitcond_notexit_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to179_bb1_notexitcond_notexit_0_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_notexitcond_notexit_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_notexitcond_notexit_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_3to179_bb1_notexitcond_notexit_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_3to179_bb1_notexitcond_notexit_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to179_bb1_notexitcond_notexit_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to179_bb1_notexitcond_notexit_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_3to179_bb1_notexitcond_notexit_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_3to179_bb1_notexitcond_notexit_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_notexitcond_notexit_NO_SHIFT_REG),
	.data_out(rnode_3to179_bb1_notexitcond_notexit_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_3to179_bb1_notexitcond_notexit_0_reg_179_fifo.DEPTH = 177;
defparam rnode_3to179_bb1_notexitcond_notexit_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_3to179_bb1_notexitcond_notexit_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to179_bb1_notexitcond_notexit_0_reg_179_fifo.IMPL = "ram";

assign rnode_3to179_bb1_notexitcond_notexit_0_reg_179_inputs_ready_NO_SHIFT_REG = local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG;
assign local_bb1_notexitcond_notexit_stall_in = rnode_3to179_bb1_notexitcond_notexit_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_notexitcond_notexit_0_NO_SHIFT_REG = rnode_3to179_bb1_notexitcond_notexit_0_reg_179_NO_SHIFT_REG;
assign rnode_3to179_bb1_notexitcond_notexit_0_stall_in_reg_179_NO_SHIFT_REG = rnode_3to179_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
assign rnode_3to179_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG = rnode_3to179_bb1_notexitcond_notexit_0_valid_out_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_cleanups_push55_next_cleanups_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_179to180_bb1_cleanups_push55_next_cleanups_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cleanups_push55_next_cleanups_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_cleanups_push55_next_cleanups_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_3to179_bb1_cleanups_push55_next_cleanups_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_fifo.DEPTH = 2;
defparam rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_fifo.DATA_WIDTH = 4;
defparam rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_fifo.IMPL = "ll_reg";

assign rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_3to179_bb1_cleanups_push55_next_cleanups_0_valid_out_NO_SHIFT_REG;
assign rnode_3to179_bb1_cleanups_push55_next_cleanups_0_stall_in_NO_SHIFT_REG = rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_cleanups_push55_next_cleanups_0_NO_SHIFT_REG = rnode_179to180_bb1_cleanups_push55_next_cleanups_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_in_reg_180_NO_SHIFT_REG = rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_in_NO_SHIFT_REG;
assign rnode_179to180_bb1_cleanups_push55_next_cleanups_0_valid_out_NO_SHIFT_REG = rnode_179to180_bb1_cleanups_push55_next_cleanups_0_valid_out_reg_180_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni3_valid_out;
wire local_bb1_c0_eni3_stall_in;
wire local_bb1_c0_eni3_inputs_ready;
wire local_bb1_c0_eni3_stall_local;
wire [31:0] local_bb1_c0_eni3;

assign local_bb1_c0_eni3_inputs_ready = (rnode_161to162_forked_0_valid_out_0_NO_SHIFT_REG & rnode_161to162_bb1_keep_going_forked_0_valid_out_0_NO_SHIFT_REG & rstag_162to162_bb1_ld__valid_out);
assign local_bb1_c0_eni3[23:0] = local_bb1_c0_eni2[23:0];
assign local_bb1_c0_eni3[31:24] = rstag_162to162_bb1_ld_;
assign local_bb1_c0_eni3_valid_out = local_bb1_c0_eni3_inputs_ready;
assign local_bb1_c0_eni3_stall_local = local_bb1_c0_eni3_stall_in;
assign rnode_161to162_forked_0_stall_in_0_NO_SHIFT_REG = (local_bb1_c0_eni3_stall_local | ~(local_bb1_c0_eni3_inputs_ready));
assign rnode_161to162_bb1_keep_going_forked_0_stall_in_0_NO_SHIFT_REG = (local_bb1_c0_eni3_stall_local | ~(local_bb1_c0_eni3_inputs_ready));
assign rstag_162to162_bb1_ld__stall_in = (local_bb1_c0_eni3_stall_local | ~(local_bb1_c0_eni3_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1_notexitcond_notexit_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_notexitcond_notexit_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_notexitcond_notexit_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_notexitcond_notexit_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_notexitcond_notexit_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_notexitcond_notexit_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_notexitcond_notexit_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_notexitcond_notexit_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_notexitcond_notexit_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_notexitcond_notexit_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_notexitcond_notexit_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_3to179_bb1_notexitcond_notexit_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_notexitcond_notexit_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_notexitcond_notexit_0_reg_180_fifo.DEPTH = 2;
defparam rnode_179to180_bb1_notexitcond_notexit_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_notexitcond_notexit_0_reg_180_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_179to180_bb1_notexitcond_notexit_0_reg_180_fifo.IMPL = "ll_reg";

assign rnode_179to180_bb1_notexitcond_notexit_0_reg_180_inputs_ready_NO_SHIFT_REG = rnode_3to179_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
assign rnode_3to179_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG = rnode_179to180_bb1_notexitcond_notexit_0_stall_out_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_notexitcond_notexit_0_NO_SHIFT_REG = rnode_179to180_bb1_notexitcond_notexit_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_notexitcond_notexit_0_stall_in_reg_180_NO_SHIFT_REG = rnode_179to180_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
assign rnode_179to180_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG = rnode_179to180_bb1_notexitcond_notexit_0_valid_out_reg_180_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_c0_enter_c0_eni3_inputs_ready;
 reg local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_stall_in_0;
 reg local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_stall_in_1;
 reg local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_stall_in_2;
wire local_bb1_c0_enter_c0_eni3_output_regs_ready;
 reg [31:0] local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_input_accepted;
wire local_bb1_c0_exit_c0_exi1_entry_stall;
wire local_bb1_c0_exit_c0_exi1_output_regs_ready;
wire [9:0] local_bb1_c0_exit_c0_exi1_valid_bits;
wire local_bb1_c0_exit_c0_exi1_phases;
wire local_bb1_c0_enter_c0_eni3_inc_pipelined_thread;
wire local_bb1_c0_enter_c0_eni3_dec_pipelined_thread;
wire local_bb1_c0_enter_c0_eni3_causedstall;

assign local_bb1_c0_enter_c0_eni3_inputs_ready = (local_bb1_c0_eni3_valid_out & rnode_161to162_forked_0_valid_out_1_NO_SHIFT_REG & rnode_161to162_bb1_keep_going_forked_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_c0_enter_c0_eni3_output_regs_ready = 1'b1;
assign local_bb1_c0_enter_c0_eni3_input_accepted = (local_bb1_c0_enter_c0_eni3_inputs_ready && !(local_bb1_c0_exit_c0_exi1_entry_stall));
assign local_bb1_c0_enter_c0_eni3_inc_pipelined_thread = rnode_161to162_forked_1_NO_SHIFT_REG;
assign local_bb1_c0_enter_c0_eni3_dec_pipelined_thread = ~(rnode_161to162_bb1_keep_going_forked_1_NO_SHIFT_REG);
assign local_bb1_c0_eni3_stall_in = ((~(local_bb1_c0_enter_c0_eni3_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign rnode_161to162_forked_0_stall_in_1_NO_SHIFT_REG = ((~(local_bb1_c0_enter_c0_eni3_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign rnode_161to162_bb1_keep_going_forked_0_stall_in_1_NO_SHIFT_REG = ((~(local_bb1_c0_enter_c0_eni3_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign local_bb1_c0_enter_c0_eni3_causedstall = (1'b1 && ((~(local_bb1_c0_enter_c0_eni3_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG <= 'x;
		local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_enter_c0_eni3_output_regs_ready)
		begin
			local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG <= local_bb1_c0_eni3;
			local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_enter_c0_eni3_stall_in_0))
			begin
				local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni3_stall_in_1))
			begin
				local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni3_stall_in_2))
			begin
				local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_c0_ene1_inputs_ready;
 reg local_bb1_c0_ene1_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_ene1_stall_in_0;
 reg local_bb1_c0_ene1_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_ene1_stall_in_1;
 reg local_bb1_c0_ene1_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c0_ene1_stall_in_2;
 reg local_bb1_c0_ene1_valid_out_3_NO_SHIFT_REG;
wire local_bb1_c0_ene1_stall_in_3;
 reg local_bb1_c0_ene1_valid_out_4_NO_SHIFT_REG;
wire local_bb1_c0_ene1_stall_in_4;
 reg local_bb1_c0_ene1_valid_out_5_NO_SHIFT_REG;
wire local_bb1_c0_ene1_stall_in_5;
 reg local_bb1_c0_ene1_valid_out_6_NO_SHIFT_REG;
wire local_bb1_c0_ene1_stall_in_6;
wire local_bb1_c0_ene1_output_regs_ready;
 reg local_bb1_c0_ene1_NO_SHIFT_REG;
wire local_bb1_c0_ene1_op_wire;
wire local_bb1_c0_ene1_causedstall;

assign local_bb1_c0_ene1_inputs_ready = 1'b1;
assign local_bb1_c0_ene1_output_regs_ready = 1'b1;
assign local_bb1_c0_ene1_op_wire = local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG[8];
assign local_bb1_c0_enter_c0_eni3_stall_in_0 = 1'b0;
assign local_bb1_c0_ene1_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_ene1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_ene1_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene1_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene1_valid_out_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene1_valid_out_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene1_valid_out_4_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene1_valid_out_5_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene1_valid_out_6_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_ene1_output_regs_ready)
		begin
			local_bb1_c0_ene1_NO_SHIFT_REG <= local_bb1_c0_ene1_op_wire;
			local_bb1_c0_ene1_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene1_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene1_valid_out_2_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene1_valid_out_3_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene1_valid_out_4_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene1_valid_out_5_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene1_valid_out_6_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_ene1_stall_in_0))
			begin
				local_bb1_c0_ene1_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene1_stall_in_1))
			begin
				local_bb1_c0_ene1_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene1_stall_in_2))
			begin
				local_bb1_c0_ene1_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene1_stall_in_3))
			begin
				local_bb1_c0_ene1_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene1_stall_in_4))
			begin
				local_bb1_c0_ene1_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene1_stall_in_5))
			begin
				local_bb1_c0_ene1_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene1_stall_in_6))
			begin
				local_bb1_c0_ene1_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_c0_ene2_inputs_ready;
 reg local_bb1_c0_ene2_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_ene2_stall_in_0;
 reg local_bb1_c0_ene2_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_ene2_stall_in_1;
 reg local_bb1_c0_ene2_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c0_ene2_stall_in_2;
 reg local_bb1_c0_ene2_valid_out_3_NO_SHIFT_REG;
wire local_bb1_c0_ene2_stall_in_3;
 reg local_bb1_c0_ene2_valid_out_4_NO_SHIFT_REG;
wire local_bb1_c0_ene2_stall_in_4;
 reg local_bb1_c0_ene2_valid_out_5_NO_SHIFT_REG;
wire local_bb1_c0_ene2_stall_in_5;
 reg local_bb1_c0_ene2_valid_out_6_NO_SHIFT_REG;
wire local_bb1_c0_ene2_stall_in_6;
wire local_bb1_c0_ene2_output_regs_ready;
 reg local_bb1_c0_ene2_NO_SHIFT_REG;
wire local_bb1_c0_ene2_op_wire;
wire local_bb1_c0_ene2_causedstall;

assign local_bb1_c0_ene2_inputs_ready = 1'b1;
assign local_bb1_c0_ene2_output_regs_ready = 1'b1;
assign local_bb1_c0_ene2_op_wire = local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG[16];
assign local_bb1_c0_enter_c0_eni3_stall_in_1 = 1'b0;
assign local_bb1_c0_ene2_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_ene2_NO_SHIFT_REG <= 'x;
		local_bb1_c0_ene2_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene2_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene2_valid_out_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene2_valid_out_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene2_valid_out_4_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene2_valid_out_5_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_ene2_valid_out_6_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_ene2_output_regs_ready)
		begin
			local_bb1_c0_ene2_NO_SHIFT_REG <= local_bb1_c0_ene2_op_wire;
			local_bb1_c0_ene2_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene2_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene2_valid_out_2_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene2_valid_out_3_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene2_valid_out_4_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene2_valid_out_5_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_ene2_valid_out_6_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_ene2_stall_in_0))
			begin
				local_bb1_c0_ene2_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene2_stall_in_1))
			begin
				local_bb1_c0_ene2_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene2_stall_in_2))
			begin
				local_bb1_c0_ene2_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene2_stall_in_3))
			begin
				local_bb1_c0_ene2_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene2_stall_in_4))
			begin
				local_bb1_c0_ene2_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene2_stall_in_5))
			begin
				local_bb1_c0_ene2_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_ene2_stall_in_6))
			begin
				local_bb1_c0_ene2_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene3_valid_out;
wire local_bb1_c0_ene3_stall_in;
wire local_bb1_c0_ene3_inputs_ready;
wire local_bb1_c0_ene3_stall_local;
wire [7:0] local_bb1_c0_ene3;

assign local_bb1_c0_ene3_inputs_ready = local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG;
assign local_bb1_c0_ene3 = local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG[31:24];
assign local_bb1_c0_ene3_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni3_stall_in_2 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_1_0_pop34__stall_local;
wire [7:0] local_bb1_rows_1_0_pop34_;
wire local_bb1_rows_1_0_pop34__fu_valid_out;
wire local_bb1_rows_1_0_pop34__fu_stall_out;

acl_pop local_bb1_rows_1_0_pop34__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_1_0_pop34__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_1_0_pop34__fu_valid_out),
	.stall_in(local_bb1_rows_1_0_pop34__stall_local),
	.data_out(local_bb1_rows_1_0_pop34_),
	.feedback_in(feedback_data_in_34),
	.feedback_valid_in(feedback_valid_in_34),
	.feedback_stall_out(feedback_stall_out_34)
);

defparam local_bb1_rows_1_0_pop34__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_1_0_pop34__feedback.STYLE = "REGULAR";

assign local_bb1_rows_1_0_pop34__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_0_0_pop35__stall_local;
wire [7:0] local_bb1_rows_0_0_pop35_;
wire local_bb1_rows_0_0_pop35__fu_valid_out;
wire local_bb1_rows_0_0_pop35__fu_stall_out;

acl_pop local_bb1_rows_0_0_pop35__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_0_0_pop35__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_0_0_pop35__fu_valid_out),
	.stall_in(local_bb1_rows_0_0_pop35__stall_local),
	.data_out(local_bb1_rows_0_0_pop35_),
	.feedback_in(feedback_data_in_35),
	.feedback_valid_in(feedback_valid_in_35),
	.feedback_stall_out(feedback_stall_out_35)
);

defparam local_bb1_rows_0_0_pop35__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_0_0_pop35__feedback.STYLE = "REGULAR";

assign local_bb1_rows_0_0_pop35__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_2_0_pop33__stall_local;
wire [7:0] local_bb1_rows_2_0_pop33_;
wire local_bb1_rows_2_0_pop33__fu_valid_out;
wire local_bb1_rows_2_0_pop33__fu_stall_out;

acl_pop local_bb1_rows_2_0_pop33__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_2_0_pop33__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_2_0_pop33__fu_valid_out),
	.stall_in(local_bb1_rows_2_0_pop33__stall_local),
	.data_out(local_bb1_rows_2_0_pop33_),
	.feedback_in(feedback_data_in_33),
	.feedback_valid_in(feedback_valid_in_33),
	.feedback_stall_out(feedback_stall_out_33)
);

defparam local_bb1_rows_2_0_pop33__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_2_0_pop33__feedback.STYLE = "REGULAR";

assign local_bb1_rows_2_0_pop33__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_3_0_pop32__stall_local;
wire [7:0] local_bb1_rows_3_0_pop32_;
wire local_bb1_rows_3_0_pop32__fu_valid_out;
wire local_bb1_rows_3_0_pop32__fu_stall_out;

acl_pop local_bb1_rows_3_0_pop32__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_3_0_pop32__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_3_0_pop32__fu_valid_out),
	.stall_in(local_bb1_rows_3_0_pop32__stall_local),
	.data_out(local_bb1_rows_3_0_pop32_),
	.feedback_in(feedback_data_in_32),
	.feedback_valid_in(feedback_valid_in_32),
	.feedback_stall_out(feedback_stall_out_32)
);

defparam local_bb1_rows_3_0_pop32__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_3_0_pop32__feedback.STYLE = "REGULAR";

assign local_bb1_rows_3_0_pop32__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_4_0_pop31__stall_local;
wire [7:0] local_bb1_rows_4_0_pop31_;
wire local_bb1_rows_4_0_pop31__fu_valid_out;
wire local_bb1_rows_4_0_pop31__fu_stall_out;

acl_pop local_bb1_rows_4_0_pop31__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_4_0_pop31__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_4_0_pop31__fu_valid_out),
	.stall_in(local_bb1_rows_4_0_pop31__stall_local),
	.data_out(local_bb1_rows_4_0_pop31_),
	.feedback_in(feedback_data_in_31),
	.feedback_valid_in(feedback_valid_in_31),
	.feedback_stall_out(feedback_stall_out_31)
);

defparam local_bb1_rows_4_0_pop31__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_4_0_pop31__feedback.STYLE = "REGULAR";

assign local_bb1_rows_4_0_pop31__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_5_0_pop30__valid_out;
wire local_bb1_rows_5_0_pop30__stall_in;
wire local_bb1_rows_5_0_pop30__inputs_ready;
wire local_bb1_rows_5_0_pop30__stall_local;
wire [7:0] local_bb1_rows_5_0_pop30_;
wire local_bb1_rows_5_0_pop30__fu_valid_out;
wire local_bb1_rows_5_0_pop30__fu_stall_out;

acl_pop local_bb1_rows_5_0_pop30__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_5_0_pop30__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_5_0_pop30__fu_valid_out),
	.stall_in(local_bb1_rows_5_0_pop30__stall_local),
	.data_out(local_bb1_rows_5_0_pop30_),
	.feedback_in(feedback_data_in_30),
	.feedback_valid_in(feedback_valid_in_30),
	.feedback_stall_out(feedback_stall_out_30)
);

defparam local_bb1_rows_5_0_pop30__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_5_0_pop30__feedback.STYLE = "REGULAR";

assign local_bb1_rows_5_0_pop30__inputs_ready = local_bb1_c0_ene1_valid_out_5_NO_SHIFT_REG;
assign local_bb1_rows_5_0_pop30__stall_local = 1'b0;
assign local_bb1_rows_5_0_pop30__valid_out = 1'b1;
assign local_bb1_c0_ene1_stall_in_5 = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_2_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_3_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_4_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_5_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_6_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_7_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_7_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_7_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_8_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_8_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_8_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_9_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_9_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_9_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_10_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_10_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_10_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_11_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_11_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_11_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_12_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_12_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_12_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene1_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1_c0_ene1_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1_c0_ene1_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1_c0_ene1_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1_c0_ene1_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1_c0_ene1_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_c0_ene1_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1_c0_ene1_0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1_c0_ene1_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb1_c0_ene1_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1_c0_ene1_0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1_c0_ene1_0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c0_ene1_stall_in_6 = 1'b0;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_0_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_2_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_3_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_4_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_5_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_6_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_7_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_7_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_8_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_8_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_9_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_9_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_10_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_10_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_11_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_11_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene1_0_valid_out_12_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_12_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene1_0_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_2_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_3_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_4_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_5_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_6_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_7_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_8_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_8_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_8_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_9_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_9_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_9_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_10_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_10_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_10_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_11_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_11_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_11_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_c0_ene2_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1_c0_ene2_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1_c0_ene2_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1_c0_ene2_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1_c0_ene2_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1_c0_ene2_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_c0_ene2_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1_c0_ene2_0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1_c0_ene2_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb1_c0_ene2_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1_c0_ene2_0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1_c0_ene2_0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c0_ene2_stall_in_6 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_0_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_0_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_1_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_2_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_3_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_4_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_5_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_6_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_7_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_8_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_8_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_9_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_9_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_10_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_10_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_c0_ene2_0_valid_out_11_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_11_NO_SHIFT_REG = rnode_164to165_bb1_c0_ene2_0_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1_c0_ene3_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_163to164_bb1_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_163to164_bb1_c0_ene3_1_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_163to164_bb1_c0_ene3_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_valid_out_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_stall_in_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1_c0_ene3_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1_c0_ene3_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1_c0_ene3_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1_c0_ene3_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1_c0_ene3_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1_c0_ene3),
	.data_out(rnode_163to164_bb1_c0_ene3_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.DATA_WIDTH = 8;
defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1_c0_ene3_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c0_ene3_stall_in = 1'b0;
assign rnode_163to164_bb1_c0_ene3_0_stall_in_0_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1_c0_ene3_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_c0_ene3_0_NO_SHIFT_REG = rnode_163to164_bb1_c0_ene3_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1_c0_ene3_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_c0_ene3_1_NO_SHIFT_REG = rnode_163to164_bb1_c0_ene3_0_reg_164_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_2_stall_local;
wire local_bb1_cmp16_2;

assign local_bb1_cmp16_2 = (local_bb1_rows_1_0_pop34_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_1_stall_local;
wire local_bb1_cmp16_1;

assign local_bb1_cmp16_1 = (local_bb1_rows_0_0_pop35_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_3_stall_local;
wire local_bb1_cmp16_3;

assign local_bb1_cmp16_3 = (local_bb1_rows_2_0_pop33_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_3_0_pop32__valid_out_0;
wire local_bb1_rows_3_0_pop32__stall_in_0;
 reg local_bb1_rows_3_0_pop32__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_4_valid_out;
wire local_bb1_cmp16_4_stall_in;
 reg local_bb1_cmp16_4_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_4_inputs_ready;
wire local_bb1_cmp16_4_stall_local;
wire local_bb1_cmp16_4;

assign local_bb1_cmp16_4_inputs_ready = local_bb1_c0_ene1_valid_out_3_NO_SHIFT_REG;
assign local_bb1_cmp16_4 = (local_bb1_rows_3_0_pop32_ == 8'h0);
assign local_bb1_rows_3_0_pop32__valid_out_0 = 1'b1;
assign local_bb1_cmp16_4_valid_out = 1'b1;
assign local_bb1_c0_ene1_stall_in_3 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_3_0_pop32__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_4_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_3_0_pop32__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_4_inputs_ready & (local_bb1_rows_3_0_pop32__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_3_0_pop32__stall_in_0)) & local_bb1_cmp16_4_stall_local);
		local_bb1_cmp16_4_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_4_inputs_ready & (local_bb1_cmp16_4_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_4_stall_in)) & local_bb1_cmp16_4_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_4_0_pop31__valid_out_0;
wire local_bb1_rows_4_0_pop31__stall_in_0;
 reg local_bb1_rows_4_0_pop31__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_5_valid_out;
wire local_bb1_cmp16_5_stall_in;
 reg local_bb1_cmp16_5_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_5_inputs_ready;
wire local_bb1_cmp16_5_stall_local;
wire local_bb1_cmp16_5;

assign local_bb1_cmp16_5_inputs_ready = local_bb1_c0_ene1_valid_out_4_NO_SHIFT_REG;
assign local_bb1_cmp16_5 = (local_bb1_rows_4_0_pop31_ == 8'h0);
assign local_bb1_rows_4_0_pop31__valid_out_0 = 1'b1;
assign local_bb1_cmp16_5_valid_out = 1'b1;
assign local_bb1_c0_ene1_stall_in_4 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_4_0_pop31__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_5_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_4_0_pop31__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_5_inputs_ready & (local_bb1_rows_4_0_pop31__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_4_0_pop31__stall_in_0)) & local_bb1_cmp16_5_stall_local);
		local_bb1_cmp16_5_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_5_inputs_ready & (local_bb1_cmp16_5_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_5_stall_in)) & local_bb1_cmp16_5_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1_rows_5_0_pop30__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_rows_5_0_pop30__0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_164to165_bb1_rows_5_0_pop30__0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_rows_5_0_pop30__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_rows_5_0_pop30__0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_164to165_bb1_rows_5_0_pop30__1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_rows_5_0_pop30__0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_rows_5_0_pop30__0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_rows_5_0_pop30__0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1_rows_5_0_pop30__0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1_rows_5_0_pop30__0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1_rows_5_0_pop30__0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_rows_5_0_pop30_),
	.data_out(rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_fifo.DATA_WIDTH = 8;
defparam rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_5_0_pop30__stall_in = 1'b0;
assign rnode_164to165_bb1_rows_5_0_pop30__0_stall_in_0_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_rows_5_0_pop30__0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_rows_5_0_pop30__0_NO_SHIFT_REG = rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_rows_5_0_pop30__0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_rows_5_0_pop30__1_NO_SHIFT_REG = rnode_164to165_bb1_rows_5_0_pop30__0_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_7_0_pop28__stall_local;
wire [7:0] local_bb1_rows_7_0_pop28_;
wire local_bb1_rows_7_0_pop28__fu_valid_out;
wire local_bb1_rows_7_0_pop28__fu_stall_out;

acl_pop local_bb1_rows_7_0_pop28__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_7_0_pop28__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_7_0_pop28__fu_valid_out),
	.stall_in(local_bb1_rows_7_0_pop28__stall_local),
	.data_out(local_bb1_rows_7_0_pop28_),
	.feedback_in(feedback_data_in_28),
	.feedback_valid_in(feedback_valid_in_28),
	.feedback_stall_out(feedback_stall_out_28)
);

defparam local_bb1_rows_7_0_pop28__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_7_0_pop28__feedback.STYLE = "REGULAR";

assign local_bb1_rows_7_0_pop28__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_8_0_pop27__stall_local;
wire [7:0] local_bb1_rows_8_0_pop27_;
wire local_bb1_rows_8_0_pop27__fu_valid_out;
wire local_bb1_rows_8_0_pop27__fu_stall_out;

acl_pop local_bb1_rows_8_0_pop27__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_8_0_pop27__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_8_0_pop27__fu_valid_out),
	.stall_in(local_bb1_rows_8_0_pop27__stall_local),
	.data_out(local_bb1_rows_8_0_pop27_),
	.feedback_in(feedback_data_in_27),
	.feedback_valid_in(feedback_valid_in_27),
	.feedback_stall_out(feedback_stall_out_27)
);

defparam local_bb1_rows_8_0_pop27__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_8_0_pop27__feedback.STYLE = "REGULAR";

assign local_bb1_rows_8_0_pop27__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_9_0_pop26__stall_local;
wire [7:0] local_bb1_rows_9_0_pop26_;
wire local_bb1_rows_9_0_pop26__fu_valid_out;
wire local_bb1_rows_9_0_pop26__fu_stall_out;

acl_pop local_bb1_rows_9_0_pop26__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_9_0_pop26__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_9_0_pop26__fu_valid_out),
	.stall_in(local_bb1_rows_9_0_pop26__stall_local),
	.data_out(local_bb1_rows_9_0_pop26_),
	.feedback_in(feedback_data_in_26),
	.feedback_valid_in(feedback_valid_in_26),
	.feedback_stall_out(feedback_stall_out_26)
);

defparam local_bb1_rows_9_0_pop26__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_9_0_pop26__feedback.STYLE = "REGULAR";

assign local_bb1_rows_9_0_pop26__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_15_0_pop20__stall_local;
wire [7:0] local_bb1_rows_15_0_pop20_;
wire local_bb1_rows_15_0_pop20__fu_valid_out;
wire local_bb1_rows_15_0_pop20__fu_stall_out;

acl_pop local_bb1_rows_15_0_pop20__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_15_0_pop20__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_15_0_pop20__fu_valid_out),
	.stall_in(local_bb1_rows_15_0_pop20__stall_local),
	.data_out(local_bb1_rows_15_0_pop20_),
	.feedback_in(feedback_data_in_20),
	.feedback_valid_in(feedback_valid_in_20),
	.feedback_stall_out(feedback_stall_out_20)
);

defparam local_bb1_rows_15_0_pop20__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_15_0_pop20__feedback.STYLE = "REGULAR";

assign local_bb1_rows_15_0_pop20__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_720_0_pop19__valid_out;
wire local_bb1_rows_720_0_pop19__stall_in;
wire local_bb1_rows_720_0_pop19__inputs_ready;
wire local_bb1_rows_720_0_pop19__stall_local;
wire [7:0] local_bb1_rows_720_0_pop19_;
wire local_bb1_rows_720_0_pop19__fu_valid_out;
wire local_bb1_rows_720_0_pop19__fu_stall_out;

acl_pop local_bb1_rows_720_0_pop19__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_720_0_pop19__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_720_0_pop19__fu_valid_out),
	.stall_in(local_bb1_rows_720_0_pop19__stall_local),
	.data_out(local_bb1_rows_720_0_pop19_),
	.feedback_in(feedback_data_in_19),
	.feedback_valid_in(feedback_valid_in_19),
	.feedback_stall_out(feedback_stall_out_19)
);

defparam local_bb1_rows_720_0_pop19__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_720_0_pop19__feedback.STYLE = "REGULAR";

assign local_bb1_rows_720_0_pop19__inputs_ready = rnode_164to165_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
assign local_bb1_rows_720_0_pop19__stall_local = 1'b0;
assign local_bb1_rows_720_0_pop19__valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_14_0_pop21__stall_local;
wire [7:0] local_bb1_rows_14_0_pop21_;
wire local_bb1_rows_14_0_pop21__fu_valid_out;
wire local_bb1_rows_14_0_pop21__fu_stall_out;

acl_pop local_bb1_rows_14_0_pop21__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_14_0_pop21__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_14_0_pop21__fu_valid_out),
	.stall_in(local_bb1_rows_14_0_pop21__stall_local),
	.data_out(local_bb1_rows_14_0_pop21_),
	.feedback_in(feedback_data_in_21),
	.feedback_valid_in(feedback_valid_in_21),
	.feedback_stall_out(feedback_stall_out_21)
);

defparam local_bb1_rows_14_0_pop21__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_14_0_pop21__feedback.STYLE = "REGULAR";

assign local_bb1_rows_14_0_pop21__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_13_0_pop22__stall_local;
wire [7:0] local_bb1_rows_13_0_pop22_;
wire local_bb1_rows_13_0_pop22__fu_valid_out;
wire local_bb1_rows_13_0_pop22__fu_stall_out;

acl_pop local_bb1_rows_13_0_pop22__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_6_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_13_0_pop22__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_13_0_pop22__fu_valid_out),
	.stall_in(local_bb1_rows_13_0_pop22__stall_local),
	.data_out(local_bb1_rows_13_0_pop22_),
	.feedback_in(feedback_data_in_22),
	.feedback_valid_in(feedback_valid_in_22),
	.feedback_stall_out(feedback_stall_out_22)
);

defparam local_bb1_rows_13_0_pop22__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_13_0_pop22__feedback.STYLE = "REGULAR";

assign local_bb1_rows_13_0_pop22__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_12_0_pop23__stall_local;
wire [7:0] local_bb1_rows_12_0_pop23_;
wire local_bb1_rows_12_0_pop23__fu_valid_out;
wire local_bb1_rows_12_0_pop23__fu_stall_out;

acl_pop local_bb1_rows_12_0_pop23__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_7_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_12_0_pop23__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_12_0_pop23__fu_valid_out),
	.stall_in(local_bb1_rows_12_0_pop23__stall_local),
	.data_out(local_bb1_rows_12_0_pop23_),
	.feedback_in(feedback_data_in_23),
	.feedback_valid_in(feedback_valid_in_23),
	.feedback_stall_out(feedback_stall_out_23)
);

defparam local_bb1_rows_12_0_pop23__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_12_0_pop23__feedback.STYLE = "REGULAR";

assign local_bb1_rows_12_0_pop23__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_11_0_pop24__stall_local;
wire [7:0] local_bb1_rows_11_0_pop24_;
wire local_bb1_rows_11_0_pop24__fu_valid_out;
wire local_bb1_rows_11_0_pop24__fu_stall_out;

acl_pop local_bb1_rows_11_0_pop24__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_8_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_11_0_pop24__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_11_0_pop24__fu_valid_out),
	.stall_in(local_bb1_rows_11_0_pop24__stall_local),
	.data_out(local_bb1_rows_11_0_pop24_),
	.feedback_in(feedback_data_in_24),
	.feedback_valid_in(feedback_valid_in_24),
	.feedback_stall_out(feedback_stall_out_24)
);

defparam local_bb1_rows_11_0_pop24__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_11_0_pop24__feedback.STYLE = "REGULAR";

assign local_bb1_rows_11_0_pop24__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_coalesce_counter_pop54_acl_pop_i11_703_stall_local;
wire [10:0] local_bb1_coalesce_counter_pop54_acl_pop_i11_703;
wire local_bb1_coalesce_counter_pop54_acl_pop_i11_703_fu_valid_out;
wire local_bb1_coalesce_counter_pop54_acl_pop_i11_703_fu_stall_out;

acl_pop local_bb1_coalesce_counter_pop54_acl_pop_i11_703_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_9_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(11'h2BF),
	.stall_out(local_bb1_coalesce_counter_pop54_acl_pop_i11_703_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_coalesce_counter_pop54_acl_pop_i11_703_fu_valid_out),
	.stall_in(local_bb1_coalesce_counter_pop54_acl_pop_i11_703_stall_local),
	.data_out(local_bb1_coalesce_counter_pop54_acl_pop_i11_703),
	.feedback_in(feedback_data_in_54),
	.feedback_valid_in(feedback_valid_in_54),
	.feedback_stall_out(feedback_stall_out_54)
);

defparam local_bb1_coalesce_counter_pop54_acl_pop_i11_703_feedback.DATA_WIDTH = 11;
defparam local_bb1_coalesce_counter_pop54_acl_pop_i11_703_feedback.STYLE = "REGULAR";

assign local_bb1_coalesce_counter_pop54_acl_pop_i11_703_stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_10_0_pop25__stall_local;
wire [7:0] local_bb1_rows_10_0_pop25_;
wire local_bb1_rows_10_0_pop25__fu_valid_out;
wire local_bb1_rows_10_0_pop25__fu_stall_out;

acl_pop local_bb1_rows_10_0_pop25__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_10_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_10_0_pop25__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_10_0_pop25__fu_valid_out),
	.stall_in(local_bb1_rows_10_0_pop25__stall_local),
	.data_out(local_bb1_rows_10_0_pop25_),
	.feedback_in(feedback_data_in_25),
	.feedback_valid_in(feedback_valid_in_25),
	.feedback_stall_out(feedback_stall_out_25)
);

defparam local_bb1_rows_10_0_pop25__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_10_0_pop25__feedback.STYLE = "REGULAR";

assign local_bb1_rows_10_0_pop25__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_6_0_pop29__stall_local;
wire [7:0] local_bb1_rows_6_0_pop29_;
wire local_bb1_rows_6_0_pop29__fu_valid_out;
wire local_bb1_rows_6_0_pop29__fu_stall_out;

acl_pop local_bb1_rows_6_0_pop29__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene1_11_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_6_0_pop29__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_6_0_pop29__fu_valid_out),
	.stall_in(local_bb1_rows_6_0_pop29__stall_local),
	.data_out(local_bb1_rows_6_0_pop29_),
	.feedback_in(feedback_data_in_29),
	.feedback_valid_in(feedback_valid_in_29),
	.feedback_stall_out(feedback_stall_out_29)
);

defparam local_bb1_rows_6_0_pop29__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_6_0_pop29__feedback.STYLE = "REGULAR";

assign local_bb1_rows_6_0_pop29__stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_3_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_4_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_5_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_6_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene1_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_c0_ene1_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_c0_ene1_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_c0_ene1_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_c0_ene1_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_c0_ene1_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_164to165_bb1_c0_ene1_12_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_c0_ene1_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_c0_ene1_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_c0_ene1_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_c0_ene1_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_c0_ene1_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_12_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_2_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_3_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_4_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_5_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_6_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene1_0_reg_166_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_3_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_4_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_5_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_6_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_7_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_c0_ene2_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_c0_ene2_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_c0_ene2_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_c0_ene2_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_c0_ene2_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_c0_ene2_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_164to165_bb1_c0_ene2_11_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_c0_ene2_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_c0_ene2_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_c0_ene2_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_c0_ene2_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_c0_ene2_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_11_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_0_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_1_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_2_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_3_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_4_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_5_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_6_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_7_NO_SHIFT_REG = rnode_165to166_bb1_c0_ene2_0_reg_166_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_0_0_push35_c0_ene3_inputs_ready;
 reg local_bb1_rows_0_0_push35_c0_ene3_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_0_0_push35_c0_ene3_stall_in;
wire local_bb1_rows_0_0_push35_c0_ene3_output_regs_ready;
wire [7:0] local_bb1_rows_0_0_push35_c0_ene3_result;
wire local_bb1_rows_0_0_push35_c0_ene3_fu_valid_out;
wire local_bb1_rows_0_0_push35_c0_ene3_fu_stall_out;
 reg [7:0] local_bb1_rows_0_0_push35_c0_ene3_NO_SHIFT_REG;
wire local_bb1_rows_0_0_push35_c0_ene3_causedstall;

acl_push local_bb1_rows_0_0_push35_c0_ene3_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_163to164_bb1_c0_ene3_0_NO_SHIFT_REG),
	.stall_out(local_bb1_rows_0_0_push35_c0_ene3_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_0_0_push35_c0_ene3_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_0_0_push35_c0_ene3_result),
	.feedback_out(feedback_data_out_35),
	.feedback_valid_out(feedback_valid_out_35),
	.feedback_stall_in(feedback_stall_in_35)
);

defparam local_bb1_rows_0_0_push35_c0_ene3_feedback.STALLFREE = 1;
defparam local_bb1_rows_0_0_push35_c0_ene3_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_0_0_push35_c0_ene3_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_0_0_push35_c0_ene3_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_0_0_push35_c0_ene3_feedback.STYLE = "REGULAR";

assign local_bb1_rows_0_0_push35_c0_ene3_inputs_ready = 1'b1;
assign local_bb1_rows_0_0_push35_c0_ene3_output_regs_ready = 1'b1;
assign local_bb1_c0_ene2_stall_in_5 = 1'b0;
assign rnode_163to164_bb1_c0_ene3_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_0_0_push35_c0_ene3_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_0_0_push35_c0_ene3_NO_SHIFT_REG <= 'x;
		local_bb1_rows_0_0_push35_c0_ene3_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_0_0_push35_c0_ene3_output_regs_ready)
		begin
			local_bb1_rows_0_0_push35_c0_ene3_NO_SHIFT_REG <= local_bb1_rows_0_0_push35_c0_ene3_result;
			local_bb1_rows_0_0_push35_c0_ene3_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_0_0_push35_c0_ene3_stall_in))
			begin
				local_bb1_rows_0_0_push35_c0_ene3_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_stall_local;
wire local_bb1_cmp16;

assign local_bb1_cmp16 = (rnode_163to164_bb1_c0_ene3_1_NO_SHIFT_REG == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_2_stall_local;
wire local_bb1_not_cmp16_2;

assign local_bb1_not_cmp16_2 = (local_bb1_cmp16_2 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_1_stall_local;
wire local_bb1_not_cmp16_1;

assign local_bb1_not_cmp16_1 = (local_bb1_cmp16_1 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_3_stall_local;
wire local_bb1_not_cmp16_3;

assign local_bb1_not_cmp16_3 = (local_bb1_cmp16_3 ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1_rows_4_0_push31_rows_3_0_pop32_inputs_ready;
 reg local_bb1_rows_4_0_push31_rows_3_0_pop32_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_4_0_push31_rows_3_0_pop32_stall_in;
wire local_bb1_rows_4_0_push31_rows_3_0_pop32_output_regs_ready;
wire [7:0] local_bb1_rows_4_0_push31_rows_3_0_pop32_result;
wire local_bb1_rows_4_0_push31_rows_3_0_pop32_fu_valid_out;
wire local_bb1_rows_4_0_push31_rows_3_0_pop32_fu_stall_out;
 reg [7:0] local_bb1_rows_4_0_push31_rows_3_0_pop32_NO_SHIFT_REG;
wire local_bb1_rows_4_0_push31_rows_3_0_pop32_causedstall;

acl_push local_bb1_rows_4_0_push31_rows_3_0_pop32_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_3_0_pop32_),
	.stall_out(local_bb1_rows_4_0_push31_rows_3_0_pop32_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_4_0_push31_rows_3_0_pop32_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_4_0_push31_rows_3_0_pop32_result),
	.feedback_out(feedback_data_out_31),
	.feedback_valid_out(feedback_valid_out_31),
	.feedback_stall_in(feedback_stall_in_31)
);

defparam local_bb1_rows_4_0_push31_rows_3_0_pop32_feedback.STALLFREE = 1;
defparam local_bb1_rows_4_0_push31_rows_3_0_pop32_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_4_0_push31_rows_3_0_pop32_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_4_0_push31_rows_3_0_pop32_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_4_0_push31_rows_3_0_pop32_feedback.STYLE = "REGULAR";

assign local_bb1_rows_4_0_push31_rows_3_0_pop32_inputs_ready = 1'b1;
assign local_bb1_rows_4_0_push31_rows_3_0_pop32_output_regs_ready = 1'b1;
assign local_bb1_rows_3_0_pop32__stall_in_0 = 1'b0;
assign local_bb1_c0_ene2_stall_in_3 = 1'b0;
assign local_bb1_rows_4_0_push31_rows_3_0_pop32_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_4_0_push31_rows_3_0_pop32_NO_SHIFT_REG <= 'x;
		local_bb1_rows_4_0_push31_rows_3_0_pop32_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_4_0_push31_rows_3_0_pop32_output_regs_ready)
		begin
			local_bb1_rows_4_0_push31_rows_3_0_pop32_NO_SHIFT_REG <= local_bb1_rows_4_0_push31_rows_3_0_pop32_result;
			local_bb1_rows_4_0_push31_rows_3_0_pop32_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_4_0_push31_rows_3_0_pop32_stall_in))
			begin
				local_bb1_rows_4_0_push31_rows_3_0_pop32_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1_cmp16_4_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_4_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1_cmp16_4_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1_cmp16_4_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1_cmp16_4_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1_cmp16_4_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1_cmp16_4_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_4),
	.data_out(rnode_164to165_bb1_cmp16_4_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1_cmp16_4_0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1_cmp16_4_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb1_cmp16_4_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1_cmp16_4_0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1_cmp16_4_0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_4_stall_in = 1'b0;
assign rnode_164to165_bb1_cmp16_4_0_stall_in_0_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_cmp16_4_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_cmp16_4_0_NO_SHIFT_REG = rnode_164to165_bb1_cmp16_4_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_cmp16_4_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_cmp16_4_1_NO_SHIFT_REG = rnode_164to165_bb1_cmp16_4_0_reg_165_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_5_0_push30_rows_4_0_pop31_inputs_ready;
 reg local_bb1_rows_5_0_push30_rows_4_0_pop31_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_5_0_push30_rows_4_0_pop31_stall_in;
wire local_bb1_rows_5_0_push30_rows_4_0_pop31_output_regs_ready;
wire [7:0] local_bb1_rows_5_0_push30_rows_4_0_pop31_result;
wire local_bb1_rows_5_0_push30_rows_4_0_pop31_fu_valid_out;
wire local_bb1_rows_5_0_push30_rows_4_0_pop31_fu_stall_out;
 reg [7:0] local_bb1_rows_5_0_push30_rows_4_0_pop31_NO_SHIFT_REG;
wire local_bb1_rows_5_0_push30_rows_4_0_pop31_causedstall;

acl_push local_bb1_rows_5_0_push30_rows_4_0_pop31_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_4_0_pop31_),
	.stall_out(local_bb1_rows_5_0_push30_rows_4_0_pop31_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_5_0_push30_rows_4_0_pop31_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_5_0_push30_rows_4_0_pop31_result),
	.feedback_out(feedback_data_out_30),
	.feedback_valid_out(feedback_valid_out_30),
	.feedback_stall_in(feedback_stall_in_30)
);

defparam local_bb1_rows_5_0_push30_rows_4_0_pop31_feedback.STALLFREE = 1;
defparam local_bb1_rows_5_0_push30_rows_4_0_pop31_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_5_0_push30_rows_4_0_pop31_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_5_0_push30_rows_4_0_pop31_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_5_0_push30_rows_4_0_pop31_feedback.STYLE = "REGULAR";

assign local_bb1_rows_5_0_push30_rows_4_0_pop31_inputs_ready = 1'b1;
assign local_bb1_rows_5_0_push30_rows_4_0_pop31_output_regs_ready = 1'b1;
assign local_bb1_rows_4_0_pop31__stall_in_0 = 1'b0;
assign local_bb1_c0_ene2_stall_in_4 = 1'b0;
assign local_bb1_rows_5_0_push30_rows_4_0_pop31_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_5_0_push30_rows_4_0_pop31_NO_SHIFT_REG <= 'x;
		local_bb1_rows_5_0_push30_rows_4_0_pop31_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_5_0_push30_rows_4_0_pop31_output_regs_ready)
		begin
			local_bb1_rows_5_0_push30_rows_4_0_pop31_NO_SHIFT_REG <= local_bb1_rows_5_0_push30_rows_4_0_pop31_result;
			local_bb1_rows_5_0_push30_rows_4_0_pop31_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_5_0_push30_rows_4_0_pop31_stall_in))
			begin
				local_bb1_rows_5_0_push30_rows_4_0_pop31_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1_cmp16_5_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_cmp16_5_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1_cmp16_5_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1_cmp16_5_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1_cmp16_5_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1_cmp16_5_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1_cmp16_5_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_5),
	.data_out(rnode_164to165_bb1_cmp16_5_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1_cmp16_5_0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1_cmp16_5_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb1_cmp16_5_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1_cmp16_5_0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1_cmp16_5_0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_5_stall_in = 1'b0;
assign rnode_164to165_bb1_cmp16_5_0_stall_in_0_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_cmp16_5_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_cmp16_5_0_NO_SHIFT_REG = rnode_164to165_bb1_cmp16_5_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_cmp16_5_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_cmp16_5_1_NO_SHIFT_REG = rnode_164to165_bb1_cmp16_5_0_reg_165_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_6_0_push29_rows_5_0_pop30_inputs_ready;
 reg local_bb1_rows_6_0_push29_rows_5_0_pop30_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_6_0_push29_rows_5_0_pop30_stall_in;
wire local_bb1_rows_6_0_push29_rows_5_0_pop30_output_regs_ready;
wire [7:0] local_bb1_rows_6_0_push29_rows_5_0_pop30_result;
wire local_bb1_rows_6_0_push29_rows_5_0_pop30_fu_valid_out;
wire local_bb1_rows_6_0_push29_rows_5_0_pop30_fu_stall_out;
 reg [7:0] local_bb1_rows_6_0_push29_rows_5_0_pop30_NO_SHIFT_REG;
wire local_bb1_rows_6_0_push29_rows_5_0_pop30_causedstall;

acl_push local_bb1_rows_6_0_push29_rows_5_0_pop30_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_8_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_164to165_bb1_rows_5_0_pop30__0_NO_SHIFT_REG),
	.stall_out(local_bb1_rows_6_0_push29_rows_5_0_pop30_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_6_0_push29_rows_5_0_pop30_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_6_0_push29_rows_5_0_pop30_result),
	.feedback_out(feedback_data_out_29),
	.feedback_valid_out(feedback_valid_out_29),
	.feedback_stall_in(feedback_stall_in_29)
);

defparam local_bb1_rows_6_0_push29_rows_5_0_pop30_feedback.STALLFREE = 1;
defparam local_bb1_rows_6_0_push29_rows_5_0_pop30_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_6_0_push29_rows_5_0_pop30_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_6_0_push29_rows_5_0_pop30_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_6_0_push29_rows_5_0_pop30_feedback.STYLE = "REGULAR";

assign local_bb1_rows_6_0_push29_rows_5_0_pop30_inputs_ready = 1'b1;
assign local_bb1_rows_6_0_push29_rows_5_0_pop30_output_regs_ready = 1'b1;
assign rnode_164to165_bb1_rows_5_0_pop30__0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_8_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_6_0_push29_rows_5_0_pop30_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_6_0_push29_rows_5_0_pop30_NO_SHIFT_REG <= 'x;
		local_bb1_rows_6_0_push29_rows_5_0_pop30_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_6_0_push29_rows_5_0_pop30_output_regs_ready)
		begin
			local_bb1_rows_6_0_push29_rows_5_0_pop30_NO_SHIFT_REG <= local_bb1_rows_6_0_push29_rows_5_0_pop30_result;
			local_bb1_rows_6_0_push29_rows_5_0_pop30_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_6_0_push29_rows_5_0_pop30_stall_in))
			begin
				local_bb1_rows_6_0_push29_rows_5_0_pop30_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_6_stall_local;
wire local_bb1_cmp16_6;

assign local_bb1_cmp16_6 = (rnode_164to165_bb1_rows_5_0_pop30__1_NO_SHIFT_REG == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_8_stall_local;
wire local_bb1_cmp16_8;

assign local_bb1_cmp16_8 = (local_bb1_rows_7_0_pop28_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_9_stall_local;
wire local_bb1_cmp16_9;

assign local_bb1_cmp16_9 = (local_bb1_rows_8_0_pop27_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_10_stall_local;
wire local_bb1_cmp16_10;

assign local_bb1_cmp16_10 = (local_bb1_rows_9_0_pop26_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_15_0_pop20__valid_out_0;
wire local_bb1_rows_15_0_pop20__stall_in_0;
 reg local_bb1_rows_15_0_pop20__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_16_valid_out;
wire local_bb1_cmp16_16_stall_in;
 reg local_bb1_cmp16_16_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_16_inputs_ready;
wire local_bb1_cmp16_16_stall_local;
wire local_bb1_cmp16_16;

assign local_bb1_cmp16_16_inputs_ready = rnode_164to165_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1_cmp16_16 = (local_bb1_rows_15_0_pop20_ == 8'h0);
assign local_bb1_rows_15_0_pop20__valid_out_0 = 1'b1;
assign local_bb1_cmp16_16_valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_15_0_pop20__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_16_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_15_0_pop20__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_16_inputs_ready & (local_bb1_rows_15_0_pop20__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_15_0_pop20__stall_in_0)) & local_bb1_cmp16_16_stall_local);
		local_bb1_cmp16_16_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_16_inputs_ready & (local_bb1_cmp16_16_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_16_stall_in)) & local_bb1_cmp16_16_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_720_0_pop19__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_720_0_pop19__0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_720_0_pop19__0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_720_0_pop19__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_720_0_pop19__0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_720_0_pop19__1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_720_0_pop19__0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_720_0_pop19__0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_720_0_pop19__0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_720_0_pop19__0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_720_0_pop19__0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_720_0_pop19__0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_720_0_pop19_),
	.data_out(rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_720_0_pop19__stall_in = 1'b0;
assign rnode_165to166_bb1_rows_720_0_pop19__0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_720_0_pop19__0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_720_0_pop19__0_NO_SHIFT_REG = rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_720_0_pop19__0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_720_0_pop19__1_NO_SHIFT_REG = rnode_165to166_bb1_rows_720_0_pop19__0_reg_166_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_14_0_pop21__valid_out_0;
wire local_bb1_rows_14_0_pop21__stall_in_0;
 reg local_bb1_rows_14_0_pop21__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_15_valid_out;
wire local_bb1_cmp16_15_stall_in;
 reg local_bb1_cmp16_15_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_15_inputs_ready;
wire local_bb1_cmp16_15_stall_local;
wire local_bb1_cmp16_15;

assign local_bb1_cmp16_15_inputs_ready = rnode_164to165_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
assign local_bb1_cmp16_15 = (local_bb1_rows_14_0_pop21_ == 8'h0);
assign local_bb1_rows_14_0_pop21__valid_out_0 = 1'b1;
assign local_bb1_cmp16_15_valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_14_0_pop21__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_15_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_14_0_pop21__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_15_inputs_ready & (local_bb1_rows_14_0_pop21__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_14_0_pop21__stall_in_0)) & local_bb1_cmp16_15_stall_local);
		local_bb1_cmp16_15_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_15_inputs_ready & (local_bb1_cmp16_15_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_15_stall_in)) & local_bb1_cmp16_15_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_13_0_pop22__valid_out_0;
wire local_bb1_rows_13_0_pop22__stall_in_0;
 reg local_bb1_rows_13_0_pop22__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_14_valid_out;
wire local_bb1_cmp16_14_stall_in;
 reg local_bb1_cmp16_14_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_14_inputs_ready;
wire local_bb1_cmp16_14_stall_local;
wire local_bb1_cmp16_14;

assign local_bb1_cmp16_14_inputs_ready = rnode_164to165_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG;
assign local_bb1_cmp16_14 = (local_bb1_rows_13_0_pop22_ == 8'h0);
assign local_bb1_rows_13_0_pop22__valid_out_0 = 1'b1;
assign local_bb1_cmp16_14_valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_13_0_pop22__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_14_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_13_0_pop22__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_14_inputs_ready & (local_bb1_rows_13_0_pop22__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_13_0_pop22__stall_in_0)) & local_bb1_cmp16_14_stall_local);
		local_bb1_cmp16_14_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_14_inputs_ready & (local_bb1_cmp16_14_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_14_stall_in)) & local_bb1_cmp16_14_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_12_0_pop23__valid_out_0;
wire local_bb1_rows_12_0_pop23__stall_in_0;
 reg local_bb1_rows_12_0_pop23__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_13_valid_out;
wire local_bb1_cmp16_13_stall_in;
 reg local_bb1_cmp16_13_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_13_inputs_ready;
wire local_bb1_cmp16_13_stall_local;
wire local_bb1_cmp16_13;

assign local_bb1_cmp16_13_inputs_ready = rnode_164to165_bb1_c0_ene1_0_valid_out_7_NO_SHIFT_REG;
assign local_bb1_cmp16_13 = (local_bb1_rows_12_0_pop23_ == 8'h0);
assign local_bb1_rows_12_0_pop23__valid_out_0 = 1'b1;
assign local_bb1_cmp16_13_valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_7_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_12_0_pop23__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_13_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_12_0_pop23__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_13_inputs_ready & (local_bb1_rows_12_0_pop23__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_12_0_pop23__stall_in_0)) & local_bb1_cmp16_13_stall_local);
		local_bb1_cmp16_13_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_13_inputs_ready & (local_bb1_cmp16_13_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_13_stall_in)) & local_bb1_cmp16_13_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_11_0_pop24__valid_out_1;
wire local_bb1_rows_11_0_pop24__stall_in_1;
 reg local_bb1_rows_11_0_pop24__consumed_1_NO_SHIFT_REG;
wire local_bb1_cmp16_12_valid_out;
wire local_bb1_cmp16_12_stall_in;
 reg local_bb1_cmp16_12_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_12_inputs_ready;
wire local_bb1_cmp16_12_stall_local;
wire local_bb1_cmp16_12;

assign local_bb1_cmp16_12_inputs_ready = rnode_164to165_bb1_c0_ene1_0_valid_out_8_NO_SHIFT_REG;
assign local_bb1_cmp16_12 = (local_bb1_rows_11_0_pop24_ == 8'h0);
assign local_bb1_rows_11_0_pop24__valid_out_1 = 1'b1;
assign local_bb1_cmp16_12_valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_8_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_11_0_pop24__consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_12_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_11_0_pop24__consumed_1_NO_SHIFT_REG <= (local_bb1_cmp16_12_inputs_ready & (local_bb1_rows_11_0_pop24__consumed_1_NO_SHIFT_REG | ~(local_bb1_rows_11_0_pop24__stall_in_1)) & local_bb1_cmp16_12_stall_local);
		local_bb1_cmp16_12_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_12_inputs_ready & (local_bb1_cmp16_12_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_12_stall_in)) & local_bb1_cmp16_12_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_not_select6_stall_local;
wire local_bb1_not_select6;

assign local_bb1_not_select6 = ($signed(local_bb1_coalesce_counter_pop54_acl_pop_i11_703) > $signed(11'h7FF));

// This section implements an unregistered operation.
// 
wire local_bb1_coalesce_counter_lobit_stall_local;
wire [10:0] local_bb1_coalesce_counter_lobit;

assign local_bb1_coalesce_counter_lobit = (local_bb1_coalesce_counter_pop54_acl_pop_i11_703 >> 11'hA);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_11_stall_local;
wire local_bb1_cmp16_11;

assign local_bb1_cmp16_11 = (local_bb1_rows_10_0_pop25_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_7_stall_local;
wire local_bb1_cmp16_7;

assign local_bb1_cmp16_7 = (local_bb1_rows_6_0_pop29_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_726_0_pop13__valid_out;
wire local_bb1_rows_726_0_pop13__stall_in;
wire local_bb1_rows_726_0_pop13__inputs_ready;
wire local_bb1_rows_726_0_pop13__stall_local;
wire [7:0] local_bb1_rows_726_0_pop13_;
wire local_bb1_rows_726_0_pop13__fu_valid_out;
wire local_bb1_rows_726_0_pop13__fu_stall_out;

acl_pop local_bb1_rows_726_0_pop13__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_726_0_pop13__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_726_0_pop13__fu_valid_out),
	.stall_in(local_bb1_rows_726_0_pop13__stall_local),
	.data_out(local_bb1_rows_726_0_pop13_),
	.feedback_in(feedback_data_in_13),
	.feedback_valid_in(feedback_valid_in_13),
	.feedback_stall_out(feedback_stall_out_13)
);

defparam local_bb1_rows_726_0_pop13__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_726_0_pop13__feedback.STYLE = "REGULAR";

assign local_bb1_rows_726_0_pop13__inputs_ready = rnode_165to166_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_rows_726_0_pop13__stall_local = 1'b0;
assign local_bb1_rows_726_0_pop13__valid_out = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_725_0_pop14__stall_local;
wire [7:0] local_bb1_rows_725_0_pop14_;
wire local_bb1_rows_725_0_pop14__fu_valid_out;
wire local_bb1_rows_725_0_pop14__fu_stall_out;

acl_pop local_bb1_rows_725_0_pop14__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_725_0_pop14__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_725_0_pop14__fu_valid_out),
	.stall_in(local_bb1_rows_725_0_pop14__stall_local),
	.data_out(local_bb1_rows_725_0_pop14_),
	.feedback_in(feedback_data_in_14),
	.feedback_valid_in(feedback_valid_in_14),
	.feedback_stall_out(feedback_stall_out_14)
);

defparam local_bb1_rows_725_0_pop14__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_725_0_pop14__feedback.STYLE = "REGULAR";

assign local_bb1_rows_725_0_pop14__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_724_0_pop15__stall_local;
wire [7:0] local_bb1_rows_724_0_pop15_;
wire local_bb1_rows_724_0_pop15__fu_valid_out;
wire local_bb1_rows_724_0_pop15__fu_stall_out;

acl_pop local_bb1_rows_724_0_pop15__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene1_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_724_0_pop15__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_724_0_pop15__fu_valid_out),
	.stall_in(local_bb1_rows_724_0_pop15__stall_local),
	.data_out(local_bb1_rows_724_0_pop15_),
	.feedback_in(feedback_data_in_15),
	.feedback_valid_in(feedback_valid_in_15),
	.feedback_stall_out(feedback_stall_out_15)
);

defparam local_bb1_rows_724_0_pop15__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_724_0_pop15__feedback.STYLE = "REGULAR";

assign local_bb1_rows_724_0_pop15__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_723_0_pop16__stall_local;
wire [7:0] local_bb1_rows_723_0_pop16_;
wire local_bb1_rows_723_0_pop16__fu_valid_out;
wire local_bb1_rows_723_0_pop16__fu_stall_out;

acl_pop local_bb1_rows_723_0_pop16__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene1_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_723_0_pop16__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_723_0_pop16__fu_valid_out),
	.stall_in(local_bb1_rows_723_0_pop16__stall_local),
	.data_out(local_bb1_rows_723_0_pop16_),
	.feedback_in(feedback_data_in_16),
	.feedback_valid_in(feedback_valid_in_16),
	.feedback_stall_out(feedback_stall_out_16)
);

defparam local_bb1_rows_723_0_pop16__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_723_0_pop16__feedback.STYLE = "REGULAR";

assign local_bb1_rows_723_0_pop16__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_722_0_pop17__stall_local;
wire [7:0] local_bb1_rows_722_0_pop17_;
wire local_bb1_rows_722_0_pop17__fu_valid_out;
wire local_bb1_rows_722_0_pop17__fu_stall_out;

acl_pop local_bb1_rows_722_0_pop17__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene1_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_722_0_pop17__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_722_0_pop17__fu_valid_out),
	.stall_in(local_bb1_rows_722_0_pop17__stall_local),
	.data_out(local_bb1_rows_722_0_pop17_),
	.feedback_in(feedback_data_in_17),
	.feedback_valid_in(feedback_valid_in_17),
	.feedback_stall_out(feedback_stall_out_17)
);

defparam local_bb1_rows_722_0_pop17__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_722_0_pop17__feedback.STYLE = "REGULAR";

assign local_bb1_rows_722_0_pop17__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_721_0_pop18__stall_local;
wire [7:0] local_bb1_rows_721_0_pop18_;
wire local_bb1_rows_721_0_pop18__fu_valid_out;
wire local_bb1_rows_721_0_pop18__fu_stall_out;

acl_pop local_bb1_rows_721_0_pop18__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene1_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_721_0_pop18__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_721_0_pop18__fu_valid_out),
	.stall_in(local_bb1_rows_721_0_pop18__stall_local),
	.data_out(local_bb1_rows_721_0_pop18_),
	.feedback_in(feedback_data_in_18),
	.feedback_valid_in(feedback_valid_in_18),
	.feedback_stall_out(feedback_stall_out_18)
);

defparam local_bb1_rows_721_0_pop18__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_721_0_pop18__feedback.STYLE = "REGULAR";

assign local_bb1_rows_721_0_pop18__stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_2_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_3_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_4_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_5_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_6_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene1_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_c0_ene1_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_c0_ene1_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_c0_ene1_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_c0_ene1_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_c0_ene1_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_c0_ene1_6_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_c0_ene1_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_c0_ene1_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_c0_ene1_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_c0_ene1_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_c0_ene1_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_2_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_3_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_4_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_5_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_6_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene1_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_2_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_3_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_4_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_5_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_6_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_c0_ene2_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_c0_ene2_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_c0_ene2_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_c0_ene2_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_c0_ene2_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_c0_ene2_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_c0_ene2_7_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_c0_ene2_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_c0_ene2_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_c0_ene2_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_c0_ene2_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_c0_ene2_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_0_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_1_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_2_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_3_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_4_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_5_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_6_NO_SHIFT_REG = rnode_166to167_bb1_c0_ene2_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_0_0_push35_c0_ene3_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_0_0_push35_c0_ene3_stall_in = 1'b0;
assign rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG = rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_isMin_3_stall_local;
wire [7:0] local_bb1_isMin_3;

assign local_bb1_isMin_3[7:1] = 7'h0;
assign local_bb1_isMin_3[0] = local_bb1_cmp16;

// This section implements an unregistered operation.
// 
wire local_bb1__334_demorgan_stall_local;
wire local_bb1__334_demorgan;

assign local_bb1__334_demorgan = (local_bb1_cmp16_1 | local_bb1_cmp16);

// This section implements an unregistered operation.
// 
wire local_bb1___stall_local;
wire local_bb1__;

assign local_bb1__ = (local_bb1_cmp16 & local_bb1_not_cmp16_1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_4_0_push31_rows_3_0_pop32_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_4_0_push31_rows_3_0_pop32_stall_in = 1'b0;
assign rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG = rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_4_stall_local;
wire local_bb1_not_cmp16_4;

assign local_bb1_not_cmp16_4 = (rnode_164to165_bb1_cmp16_4_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_5_0_push30_rows_4_0_pop31_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_5_0_push30_rows_4_0_pop31_stall_in = 1'b0;
assign rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG = rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_5_stall_local;
wire local_bb1_not_cmp16_5;

assign local_bb1_not_cmp16_5 = (rnode_164to165_bb1_cmp16_5_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_6_0_push29_rows_5_0_pop30_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_6_0_push29_rows_5_0_pop30_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_6_stall_local;
wire local_bb1_not_cmp16_6;

assign local_bb1_not_cmp16_6 = (local_bb1_cmp16_6 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_8_stall_local;
wire local_bb1_not_cmp16_8;

assign local_bb1_not_cmp16_8 = (local_bb1_cmp16_8 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_9_stall_local;
wire local_bb1_not_cmp16_9;

assign local_bb1_not_cmp16_9 = (local_bb1_cmp16_9 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_10_stall_local;
wire local_bb1_not_cmp16_10;

assign local_bb1_not_cmp16_10 = (local_bb1_cmp16_10 ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_inputs_ready;
 reg local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_stall_in;
wire local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_output_regs_ready;
wire [7:0] local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_result;
wire local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_fu_valid_out;
wire local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_fu_stall_out;
 reg [7:0] local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_NO_SHIFT_REG;
wire local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_causedstall;

acl_push local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(1'b1),
	.predicate(1'b0),
	.data_in(local_bb1_rows_15_0_pop20_),
	.stall_out(local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_result),
	.feedback_out(feedback_data_out_3),
	.feedback_valid_out(feedback_valid_out_3),
	.feedback_stall_in(feedback_stall_in_3)
);

defparam local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_feedback.STALLFREE = 1;
defparam local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_feedback.FIFO_DEPTH = 704;
defparam local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_feedback.MIN_FIFO_LATENCY = 704;
defparam local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_feedback.STYLE = "REGULAR";

assign local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_inputs_ready = 1'b1;
assign local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_output_regs_ready = 1'b1;
assign local_bb1_rows_15_0_pop20__stall_in_0 = 1'b0;
assign local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_NO_SHIFT_REG <= 'x;
		local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_output_regs_ready)
		begin
			local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_NO_SHIFT_REG <= local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_result;
			local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_stall_in))
			begin
				local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_cmp16_16_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_16_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_cmp16_16_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_cmp16_16_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_cmp16_16_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_cmp16_16_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_cmp16_16_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_16),
	.data_out(rnode_165to166_bb1_cmp16_16_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_cmp16_16_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_cmp16_16_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_cmp16_16_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_cmp16_16_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_cmp16_16_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_16_stall_in = 1'b0;
assign rnode_165to166_bb1_cmp16_16_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_16_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_16_0_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_16_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_cmp16_16_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_16_1_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_16_0_reg_166_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_721_0_push18_rows_720_0_pop19_inputs_ready;
 reg local_bb1_rows_721_0_push18_rows_720_0_pop19_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_721_0_push18_rows_720_0_pop19_stall_in;
wire local_bb1_rows_721_0_push18_rows_720_0_pop19_output_regs_ready;
wire [7:0] local_bb1_rows_721_0_push18_rows_720_0_pop19_result;
wire local_bb1_rows_721_0_push18_rows_720_0_pop19_fu_valid_out;
wire local_bb1_rows_721_0_push18_rows_720_0_pop19_fu_stall_out;
 reg [7:0] local_bb1_rows_721_0_push18_rows_720_0_pop19_NO_SHIFT_REG;
wire local_bb1_rows_721_0_push18_rows_720_0_pop19_causedstall;

acl_push local_bb1_rows_721_0_push18_rows_720_0_pop19_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene2_6_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_165to166_bb1_rows_720_0_pop19__0_NO_SHIFT_REG),
	.stall_out(local_bb1_rows_721_0_push18_rows_720_0_pop19_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_721_0_push18_rows_720_0_pop19_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_721_0_push18_rows_720_0_pop19_result),
	.feedback_out(feedback_data_out_18),
	.feedback_valid_out(feedback_valid_out_18),
	.feedback_stall_in(feedback_stall_in_18)
);

defparam local_bb1_rows_721_0_push18_rows_720_0_pop19_feedback.STALLFREE = 1;
defparam local_bb1_rows_721_0_push18_rows_720_0_pop19_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_721_0_push18_rows_720_0_pop19_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_721_0_push18_rows_720_0_pop19_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_721_0_push18_rows_720_0_pop19_feedback.STYLE = "REGULAR";

assign local_bb1_rows_721_0_push18_rows_720_0_pop19_inputs_ready = 1'b1;
assign local_bb1_rows_721_0_push18_rows_720_0_pop19_output_regs_ready = 1'b1;
assign rnode_165to166_bb1_rows_720_0_pop19__0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_721_0_push18_rows_720_0_pop19_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[4] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_721_0_push18_rows_720_0_pop19_NO_SHIFT_REG <= 'x;
		local_bb1_rows_721_0_push18_rows_720_0_pop19_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_721_0_push18_rows_720_0_pop19_output_regs_ready)
		begin
			local_bb1_rows_721_0_push18_rows_720_0_pop19_NO_SHIFT_REG <= local_bb1_rows_721_0_push18_rows_720_0_pop19_result;
			local_bb1_rows_721_0_push18_rows_720_0_pop19_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_721_0_push18_rows_720_0_pop19_stall_in))
			begin
				local_bb1_rows_721_0_push18_rows_720_0_pop19_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_1_1_stall_local;
wire local_bb1_cmp16_1_1;

assign local_bb1_cmp16_1_1 = (rnode_165to166_bb1_rows_720_0_pop19__1_NO_SHIFT_REG == 8'h0);

// This section implements a registered operation.
// 
wire local_bb1_rows_15_0_push20_rows_14_0_pop21_inputs_ready;
 reg local_bb1_rows_15_0_push20_rows_14_0_pop21_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_15_0_push20_rows_14_0_pop21_stall_in;
wire local_bb1_rows_15_0_push20_rows_14_0_pop21_output_regs_ready;
wire [7:0] local_bb1_rows_15_0_push20_rows_14_0_pop21_result;
wire local_bb1_rows_15_0_push20_rows_14_0_pop21_fu_valid_out;
wire local_bb1_rows_15_0_push20_rows_14_0_pop21_fu_stall_out;
 reg [7:0] local_bb1_rows_15_0_push20_rows_14_0_pop21_NO_SHIFT_REG;
wire local_bb1_rows_15_0_push20_rows_14_0_pop21_causedstall;

acl_push local_bb1_rows_15_0_push20_rows_14_0_pop21_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_14_0_pop21_),
	.stall_out(local_bb1_rows_15_0_push20_rows_14_0_pop21_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_15_0_push20_rows_14_0_pop21_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_15_0_push20_rows_14_0_pop21_result),
	.feedback_out(feedback_data_out_20),
	.feedback_valid_out(feedback_valid_out_20),
	.feedback_stall_in(feedback_stall_in_20)
);

defparam local_bb1_rows_15_0_push20_rows_14_0_pop21_feedback.STALLFREE = 1;
defparam local_bb1_rows_15_0_push20_rows_14_0_pop21_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_15_0_push20_rows_14_0_pop21_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_15_0_push20_rows_14_0_pop21_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_15_0_push20_rows_14_0_pop21_feedback.STYLE = "REGULAR";

assign local_bb1_rows_15_0_push20_rows_14_0_pop21_inputs_ready = 1'b1;
assign local_bb1_rows_15_0_push20_rows_14_0_pop21_output_regs_ready = 1'b1;
assign local_bb1_rows_14_0_pop21__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_15_0_push20_rows_14_0_pop21_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_15_0_push20_rows_14_0_pop21_NO_SHIFT_REG <= 'x;
		local_bb1_rows_15_0_push20_rows_14_0_pop21_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_15_0_push20_rows_14_0_pop21_output_regs_ready)
		begin
			local_bb1_rows_15_0_push20_rows_14_0_pop21_NO_SHIFT_REG <= local_bb1_rows_15_0_push20_rows_14_0_pop21_result;
			local_bb1_rows_15_0_push20_rows_14_0_pop21_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_15_0_push20_rows_14_0_pop21_stall_in))
			begin
				local_bb1_rows_15_0_push20_rows_14_0_pop21_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_cmp16_15_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_15_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_cmp16_15_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_cmp16_15_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_cmp16_15_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_cmp16_15_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_cmp16_15_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_15),
	.data_out(rnode_165to166_bb1_cmp16_15_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_cmp16_15_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_cmp16_15_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_cmp16_15_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_cmp16_15_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_cmp16_15_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_15_stall_in = 1'b0;
assign rnode_165to166_bb1_cmp16_15_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_15_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_15_0_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_15_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_cmp16_15_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_15_1_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_15_0_reg_166_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_14_0_push21_rows_13_0_pop22_inputs_ready;
 reg local_bb1_rows_14_0_push21_rows_13_0_pop22_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_14_0_push21_rows_13_0_pop22_stall_in;
wire local_bb1_rows_14_0_push21_rows_13_0_pop22_output_regs_ready;
wire [7:0] local_bb1_rows_14_0_push21_rows_13_0_pop22_result;
wire local_bb1_rows_14_0_push21_rows_13_0_pop22_fu_valid_out;
wire local_bb1_rows_14_0_push21_rows_13_0_pop22_fu_stall_out;
 reg [7:0] local_bb1_rows_14_0_push21_rows_13_0_pop22_NO_SHIFT_REG;
wire local_bb1_rows_14_0_push21_rows_13_0_pop22_causedstall;

acl_push local_bb1_rows_14_0_push21_rows_13_0_pop22_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_13_0_pop22_),
	.stall_out(local_bb1_rows_14_0_push21_rows_13_0_pop22_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_14_0_push21_rows_13_0_pop22_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_14_0_push21_rows_13_0_pop22_result),
	.feedback_out(feedback_data_out_21),
	.feedback_valid_out(feedback_valid_out_21),
	.feedback_stall_in(feedback_stall_in_21)
);

defparam local_bb1_rows_14_0_push21_rows_13_0_pop22_feedback.STALLFREE = 1;
defparam local_bb1_rows_14_0_push21_rows_13_0_pop22_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_14_0_push21_rows_13_0_pop22_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_14_0_push21_rows_13_0_pop22_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_14_0_push21_rows_13_0_pop22_feedback.STYLE = "REGULAR";

assign local_bb1_rows_14_0_push21_rows_13_0_pop22_inputs_ready = 1'b1;
assign local_bb1_rows_14_0_push21_rows_13_0_pop22_output_regs_ready = 1'b1;
assign local_bb1_rows_13_0_pop22__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_14_0_push21_rows_13_0_pop22_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_14_0_push21_rows_13_0_pop22_NO_SHIFT_REG <= 'x;
		local_bb1_rows_14_0_push21_rows_13_0_pop22_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_14_0_push21_rows_13_0_pop22_output_regs_ready)
		begin
			local_bb1_rows_14_0_push21_rows_13_0_pop22_NO_SHIFT_REG <= local_bb1_rows_14_0_push21_rows_13_0_pop22_result;
			local_bb1_rows_14_0_push21_rows_13_0_pop22_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_14_0_push21_rows_13_0_pop22_stall_in))
			begin
				local_bb1_rows_14_0_push21_rows_13_0_pop22_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_cmp16_14_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_14_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_cmp16_14_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_cmp16_14_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_cmp16_14_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_cmp16_14_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_cmp16_14_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_14),
	.data_out(rnode_165to166_bb1_cmp16_14_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_cmp16_14_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_cmp16_14_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_cmp16_14_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_cmp16_14_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_cmp16_14_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_14_stall_in = 1'b0;
assign rnode_165to166_bb1_cmp16_14_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_14_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_14_0_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_14_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_cmp16_14_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_14_1_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_14_0_reg_166_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_13_0_push22_rows_12_0_pop23_inputs_ready;
 reg local_bb1_rows_13_0_push22_rows_12_0_pop23_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_13_0_push22_rows_12_0_pop23_stall_in;
wire local_bb1_rows_13_0_push22_rows_12_0_pop23_output_regs_ready;
wire [7:0] local_bb1_rows_13_0_push22_rows_12_0_pop23_result;
wire local_bb1_rows_13_0_push22_rows_12_0_pop23_fu_valid_out;
wire local_bb1_rows_13_0_push22_rows_12_0_pop23_fu_stall_out;
 reg [7:0] local_bb1_rows_13_0_push22_rows_12_0_pop23_NO_SHIFT_REG;
wire local_bb1_rows_13_0_push22_rows_12_0_pop23_causedstall;

acl_push local_bb1_rows_13_0_push22_rows_12_0_pop23_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_7_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_12_0_pop23_),
	.stall_out(local_bb1_rows_13_0_push22_rows_12_0_pop23_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_13_0_push22_rows_12_0_pop23_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_13_0_push22_rows_12_0_pop23_result),
	.feedback_out(feedback_data_out_22),
	.feedback_valid_out(feedback_valid_out_22),
	.feedback_stall_in(feedback_stall_in_22)
);

defparam local_bb1_rows_13_0_push22_rows_12_0_pop23_feedback.STALLFREE = 1;
defparam local_bb1_rows_13_0_push22_rows_12_0_pop23_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_13_0_push22_rows_12_0_pop23_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_13_0_push22_rows_12_0_pop23_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_13_0_push22_rows_12_0_pop23_feedback.STYLE = "REGULAR";

assign local_bb1_rows_13_0_push22_rows_12_0_pop23_inputs_ready = 1'b1;
assign local_bb1_rows_13_0_push22_rows_12_0_pop23_output_regs_ready = 1'b1;
assign local_bb1_rows_12_0_pop23__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_13_0_push22_rows_12_0_pop23_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_13_0_push22_rows_12_0_pop23_NO_SHIFT_REG <= 'x;
		local_bb1_rows_13_0_push22_rows_12_0_pop23_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_13_0_push22_rows_12_0_pop23_output_regs_ready)
		begin
			local_bb1_rows_13_0_push22_rows_12_0_pop23_NO_SHIFT_REG <= local_bb1_rows_13_0_push22_rows_12_0_pop23_result;
			local_bb1_rows_13_0_push22_rows_12_0_pop23_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_13_0_push22_rows_12_0_pop23_stall_in))
			begin
				local_bb1_rows_13_0_push22_rows_12_0_pop23_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_cmp16_13_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_13_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_cmp16_13_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_cmp16_13_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_cmp16_13_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_cmp16_13_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_cmp16_13_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_13),
	.data_out(rnode_165to166_bb1_cmp16_13_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_cmp16_13_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_cmp16_13_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_cmp16_13_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_cmp16_13_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_cmp16_13_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_13_stall_in = 1'b0;
assign rnode_165to166_bb1_cmp16_13_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_13_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_13_0_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_13_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_cmp16_13_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_13_1_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_13_0_reg_166_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_11_0_pop24__0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_11_0_pop24__0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_11_0_pop24__0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_11_0_pop24__0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_11_0_pop24__0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_11_0_pop24__0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_11_0_pop24__0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_11_0_pop24__0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_11_0_pop24__0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_11_0_pop24_),
	.data_out(rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_11_0_pop24__stall_in_1 = 1'b0;
assign rnode_165to166_bb1_rows_11_0_pop24__0_NO_SHIFT_REG = rnode_165to166_bb1_rows_11_0_pop24__0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_11_0_pop24__0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_11_0_pop24__0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_cmp16_12_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_12_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_cmp16_12_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_cmp16_12_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_cmp16_12_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_cmp16_12_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_cmp16_12_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_12),
	.data_out(rnode_165to166_bb1_cmp16_12_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_cmp16_12_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_cmp16_12_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_cmp16_12_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_cmp16_12_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_cmp16_12_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_12_stall_in = 1'b0;
assign rnode_165to166_bb1_cmp16_12_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_12_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_12_0_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_12_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_cmp16_12_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_12_1_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_12_0_reg_166_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_719_0_coalesced_pop3__stall_local;
wire [7:0] local_bb1_rows_719_0_coalesced_pop3_;
wire local_bb1_rows_719_0_coalesced_pop3__fu_valid_out;
wire local_bb1_rows_719_0_coalesced_pop3__fu_stall_out;

acl_pop local_bb1_rows_719_0_coalesced_pop3__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_not_select6),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_719_0_coalesced_pop3__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_719_0_coalesced_pop3__fu_valid_out),
	.stall_in(local_bb1_rows_719_0_coalesced_pop3__stall_local),
	.data_out(local_bb1_rows_719_0_coalesced_pop3_),
	.feedback_in(feedback_data_in_3),
	.feedback_valid_in(feedback_valid_in_3),
	.feedback_stall_out(feedback_stall_out_3)
);

defparam local_bb1_rows_719_0_coalesced_pop3__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_719_0_coalesced_pop3__feedback.STYLE = "COALESCE";

assign local_bb1_rows_719_0_coalesced_pop3__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_next_coalesce_select_stall_local;
wire [10:0] local_bb1_next_coalesce_select;

assign local_bb1_next_coalesce_select = (local_bb1_coalesce_counter_lobit ^ 11'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_11_stall_local;
wire local_bb1_not_cmp16_11;

assign local_bb1_not_cmp16_11 = (local_bb1_cmp16_11 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_7_stall_local;
wire local_bb1_not_cmp16_7;

assign local_bb1_not_cmp16_7 = (local_bb1_cmp16_7 ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_726_0_pop13__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_726_0_pop13__0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_726_0_pop13__0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_726_0_pop13__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_726_0_pop13__0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_726_0_pop13__1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_726_0_pop13__0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_726_0_pop13__0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_726_0_pop13__0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_726_0_pop13__0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_726_0_pop13__0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_726_0_pop13__0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_726_0_pop13_),
	.data_out(rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_726_0_pop13__stall_in = 1'b0;
assign rnode_166to167_bb1_rows_726_0_pop13__0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_726_0_pop13__0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_726_0_pop13__0_NO_SHIFT_REG = rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_726_0_pop13__0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_726_0_pop13__1_NO_SHIFT_REG = rnode_166to167_bb1_rows_726_0_pop13__0_reg_167_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_725_0_pop14__valid_out_0;
wire local_bb1_rows_725_0_pop14__stall_in_0;
 reg local_bb1_rows_725_0_pop14__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_6_1_valid_out;
wire local_bb1_cmp16_6_1_stall_in;
 reg local_bb1_cmp16_6_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_6_1_inputs_ready;
wire local_bb1_cmp16_6_1_stall_local;
wire local_bb1_cmp16_6_1;

assign local_bb1_cmp16_6_1_inputs_ready = rnode_165to166_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp16_6_1 = (local_bb1_rows_725_0_pop14_ == 8'h0);
assign local_bb1_rows_725_0_pop14__valid_out_0 = 1'b1;
assign local_bb1_cmp16_6_1_valid_out = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_725_0_pop14__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_6_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_725_0_pop14__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_6_1_inputs_ready & (local_bb1_rows_725_0_pop14__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_725_0_pop14__stall_in_0)) & local_bb1_cmp16_6_1_stall_local);
		local_bb1_cmp16_6_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_6_1_inputs_ready & (local_bb1_cmp16_6_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_6_1_stall_in)) & local_bb1_cmp16_6_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_724_0_pop15__valid_out_0;
wire local_bb1_rows_724_0_pop15__stall_in_0;
 reg local_bb1_rows_724_0_pop15__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_5_1_valid_out;
wire local_bb1_cmp16_5_1_stall_in;
 reg local_bb1_cmp16_5_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_5_1_inputs_ready;
wire local_bb1_cmp16_5_1_stall_local;
wire local_bb1_cmp16_5_1;

assign local_bb1_cmp16_5_1_inputs_ready = rnode_165to166_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_cmp16_5_1 = (local_bb1_rows_724_0_pop15_ == 8'h0);
assign local_bb1_rows_724_0_pop15__valid_out_0 = 1'b1;
assign local_bb1_cmp16_5_1_valid_out = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_724_0_pop15__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_5_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_724_0_pop15__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_5_1_inputs_ready & (local_bb1_rows_724_0_pop15__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_724_0_pop15__stall_in_0)) & local_bb1_cmp16_5_1_stall_local);
		local_bb1_cmp16_5_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_5_1_inputs_ready & (local_bb1_cmp16_5_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_5_1_stall_in)) & local_bb1_cmp16_5_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_723_0_pop16__valid_out_0;
wire local_bb1_rows_723_0_pop16__stall_in_0;
 reg local_bb1_rows_723_0_pop16__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_4_1_valid_out;
wire local_bb1_cmp16_4_1_stall_in;
 reg local_bb1_cmp16_4_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_4_1_inputs_ready;
wire local_bb1_cmp16_4_1_stall_local;
wire local_bb1_cmp16_4_1;

assign local_bb1_cmp16_4_1_inputs_ready = rnode_165to166_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1_cmp16_4_1 = (local_bb1_rows_723_0_pop16_ == 8'h0);
assign local_bb1_rows_723_0_pop16__valid_out_0 = 1'b1;
assign local_bb1_cmp16_4_1_valid_out = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_723_0_pop16__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_4_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_723_0_pop16__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_4_1_inputs_ready & (local_bb1_rows_723_0_pop16__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_723_0_pop16__stall_in_0)) & local_bb1_cmp16_4_1_stall_local);
		local_bb1_cmp16_4_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_4_1_inputs_ready & (local_bb1_cmp16_4_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_4_1_stall_in)) & local_bb1_cmp16_4_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_722_0_pop17__valid_out_0;
wire local_bb1_rows_722_0_pop17__stall_in_0;
 reg local_bb1_rows_722_0_pop17__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_3_1_valid_out;
wire local_bb1_cmp16_3_1_stall_in;
 reg local_bb1_cmp16_3_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_3_1_inputs_ready;
wire local_bb1_cmp16_3_1_stall_local;
wire local_bb1_cmp16_3_1;

assign local_bb1_cmp16_3_1_inputs_ready = rnode_165to166_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
assign local_bb1_cmp16_3_1 = (local_bb1_rows_722_0_pop17_ == 8'h0);
assign local_bb1_rows_722_0_pop17__valid_out_0 = 1'b1;
assign local_bb1_cmp16_3_1_valid_out = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_722_0_pop17__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_3_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_722_0_pop17__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_3_1_inputs_ready & (local_bb1_rows_722_0_pop17__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_722_0_pop17__stall_in_0)) & local_bb1_cmp16_3_1_stall_local);
		local_bb1_cmp16_3_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_3_1_inputs_ready & (local_bb1_cmp16_3_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_3_1_stall_in)) & local_bb1_cmp16_3_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_721_0_pop18__valid_out_0;
wire local_bb1_rows_721_0_pop18__stall_in_0;
 reg local_bb1_rows_721_0_pop18__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_2_1_valid_out;
wire local_bb1_cmp16_2_1_stall_in;
 reg local_bb1_cmp16_2_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_2_1_inputs_ready;
wire local_bb1_cmp16_2_1_stall_local;
wire local_bb1_cmp16_2_1;

assign local_bb1_cmp16_2_1_inputs_ready = rnode_165to166_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
assign local_bb1_cmp16_2_1 = (local_bb1_rows_721_0_pop18_ == 8'h0);
assign local_bb1_rows_721_0_pop18__valid_out_0 = 1'b1;
assign local_bb1_cmp16_2_1_valid_out = 1'b1;
assign rnode_165to166_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_721_0_pop18__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_2_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_721_0_pop18__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_2_1_inputs_ready & (local_bb1_rows_721_0_pop18__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_721_0_pop18__stall_in_0)) & local_bb1_cmp16_2_1_stall_local);
		local_bb1_cmp16_2_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_2_1_inputs_ready & (local_bb1_cmp16_2_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_2_1_stall_in)) & local_bb1_cmp16_2_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_729_0_pop10__stall_local;
wire [7:0] local_bb1_rows_729_0_pop10_;
wire local_bb1_rows_729_0_pop10__fu_valid_out;
wire local_bb1_rows_729_0_pop10__fu_stall_out;

acl_pop local_bb1_rows_729_0_pop10__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_729_0_pop10__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_729_0_pop10__fu_valid_out),
	.stall_in(local_bb1_rows_729_0_pop10__stall_local),
	.data_out(local_bb1_rows_729_0_pop10_),
	.feedback_in(feedback_data_in_10),
	.feedback_valid_in(feedback_valid_in_10),
	.feedback_stall_out(feedback_stall_out_10)
);

defparam local_bb1_rows_729_0_pop10__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_729_0_pop10__feedback.STYLE = "REGULAR";

assign local_bb1_rows_729_0_pop10__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_731_0_pop8__stall_local;
wire [7:0] local_bb1_rows_731_0_pop8_;
wire local_bb1_rows_731_0_pop8__fu_valid_out;
wire local_bb1_rows_731_0_pop8__fu_stall_out;

acl_pop local_bb1_rows_731_0_pop8__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_731_0_pop8__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_731_0_pop8__fu_valid_out),
	.stall_in(local_bb1_rows_731_0_pop8__stall_local),
	.data_out(local_bb1_rows_731_0_pop8_),
	.feedback_in(feedback_data_in_8),
	.feedback_valid_in(feedback_valid_in_8),
	.feedback_stall_out(feedback_stall_out_8)
);

defparam local_bb1_rows_731_0_pop8__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_731_0_pop8__feedback.STYLE = "REGULAR";

assign local_bb1_rows_731_0_pop8__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_732_0_pop7__valid_out;
wire local_bb1_rows_732_0_pop7__stall_in;
wire local_bb1_rows_732_0_pop7__inputs_ready;
wire local_bb1_rows_732_0_pop7__stall_local;
wire [7:0] local_bb1_rows_732_0_pop7_;
wire local_bb1_rows_732_0_pop7__fu_valid_out;
wire local_bb1_rows_732_0_pop7__fu_stall_out;

acl_pop local_bb1_rows_732_0_pop7__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene1_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_732_0_pop7__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_732_0_pop7__fu_valid_out),
	.stall_in(local_bb1_rows_732_0_pop7__stall_local),
	.data_out(local_bb1_rows_732_0_pop7_),
	.feedback_in(feedback_data_in_7),
	.feedback_valid_in(feedback_valid_in_7),
	.feedback_stall_out(feedback_stall_out_7)
);

defparam local_bb1_rows_732_0_pop7__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_732_0_pop7__feedback.STYLE = "REGULAR";

assign local_bb1_rows_732_0_pop7__inputs_ready = rnode_166to167_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_rows_732_0_pop7__stall_local = 1'b0;
assign local_bb1_rows_732_0_pop7__valid_out = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_730_0_pop9__stall_local;
wire [7:0] local_bb1_rows_730_0_pop9_;
wire local_bb1_rows_730_0_pop9__fu_valid_out;
wire local_bb1_rows_730_0_pop9__fu_stall_out;

acl_pop local_bb1_rows_730_0_pop9__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene1_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_730_0_pop9__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_730_0_pop9__fu_valid_out),
	.stall_in(local_bb1_rows_730_0_pop9__stall_local),
	.data_out(local_bb1_rows_730_0_pop9_),
	.feedback_in(feedback_data_in_9),
	.feedback_valid_in(feedback_valid_in_9),
	.feedback_stall_out(feedback_stall_out_9)
);

defparam local_bb1_rows_730_0_pop9__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_730_0_pop9__feedback.STYLE = "REGULAR";

assign local_bb1_rows_730_0_pop9__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_727_0_pop12__stall_local;
wire [7:0] local_bb1_rows_727_0_pop12_;
wire local_bb1_rows_727_0_pop12__fu_valid_out;
wire local_bb1_rows_727_0_pop12__fu_stall_out;

acl_pop local_bb1_rows_727_0_pop12__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene1_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_727_0_pop12__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_727_0_pop12__fu_valid_out),
	.stall_in(local_bb1_rows_727_0_pop12__stall_local),
	.data_out(local_bb1_rows_727_0_pop12_),
	.feedback_in(feedback_data_in_12),
	.feedback_valid_in(feedback_valid_in_12),
	.feedback_stall_out(feedback_stall_out_12)
);

defparam local_bb1_rows_727_0_pop12__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_727_0_pop12__feedback.STYLE = "REGULAR";

assign local_bb1_rows_727_0_pop12__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_728_0_pop11__stall_local;
wire [7:0] local_bb1_rows_728_0_pop11_;
wire local_bb1_rows_728_0_pop11__fu_valid_out;
wire local_bb1_rows_728_0_pop11__fu_stall_out;

acl_pop local_bb1_rows_728_0_pop11__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene1_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_728_0_pop11__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_728_0_pop11__fu_valid_out),
	.stall_in(local_bb1_rows_728_0_pop11__stall_local),
	.data_out(local_bb1_rows_728_0_pop11_),
	.feedback_in(feedback_data_in_11),
	.feedback_valid_in(feedback_valid_in_11),
	.feedback_stall_out(feedback_stall_out_11)
);

defparam local_bb1_rows_728_0_pop11__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_728_0_pop11__feedback.STYLE = "REGULAR";

assign local_bb1_rows_728_0_pop11__stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_4_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_5_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_6_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_7_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_7_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_7_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_8_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_8_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_8_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_9_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_9_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_9_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_10_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_10_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_10_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene1_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_c0_ene1_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_c0_ene1_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_c0_ene1_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_c0_ene1_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_c0_ene1_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_c0_ene1_6_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_c0_ene1_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_c0_ene1_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb1_c0_ene1_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_c0_ene1_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_c0_ene1_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_2_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_3_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_4_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_5_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_6_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_7_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_7_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_8_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_8_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_9_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_9_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene1_0_valid_out_10_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_10_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene1_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_4_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_5_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_6_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_7_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_8_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_8_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_8_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_9_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_9_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_9_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene2_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_c0_ene2_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_c0_ene2_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_c0_ene2_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_c0_ene2_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_c0_ene2_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_c0_ene2_6_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_c0_ene2_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_c0_ene2_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb1_c0_ene2_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_c0_ene2_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_c0_ene2_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_0_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_1_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_2_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_3_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_4_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_5_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_6_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_7_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_8_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_8_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene2_0_valid_out_9_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_9_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene2_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG),
	.data_out(rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_fifo.DEPTH = 4;
defparam rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_0_0_push35_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG = rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_reg_170_NO_SHIFT_REG;
assign rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__333_stall_local;
wire [7:0] local_bb1__333;

assign local_bb1__333 = (local_bb1__ ? local_bb1_isMin_3 : 8'h1);

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG),
	.data_out(rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_fifo.DEPTH = 4;
defparam rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG = rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_170_NO_SHIFT_REG;
assign rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG),
	.data_out(rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_fifo.DEPTH = 4;
defparam rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG = rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_170_NO_SHIFT_REG;
assign rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_16_stall_local;
wire local_bb1_not_cmp16_16;

assign local_bb1_not_cmp16_16 = (rnode_165to166_bb1_cmp16_16_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_721_0_push18_rows_720_0_pop19_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_721_0_push18_rows_720_0_pop19_stall_in = 1'b0;
assign rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG = rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_1_1_stall_local;
wire local_bb1_not_cmp16_1_1;

assign local_bb1_not_cmp16_1_1 = (local_bb1_cmp16_1_1 ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_15_0_push20_rows_14_0_pop21_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_15_0_push20_rows_14_0_pop21_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_15_stall_local;
wire local_bb1_not_cmp16_15;

assign local_bb1_not_cmp16_15 = (rnode_165to166_bb1_cmp16_15_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_14_0_push21_rows_13_0_pop22_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_14_0_push21_rows_13_0_pop22_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_14_stall_local;
wire local_bb1_not_cmp16_14;

assign local_bb1_not_cmp16_14 = (rnode_165to166_bb1_cmp16_14_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_13_0_push22_rows_12_0_pop23_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_13_0_push22_rows_12_0_pop23_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_13_stall_local;
wire local_bb1_not_cmp16_13;

assign local_bb1_not_cmp16_13 = (rnode_165to166_bb1_cmp16_13_1_NO_SHIFT_REG ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1_rows_12_0_push23_rows_11_0_pop24_inputs_ready;
 reg local_bb1_rows_12_0_push23_rows_11_0_pop24_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_12_0_push23_rows_11_0_pop24_stall_in;
wire local_bb1_rows_12_0_push23_rows_11_0_pop24_output_regs_ready;
wire [7:0] local_bb1_rows_12_0_push23_rows_11_0_pop24_result;
wire local_bb1_rows_12_0_push23_rows_11_0_pop24_fu_valid_out;
wire local_bb1_rows_12_0_push23_rows_11_0_pop24_fu_stall_out;
 reg [7:0] local_bb1_rows_12_0_push23_rows_11_0_pop24_NO_SHIFT_REG;
wire local_bb1_rows_12_0_push23_rows_11_0_pop24_causedstall;

acl_push local_bb1_rows_12_0_push23_rows_11_0_pop24_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene2_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_165to166_bb1_rows_11_0_pop24__0_NO_SHIFT_REG),
	.stall_out(local_bb1_rows_12_0_push23_rows_11_0_pop24_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_12_0_push23_rows_11_0_pop24_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_12_0_push23_rows_11_0_pop24_result),
	.feedback_out(feedback_data_out_23),
	.feedback_valid_out(feedback_valid_out_23),
	.feedback_stall_in(feedback_stall_in_23)
);

defparam local_bb1_rows_12_0_push23_rows_11_0_pop24_feedback.STALLFREE = 1;
defparam local_bb1_rows_12_0_push23_rows_11_0_pop24_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_12_0_push23_rows_11_0_pop24_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_12_0_push23_rows_11_0_pop24_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_rows_12_0_push23_rows_11_0_pop24_feedback.STYLE = "REGULAR";

assign local_bb1_rows_12_0_push23_rows_11_0_pop24_inputs_ready = 1'b1;
assign local_bb1_rows_12_0_push23_rows_11_0_pop24_output_regs_ready = 1'b1;
assign rnode_165to166_bb1_rows_11_0_pop24__0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_12_0_push23_rows_11_0_pop24_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[4] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_12_0_push23_rows_11_0_pop24_NO_SHIFT_REG <= 'x;
		local_bb1_rows_12_0_push23_rows_11_0_pop24_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_12_0_push23_rows_11_0_pop24_output_regs_ready)
		begin
			local_bb1_rows_12_0_push23_rows_11_0_pop24_NO_SHIFT_REG <= local_bb1_rows_12_0_push23_rows_11_0_pop24_result;
			local_bb1_rows_12_0_push23_rows_11_0_pop24_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_12_0_push23_rows_11_0_pop24_stall_in))
			begin
				local_bb1_rows_12_0_push23_rows_11_0_pop24_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_12_stall_local;
wire local_bb1_not_cmp16_12;

assign local_bb1_not_cmp16_12 = (rnode_165to166_bb1_cmp16_12_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_121_stall_local;
wire local_bb1_cmp16_121;

assign local_bb1_cmp16_121 = (local_bb1_rows_719_0_coalesced_pop3_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_not_select6_valid_out_1;
wire local_bb1_not_select6_stall_in_1;
 reg local_bb1_not_select6_consumed_1_NO_SHIFT_REG;
wire local_bb1_next_coalesce_valid_out;
wire local_bb1_next_coalesce_stall_in;
 reg local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_719_0_coalesced_pop3__valid_out_0;
wire local_bb1_rows_719_0_coalesced_pop3__stall_in_0;
 reg local_bb1_rows_719_0_coalesced_pop3__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_121_valid_out;
wire local_bb1_cmp16_121_stall_in;
 reg local_bb1_cmp16_121_consumed_0_NO_SHIFT_REG;
wire local_bb1_next_coalesce_inputs_ready;
wire local_bb1_next_coalesce_stall_local;
wire [10:0] local_bb1_next_coalesce;

assign local_bb1_next_coalesce_inputs_ready = rnode_164to165_bb1_c0_ene1_0_valid_out_9_NO_SHIFT_REG;
assign local_bb1_next_coalesce = (local_bb1_coalesce_counter_pop54_acl_pop_i11_703 - local_bb1_next_coalesce_select);
assign local_bb1_not_select6_valid_out_1 = 1'b1;
assign local_bb1_next_coalesce_valid_out = 1'b1;
assign local_bb1_rows_719_0_coalesced_pop3__valid_out_0 = 1'b1;
assign local_bb1_cmp16_121_valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_9_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_not_select6_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_719_0_coalesced_pop3__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_121_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_not_select6_consumed_1_NO_SHIFT_REG <= (local_bb1_next_coalesce_inputs_ready & (local_bb1_not_select6_consumed_1_NO_SHIFT_REG | ~(local_bb1_not_select6_stall_in_1)) & local_bb1_next_coalesce_stall_local);
		local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG <= (local_bb1_next_coalesce_inputs_ready & (local_bb1_next_coalesce_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_coalesce_stall_in)) & local_bb1_next_coalesce_stall_local);
		local_bb1_rows_719_0_coalesced_pop3__consumed_0_NO_SHIFT_REG <= (local_bb1_next_coalesce_inputs_ready & (local_bb1_rows_719_0_coalesced_pop3__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_719_0_coalesced_pop3__stall_in_0)) & local_bb1_next_coalesce_stall_local);
		local_bb1_cmp16_121_consumed_0_NO_SHIFT_REG <= (local_bb1_next_coalesce_inputs_ready & (local_bb1_cmp16_121_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_121_stall_in)) & local_bb1_next_coalesce_stall_local);
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_727_0_push12_rows_726_0_pop13_inputs_ready;
 reg local_bb1_rows_727_0_push12_rows_726_0_pop13_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_727_0_push12_rows_726_0_pop13_stall_in;
wire local_bb1_rows_727_0_push12_rows_726_0_pop13_output_regs_ready;
wire [7:0] local_bb1_rows_727_0_push12_rows_726_0_pop13_result;
wire local_bb1_rows_727_0_push12_rows_726_0_pop13_fu_valid_out;
wire local_bb1_rows_727_0_push12_rows_726_0_pop13_fu_stall_out;
 reg [7:0] local_bb1_rows_727_0_push12_rows_726_0_pop13_NO_SHIFT_REG;
wire local_bb1_rows_727_0_push12_rows_726_0_pop13_causedstall;

acl_push local_bb1_rows_727_0_push12_rows_726_0_pop13_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene2_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_166to167_bb1_rows_726_0_pop13__0_NO_SHIFT_REG),
	.stall_out(local_bb1_rows_727_0_push12_rows_726_0_pop13_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_727_0_push12_rows_726_0_pop13_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_727_0_push12_rows_726_0_pop13_result),
	.feedback_out(feedback_data_out_12),
	.feedback_valid_out(feedback_valid_out_12),
	.feedback_stall_in(feedback_stall_in_12)
);

defparam local_bb1_rows_727_0_push12_rows_726_0_pop13_feedback.STALLFREE = 1;
defparam local_bb1_rows_727_0_push12_rows_726_0_pop13_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_727_0_push12_rows_726_0_pop13_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_727_0_push12_rows_726_0_pop13_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_727_0_push12_rows_726_0_pop13_feedback.STYLE = "REGULAR";

assign local_bb1_rows_727_0_push12_rows_726_0_pop13_inputs_ready = 1'b1;
assign local_bb1_rows_727_0_push12_rows_726_0_pop13_output_regs_ready = 1'b1;
assign rnode_166to167_bb1_rows_726_0_pop13__0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_727_0_push12_rows_726_0_pop13_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[5] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_727_0_push12_rows_726_0_pop13_NO_SHIFT_REG <= 'x;
		local_bb1_rows_727_0_push12_rows_726_0_pop13_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_727_0_push12_rows_726_0_pop13_output_regs_ready)
		begin
			local_bb1_rows_727_0_push12_rows_726_0_pop13_NO_SHIFT_REG <= local_bb1_rows_727_0_push12_rows_726_0_pop13_result;
			local_bb1_rows_727_0_push12_rows_726_0_pop13_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_727_0_push12_rows_726_0_pop13_stall_in))
			begin
				local_bb1_rows_727_0_push12_rows_726_0_pop13_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_7_1_stall_local;
wire local_bb1_cmp16_7_1;

assign local_bb1_cmp16_7_1 = (rnode_166to167_bb1_rows_726_0_pop13__1_NO_SHIFT_REG == 8'h0);

// This section implements a registered operation.
// 
wire local_bb1_rows_726_0_push13_rows_725_0_pop14_inputs_ready;
 reg local_bb1_rows_726_0_push13_rows_725_0_pop14_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_726_0_push13_rows_725_0_pop14_stall_in;
wire local_bb1_rows_726_0_push13_rows_725_0_pop14_output_regs_ready;
wire [7:0] local_bb1_rows_726_0_push13_rows_725_0_pop14_result;
wire local_bb1_rows_726_0_push13_rows_725_0_pop14_fu_valid_out;
wire local_bb1_rows_726_0_push13_rows_725_0_pop14_fu_stall_out;
 reg [7:0] local_bb1_rows_726_0_push13_rows_725_0_pop14_NO_SHIFT_REG;
wire local_bb1_rows_726_0_push13_rows_725_0_pop14_causedstall;

acl_push local_bb1_rows_726_0_push13_rows_725_0_pop14_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene2_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_725_0_pop14_),
	.stall_out(local_bb1_rows_726_0_push13_rows_725_0_pop14_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_726_0_push13_rows_725_0_pop14_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_726_0_push13_rows_725_0_pop14_result),
	.feedback_out(feedback_data_out_13),
	.feedback_valid_out(feedback_valid_out_13),
	.feedback_stall_in(feedback_stall_in_13)
);

defparam local_bb1_rows_726_0_push13_rows_725_0_pop14_feedback.STALLFREE = 1;
defparam local_bb1_rows_726_0_push13_rows_725_0_pop14_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_726_0_push13_rows_725_0_pop14_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_726_0_push13_rows_725_0_pop14_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_726_0_push13_rows_725_0_pop14_feedback.STYLE = "REGULAR";

assign local_bb1_rows_726_0_push13_rows_725_0_pop14_inputs_ready = 1'b1;
assign local_bb1_rows_726_0_push13_rows_725_0_pop14_output_regs_ready = 1'b1;
assign local_bb1_rows_725_0_pop14__stall_in_0 = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_726_0_push13_rows_725_0_pop14_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[4] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_726_0_push13_rows_725_0_pop14_NO_SHIFT_REG <= 'x;
		local_bb1_rows_726_0_push13_rows_725_0_pop14_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_726_0_push13_rows_725_0_pop14_output_regs_ready)
		begin
			local_bb1_rows_726_0_push13_rows_725_0_pop14_NO_SHIFT_REG <= local_bb1_rows_726_0_push13_rows_725_0_pop14_result;
			local_bb1_rows_726_0_push13_rows_725_0_pop14_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_726_0_push13_rows_725_0_pop14_stall_in))
			begin
				local_bb1_rows_726_0_push13_rows_725_0_pop14_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp16_6_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_6_1_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp16_6_1_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp16_6_1_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp16_6_1_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp16_6_1_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp16_6_1_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_6_1),
	.data_out(rnode_166to167_bb1_cmp16_6_1_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp16_6_1_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp16_6_1_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp16_6_1_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp16_6_1_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp16_6_1_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_6_1_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp16_6_1_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_6_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_6_1_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_6_1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp16_6_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_6_1_1_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_6_1_0_reg_167_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_725_0_push14_rows_724_0_pop15_inputs_ready;
 reg local_bb1_rows_725_0_push14_rows_724_0_pop15_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_725_0_push14_rows_724_0_pop15_stall_in;
wire local_bb1_rows_725_0_push14_rows_724_0_pop15_output_regs_ready;
wire [7:0] local_bb1_rows_725_0_push14_rows_724_0_pop15_result;
wire local_bb1_rows_725_0_push14_rows_724_0_pop15_fu_valid_out;
wire local_bb1_rows_725_0_push14_rows_724_0_pop15_fu_stall_out;
 reg [7:0] local_bb1_rows_725_0_push14_rows_724_0_pop15_NO_SHIFT_REG;
wire local_bb1_rows_725_0_push14_rows_724_0_pop15_causedstall;

acl_push local_bb1_rows_725_0_push14_rows_724_0_pop15_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene2_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_724_0_pop15_),
	.stall_out(local_bb1_rows_725_0_push14_rows_724_0_pop15_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_725_0_push14_rows_724_0_pop15_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_725_0_push14_rows_724_0_pop15_result),
	.feedback_out(feedback_data_out_14),
	.feedback_valid_out(feedback_valid_out_14),
	.feedback_stall_in(feedback_stall_in_14)
);

defparam local_bb1_rows_725_0_push14_rows_724_0_pop15_feedback.STALLFREE = 1;
defparam local_bb1_rows_725_0_push14_rows_724_0_pop15_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_725_0_push14_rows_724_0_pop15_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_725_0_push14_rows_724_0_pop15_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_725_0_push14_rows_724_0_pop15_feedback.STYLE = "REGULAR";

assign local_bb1_rows_725_0_push14_rows_724_0_pop15_inputs_ready = 1'b1;
assign local_bb1_rows_725_0_push14_rows_724_0_pop15_output_regs_ready = 1'b1;
assign local_bb1_rows_724_0_pop15__stall_in_0 = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_725_0_push14_rows_724_0_pop15_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[4] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_725_0_push14_rows_724_0_pop15_NO_SHIFT_REG <= 'x;
		local_bb1_rows_725_0_push14_rows_724_0_pop15_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_725_0_push14_rows_724_0_pop15_output_regs_ready)
		begin
			local_bb1_rows_725_0_push14_rows_724_0_pop15_NO_SHIFT_REG <= local_bb1_rows_725_0_push14_rows_724_0_pop15_result;
			local_bb1_rows_725_0_push14_rows_724_0_pop15_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_725_0_push14_rows_724_0_pop15_stall_in))
			begin
				local_bb1_rows_725_0_push14_rows_724_0_pop15_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp16_5_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_5_1_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp16_5_1_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp16_5_1_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp16_5_1_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp16_5_1_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp16_5_1_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_5_1),
	.data_out(rnode_166to167_bb1_cmp16_5_1_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp16_5_1_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp16_5_1_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp16_5_1_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp16_5_1_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp16_5_1_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_5_1_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp16_5_1_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_5_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_5_1_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_5_1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp16_5_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_5_1_1_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_5_1_0_reg_167_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_724_0_push15_rows_723_0_pop16_inputs_ready;
 reg local_bb1_rows_724_0_push15_rows_723_0_pop16_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_724_0_push15_rows_723_0_pop16_stall_in;
wire local_bb1_rows_724_0_push15_rows_723_0_pop16_output_regs_ready;
wire [7:0] local_bb1_rows_724_0_push15_rows_723_0_pop16_result;
wire local_bb1_rows_724_0_push15_rows_723_0_pop16_fu_valid_out;
wire local_bb1_rows_724_0_push15_rows_723_0_pop16_fu_stall_out;
 reg [7:0] local_bb1_rows_724_0_push15_rows_723_0_pop16_NO_SHIFT_REG;
wire local_bb1_rows_724_0_push15_rows_723_0_pop16_causedstall;

acl_push local_bb1_rows_724_0_push15_rows_723_0_pop16_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene2_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_723_0_pop16_),
	.stall_out(local_bb1_rows_724_0_push15_rows_723_0_pop16_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_724_0_push15_rows_723_0_pop16_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_724_0_push15_rows_723_0_pop16_result),
	.feedback_out(feedback_data_out_15),
	.feedback_valid_out(feedback_valid_out_15),
	.feedback_stall_in(feedback_stall_in_15)
);

defparam local_bb1_rows_724_0_push15_rows_723_0_pop16_feedback.STALLFREE = 1;
defparam local_bb1_rows_724_0_push15_rows_723_0_pop16_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_724_0_push15_rows_723_0_pop16_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_724_0_push15_rows_723_0_pop16_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_724_0_push15_rows_723_0_pop16_feedback.STYLE = "REGULAR";

assign local_bb1_rows_724_0_push15_rows_723_0_pop16_inputs_ready = 1'b1;
assign local_bb1_rows_724_0_push15_rows_723_0_pop16_output_regs_ready = 1'b1;
assign local_bb1_rows_723_0_pop16__stall_in_0 = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_724_0_push15_rows_723_0_pop16_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[4] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_724_0_push15_rows_723_0_pop16_NO_SHIFT_REG <= 'x;
		local_bb1_rows_724_0_push15_rows_723_0_pop16_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_724_0_push15_rows_723_0_pop16_output_regs_ready)
		begin
			local_bb1_rows_724_0_push15_rows_723_0_pop16_NO_SHIFT_REG <= local_bb1_rows_724_0_push15_rows_723_0_pop16_result;
			local_bb1_rows_724_0_push15_rows_723_0_pop16_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_724_0_push15_rows_723_0_pop16_stall_in))
			begin
				local_bb1_rows_724_0_push15_rows_723_0_pop16_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp16_4_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_4_1_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp16_4_1_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp16_4_1_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp16_4_1_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp16_4_1_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp16_4_1_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_4_1),
	.data_out(rnode_166to167_bb1_cmp16_4_1_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp16_4_1_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp16_4_1_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp16_4_1_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp16_4_1_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp16_4_1_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_4_1_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp16_4_1_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_4_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_4_1_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_4_1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp16_4_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_4_1_1_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_4_1_0_reg_167_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_723_0_push16_rows_722_0_pop17_inputs_ready;
 reg local_bb1_rows_723_0_push16_rows_722_0_pop17_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_723_0_push16_rows_722_0_pop17_stall_in;
wire local_bb1_rows_723_0_push16_rows_722_0_pop17_output_regs_ready;
wire [7:0] local_bb1_rows_723_0_push16_rows_722_0_pop17_result;
wire local_bb1_rows_723_0_push16_rows_722_0_pop17_fu_valid_out;
wire local_bb1_rows_723_0_push16_rows_722_0_pop17_fu_stall_out;
 reg [7:0] local_bb1_rows_723_0_push16_rows_722_0_pop17_NO_SHIFT_REG;
wire local_bb1_rows_723_0_push16_rows_722_0_pop17_causedstall;

acl_push local_bb1_rows_723_0_push16_rows_722_0_pop17_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene2_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_722_0_pop17_),
	.stall_out(local_bb1_rows_723_0_push16_rows_722_0_pop17_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_723_0_push16_rows_722_0_pop17_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_723_0_push16_rows_722_0_pop17_result),
	.feedback_out(feedback_data_out_16),
	.feedback_valid_out(feedback_valid_out_16),
	.feedback_stall_in(feedback_stall_in_16)
);

defparam local_bb1_rows_723_0_push16_rows_722_0_pop17_feedback.STALLFREE = 1;
defparam local_bb1_rows_723_0_push16_rows_722_0_pop17_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_723_0_push16_rows_722_0_pop17_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_723_0_push16_rows_722_0_pop17_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_723_0_push16_rows_722_0_pop17_feedback.STYLE = "REGULAR";

assign local_bb1_rows_723_0_push16_rows_722_0_pop17_inputs_ready = 1'b1;
assign local_bb1_rows_723_0_push16_rows_722_0_pop17_output_regs_ready = 1'b1;
assign local_bb1_rows_722_0_pop17__stall_in_0 = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_723_0_push16_rows_722_0_pop17_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[4] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_723_0_push16_rows_722_0_pop17_NO_SHIFT_REG <= 'x;
		local_bb1_rows_723_0_push16_rows_722_0_pop17_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_723_0_push16_rows_722_0_pop17_output_regs_ready)
		begin
			local_bb1_rows_723_0_push16_rows_722_0_pop17_NO_SHIFT_REG <= local_bb1_rows_723_0_push16_rows_722_0_pop17_result;
			local_bb1_rows_723_0_push16_rows_722_0_pop17_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_723_0_push16_rows_722_0_pop17_stall_in))
			begin
				local_bb1_rows_723_0_push16_rows_722_0_pop17_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp16_3_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_3_1_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp16_3_1_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp16_3_1_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp16_3_1_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp16_3_1_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp16_3_1_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_3_1),
	.data_out(rnode_166to167_bb1_cmp16_3_1_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp16_3_1_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp16_3_1_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp16_3_1_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp16_3_1_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp16_3_1_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_3_1_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp16_3_1_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_3_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_3_1_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_3_1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp16_3_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_3_1_1_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_3_1_0_reg_167_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_722_0_push17_rows_721_0_pop18_inputs_ready;
 reg local_bb1_rows_722_0_push17_rows_721_0_pop18_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_722_0_push17_rows_721_0_pop18_stall_in;
wire local_bb1_rows_722_0_push17_rows_721_0_pop18_output_regs_ready;
wire [7:0] local_bb1_rows_722_0_push17_rows_721_0_pop18_result;
wire local_bb1_rows_722_0_push17_rows_721_0_pop18_fu_valid_out;
wire local_bb1_rows_722_0_push17_rows_721_0_pop18_fu_stall_out;
 reg [7:0] local_bb1_rows_722_0_push17_rows_721_0_pop18_NO_SHIFT_REG;
wire local_bb1_rows_722_0_push17_rows_721_0_pop18_causedstall;

acl_push local_bb1_rows_722_0_push17_rows_721_0_pop18_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_165to166_bb1_c0_ene2_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_721_0_pop18_),
	.stall_out(local_bb1_rows_722_0_push17_rows_721_0_pop18_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[4]),
	.valid_out(local_bb1_rows_722_0_push17_rows_721_0_pop18_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_722_0_push17_rows_721_0_pop18_result),
	.feedback_out(feedback_data_out_17),
	.feedback_valid_out(feedback_valid_out_17),
	.feedback_stall_in(feedback_stall_in_17)
);

defparam local_bb1_rows_722_0_push17_rows_721_0_pop18_feedback.STALLFREE = 1;
defparam local_bb1_rows_722_0_push17_rows_721_0_pop18_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_722_0_push17_rows_721_0_pop18_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_722_0_push17_rows_721_0_pop18_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_722_0_push17_rows_721_0_pop18_feedback.STYLE = "REGULAR";

assign local_bb1_rows_722_0_push17_rows_721_0_pop18_inputs_ready = 1'b1;
assign local_bb1_rows_722_0_push17_rows_721_0_pop18_output_regs_ready = 1'b1;
assign local_bb1_rows_721_0_pop18__stall_in_0 = 1'b0;
assign rnode_165to166_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_722_0_push17_rows_721_0_pop18_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[4] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_722_0_push17_rows_721_0_pop18_NO_SHIFT_REG <= 'x;
		local_bb1_rows_722_0_push17_rows_721_0_pop18_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_722_0_push17_rows_721_0_pop18_output_regs_ready)
		begin
			local_bb1_rows_722_0_push17_rows_721_0_pop18_NO_SHIFT_REG <= local_bb1_rows_722_0_push17_rows_721_0_pop18_result;
			local_bb1_rows_722_0_push17_rows_721_0_pop18_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_722_0_push17_rows_721_0_pop18_stall_in))
			begin
				local_bb1_rows_722_0_push17_rows_721_0_pop18_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp16_2_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp16_2_1_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp16_2_1_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp16_2_1_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp16_2_1_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp16_2_1_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp16_2_1_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_2_1),
	.data_out(rnode_166to167_bb1_cmp16_2_1_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp16_2_1_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp16_2_1_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp16_2_1_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp16_2_1_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp16_2_1_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_2_1_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp16_2_1_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_2_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_2_1_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_2_1_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp16_2_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_cmp16_2_1_1_NO_SHIFT_REG = rnode_166to167_bb1_cmp16_2_1_0_reg_167_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_729_0_pop10__valid_out_0;
wire local_bb1_rows_729_0_pop10__stall_in_0;
 reg local_bb1_rows_729_0_pop10__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_10_1_valid_out;
wire local_bb1_cmp16_10_1_stall_in;
 reg local_bb1_cmp16_10_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_10_1_inputs_ready;
wire local_bb1_cmp16_10_1_stall_local;
wire local_bb1_cmp16_10_1;

assign local_bb1_cmp16_10_1_inputs_ready = rnode_166to167_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cmp16_10_1 = (local_bb1_rows_729_0_pop10_ == 8'h0);
assign local_bb1_rows_729_0_pop10__valid_out_0 = 1'b1;
assign local_bb1_cmp16_10_1_valid_out = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_729_0_pop10__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_10_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_729_0_pop10__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_10_1_inputs_ready & (local_bb1_rows_729_0_pop10__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_729_0_pop10__stall_in_0)) & local_bb1_cmp16_10_1_stall_local);
		local_bb1_cmp16_10_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_10_1_inputs_ready & (local_bb1_cmp16_10_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_10_1_stall_in)) & local_bb1_cmp16_10_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_rows_731_0_pop8__valid_out_0;
wire local_bb1_rows_731_0_pop8__stall_in_0;
 reg local_bb1_rows_731_0_pop8__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_12_1_valid_out;
wire local_bb1_cmp16_12_1_stall_in;
 reg local_bb1_cmp16_12_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_12_1_inputs_ready;
wire local_bb1_cmp16_12_1_stall_local;
wire local_bb1_cmp16_12_1;

assign local_bb1_cmp16_12_1_inputs_ready = rnode_166to167_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp16_12_1 = (local_bb1_rows_731_0_pop8_ == 8'h0);
assign local_bb1_rows_731_0_pop8__valid_out_0 = 1'b1;
assign local_bb1_cmp16_12_1_valid_out = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_731_0_pop8__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_12_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_731_0_pop8__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_12_1_inputs_ready & (local_bb1_rows_731_0_pop8__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_731_0_pop8__stall_in_0)) & local_bb1_cmp16_12_1_stall_local);
		local_bb1_cmp16_12_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_12_1_inputs_ready & (local_bb1_cmp16_12_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_12_1_stall_in)) & local_bb1_cmp16_12_1_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_732_0_pop7__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_732_0_pop7__0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_732_0_pop7__0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_732_0_pop7__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_732_0_pop7__0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_732_0_pop7__1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_732_0_pop7__0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_732_0_pop7__0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_732_0_pop7__0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_732_0_pop7__0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_732_0_pop7__0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_732_0_pop7__0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_732_0_pop7_),
	.data_out(rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_732_0_pop7__stall_in = 1'b0;
assign rnode_167to168_bb1_rows_732_0_pop7__0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_732_0_pop7__0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_732_0_pop7__0_NO_SHIFT_REG = rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_732_0_pop7__0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_732_0_pop7__1_NO_SHIFT_REG = rnode_167to168_bb1_rows_732_0_pop7__0_reg_168_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_730_0_pop9__valid_out_0;
wire local_bb1_rows_730_0_pop9__stall_in_0;
 reg local_bb1_rows_730_0_pop9__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_11_1_valid_out;
wire local_bb1_cmp16_11_1_stall_in;
 reg local_bb1_cmp16_11_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_11_1_inputs_ready;
wire local_bb1_cmp16_11_1_stall_local;
wire local_bb1_cmp16_11_1;

assign local_bb1_cmp16_11_1_inputs_ready = rnode_166to167_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1_cmp16_11_1 = (local_bb1_rows_730_0_pop9_ == 8'h0);
assign local_bb1_rows_730_0_pop9__valid_out_0 = 1'b1;
assign local_bb1_cmp16_11_1_valid_out = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_730_0_pop9__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_11_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_730_0_pop9__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_11_1_inputs_ready & (local_bb1_rows_730_0_pop9__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_730_0_pop9__stall_in_0)) & local_bb1_cmp16_11_1_stall_local);
		local_bb1_cmp16_11_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_11_1_inputs_ready & (local_bb1_cmp16_11_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_11_1_stall_in)) & local_bb1_cmp16_11_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_8_1_stall_local;
wire local_bb1_cmp16_8_1;

assign local_bb1_cmp16_8_1 = (local_bb1_rows_727_0_pop12_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_728_0_pop11__valid_out_0;
wire local_bb1_rows_728_0_pop11__stall_in_0;
 reg local_bb1_rows_728_0_pop11__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_9_1_valid_out;
wire local_bb1_cmp16_9_1_stall_in;
 reg local_bb1_cmp16_9_1_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_9_1_inputs_ready;
wire local_bb1_cmp16_9_1_stall_local;
wire local_bb1_cmp16_9_1;

assign local_bb1_cmp16_9_1_inputs_ready = rnode_166to167_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
assign local_bb1_cmp16_9_1 = (local_bb1_rows_728_0_pop11_ == 8'h0);
assign local_bb1_rows_728_0_pop11__valid_out_0 = 1'b1;
assign local_bb1_cmp16_9_1_valid_out = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_728_0_pop11__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_9_1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_728_0_pop11__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_9_1_inputs_ready & (local_bb1_rows_728_0_pop11__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_728_0_pop11__stall_in_0)) & local_bb1_cmp16_9_1_stall_local);
		local_bb1_cmp16_9_1_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_9_1_inputs_ready & (local_bb1_cmp16_9_1_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_9_1_stall_in)) & local_bb1_cmp16_9_1_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop40__stall_local;
wire [7:0] local_bb1__pop40_;
wire local_bb1__pop40__fu_valid_out;
wire local_bb1__pop40__fu_stall_out;

acl_pop local_bb1__pop40__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop40__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__pop40__fu_valid_out),
	.stall_in(local_bb1__pop40__stall_local),
	.data_out(local_bb1__pop40_),
	.feedback_in(feedback_data_in_40),
	.feedback_valid_in(feedback_valid_in_40),
	.feedback_stall_out(feedback_stall_out_40)
);

defparam local_bb1__pop40__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop40__feedback.STYLE = "REGULAR";

assign local_bb1__pop40__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop41__stall_local;
wire [7:0] local_bb1__pop41_;
wire local_bb1__pop41__fu_valid_out;
wire local_bb1__pop41__fu_stall_out;

acl_pop local_bb1__pop41__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop41__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__pop41__fu_valid_out),
	.stall_in(local_bb1__pop41__stall_local),
	.data_out(local_bb1__pop41_),
	.feedback_in(feedback_data_in_41),
	.feedback_valid_in(feedback_valid_in_41),
	.feedback_stall_out(feedback_stall_out_41)
);

defparam local_bb1__pop41__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop41__feedback.STYLE = "REGULAR";

assign local_bb1__pop41__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop42__valid_out;
wire local_bb1__pop42__stall_in;
wire local_bb1__pop42__inputs_ready;
wire local_bb1__pop42__stall_local;
wire [7:0] local_bb1__pop42_;
wire local_bb1__pop42__fu_valid_out;
wire local_bb1__pop42__fu_stall_out;

acl_pop local_bb1__pop42__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop42__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__pop42__fu_valid_out),
	.stall_in(local_bb1__pop42__stall_local),
	.data_out(local_bb1__pop42_),
	.feedback_in(feedback_data_in_42),
	.feedback_valid_in(feedback_valid_in_42),
	.feedback_stall_out(feedback_stall_out_42)
);

defparam local_bb1__pop42__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop42__feedback.STYLE = "REGULAR";

assign local_bb1__pop42__inputs_ready = rnode_167to168_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1__pop42__stall_local = 1'b0;
assign local_bb1__pop42__valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop36__valid_out;
wire local_bb1__pop36__stall_in;
wire local_bb1__pop36__inputs_ready;
wire local_bb1__pop36__stall_local;
wire [7:0] local_bb1__pop36_;
wire local_bb1__pop36__fu_valid_out;
wire local_bb1__pop36__fu_stall_out;

acl_pop local_bb1__pop36__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop36__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__pop36__fu_valid_out),
	.stall_in(local_bb1__pop36__stall_local),
	.data_out(local_bb1__pop36_),
	.feedback_in(feedback_data_in_36),
	.feedback_valid_in(feedback_valid_in_36),
	.feedback_stall_out(feedback_stall_out_36)
);

defparam local_bb1__pop36__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop36__feedback.STYLE = "REGULAR";

assign local_bb1__pop36__inputs_ready = rnode_167to168_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1__pop36__stall_local = 1'b0;
assign local_bb1__pop36__valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop37__stall_local;
wire [7:0] local_bb1__pop37_;
wire local_bb1__pop37__fu_valid_out;
wire local_bb1__pop37__fu_stall_out;

acl_pop local_bb1__pop37__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop37__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__pop37__fu_valid_out),
	.stall_in(local_bb1__pop37__stall_local),
	.data_out(local_bb1__pop37_),
	.feedback_in(feedback_data_in_37),
	.feedback_valid_in(feedback_valid_in_37),
	.feedback_stall_out(feedback_stall_out_37)
);

defparam local_bb1__pop37__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop37__feedback.STYLE = "REGULAR";

assign local_bb1__pop37__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop38__stall_local;
wire [7:0] local_bb1__pop38_;
wire local_bb1__pop38__fu_valid_out;
wire local_bb1__pop38__fu_stall_out;

acl_pop local_bb1__pop38__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop38__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__pop38__fu_valid_out),
	.stall_in(local_bb1__pop38__stall_local),
	.data_out(local_bb1__pop38_),
	.feedback_in(feedback_data_in_38),
	.feedback_valid_in(feedback_valid_in_38),
	.feedback_stall_out(feedback_stall_out_38)
);

defparam local_bb1__pop38__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop38__feedback.STYLE = "REGULAR";

assign local_bb1__pop38__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop39__stall_local;
wire [7:0] local_bb1__pop39_;
wire local_bb1__pop39__fu_valid_out;
wire local_bb1__pop39__fu_stall_out;

acl_pop local_bb1__pop39__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_6_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop39__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__pop39__fu_valid_out),
	.stall_in(local_bb1__pop39__stall_local),
	.data_out(local_bb1__pop39_),
	.feedback_in(feedback_data_in_39),
	.feedback_valid_in(feedback_valid_in_39),
	.feedback_stall_out(feedback_stall_out_39)
);

defparam local_bb1__pop39__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop39__feedback.STYLE = "REGULAR";

assign local_bb1__pop39__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_733_0_pop6__stall_local;
wire [7:0] local_bb1_rows_733_0_pop6_;
wire local_bb1_rows_733_0_pop6__fu_valid_out;
wire local_bb1_rows_733_0_pop6__fu_stall_out;

acl_pop local_bb1_rows_733_0_pop6__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_7_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_733_0_pop6__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1_rows_733_0_pop6__fu_valid_out),
	.stall_in(local_bb1_rows_733_0_pop6__stall_local),
	.data_out(local_bb1_rows_733_0_pop6_),
	.feedback_in(feedback_data_in_6),
	.feedback_valid_in(feedback_valid_in_6),
	.feedback_stall_out(feedback_stall_out_6)
);

defparam local_bb1_rows_733_0_pop6__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_733_0_pop6__feedback.STYLE = "REGULAR";

assign local_bb1_rows_733_0_pop6__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_734_0_pop5__stall_local;
wire [7:0] local_bb1_rows_734_0_pop5_;
wire local_bb1_rows_734_0_pop5__fu_valid_out;
wire local_bb1_rows_734_0_pop5__fu_stall_out;

acl_pop local_bb1_rows_734_0_pop5__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_8_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_734_0_pop5__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1_rows_734_0_pop5__fu_valid_out),
	.stall_in(local_bb1_rows_734_0_pop5__stall_local),
	.data_out(local_bb1_rows_734_0_pop5_),
	.feedback_in(feedback_data_in_5),
	.feedback_valid_in(feedback_valid_in_5),
	.feedback_stall_out(feedback_stall_out_5)
);

defparam local_bb1_rows_734_0_pop5__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_734_0_pop5__feedback.STYLE = "REGULAR";

assign local_bb1_rows_734_0_pop5__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_rows_735_0_pop4__stall_local;
wire [7:0] local_bb1_rows_735_0_pop4_;
wire local_bb1_rows_735_0_pop4__fu_valid_out;
wire local_bb1_rows_735_0_pop4__fu_stall_out;

acl_pop local_bb1_rows_735_0_pop4__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene1_9_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1_rows_735_0_pop4__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1_rows_735_0_pop4__fu_valid_out),
	.stall_in(local_bb1_rows_735_0_pop4__stall_local),
	.data_out(local_bb1_rows_735_0_pop4_),
	.feedback_in(feedback_data_in_4),
	.feedback_valid_in(feedback_valid_in_4),
	.feedback_stall_out(feedback_stall_out_4)
);

defparam local_bb1_rows_735_0_pop4__feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_735_0_pop4__feedback.STYLE = "REGULAR";

assign local_bb1_rows_735_0_pop4__stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_2_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_3_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_4_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_5_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_6_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene1_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_c0_ene1_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_c0_ene1_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_c0_ene1_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_c0_ene1_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_c0_ene1_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_c0_ene1_10_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_c0_ene1_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_c0_ene1_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_c0_ene1_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_c0_ene1_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_c0_ene1_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_10_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_2_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_3_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_4_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_5_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_6_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene1_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_2_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_3_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_4_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_5_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_6_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_7_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_c0_ene2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_c0_ene2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_c0_ene2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_c0_ene2_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_c0_ene2_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_c0_ene2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_c0_ene2_9_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_c0_ene2_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_c0_ene2_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_c0_ene2_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_c0_ene2_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_c0_ene2_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_9_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_0_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_1_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_2_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_3_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_4_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_5_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_5_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_6_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_6_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_c0_ene2_0_valid_out_7_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_7_NO_SHIFT_REG = rnode_168to169_bb1_c0_ene2_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to170_bb1_rows_0_0_push35_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__335_stall_local;
wire [7:0] local_bb1__335;

assign local_bb1__335 = (local_bb1__334_demorgan ? local_bb1__333 : 8'h0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to170_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to170_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG),
	.data_out(rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_fifo.DEPTH = 2;
defparam rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG = rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_170_NO_SHIFT_REG;
assign rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_12_0_push23_rows_11_0_pop24_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_12_0_push23_rows_11_0_pop24_stall_in = 1'b0;
assign rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG = rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_not_select6_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_not_select6_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to166_bb1_not_select6_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_not_select6_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_not_select6_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_not_select6_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_not_select6_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_not_select6_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_not_select6_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_not_select6_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_not_select6_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_not_select6_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_not_select6_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_not_select6),
	.data_out(rnode_165to166_bb1_not_select6_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_not_select6_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_not_select6_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_not_select6_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_not_select6_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_not_select6_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_not_select6_stall_in_1 = 1'b0;
assign rnode_165to166_bb1_not_select6_0_NO_SHIFT_REG = rnode_165to166_bb1_not_select6_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_not_select6_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_not_select6_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_coalesce_counter_push54_next_coalesce_inputs_ready;
 reg local_bb1_coalesce_counter_push54_next_coalesce_valid_out_NO_SHIFT_REG;
wire local_bb1_coalesce_counter_push54_next_coalesce_stall_in;
wire local_bb1_coalesce_counter_push54_next_coalesce_output_regs_ready;
wire [10:0] local_bb1_coalesce_counter_push54_next_coalesce_result;
wire local_bb1_coalesce_counter_push54_next_coalesce_fu_valid_out;
wire local_bb1_coalesce_counter_push54_next_coalesce_fu_stall_out;
 reg [10:0] local_bb1_coalesce_counter_push54_next_coalesce_NO_SHIFT_REG;
wire local_bb1_coalesce_counter_push54_next_coalesce_causedstall;

acl_push local_bb1_coalesce_counter_push54_next_coalesce_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_9_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_next_coalesce),
	.stall_out(local_bb1_coalesce_counter_push54_next_coalesce_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_coalesce_counter_push54_next_coalesce_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_coalesce_counter_push54_next_coalesce_result),
	.feedback_out(feedback_data_out_54),
	.feedback_valid_out(feedback_valid_out_54),
	.feedback_stall_in(feedback_stall_in_54)
);

defparam local_bb1_coalesce_counter_push54_next_coalesce_feedback.STALLFREE = 1;
defparam local_bb1_coalesce_counter_push54_next_coalesce_feedback.DATA_WIDTH = 11;
defparam local_bb1_coalesce_counter_push54_next_coalesce_feedback.FIFO_DEPTH = 1;
defparam local_bb1_coalesce_counter_push54_next_coalesce_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_coalesce_counter_push54_next_coalesce_feedback.STYLE = "REGULAR";

assign local_bb1_coalesce_counter_push54_next_coalesce_inputs_ready = 1'b1;
assign local_bb1_coalesce_counter_push54_next_coalesce_output_regs_ready = 1'b1;
assign local_bb1_next_coalesce_stall_in = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_9_NO_SHIFT_REG = 1'b0;
assign local_bb1_coalesce_counter_push54_next_coalesce_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_coalesce_counter_push54_next_coalesce_NO_SHIFT_REG <= 'x;
		local_bb1_coalesce_counter_push54_next_coalesce_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_coalesce_counter_push54_next_coalesce_output_regs_ready)
		begin
			local_bb1_coalesce_counter_push54_next_coalesce_NO_SHIFT_REG <= local_bb1_coalesce_counter_push54_next_coalesce_result;
			local_bb1_coalesce_counter_push54_next_coalesce_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_coalesce_counter_push54_next_coalesce_stall_in))
			begin
				local_bb1_coalesce_counter_push54_next_coalesce_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_inputs_ready;
 reg local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_stall_in;
wire local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_output_regs_ready;
wire [7:0] local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_result;
wire local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_fu_valid_out;
wire local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_fu_stall_out;
 reg [7:0] local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_NO_SHIFT_REG;
wire local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_causedstall;

acl_push local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_10_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_719_0_coalesced_pop3_),
	.stall_out(local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_result),
	.feedback_out(feedback_data_out_19),
	.feedback_valid_out(feedback_valid_out_19),
	.feedback_stall_in(feedback_stall_in_19)
);

defparam local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_feedback.STALLFREE = 1;
defparam local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_feedback.STYLE = "REGULAR";

assign local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_inputs_ready = 1'b1;
assign local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_output_regs_ready = 1'b1;
assign local_bb1_rows_719_0_coalesced_pop3__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_10_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_NO_SHIFT_REG <= 'x;
		local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_output_regs_ready)
		begin
			local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_NO_SHIFT_REG <= local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_result;
			local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_stall_in))
			begin
				local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_cmp16_121_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_cmp16_121_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_cmp16_121_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_cmp16_121_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_cmp16_121_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_cmp16_121_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_cmp16_121_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_121),
	.data_out(rnode_165to166_bb1_cmp16_121_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_cmp16_121_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_cmp16_121_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_cmp16_121_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_cmp16_121_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_cmp16_121_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_121_stall_in = 1'b0;
assign rnode_165to166_bb1_cmp16_121_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_121_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_121_0_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_121_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_cmp16_121_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_cmp16_121_1_NO_SHIFT_REG = rnode_165to166_bb1_cmp16_121_0_reg_166_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_rows_727_0_push12_rows_726_0_pop13_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_727_0_push12_rows_726_0_pop13_stall_in = 1'b0;
assign rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG = rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_7_1_stall_local;
wire local_bb1_not_cmp16_7_1;

assign local_bb1_not_cmp16_7_1 = (local_bb1_cmp16_7_1 ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_726_0_push13_rows_725_0_pop14_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_726_0_push13_rows_725_0_pop14_stall_in = 1'b0;
assign rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG = rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_6_1_stall_local;
wire local_bb1_not_cmp16_6_1;

assign local_bb1_not_cmp16_6_1 = (rnode_166to167_bb1_cmp16_6_1_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_725_0_push14_rows_724_0_pop15_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_725_0_push14_rows_724_0_pop15_stall_in = 1'b0;
assign rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG = rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_5_1_stall_local;
wire local_bb1_not_cmp16_5_1;

assign local_bb1_not_cmp16_5_1 = (rnode_166to167_bb1_cmp16_5_1_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_724_0_push15_rows_723_0_pop16_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_724_0_push15_rows_723_0_pop16_stall_in = 1'b0;
assign rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG = rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_4_1_stall_local;
wire local_bb1_not_cmp16_4_1;

assign local_bb1_not_cmp16_4_1 = (rnode_166to167_bb1_cmp16_4_1_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_723_0_push16_rows_722_0_pop17_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_723_0_push16_rows_722_0_pop17_stall_in = 1'b0;
assign rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG = rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_3_1_stall_local;
wire local_bb1_not_cmp16_3_1;

assign local_bb1_not_cmp16_3_1 = (rnode_166to167_bb1_cmp16_3_1_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_rows_722_0_push17_rows_721_0_pop18_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_722_0_push17_rows_721_0_pop18_stall_in = 1'b0;
assign rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG = rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_2_1_stall_local;
wire local_bb1_not_cmp16_2_1;

assign local_bb1_not_cmp16_2_1 = (rnode_166to167_bb1_cmp16_2_1_1_NO_SHIFT_REG ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1_rows_730_0_push9_rows_729_0_pop10_inputs_ready;
 reg local_bb1_rows_730_0_push9_rows_729_0_pop10_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_730_0_push9_rows_729_0_pop10_stall_in;
wire local_bb1_rows_730_0_push9_rows_729_0_pop10_output_regs_ready;
wire [7:0] local_bb1_rows_730_0_push9_rows_729_0_pop10_result;
wire local_bb1_rows_730_0_push9_rows_729_0_pop10_fu_valid_out;
wire local_bb1_rows_730_0_push9_rows_729_0_pop10_fu_stall_out;
 reg [7:0] local_bb1_rows_730_0_push9_rows_729_0_pop10_NO_SHIFT_REG;
wire local_bb1_rows_730_0_push9_rows_729_0_pop10_causedstall;

acl_push local_bb1_rows_730_0_push9_rows_729_0_pop10_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene2_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_729_0_pop10_),
	.stall_out(local_bb1_rows_730_0_push9_rows_729_0_pop10_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_730_0_push9_rows_729_0_pop10_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_730_0_push9_rows_729_0_pop10_result),
	.feedback_out(feedback_data_out_9),
	.feedback_valid_out(feedback_valid_out_9),
	.feedback_stall_in(feedback_stall_in_9)
);

defparam local_bb1_rows_730_0_push9_rows_729_0_pop10_feedback.STALLFREE = 1;
defparam local_bb1_rows_730_0_push9_rows_729_0_pop10_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_730_0_push9_rows_729_0_pop10_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_730_0_push9_rows_729_0_pop10_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_730_0_push9_rows_729_0_pop10_feedback.STYLE = "REGULAR";

assign local_bb1_rows_730_0_push9_rows_729_0_pop10_inputs_ready = 1'b1;
assign local_bb1_rows_730_0_push9_rows_729_0_pop10_output_regs_ready = 1'b1;
assign local_bb1_rows_729_0_pop10__stall_in_0 = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_730_0_push9_rows_729_0_pop10_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[5] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_730_0_push9_rows_729_0_pop10_NO_SHIFT_REG <= 'x;
		local_bb1_rows_730_0_push9_rows_729_0_pop10_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_730_0_push9_rows_729_0_pop10_output_regs_ready)
		begin
			local_bb1_rows_730_0_push9_rows_729_0_pop10_NO_SHIFT_REG <= local_bb1_rows_730_0_push9_rows_729_0_pop10_result;
			local_bb1_rows_730_0_push9_rows_729_0_pop10_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_730_0_push9_rows_729_0_pop10_stall_in))
			begin
				local_bb1_rows_730_0_push9_rows_729_0_pop10_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_cmp16_10_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_10_1_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_cmp16_10_1_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_cmp16_10_1_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_cmp16_10_1_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_cmp16_10_1_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_cmp16_10_1_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_10_1),
	.data_out(rnode_167to168_bb1_cmp16_10_1_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_cmp16_10_1_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_cmp16_10_1_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb1_cmp16_10_1_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_cmp16_10_1_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_cmp16_10_1_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_10_1_stall_in = 1'b0;
assign rnode_167to168_bb1_cmp16_10_1_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_10_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_10_1_0_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_10_1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_cmp16_10_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_10_1_1_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_10_1_0_reg_168_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_732_0_push7_rows_731_0_pop8_inputs_ready;
 reg local_bb1_rows_732_0_push7_rows_731_0_pop8_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_732_0_push7_rows_731_0_pop8_stall_in;
wire local_bb1_rows_732_0_push7_rows_731_0_pop8_output_regs_ready;
wire [7:0] local_bb1_rows_732_0_push7_rows_731_0_pop8_result;
wire local_bb1_rows_732_0_push7_rows_731_0_pop8_fu_valid_out;
wire local_bb1_rows_732_0_push7_rows_731_0_pop8_fu_stall_out;
 reg [7:0] local_bb1_rows_732_0_push7_rows_731_0_pop8_NO_SHIFT_REG;
wire local_bb1_rows_732_0_push7_rows_731_0_pop8_causedstall;

acl_push local_bb1_rows_732_0_push7_rows_731_0_pop8_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene2_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_731_0_pop8_),
	.stall_out(local_bb1_rows_732_0_push7_rows_731_0_pop8_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_732_0_push7_rows_731_0_pop8_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_732_0_push7_rows_731_0_pop8_result),
	.feedback_out(feedback_data_out_7),
	.feedback_valid_out(feedback_valid_out_7),
	.feedback_stall_in(feedback_stall_in_7)
);

defparam local_bb1_rows_732_0_push7_rows_731_0_pop8_feedback.STALLFREE = 1;
defparam local_bb1_rows_732_0_push7_rows_731_0_pop8_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_732_0_push7_rows_731_0_pop8_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_732_0_push7_rows_731_0_pop8_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_732_0_push7_rows_731_0_pop8_feedback.STYLE = "REGULAR";

assign local_bb1_rows_732_0_push7_rows_731_0_pop8_inputs_ready = 1'b1;
assign local_bb1_rows_732_0_push7_rows_731_0_pop8_output_regs_ready = 1'b1;
assign local_bb1_rows_731_0_pop8__stall_in_0 = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_732_0_push7_rows_731_0_pop8_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[5] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_732_0_push7_rows_731_0_pop8_NO_SHIFT_REG <= 'x;
		local_bb1_rows_732_0_push7_rows_731_0_pop8_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_732_0_push7_rows_731_0_pop8_output_regs_ready)
		begin
			local_bb1_rows_732_0_push7_rows_731_0_pop8_NO_SHIFT_REG <= local_bb1_rows_732_0_push7_rows_731_0_pop8_result;
			local_bb1_rows_732_0_push7_rows_731_0_pop8_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_732_0_push7_rows_731_0_pop8_stall_in))
			begin
				local_bb1_rows_732_0_push7_rows_731_0_pop8_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_cmp16_12_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_12_1_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_cmp16_12_1_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_cmp16_12_1_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_cmp16_12_1_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_cmp16_12_1_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_cmp16_12_1_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_12_1),
	.data_out(rnode_167to168_bb1_cmp16_12_1_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_cmp16_12_1_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_cmp16_12_1_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb1_cmp16_12_1_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_cmp16_12_1_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_cmp16_12_1_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_12_1_stall_in = 1'b0;
assign rnode_167to168_bb1_cmp16_12_1_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_12_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_12_1_0_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_12_1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_cmp16_12_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_12_1_1_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_12_1_0_reg_168_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_rows_733_0_push6_rows_732_0_pop7_inputs_ready;
 reg local_bb1_rows_733_0_push6_rows_732_0_pop7_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_733_0_push6_rows_732_0_pop7_stall_in;
wire local_bb1_rows_733_0_push6_rows_732_0_pop7_output_regs_ready;
wire [7:0] local_bb1_rows_733_0_push6_rows_732_0_pop7_result;
wire local_bb1_rows_733_0_push6_rows_732_0_pop7_fu_valid_out;
wire local_bb1_rows_733_0_push6_rows_732_0_pop7_fu_stall_out;
 reg [7:0] local_bb1_rows_733_0_push6_rows_732_0_pop7_NO_SHIFT_REG;
wire local_bb1_rows_733_0_push6_rows_732_0_pop7_causedstall;

acl_push local_bb1_rows_733_0_push6_rows_732_0_pop7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_167to168_bb1_rows_732_0_pop7__0_NO_SHIFT_REG),
	.stall_out(local_bb1_rows_733_0_push6_rows_732_0_pop7_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1_rows_733_0_push6_rows_732_0_pop7_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_733_0_push6_rows_732_0_pop7_result),
	.feedback_out(feedback_data_out_6),
	.feedback_valid_out(feedback_valid_out_6),
	.feedback_stall_in(feedback_stall_in_6)
);

defparam local_bb1_rows_733_0_push6_rows_732_0_pop7_feedback.STALLFREE = 1;
defparam local_bb1_rows_733_0_push6_rows_732_0_pop7_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_733_0_push6_rows_732_0_pop7_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_733_0_push6_rows_732_0_pop7_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_733_0_push6_rows_732_0_pop7_feedback.STYLE = "REGULAR";

assign local_bb1_rows_733_0_push6_rows_732_0_pop7_inputs_ready = 1'b1;
assign local_bb1_rows_733_0_push6_rows_732_0_pop7_output_regs_ready = 1'b1;
assign rnode_167to168_bb1_rows_732_0_pop7__0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_733_0_push6_rows_732_0_pop7_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_733_0_push6_rows_732_0_pop7_NO_SHIFT_REG <= 'x;
		local_bb1_rows_733_0_push6_rows_732_0_pop7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_733_0_push6_rows_732_0_pop7_output_regs_ready)
		begin
			local_bb1_rows_733_0_push6_rows_732_0_pop7_NO_SHIFT_REG <= local_bb1_rows_733_0_push6_rows_732_0_pop7_result;
			local_bb1_rows_733_0_push6_rows_732_0_pop7_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_733_0_push6_rows_732_0_pop7_stall_in))
			begin
				local_bb1_rows_733_0_push6_rows_732_0_pop7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_13_1_stall_local;
wire local_bb1_cmp16_13_1;

assign local_bb1_cmp16_13_1 = (rnode_167to168_bb1_rows_732_0_pop7__1_NO_SHIFT_REG == 8'h0);

// This section implements a registered operation.
// 
wire local_bb1_rows_731_0_push8_rows_730_0_pop9_inputs_ready;
 reg local_bb1_rows_731_0_push8_rows_730_0_pop9_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_731_0_push8_rows_730_0_pop9_stall_in;
wire local_bb1_rows_731_0_push8_rows_730_0_pop9_output_regs_ready;
wire [7:0] local_bb1_rows_731_0_push8_rows_730_0_pop9_result;
wire local_bb1_rows_731_0_push8_rows_730_0_pop9_fu_valid_out;
wire local_bb1_rows_731_0_push8_rows_730_0_pop9_fu_stall_out;
 reg [7:0] local_bb1_rows_731_0_push8_rows_730_0_pop9_NO_SHIFT_REG;
wire local_bb1_rows_731_0_push8_rows_730_0_pop9_causedstall;

acl_push local_bb1_rows_731_0_push8_rows_730_0_pop9_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene2_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_730_0_pop9_),
	.stall_out(local_bb1_rows_731_0_push8_rows_730_0_pop9_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_731_0_push8_rows_730_0_pop9_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_731_0_push8_rows_730_0_pop9_result),
	.feedback_out(feedback_data_out_8),
	.feedback_valid_out(feedback_valid_out_8),
	.feedback_stall_in(feedback_stall_in_8)
);

defparam local_bb1_rows_731_0_push8_rows_730_0_pop9_feedback.STALLFREE = 1;
defparam local_bb1_rows_731_0_push8_rows_730_0_pop9_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_731_0_push8_rows_730_0_pop9_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_731_0_push8_rows_730_0_pop9_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_731_0_push8_rows_730_0_pop9_feedback.STYLE = "REGULAR";

assign local_bb1_rows_731_0_push8_rows_730_0_pop9_inputs_ready = 1'b1;
assign local_bb1_rows_731_0_push8_rows_730_0_pop9_output_regs_ready = 1'b1;
assign local_bb1_rows_730_0_pop9__stall_in_0 = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_731_0_push8_rows_730_0_pop9_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[5] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_731_0_push8_rows_730_0_pop9_NO_SHIFT_REG <= 'x;
		local_bb1_rows_731_0_push8_rows_730_0_pop9_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_731_0_push8_rows_730_0_pop9_output_regs_ready)
		begin
			local_bb1_rows_731_0_push8_rows_730_0_pop9_NO_SHIFT_REG <= local_bb1_rows_731_0_push8_rows_730_0_pop9_result;
			local_bb1_rows_731_0_push8_rows_730_0_pop9_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_731_0_push8_rows_730_0_pop9_stall_in))
			begin
				local_bb1_rows_731_0_push8_rows_730_0_pop9_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_cmp16_11_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_11_1_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_cmp16_11_1_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_cmp16_11_1_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_cmp16_11_1_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_cmp16_11_1_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_cmp16_11_1_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_11_1),
	.data_out(rnode_167to168_bb1_cmp16_11_1_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_cmp16_11_1_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_cmp16_11_1_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb1_cmp16_11_1_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_cmp16_11_1_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_cmp16_11_1_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_11_1_stall_in = 1'b0;
assign rnode_167to168_bb1_cmp16_11_1_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_11_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_11_1_0_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_11_1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_cmp16_11_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_11_1_1_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_11_1_0_reg_168_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_8_1_stall_local;
wire local_bb1_not_cmp16_8_1;

assign local_bb1_not_cmp16_8_1 = (local_bb1_cmp16_8_1 ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1_rows_729_0_push10_rows_728_0_pop11_inputs_ready;
 reg local_bb1_rows_729_0_push10_rows_728_0_pop11_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_729_0_push10_rows_728_0_pop11_stall_in;
wire local_bb1_rows_729_0_push10_rows_728_0_pop11_output_regs_ready;
wire [7:0] local_bb1_rows_729_0_push10_rows_728_0_pop11_result;
wire local_bb1_rows_729_0_push10_rows_728_0_pop11_fu_valid_out;
wire local_bb1_rows_729_0_push10_rows_728_0_pop11_fu_stall_out;
 reg [7:0] local_bb1_rows_729_0_push10_rows_728_0_pop11_NO_SHIFT_REG;
wire local_bb1_rows_729_0_push10_rows_728_0_pop11_causedstall;

acl_push local_bb1_rows_729_0_push10_rows_728_0_pop11_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene2_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_728_0_pop11_),
	.stall_out(local_bb1_rows_729_0_push10_rows_728_0_pop11_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_729_0_push10_rows_728_0_pop11_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_729_0_push10_rows_728_0_pop11_result),
	.feedback_out(feedback_data_out_10),
	.feedback_valid_out(feedback_valid_out_10),
	.feedback_stall_in(feedback_stall_in_10)
);

defparam local_bb1_rows_729_0_push10_rows_728_0_pop11_feedback.STALLFREE = 1;
defparam local_bb1_rows_729_0_push10_rows_728_0_pop11_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_729_0_push10_rows_728_0_pop11_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_729_0_push10_rows_728_0_pop11_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_729_0_push10_rows_728_0_pop11_feedback.STYLE = "REGULAR";

assign local_bb1_rows_729_0_push10_rows_728_0_pop11_inputs_ready = 1'b1;
assign local_bb1_rows_729_0_push10_rows_728_0_pop11_output_regs_ready = 1'b1;
assign local_bb1_rows_728_0_pop11__stall_in_0 = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_729_0_push10_rows_728_0_pop11_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[5] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_729_0_push10_rows_728_0_pop11_NO_SHIFT_REG <= 'x;
		local_bb1_rows_729_0_push10_rows_728_0_pop11_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_729_0_push10_rows_728_0_pop11_output_regs_ready)
		begin
			local_bb1_rows_729_0_push10_rows_728_0_pop11_NO_SHIFT_REG <= local_bb1_rows_729_0_push10_rows_728_0_pop11_result;
			local_bb1_rows_729_0_push10_rows_728_0_pop11_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_729_0_push10_rows_728_0_pop11_stall_in))
			begin
				local_bb1_rows_729_0_push10_rows_728_0_pop11_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_cmp16_9_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_cmp16_9_1_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_cmp16_9_1_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_cmp16_9_1_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_cmp16_9_1_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_cmp16_9_1_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_cmp16_9_1_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_9_1),
	.data_out(rnode_167to168_bb1_cmp16_9_1_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_cmp16_9_1_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_cmp16_9_1_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb1_cmp16_9_1_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_cmp16_9_1_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_cmp16_9_1_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_9_1_stall_in = 1'b0;
assign rnode_167to168_bb1_cmp16_9_1_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_9_1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_9_1_0_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_9_1_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_cmp16_9_1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_cmp16_9_1_1_NO_SHIFT_REG = rnode_167to168_bb1_cmp16_9_1_0_reg_168_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1__pop40__valid_out_0;
wire local_bb1__pop40__stall_in_0;
 reg local_bb1__pop40__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_5_2_valid_out;
wire local_bb1_cmp16_5_2_stall_in;
 reg local_bb1_cmp16_5_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_5_2_inputs_ready;
wire local_bb1_cmp16_5_2_stall_local;
wire local_bb1_cmp16_5_2;

assign local_bb1_cmp16_5_2_inputs_ready = rnode_167to168_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cmp16_5_2 = (local_bb1__pop40_ == 8'h0);
assign local_bb1__pop40__valid_out_0 = 1'b1;
assign local_bb1_cmp16_5_2_valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop40__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_5_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop40__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_5_2_inputs_ready & (local_bb1__pop40__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop40__stall_in_0)) & local_bb1_cmp16_5_2_stall_local);
		local_bb1_cmp16_5_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_5_2_inputs_ready & (local_bb1_cmp16_5_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_5_2_stall_in)) & local_bb1_cmp16_5_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop41__valid_out_0;
wire local_bb1__pop41__stall_in_0;
 reg local_bb1__pop41__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_6_2_valid_out;
wire local_bb1_cmp16_6_2_stall_in;
 reg local_bb1_cmp16_6_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_6_2_inputs_ready;
wire local_bb1_cmp16_6_2_stall_local;
wire local_bb1_cmp16_6_2;

assign local_bb1_cmp16_6_2_inputs_ready = rnode_167to168_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp16_6_2 = (local_bb1__pop41_ == 8'h0);
assign local_bb1__pop41__valid_out_0 = 1'b1;
assign local_bb1_cmp16_6_2_valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop41__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_6_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop41__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_6_2_inputs_ready & (local_bb1__pop41__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop41__stall_in_0)) & local_bb1_cmp16_6_2_stall_local);
		local_bb1_cmp16_6_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_6_2_inputs_ready & (local_bb1_cmp16_6_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_6_2_stall_in)) & local_bb1_cmp16_6_2_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1__pop42__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop42__0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__pop42__0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop42__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop42__0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__pop42__1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop42__0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__pop42__0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop42__0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop42__0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop42__0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1__pop42__0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1__pop42__0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1__pop42__0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1__pop42__0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1__pop42__0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1__pop42_),
	.data_out(rnode_168to169_bb1__pop42__0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1__pop42__0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1__pop42__0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1__pop42__0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1__pop42__0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1__pop42__0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__pop42__stall_in = 1'b0;
assign rnode_168to169_bb1__pop42__0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__pop42__0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__pop42__0_NO_SHIFT_REG = rnode_168to169_bb1__pop42__0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1__pop42__0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__pop42__1_NO_SHIFT_REG = rnode_168to169_bb1__pop42__0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1__pop36__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop36__0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__pop36__0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop36__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop36__0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__pop36__1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop36__0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__pop36__0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop36__0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop36__0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__pop36__0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1__pop36__0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1__pop36__0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1__pop36__0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1__pop36__0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1__pop36__0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1__pop36_),
	.data_out(rnode_168to169_bb1__pop36__0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1__pop36__0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1__pop36__0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1__pop36__0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1__pop36__0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1__pop36__0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__pop36__stall_in = 1'b0;
assign rnode_168to169_bb1__pop36__0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__pop36__0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__pop36__0_NO_SHIFT_REG = rnode_168to169_bb1__pop36__0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1__pop36__0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__pop36__1_NO_SHIFT_REG = rnode_168to169_bb1__pop36__0_reg_169_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1__pop37__valid_out_0;
wire local_bb1__pop37__stall_in_0;
 reg local_bb1__pop37__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_2_2_valid_out;
wire local_bb1_cmp16_2_2_stall_in;
 reg local_bb1_cmp16_2_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_2_2_inputs_ready;
wire local_bb1_cmp16_2_2_stall_local;
wire local_bb1_cmp16_2_2;

assign local_bb1_cmp16_2_2_inputs_ready = rnode_167to168_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
assign local_bb1_cmp16_2_2 = (local_bb1__pop37_ == 8'h0);
assign local_bb1__pop37__valid_out_0 = 1'b1;
assign local_bb1_cmp16_2_2_valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop37__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_2_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop37__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_2_2_inputs_ready & (local_bb1__pop37__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop37__stall_in_0)) & local_bb1_cmp16_2_2_stall_local);
		local_bb1_cmp16_2_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_2_2_inputs_ready & (local_bb1_cmp16_2_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_2_2_stall_in)) & local_bb1_cmp16_2_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop38__valid_out_0;
wire local_bb1__pop38__stall_in_0;
 reg local_bb1__pop38__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_3_2_valid_out;
wire local_bb1_cmp16_3_2_stall_in;
 reg local_bb1_cmp16_3_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_3_2_inputs_ready;
wire local_bb1_cmp16_3_2_stall_local;
wire local_bb1_cmp16_3_2;

assign local_bb1_cmp16_3_2_inputs_ready = rnode_167to168_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
assign local_bb1_cmp16_3_2 = (local_bb1__pop38_ == 8'h0);
assign local_bb1__pop38__valid_out_0 = 1'b1;
assign local_bb1_cmp16_3_2_valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop38__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_3_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop38__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_3_2_inputs_ready & (local_bb1__pop38__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop38__stall_in_0)) & local_bb1_cmp16_3_2_stall_local);
		local_bb1_cmp16_3_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_3_2_inputs_ready & (local_bb1_cmp16_3_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_3_2_stall_in)) & local_bb1_cmp16_3_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop39__valid_out_0;
wire local_bb1__pop39__stall_in_0;
 reg local_bb1__pop39__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_4_2_valid_out;
wire local_bb1_cmp16_4_2_stall_in;
 reg local_bb1_cmp16_4_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_4_2_inputs_ready;
wire local_bb1_cmp16_4_2_stall_local;
wire local_bb1_cmp16_4_2;

assign local_bb1_cmp16_4_2_inputs_ready = rnode_167to168_bb1_c0_ene1_0_valid_out_6_NO_SHIFT_REG;
assign local_bb1_cmp16_4_2 = (local_bb1__pop39_ == 8'h0);
assign local_bb1__pop39__valid_out_0 = 1'b1;
assign local_bb1_cmp16_4_2_valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop39__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_4_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop39__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_4_2_inputs_ready & (local_bb1__pop39__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop39__stall_in_0)) & local_bb1_cmp16_4_2_stall_local);
		local_bb1_cmp16_4_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_4_2_inputs_ready & (local_bb1_cmp16_4_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_4_2_stall_in)) & local_bb1_cmp16_4_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_14_1_stall_local;
wire local_bb1_cmp16_14_1;

assign local_bb1_cmp16_14_1 = (local_bb1_rows_733_0_pop6_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_15_1_stall_local;
wire local_bb1_cmp16_15_1;

assign local_bb1_cmp16_15_1 = (local_bb1_rows_734_0_pop5_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_16_1_stall_local;
wire local_bb1_cmp16_16_1;

assign local_bb1_cmp16_16_1 = (local_bb1_rows_735_0_pop4_ == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__pop48__valid_out;
wire local_bb1__pop48__stall_in;
wire local_bb1__pop48__inputs_ready;
wire local_bb1__pop48__stall_local;
wire [7:0] local_bb1__pop48_;
wire local_bb1__pop48__fu_valid_out;
wire local_bb1__pop48__fu_stall_out;

acl_pop local_bb1__pop48__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop48__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__pop48__fu_valid_out),
	.stall_in(local_bb1__pop48__stall_local),
	.data_out(local_bb1__pop48_),
	.feedback_in(feedback_data_in_48),
	.feedback_valid_in(feedback_valid_in_48),
	.feedback_stall_out(feedback_stall_out_48)
);

defparam local_bb1__pop48__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop48__feedback.STYLE = "REGULAR";

assign local_bb1__pop48__inputs_ready = rnode_168to169_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1__pop48__stall_local = 1'b0;
assign local_bb1__pop48__valid_out = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop43__stall_local;
wire [7:0] local_bb1__pop43_;
wire local_bb1__pop43__fu_valid_out;
wire local_bb1__pop43__fu_stall_out;

acl_pop local_bb1__pop43__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop43__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__pop43__fu_valid_out),
	.stall_in(local_bb1__pop43__stall_local),
	.data_out(local_bb1__pop43_),
	.feedback_in(feedback_data_in_43),
	.feedback_valid_in(feedback_valid_in_43),
	.feedback_stall_out(feedback_stall_out_43)
);

defparam local_bb1__pop43__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop43__feedback.STYLE = "REGULAR";

assign local_bb1__pop43__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop44__stall_local;
wire [7:0] local_bb1__pop44_;
wire local_bb1__pop44__fu_valid_out;
wire local_bb1__pop44__fu_stall_out;

acl_pop local_bb1__pop44__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene1_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop44__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__pop44__fu_valid_out),
	.stall_in(local_bb1__pop44__stall_local),
	.data_out(local_bb1__pop44_),
	.feedback_in(feedback_data_in_44),
	.feedback_valid_in(feedback_valid_in_44),
	.feedback_stall_out(feedback_stall_out_44)
);

defparam local_bb1__pop44__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop44__feedback.STYLE = "REGULAR";

assign local_bb1__pop44__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop46__stall_local;
wire [7:0] local_bb1__pop46_;
wire local_bb1__pop46__fu_valid_out;
wire local_bb1__pop46__fu_stall_out;

acl_pop local_bb1__pop46__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene1_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop46__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__pop46__fu_valid_out),
	.stall_in(local_bb1__pop46__stall_local),
	.data_out(local_bb1__pop46_),
	.feedback_in(feedback_data_in_46),
	.feedback_valid_in(feedback_valid_in_46),
	.feedback_stall_out(feedback_stall_out_46)
);

defparam local_bb1__pop46__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop46__feedback.STYLE = "REGULAR";

assign local_bb1__pop46__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop47__stall_local;
wire [7:0] local_bb1__pop47_;
wire local_bb1__pop47__fu_valid_out;
wire local_bb1__pop47__fu_stall_out;

acl_pop local_bb1__pop47__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene1_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop47__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__pop47__fu_valid_out),
	.stall_in(local_bb1__pop47__stall_local),
	.data_out(local_bb1__pop47_),
	.feedback_in(feedback_data_in_47),
	.feedback_valid_in(feedback_valid_in_47),
	.feedback_stall_out(feedback_stall_out_47)
);

defparam local_bb1__pop47__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop47__feedback.STYLE = "REGULAR";

assign local_bb1__pop47__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop45__stall_local;
wire [7:0] local_bb1__pop45_;
wire local_bb1__pop45__fu_valid_out;
wire local_bb1__pop45__fu_stall_out;

acl_pop local_bb1__pop45__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene1_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop45__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__pop45__fu_valid_out),
	.stall_in(local_bb1__pop45__stall_local),
	.data_out(local_bb1__pop45_),
	.feedback_in(feedback_data_in_45),
	.feedback_valid_in(feedback_valid_in_45),
	.feedback_stall_out(feedback_stall_out_45)
);

defparam local_bb1__pop45__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop45__feedback.STYLE = "REGULAR";

assign local_bb1__pop45__stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene1_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_c0_ene1_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_c0_ene1_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_c0_ene1_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_c0_ene1_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_c0_ene1_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_c0_ene1_6_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_c0_ene1_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_c0_ene1_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_c0_ene1_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_c0_ene1_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_c0_ene1_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_c0_ene1_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_c0_ene1_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_c0_ene1_0_NO_SHIFT_REG = rnode_169to170_bb1_c0_ene1_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_c0_ene1_1_NO_SHIFT_REG = rnode_169to170_bb1_c0_ene1_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_c0_ene1_2_NO_SHIFT_REG = rnode_169to170_bb1_c0_ene1_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_c0_ene2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_c0_ene2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_c0_ene2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_c0_ene2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_c0_ene2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_c0_ene2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_c0_ene2_7_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_c0_ene2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_c0_ene2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_c0_ene2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_c0_ene2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_c0_ene2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_c0_ene2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_c0_ene2_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_c0_ene2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_c0_ene2_0_NO_SHIFT_REG = rnode_169to170_bb1_c0_ene2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c0_ene2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_c0_ene2_1_NO_SHIFT_REG = rnode_169to170_bb1_c0_ene2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_c0_ene2_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_c0_ene2_2_NO_SHIFT_REG = rnode_169to170_bb1_c0_ene2_0_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_2_stall_local;
wire local_bb1_cmp19_2;

assign local_bb1_cmp19_2 = (local_bb1__335 == 8'h0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to170_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG),
	.data_out(rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_fifo.DEPTH = 2;
defparam rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG = rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_170_NO_SHIFT_REG;
assign rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_not_select6_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_not_select6_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1_not_select6_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_not_select6_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_not_select6_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_not_select6_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_not_select6_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_not_select6_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_not_select6_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_not_select6_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_not_select6_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_not_select6_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_not_select6_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_not_select6_0_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_not_select6_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_not_select6_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_not_select6_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_not_select6_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_not_select6_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_not_select6_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_not_select6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_not_select6_0_NO_SHIFT_REG = rnode_166to167_bb1_not_select6_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_not_select6_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_not_select6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_NO_SHIFT_REG;
 logic [10:0] rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [10:0] rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_coalesce_counter_push54_next_coalesce_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_fifo.DATA_WIDTH = 11;
defparam rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_coalesce_counter_push54_next_coalesce_stall_in = 1'b0;
assign rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG = rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_121_stall_local;
wire local_bb1_not_cmp16_121;

assign local_bb1_not_cmp16_121 = (rnode_165to166_bb1_cmp16_121_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG = rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG),
	.data_out(rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_fifo.DEPTH = 2;
defparam rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG = rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_170_NO_SHIFT_REG;
assign rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG),
	.data_out(rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_fifo.DEPTH = 2;
defparam rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG = rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_170_NO_SHIFT_REG;
assign rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG),
	.data_out(rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_fifo.DEPTH = 2;
defparam rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG = rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_170_NO_SHIFT_REG;
assign rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG),
	.data_out(rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_fifo.DEPTH = 2;
defparam rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG = rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_170_NO_SHIFT_REG;
assign rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG),
	.data_out(rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_fifo.DEPTH = 2;
defparam rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG = rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_170_NO_SHIFT_REG;
assign rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_rows_730_0_push9_rows_729_0_pop10_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_730_0_push9_rows_729_0_pop10_stall_in = 1'b0;
assign rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG = rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_10_1_stall_local;
wire local_bb1_not_cmp16_10_1;

assign local_bb1_not_cmp16_10_1 = (rnode_167to168_bb1_cmp16_10_1_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_rows_732_0_push7_rows_731_0_pop8_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_732_0_push7_rows_731_0_pop8_stall_in = 1'b0;
assign rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG = rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_12_1_stall_local;
wire local_bb1_not_cmp16_12_1;

assign local_bb1_not_cmp16_12_1 = (rnode_167to168_bb1_cmp16_12_1_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_rows_733_0_push6_rows_732_0_pop7_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_733_0_push6_rows_732_0_pop7_stall_in = 1'b0;
assign rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_NO_SHIFT_REG = rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_13_1_stall_local;
wire local_bb1_not_cmp16_13_1;

assign local_bb1_not_cmp16_13_1 = (local_bb1_cmp16_13_1 ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_rows_731_0_push8_rows_730_0_pop9_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_731_0_push8_rows_730_0_pop9_stall_in = 1'b0;
assign rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG = rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_11_1_stall_local;
wire local_bb1_not_cmp16_11_1;

assign local_bb1_not_cmp16_11_1 = (rnode_167to168_bb1_cmp16_11_1_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_rows_729_0_push10_rows_728_0_pop11_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_729_0_push10_rows_728_0_pop11_stall_in = 1'b0;
assign rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG = rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_9_1_stall_local;
wire local_bb1_not_cmp16_9_1;

assign local_bb1_not_cmp16_9_1 = (rnode_167to168_bb1_cmp16_9_1_1_NO_SHIFT_REG ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1__push41__pop40_inputs_ready;
 reg local_bb1__push41__pop40_valid_out_NO_SHIFT_REG;
wire local_bb1__push41__pop40_stall_in;
wire local_bb1__push41__pop40_output_regs_ready;
wire [7:0] local_bb1__push41__pop40_result;
wire local_bb1__push41__pop40_fu_valid_out;
wire local_bb1__push41__pop40_fu_stall_out;
 reg [7:0] local_bb1__push41__pop40_NO_SHIFT_REG;
wire local_bb1__push41__pop40_causedstall;

acl_push local_bb1__push41__pop40_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_6_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop40_),
	.stall_out(local_bb1__push41__pop40_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__push41__pop40_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push41__pop40_result),
	.feedback_out(feedback_data_out_41),
	.feedback_valid_out(feedback_valid_out_41),
	.feedback_stall_in(feedback_stall_in_41)
);

defparam local_bb1__push41__pop40_feedback.STALLFREE = 1;
defparam local_bb1__push41__pop40_feedback.DATA_WIDTH = 8;
defparam local_bb1__push41__pop40_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push41__pop40_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push41__pop40_feedback.STYLE = "REGULAR";

assign local_bb1__push41__pop40_inputs_ready = 1'b1;
assign local_bb1__push41__pop40_output_regs_ready = 1'b1;
assign local_bb1__pop40__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign local_bb1__push41__pop40_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push41__pop40_NO_SHIFT_REG <= 'x;
		local_bb1__push41__pop40_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push41__pop40_output_regs_ready)
		begin
			local_bb1__push41__pop40_NO_SHIFT_REG <= local_bb1__push41__pop40_result;
			local_bb1__push41__pop40_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push41__pop40_stall_in))
			begin
				local_bb1__push41__pop40_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_cmp16_5_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_5_2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_cmp16_5_2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_cmp16_5_2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_cmp16_5_2_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_cmp16_5_2_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_cmp16_5_2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_5_2),
	.data_out(rnode_168to169_bb1_cmp16_5_2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_cmp16_5_2_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_cmp16_5_2_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_cmp16_5_2_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_cmp16_5_2_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_cmp16_5_2_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_5_2_stall_in = 1'b0;
assign rnode_168to169_bb1_cmp16_5_2_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_5_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_5_2_0_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_5_2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_cmp16_5_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_5_2_1_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_5_2_0_reg_169_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push42__pop41_inputs_ready;
 reg local_bb1__push42__pop41_valid_out_NO_SHIFT_REG;
wire local_bb1__push42__pop41_stall_in;
wire local_bb1__push42__pop41_output_regs_ready;
wire [7:0] local_bb1__push42__pop41_result;
wire local_bb1__push42__pop41_fu_valid_out;
wire local_bb1__push42__pop41_fu_stall_out;
 reg [7:0] local_bb1__push42__pop41_NO_SHIFT_REG;
wire local_bb1__push42__pop41_causedstall;

acl_push local_bb1__push42__pop41_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_7_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop41_),
	.stall_out(local_bb1__push42__pop41_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__push42__pop41_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push42__pop41_result),
	.feedback_out(feedback_data_out_42),
	.feedback_valid_out(feedback_valid_out_42),
	.feedback_stall_in(feedback_stall_in_42)
);

defparam local_bb1__push42__pop41_feedback.STALLFREE = 1;
defparam local_bb1__push42__pop41_feedback.DATA_WIDTH = 8;
defparam local_bb1__push42__pop41_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push42__pop41_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push42__pop41_feedback.STYLE = "REGULAR";

assign local_bb1__push42__pop41_inputs_ready = 1'b1;
assign local_bb1__push42__pop41_output_regs_ready = 1'b1;
assign local_bb1__pop41__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_7_NO_SHIFT_REG = 1'b0;
assign local_bb1__push42__pop41_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push42__pop41_NO_SHIFT_REG <= 'x;
		local_bb1__push42__pop41_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push42__pop41_output_regs_ready)
		begin
			local_bb1__push42__pop41_NO_SHIFT_REG <= local_bb1__push42__pop41_result;
			local_bb1__push42__pop41_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push42__pop41_stall_in))
			begin
				local_bb1__push42__pop41_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_cmp16_6_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_6_2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_cmp16_6_2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_cmp16_6_2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_cmp16_6_2_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_cmp16_6_2_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_cmp16_6_2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_6_2),
	.data_out(rnode_168to169_bb1_cmp16_6_2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_cmp16_6_2_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_cmp16_6_2_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_cmp16_6_2_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_cmp16_6_2_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_cmp16_6_2_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_6_2_stall_in = 1'b0;
assign rnode_168to169_bb1_cmp16_6_2_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_6_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_6_2_0_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_6_2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_cmp16_6_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_6_2_1_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_6_2_0_reg_169_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push43__pop42_inputs_ready;
 reg local_bb1__push43__pop42_valid_out_NO_SHIFT_REG;
wire local_bb1__push43__pop42_stall_in;
wire local_bb1__push43__pop42_output_regs_ready;
wire [7:0] local_bb1__push43__pop42_result;
wire local_bb1__push43__pop42_fu_valid_out;
wire local_bb1__push43__pop42_fu_stall_out;
 reg [7:0] local_bb1__push43__pop42_NO_SHIFT_REG;
wire local_bb1__push43__pop42_causedstall;

acl_push local_bb1__push43__pop42_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene2_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_168to169_bb1__pop42__0_NO_SHIFT_REG),
	.stall_out(local_bb1__push43__pop42_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__push43__pop42_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push43__pop42_result),
	.feedback_out(feedback_data_out_43),
	.feedback_valid_out(feedback_valid_out_43),
	.feedback_stall_in(feedback_stall_in_43)
);

defparam local_bb1__push43__pop42_feedback.STALLFREE = 1;
defparam local_bb1__push43__pop42_feedback.DATA_WIDTH = 8;
defparam local_bb1__push43__pop42_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push43__pop42_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push43__pop42_feedback.STYLE = "REGULAR";

assign local_bb1__push43__pop42_inputs_ready = 1'b1;
assign local_bb1__push43__pop42_output_regs_ready = 1'b1;
assign rnode_168to169_bb1__pop42__0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1__push43__pop42_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[7] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push43__pop42_NO_SHIFT_REG <= 'x;
		local_bb1__push43__pop42_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push43__pop42_output_regs_ready)
		begin
			local_bb1__push43__pop42_NO_SHIFT_REG <= local_bb1__push43__pop42_result;
			local_bb1__push43__pop42_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push43__pop42_stall_in))
			begin
				local_bb1__push43__pop42_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_7_2_valid_out;
wire local_bb1_cmp16_7_2_stall_in;
wire local_bb1_cmp16_7_2_inputs_ready;
wire local_bb1_cmp16_7_2_stall_local;
wire local_bb1_cmp16_7_2;

assign local_bb1_cmp16_7_2_inputs_ready = rnode_168to169_bb1__pop42__0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp16_7_2 = (rnode_168to169_bb1__pop42__1_NO_SHIFT_REG == 8'h0);
assign local_bb1_cmp16_7_2_valid_out = 1'b1;
assign rnode_168to169_bb1__pop42__0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1__push37__pop36_inputs_ready;
 reg local_bb1__push37__pop36_valid_out_NO_SHIFT_REG;
wire local_bb1__push37__pop36_stall_in;
wire local_bb1__push37__pop36_output_regs_ready;
wire [7:0] local_bb1__push37__pop36_result;
wire local_bb1__push37__pop36_fu_valid_out;
wire local_bb1__push37__pop36_fu_stall_out;
 reg [7:0] local_bb1__push37__pop36_NO_SHIFT_REG;
wire local_bb1__push37__pop36_causedstall;

acl_push local_bb1__push37__pop36_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene2_6_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_168to169_bb1__pop36__0_NO_SHIFT_REG),
	.stall_out(local_bb1__push37__pop36_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__push37__pop36_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push37__pop36_result),
	.feedback_out(feedback_data_out_37),
	.feedback_valid_out(feedback_valid_out_37),
	.feedback_stall_in(feedback_stall_in_37)
);

defparam local_bb1__push37__pop36_feedback.STALLFREE = 1;
defparam local_bb1__push37__pop36_feedback.DATA_WIDTH = 8;
defparam local_bb1__push37__pop36_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push37__pop36_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1__push37__pop36_feedback.STYLE = "REGULAR";

assign local_bb1__push37__pop36_inputs_ready = 1'b1;
assign local_bb1__push37__pop36_output_regs_ready = 1'b1;
assign rnode_168to169_bb1__pop36__0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign local_bb1__push37__pop36_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[7] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push37__pop36_NO_SHIFT_REG <= 'x;
		local_bb1__push37__pop36_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push37__pop36_output_regs_ready)
		begin
			local_bb1__push37__pop36_NO_SHIFT_REG <= local_bb1__push37__pop36_result;
			local_bb1__push37__pop36_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push37__pop36_stall_in))
			begin
				local_bb1__push37__pop36_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_1_2_stall_local;
wire local_bb1_cmp16_1_2;

assign local_bb1_cmp16_1_2 = (rnode_168to169_bb1__pop36__1_NO_SHIFT_REG == 8'h0);

// This section implements a registered operation.
// 
wire local_bb1__push38__pop37_inputs_ready;
 reg local_bb1__push38__pop37_valid_out_NO_SHIFT_REG;
wire local_bb1__push38__pop37_stall_in;
wire local_bb1__push38__pop37_output_regs_ready;
wire [7:0] local_bb1__push38__pop37_result;
wire local_bb1__push38__pop37_fu_valid_out;
wire local_bb1__push38__pop37_fu_stall_out;
 reg [7:0] local_bb1__push38__pop37_NO_SHIFT_REG;
wire local_bb1__push38__pop37_causedstall;

acl_push local_bb1__push38__pop37_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop37_),
	.stall_out(local_bb1__push38__pop37_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__push38__pop37_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push38__pop37_result),
	.feedback_out(feedback_data_out_38),
	.feedback_valid_out(feedback_valid_out_38),
	.feedback_stall_in(feedback_stall_in_38)
);

defparam local_bb1__push38__pop37_feedback.STALLFREE = 1;
defparam local_bb1__push38__pop37_feedback.DATA_WIDTH = 8;
defparam local_bb1__push38__pop37_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push38__pop37_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push38__pop37_feedback.STYLE = "REGULAR";

assign local_bb1__push38__pop37_inputs_ready = 1'b1;
assign local_bb1__push38__pop37_output_regs_ready = 1'b1;
assign local_bb1__pop37__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign local_bb1__push38__pop37_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push38__pop37_NO_SHIFT_REG <= 'x;
		local_bb1__push38__pop37_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push38__pop37_output_regs_ready)
		begin
			local_bb1__push38__pop37_NO_SHIFT_REG <= local_bb1__push38__pop37_result;
			local_bb1__push38__pop37_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push38__pop37_stall_in))
			begin
				local_bb1__push38__pop37_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_cmp16_2_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_2_2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_cmp16_2_2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_cmp16_2_2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_cmp16_2_2_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_cmp16_2_2_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_cmp16_2_2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_2_2),
	.data_out(rnode_168to169_bb1_cmp16_2_2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_cmp16_2_2_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_cmp16_2_2_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_cmp16_2_2_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_cmp16_2_2_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_cmp16_2_2_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_2_2_stall_in = 1'b0;
assign rnode_168to169_bb1_cmp16_2_2_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_2_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_2_2_0_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_2_2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_cmp16_2_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_2_2_1_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_2_2_0_reg_169_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push39__pop38_inputs_ready;
 reg local_bb1__push39__pop38_valid_out_NO_SHIFT_REG;
wire local_bb1__push39__pop38_stall_in;
wire local_bb1__push39__pop38_output_regs_ready;
wire [7:0] local_bb1__push39__pop38_result;
wire local_bb1__push39__pop38_fu_valid_out;
wire local_bb1__push39__pop38_fu_stall_out;
 reg [7:0] local_bb1__push39__pop38_NO_SHIFT_REG;
wire local_bb1__push39__pop38_causedstall;

acl_push local_bb1__push39__pop38_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop38_),
	.stall_out(local_bb1__push39__pop38_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__push39__pop38_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push39__pop38_result),
	.feedback_out(feedback_data_out_39),
	.feedback_valid_out(feedback_valid_out_39),
	.feedback_stall_in(feedback_stall_in_39)
);

defparam local_bb1__push39__pop38_feedback.STALLFREE = 1;
defparam local_bb1__push39__pop38_feedback.DATA_WIDTH = 8;
defparam local_bb1__push39__pop38_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push39__pop38_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push39__pop38_feedback.STYLE = "REGULAR";

assign local_bb1__push39__pop38_inputs_ready = 1'b1;
assign local_bb1__push39__pop38_output_regs_ready = 1'b1;
assign local_bb1__pop38__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1__push39__pop38_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push39__pop38_NO_SHIFT_REG <= 'x;
		local_bb1__push39__pop38_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push39__pop38_output_regs_ready)
		begin
			local_bb1__push39__pop38_NO_SHIFT_REG <= local_bb1__push39__pop38_result;
			local_bb1__push39__pop38_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push39__pop38_stall_in))
			begin
				local_bb1__push39__pop38_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_cmp16_3_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_3_2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_cmp16_3_2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_cmp16_3_2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_cmp16_3_2_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_cmp16_3_2_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_cmp16_3_2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_3_2),
	.data_out(rnode_168to169_bb1_cmp16_3_2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_cmp16_3_2_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_cmp16_3_2_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_cmp16_3_2_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_cmp16_3_2_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_cmp16_3_2_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_3_2_stall_in = 1'b0;
assign rnode_168to169_bb1_cmp16_3_2_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_3_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_3_2_0_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_3_2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_cmp16_3_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_3_2_1_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_3_2_0_reg_169_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push40__pop39_inputs_ready;
 reg local_bb1__push40__pop39_valid_out_NO_SHIFT_REG;
wire local_bb1__push40__pop39_stall_in;
wire local_bb1__push40__pop39_output_regs_ready;
wire [7:0] local_bb1__push40__pop39_result;
wire local_bb1__push40__pop39_fu_valid_out;
wire local_bb1__push40__pop39_fu_stall_out;
 reg [7:0] local_bb1__push40__pop39_NO_SHIFT_REG;
wire local_bb1__push40__pop39_causedstall;

acl_push local_bb1__push40__pop39_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop39_),
	.stall_out(local_bb1__push40__pop39_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__push40__pop39_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push40__pop39_result),
	.feedback_out(feedback_data_out_40),
	.feedback_valid_out(feedback_valid_out_40),
	.feedback_stall_in(feedback_stall_in_40)
);

defparam local_bb1__push40__pop39_feedback.STALLFREE = 1;
defparam local_bb1__push40__pop39_feedback.DATA_WIDTH = 8;
defparam local_bb1__push40__pop39_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push40__pop39_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push40__pop39_feedback.STYLE = "REGULAR";

assign local_bb1__push40__pop39_inputs_ready = 1'b1;
assign local_bb1__push40__pop39_output_regs_ready = 1'b1;
assign local_bb1__pop39__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1__push40__pop39_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push40__pop39_NO_SHIFT_REG <= 'x;
		local_bb1__push40__pop39_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push40__pop39_output_regs_ready)
		begin
			local_bb1__push40__pop39_NO_SHIFT_REG <= local_bb1__push40__pop39_result;
			local_bb1__push40__pop39_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push40__pop39_stall_in))
			begin
				local_bb1__push40__pop39_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_cmp16_4_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_4_2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_cmp16_4_2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_cmp16_4_2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_cmp16_4_2_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_cmp16_4_2_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_cmp16_4_2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_4_2),
	.data_out(rnode_168to169_bb1_cmp16_4_2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_cmp16_4_2_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_cmp16_4_2_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_cmp16_4_2_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_cmp16_4_2_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_cmp16_4_2_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_4_2_stall_in = 1'b0;
assign rnode_168to169_bb1_cmp16_4_2_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_4_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_4_2_0_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_4_2_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_cmp16_4_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_4_2_1_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_4_2_0_reg_169_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_14_1_stall_local;
wire local_bb1_not_cmp16_14_1;

assign local_bb1_not_cmp16_14_1 = (local_bb1_cmp16_14_1 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_15_1_stall_local;
wire local_bb1_not_cmp16_15_1;

assign local_bb1_not_cmp16_15_1 = (local_bb1_cmp16_15_1 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_16_1_stall_local;
wire local_bb1_not_cmp16_16_1;

assign local_bb1_not_cmp16_16_1 = (local_bb1_cmp16_16_1 ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1__pop48__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__pop48__0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1__pop48__0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__pop48__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1__pop48__0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1__pop48__1_NO_SHIFT_REG;
 logic rnode_169to170_bb1__pop48__0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1__pop48__0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__pop48__0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__pop48__0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__pop48__0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1__pop48__0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1__pop48__0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1__pop48__0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1__pop48__0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1__pop48__0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1__pop48_),
	.data_out(rnode_169to170_bb1__pop48__0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1__pop48__0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1__pop48__0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1__pop48__0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1__pop48__0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1__pop48__0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__pop48__stall_in = 1'b0;
assign rnode_169to170_bb1__pop48__0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__pop48__0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1__pop48__0_NO_SHIFT_REG = rnode_169to170_bb1__pop48__0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1__pop48__0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1__pop48__1_NO_SHIFT_REG = rnode_169to170_bb1__pop48__0_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1__pop43__valid_out_0;
wire local_bb1__pop43__stall_in_0;
 reg local_bb1__pop43__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_8_2_valid_out;
wire local_bb1_cmp16_8_2_stall_in;
 reg local_bb1_cmp16_8_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_8_2_inputs_ready;
wire local_bb1_cmp16_8_2_stall_local;
wire local_bb1_cmp16_8_2;

assign local_bb1_cmp16_8_2_inputs_ready = rnode_168to169_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp16_8_2 = (local_bb1__pop43_ == 8'h0);
assign local_bb1__pop43__valid_out_0 = 1'b1;
assign local_bb1_cmp16_8_2_valid_out = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop43__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_8_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop43__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_8_2_inputs_ready & (local_bb1__pop43__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop43__stall_in_0)) & local_bb1_cmp16_8_2_stall_local);
		local_bb1_cmp16_8_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_8_2_inputs_ready & (local_bb1_cmp16_8_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_8_2_stall_in)) & local_bb1_cmp16_8_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop44__valid_out_0;
wire local_bb1__pop44__stall_in_0;
 reg local_bb1__pop44__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_9_2_valid_out;
wire local_bb1_cmp16_9_2_stall_in;
 reg local_bb1_cmp16_9_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_9_2_inputs_ready;
wire local_bb1_cmp16_9_2_stall_local;
wire local_bb1_cmp16_9_2;

assign local_bb1_cmp16_9_2_inputs_ready = rnode_168to169_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_cmp16_9_2 = (local_bb1__pop44_ == 8'h0);
assign local_bb1__pop44__valid_out_0 = 1'b1;
assign local_bb1_cmp16_9_2_valid_out = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop44__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_9_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop44__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_9_2_inputs_ready & (local_bb1__pop44__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop44__stall_in_0)) & local_bb1_cmp16_9_2_stall_local);
		local_bb1_cmp16_9_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_9_2_inputs_ready & (local_bb1_cmp16_9_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_9_2_stall_in)) & local_bb1_cmp16_9_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop46__valid_out_0;
wire local_bb1__pop46__stall_in_0;
 reg local_bb1__pop46__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_11_2_valid_out;
wire local_bb1_cmp16_11_2_stall_in;
 reg local_bb1_cmp16_11_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_11_2_inputs_ready;
wire local_bb1_cmp16_11_2_stall_local;
wire local_bb1_cmp16_11_2;

assign local_bb1_cmp16_11_2_inputs_ready = rnode_168to169_bb1_c0_ene1_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1_cmp16_11_2 = (local_bb1__pop46_ == 8'h0);
assign local_bb1__pop46__valid_out_0 = 1'b1;
assign local_bb1_cmp16_11_2_valid_out = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_3_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop46__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_11_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop46__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_11_2_inputs_ready & (local_bb1__pop46__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop46__stall_in_0)) & local_bb1_cmp16_11_2_stall_local);
		local_bb1_cmp16_11_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_11_2_inputs_ready & (local_bb1_cmp16_11_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_11_2_stall_in)) & local_bb1_cmp16_11_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop47__valid_out_0;
wire local_bb1__pop47__stall_in_0;
 reg local_bb1__pop47__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_12_2_valid_out;
wire local_bb1_cmp16_12_2_stall_in;
 reg local_bb1_cmp16_12_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_12_2_inputs_ready;
wire local_bb1_cmp16_12_2_stall_local;
wire local_bb1_cmp16_12_2;

assign local_bb1_cmp16_12_2_inputs_ready = rnode_168to169_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG;
assign local_bb1_cmp16_12_2 = (local_bb1__pop47_ == 8'h0);
assign local_bb1__pop47__valid_out_0 = 1'b1;
assign local_bb1_cmp16_12_2_valid_out = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop47__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_12_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop47__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_12_2_inputs_ready & (local_bb1__pop47__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop47__stall_in_0)) & local_bb1_cmp16_12_2_stall_local);
		local_bb1_cmp16_12_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_12_2_inputs_ready & (local_bb1_cmp16_12_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_12_2_stall_in)) & local_bb1_cmp16_12_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop45__valid_out_0;
wire local_bb1__pop45__stall_in_0;
 reg local_bb1__pop45__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_10_2_valid_out;
wire local_bb1_cmp16_10_2_stall_in;
 reg local_bb1_cmp16_10_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_10_2_inputs_ready;
wire local_bb1_cmp16_10_2_stall_local;
wire local_bb1_cmp16_10_2;

assign local_bb1_cmp16_10_2_inputs_ready = rnode_168to169_bb1_c0_ene1_0_valid_out_5_NO_SHIFT_REG;
assign local_bb1_cmp16_10_2 = (local_bb1__pop45_ == 8'h0);
assign local_bb1__pop45__valid_out_0 = 1'b1;
assign local_bb1_cmp16_10_2_valid_out = 1'b1;
assign rnode_168to169_bb1_c0_ene1_0_stall_in_5_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop45__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_10_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop45__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_10_2_inputs_ready & (local_bb1__pop45__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop45__stall_in_0)) & local_bb1_cmp16_10_2_stall_local);
		local_bb1_cmp16_10_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_10_2_inputs_ready & (local_bb1_cmp16_10_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_10_2_stall_in)) & local_bb1_cmp16_10_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop49__stall_local;
wire [7:0] local_bb1__pop49_;
wire local_bb1__pop49__fu_valid_out;
wire local_bb1__pop49__fu_stall_out;

acl_pop local_bb1__pop49__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_169to170_bb1_c0_ene1_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop49__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[8]),
	.valid_out(local_bb1__pop49__fu_valid_out),
	.stall_in(local_bb1__pop49__stall_local),
	.data_out(local_bb1__pop49_),
	.feedback_in(feedback_data_in_49),
	.feedback_valid_in(feedback_valid_in_49),
	.feedback_stall_out(feedback_stall_out_49)
);

defparam local_bb1__pop49__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop49__feedback.STYLE = "REGULAR";

assign local_bb1__pop49__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop50__stall_local;
wire [7:0] local_bb1__pop50_;
wire local_bb1__pop50__fu_valid_out;
wire local_bb1__pop50__fu_stall_out;

acl_pop local_bb1__pop50__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_169to170_bb1_c0_ene1_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop50__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[8]),
	.valid_out(local_bb1__pop50__fu_valid_out),
	.stall_in(local_bb1__pop50__stall_local),
	.data_out(local_bb1__pop50_),
	.feedback_in(feedback_data_in_50),
	.feedback_valid_in(feedback_valid_in_50),
	.feedback_stall_out(feedback_stall_out_50)
);

defparam local_bb1__pop50__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop50__feedback.STYLE = "REGULAR";

assign local_bb1__pop50__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__pop51__stall_local;
wire [7:0] local_bb1__pop51_;
wire local_bb1__pop51__fu_valid_out;
wire local_bb1__pop51__fu_stall_out;

acl_pop local_bb1__pop51__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_169to170_bb1_c0_ene1_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__pop51__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[8]),
	.valid_out(local_bb1__pop51__fu_valid_out),
	.stall_in(local_bb1__pop51__stall_local),
	.data_out(local_bb1__pop51_),
	.feedback_in(feedback_data_in_51),
	.feedback_valid_in(feedback_valid_in_51),
	.feedback_stall_out(feedback_stall_out_51)
);

defparam local_bb1__pop51__feedback.DATA_WIDTH = 8;
defparam local_bb1__pop51__feedback.STYLE = "REGULAR";

assign local_bb1__pop51__stall_local = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__336_demorgan_stall_local;
wire local_bb1__336_demorgan;

assign local_bb1__336_demorgan = (local_bb1_cmp16_2 | local_bb1_cmp19_2);

// This section implements an unregistered operation.
// 
wire local_bb1__338_stall_local;
wire local_bb1__338;

assign local_bb1__338 = (local_bb1_cmp19_2 & local_bb1_not_cmp16_2);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to170_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_not_select6_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_not_select6_0_stall_in_NO_SHIFT_REG;
 logic rnode_167to168_bb1_not_select6_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_not_select6_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic rnode_167to168_bb1_not_select6_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_not_select6_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_not_select6_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_not_select6_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_not_select6_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_not_select6_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_not_select6_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_not_select6_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_not_select6_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_not_select6_0_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_not_select6_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_not_select6_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_not_select6_0_reg_168_fifo.DATA_WIDTH = 1;
defparam rnode_167to168_bb1_not_select6_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_not_select6_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_not_select6_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_not_select6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_not_select6_0_NO_SHIFT_REG = rnode_167to168_bb1_not_select6_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_not_select6_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_not_select6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_NO_SHIFT_REG;
 logic [10:0] rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [10:0] rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_fifo.DATA_WIDTH = 11;
defparam rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG = rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to170_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to170_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to170_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to170_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to170_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG = rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG = rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG = rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG = rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1__push41__pop40_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push41__pop40_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push41__pop40_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push41__pop40_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push41__pop40_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push41__pop40_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push41__pop40_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push41__pop40_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1__push41__pop40_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1__push41__pop40_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1__push41__pop40_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1__push41__pop40_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1__push41__pop40_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push41__pop40_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1__push41__pop40_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1__push41__pop40_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1__push41__pop40_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1__push41__pop40_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1__push41__pop40_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1__push41__pop40_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push41__pop40_stall_in = 1'b0;
assign rnode_169to171_bb1__push41__pop40_0_NO_SHIFT_REG = rnode_169to171_bb1__push41__pop40_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1__push41__pop40_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push41__pop40_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_5_2_stall_local;
wire local_bb1_not_cmp16_5_2;

assign local_bb1_not_cmp16_5_2 = (rnode_168to169_bb1_cmp16_5_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1__push42__pop41_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push42__pop41_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push42__pop41_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push42__pop41_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push42__pop41_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push42__pop41_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push42__pop41_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push42__pop41_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1__push42__pop41_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1__push42__pop41_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1__push42__pop41_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1__push42__pop41_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1__push42__pop41_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push42__pop41_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1__push42__pop41_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1__push42__pop41_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1__push42__pop41_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1__push42__pop41_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1__push42__pop41_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1__push42__pop41_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push42__pop41_stall_in = 1'b0;
assign rnode_169to171_bb1__push42__pop41_0_NO_SHIFT_REG = rnode_169to171_bb1__push42__pop41_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1__push42__pop41_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push42__pop41_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_6_2_stall_local;
wire local_bb1_not_cmp16_6_2;

assign local_bb1_not_cmp16_6_2 = (rnode_168to169_bb1_cmp16_6_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__push43__pop42_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push43__pop42_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push43__pop42_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push43__pop42_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push43__pop42_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push43__pop42_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push43__pop42_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push43__pop42_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__push43__pop42_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__push43__pop42_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__push43__pop42_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__push43__pop42_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__push43__pop42_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push43__pop42_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1__push43__pop42_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__push43__pop42_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__push43__pop42_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1__push43__pop42_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__push43__pop42_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__push43__pop42_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push43__pop42_stall_in = 1'b0;
assign rnode_170to171_bb1__push43__pop42_0_NO_SHIFT_REG = rnode_170to171_bb1__push43__pop42_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__push43__pop42_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push43__pop42_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cmp16_7_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_7_2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cmp16_7_2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cmp16_7_2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cmp16_7_2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cmp16_7_2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cmp16_7_2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_7_2),
	.data_out(rnode_169to170_bb1_cmp16_7_2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cmp16_7_2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_cmp16_7_2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_cmp16_7_2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_cmp16_7_2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_cmp16_7_2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_7_2_stall_in = 1'b0;
assign rnode_169to170_bb1_cmp16_7_2_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_7_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_7_2_0_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_7_2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp16_7_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_7_2_1_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_7_2_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__push37__pop36_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push37__pop36_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push37__pop36_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push37__pop36_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push37__pop36_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push37__pop36_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push37__pop36_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push37__pop36_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__push37__pop36_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__push37__pop36_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__push37__pop36_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__push37__pop36_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__push37__pop36_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push37__pop36_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1__push37__pop36_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__push37__pop36_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__push37__pop36_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1__push37__pop36_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__push37__pop36_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__push37__pop36_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push37__pop36_stall_in = 1'b0;
assign rnode_170to171_bb1__push37__pop36_0_NO_SHIFT_REG = rnode_170to171_bb1__push37__pop36_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__push37__pop36_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push37__pop36_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_1_2_stall_local;
wire local_bb1_not_cmp16_1_2;

assign local_bb1_not_cmp16_1_2 = (local_bb1_cmp16_1_2 ^ 1'b1);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1__push38__pop37_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push38__pop37_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push38__pop37_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push38__pop37_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push38__pop37_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push38__pop37_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push38__pop37_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push38__pop37_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1__push38__pop37_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1__push38__pop37_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1__push38__pop37_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1__push38__pop37_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1__push38__pop37_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push38__pop37_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1__push38__pop37_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1__push38__pop37_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1__push38__pop37_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1__push38__pop37_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1__push38__pop37_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1__push38__pop37_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push38__pop37_stall_in = 1'b0;
assign rnode_169to171_bb1__push38__pop37_0_NO_SHIFT_REG = rnode_169to171_bb1__push38__pop37_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1__push38__pop37_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push38__pop37_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_2_2_stall_local;
wire local_bb1_not_cmp16_2_2;

assign local_bb1_not_cmp16_2_2 = (rnode_168to169_bb1_cmp16_2_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1__push39__pop38_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push39__pop38_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push39__pop38_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push39__pop38_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push39__pop38_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push39__pop38_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push39__pop38_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push39__pop38_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1__push39__pop38_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1__push39__pop38_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1__push39__pop38_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1__push39__pop38_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1__push39__pop38_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push39__pop38_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1__push39__pop38_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1__push39__pop38_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1__push39__pop38_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1__push39__pop38_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1__push39__pop38_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1__push39__pop38_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push39__pop38_stall_in = 1'b0;
assign rnode_169to171_bb1__push39__pop38_0_NO_SHIFT_REG = rnode_169to171_bb1__push39__pop38_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1__push39__pop38_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push39__pop38_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_3_2_stall_local;
wire local_bb1_not_cmp16_3_2;

assign local_bb1_not_cmp16_3_2 = (rnode_168to169_bb1_cmp16_3_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1__push40__pop39_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push40__pop39_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push40__pop39_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push40__pop39_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push40__pop39_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push40__pop39_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push40__pop39_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push40__pop39_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1__push40__pop39_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1__push40__pop39_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1__push40__pop39_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1__push40__pop39_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1__push40__pop39_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push40__pop39_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1__push40__pop39_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1__push40__pop39_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1__push40__pop39_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1__push40__pop39_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1__push40__pop39_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1__push40__pop39_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push40__pop39_stall_in = 1'b0;
assign rnode_169to171_bb1__push40__pop39_0_NO_SHIFT_REG = rnode_169to171_bb1__push40__pop39_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1__push40__pop39_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push40__pop39_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_4_2_stall_local;
wire local_bb1_not_cmp16_4_2;

assign local_bb1_not_cmp16_4_2 = (rnode_168to169_bb1_cmp16_4_2_1_NO_SHIFT_REG ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1__push49__pop48_inputs_ready;
 reg local_bb1__push49__pop48_valid_out_NO_SHIFT_REG;
wire local_bb1__push49__pop48_stall_in;
wire local_bb1__push49__pop48_output_regs_ready;
wire [7:0] local_bb1__push49__pop48_result;
wire local_bb1__push49__pop48_fu_valid_out;
wire local_bb1__push49__pop48_fu_stall_out;
 reg [7:0] local_bb1__push49__pop48_NO_SHIFT_REG;
wire local_bb1__push49__pop48_causedstall;

acl_push local_bb1__push49__pop48_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_169to170_bb1_c0_ene2_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(rnode_169to170_bb1__pop48__0_NO_SHIFT_REG),
	.stall_out(local_bb1__push49__pop48_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[8]),
	.valid_out(local_bb1__push49__pop48_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push49__pop48_result),
	.feedback_out(feedback_data_out_49),
	.feedback_valid_out(feedback_valid_out_49),
	.feedback_stall_in(feedback_stall_in_49)
);

defparam local_bb1__push49__pop48_feedback.STALLFREE = 1;
defparam local_bb1__push49__pop48_feedback.DATA_WIDTH = 8;
defparam local_bb1__push49__pop48_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push49__pop48_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push49__pop48_feedback.STYLE = "REGULAR";

assign local_bb1__push49__pop48_inputs_ready = 1'b1;
assign local_bb1__push49__pop48_output_regs_ready = 1'b1;
assign rnode_169to170_bb1__pop48__0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1__push49__pop48_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[8] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push49__pop48_NO_SHIFT_REG <= 'x;
		local_bb1__push49__pop48_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push49__pop48_output_regs_ready)
		begin
			local_bb1__push49__pop48_NO_SHIFT_REG <= local_bb1__push49__pop48_result;
			local_bb1__push49__pop48_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push49__pop48_stall_in))
			begin
				local_bb1__push49__pop48_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_13_2_stall_local;
wire local_bb1_cmp16_13_2;

assign local_bb1_cmp16_13_2 = (rnode_169to170_bb1__pop48__1_NO_SHIFT_REG == 8'h0);

// This section implements a registered operation.
// 
wire local_bb1__push44__pop43_inputs_ready;
 reg local_bb1__push44__pop43_valid_out_NO_SHIFT_REG;
wire local_bb1__push44__pop43_stall_in;
wire local_bb1__push44__pop43_output_regs_ready;
wire [7:0] local_bb1__push44__pop43_result;
wire local_bb1__push44__pop43_fu_valid_out;
wire local_bb1__push44__pop43_fu_stall_out;
 reg [7:0] local_bb1__push44__pop43_NO_SHIFT_REG;
wire local_bb1__push44__pop43_causedstall;

acl_push local_bb1__push44__pop43_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene2_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop43_),
	.stall_out(local_bb1__push44__pop43_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__push44__pop43_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push44__pop43_result),
	.feedback_out(feedback_data_out_44),
	.feedback_valid_out(feedback_valid_out_44),
	.feedback_stall_in(feedback_stall_in_44)
);

defparam local_bb1__push44__pop43_feedback.STALLFREE = 1;
defparam local_bb1__push44__pop43_feedback.DATA_WIDTH = 8;
defparam local_bb1__push44__pop43_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push44__pop43_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push44__pop43_feedback.STYLE = "REGULAR";

assign local_bb1__push44__pop43_inputs_ready = 1'b1;
assign local_bb1__push44__pop43_output_regs_ready = 1'b1;
assign local_bb1__pop43__stall_in_0 = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1__push44__pop43_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[7] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push44__pop43_NO_SHIFT_REG <= 'x;
		local_bb1__push44__pop43_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push44__pop43_output_regs_ready)
		begin
			local_bb1__push44__pop43_NO_SHIFT_REG <= local_bb1__push44__pop43_result;
			local_bb1__push44__pop43_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push44__pop43_stall_in))
			begin
				local_bb1__push44__pop43_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cmp16_8_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_8_2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cmp16_8_2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cmp16_8_2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cmp16_8_2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cmp16_8_2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cmp16_8_2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_8_2),
	.data_out(rnode_169to170_bb1_cmp16_8_2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cmp16_8_2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_cmp16_8_2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_cmp16_8_2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_cmp16_8_2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_cmp16_8_2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_8_2_stall_in = 1'b0;
assign rnode_169to170_bb1_cmp16_8_2_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_8_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_8_2_0_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_8_2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp16_8_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_8_2_1_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_8_2_0_reg_170_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push45__pop44_inputs_ready;
 reg local_bb1__push45__pop44_valid_out_NO_SHIFT_REG;
wire local_bb1__push45__pop44_stall_in;
wire local_bb1__push45__pop44_output_regs_ready;
wire [7:0] local_bb1__push45__pop44_result;
wire local_bb1__push45__pop44_fu_valid_out;
wire local_bb1__push45__pop44_fu_stall_out;
 reg [7:0] local_bb1__push45__pop44_NO_SHIFT_REG;
wire local_bb1__push45__pop44_causedstall;

acl_push local_bb1__push45__pop44_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene2_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop44_),
	.stall_out(local_bb1__push45__pop44_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__push45__pop44_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push45__pop44_result),
	.feedback_out(feedback_data_out_45),
	.feedback_valid_out(feedback_valid_out_45),
	.feedback_stall_in(feedback_stall_in_45)
);

defparam local_bb1__push45__pop44_feedback.STALLFREE = 1;
defparam local_bb1__push45__pop44_feedback.DATA_WIDTH = 8;
defparam local_bb1__push45__pop44_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push45__pop44_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push45__pop44_feedback.STYLE = "REGULAR";

assign local_bb1__push45__pop44_inputs_ready = 1'b1;
assign local_bb1__push45__pop44_output_regs_ready = 1'b1;
assign local_bb1__pop44__stall_in_0 = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign local_bb1__push45__pop44_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[7] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push45__pop44_NO_SHIFT_REG <= 'x;
		local_bb1__push45__pop44_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push45__pop44_output_regs_ready)
		begin
			local_bb1__push45__pop44_NO_SHIFT_REG <= local_bb1__push45__pop44_result;
			local_bb1__push45__pop44_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push45__pop44_stall_in))
			begin
				local_bb1__push45__pop44_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cmp16_9_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_9_2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cmp16_9_2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cmp16_9_2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cmp16_9_2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cmp16_9_2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cmp16_9_2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_9_2),
	.data_out(rnode_169to170_bb1_cmp16_9_2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cmp16_9_2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_cmp16_9_2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_cmp16_9_2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_cmp16_9_2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_cmp16_9_2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_9_2_stall_in = 1'b0;
assign rnode_169to170_bb1_cmp16_9_2_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_9_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_9_2_0_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_9_2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp16_9_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_9_2_1_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_9_2_0_reg_170_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push47__pop46_inputs_ready;
 reg local_bb1__push47__pop46_valid_out_NO_SHIFT_REG;
wire local_bb1__push47__pop46_stall_in;
wire local_bb1__push47__pop46_output_regs_ready;
wire [7:0] local_bb1__push47__pop46_result;
wire local_bb1__push47__pop46_fu_valid_out;
wire local_bb1__push47__pop46_fu_stall_out;
 reg [7:0] local_bb1__push47__pop46_NO_SHIFT_REG;
wire local_bb1__push47__pop46_causedstall;

acl_push local_bb1__push47__pop46_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene2_3_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop46_),
	.stall_out(local_bb1__push47__pop46_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__push47__pop46_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push47__pop46_result),
	.feedback_out(feedback_data_out_47),
	.feedback_valid_out(feedback_valid_out_47),
	.feedback_stall_in(feedback_stall_in_47)
);

defparam local_bb1__push47__pop46_feedback.STALLFREE = 1;
defparam local_bb1__push47__pop46_feedback.DATA_WIDTH = 8;
defparam local_bb1__push47__pop46_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push47__pop46_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push47__pop46_feedback.STYLE = "REGULAR";

assign local_bb1__push47__pop46_inputs_ready = 1'b1;
assign local_bb1__push47__pop46_output_regs_ready = 1'b1;
assign local_bb1__pop46__stall_in_0 = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign local_bb1__push47__pop46_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[7] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push47__pop46_NO_SHIFT_REG <= 'x;
		local_bb1__push47__pop46_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push47__pop46_output_regs_ready)
		begin
			local_bb1__push47__pop46_NO_SHIFT_REG <= local_bb1__push47__pop46_result;
			local_bb1__push47__pop46_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push47__pop46_stall_in))
			begin
				local_bb1__push47__pop46_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cmp16_11_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_11_2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cmp16_11_2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cmp16_11_2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cmp16_11_2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cmp16_11_2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cmp16_11_2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_11_2),
	.data_out(rnode_169to170_bb1_cmp16_11_2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cmp16_11_2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_cmp16_11_2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_cmp16_11_2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_cmp16_11_2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_cmp16_11_2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_11_2_stall_in = 1'b0;
assign rnode_169to170_bb1_cmp16_11_2_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_11_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_11_2_0_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_11_2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp16_11_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_11_2_1_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_11_2_0_reg_170_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push48__pop47_inputs_ready;
 reg local_bb1__push48__pop47_valid_out_NO_SHIFT_REG;
wire local_bb1__push48__pop47_stall_in;
wire local_bb1__push48__pop47_output_regs_ready;
wire [7:0] local_bb1__push48__pop47_result;
wire local_bb1__push48__pop47_fu_valid_out;
wire local_bb1__push48__pop47_fu_stall_out;
 reg [7:0] local_bb1__push48__pop47_NO_SHIFT_REG;
wire local_bb1__push48__pop47_causedstall;

acl_push local_bb1__push48__pop47_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene2_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop47_),
	.stall_out(local_bb1__push48__pop47_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__push48__pop47_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push48__pop47_result),
	.feedback_out(feedback_data_out_48),
	.feedback_valid_out(feedback_valid_out_48),
	.feedback_stall_in(feedback_stall_in_48)
);

defparam local_bb1__push48__pop47_feedback.STALLFREE = 1;
defparam local_bb1__push48__pop47_feedback.DATA_WIDTH = 8;
defparam local_bb1__push48__pop47_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push48__pop47_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push48__pop47_feedback.STYLE = "REGULAR";

assign local_bb1__push48__pop47_inputs_ready = 1'b1;
assign local_bb1__push48__pop47_output_regs_ready = 1'b1;
assign local_bb1__pop47__stall_in_0 = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG = 1'b0;
assign local_bb1__push48__pop47_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[7] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push48__pop47_NO_SHIFT_REG <= 'x;
		local_bb1__push48__pop47_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push48__pop47_output_regs_ready)
		begin
			local_bb1__push48__pop47_NO_SHIFT_REG <= local_bb1__push48__pop47_result;
			local_bb1__push48__pop47_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push48__pop47_stall_in))
			begin
				local_bb1__push48__pop47_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cmp16_12_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_12_2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cmp16_12_2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cmp16_12_2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cmp16_12_2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cmp16_12_2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cmp16_12_2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_12_2),
	.data_out(rnode_169to170_bb1_cmp16_12_2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cmp16_12_2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_cmp16_12_2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_cmp16_12_2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_cmp16_12_2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_cmp16_12_2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_12_2_stall_in = 1'b0;
assign rnode_169to170_bb1_cmp16_12_2_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_12_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_12_2_0_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_12_2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp16_12_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_12_2_1_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_12_2_0_reg_170_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push46__pop45_inputs_ready;
 reg local_bb1__push46__pop45_valid_out_NO_SHIFT_REG;
wire local_bb1__push46__pop45_stall_in;
wire local_bb1__push46__pop45_output_regs_ready;
wire [7:0] local_bb1__push46__pop45_result;
wire local_bb1__push46__pop45_fu_valid_out;
wire local_bb1__push46__pop45_fu_stall_out;
 reg [7:0] local_bb1__push46__pop45_NO_SHIFT_REG;
wire local_bb1__push46__pop45_causedstall;

acl_push local_bb1__push46__pop45_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_168to169_bb1_c0_ene2_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop45_),
	.stall_out(local_bb1__push46__pop45_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[7]),
	.valid_out(local_bb1__push46__pop45_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push46__pop45_result),
	.feedback_out(feedback_data_out_46),
	.feedback_valid_out(feedback_valid_out_46),
	.feedback_stall_in(feedback_stall_in_46)
);

defparam local_bb1__push46__pop45_feedback.STALLFREE = 1;
defparam local_bb1__push46__pop45_feedback.DATA_WIDTH = 8;
defparam local_bb1__push46__pop45_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push46__pop45_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push46__pop45_feedback.STYLE = "REGULAR";

assign local_bb1__push46__pop45_inputs_ready = 1'b1;
assign local_bb1__push46__pop45_output_regs_ready = 1'b1;
assign local_bb1__pop45__stall_in_0 = 1'b0;
assign rnode_168to169_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign local_bb1__push46__pop45_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[7] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push46__pop45_NO_SHIFT_REG <= 'x;
		local_bb1__push46__pop45_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push46__pop45_output_regs_ready)
		begin
			local_bb1__push46__pop45_NO_SHIFT_REG <= local_bb1__push46__pop45_result;
			local_bb1__push46__pop45_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push46__pop45_stall_in))
			begin
				local_bb1__push46__pop45_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cmp16_10_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp16_10_2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cmp16_10_2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cmp16_10_2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cmp16_10_2_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cmp16_10_2_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cmp16_10_2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_10_2),
	.data_out(rnode_169to170_bb1_cmp16_10_2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cmp16_10_2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_cmp16_10_2_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_cmp16_10_2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_cmp16_10_2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_cmp16_10_2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_10_2_stall_in = 1'b0;
assign rnode_169to170_bb1_cmp16_10_2_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_10_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_10_2_0_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_10_2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp16_10_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp16_10_2_1_NO_SHIFT_REG = rnode_169to170_bb1_cmp16_10_2_0_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1__pop49__valid_out_0;
wire local_bb1__pop49__stall_in_0;
 reg local_bb1__pop49__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_14_2_valid_out;
wire local_bb1_cmp16_14_2_stall_in;
 reg local_bb1_cmp16_14_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_14_2_inputs_ready;
wire local_bb1_cmp16_14_2_stall_local;
wire local_bb1_cmp16_14_2;

assign local_bb1_cmp16_14_2_inputs_ready = rnode_169to170_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cmp16_14_2 = (local_bb1__pop49_ == 8'h0);
assign local_bb1__pop49__valid_out_0 = 1'b1;
assign local_bb1_cmp16_14_2_valid_out = 1'b1;
assign rnode_169to170_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop49__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_14_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop49__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_14_2_inputs_ready & (local_bb1__pop49__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop49__stall_in_0)) & local_bb1_cmp16_14_2_stall_local);
		local_bb1_cmp16_14_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_14_2_inputs_ready & (local_bb1_cmp16_14_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_14_2_stall_in)) & local_bb1_cmp16_14_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__pop50__valid_out_0;
wire local_bb1__pop50__stall_in_0;
 reg local_bb1__pop50__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_15_2_valid_out;
wire local_bb1_cmp16_15_2_stall_in;
 reg local_bb1_cmp16_15_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_15_2_inputs_ready;
wire local_bb1_cmp16_15_2_stall_local;
wire local_bb1_cmp16_15_2;

assign local_bb1_cmp16_15_2_inputs_ready = rnode_169to170_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp16_15_2 = (local_bb1__pop50_ == 8'h0);
assign local_bb1__pop50__valid_out_0 = 1'b1;
assign local_bb1_cmp16_15_2_valid_out = 1'b1;
assign rnode_169to170_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__pop50__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_15_2_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__pop50__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_15_2_inputs_ready & (local_bb1__pop50__consumed_0_NO_SHIFT_REG | ~(local_bb1__pop50__stall_in_0)) & local_bb1_cmp16_15_2_stall_local);
		local_bb1_cmp16_15_2_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_15_2_inputs_ready & (local_bb1_cmp16_15_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_15_2_stall_in)) & local_bb1_cmp16_15_2_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_cmp16_16_2_valid_out;
wire local_bb1_cmp16_16_2_stall_in;
wire local_bb1_cmp16_16_2_inputs_ready;
wire local_bb1_cmp16_16_2_stall_local;
wire local_bb1_cmp16_16_2;

assign local_bb1_cmp16_16_2_inputs_ready = rnode_169to170_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_cmp16_16_2 = (local_bb1__pop51_ == 8'h0);
assign local_bb1_cmp16_16_2_valid_out = 1'b1;
assign rnode_169to170_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1__337_stall_local;
wire [7:0] local_bb1__337;

assign local_bb1__337 = (local_bb1__336_demorgan ? 8'h1 : local_bb1__335);

// This section implements an unregistered operation.
// 
wire local_bb1__coalesced_pop2__stall_local;
wire [7:0] local_bb1__coalesced_pop2_;
wire local_bb1__coalesced_pop2__fu_valid_out;
wire local_bb1__coalesced_pop2__fu_stall_out;

acl_pop local_bb1__coalesced_pop2__feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_not_select6_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in('x),
	.stall_out(local_bb1__coalesced_pop2__fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__coalesced_pop2__fu_valid_out),
	.stall_in(local_bb1__coalesced_pop2__stall_local),
	.data_out(local_bb1__coalesced_pop2_),
	.feedback_in(feedback_data_in_2),
	.feedback_valid_in(feedback_valid_in_2),
	.feedback_stall_out(feedback_stall_out_2)
);

defparam local_bb1__coalesced_pop2__feedback.DATA_WIDTH = 8;
defparam local_bb1__coalesced_pop2__feedback.STYLE = "COALESCE";

assign local_bb1__coalesced_pop2__stall_local = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_NO_SHIFT_REG;
 logic [10:0] rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [10:0] rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_fifo.DATA_WIDTH = 11;
defparam rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_NO_SHIFT_REG = rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_7_2_stall_local;
wire local_bb1_not_cmp16_7_2;

assign local_bb1_not_cmp16_7_2 = (rnode_169to170_bb1_cmp16_7_2_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_13_2_stall_local;
wire local_bb1_not_cmp16_13_2;

assign local_bb1_not_cmp16_13_2 = (local_bb1_cmp16_13_2 ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__push44__pop43_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push44__pop43_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push44__pop43_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push44__pop43_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push44__pop43_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push44__pop43_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push44__pop43_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push44__pop43_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__push44__pop43_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__push44__pop43_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__push44__pop43_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__push44__pop43_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__push44__pop43_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push44__pop43_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1__push44__pop43_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__push44__pop43_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__push44__pop43_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1__push44__pop43_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__push44__pop43_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__push44__pop43_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push44__pop43_stall_in = 1'b0;
assign rnode_170to171_bb1__push44__pop43_0_NO_SHIFT_REG = rnode_170to171_bb1__push44__pop43_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__push44__pop43_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push44__pop43_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_8_2_stall_local;
wire local_bb1_not_cmp16_8_2;

assign local_bb1_not_cmp16_8_2 = (rnode_169to170_bb1_cmp16_8_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__push45__pop44_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push45__pop44_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push45__pop44_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push45__pop44_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push45__pop44_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push45__pop44_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push45__pop44_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push45__pop44_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__push45__pop44_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__push45__pop44_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__push45__pop44_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__push45__pop44_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__push45__pop44_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push45__pop44_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1__push45__pop44_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__push45__pop44_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__push45__pop44_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1__push45__pop44_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__push45__pop44_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__push45__pop44_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push45__pop44_stall_in = 1'b0;
assign rnode_170to171_bb1__push45__pop44_0_NO_SHIFT_REG = rnode_170to171_bb1__push45__pop44_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__push45__pop44_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push45__pop44_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_9_2_stall_local;
wire local_bb1_not_cmp16_9_2;

assign local_bb1_not_cmp16_9_2 = (rnode_169to170_bb1_cmp16_9_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__push47__pop46_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push47__pop46_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push47__pop46_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push47__pop46_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push47__pop46_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push47__pop46_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push47__pop46_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push47__pop46_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__push47__pop46_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__push47__pop46_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__push47__pop46_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__push47__pop46_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__push47__pop46_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push47__pop46_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1__push47__pop46_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__push47__pop46_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__push47__pop46_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1__push47__pop46_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__push47__pop46_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__push47__pop46_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push47__pop46_stall_in = 1'b0;
assign rnode_170to171_bb1__push47__pop46_0_NO_SHIFT_REG = rnode_170to171_bb1__push47__pop46_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__push47__pop46_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push47__pop46_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_11_2_stall_local;
wire local_bb1_not_cmp16_11_2;

assign local_bb1_not_cmp16_11_2 = (rnode_169to170_bb1_cmp16_11_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__push48__pop47_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push48__pop47_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push48__pop47_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push48__pop47_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push48__pop47_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push48__pop47_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push48__pop47_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push48__pop47_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__push48__pop47_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__push48__pop47_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__push48__pop47_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__push48__pop47_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__push48__pop47_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push48__pop47_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1__push48__pop47_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__push48__pop47_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__push48__pop47_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1__push48__pop47_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__push48__pop47_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__push48__pop47_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push48__pop47_stall_in = 1'b0;
assign rnode_170to171_bb1__push48__pop47_0_NO_SHIFT_REG = rnode_170to171_bb1__push48__pop47_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__push48__pop47_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push48__pop47_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_12_2_stall_local;
wire local_bb1_not_cmp16_12_2;

assign local_bb1_not_cmp16_12_2 = (rnode_169to170_bb1_cmp16_12_2_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__push46__pop45_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push46__pop45_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push46__pop45_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push46__pop45_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1__push46__pop45_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push46__pop45_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push46__pop45_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__push46__pop45_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__push46__pop45_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__push46__pop45_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__push46__pop45_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__push46__pop45_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__push46__pop45_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push46__pop45_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1__push46__pop45_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__push46__pop45_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__push46__pop45_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1__push46__pop45_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__push46__pop45_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__push46__pop45_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push46__pop45_stall_in = 1'b0;
assign rnode_170to171_bb1__push46__pop45_0_NO_SHIFT_REG = rnode_170to171_bb1__push46__pop45_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__push46__pop45_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push46__pop45_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_10_2_stall_local;
wire local_bb1_not_cmp16_10_2;

assign local_bb1_not_cmp16_10_2 = (rnode_169to170_bb1_cmp16_10_2_1_NO_SHIFT_REG ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1__push50__pop49_inputs_ready;
 reg local_bb1__push50__pop49_valid_out_NO_SHIFT_REG;
wire local_bb1__push50__pop49_stall_in;
wire local_bb1__push50__pop49_output_regs_ready;
wire [7:0] local_bb1__push50__pop49_result;
wire local_bb1__push50__pop49_fu_valid_out;
wire local_bb1__push50__pop49_fu_stall_out;
 reg [7:0] local_bb1__push50__pop49_NO_SHIFT_REG;
wire local_bb1__push50__pop49_causedstall;

acl_push local_bb1__push50__pop49_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_169to170_bb1_c0_ene2_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop49_),
	.stall_out(local_bb1__push50__pop49_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[8]),
	.valid_out(local_bb1__push50__pop49_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push50__pop49_result),
	.feedback_out(feedback_data_out_50),
	.feedback_valid_out(feedback_valid_out_50),
	.feedback_stall_in(feedback_stall_in_50)
);

defparam local_bb1__push50__pop49_feedback.STALLFREE = 1;
defparam local_bb1__push50__pop49_feedback.DATA_WIDTH = 8;
defparam local_bb1__push50__pop49_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push50__pop49_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push50__pop49_feedback.STYLE = "REGULAR";

assign local_bb1__push50__pop49_inputs_ready = 1'b1;
assign local_bb1__push50__pop49_output_regs_ready = 1'b1;
assign local_bb1__pop49__stall_in_0 = 1'b0;
assign rnode_169to170_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1__push50__pop49_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[8] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push50__pop49_NO_SHIFT_REG <= 'x;
		local_bb1__push50__pop49_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push50__pop49_output_regs_ready)
		begin
			local_bb1__push50__pop49_NO_SHIFT_REG <= local_bb1__push50__pop49_result;
			local_bb1__push50__pop49_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push50__pop49_stall_in))
			begin
				local_bb1__push50__pop49_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_cmp16_14_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_14_2_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_cmp16_14_2_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_cmp16_14_2_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_cmp16_14_2_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_cmp16_14_2_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_cmp16_14_2_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_14_2),
	.data_out(rnode_170to171_bb1_cmp16_14_2_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_cmp16_14_2_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_cmp16_14_2_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb1_cmp16_14_2_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_cmp16_14_2_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_cmp16_14_2_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_14_2_stall_in = 1'b0;
assign rnode_170to171_bb1_cmp16_14_2_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_14_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_cmp16_14_2_0_NO_SHIFT_REG = rnode_170to171_bb1_cmp16_14_2_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_cmp16_14_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_cmp16_14_2_1_NO_SHIFT_REG = rnode_170to171_bb1_cmp16_14_2_0_reg_171_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1__push51__pop50_inputs_ready;
 reg local_bb1__push51__pop50_valid_out_NO_SHIFT_REG;
wire local_bb1__push51__pop50_stall_in;
wire local_bb1__push51__pop50_output_regs_ready;
wire [7:0] local_bb1__push51__pop50_result;
wire local_bb1__push51__pop50_fu_valid_out;
wire local_bb1__push51__pop50_fu_stall_out;
 reg [7:0] local_bb1__push51__pop50_NO_SHIFT_REG;
wire local_bb1__push51__pop50_causedstall;

acl_push local_bb1__push51__pop50_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_169to170_bb1_c0_ene2_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__pop50_),
	.stall_out(local_bb1__push51__pop50_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[8]),
	.valid_out(local_bb1__push51__pop50_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push51__pop50_result),
	.feedback_out(feedback_data_out_51),
	.feedback_valid_out(feedback_valid_out_51),
	.feedback_stall_in(feedback_stall_in_51)
);

defparam local_bb1__push51__pop50_feedback.STALLFREE = 1;
defparam local_bb1__push51__pop50_feedback.DATA_WIDTH = 8;
defparam local_bb1__push51__pop50_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push51__pop50_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push51__pop50_feedback.STYLE = "REGULAR";

assign local_bb1__push51__pop50_inputs_ready = 1'b1;
assign local_bb1__push51__pop50_output_regs_ready = 1'b1;
assign local_bb1__pop50__stall_in_0 = 1'b0;
assign rnode_169to170_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign local_bb1__push51__pop50_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[8] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push51__pop50_NO_SHIFT_REG <= 'x;
		local_bb1__push51__pop50_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push51__pop50_output_regs_ready)
		begin
			local_bb1__push51__pop50_NO_SHIFT_REG <= local_bb1__push51__pop50_result;
			local_bb1__push51__pop50_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push51__pop50_stall_in))
			begin
				local_bb1__push51__pop50_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_cmp16_15_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_15_2_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_cmp16_15_2_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_cmp16_15_2_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_cmp16_15_2_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_cmp16_15_2_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_cmp16_15_2_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_15_2),
	.data_out(rnode_170to171_bb1_cmp16_15_2_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_cmp16_15_2_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_cmp16_15_2_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb1_cmp16_15_2_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_cmp16_15_2_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_cmp16_15_2_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_15_2_stall_in = 1'b0;
assign rnode_170to171_bb1_cmp16_15_2_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_15_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_cmp16_15_2_0_NO_SHIFT_REG = rnode_170to171_bb1_cmp16_15_2_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_cmp16_15_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_cmp16_15_2_1_NO_SHIFT_REG = rnode_170to171_bb1_cmp16_15_2_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_cmp16_16_2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_cmp16_16_2_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_cmp16_16_2_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_cmp16_16_2_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_cmp16_16_2_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_cmp16_16_2_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_cmp16_16_2_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_16_2),
	.data_out(rnode_170to171_bb1_cmp16_16_2_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_cmp16_16_2_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_cmp16_16_2_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb1_cmp16_16_2_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_cmp16_16_2_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_cmp16_16_2_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_16_2_stall_in = 1'b0;
assign rnode_170to171_bb1_cmp16_16_2_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_16_2_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_cmp16_16_2_0_NO_SHIFT_REG = rnode_170to171_bb1_cmp16_16_2_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_cmp16_16_2_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_cmp16_16_2_1_NO_SHIFT_REG = rnode_170to171_bb1_cmp16_16_2_0_reg_171_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1__339_stall_local;
wire [7:0] local_bb1__339;

assign local_bb1__339 = (local_bb1__338 ? 8'h0 : local_bb1__337);

// This section implements an unregistered operation.
// 
wire local_bb1__coalesced_pop2__valid_out_0;
wire local_bb1__coalesced_pop2__stall_in_0;
 reg local_bb1__coalesced_pop2__consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_228_valid_out;
wire local_bb1_cmp16_228_stall_in;
 reg local_bb1_cmp16_228_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp16_228_inputs_ready;
wire local_bb1_cmp16_228_stall_local;
wire local_bb1_cmp16_228;

assign local_bb1_cmp16_228_inputs_ready = rnode_167to168_bb1_not_select6_0_valid_out_NO_SHIFT_REG;
assign local_bb1_cmp16_228 = (local_bb1__coalesced_pop2_ == 8'h0);
assign local_bb1__coalesced_pop2__valid_out_0 = 1'b1;
assign local_bb1_cmp16_228_valid_out = 1'b1;
assign rnode_167to168_bb1_not_select6_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__coalesced_pop2__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp16_228_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__coalesced_pop2__consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_228_inputs_ready & (local_bb1__coalesced_pop2__consumed_0_NO_SHIFT_REG | ~(local_bb1__coalesced_pop2__stall_in_0)) & local_bb1_cmp16_228_stall_local);
		local_bb1_cmp16_228_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp16_228_inputs_ready & (local_bb1_cmp16_228_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp16_228_stall_in)) & local_bb1_cmp16_228_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_14_2_stall_local;
wire local_bb1_not_cmp16_14_2;

assign local_bb1_not_cmp16_14_2 = (rnode_170to171_bb1_cmp16_14_2_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_15_2_stall_local;
wire local_bb1_not_cmp16_15_2;

assign local_bb1_not_cmp16_15_2 = (rnode_170to171_bb1_cmp16_15_2_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_16_2_stall_local;
wire local_bb1_not_cmp16_16_2;

assign local_bb1_not_cmp16_16_2 = (rnode_170to171_bb1_cmp16_16_2_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u2_stall_local;
wire [7:0] local_bb1_var__u2;

assign local_bb1_var__u2 = (local_bb1__339 & 8'h1);

// This section implements a registered operation.
// 
wire local_bb1__push36__coalesced_pop2_inputs_ready;
 reg local_bb1__push36__coalesced_pop2_valid_out_NO_SHIFT_REG;
wire local_bb1__push36__coalesced_pop2_stall_in;
wire local_bb1__push36__coalesced_pop2_output_regs_ready;
wire [7:0] local_bb1__push36__coalesced_pop2_result;
wire local_bb1__push36__coalesced_pop2_fu_valid_out;
wire local_bb1__push36__coalesced_pop2_fu_stall_out;
 reg [7:0] local_bb1__push36__coalesced_pop2_NO_SHIFT_REG;
wire local_bb1__push36__coalesced_pop2_causedstall;

acl_push local_bb1__push36__coalesced_pop2_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_8_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1__coalesced_pop2_),
	.stall_out(local_bb1__push36__coalesced_pop2_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__push36__coalesced_pop2_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__push36__coalesced_pop2_result),
	.feedback_out(feedback_data_out_36),
	.feedback_valid_out(feedback_valid_out_36),
	.feedback_stall_in(feedback_stall_in_36)
);

defparam local_bb1__push36__coalesced_pop2_feedback.STALLFREE = 1;
defparam local_bb1__push36__coalesced_pop2_feedback.DATA_WIDTH = 8;
defparam local_bb1__push36__coalesced_pop2_feedback.FIFO_DEPTH = 1;
defparam local_bb1__push36__coalesced_pop2_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1__push36__coalesced_pop2_feedback.STYLE = "REGULAR";

assign local_bb1__push36__coalesced_pop2_inputs_ready = 1'b1;
assign local_bb1__push36__coalesced_pop2_output_regs_ready = 1'b1;
assign local_bb1__coalesced_pop2__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_8_NO_SHIFT_REG = 1'b0;
assign local_bb1__push36__coalesced_pop2_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__push36__coalesced_pop2_NO_SHIFT_REG <= 'x;
		local_bb1__push36__coalesced_pop2_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__push36__coalesced_pop2_output_regs_ready)
		begin
			local_bb1__push36__coalesced_pop2_NO_SHIFT_REG <= local_bb1__push36__coalesced_pop2_result;
			local_bb1__push36__coalesced_pop2_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__push36__coalesced_pop2_stall_in))
			begin
				local_bb1__push36__coalesced_pop2_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_cmp16_228_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_cmp16_228_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_cmp16_228_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_cmp16_228_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_cmp16_228_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_cmp16_228_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_cmp16_228_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_cmp16_228),
	.data_out(rnode_168to169_bb1_cmp16_228_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_cmp16_228_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_cmp16_228_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1_cmp16_228_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_cmp16_228_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_cmp16_228_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp16_228_stall_in = 1'b0;
assign rnode_168to169_bb1_cmp16_228_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_228_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_228_0_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_228_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_cmp16_228_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_cmp16_228_1_NO_SHIFT_REG = rnode_168to169_bb1_cmp16_228_0_reg_169_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_3_stall_local;
wire local_bb1_cmp19_3;

assign local_bb1_cmp19_3 = (local_bb1_var__u2 == 8'h0);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1__push36__coalesced_pop2_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push36__coalesced_pop2_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push36__coalesced_pop2_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push36__coalesced_pop2_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push36__coalesced_pop2_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__push36__coalesced_pop2_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1__push36__coalesced_pop2_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1__push36__coalesced_pop2_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1__push36__coalesced_pop2_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__push36__coalesced_pop2_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__push36__coalesced_pop2_stall_in = 1'b0;
assign rnode_169to171_bb1__push36__coalesced_pop2_0_NO_SHIFT_REG = rnode_169to171_bb1__push36__coalesced_pop2_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1__push36__coalesced_pop2_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push36__coalesced_pop2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp16_228_stall_local;
wire local_bb1_not_cmp16_228;

assign local_bb1_not_cmp16_228 = (rnode_168to169_bb1_cmp16_228_1_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1__340_demorgan_stall_local;
wire local_bb1__340_demorgan;

assign local_bb1__340_demorgan = (local_bb1_cmp16_3 | local_bb1_cmp19_3);

// This section implements an unregistered operation.
// 
wire local_bb1__342_stall_local;
wire local_bb1__342;

assign local_bb1__342 = (local_bb1_cmp19_3 & local_bb1_not_cmp16_3);

// This section implements an unregistered operation.
// 
wire local_bb1__341_stall_local;
wire [7:0] local_bb1__341;

assign local_bb1__341 = (local_bb1__340_demorgan ? 8'h1 : local_bb1__339);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_1_0_pop34__valid_out_0;
wire local_bb1_rows_1_0_pop34__stall_in_0;
 reg local_bb1_rows_1_0_pop34__consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_0_0_pop35__valid_out_0;
wire local_bb1_rows_0_0_pop35__stall_in_0;
 reg local_bb1_rows_0_0_pop35__consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_2_0_pop33__valid_out_0;
wire local_bb1_rows_2_0_pop33__stall_in_0;
 reg local_bb1_rows_2_0_pop33__consumed_0_NO_SHIFT_REG;
wire local_bb1__343_valid_out;
wire local_bb1__343_stall_in;
 reg local_bb1__343_consumed_0_NO_SHIFT_REG;
wire local_bb1__343_inputs_ready;
wire local_bb1__343_stall_local;
wire [7:0] local_bb1__343;

assign local_bb1__343_inputs_ready = (local_bb1_c0_ene1_valid_out_0_NO_SHIFT_REG & local_bb1_c0_ene1_valid_out_1_NO_SHIFT_REG & rnode_163to164_bb1_c0_ene3_0_valid_out_1_NO_SHIFT_REG & local_bb1_c0_ene1_valid_out_2_NO_SHIFT_REG);
assign local_bb1__343 = (local_bb1__342 ? 8'h0 : local_bb1__341);
assign local_bb1_rows_1_0_pop34__valid_out_0 = 1'b1;
assign local_bb1_rows_0_0_pop35__valid_out_0 = 1'b1;
assign local_bb1_rows_2_0_pop33__valid_out_0 = 1'b1;
assign local_bb1__343_valid_out = 1'b1;
assign local_bb1_c0_ene1_stall_in_0 = 1'b0;
assign local_bb1_c0_ene1_stall_in_1 = 1'b0;
assign rnode_163to164_bb1_c0_ene3_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_c0_ene1_stall_in_2 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_1_0_pop34__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_0_0_pop35__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_2_0_pop33__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__343_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_1_0_pop34__consumed_0_NO_SHIFT_REG <= (local_bb1__343_inputs_ready & (local_bb1_rows_1_0_pop34__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_1_0_pop34__stall_in_0)) & local_bb1__343_stall_local);
		local_bb1_rows_0_0_pop35__consumed_0_NO_SHIFT_REG <= (local_bb1__343_inputs_ready & (local_bb1_rows_0_0_pop35__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_0_0_pop35__stall_in_0)) & local_bb1__343_stall_local);
		local_bb1_rows_2_0_pop33__consumed_0_NO_SHIFT_REG <= (local_bb1__343_inputs_ready & (local_bb1_rows_2_0_pop33__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_2_0_pop33__stall_in_0)) & local_bb1__343_stall_local);
		local_bb1__343_consumed_0_NO_SHIFT_REG <= (local_bb1__343_inputs_ready & (local_bb1__343_consumed_0_NO_SHIFT_REG | ~(local_bb1__343_stall_in)) & local_bb1__343_stall_local);
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_2_0_push33_rows_1_0_pop34_inputs_ready;
 reg local_bb1_rows_2_0_push33_rows_1_0_pop34_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_2_0_push33_rows_1_0_pop34_stall_in;
wire local_bb1_rows_2_0_push33_rows_1_0_pop34_output_regs_ready;
wire [7:0] local_bb1_rows_2_0_push33_rows_1_0_pop34_result;
wire local_bb1_rows_2_0_push33_rows_1_0_pop34_fu_valid_out;
wire local_bb1_rows_2_0_push33_rows_1_0_pop34_fu_stall_out;
 reg [7:0] local_bb1_rows_2_0_push33_rows_1_0_pop34_NO_SHIFT_REG;
wire local_bb1_rows_2_0_push33_rows_1_0_pop34_causedstall;

acl_push local_bb1_rows_2_0_push33_rows_1_0_pop34_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_1_0_pop34_),
	.stall_out(local_bb1_rows_2_0_push33_rows_1_0_pop34_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_2_0_push33_rows_1_0_pop34_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_2_0_push33_rows_1_0_pop34_result),
	.feedback_out(feedback_data_out_33),
	.feedback_valid_out(feedback_valid_out_33),
	.feedback_stall_in(feedback_stall_in_33)
);

defparam local_bb1_rows_2_0_push33_rows_1_0_pop34_feedback.STALLFREE = 1;
defparam local_bb1_rows_2_0_push33_rows_1_0_pop34_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_2_0_push33_rows_1_0_pop34_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_2_0_push33_rows_1_0_pop34_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_2_0_push33_rows_1_0_pop34_feedback.STYLE = "REGULAR";

assign local_bb1_rows_2_0_push33_rows_1_0_pop34_inputs_ready = 1'b1;
assign local_bb1_rows_2_0_push33_rows_1_0_pop34_output_regs_ready = 1'b1;
assign local_bb1_rows_1_0_pop34__stall_in_0 = 1'b0;
assign local_bb1_c0_ene2_stall_in_1 = 1'b0;
assign local_bb1_rows_2_0_push33_rows_1_0_pop34_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_2_0_push33_rows_1_0_pop34_NO_SHIFT_REG <= 'x;
		local_bb1_rows_2_0_push33_rows_1_0_pop34_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_2_0_push33_rows_1_0_pop34_output_regs_ready)
		begin
			local_bb1_rows_2_0_push33_rows_1_0_pop34_NO_SHIFT_REG <= local_bb1_rows_2_0_push33_rows_1_0_pop34_result;
			local_bb1_rows_2_0_push33_rows_1_0_pop34_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_2_0_push33_rows_1_0_pop34_stall_in))
			begin
				local_bb1_rows_2_0_push33_rows_1_0_pop34_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_1_0_push34_rows_0_0_pop35_inputs_ready;
 reg local_bb1_rows_1_0_push34_rows_0_0_pop35_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_1_0_push34_rows_0_0_pop35_stall_in;
wire local_bb1_rows_1_0_push34_rows_0_0_pop35_output_regs_ready;
wire [7:0] local_bb1_rows_1_0_push34_rows_0_0_pop35_result;
wire local_bb1_rows_1_0_push34_rows_0_0_pop35_fu_valid_out;
wire local_bb1_rows_1_0_push34_rows_0_0_pop35_fu_stall_out;
 reg [7:0] local_bb1_rows_1_0_push34_rows_0_0_pop35_NO_SHIFT_REG;
wire local_bb1_rows_1_0_push34_rows_0_0_pop35_causedstall;

acl_push local_bb1_rows_1_0_push34_rows_0_0_pop35_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_0_0_pop35_),
	.stall_out(local_bb1_rows_1_0_push34_rows_0_0_pop35_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_1_0_push34_rows_0_0_pop35_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_1_0_push34_rows_0_0_pop35_result),
	.feedback_out(feedback_data_out_34),
	.feedback_valid_out(feedback_valid_out_34),
	.feedback_stall_in(feedback_stall_in_34)
);

defparam local_bb1_rows_1_0_push34_rows_0_0_pop35_feedback.STALLFREE = 1;
defparam local_bb1_rows_1_0_push34_rows_0_0_pop35_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_1_0_push34_rows_0_0_pop35_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_1_0_push34_rows_0_0_pop35_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_1_0_push34_rows_0_0_pop35_feedback.STYLE = "REGULAR";

assign local_bb1_rows_1_0_push34_rows_0_0_pop35_inputs_ready = 1'b1;
assign local_bb1_rows_1_0_push34_rows_0_0_pop35_output_regs_ready = 1'b1;
assign local_bb1_rows_0_0_pop35__stall_in_0 = 1'b0;
assign local_bb1_c0_ene2_stall_in_0 = 1'b0;
assign local_bb1_rows_1_0_push34_rows_0_0_pop35_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_1_0_push34_rows_0_0_pop35_NO_SHIFT_REG <= 'x;
		local_bb1_rows_1_0_push34_rows_0_0_pop35_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_1_0_push34_rows_0_0_pop35_output_regs_ready)
		begin
			local_bb1_rows_1_0_push34_rows_0_0_pop35_NO_SHIFT_REG <= local_bb1_rows_1_0_push34_rows_0_0_pop35_result;
			local_bb1_rows_1_0_push34_rows_0_0_pop35_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_1_0_push34_rows_0_0_pop35_stall_in))
			begin
				local_bb1_rows_1_0_push34_rows_0_0_pop35_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_3_0_push32_rows_2_0_pop33_inputs_ready;
 reg local_bb1_rows_3_0_push32_rows_2_0_pop33_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_3_0_push32_rows_2_0_pop33_stall_in;
wire local_bb1_rows_3_0_push32_rows_2_0_pop33_output_regs_ready;
wire [7:0] local_bb1_rows_3_0_push32_rows_2_0_pop33_result;
wire local_bb1_rows_3_0_push32_rows_2_0_pop33_fu_valid_out;
wire local_bb1_rows_3_0_push32_rows_2_0_pop33_fu_stall_out;
 reg [7:0] local_bb1_rows_3_0_push32_rows_2_0_pop33_NO_SHIFT_REG;
wire local_bb1_rows_3_0_push32_rows_2_0_pop33_causedstall;

acl_push local_bb1_rows_3_0_push32_rows_2_0_pop33_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_c0_ene2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_2_0_pop33_),
	.stall_out(local_bb1_rows_3_0_push32_rows_2_0_pop33_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[2]),
	.valid_out(local_bb1_rows_3_0_push32_rows_2_0_pop33_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_3_0_push32_rows_2_0_pop33_result),
	.feedback_out(feedback_data_out_32),
	.feedback_valid_out(feedback_valid_out_32),
	.feedback_stall_in(feedback_stall_in_32)
);

defparam local_bb1_rows_3_0_push32_rows_2_0_pop33_feedback.STALLFREE = 1;
defparam local_bb1_rows_3_0_push32_rows_2_0_pop33_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_3_0_push32_rows_2_0_pop33_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_3_0_push32_rows_2_0_pop33_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_3_0_push32_rows_2_0_pop33_feedback.STYLE = "REGULAR";

assign local_bb1_rows_3_0_push32_rows_2_0_pop33_inputs_ready = 1'b1;
assign local_bb1_rows_3_0_push32_rows_2_0_pop33_output_regs_ready = 1'b1;
assign local_bb1_rows_2_0_pop33__stall_in_0 = 1'b0;
assign local_bb1_c0_ene2_stall_in_2 = 1'b0;
assign local_bb1_rows_3_0_push32_rows_2_0_pop33_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[2] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_3_0_push32_rows_2_0_pop33_NO_SHIFT_REG <= 'x;
		local_bb1_rows_3_0_push32_rows_2_0_pop33_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_3_0_push32_rows_2_0_pop33_output_regs_ready)
		begin
			local_bb1_rows_3_0_push32_rows_2_0_pop33_NO_SHIFT_REG <= local_bb1_rows_3_0_push32_rows_2_0_pop33_result;
			local_bb1_rows_3_0_push32_rows_2_0_pop33_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_3_0_push32_rows_2_0_pop33_stall_in))
			begin
				local_bb1_rows_3_0_push32_rows_2_0_pop33_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1__343_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1__343_0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_164to165_bb1__343_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1__343_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1__343_0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_164to165_bb1__343_1_NO_SHIFT_REG;
 logic rnode_164to165_bb1__343_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_164to165_bb1__343_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1__343_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1__343_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1__343_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1__343_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1__343_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1__343_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1__343_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1__343_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1__343),
	.data_out(rnode_164to165_bb1__343_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1__343_0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1__343_0_reg_165_fifo.DATA_WIDTH = 8;
defparam rnode_164to165_bb1__343_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1__343_0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1__343_0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__343_stall_in = 1'b0;
assign rnode_164to165_bb1__343_0_stall_in_0_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1__343_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1__343_0_NO_SHIFT_REG = rnode_164to165_bb1__343_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1__343_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1__343_1_NO_SHIFT_REG = rnode_164to165_bb1__343_0_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_2_0_push33_rows_1_0_pop34_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_2_0_push33_rows_1_0_pop34_stall_in = 1'b0;
assign rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG = rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_1_0_push34_rows_0_0_pop35_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_1_0_push34_rows_0_0_pop35_stall_in = 1'b0;
assign rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG = rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_rows_3_0_push32_rows_2_0_pop33_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_3_0_push32_rows_2_0_pop33_stall_in = 1'b0;
assign rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG = rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u3_stall_local;
wire [7:0] local_bb1_var__u3;

assign local_bb1_var__u3 = (rnode_164to165_bb1__343_0_NO_SHIFT_REG & 8'h1);

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG),
	.data_out(rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_fifo.DEPTH = 4;
defparam rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG = rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_170_NO_SHIFT_REG;
assign rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG),
	.data_out(rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_fifo.DEPTH = 4;
defparam rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG = rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_170_NO_SHIFT_REG;
assign rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG),
	.data_out(rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_fifo.DEPTH = 4;
defparam rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG = rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_170_NO_SHIFT_REG;
assign rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_4_stall_local;
wire local_bb1_cmp19_4;

assign local_bb1_cmp19_4 = (local_bb1_var__u3 == 8'h0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to170_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to170_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to170_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__344_demorgan_stall_local;
wire local_bb1__344_demorgan;

assign local_bb1__344_demorgan = (rnode_164to165_bb1_cmp16_4_0_NO_SHIFT_REG | local_bb1_cmp19_4);

// This section implements an unregistered operation.
// 
wire local_bb1__346_stall_local;
wire local_bb1__346;

assign local_bb1__346 = (local_bb1_cmp19_4 & local_bb1_not_cmp16_4);

// This section implements an unregistered operation.
// 
wire local_bb1__345_stall_local;
wire [7:0] local_bb1__345;

assign local_bb1__345 = (local_bb1__344_demorgan ? 8'h1 : rnode_164to165_bb1__343_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1__347_stall_local;
wire [7:0] local_bb1__347;

assign local_bb1__347 = (local_bb1__346 ? 8'h0 : local_bb1__345);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u4_stall_local;
wire [7:0] local_bb1_var__u4;

assign local_bb1_var__u4 = (local_bb1__347 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_5_stall_local;
wire local_bb1_cmp19_5;

assign local_bb1_cmp19_5 = (local_bb1_var__u4 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__348_demorgan_stall_local;
wire local_bb1__348_demorgan;

assign local_bb1__348_demorgan = (rnode_164to165_bb1_cmp16_5_0_NO_SHIFT_REG | local_bb1_cmp19_5);

// This section implements an unregistered operation.
// 
wire local_bb1__350_stall_local;
wire local_bb1__350;

assign local_bb1__350 = (local_bb1_cmp19_5 & local_bb1_not_cmp16_5);

// This section implements an unregistered operation.
// 
wire local_bb1__349_stall_local;
wire [7:0] local_bb1__349;

assign local_bb1__349 = (local_bb1__348_demorgan ? 8'h1 : local_bb1__347);

// This section implements an unregistered operation.
// 
wire local_bb1__351_stall_local;
wire [7:0] local_bb1__351;

assign local_bb1__351 = (local_bb1__350 ? 8'h0 : local_bb1__349);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u5_stall_local;
wire [7:0] local_bb1_var__u5;

assign local_bb1_var__u5 = (local_bb1__351 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_6_stall_local;
wire local_bb1_cmp19_6;

assign local_bb1_cmp19_6 = (local_bb1_var__u5 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__352_demorgan_stall_local;
wire local_bb1__352_demorgan;

assign local_bb1__352_demorgan = (local_bb1_cmp16_6 | local_bb1_cmp19_6);

// This section implements an unregistered operation.
// 
wire local_bb1__354_stall_local;
wire local_bb1__354;

assign local_bb1__354 = (local_bb1_cmp19_6 & local_bb1_not_cmp16_6);

// This section implements an unregistered operation.
// 
wire local_bb1__353_stall_local;
wire [7:0] local_bb1__353;

assign local_bb1__353 = (local_bb1__352_demorgan ? 8'h1 : local_bb1__351);

// This section implements an unregistered operation.
// 
wire local_bb1__355_stall_local;
wire [7:0] local_bb1__355;

assign local_bb1__355 = (local_bb1__354 ? 8'h0 : local_bb1__353);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u6_stall_local;
wire [7:0] local_bb1_var__u6;

assign local_bb1_var__u6 = (local_bb1__355 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_7_stall_local;
wire local_bb1_cmp19_7;

assign local_bb1_cmp19_7 = (local_bb1_var__u6 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__356_demorgan_stall_local;
wire local_bb1__356_demorgan;

assign local_bb1__356_demorgan = (local_bb1_cmp16_7 | local_bb1_cmp19_7);

// This section implements an unregistered operation.
// 
wire local_bb1__358_stall_local;
wire local_bb1__358;

assign local_bb1__358 = (local_bb1_cmp19_7 & local_bb1_not_cmp16_7);

// This section implements an unregistered operation.
// 
wire local_bb1__357_stall_local;
wire [7:0] local_bb1__357;

assign local_bb1__357 = (local_bb1__356_demorgan ? 8'h1 : local_bb1__355);

// This section implements an unregistered operation.
// 
wire local_bb1__359_stall_local;
wire [7:0] local_bb1__359;

assign local_bb1__359 = (local_bb1__358 ? 8'h0 : local_bb1__357);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u7_stall_local;
wire [7:0] local_bb1_var__u7;

assign local_bb1_var__u7 = (local_bb1__359 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_8_stall_local;
wire local_bb1_cmp19_8;

assign local_bb1_cmp19_8 = (local_bb1_var__u7 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__360_demorgan_stall_local;
wire local_bb1__360_demorgan;

assign local_bb1__360_demorgan = (local_bb1_cmp16_8 | local_bb1_cmp19_8);

// This section implements an unregistered operation.
// 
wire local_bb1__362_stall_local;
wire local_bb1__362;

assign local_bb1__362 = (local_bb1_cmp19_8 & local_bb1_not_cmp16_8);

// This section implements an unregistered operation.
// 
wire local_bb1__361_stall_local;
wire [7:0] local_bb1__361;

assign local_bb1__361 = (local_bb1__360_demorgan ? 8'h1 : local_bb1__359);

// This section implements an unregistered operation.
// 
wire local_bb1__363_stall_local;
wire [7:0] local_bb1__363;

assign local_bb1__363 = (local_bb1__362 ? 8'h0 : local_bb1__361);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u8_stall_local;
wire [7:0] local_bb1_var__u8;

assign local_bb1_var__u8 = (local_bb1__363 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_9_stall_local;
wire local_bb1_cmp19_9;

assign local_bb1_cmp19_9 = (local_bb1_var__u8 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__364_demorgan_stall_local;
wire local_bb1__364_demorgan;

assign local_bb1__364_demorgan = (local_bb1_cmp16_9 | local_bb1_cmp19_9);

// This section implements an unregistered operation.
// 
wire local_bb1__366_stall_local;
wire local_bb1__366;

assign local_bb1__366 = (local_bb1_cmp19_9 & local_bb1_not_cmp16_9);

// This section implements an unregistered operation.
// 
wire local_bb1__365_stall_local;
wire [7:0] local_bb1__365;

assign local_bb1__365 = (local_bb1__364_demorgan ? 8'h1 : local_bb1__363);

// This section implements an unregistered operation.
// 
wire local_bb1__367_stall_local;
wire [7:0] local_bb1__367;

assign local_bb1__367 = (local_bb1__366 ? 8'h0 : local_bb1__365);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u9_stall_local;
wire [7:0] local_bb1_var__u9;

assign local_bb1_var__u9 = (local_bb1__367 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_10_stall_local;
wire local_bb1_cmp19_10;

assign local_bb1_cmp19_10 = (local_bb1_var__u9 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__368_demorgan_stall_local;
wire local_bb1__368_demorgan;

assign local_bb1__368_demorgan = (local_bb1_cmp16_10 | local_bb1_cmp19_10);

// This section implements an unregistered operation.
// 
wire local_bb1__370_stall_local;
wire local_bb1__370;

assign local_bb1__370 = (local_bb1_cmp19_10 & local_bb1_not_cmp16_10);

// This section implements an unregistered operation.
// 
wire local_bb1__369_stall_local;
wire [7:0] local_bb1__369;

assign local_bb1__369 = (local_bb1__368_demorgan ? 8'h1 : local_bb1__367);

// This section implements an unregistered operation.
// 
wire local_bb1__371_stall_local;
wire [7:0] local_bb1__371;

assign local_bb1__371 = (local_bb1__370 ? 8'h0 : local_bb1__369);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u10_stall_local;
wire [7:0] local_bb1_var__u10;

assign local_bb1_var__u10 = (local_bb1__371 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_11_stall_local;
wire local_bb1_cmp19_11;

assign local_bb1_cmp19_11 = (local_bb1_var__u10 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__372_demorgan_stall_local;
wire local_bb1__372_demorgan;

assign local_bb1__372_demorgan = (local_bb1_cmp16_11 | local_bb1_cmp19_11);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_7_0_pop28__valid_out_0;
wire local_bb1_rows_7_0_pop28__stall_in_0;
 reg local_bb1_rows_7_0_pop28__consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_8_0_pop27__valid_out_0;
wire local_bb1_rows_8_0_pop27__stall_in_0;
 reg local_bb1_rows_8_0_pop27__consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_9_0_pop26__valid_out_0;
wire local_bb1_rows_9_0_pop26__stall_in_0;
 reg local_bb1_rows_9_0_pop26__consumed_0_NO_SHIFT_REG;
wire local_bb1__371_valid_out_1;
wire local_bb1__371_stall_in_1;
 reg local_bb1__371_consumed_1_NO_SHIFT_REG;
wire local_bb1_rows_6_0_pop29__valid_out_0;
wire local_bb1_rows_6_0_pop29__stall_in_0;
 reg local_bb1_rows_6_0_pop29__consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_10_0_pop25__valid_out_0;
wire local_bb1_rows_10_0_pop25__stall_in_0;
 reg local_bb1_rows_10_0_pop25__consumed_0_NO_SHIFT_REG;
wire local_bb1__372_demorgan_valid_out;
wire local_bb1__372_demorgan_stall_in;
 reg local_bb1__372_demorgan_consumed_0_NO_SHIFT_REG;
wire local_bb1__374_valid_out;
wire local_bb1__374_stall_in;
 reg local_bb1__374_consumed_0_NO_SHIFT_REG;
wire local_bb1__374_inputs_ready;
wire local_bb1__374_stall_local;
wire local_bb1__374;

assign local_bb1__374_inputs_ready = (rnode_164to165_bb1_c0_ene1_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_bb1_c0_ene1_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_bb1_c0_ene1_0_valid_out_2_NO_SHIFT_REG & rnode_164to165_bb1_c0_ene1_0_valid_out_11_NO_SHIFT_REG & rnode_164to165_bb1_rows_5_0_pop30__0_valid_out_1_NO_SHIFT_REG & rnode_164to165_bb1_cmp16_4_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_bb1__343_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_bb1_cmp16_4_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_bb1_cmp16_5_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_bb1_cmp16_5_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_bb1__343_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_bb1_c0_ene1_0_valid_out_10_NO_SHIFT_REG);
assign local_bb1__374 = (local_bb1_cmp19_11 & local_bb1_not_cmp16_11);
assign local_bb1_rows_7_0_pop28__valid_out_0 = 1'b1;
assign local_bb1_rows_8_0_pop27__valid_out_0 = 1'b1;
assign local_bb1_rows_9_0_pop26__valid_out_0 = 1'b1;
assign local_bb1__371_valid_out_1 = 1'b1;
assign local_bb1_rows_6_0_pop29__valid_out_0 = 1'b1;
assign local_bb1_rows_10_0_pop25__valid_out_0 = 1'b1;
assign local_bb1__372_demorgan_valid_out = 1'b1;
assign local_bb1__374_valid_out = 1'b1;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_11_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_rows_5_0_pop30__0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_cmp16_4_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1__343_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_cmp16_4_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_cmp16_5_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_cmp16_5_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1__343_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_c0_ene1_0_stall_in_10_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_7_0_pop28__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_8_0_pop27__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_9_0_pop26__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__371_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_6_0_pop29__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_10_0_pop25__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__372_demorgan_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__374_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_7_0_pop28__consumed_0_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1_rows_7_0_pop28__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_7_0_pop28__stall_in_0)) & local_bb1__374_stall_local);
		local_bb1_rows_8_0_pop27__consumed_0_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1_rows_8_0_pop27__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_8_0_pop27__stall_in_0)) & local_bb1__374_stall_local);
		local_bb1_rows_9_0_pop26__consumed_0_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1_rows_9_0_pop26__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_9_0_pop26__stall_in_0)) & local_bb1__374_stall_local);
		local_bb1__371_consumed_1_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1__371_consumed_1_NO_SHIFT_REG | ~(local_bb1__371_stall_in_1)) & local_bb1__374_stall_local);
		local_bb1_rows_6_0_pop29__consumed_0_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1_rows_6_0_pop29__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_6_0_pop29__stall_in_0)) & local_bb1__374_stall_local);
		local_bb1_rows_10_0_pop25__consumed_0_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1_rows_10_0_pop25__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_10_0_pop25__stall_in_0)) & local_bb1__374_stall_local);
		local_bb1__372_demorgan_consumed_0_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1__372_demorgan_consumed_0_NO_SHIFT_REG | ~(local_bb1__372_demorgan_stall_in)) & local_bb1__374_stall_local);
		local_bb1__374_consumed_0_NO_SHIFT_REG <= (local_bb1__374_inputs_ready & (local_bb1__374_consumed_0_NO_SHIFT_REG | ~(local_bb1__374_stall_in)) & local_bb1__374_stall_local);
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_8_0_push27_rows_7_0_pop28_inputs_ready;
 reg local_bb1_rows_8_0_push27_rows_7_0_pop28_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_8_0_push27_rows_7_0_pop28_stall_in;
wire local_bb1_rows_8_0_push27_rows_7_0_pop28_output_regs_ready;
wire [7:0] local_bb1_rows_8_0_push27_rows_7_0_pop28_result;
wire local_bb1_rows_8_0_push27_rows_7_0_pop28_fu_valid_out;
wire local_bb1_rows_8_0_push27_rows_7_0_pop28_fu_stall_out;
 reg [7:0] local_bb1_rows_8_0_push27_rows_7_0_pop28_NO_SHIFT_REG;
wire local_bb1_rows_8_0_push27_rows_7_0_pop28_causedstall;

acl_push local_bb1_rows_8_0_push27_rows_7_0_pop28_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_2_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_7_0_pop28_),
	.stall_out(local_bb1_rows_8_0_push27_rows_7_0_pop28_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_8_0_push27_rows_7_0_pop28_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_8_0_push27_rows_7_0_pop28_result),
	.feedback_out(feedback_data_out_27),
	.feedback_valid_out(feedback_valid_out_27),
	.feedback_stall_in(feedback_stall_in_27)
);

defparam local_bb1_rows_8_0_push27_rows_7_0_pop28_feedback.STALLFREE = 1;
defparam local_bb1_rows_8_0_push27_rows_7_0_pop28_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_8_0_push27_rows_7_0_pop28_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_8_0_push27_rows_7_0_pop28_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_8_0_push27_rows_7_0_pop28_feedback.STYLE = "REGULAR";

assign local_bb1_rows_8_0_push27_rows_7_0_pop28_inputs_ready = 1'b1;
assign local_bb1_rows_8_0_push27_rows_7_0_pop28_output_regs_ready = 1'b1;
assign local_bb1_rows_7_0_pop28__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_8_0_push27_rows_7_0_pop28_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_8_0_push27_rows_7_0_pop28_NO_SHIFT_REG <= 'x;
		local_bb1_rows_8_0_push27_rows_7_0_pop28_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_8_0_push27_rows_7_0_pop28_output_regs_ready)
		begin
			local_bb1_rows_8_0_push27_rows_7_0_pop28_NO_SHIFT_REG <= local_bb1_rows_8_0_push27_rows_7_0_pop28_result;
			local_bb1_rows_8_0_push27_rows_7_0_pop28_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_8_0_push27_rows_7_0_pop28_stall_in))
			begin
				local_bb1_rows_8_0_push27_rows_7_0_pop28_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_9_0_push26_rows_8_0_pop27_inputs_ready;
 reg local_bb1_rows_9_0_push26_rows_8_0_pop27_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_9_0_push26_rows_8_0_pop27_stall_in;
wire local_bb1_rows_9_0_push26_rows_8_0_pop27_output_regs_ready;
wire [7:0] local_bb1_rows_9_0_push26_rows_8_0_pop27_result;
wire local_bb1_rows_9_0_push26_rows_8_0_pop27_fu_valid_out;
wire local_bb1_rows_9_0_push26_rows_8_0_pop27_fu_stall_out;
 reg [7:0] local_bb1_rows_9_0_push26_rows_8_0_pop27_NO_SHIFT_REG;
wire local_bb1_rows_9_0_push26_rows_8_0_pop27_causedstall;

acl_push local_bb1_rows_9_0_push26_rows_8_0_pop27_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_8_0_pop27_),
	.stall_out(local_bb1_rows_9_0_push26_rows_8_0_pop27_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_9_0_push26_rows_8_0_pop27_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_9_0_push26_rows_8_0_pop27_result),
	.feedback_out(feedback_data_out_26),
	.feedback_valid_out(feedback_valid_out_26),
	.feedback_stall_in(feedback_stall_in_26)
);

defparam local_bb1_rows_9_0_push26_rows_8_0_pop27_feedback.STALLFREE = 1;
defparam local_bb1_rows_9_0_push26_rows_8_0_pop27_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_9_0_push26_rows_8_0_pop27_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_9_0_push26_rows_8_0_pop27_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_9_0_push26_rows_8_0_pop27_feedback.STYLE = "REGULAR";

assign local_bb1_rows_9_0_push26_rows_8_0_pop27_inputs_ready = 1'b1;
assign local_bb1_rows_9_0_push26_rows_8_0_pop27_output_regs_ready = 1'b1;
assign local_bb1_rows_8_0_pop27__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_9_0_push26_rows_8_0_pop27_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_9_0_push26_rows_8_0_pop27_NO_SHIFT_REG <= 'x;
		local_bb1_rows_9_0_push26_rows_8_0_pop27_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_9_0_push26_rows_8_0_pop27_output_regs_ready)
		begin
			local_bb1_rows_9_0_push26_rows_8_0_pop27_NO_SHIFT_REG <= local_bb1_rows_9_0_push26_rows_8_0_pop27_result;
			local_bb1_rows_9_0_push26_rows_8_0_pop27_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_9_0_push26_rows_8_0_pop27_stall_in))
			begin
				local_bb1_rows_9_0_push26_rows_8_0_pop27_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_10_0_push25_rows_9_0_pop26_inputs_ready;
 reg local_bb1_rows_10_0_push25_rows_9_0_pop26_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_10_0_push25_rows_9_0_pop26_stall_in;
wire local_bb1_rows_10_0_push25_rows_9_0_pop26_output_regs_ready;
wire [7:0] local_bb1_rows_10_0_push25_rows_9_0_pop26_result;
wire local_bb1_rows_10_0_push25_rows_9_0_pop26_fu_valid_out;
wire local_bb1_rows_10_0_push25_rows_9_0_pop26_fu_stall_out;
 reg [7:0] local_bb1_rows_10_0_push25_rows_9_0_pop26_NO_SHIFT_REG;
wire local_bb1_rows_10_0_push25_rows_9_0_pop26_causedstall;

acl_push local_bb1_rows_10_0_push25_rows_9_0_pop26_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_9_0_pop26_),
	.stall_out(local_bb1_rows_10_0_push25_rows_9_0_pop26_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_10_0_push25_rows_9_0_pop26_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_10_0_push25_rows_9_0_pop26_result),
	.feedback_out(feedback_data_out_25),
	.feedback_valid_out(feedback_valid_out_25),
	.feedback_stall_in(feedback_stall_in_25)
);

defparam local_bb1_rows_10_0_push25_rows_9_0_pop26_feedback.STALLFREE = 1;
defparam local_bb1_rows_10_0_push25_rows_9_0_pop26_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_10_0_push25_rows_9_0_pop26_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_10_0_push25_rows_9_0_pop26_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_10_0_push25_rows_9_0_pop26_feedback.STYLE = "REGULAR";

assign local_bb1_rows_10_0_push25_rows_9_0_pop26_inputs_ready = 1'b1;
assign local_bb1_rows_10_0_push25_rows_9_0_pop26_output_regs_ready = 1'b1;
assign local_bb1_rows_9_0_pop26__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_10_0_push25_rows_9_0_pop26_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_10_0_push25_rows_9_0_pop26_NO_SHIFT_REG <= 'x;
		local_bb1_rows_10_0_push25_rows_9_0_pop26_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_10_0_push25_rows_9_0_pop26_output_regs_ready)
		begin
			local_bb1_rows_10_0_push25_rows_9_0_pop26_NO_SHIFT_REG <= local_bb1_rows_10_0_push25_rows_9_0_pop26_result;
			local_bb1_rows_10_0_push25_rows_9_0_pop26_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_10_0_push25_rows_9_0_pop26_stall_in))
			begin
				local_bb1_rows_10_0_push25_rows_9_0_pop26_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1__371_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1__371_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1__371_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1__371_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_165to166_bb1__371_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__371_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__371_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__371_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1__371_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1__371_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1__371_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1__371_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1__371_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1__371),
	.data_out(rnode_165to166_bb1__371_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1__371_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1__371_0_reg_166_fifo.DATA_WIDTH = 8;
defparam rnode_165to166_bb1__371_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1__371_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1__371_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__371_stall_in_1 = 1'b0;
assign rnode_165to166_bb1__371_0_NO_SHIFT_REG = rnode_165to166_bb1__371_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1__371_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1__371_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_rows_7_0_push28_rows_6_0_pop29_inputs_ready;
 reg local_bb1_rows_7_0_push28_rows_6_0_pop29_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_7_0_push28_rows_6_0_pop29_stall_in;
wire local_bb1_rows_7_0_push28_rows_6_0_pop29_output_regs_ready;
wire [7:0] local_bb1_rows_7_0_push28_rows_6_0_pop29_result;
wire local_bb1_rows_7_0_push28_rows_6_0_pop29_fu_valid_out;
wire local_bb1_rows_7_0_push28_rows_6_0_pop29_fu_stall_out;
 reg [7:0] local_bb1_rows_7_0_push28_rows_6_0_pop29_NO_SHIFT_REG;
wire local_bb1_rows_7_0_push28_rows_6_0_pop29_causedstall;

acl_push local_bb1_rows_7_0_push28_rows_6_0_pop29_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_0_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_6_0_pop29_),
	.stall_out(local_bb1_rows_7_0_push28_rows_6_0_pop29_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_7_0_push28_rows_6_0_pop29_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_7_0_push28_rows_6_0_pop29_result),
	.feedback_out(feedback_data_out_28),
	.feedback_valid_out(feedback_valid_out_28),
	.feedback_stall_in(feedback_stall_in_28)
);

defparam local_bb1_rows_7_0_push28_rows_6_0_pop29_feedback.STALLFREE = 1;
defparam local_bb1_rows_7_0_push28_rows_6_0_pop29_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_7_0_push28_rows_6_0_pop29_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_7_0_push28_rows_6_0_pop29_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_7_0_push28_rows_6_0_pop29_feedback.STYLE = "REGULAR";

assign local_bb1_rows_7_0_push28_rows_6_0_pop29_inputs_ready = 1'b1;
assign local_bb1_rows_7_0_push28_rows_6_0_pop29_output_regs_ready = 1'b1;
assign local_bb1_rows_6_0_pop29__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_7_0_push28_rows_6_0_pop29_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_7_0_push28_rows_6_0_pop29_NO_SHIFT_REG <= 'x;
		local_bb1_rows_7_0_push28_rows_6_0_pop29_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_7_0_push28_rows_6_0_pop29_output_regs_ready)
		begin
			local_bb1_rows_7_0_push28_rows_6_0_pop29_NO_SHIFT_REG <= local_bb1_rows_7_0_push28_rows_6_0_pop29_result;
			local_bb1_rows_7_0_push28_rows_6_0_pop29_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_7_0_push28_rows_6_0_pop29_stall_in))
			begin
				local_bb1_rows_7_0_push28_rows_6_0_pop29_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_11_0_push24_rows_10_0_pop25_inputs_ready;
 reg local_bb1_rows_11_0_push24_rows_10_0_pop25_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_11_0_push24_rows_10_0_pop25_stall_in;
wire local_bb1_rows_11_0_push24_rows_10_0_pop25_output_regs_ready;
wire [7:0] local_bb1_rows_11_0_push24_rows_10_0_pop25_result;
wire local_bb1_rows_11_0_push24_rows_10_0_pop25_fu_valid_out;
wire local_bb1_rows_11_0_push24_rows_10_0_pop25_fu_stall_out;
 reg [7:0] local_bb1_rows_11_0_push24_rows_10_0_pop25_NO_SHIFT_REG;
wire local_bb1_rows_11_0_push24_rows_10_0_pop25_causedstall;

acl_push local_bb1_rows_11_0_push24_rows_10_0_pop25_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_164to165_bb1_c0_ene2_6_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_10_0_pop25_),
	.stall_out(local_bb1_rows_11_0_push24_rows_10_0_pop25_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[3]),
	.valid_out(local_bb1_rows_11_0_push24_rows_10_0_pop25_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_11_0_push24_rows_10_0_pop25_result),
	.feedback_out(feedback_data_out_24),
	.feedback_valid_out(feedback_valid_out_24),
	.feedback_stall_in(feedback_stall_in_24)
);

defparam local_bb1_rows_11_0_push24_rows_10_0_pop25_feedback.STALLFREE = 1;
defparam local_bb1_rows_11_0_push24_rows_10_0_pop25_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_11_0_push24_rows_10_0_pop25_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_11_0_push24_rows_10_0_pop25_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_11_0_push24_rows_10_0_pop25_feedback.STYLE = "REGULAR";

assign local_bb1_rows_11_0_push24_rows_10_0_pop25_inputs_ready = 1'b1;
assign local_bb1_rows_11_0_push24_rows_10_0_pop25_output_regs_ready = 1'b1;
assign local_bb1_rows_10_0_pop25__stall_in_0 = 1'b0;
assign rnode_164to165_bb1_c0_ene2_0_stall_in_6_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_11_0_push24_rows_10_0_pop25_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[3] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_11_0_push24_rows_10_0_pop25_NO_SHIFT_REG <= 'x;
		local_bb1_rows_11_0_push24_rows_10_0_pop25_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_11_0_push24_rows_10_0_pop25_output_regs_ready)
		begin
			local_bb1_rows_11_0_push24_rows_10_0_pop25_NO_SHIFT_REG <= local_bb1_rows_11_0_push24_rows_10_0_pop25_result;
			local_bb1_rows_11_0_push24_rows_10_0_pop25_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_11_0_push24_rows_10_0_pop25_stall_in))
			begin
				local_bb1_rows_11_0_push24_rows_10_0_pop25_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1__372_demorgan_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1__372_demorgan_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to166_bb1__372_demorgan_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1__372_demorgan_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1__372_demorgan_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__372_demorgan_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__372_demorgan_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__372_demorgan_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1__372_demorgan_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1__372_demorgan_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1__372_demorgan_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1__372_demorgan_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1__372_demorgan_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1__372_demorgan),
	.data_out(rnode_165to166_bb1__372_demorgan_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1__372_demorgan_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1__372_demorgan_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1__372_demorgan_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1__372_demorgan_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1__372_demorgan_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__372_demorgan_stall_in = 1'b0;
assign rnode_165to166_bb1__372_demorgan_0_NO_SHIFT_REG = rnode_165to166_bb1__372_demorgan_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1__372_demorgan_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1__372_demorgan_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1__374_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1__374_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to166_bb1__374_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1__374_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1__374_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__374_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__374_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1__374_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1__374_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1__374_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1__374_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1__374_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1__374_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1__374),
	.data_out(rnode_165to166_bb1__374_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1__374_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1__374_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1__374_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1__374_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1__374_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__374_stall_in = 1'b0;
assign rnode_165to166_bb1__374_0_NO_SHIFT_REG = rnode_165to166_bb1__374_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1__374_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1__374_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_8_0_push27_rows_7_0_pop28_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_8_0_push27_rows_7_0_pop28_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_9_0_push26_rows_8_0_pop27_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_9_0_push26_rows_8_0_pop27_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_10_0_push25_rows_9_0_pop26_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_10_0_push25_rows_9_0_pop26_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_7_0_push28_rows_6_0_pop29_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_7_0_push28_rows_6_0_pop29_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_rows_11_0_push24_rows_10_0_pop25_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_11_0_push24_rows_10_0_pop25_stall_in = 1'b0;
assign rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG = rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__373_stall_local;
wire [7:0] local_bb1__373;

assign local_bb1__373 = (rnode_165to166_bb1__372_demorgan_0_NO_SHIFT_REG ? 8'h1 : rnode_165to166_bb1__371_0_NO_SHIFT_REG);

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG),
	.data_out(rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_fifo.DEPTH = 3;
defparam rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG = rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_170_NO_SHIFT_REG;
assign rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__375_stall_local;
wire [7:0] local_bb1__375;

assign local_bb1__375 = (rnode_165to166_bb1__374_0_NO_SHIFT_REG ? 8'h0 : local_bb1__373);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_167to170_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u11_stall_local;
wire [7:0] local_bb1_var__u11;

assign local_bb1_var__u11 = (local_bb1__375 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_12_stall_local;
wire local_bb1_cmp19_12;

assign local_bb1_cmp19_12 = (local_bb1_var__u11 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__376_demorgan_stall_local;
wire local_bb1__376_demorgan;

assign local_bb1__376_demorgan = (rnode_165to166_bb1_cmp16_12_0_NO_SHIFT_REG | local_bb1_cmp19_12);

// This section implements an unregistered operation.
// 
wire local_bb1__378_stall_local;
wire local_bb1__378;

assign local_bb1__378 = (local_bb1_cmp19_12 & local_bb1_not_cmp16_12);

// This section implements an unregistered operation.
// 
wire local_bb1__377_stall_local;
wire [7:0] local_bb1__377;

assign local_bb1__377 = (local_bb1__376_demorgan ? 8'h1 : local_bb1__375);

// This section implements an unregistered operation.
// 
wire local_bb1__379_stall_local;
wire [7:0] local_bb1__379;

assign local_bb1__379 = (local_bb1__378 ? 8'h0 : local_bb1__377);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u12_stall_local;
wire [7:0] local_bb1_var__u12;

assign local_bb1_var__u12 = (local_bb1__379 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_13_stall_local;
wire local_bb1_cmp19_13;

assign local_bb1_cmp19_13 = (local_bb1_var__u12 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__380_demorgan_stall_local;
wire local_bb1__380_demorgan;

assign local_bb1__380_demorgan = (rnode_165to166_bb1_cmp16_13_0_NO_SHIFT_REG | local_bb1_cmp19_13);

// This section implements an unregistered operation.
// 
wire local_bb1__382_stall_local;
wire local_bb1__382;

assign local_bb1__382 = (local_bb1_cmp19_13 & local_bb1_not_cmp16_13);

// This section implements an unregistered operation.
// 
wire local_bb1__381_stall_local;
wire [7:0] local_bb1__381;

assign local_bb1__381 = (local_bb1__380_demorgan ? 8'h1 : local_bb1__379);

// This section implements an unregistered operation.
// 
wire local_bb1__383_stall_local;
wire [7:0] local_bb1__383;

assign local_bb1__383 = (local_bb1__382 ? 8'h0 : local_bb1__381);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u13_stall_local;
wire [7:0] local_bb1_var__u13;

assign local_bb1_var__u13 = (local_bb1__383 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_14_stall_local;
wire local_bb1_cmp19_14;

assign local_bb1_cmp19_14 = (local_bb1_var__u13 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__384_demorgan_stall_local;
wire local_bb1__384_demorgan;

assign local_bb1__384_demorgan = (rnode_165to166_bb1_cmp16_14_0_NO_SHIFT_REG | local_bb1_cmp19_14);

// This section implements an unregistered operation.
// 
wire local_bb1__386_stall_local;
wire local_bb1__386;

assign local_bb1__386 = (local_bb1_cmp19_14 & local_bb1_not_cmp16_14);

// This section implements an unregistered operation.
// 
wire local_bb1__385_stall_local;
wire [7:0] local_bb1__385;

assign local_bb1__385 = (local_bb1__384_demorgan ? 8'h1 : local_bb1__383);

// This section implements an unregistered operation.
// 
wire local_bb1__387_stall_local;
wire [7:0] local_bb1__387;

assign local_bb1__387 = (local_bb1__386 ? 8'h0 : local_bb1__385);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u14_stall_local;
wire [7:0] local_bb1_var__u14;

assign local_bb1_var__u14 = (local_bb1__387 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_15_stall_local;
wire local_bb1_cmp19_15;

assign local_bb1_cmp19_15 = (local_bb1_var__u14 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__388_demorgan_stall_local;
wire local_bb1__388_demorgan;

assign local_bb1__388_demorgan = (rnode_165to166_bb1_cmp16_15_0_NO_SHIFT_REG | local_bb1_cmp19_15);

// This section implements an unregistered operation.
// 
wire local_bb1__390_stall_local;
wire local_bb1__390;

assign local_bb1__390 = (local_bb1_cmp19_15 & local_bb1_not_cmp16_15);

// This section implements an unregistered operation.
// 
wire local_bb1__389_stall_local;
wire [7:0] local_bb1__389;

assign local_bb1__389 = (local_bb1__388_demorgan ? 8'h1 : local_bb1__387);

// This section implements an unregistered operation.
// 
wire local_bb1__391_stall_local;
wire [7:0] local_bb1__391;

assign local_bb1__391 = (local_bb1__390 ? 8'h0 : local_bb1__389);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u15_stall_local;
wire [7:0] local_bb1_var__u15;

assign local_bb1_var__u15 = (local_bb1__391 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_16_stall_local;
wire local_bb1_cmp19_16;

assign local_bb1_cmp19_16 = (local_bb1_var__u15 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__392_demorgan_stall_local;
wire local_bb1__392_demorgan;

assign local_bb1__392_demorgan = (rnode_165to166_bb1_cmp16_16_0_NO_SHIFT_REG | local_bb1_cmp19_16);

// This section implements an unregistered operation.
// 
wire local_bb1__394_stall_local;
wire local_bb1__394;

assign local_bb1__394 = (local_bb1_cmp19_16 & local_bb1_not_cmp16_16);

// This section implements an unregistered operation.
// 
wire local_bb1__393_stall_local;
wire [7:0] local_bb1__393;

assign local_bb1__393 = (local_bb1__392_demorgan ? 8'h1 : local_bb1__391);

// This section implements an unregistered operation.
// 
wire local_bb1__395_stall_local;
wire [7:0] local_bb1__395;

assign local_bb1__395 = (local_bb1__394 ? 8'h0 : local_bb1__393);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u16_stall_local;
wire [7:0] local_bb1_var__u16;

assign local_bb1_var__u16 = (local_bb1__395 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_122_stall_local;
wire local_bb1_cmp19_122;

assign local_bb1_cmp19_122 = (local_bb1_var__u16 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__396_demorgan_stall_local;
wire local_bb1__396_demorgan;

assign local_bb1__396_demorgan = (rnode_165to166_bb1_cmp16_121_0_NO_SHIFT_REG | local_bb1_cmp19_122);

// This section implements an unregistered operation.
// 
wire local_bb1__398_stall_local;
wire local_bb1__398;

assign local_bb1__398 = (local_bb1_cmp19_122 & local_bb1_not_cmp16_121);

// This section implements an unregistered operation.
// 
wire local_bb1__397_stall_local;
wire [7:0] local_bb1__397;

assign local_bb1__397 = (local_bb1__396_demorgan ? 8'h1 : local_bb1__395);

// This section implements an unregistered operation.
// 
wire local_bb1__399_stall_local;
wire [7:0] local_bb1__399;

assign local_bb1__399 = (local_bb1__398 ? 8'h0 : local_bb1__397);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u17_stall_local;
wire [7:0] local_bb1_var__u17;

assign local_bb1_var__u17 = (local_bb1__399 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_1_1_stall_local;
wire local_bb1_cmp19_1_1;

assign local_bb1_cmp19_1_1 = (local_bb1_var__u17 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__400_demorgan_stall_local;
wire local_bb1__400_demorgan;

assign local_bb1__400_demorgan = (local_bb1_cmp16_1_1 | local_bb1_cmp19_1_1);

// This section implements an unregistered operation.
// 
wire local_bb1__402_stall_local;
wire local_bb1__402;

assign local_bb1__402 = (local_bb1_cmp19_1_1 & local_bb1_not_cmp16_1_1);

// This section implements an unregistered operation.
// 
wire local_bb1__401_valid_out;
wire local_bb1__401_stall_in;
 reg local_bb1__401_consumed_0_NO_SHIFT_REG;
wire local_bb1__402_valid_out;
wire local_bb1__402_stall_in;
 reg local_bb1__402_consumed_0_NO_SHIFT_REG;
wire local_bb1__401_inputs_ready;
wire local_bb1__401_stall_local;
wire [7:0] local_bb1__401;

assign local_bb1__401_inputs_ready = (rnode_165to166_bb1_rows_720_0_pop19__0_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_16_0_valid_out_0_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_16_0_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_15_0_valid_out_0_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_15_0_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_14_0_valid_out_0_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_14_0_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_13_0_valid_out_0_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_13_0_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_12_0_valid_out_0_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_12_0_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_121_0_valid_out_0_NO_SHIFT_REG & rnode_165to166_bb1__372_demorgan_0_valid_out_NO_SHIFT_REG & rnode_165to166_bb1__371_0_valid_out_NO_SHIFT_REG & rnode_165to166_bb1__374_0_valid_out_NO_SHIFT_REG & rnode_165to166_bb1_cmp16_121_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1__401 = (local_bb1__400_demorgan ? 8'h1 : local_bb1__399);
assign local_bb1__401_valid_out = 1'b1;
assign local_bb1__402_valid_out = 1'b1;
assign rnode_165to166_bb1_rows_720_0_pop19__0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_16_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_16_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_15_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_15_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_14_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_14_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_13_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_13_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_12_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_12_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_121_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1__372_demorgan_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1__371_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1__374_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_cmp16_121_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__401_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__402_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__401_consumed_0_NO_SHIFT_REG <= (local_bb1__401_inputs_ready & (local_bb1__401_consumed_0_NO_SHIFT_REG | ~(local_bb1__401_stall_in)) & local_bb1__401_stall_local);
		local_bb1__402_consumed_0_NO_SHIFT_REG <= (local_bb1__401_inputs_ready & (local_bb1__402_consumed_0_NO_SHIFT_REG | ~(local_bb1__402_stall_in)) & local_bb1__401_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1__401_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1__401_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1__401_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1__401_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_166to167_bb1__401_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__401_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__401_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__401_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1__401_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1__401_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1__401_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1__401_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1__401_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1__401),
	.data_out(rnode_166to167_bb1__401_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1__401_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1__401_0_reg_167_fifo.DATA_WIDTH = 8;
defparam rnode_166to167_bb1__401_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1__401_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1__401_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__401_stall_in = 1'b0;
assign rnode_166to167_bb1__401_0_NO_SHIFT_REG = rnode_166to167_bb1__401_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1__401_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__401_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1__402_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1__402_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1__402_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1__402_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1__402_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__402_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__402_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__402_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1__402_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1__402_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1__402_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1__402_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1__402_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1__402),
	.data_out(rnode_166to167_bb1__402_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1__402_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1__402_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1__402_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1__402_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1__402_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__402_stall_in = 1'b0;
assign rnode_166to167_bb1__402_0_NO_SHIFT_REG = rnode_166to167_bb1__402_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1__402_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__402_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__403_stall_local;
wire [7:0] local_bb1__403;

assign local_bb1__403 = (rnode_166to167_bb1__402_0_NO_SHIFT_REG ? 8'h0 : rnode_166to167_bb1__401_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u18_stall_local;
wire [7:0] local_bb1_var__u18;

assign local_bb1_var__u18 = (local_bb1__403 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_2_1_stall_local;
wire local_bb1_cmp19_2_1;

assign local_bb1_cmp19_2_1 = (local_bb1_var__u18 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__404_demorgan_stall_local;
wire local_bb1__404_demorgan;

assign local_bb1__404_demorgan = (rnode_166to167_bb1_cmp16_2_1_0_NO_SHIFT_REG | local_bb1_cmp19_2_1);

// This section implements an unregistered operation.
// 
wire local_bb1__406_stall_local;
wire local_bb1__406;

assign local_bb1__406 = (local_bb1_cmp19_2_1 & local_bb1_not_cmp16_2_1);

// This section implements an unregistered operation.
// 
wire local_bb1__405_stall_local;
wire [7:0] local_bb1__405;

assign local_bb1__405 = (local_bb1__404_demorgan ? 8'h1 : local_bb1__403);

// This section implements an unregistered operation.
// 
wire local_bb1__407_stall_local;
wire [7:0] local_bb1__407;

assign local_bb1__407 = (local_bb1__406 ? 8'h0 : local_bb1__405);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u19_stall_local;
wire [7:0] local_bb1_var__u19;

assign local_bb1_var__u19 = (local_bb1__407 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_3_1_stall_local;
wire local_bb1_cmp19_3_1;

assign local_bb1_cmp19_3_1 = (local_bb1_var__u19 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__408_demorgan_stall_local;
wire local_bb1__408_demorgan;

assign local_bb1__408_demorgan = (rnode_166to167_bb1_cmp16_3_1_0_NO_SHIFT_REG | local_bb1_cmp19_3_1);

// This section implements an unregistered operation.
// 
wire local_bb1__410_stall_local;
wire local_bb1__410;

assign local_bb1__410 = (local_bb1_cmp19_3_1 & local_bb1_not_cmp16_3_1);

// This section implements an unregistered operation.
// 
wire local_bb1__409_stall_local;
wire [7:0] local_bb1__409;

assign local_bb1__409 = (local_bb1__408_demorgan ? 8'h1 : local_bb1__407);

// This section implements an unregistered operation.
// 
wire local_bb1__411_stall_local;
wire [7:0] local_bb1__411;

assign local_bb1__411 = (local_bb1__410 ? 8'h0 : local_bb1__409);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u20_stall_local;
wire [7:0] local_bb1_var__u20;

assign local_bb1_var__u20 = (local_bb1__411 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_4_1_stall_local;
wire local_bb1_cmp19_4_1;

assign local_bb1_cmp19_4_1 = (local_bb1_var__u20 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__412_demorgan_stall_local;
wire local_bb1__412_demorgan;

assign local_bb1__412_demorgan = (rnode_166to167_bb1_cmp16_4_1_0_NO_SHIFT_REG | local_bb1_cmp19_4_1);

// This section implements an unregistered operation.
// 
wire local_bb1__414_stall_local;
wire local_bb1__414;

assign local_bb1__414 = (local_bb1_cmp19_4_1 & local_bb1_not_cmp16_4_1);

// This section implements an unregistered operation.
// 
wire local_bb1__413_stall_local;
wire [7:0] local_bb1__413;

assign local_bb1__413 = (local_bb1__412_demorgan ? 8'h1 : local_bb1__411);

// This section implements an unregistered operation.
// 
wire local_bb1__415_stall_local;
wire [7:0] local_bb1__415;

assign local_bb1__415 = (local_bb1__414 ? 8'h0 : local_bb1__413);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u21_stall_local;
wire [7:0] local_bb1_var__u21;

assign local_bb1_var__u21 = (local_bb1__415 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_5_1_stall_local;
wire local_bb1_cmp19_5_1;

assign local_bb1_cmp19_5_1 = (local_bb1_var__u21 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__416_demorgan_stall_local;
wire local_bb1__416_demorgan;

assign local_bb1__416_demorgan = (rnode_166to167_bb1_cmp16_5_1_0_NO_SHIFT_REG | local_bb1_cmp19_5_1);

// This section implements an unregistered operation.
// 
wire local_bb1__418_stall_local;
wire local_bb1__418;

assign local_bb1__418 = (local_bb1_cmp19_5_1 & local_bb1_not_cmp16_5_1);

// This section implements an unregistered operation.
// 
wire local_bb1__417_stall_local;
wire [7:0] local_bb1__417;

assign local_bb1__417 = (local_bb1__416_demorgan ? 8'h1 : local_bb1__415);

// This section implements an unregistered operation.
// 
wire local_bb1__419_stall_local;
wire [7:0] local_bb1__419;

assign local_bb1__419 = (local_bb1__418 ? 8'h0 : local_bb1__417);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u22_stall_local;
wire [7:0] local_bb1_var__u22;

assign local_bb1_var__u22 = (local_bb1__419 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_6_1_stall_local;
wire local_bb1_cmp19_6_1;

assign local_bb1_cmp19_6_1 = (local_bb1_var__u22 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__420_demorgan_stall_local;
wire local_bb1__420_demorgan;

assign local_bb1__420_demorgan = (rnode_166to167_bb1_cmp16_6_1_0_NO_SHIFT_REG | local_bb1_cmp19_6_1);

// This section implements an unregistered operation.
// 
wire local_bb1__422_stall_local;
wire local_bb1__422;

assign local_bb1__422 = (local_bb1_cmp19_6_1 & local_bb1_not_cmp16_6_1);

// This section implements an unregistered operation.
// 
wire local_bb1__421_stall_local;
wire [7:0] local_bb1__421;

assign local_bb1__421 = (local_bb1__420_demorgan ? 8'h1 : local_bb1__419);

// This section implements an unregistered operation.
// 
wire local_bb1__423_stall_local;
wire [7:0] local_bb1__423;

assign local_bb1__423 = (local_bb1__422 ? 8'h0 : local_bb1__421);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u23_stall_local;
wire [7:0] local_bb1_var__u23;

assign local_bb1_var__u23 = (local_bb1__423 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_7_1_stall_local;
wire local_bb1_cmp19_7_1;

assign local_bb1_cmp19_7_1 = (local_bb1_var__u23 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__424_demorgan_stall_local;
wire local_bb1__424_demorgan;

assign local_bb1__424_demorgan = (local_bb1_cmp16_7_1 | local_bb1_cmp19_7_1);

// This section implements an unregistered operation.
// 
wire local_bb1__426_stall_local;
wire local_bb1__426;

assign local_bb1__426 = (local_bb1_cmp19_7_1 & local_bb1_not_cmp16_7_1);

// This section implements an unregistered operation.
// 
wire local_bb1__425_stall_local;
wire [7:0] local_bb1__425;

assign local_bb1__425 = (local_bb1__424_demorgan ? 8'h1 : local_bb1__423);

// This section implements an unregistered operation.
// 
wire local_bb1__427_stall_local;
wire [7:0] local_bb1__427;

assign local_bb1__427 = (local_bb1__426 ? 8'h0 : local_bb1__425);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u24_stall_local;
wire [7:0] local_bb1_var__u24;

assign local_bb1_var__u24 = (local_bb1__427 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_8_1_stall_local;
wire local_bb1_cmp19_8_1;

assign local_bb1_cmp19_8_1 = (local_bb1_var__u24 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__428_demorgan_stall_local;
wire local_bb1__428_demorgan;

assign local_bb1__428_demorgan = (local_bb1_cmp16_8_1 | local_bb1_cmp19_8_1);

// This section implements an unregistered operation.
// 
wire local_bb1__430_stall_local;
wire local_bb1__430;

assign local_bb1__430 = (local_bb1_cmp19_8_1 & local_bb1_not_cmp16_8_1);

// This section implements an unregistered operation.
// 
wire local_bb1__429_stall_local;
wire [7:0] local_bb1__429;

assign local_bb1__429 = (local_bb1__428_demorgan ? 8'h1 : local_bb1__427);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_727_0_pop12__valid_out_0;
wire local_bb1_rows_727_0_pop12__stall_in_0;
 reg local_bb1_rows_727_0_pop12__consumed_0_NO_SHIFT_REG;
wire local_bb1__431_valid_out;
wire local_bb1__431_stall_in;
 reg local_bb1__431_consumed_0_NO_SHIFT_REG;
wire local_bb1__431_inputs_ready;
wire local_bb1__431_stall_local;
wire [7:0] local_bb1__431;

assign local_bb1__431_inputs_ready = (rnode_166to167_bb1_c0_ene1_0_valid_out_4_NO_SHIFT_REG & rnode_166to167_bb1_rows_726_0_pop13__0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_6_1_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_6_1_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_5_1_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_5_1_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_4_1_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_4_1_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_3_1_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_3_1_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_2_1_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb1_cmp16_2_1_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb1__402_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1__401_0_valid_out_NO_SHIFT_REG);
assign local_bb1__431 = (local_bb1__430 ? 8'h0 : local_bb1__429);
assign local_bb1_rows_727_0_pop12__valid_out_0 = 1'b1;
assign local_bb1__431_valid_out = 1'b1;
assign rnode_166to167_bb1_c0_ene1_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_rows_726_0_pop13__0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_6_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_6_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_5_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_5_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_4_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_4_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_3_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_3_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_2_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp16_2_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__402_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__401_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_727_0_pop12__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__431_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_727_0_pop12__consumed_0_NO_SHIFT_REG <= (local_bb1__431_inputs_ready & (local_bb1_rows_727_0_pop12__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_727_0_pop12__stall_in_0)) & local_bb1__431_stall_local);
		local_bb1__431_consumed_0_NO_SHIFT_REG <= (local_bb1__431_inputs_ready & (local_bb1__431_consumed_0_NO_SHIFT_REG | ~(local_bb1__431_stall_in)) & local_bb1__431_stall_local);
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_728_0_push11_rows_727_0_pop12_inputs_ready;
 reg local_bb1_rows_728_0_push11_rows_727_0_pop12_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_728_0_push11_rows_727_0_pop12_stall_in;
wire local_bb1_rows_728_0_push11_rows_727_0_pop12_output_regs_ready;
wire [7:0] local_bb1_rows_728_0_push11_rows_727_0_pop12_result;
wire local_bb1_rows_728_0_push11_rows_727_0_pop12_fu_valid_out;
wire local_bb1_rows_728_0_push11_rows_727_0_pop12_fu_stall_out;
 reg [7:0] local_bb1_rows_728_0_push11_rows_727_0_pop12_NO_SHIFT_REG;
wire local_bb1_rows_728_0_push11_rows_727_0_pop12_causedstall;

acl_push local_bb1_rows_728_0_push11_rows_727_0_pop12_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_166to167_bb1_c0_ene2_1_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_727_0_pop12_),
	.stall_out(local_bb1_rows_728_0_push11_rows_727_0_pop12_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[5]),
	.valid_out(local_bb1_rows_728_0_push11_rows_727_0_pop12_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_728_0_push11_rows_727_0_pop12_result),
	.feedback_out(feedback_data_out_11),
	.feedback_valid_out(feedback_valid_out_11),
	.feedback_stall_in(feedback_stall_in_11)
);

defparam local_bb1_rows_728_0_push11_rows_727_0_pop12_feedback.STALLFREE = 1;
defparam local_bb1_rows_728_0_push11_rows_727_0_pop12_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_728_0_push11_rows_727_0_pop12_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_728_0_push11_rows_727_0_pop12_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_728_0_push11_rows_727_0_pop12_feedback.STYLE = "REGULAR";

assign local_bb1_rows_728_0_push11_rows_727_0_pop12_inputs_ready = 1'b1;
assign local_bb1_rows_728_0_push11_rows_727_0_pop12_output_regs_ready = 1'b1;
assign local_bb1_rows_727_0_pop12__stall_in_0 = 1'b0;
assign rnode_166to167_bb1_c0_ene2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_728_0_push11_rows_727_0_pop12_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[5] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_728_0_push11_rows_727_0_pop12_NO_SHIFT_REG <= 'x;
		local_bb1_rows_728_0_push11_rows_727_0_pop12_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_728_0_push11_rows_727_0_pop12_output_regs_ready)
		begin
			local_bb1_rows_728_0_push11_rows_727_0_pop12_NO_SHIFT_REG <= local_bb1_rows_728_0_push11_rows_727_0_pop12_result;
			local_bb1_rows_728_0_push11_rows_727_0_pop12_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_728_0_push11_rows_727_0_pop12_stall_in))
			begin
				local_bb1_rows_728_0_push11_rows_727_0_pop12_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1__431_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1__431_0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1__431_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1__431_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1__431_0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1__431_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1__431_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_167to168_bb1__431_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1__431_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1__431_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1__431_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1__431_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1__431_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1__431_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1__431_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1__431_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1__431),
	.data_out(rnode_167to168_bb1__431_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1__431_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1__431_0_reg_168_fifo.DATA_WIDTH = 8;
defparam rnode_167to168_bb1__431_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1__431_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1__431_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__431_stall_in = 1'b0;
assign rnode_167to168_bb1__431_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1__431_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1__431_0_NO_SHIFT_REG = rnode_167to168_bb1__431_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1__431_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1__431_1_NO_SHIFT_REG = rnode_167to168_bb1__431_0_reg_168_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_rows_728_0_push11_rows_727_0_pop12_NO_SHIFT_REG),
	.data_out(rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_728_0_push11_rows_727_0_pop12_stall_in = 1'b0;
assign rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG = rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u25_stall_local;
wire [7:0] local_bb1_var__u25;

assign local_bb1_var__u25 = (rnode_167to168_bb1__431_0_NO_SHIFT_REG & 8'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG = rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_9_1_stall_local;
wire local_bb1_cmp19_9_1;

assign local_bb1_cmp19_9_1 = (local_bb1_var__u25 == 8'h0);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG),
	.data_out(rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_NO_SHIFT_REG = rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__432_demorgan_stall_local;
wire local_bb1__432_demorgan;

assign local_bb1__432_demorgan = (rnode_167to168_bb1_cmp16_9_1_0_NO_SHIFT_REG | local_bb1_cmp19_9_1);

// This section implements an unregistered operation.
// 
wire local_bb1__434_stall_local;
wire local_bb1__434;

assign local_bb1__434 = (local_bb1_cmp19_9_1 & local_bb1_not_cmp16_9_1);

// This section implements an unregistered operation.
// 
wire local_bb1__433_stall_local;
wire [7:0] local_bb1__433;

assign local_bb1__433 = (local_bb1__432_demorgan ? 8'h1 : rnode_167to168_bb1__431_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1__435_stall_local;
wire [7:0] local_bb1__435;

assign local_bb1__435 = (local_bb1__434 ? 8'h0 : local_bb1__433);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u26_stall_local;
wire [7:0] local_bb1_var__u26;

assign local_bb1_var__u26 = (local_bb1__435 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_10_1_stall_local;
wire local_bb1_cmp19_10_1;

assign local_bb1_cmp19_10_1 = (local_bb1_var__u26 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__436_demorgan_stall_local;
wire local_bb1__436_demorgan;

assign local_bb1__436_demorgan = (rnode_167to168_bb1_cmp16_10_1_0_NO_SHIFT_REG | local_bb1_cmp19_10_1);

// This section implements an unregistered operation.
// 
wire local_bb1__438_stall_local;
wire local_bb1__438;

assign local_bb1__438 = (local_bb1_cmp19_10_1 & local_bb1_not_cmp16_10_1);

// This section implements an unregistered operation.
// 
wire local_bb1__437_stall_local;
wire [7:0] local_bb1__437;

assign local_bb1__437 = (local_bb1__436_demorgan ? 8'h1 : local_bb1__435);

// This section implements an unregistered operation.
// 
wire local_bb1__439_stall_local;
wire [7:0] local_bb1__439;

assign local_bb1__439 = (local_bb1__438 ? 8'h0 : local_bb1__437);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u27_stall_local;
wire [7:0] local_bb1_var__u27;

assign local_bb1_var__u27 = (local_bb1__439 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_11_1_stall_local;
wire local_bb1_cmp19_11_1;

assign local_bb1_cmp19_11_1 = (local_bb1_var__u27 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__440_demorgan_stall_local;
wire local_bb1__440_demorgan;

assign local_bb1__440_demorgan = (rnode_167to168_bb1_cmp16_11_1_0_NO_SHIFT_REG | local_bb1_cmp19_11_1);

// This section implements an unregistered operation.
// 
wire local_bb1__442_stall_local;
wire local_bb1__442;

assign local_bb1__442 = (local_bb1_cmp19_11_1 & local_bb1_not_cmp16_11_1);

// This section implements an unregistered operation.
// 
wire local_bb1__441_stall_local;
wire [7:0] local_bb1__441;

assign local_bb1__441 = (local_bb1__440_demorgan ? 8'h1 : local_bb1__439);

// This section implements an unregistered operation.
// 
wire local_bb1__443_stall_local;
wire [7:0] local_bb1__443;

assign local_bb1__443 = (local_bb1__442 ? 8'h0 : local_bb1__441);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u28_stall_local;
wire [7:0] local_bb1_var__u28;

assign local_bb1_var__u28 = (local_bb1__443 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_12_1_stall_local;
wire local_bb1_cmp19_12_1;

assign local_bb1_cmp19_12_1 = (local_bb1_var__u28 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__444_demorgan_stall_local;
wire local_bb1__444_demorgan;

assign local_bb1__444_demorgan = (rnode_167to168_bb1_cmp16_12_1_0_NO_SHIFT_REG | local_bb1_cmp19_12_1);

// This section implements an unregistered operation.
// 
wire local_bb1__446_stall_local;
wire local_bb1__446;

assign local_bb1__446 = (local_bb1_cmp19_12_1 & local_bb1_not_cmp16_12_1);

// This section implements an unregistered operation.
// 
wire local_bb1__445_stall_local;
wire [7:0] local_bb1__445;

assign local_bb1__445 = (local_bb1__444_demorgan ? 8'h1 : local_bb1__443);

// This section implements an unregistered operation.
// 
wire local_bb1__447_stall_local;
wire [7:0] local_bb1__447;

assign local_bb1__447 = (local_bb1__446 ? 8'h0 : local_bb1__445);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u29_stall_local;
wire [7:0] local_bb1_var__u29;

assign local_bb1_var__u29 = (local_bb1__447 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_13_1_stall_local;
wire local_bb1_cmp19_13_1;

assign local_bb1_cmp19_13_1 = (local_bb1_var__u29 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__448_demorgan_stall_local;
wire local_bb1__448_demorgan;

assign local_bb1__448_demorgan = (local_bb1_cmp16_13_1 | local_bb1_cmp19_13_1);

// This section implements an unregistered operation.
// 
wire local_bb1__450_stall_local;
wire local_bb1__450;

assign local_bb1__450 = (local_bb1_cmp19_13_1 & local_bb1_not_cmp16_13_1);

// This section implements an unregistered operation.
// 
wire local_bb1__449_stall_local;
wire [7:0] local_bb1__449;

assign local_bb1__449 = (local_bb1__448_demorgan ? 8'h1 : local_bb1__447);

// This section implements an unregistered operation.
// 
wire local_bb1__451_stall_local;
wire [7:0] local_bb1__451;

assign local_bb1__451 = (local_bb1__450 ? 8'h0 : local_bb1__449);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u30_stall_local;
wire [7:0] local_bb1_var__u30;

assign local_bb1_var__u30 = (local_bb1__451 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_14_1_stall_local;
wire local_bb1_cmp19_14_1;

assign local_bb1_cmp19_14_1 = (local_bb1_var__u30 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__452_demorgan_stall_local;
wire local_bb1__452_demorgan;

assign local_bb1__452_demorgan = (local_bb1_cmp16_14_1 | local_bb1_cmp19_14_1);

// This section implements an unregistered operation.
// 
wire local_bb1__454_stall_local;
wire local_bb1__454;

assign local_bb1__454 = (local_bb1_cmp19_14_1 & local_bb1_not_cmp16_14_1);

// This section implements an unregistered operation.
// 
wire local_bb1__453_stall_local;
wire [7:0] local_bb1__453;

assign local_bb1__453 = (local_bb1__452_demorgan ? 8'h1 : local_bb1__451);

// This section implements an unregistered operation.
// 
wire local_bb1__455_stall_local;
wire [7:0] local_bb1__455;

assign local_bb1__455 = (local_bb1__454 ? 8'h0 : local_bb1__453);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u31_stall_local;
wire [7:0] local_bb1_var__u31;

assign local_bb1_var__u31 = (local_bb1__455 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_15_1_stall_local;
wire local_bb1_cmp19_15_1;

assign local_bb1_cmp19_15_1 = (local_bb1_var__u31 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__456_demorgan_stall_local;
wire local_bb1__456_demorgan;

assign local_bb1__456_demorgan = (local_bb1_cmp16_15_1 | local_bb1_cmp19_15_1);

// This section implements an unregistered operation.
// 
wire local_bb1__458_stall_local;
wire local_bb1__458;

assign local_bb1__458 = (local_bb1_cmp19_15_1 & local_bb1_not_cmp16_15_1);

// This section implements an unregistered operation.
// 
wire local_bb1__457_stall_local;
wire [7:0] local_bb1__457;

assign local_bb1__457 = (local_bb1__456_demorgan ? 8'h1 : local_bb1__455);

// This section implements an unregistered operation.
// 
wire local_bb1__459_stall_local;
wire [7:0] local_bb1__459;

assign local_bb1__459 = (local_bb1__458 ? 8'h0 : local_bb1__457);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u32_stall_local;
wire [7:0] local_bb1_var__u32;

assign local_bb1_var__u32 = (local_bb1__459 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_16_1_stall_local;
wire local_bb1_cmp19_16_1;

assign local_bb1_cmp19_16_1 = (local_bb1_var__u32 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__460_demorgan_stall_local;
wire local_bb1__460_demorgan;

assign local_bb1__460_demorgan = (local_bb1_cmp16_16_1 | local_bb1_cmp19_16_1);

// This section implements an unregistered operation.
// 
wire local_bb1_rows_733_0_pop6__valid_out_0;
wire local_bb1_rows_733_0_pop6__stall_in_0;
 reg local_bb1_rows_733_0_pop6__consumed_0_NO_SHIFT_REG;
wire local_bb1_rows_734_0_pop5__valid_out_0;
wire local_bb1_rows_734_0_pop5__stall_in_0;
 reg local_bb1_rows_734_0_pop5__consumed_0_NO_SHIFT_REG;
wire local_bb1__459_valid_out_1;
wire local_bb1__459_stall_in_1;
 reg local_bb1__459_consumed_1_NO_SHIFT_REG;
wire local_bb1_rows_735_0_pop4__valid_out_0;
wire local_bb1_rows_735_0_pop4__stall_in_0;
 reg local_bb1_rows_735_0_pop4__consumed_0_NO_SHIFT_REG;
wire local_bb1__460_demorgan_valid_out;
wire local_bb1__460_demorgan_stall_in;
 reg local_bb1__460_demorgan_consumed_0_NO_SHIFT_REG;
wire local_bb1__462_valid_out;
wire local_bb1__462_stall_in;
 reg local_bb1__462_consumed_0_NO_SHIFT_REG;
wire local_bb1__462_inputs_ready;
wire local_bb1__462_stall_local;
wire local_bb1__462;

assign local_bb1__462_inputs_ready = (rnode_167to168_bb1_c0_ene1_0_valid_out_7_NO_SHIFT_REG & rnode_167to168_bb1_rows_732_0_pop7__0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_12_1_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_12_1_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_10_1_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_10_1_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_11_1_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_11_1_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_9_1_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb1__431_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb1_cmp16_9_1_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb1_c0_ene1_0_valid_out_8_NO_SHIFT_REG & rnode_167to168_bb1__431_0_valid_out_0_NO_SHIFT_REG & rnode_167to168_bb1_c0_ene1_0_valid_out_9_NO_SHIFT_REG);
assign local_bb1__462 = (local_bb1_cmp19_16_1 & local_bb1_not_cmp16_16_1);
assign local_bb1_rows_733_0_pop6__valid_out_0 = 1'b1;
assign local_bb1_rows_734_0_pop5__valid_out_0 = 1'b1;
assign local_bb1__459_valid_out_1 = 1'b1;
assign local_bb1_rows_735_0_pop4__valid_out_0 = 1'b1;
assign local_bb1__460_demorgan_valid_out = 1'b1;
assign local_bb1__462_valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_7_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_rows_732_0_pop7__0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_12_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_12_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_10_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_10_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_11_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_11_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_9_1_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1__431_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_cmp16_9_1_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_8_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1__431_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene1_0_stall_in_9_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_733_0_pop6__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_734_0_pop5__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__459_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_rows_735_0_pop4__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__460_demorgan_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__462_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_rows_733_0_pop6__consumed_0_NO_SHIFT_REG <= (local_bb1__462_inputs_ready & (local_bb1_rows_733_0_pop6__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_733_0_pop6__stall_in_0)) & local_bb1__462_stall_local);
		local_bb1_rows_734_0_pop5__consumed_0_NO_SHIFT_REG <= (local_bb1__462_inputs_ready & (local_bb1_rows_734_0_pop5__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_734_0_pop5__stall_in_0)) & local_bb1__462_stall_local);
		local_bb1__459_consumed_1_NO_SHIFT_REG <= (local_bb1__462_inputs_ready & (local_bb1__459_consumed_1_NO_SHIFT_REG | ~(local_bb1__459_stall_in_1)) & local_bb1__462_stall_local);
		local_bb1_rows_735_0_pop4__consumed_0_NO_SHIFT_REG <= (local_bb1__462_inputs_ready & (local_bb1_rows_735_0_pop4__consumed_0_NO_SHIFT_REG | ~(local_bb1_rows_735_0_pop4__stall_in_0)) & local_bb1__462_stall_local);
		local_bb1__460_demorgan_consumed_0_NO_SHIFT_REG <= (local_bb1__462_inputs_ready & (local_bb1__460_demorgan_consumed_0_NO_SHIFT_REG | ~(local_bb1__460_demorgan_stall_in)) & local_bb1__462_stall_local);
		local_bb1__462_consumed_0_NO_SHIFT_REG <= (local_bb1__462_inputs_ready & (local_bb1__462_consumed_0_NO_SHIFT_REG | ~(local_bb1__462_stall_in)) & local_bb1__462_stall_local);
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_734_0_push5_rows_733_0_pop6_inputs_ready;
 reg local_bb1_rows_734_0_push5_rows_733_0_pop6_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_734_0_push5_rows_733_0_pop6_stall_in;
wire local_bb1_rows_734_0_push5_rows_733_0_pop6_output_regs_ready;
wire [7:0] local_bb1_rows_734_0_push5_rows_733_0_pop6_result;
wire local_bb1_rows_734_0_push5_rows_733_0_pop6_fu_valid_out;
wire local_bb1_rows_734_0_push5_rows_733_0_pop6_fu_stall_out;
 reg [7:0] local_bb1_rows_734_0_push5_rows_733_0_pop6_NO_SHIFT_REG;
wire local_bb1_rows_734_0_push5_rows_733_0_pop6_causedstall;

acl_push local_bb1_rows_734_0_push5_rows_733_0_pop6_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_4_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_733_0_pop6_),
	.stall_out(local_bb1_rows_734_0_push5_rows_733_0_pop6_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1_rows_734_0_push5_rows_733_0_pop6_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_734_0_push5_rows_733_0_pop6_result),
	.feedback_out(feedback_data_out_5),
	.feedback_valid_out(feedback_valid_out_5),
	.feedback_stall_in(feedback_stall_in_5)
);

defparam local_bb1_rows_734_0_push5_rows_733_0_pop6_feedback.STALLFREE = 1;
defparam local_bb1_rows_734_0_push5_rows_733_0_pop6_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_734_0_push5_rows_733_0_pop6_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_734_0_push5_rows_733_0_pop6_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_734_0_push5_rows_733_0_pop6_feedback.STYLE = "REGULAR";

assign local_bb1_rows_734_0_push5_rows_733_0_pop6_inputs_ready = 1'b1;
assign local_bb1_rows_734_0_push5_rows_733_0_pop6_output_regs_ready = 1'b1;
assign local_bb1_rows_733_0_pop6__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_734_0_push5_rows_733_0_pop6_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_734_0_push5_rows_733_0_pop6_NO_SHIFT_REG <= 'x;
		local_bb1_rows_734_0_push5_rows_733_0_pop6_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_734_0_push5_rows_733_0_pop6_output_regs_ready)
		begin
			local_bb1_rows_734_0_push5_rows_733_0_pop6_NO_SHIFT_REG <= local_bb1_rows_734_0_push5_rows_733_0_pop6_result;
			local_bb1_rows_734_0_push5_rows_733_0_pop6_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_734_0_push5_rows_733_0_pop6_stall_in))
			begin
				local_bb1_rows_734_0_push5_rows_733_0_pop6_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_rows_735_0_push4_rows_734_0_pop5_inputs_ready;
 reg local_bb1_rows_735_0_push4_rows_734_0_pop5_valid_out_NO_SHIFT_REG;
wire local_bb1_rows_735_0_push4_rows_734_0_pop5_stall_in;
wire local_bb1_rows_735_0_push4_rows_734_0_pop5_output_regs_ready;
wire [7:0] local_bb1_rows_735_0_push4_rows_734_0_pop5_result;
wire local_bb1_rows_735_0_push4_rows_734_0_pop5_fu_valid_out;
wire local_bb1_rows_735_0_push4_rows_734_0_pop5_fu_stall_out;
 reg [7:0] local_bb1_rows_735_0_push4_rows_734_0_pop5_NO_SHIFT_REG;
wire local_bb1_rows_735_0_push4_rows_734_0_pop5_causedstall;

acl_push local_bb1_rows_735_0_push4_rows_734_0_pop5_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rnode_167to168_bb1_c0_ene2_5_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(local_bb1_rows_734_0_pop5_),
	.stall_out(local_bb1_rows_735_0_push4_rows_734_0_pop5_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1_rows_735_0_push4_rows_734_0_pop5_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1_rows_735_0_push4_rows_734_0_pop5_result),
	.feedback_out(feedback_data_out_4),
	.feedback_valid_out(feedback_valid_out_4),
	.feedback_stall_in(feedback_stall_in_4)
);

defparam local_bb1_rows_735_0_push4_rows_734_0_pop5_feedback.STALLFREE = 1;
defparam local_bb1_rows_735_0_push4_rows_734_0_pop5_feedback.DATA_WIDTH = 8;
defparam local_bb1_rows_735_0_push4_rows_734_0_pop5_feedback.FIFO_DEPTH = 1;
defparam local_bb1_rows_735_0_push4_rows_734_0_pop5_feedback.MIN_FIFO_LATENCY = 1;
defparam local_bb1_rows_735_0_push4_rows_734_0_pop5_feedback.STYLE = "REGULAR";

assign local_bb1_rows_735_0_push4_rows_734_0_pop5_inputs_ready = 1'b1;
assign local_bb1_rows_735_0_push4_rows_734_0_pop5_output_regs_ready = 1'b1;
assign local_bb1_rows_734_0_pop5__stall_in_0 = 1'b0;
assign rnode_167to168_bb1_c0_ene2_0_stall_in_5_NO_SHIFT_REG = 1'b0;
assign local_bb1_rows_735_0_push4_rows_734_0_pop5_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_rows_735_0_push4_rows_734_0_pop5_NO_SHIFT_REG <= 'x;
		local_bb1_rows_735_0_push4_rows_734_0_pop5_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_rows_735_0_push4_rows_734_0_pop5_output_regs_ready)
		begin
			local_bb1_rows_735_0_push4_rows_734_0_pop5_NO_SHIFT_REG <= local_bb1_rows_735_0_push4_rows_734_0_pop5_result;
			local_bb1_rows_735_0_push4_rows_734_0_pop5_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_rows_735_0_push4_rows_734_0_pop5_stall_in))
			begin
				local_bb1_rows_735_0_push4_rows_734_0_pop5_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1__459_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1__459_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__459_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__459_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_168to169_bb1__459_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__459_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__459_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__459_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1__459_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1__459_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1__459_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1__459_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1__459_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1__459),
	.data_out(rnode_168to169_bb1__459_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1__459_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1__459_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_168to169_bb1__459_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1__459_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1__459_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__459_stall_in_1 = 1'b0;
assign rnode_168to169_bb1__459_0_NO_SHIFT_REG = rnode_168to169_bb1__459_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1__459_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__459_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1__coalesced_push2_rows_735_0_pop4_inputs_ready;
 reg local_bb1__coalesced_push2_rows_735_0_pop4_valid_out_NO_SHIFT_REG;
wire local_bb1__coalesced_push2_rows_735_0_pop4_stall_in;
wire local_bb1__coalesced_push2_rows_735_0_pop4_output_regs_ready;
wire [7:0] local_bb1__coalesced_push2_rows_735_0_pop4_result;
wire local_bb1__coalesced_push2_rows_735_0_pop4_fu_valid_out;
wire local_bb1__coalesced_push2_rows_735_0_pop4_fu_stall_out;
 reg [7:0] local_bb1__coalesced_push2_rows_735_0_pop4_NO_SHIFT_REG;
wire local_bb1__coalesced_push2_rows_735_0_pop4_causedstall;

acl_push local_bb1__coalesced_push2_rows_735_0_pop4_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(1'b1),
	.predicate(1'b0),
	.data_in(local_bb1_rows_735_0_pop4_),
	.stall_out(local_bb1__coalesced_push2_rows_735_0_pop4_fu_stall_out),
	.valid_in(local_bb1_c0_exit_c0_exi1_valid_bits[6]),
	.valid_out(local_bb1__coalesced_push2_rows_735_0_pop4_fu_valid_out),
	.stall_in(1'b0),
	.data_out(local_bb1__coalesced_push2_rows_735_0_pop4_result),
	.feedback_out(feedback_data_out_2),
	.feedback_valid_out(feedback_valid_out_2),
	.feedback_stall_in(feedback_stall_in_2)
);

defparam local_bb1__coalesced_push2_rows_735_0_pop4_feedback.STALLFREE = 1;
defparam local_bb1__coalesced_push2_rows_735_0_pop4_feedback.DATA_WIDTH = 8;
defparam local_bb1__coalesced_push2_rows_735_0_pop4_feedback.FIFO_DEPTH = 704;
defparam local_bb1__coalesced_push2_rows_735_0_pop4_feedback.MIN_FIFO_LATENCY = 704;
defparam local_bb1__coalesced_push2_rows_735_0_pop4_feedback.STYLE = "REGULAR";

assign local_bb1__coalesced_push2_rows_735_0_pop4_inputs_ready = 1'b1;
assign local_bb1__coalesced_push2_rows_735_0_pop4_output_regs_ready = 1'b1;
assign local_bb1_rows_735_0_pop4__stall_in_0 = 1'b0;
assign local_bb1__coalesced_push2_rows_735_0_pop4_causedstall = (local_bb1_c0_exit_c0_exi1_valid_bits[6] && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__coalesced_push2_rows_735_0_pop4_NO_SHIFT_REG <= 'x;
		local_bb1__coalesced_push2_rows_735_0_pop4_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1__coalesced_push2_rows_735_0_pop4_output_regs_ready)
		begin
			local_bb1__coalesced_push2_rows_735_0_pop4_NO_SHIFT_REG <= local_bb1__coalesced_push2_rows_735_0_pop4_result;
			local_bb1__coalesced_push2_rows_735_0_pop4_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1__coalesced_push2_rows_735_0_pop4_stall_in))
			begin
				local_bb1__coalesced_push2_rows_735_0_pop4_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1__460_demorgan_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1__460_demorgan_0_stall_in_NO_SHIFT_REG;
 logic rnode_168to169_bb1__460_demorgan_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__460_demorgan_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1__460_demorgan_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__460_demorgan_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__460_demorgan_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__460_demorgan_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1__460_demorgan_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1__460_demorgan_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1__460_demorgan_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1__460_demorgan_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1__460_demorgan_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1__460_demorgan),
	.data_out(rnode_168to169_bb1__460_demorgan_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1__460_demorgan_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1__460_demorgan_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1__460_demorgan_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1__460_demorgan_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1__460_demorgan_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__460_demorgan_stall_in = 1'b0;
assign rnode_168to169_bb1__460_demorgan_0_NO_SHIFT_REG = rnode_168to169_bb1__460_demorgan_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1__460_demorgan_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__460_demorgan_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1__462_0_valid_out_NO_SHIFT_REG;
 logic rnode_168to169_bb1__462_0_stall_in_NO_SHIFT_REG;
 logic rnode_168to169_bb1__462_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__462_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_168to169_bb1__462_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__462_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__462_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__462_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1__462_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1__462_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1__462_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1__462_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1__462_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1__462),
	.data_out(rnode_168to169_bb1__462_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1__462_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1__462_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_168to169_bb1__462_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1__462_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1__462_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__462_stall_in = 1'b0;
assign rnode_168to169_bb1__462_0_NO_SHIFT_REG = rnode_168to169_bb1__462_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1__462_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__462_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_rows_734_0_push5_rows_733_0_pop6_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_734_0_push5_rows_733_0_pop6_stall_in = 1'b0;
assign rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_NO_SHIFT_REG = rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_rows_735_0_push4_rows_734_0_pop5_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_rows_735_0_push4_rows_734_0_pop5_stall_in = 1'b0;
assign rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_NO_SHIFT_REG = rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__coalesced_push2_rows_735_0_pop4_NO_SHIFT_REG),
	.data_out(rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__coalesced_push2_rows_735_0_pop4_stall_in = 1'b0;
assign rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_NO_SHIFT_REG = rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__461_stall_local;
wire [7:0] local_bb1__461;

assign local_bb1__461 = (rnode_168to169_bb1__460_demorgan_0_NO_SHIFT_REG ? 8'h1 : rnode_168to169_bb1__459_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1__463_stall_local;
wire [7:0] local_bb1__463;

assign local_bb1__463 = (rnode_168to169_bb1__462_0_NO_SHIFT_REG ? 8'h0 : local_bb1__461);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u33_stall_local;
wire [7:0] local_bb1_var__u33;

assign local_bb1_var__u33 = (local_bb1__463 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_229_stall_local;
wire local_bb1_cmp19_229;

assign local_bb1_cmp19_229 = (local_bb1_var__u33 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__464_demorgan_stall_local;
wire local_bb1__464_demorgan;

assign local_bb1__464_demorgan = (rnode_168to169_bb1_cmp16_228_0_NO_SHIFT_REG | local_bb1_cmp19_229);

// This section implements an unregistered operation.
// 
wire local_bb1__466_stall_local;
wire local_bb1__466;

assign local_bb1__466 = (local_bb1_cmp19_229 & local_bb1_not_cmp16_228);

// This section implements an unregistered operation.
// 
wire local_bb1__465_stall_local;
wire [7:0] local_bb1__465;

assign local_bb1__465 = (local_bb1__464_demorgan ? 8'h1 : local_bb1__463);

// This section implements an unregistered operation.
// 
wire local_bb1__467_stall_local;
wire [7:0] local_bb1__467;

assign local_bb1__467 = (local_bb1__466 ? 8'h0 : local_bb1__465);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u34_stall_local;
wire [7:0] local_bb1_var__u34;

assign local_bb1_var__u34 = (local_bb1__467 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_1_2_stall_local;
wire local_bb1_cmp19_1_2;

assign local_bb1_cmp19_1_2 = (local_bb1_var__u34 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__468_demorgan_stall_local;
wire local_bb1__468_demorgan;

assign local_bb1__468_demorgan = (local_bb1_cmp16_1_2 | local_bb1_cmp19_1_2);

// This section implements an unregistered operation.
// 
wire local_bb1__470_stall_local;
wire local_bb1__470;

assign local_bb1__470 = (local_bb1_cmp19_1_2 & local_bb1_not_cmp16_1_2);

// This section implements an unregistered operation.
// 
wire local_bb1__469_stall_local;
wire [7:0] local_bb1__469;

assign local_bb1__469 = (local_bb1__468_demorgan ? 8'h1 : local_bb1__467);

// This section implements an unregistered operation.
// 
wire local_bb1__471_stall_local;
wire [7:0] local_bb1__471;

assign local_bb1__471 = (local_bb1__470 ? 8'h0 : local_bb1__469);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u35_stall_local;
wire [7:0] local_bb1_var__u35;

assign local_bb1_var__u35 = (local_bb1__471 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_2_2_stall_local;
wire local_bb1_cmp19_2_2;

assign local_bb1_cmp19_2_2 = (local_bb1_var__u35 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__472_demorgan_stall_local;
wire local_bb1__472_demorgan;

assign local_bb1__472_demorgan = (rnode_168to169_bb1_cmp16_2_2_0_NO_SHIFT_REG | local_bb1_cmp19_2_2);

// This section implements an unregistered operation.
// 
wire local_bb1__474_stall_local;
wire local_bb1__474;

assign local_bb1__474 = (local_bb1_cmp19_2_2 & local_bb1_not_cmp16_2_2);

// This section implements an unregistered operation.
// 
wire local_bb1__473_stall_local;
wire [7:0] local_bb1__473;

assign local_bb1__473 = (local_bb1__472_demorgan ? 8'h1 : local_bb1__471);

// This section implements an unregistered operation.
// 
wire local_bb1__475_stall_local;
wire [7:0] local_bb1__475;

assign local_bb1__475 = (local_bb1__474 ? 8'h0 : local_bb1__473);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u36_stall_local;
wire [7:0] local_bb1_var__u36;

assign local_bb1_var__u36 = (local_bb1__475 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_3_2_stall_local;
wire local_bb1_cmp19_3_2;

assign local_bb1_cmp19_3_2 = (local_bb1_var__u36 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__476_demorgan_stall_local;
wire local_bb1__476_demorgan;

assign local_bb1__476_demorgan = (rnode_168to169_bb1_cmp16_3_2_0_NO_SHIFT_REG | local_bb1_cmp19_3_2);

// This section implements an unregistered operation.
// 
wire local_bb1__478_stall_local;
wire local_bb1__478;

assign local_bb1__478 = (local_bb1_cmp19_3_2 & local_bb1_not_cmp16_3_2);

// This section implements an unregistered operation.
// 
wire local_bb1__477_stall_local;
wire [7:0] local_bb1__477;

assign local_bb1__477 = (local_bb1__476_demorgan ? 8'h1 : local_bb1__475);

// This section implements an unregistered operation.
// 
wire local_bb1__479_stall_local;
wire [7:0] local_bb1__479;

assign local_bb1__479 = (local_bb1__478 ? 8'h0 : local_bb1__477);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u37_stall_local;
wire [7:0] local_bb1_var__u37;

assign local_bb1_var__u37 = (local_bb1__479 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_4_2_stall_local;
wire local_bb1_cmp19_4_2;

assign local_bb1_cmp19_4_2 = (local_bb1_var__u37 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__480_demorgan_stall_local;
wire local_bb1__480_demorgan;

assign local_bb1__480_demorgan = (rnode_168to169_bb1_cmp16_4_2_0_NO_SHIFT_REG | local_bb1_cmp19_4_2);

// This section implements an unregistered operation.
// 
wire local_bb1__482_stall_local;
wire local_bb1__482;

assign local_bb1__482 = (local_bb1_cmp19_4_2 & local_bb1_not_cmp16_4_2);

// This section implements an unregistered operation.
// 
wire local_bb1__481_stall_local;
wire [7:0] local_bb1__481;

assign local_bb1__481 = (local_bb1__480_demorgan ? 8'h1 : local_bb1__479);

// This section implements an unregistered operation.
// 
wire local_bb1__483_stall_local;
wire [7:0] local_bb1__483;

assign local_bb1__483 = (local_bb1__482 ? 8'h0 : local_bb1__481);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u38_stall_local;
wire [7:0] local_bb1_var__u38;

assign local_bb1_var__u38 = (local_bb1__483 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_5_2_stall_local;
wire local_bb1_cmp19_5_2;

assign local_bb1_cmp19_5_2 = (local_bb1_var__u38 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__484_demorgan_stall_local;
wire local_bb1__484_demorgan;

assign local_bb1__484_demorgan = (rnode_168to169_bb1_cmp16_5_2_0_NO_SHIFT_REG | local_bb1_cmp19_5_2);

// This section implements an unregistered operation.
// 
wire local_bb1__486_stall_local;
wire local_bb1__486;

assign local_bb1__486 = (local_bb1_cmp19_5_2 & local_bb1_not_cmp16_5_2);

// This section implements an unregistered operation.
// 
wire local_bb1__485_stall_local;
wire [7:0] local_bb1__485;

assign local_bb1__485 = (local_bb1__484_demorgan ? 8'h1 : local_bb1__483);

// This section implements an unregistered operation.
// 
wire local_bb1__487_stall_local;
wire [7:0] local_bb1__487;

assign local_bb1__487 = (local_bb1__486 ? 8'h0 : local_bb1__485);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u39_stall_local;
wire [7:0] local_bb1_var__u39;

assign local_bb1_var__u39 = (local_bb1__487 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_6_2_stall_local;
wire local_bb1_cmp19_6_2;

assign local_bb1_cmp19_6_2 = (local_bb1_var__u39 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__488_demorgan_stall_local;
wire local_bb1__488_demorgan;

assign local_bb1__488_demorgan = (rnode_168to169_bb1_cmp16_6_2_0_NO_SHIFT_REG | local_bb1_cmp19_6_2);

// This section implements an unregistered operation.
// 
wire local_bb1__490_stall_local;
wire local_bb1__490;

assign local_bb1__490 = (local_bb1_cmp19_6_2 & local_bb1_not_cmp16_6_2);

// This section implements an unregistered operation.
// 
wire local_bb1__489_valid_out;
wire local_bb1__489_stall_in;
 reg local_bb1__489_consumed_0_NO_SHIFT_REG;
wire local_bb1__490_valid_out;
wire local_bb1__490_stall_in;
 reg local_bb1__490_consumed_0_NO_SHIFT_REG;
wire local_bb1__489_inputs_ready;
wire local_bb1__489_stall_local;
wire [7:0] local_bb1__489;

assign local_bb1__489_inputs_ready = (rnode_168to169_bb1__pop36__0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_2_2_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_2_2_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_3_2_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_3_2_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_4_2_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_4_2_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_5_2_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_5_2_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_6_2_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb1__460_demorgan_0_valid_out_NO_SHIFT_REG & rnode_168to169_bb1__459_0_valid_out_NO_SHIFT_REG & rnode_168to169_bb1__462_0_valid_out_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_228_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_228_0_valid_out_1_NO_SHIFT_REG & rnode_168to169_bb1_cmp16_6_2_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1__489 = (local_bb1__488_demorgan ? 8'h1 : local_bb1__487);
assign local_bb1__489_valid_out = 1'b1;
assign local_bb1__490_valid_out = 1'b1;
assign rnode_168to169_bb1__pop36__0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_2_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_2_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_3_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_3_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_4_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_4_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_5_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_5_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_6_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__460_demorgan_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__459_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__462_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_228_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_228_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1_cmp16_6_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__489_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__490_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__489_consumed_0_NO_SHIFT_REG <= (local_bb1__489_inputs_ready & (local_bb1__489_consumed_0_NO_SHIFT_REG | ~(local_bb1__489_stall_in)) & local_bb1__489_stall_local);
		local_bb1__490_consumed_0_NO_SHIFT_REG <= (local_bb1__489_inputs_ready & (local_bb1__490_consumed_0_NO_SHIFT_REG | ~(local_bb1__490_stall_in)) & local_bb1__489_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1__489_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1__489_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1__489_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__489_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1__489_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__489_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__489_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__489_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1__489_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1__489_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1__489_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1__489_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1__489_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1__489),
	.data_out(rnode_169to170_bb1__489_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1__489_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1__489_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1__489_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1__489_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1__489_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__489_stall_in = 1'b0;
assign rnode_169to170_bb1__489_0_NO_SHIFT_REG = rnode_169to170_bb1__489_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1__489_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__489_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1__490_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1__490_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1__490_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__490_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1__490_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__490_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__490_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__490_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1__490_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1__490_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1__490_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1__490_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1__490_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1__490),
	.data_out(rnode_169to170_bb1__490_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1__490_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1__490_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1__490_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1__490_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1__490_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__490_stall_in = 1'b0;
assign rnode_169to170_bb1__490_0_NO_SHIFT_REG = rnode_169to170_bb1__490_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1__490_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__490_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__491_stall_local;
wire [7:0] local_bb1__491;

assign local_bb1__491 = (rnode_169to170_bb1__490_0_NO_SHIFT_REG ? 8'h0 : rnode_169to170_bb1__489_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u40_stall_local;
wire [7:0] local_bb1_var__u40;

assign local_bb1_var__u40 = (local_bb1__491 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_7_2_stall_local;
wire local_bb1_cmp19_7_2;

assign local_bb1_cmp19_7_2 = (local_bb1_var__u40 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__492_demorgan_stall_local;
wire local_bb1__492_demorgan;

assign local_bb1__492_demorgan = (rnode_169to170_bb1_cmp16_7_2_0_NO_SHIFT_REG | local_bb1_cmp19_7_2);

// This section implements an unregistered operation.
// 
wire local_bb1__494_stall_local;
wire local_bb1__494;

assign local_bb1__494 = (local_bb1_cmp19_7_2 & local_bb1_not_cmp16_7_2);

// This section implements an unregistered operation.
// 
wire local_bb1__493_stall_local;
wire [7:0] local_bb1__493;

assign local_bb1__493 = (local_bb1__492_demorgan ? 8'h1 : local_bb1__491);

// This section implements an unregistered operation.
// 
wire local_bb1__495_stall_local;
wire [7:0] local_bb1__495;

assign local_bb1__495 = (local_bb1__494 ? 8'h0 : local_bb1__493);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u41_stall_local;
wire [7:0] local_bb1_var__u41;

assign local_bb1_var__u41 = (local_bb1__495 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_8_2_stall_local;
wire local_bb1_cmp19_8_2;

assign local_bb1_cmp19_8_2 = (local_bb1_var__u41 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__496_demorgan_stall_local;
wire local_bb1__496_demorgan;

assign local_bb1__496_demorgan = (rnode_169to170_bb1_cmp16_8_2_0_NO_SHIFT_REG | local_bb1_cmp19_8_2);

// This section implements an unregistered operation.
// 
wire local_bb1__498_stall_local;
wire local_bb1__498;

assign local_bb1__498 = (local_bb1_cmp19_8_2 & local_bb1_not_cmp16_8_2);

// This section implements an unregistered operation.
// 
wire local_bb1__497_stall_local;
wire [7:0] local_bb1__497;

assign local_bb1__497 = (local_bb1__496_demorgan ? 8'h1 : local_bb1__495);

// This section implements an unregistered operation.
// 
wire local_bb1__499_stall_local;
wire [7:0] local_bb1__499;

assign local_bb1__499 = (local_bb1__498 ? 8'h0 : local_bb1__497);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u42_stall_local;
wire [7:0] local_bb1_var__u42;

assign local_bb1_var__u42 = (local_bb1__499 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_9_2_stall_local;
wire local_bb1_cmp19_9_2;

assign local_bb1_cmp19_9_2 = (local_bb1_var__u42 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__500_demorgan_stall_local;
wire local_bb1__500_demorgan;

assign local_bb1__500_demorgan = (rnode_169to170_bb1_cmp16_9_2_0_NO_SHIFT_REG | local_bb1_cmp19_9_2);

// This section implements an unregistered operation.
// 
wire local_bb1__502_stall_local;
wire local_bb1__502;

assign local_bb1__502 = (local_bb1_cmp19_9_2 & local_bb1_not_cmp16_9_2);

// This section implements an unregistered operation.
// 
wire local_bb1__501_stall_local;
wire [7:0] local_bb1__501;

assign local_bb1__501 = (local_bb1__500_demorgan ? 8'h1 : local_bb1__499);

// This section implements an unregistered operation.
// 
wire local_bb1__503_stall_local;
wire [7:0] local_bb1__503;

assign local_bb1__503 = (local_bb1__502 ? 8'h0 : local_bb1__501);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u43_stall_local;
wire [7:0] local_bb1_var__u43;

assign local_bb1_var__u43 = (local_bb1__503 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_10_2_stall_local;
wire local_bb1_cmp19_10_2;

assign local_bb1_cmp19_10_2 = (local_bb1_var__u43 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__504_demorgan_stall_local;
wire local_bb1__504_demorgan;

assign local_bb1__504_demorgan = (rnode_169to170_bb1_cmp16_10_2_0_NO_SHIFT_REG | local_bb1_cmp19_10_2);

// This section implements an unregistered operation.
// 
wire local_bb1__506_stall_local;
wire local_bb1__506;

assign local_bb1__506 = (local_bb1_cmp19_10_2 & local_bb1_not_cmp16_10_2);

// This section implements an unregistered operation.
// 
wire local_bb1__505_stall_local;
wire [7:0] local_bb1__505;

assign local_bb1__505 = (local_bb1__504_demorgan ? 8'h1 : local_bb1__503);

// This section implements an unregistered operation.
// 
wire local_bb1__507_stall_local;
wire [7:0] local_bb1__507;

assign local_bb1__507 = (local_bb1__506 ? 8'h0 : local_bb1__505);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u44_stall_local;
wire [7:0] local_bb1_var__u44;

assign local_bb1_var__u44 = (local_bb1__507 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__507_op_stall_local;
wire [7:0] local_bb1__507_op;

assign local_bb1__507_op = (local_bb1__507 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_11_2_stall_local;
wire local_bb1_cmp19_11_2;

assign local_bb1_cmp19_11_2 = (local_bb1_var__u44 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__508_demorgan_stall_local;
wire local_bb1__508_demorgan;

assign local_bb1__508_demorgan = (rnode_169to170_bb1_cmp16_11_2_0_NO_SHIFT_REG | local_bb1_cmp19_11_2);

// This section implements an unregistered operation.
// 
wire local_bb1__510_stall_local;
wire local_bb1__510;

assign local_bb1__510 = (local_bb1_cmp19_11_2 & local_bb1_not_cmp16_11_2);

// This section implements an unregistered operation.
// 
wire local_bb1__509_op_stall_local;
wire [7:0] local_bb1__509_op;

assign local_bb1__509_op = (local_bb1__508_demorgan ? 8'h1 : local_bb1__507_op);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u45_stall_local;
wire [7:0] local_bb1_var__u45;

assign local_bb1_var__u45 = (local_bb1__510 ? 8'h0 : local_bb1__509_op);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_12_2_stall_local;
wire local_bb1_cmp19_12_2;

assign local_bb1_cmp19_12_2 = (local_bb1_var__u45 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__512_demorgan_stall_local;
wire local_bb1__512_demorgan;

assign local_bb1__512_demorgan = (rnode_169to170_bb1_cmp16_12_2_0_NO_SHIFT_REG | local_bb1_cmp19_12_2);

// This section implements an unregistered operation.
// 
wire local_bb1__514_stall_local;
wire local_bb1__514;

assign local_bb1__514 = (local_bb1_cmp19_12_2 & local_bb1_not_cmp16_12_2);

// This section implements an unregistered operation.
// 
wire local_bb1__513_op_stall_local;
wire [7:0] local_bb1__513_op;

assign local_bb1__513_op = (local_bb1__512_demorgan ? 8'h1 : local_bb1_var__u45);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u46_stall_local;
wire [7:0] local_bb1_var__u46;

assign local_bb1_var__u46 = (local_bb1__514 ? 8'h0 : local_bb1__513_op);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_13_2_stall_local;
wire local_bb1_cmp19_13_2;

assign local_bb1_cmp19_13_2 = (local_bb1_var__u46 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__516_demorgan_stall_local;
wire local_bb1__516_demorgan;

assign local_bb1__516_demorgan = (local_bb1_cmp16_13_2 | local_bb1_cmp19_13_2);

// This section implements an unregistered operation.
// 
wire local_bb1__518_stall_local;
wire local_bb1__518;

assign local_bb1__518 = (local_bb1_cmp19_13_2 & local_bb1_not_cmp16_13_2);

// This section implements an unregistered operation.
// 
wire local_bb1__517_op_stall_local;
wire [7:0] local_bb1__517_op;

assign local_bb1__517_op = (local_bb1__516_demorgan ? 8'h1 : local_bb1_var__u46);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u47_valid_out;
wire local_bb1_var__u47_stall_in;
wire local_bb1_var__u47_inputs_ready;
wire local_bb1_var__u47_stall_local;
wire [7:0] local_bb1_var__u47;

assign local_bb1_var__u47_inputs_ready = (rnode_169to170_bb1__pop48__0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_11_2_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_11_2_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_12_2_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_12_2_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_7_2_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_7_2_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1__490_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1__489_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_8_2_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_8_2_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_9_2_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_9_2_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_10_2_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp16_10_2_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_var__u47 = (local_bb1__518 ? 8'h0 : local_bb1__517_op);
assign local_bb1_var__u47_valid_out = 1'b1;
assign rnode_169to170_bb1__pop48__0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_11_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_11_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_12_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_12_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_7_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_7_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__490_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__489_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_8_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_8_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_9_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_9_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_10_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp16_10_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_var__u47_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u47_0_stall_in_0_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_var__u47_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u47_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u47_0_stall_in_1_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_var__u47_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u47_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_170to171_bb1_var__u47_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u47_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u47_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u47_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_var__u47_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_var__u47_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_var__u47_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_var__u47_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_var__u47_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_var__u47),
	.data_out(rnode_170to171_bb1_var__u47_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_var__u47_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_var__u47_0_reg_171_fifo.DATA_WIDTH = 8;
defparam rnode_170to171_bb1_var__u47_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_var__u47_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_var__u47_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u47_stall_in = 1'b0;
assign rnode_170to171_bb1_var__u47_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_var__u47_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_var__u47_0_NO_SHIFT_REG = rnode_170to171_bb1_var__u47_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_var__u47_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_var__u47_1_NO_SHIFT_REG = rnode_170to171_bb1_var__u47_0_reg_171_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_14_2_stall_local;
wire local_bb1_cmp19_14_2;

assign local_bb1_cmp19_14_2 = (rnode_170to171_bb1_var__u47_0_NO_SHIFT_REG == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__520_demorgan_stall_local;
wire local_bb1__520_demorgan;

assign local_bb1__520_demorgan = (rnode_170to171_bb1_cmp16_14_2_0_NO_SHIFT_REG | local_bb1_cmp19_14_2);

// This section implements an unregistered operation.
// 
wire local_bb1__522_stall_local;
wire local_bb1__522;

assign local_bb1__522 = (local_bb1_cmp19_14_2 & local_bb1_not_cmp16_14_2);

// This section implements an unregistered operation.
// 
wire local_bb1__521_op_stall_local;
wire [7:0] local_bb1__521_op;

assign local_bb1__521_op = (local_bb1__520_demorgan ? 8'h1 : rnode_170to171_bb1_var__u47_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u48_stall_local;
wire [7:0] local_bb1_var__u48;

assign local_bb1_var__u48 = (local_bb1__522 ? 8'h0 : local_bb1__521_op);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_15_2_stall_local;
wire local_bb1_cmp19_15_2;

assign local_bb1_cmp19_15_2 = (local_bb1_var__u48 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__524_demorgan_stall_local;
wire local_bb1__524_demorgan;

assign local_bb1__524_demorgan = (rnode_170to171_bb1_cmp16_15_2_0_NO_SHIFT_REG | local_bb1_cmp19_15_2);

// This section implements an unregistered operation.
// 
wire local_bb1__526_stall_local;
wire local_bb1__526;

assign local_bb1__526 = (local_bb1_cmp19_15_2 & local_bb1_not_cmp16_15_2);

// This section implements an unregistered operation.
// 
wire local_bb1__525_op_stall_local;
wire [7:0] local_bb1__525_op;

assign local_bb1__525_op = (local_bb1__524_demorgan ? 8'h1 : local_bb1_var__u48);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u49_stall_local;
wire [7:0] local_bb1_var__u49;

assign local_bb1_var__u49 = (local_bb1__526 ? 8'h0 : local_bb1__525_op);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp19_16_2_stall_local;
wire local_bb1_cmp19_16_2;

assign local_bb1_cmp19_16_2 = (local_bb1_var__u49 == 8'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__527_op_op_stall_local;
wire [7:0] local_bb1__527_op_op;

assign local_bb1__527_op_op = (local_bb1_var__u49 + 8'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1__528_demorgan_stall_local;
wire local_bb1__528_demorgan;

assign local_bb1__528_demorgan = (rnode_170to171_bb1_cmp16_16_2_0_NO_SHIFT_REG | local_bb1_cmp19_16_2);

// This section implements an unregistered operation.
// 
wire local_bb1__530_stall_local;
wire local_bb1__530;

assign local_bb1__530 = (local_bb1_cmp19_16_2 & local_bb1_not_cmp16_16_2);

// This section implements an unregistered operation.
// 
wire local_bb1__529_op_op_stall_local;
wire [7:0] local_bb1__529_op_op;

assign local_bb1__529_op_op = (local_bb1__528_demorgan ? 8'h0 : local_bb1__527_op_op);

// This section implements an unregistered operation.
// 
wire local_bb1_sext_stall_local;
wire [7:0] local_bb1_sext;

assign local_bb1_sext = (local_bb1__530 ? 8'hFF : local_bb1__529_op_op);

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi1_valid_out;
wire local_bb1_c0_exi1_stall_in;
wire local_bb1_c0_exi1_inputs_ready;
wire local_bb1_c0_exi1_stall_local;
wire [15:0] local_bb1_c0_exi1;

assign local_bb1_c0_exi1_inputs_ready = (rnode_170to171_bb1_cmp16_14_2_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb1_var__u47_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb1_cmp16_14_2_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb1_cmp16_15_2_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb1_cmp16_15_2_0_valid_out_1_NO_SHIFT_REG & rnode_170to171_bb1_var__u47_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb1_cmp16_16_2_0_valid_out_0_NO_SHIFT_REG & rnode_170to171_bb1_cmp16_16_2_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_c0_exi1[7:0] = 8'bxxxxxxxx;
assign local_bb1_c0_exi1[15:8] = local_bb1_sext;
assign local_bb1_c0_exi1_valid_out = 1'b1;
assign rnode_170to171_bb1_cmp16_14_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_var__u47_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_14_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_15_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_15_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_var__u47_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_16_2_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_cmp16_16_2_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_c0_exit_c0_exi1_inputs_ready;
 reg local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi1_stall_in;
 reg [15:0] local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG;
wire [15:0] local_bb1_c0_exit_c0_exi1_in;
wire local_bb1_c0_exit_c0_exi1_valid;
wire local_bb1_c0_exit_c0_exi1_causedstall;

acl_stall_free_sink local_bb1_c0_exit_c0_exi1_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c0_exi1),
	.data_out(local_bb1_c0_exit_c0_exi1_in),
	.input_accepted(local_bb1_c0_enter_c0_eni3_input_accepted),
	.valid_out(local_bb1_c0_exit_c0_exi1_valid),
	.stall_in(~(local_bb1_c0_exit_c0_exi1_output_regs_ready)),
	.stall_entry(local_bb1_c0_exit_c0_exi1_entry_stall),
	.valids(local_bb1_c0_exit_c0_exi1_valid_bits),
	.IIphases(local_bb1_c0_exit_c0_exi1_phases),
	.inc_pipelined_thread(local_bb1_c0_enter_c0_eni3_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c0_enter_c0_eni3_dec_pipelined_thread)
);

defparam local_bb1_c0_exit_c0_exi1_instance.DATA_WIDTH = 16;
defparam local_bb1_c0_exit_c0_exi1_instance.PIPELINE_DEPTH = 14;
defparam local_bb1_c0_exit_c0_exi1_instance.SHARINGII = 1;
defparam local_bb1_c0_exit_c0_exi1_instance.SCHEDULEII = 1;

assign local_bb1_c0_exit_c0_exi1_inputs_ready = 1'b1;
assign local_bb1_c0_exit_c0_exi1_output_regs_ready = (&(~(local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi1_stall_in)));
assign local_bb1_c0_exi1_stall_in = 1'b0;
assign local_bb1__push51__pop50_stall_in = 1'b0;
assign local_bb1__push50__pop49_stall_in = 1'b0;
assign local_bb1__push49__pop48_stall_in = 1'b0;
assign rnode_170to171_bb1__push48__pop47_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push47__pop46_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push46__pop45_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push45__pop44_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push44__pop43_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push43__pop42_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push42__pop41_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push41__pop40_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push40__pop39_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push39__pop38_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push38__pop37_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__push37__pop36_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_rows_733_0_push6_rows_732_0_pop7_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_rows_734_0_push5_rows_733_0_pop6_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_rows_735_0_push4_rows_734_0_pop5_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__push36__coalesced_pop2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1__coalesced_push2_rows_735_0_pop4_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_1_0_push34_rows_0_0_pop35_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_2_0_push33_rows_1_0_pop34_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_3_0_push32_rows_2_0_pop33_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_4_0_push31_rows_3_0_pop32_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_5_0_push30_rows_4_0_pop31_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_0_0_push35_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_7_0_push28_rows_6_0_pop29_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_15_0_push20_rows_14_0_pop21_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_8_0_push27_rows_7_0_pop28_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_14_0_push21_rows_13_0_pop22_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_9_0_push26_rows_8_0_pop27_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_10_0_push25_rows_9_0_pop26_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_11_0_push24_rows_10_0_pop25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_13_0_push22_rows_12_0_pop23_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_6_0_push29_rows_5_0_pop30_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_coalesce_counter_push54_next_coalesce_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_720_0_push19_rows_719_0_coalesced_pop3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_719_0_coalesced_push3_rows_15_0_pop20_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_726_0_push13_rows_725_0_pop14_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_725_0_push14_rows_724_0_pop15_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_724_0_push15_rows_723_0_pop16_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_723_0_push16_rows_722_0_pop17_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_12_0_push23_rows_11_0_pop24_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_722_0_push17_rows_721_0_pop18_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_721_0_push18_rows_720_0_pop19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_727_0_push12_rows_726_0_pop13_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_728_0_push11_rows_727_0_pop12_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_729_0_push10_rows_728_0_pop11_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_730_0_push9_rows_729_0_pop10_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_731_0_push8_rows_730_0_pop9_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_rows_732_0_push7_rows_731_0_pop8_0_stall_in_NO_SHIFT_REG = 1'b0;
assign local_bb1_c0_exit_c0_exi1_causedstall = (1'b1 && (1'b0 && !(~(local_bb1_c0_exit_c0_exi1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_exit_c0_exi1_output_regs_ready)
		begin
			local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_in;
			local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_valid;
		end
		else
		begin
			if (~(local_bb1_c0_exit_c0_exi1_stall_in))
			begin
				local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe1_valid_out;
wire local_bb1_c0_exe1_stall_in;
wire local_bb1_c0_exe1_inputs_ready;
wire local_bb1_c0_exe1_stall_local;
wire [7:0] local_bb1_c0_exe1;

assign local_bb1_c0_exe1_inputs_ready = local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exe1 = local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG[15:8];
assign local_bb1_c0_exe1_valid_out = local_bb1_c0_exe1_inputs_ready;
assign local_bb1_c0_exe1_stall_local = local_bb1_c0_exe1_stall_in;
assign local_bb1_c0_exit_c0_exi1_stall_in = (|local_bb1_c0_exe1_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_st_c0_exe1_inputs_ready;
 reg local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
wire local_bb1_st_c0_exe1_stall_in;
wire local_bb1_st_c0_exe1_output_regs_ready;
wire local_bb1_st_c0_exe1_fu_stall_out;
wire local_bb1_st_c0_exe1_fu_valid_out;
wire local_bb1_st_c0_exe1_causedstall;

lsu_top lsu_local_bb1_st_c0_exe1 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_st_c0_exe1_fu_stall_out),
	.i_valid(local_bb1_st_c0_exe1_inputs_ready),
	.i_address(rnode_175to176_bb1_arrayidx34_0_NO_SHIFT_REG),
	.i_writedata(local_bb1_c0_exe1),
	.i_cmpdata(),
	.i_predicate(rnode_175to176_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_st_c0_exe1_output_regs_ready)),
	.o_valid(local_bb1_st_c0_exe1_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_st_c0_exe1_active),
	.avm_address(avm_local_bb1_st_c0_exe1_address),
	.avm_read(avm_local_bb1_st_c0_exe1_read),
	.avm_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_write(avm_local_bb1_st_c0_exe1_write),
	.avm_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.avm_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_st_c0_exe1.AWIDTH = 30;
defparam lsu_local_bb1_st_c0_exe1.WIDTH_BYTES = 1;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_c0_exe1.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_c0_exe1.ALIGNMENT_BYTES = 1;
defparam lsu_local_bb1_st_c0_exe1.READ = 0;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC = 0;
defparam lsu_local_bb1_st_c0_exe1.WIDTH = 8;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH = 256;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_st_c0_exe1.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_st_c0_exe1.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb1_st_c0_exe1.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb1_st_c0_exe1.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_st_c0_exe1.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_st_c0_exe1.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_st_c0_exe1.NUMBER_BANKS = 1;
defparam lsu_local_bb1_st_c0_exe1.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_st_c0_exe1.USEINPUTFIFO = 0;
defparam lsu_local_bb1_st_c0_exe1.USECACHING = 0;
defparam lsu_local_bb1_st_c0_exe1.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_st_c0_exe1.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_st_c0_exe1.HIGH_FMAX = 1;
defparam lsu_local_bb1_st_c0_exe1.ADDRSPACE = 1;
defparam lsu_local_bb1_st_c0_exe1.STYLE = "BURST-COALESCED";
defparam lsu_local_bb1_st_c0_exe1.USE_BYTE_EN = 0;

assign local_bb1_st_c0_exe1_inputs_ready = (local_bb1_c0_exe1_valid_out & rnode_175to176_bb1_arrayidx34_0_valid_out_NO_SHIFT_REG & rnode_175to176_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG);
assign local_bb1_st_c0_exe1_output_regs_ready = (&(~(local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG) | ~(local_bb1_st_c0_exe1_stall_in)));
assign local_bb1_c0_exe1_stall_in = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign rnode_175to176_bb1_arrayidx34_0_stall_in_NO_SHIFT_REG = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign rnode_175to176_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign local_bb1_st_c0_exe1_causedstall = (local_bb1_st_c0_exe1_inputs_ready && (local_bb1_st_c0_exe1_fu_stall_out && !(~(local_bb1_st_c0_exe1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_st_c0_exe1_output_regs_ready)
		begin
			local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= local_bb1_st_c0_exe1_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_st_c0_exe1_stall_in))
			begin
				local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_180to180_bb1_st_c0_exe1_valid_out;
wire rstag_180to180_bb1_st_c0_exe1_stall_in;
wire rstag_180to180_bb1_st_c0_exe1_inputs_ready;
wire rstag_180to180_bb1_st_c0_exe1_stall_local;
 reg rstag_180to180_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG;
wire rstag_180to180_bb1_st_c0_exe1_combined_valid;

assign rstag_180to180_bb1_st_c0_exe1_inputs_ready = local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
assign rstag_180to180_bb1_st_c0_exe1_combined_valid = (rstag_180to180_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG | rstag_180to180_bb1_st_c0_exe1_inputs_ready);
assign rstag_180to180_bb1_st_c0_exe1_valid_out = rstag_180to180_bb1_st_c0_exe1_combined_valid;
assign rstag_180to180_bb1_st_c0_exe1_stall_local = rstag_180to180_bb1_st_c0_exe1_stall_in;
assign local_bb1_st_c0_exe1_stall_in = (|rstag_180to180_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_180to180_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_180to180_bb1_st_c0_exe1_stall_local)
		begin
			if (~(rstag_180to180_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_180to180_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= rstag_180to180_bb1_st_c0_exe1_inputs_ready;
			end
		end
		else
		begin
			rstag_180to180_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;

assign branch_var__inputs_ready = (rnode_179to180_bb1_initerations_push53_next_initerations_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_cleanups_push55_next_cleanups_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_masked_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG & rstag_180to180_bb1_st_c0_exe1_valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign rnode_179to180_bb1_initerations_push53_next_initerations_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_179to180_bb1_indvars_iv16_push52_indvars_iv_next17_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_179to180_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_179to180_bb1_cleanups_push55_next_cleanups_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_179to180_bb1_masked_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_179to180_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_180to180_bb1_st_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			branch_compare_result_NO_SHIFT_REG <= rnode_179to180_bb1_masked_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module erosion_basic_block_2
	(
		input 		clock,
		input 		resetn,
		input 		valid_in,
		output 		stall_out,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in;
 reg merge_node_valid_out_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in))
			begin
				merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = ~(stall_in);
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module erosion_function
	(
		input 		clock,
		input 		resetn,
		output 		stall_out,
		input 		valid_in,
		output 		valid_out,
		input 		stall_in,
		input [255:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [29:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [255:0] 		avm_local_bb1_ld__writedata,
		output [31:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		input [255:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		input 		start,
		input [31:0] 		input_iterations,
		input 		clock2x,
		input [63:0] 		input_img_in,
		input [63:0] 		input_img_out,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] workgroup_size;
wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire bb_0_lvb_bb0_cmp6;
wire bb_1_stall_out_0;
wire bb_1_stall_out_1;
wire bb_1_valid_out_0;
wire bb_1_valid_out_1;
wire bb_1_feedback_stall_out_55;
wire bb_1_feedback_stall_out_0;
wire bb_1_feedback_stall_out_1;
wire bb_1_acl_pipelined_valid;
wire bb_1_acl_pipelined_exiting_valid;
wire bb_1_acl_pipelined_exiting_stall;
wire bb_1_feedback_stall_out_53;
wire bb_1_feedback_stall_out_52;
wire bb_1_feedback_valid_out_53;
wire [3:0] bb_1_feedback_data_out_53;
wire bb_1_feedback_valid_out_0;
wire bb_1_feedback_data_out_0;
wire bb_1_feedback_valid_out_52;
wire [63:0] bb_1_feedback_data_out_52;
wire bb_1_feedback_valid_out_55;
wire [3:0] bb_1_feedback_data_out_55;
wire bb_1_local_bb1_ld__active;
wire bb_1_feedback_valid_out_1;
wire bb_1_feedback_data_out_1;
wire bb_1_feedback_stall_out_34;
wire bb_1_feedback_stall_out_35;
wire bb_1_feedback_stall_out_33;
wire bb_1_feedback_stall_out_32;
wire bb_1_feedback_stall_out_31;
wire bb_1_feedback_stall_out_30;
wire bb_1_feedback_stall_out_28;
wire bb_1_feedback_stall_out_27;
wire bb_1_feedback_stall_out_26;
wire bb_1_feedback_stall_out_20;
wire bb_1_feedback_stall_out_19;
wire bb_1_feedback_stall_out_21;
wire bb_1_feedback_stall_out_22;
wire bb_1_feedback_stall_out_23;
wire bb_1_feedback_stall_out_24;
wire bb_1_feedback_stall_out_54;
wire bb_1_feedback_stall_out_25;
wire bb_1_feedback_stall_out_29;
wire bb_1_feedback_valid_out_35;
wire [7:0] bb_1_feedback_data_out_35;
wire bb_1_feedback_valid_out_31;
wire [7:0] bb_1_feedback_data_out_31;
wire bb_1_feedback_valid_out_30;
wire [7:0] bb_1_feedback_data_out_30;
wire bb_1_feedback_valid_out_29;
wire [7:0] bb_1_feedback_data_out_29;
wire bb_1_feedback_stall_out_13;
wire bb_1_feedback_stall_out_14;
wire bb_1_feedback_stall_out_15;
wire bb_1_feedback_stall_out_16;
wire bb_1_feedback_stall_out_17;
wire bb_1_feedback_stall_out_18;
wire bb_1_feedback_valid_out_3;
wire [7:0] bb_1_feedback_data_out_3;
wire bb_1_feedback_valid_out_18;
wire [7:0] bb_1_feedback_data_out_18;
wire bb_1_feedback_valid_out_20;
wire [7:0] bb_1_feedback_data_out_20;
wire bb_1_feedback_valid_out_21;
wire [7:0] bb_1_feedback_data_out_21;
wire bb_1_feedback_valid_out_22;
wire [7:0] bb_1_feedback_data_out_22;
wire bb_1_feedback_stall_out_3;
wire bb_1_feedback_stall_out_10;
wire bb_1_feedback_stall_out_8;
wire bb_1_feedback_stall_out_7;
wire bb_1_feedback_stall_out_9;
wire bb_1_feedback_stall_out_12;
wire bb_1_feedback_stall_out_11;
wire bb_1_feedback_valid_out_23;
wire [7:0] bb_1_feedback_data_out_23;
wire bb_1_feedback_valid_out_12;
wire [7:0] bb_1_feedback_data_out_12;
wire bb_1_feedback_valid_out_13;
wire [7:0] bb_1_feedback_data_out_13;
wire bb_1_feedback_valid_out_14;
wire [7:0] bb_1_feedback_data_out_14;
wire bb_1_feedback_valid_out_15;
wire [7:0] bb_1_feedback_data_out_15;
wire bb_1_feedback_valid_out_16;
wire [7:0] bb_1_feedback_data_out_16;
wire bb_1_feedback_valid_out_17;
wire [7:0] bb_1_feedback_data_out_17;
wire bb_1_feedback_stall_out_40;
wire bb_1_feedback_stall_out_41;
wire bb_1_feedback_stall_out_42;
wire bb_1_feedback_stall_out_36;
wire bb_1_feedback_stall_out_37;
wire bb_1_feedback_stall_out_38;
wire bb_1_feedback_stall_out_39;
wire bb_1_feedback_stall_out_6;
wire bb_1_feedback_stall_out_5;
wire bb_1_feedback_stall_out_4;
wire bb_1_feedback_valid_out_54;
wire [10:0] bb_1_feedback_data_out_54;
wire bb_1_feedback_valid_out_19;
wire [7:0] bb_1_feedback_data_out_19;
wire bb_1_feedback_valid_out_9;
wire [7:0] bb_1_feedback_data_out_9;
wire bb_1_feedback_valid_out_7;
wire [7:0] bb_1_feedback_data_out_7;
wire bb_1_feedback_valid_out_6;
wire [7:0] bb_1_feedback_data_out_6;
wire bb_1_feedback_valid_out_8;
wire [7:0] bb_1_feedback_data_out_8;
wire bb_1_feedback_valid_out_10;
wire [7:0] bb_1_feedback_data_out_10;
wire bb_1_feedback_stall_out_48;
wire bb_1_feedback_stall_out_43;
wire bb_1_feedback_stall_out_44;
wire bb_1_feedback_stall_out_46;
wire bb_1_feedback_stall_out_47;
wire bb_1_feedback_stall_out_45;
wire bb_1_feedback_valid_out_41;
wire [7:0] bb_1_feedback_data_out_41;
wire bb_1_feedback_valid_out_42;
wire [7:0] bb_1_feedback_data_out_42;
wire bb_1_feedback_valid_out_43;
wire [7:0] bb_1_feedback_data_out_43;
wire bb_1_feedback_valid_out_37;
wire [7:0] bb_1_feedback_data_out_37;
wire bb_1_feedback_valid_out_38;
wire [7:0] bb_1_feedback_data_out_38;
wire bb_1_feedback_valid_out_39;
wire [7:0] bb_1_feedback_data_out_39;
wire bb_1_feedback_valid_out_40;
wire [7:0] bb_1_feedback_data_out_40;
wire bb_1_feedback_stall_out_49;
wire bb_1_feedback_stall_out_50;
wire bb_1_feedback_stall_out_51;
wire bb_1_feedback_valid_out_49;
wire [7:0] bb_1_feedback_data_out_49;
wire bb_1_feedback_valid_out_44;
wire [7:0] bb_1_feedback_data_out_44;
wire bb_1_feedback_valid_out_45;
wire [7:0] bb_1_feedback_data_out_45;
wire bb_1_feedback_valid_out_47;
wire [7:0] bb_1_feedback_data_out_47;
wire bb_1_feedback_valid_out_48;
wire [7:0] bb_1_feedback_data_out_48;
wire bb_1_feedback_valid_out_46;
wire [7:0] bb_1_feedback_data_out_46;
wire bb_1_feedback_stall_out_2;
wire bb_1_feedback_valid_out_50;
wire [7:0] bb_1_feedback_data_out_50;
wire bb_1_feedback_valid_out_51;
wire [7:0] bb_1_feedback_data_out_51;
wire bb_1_feedback_valid_out_36;
wire [7:0] bb_1_feedback_data_out_36;
wire bb_1_feedback_valid_out_33;
wire [7:0] bb_1_feedback_data_out_33;
wire bb_1_feedback_valid_out_34;
wire [7:0] bb_1_feedback_data_out_34;
wire bb_1_feedback_valid_out_32;
wire [7:0] bb_1_feedback_data_out_32;
wire bb_1_feedback_valid_out_27;
wire [7:0] bb_1_feedback_data_out_27;
wire bb_1_feedback_valid_out_26;
wire [7:0] bb_1_feedback_data_out_26;
wire bb_1_feedback_valid_out_25;
wire [7:0] bb_1_feedback_data_out_25;
wire bb_1_feedback_valid_out_28;
wire [7:0] bb_1_feedback_data_out_28;
wire bb_1_feedback_valid_out_24;
wire [7:0] bb_1_feedback_data_out_24;
wire bb_1_feedback_valid_out_11;
wire [7:0] bb_1_feedback_data_out_11;
wire bb_1_feedback_valid_out_5;
wire [7:0] bb_1_feedback_data_out_5;
wire bb_1_feedback_valid_out_4;
wire [7:0] bb_1_feedback_data_out_4;
wire bb_1_feedback_valid_out_2;
wire [7:0] bb_1_feedback_data_out_2;
wire bb_1_local_bb1_st_c0_exe1_active;
wire bb_2_stall_out;
wire bb_2_valid_out;
wire feedback_stall_53;
wire feedback_valid_53;
wire [3:0] feedback_data_53;
wire feedback_stall_52;
wire feedback_valid_52;
wire [63:0] feedback_data_52;
wire feedback_stall_0;
wire feedback_valid_0;
wire feedback_data_0;
wire feedback_stall_51;
wire feedback_valid_51;
wire [7:0] feedback_data_51;
wire feedback_stall_50;
wire feedback_valid_50;
wire [7:0] feedback_data_50;
wire feedback_stall_49;
wire feedback_valid_49;
wire [7:0] feedback_data_49;
wire feedback_stall_48;
wire feedback_valid_48;
wire [7:0] feedback_data_48;
wire feedback_stall_47;
wire feedback_valid_47;
wire [7:0] feedback_data_47;
wire feedback_stall_46;
wire feedback_valid_46;
wire [7:0] feedback_data_46;
wire feedback_stall_45;
wire feedback_valid_45;
wire [7:0] feedback_data_45;
wire feedback_stall_44;
wire feedback_valid_44;
wire [7:0] feedback_data_44;
wire feedback_stall_43;
wire feedback_valid_43;
wire [7:0] feedback_data_43;
wire feedback_stall_42;
wire feedback_valid_42;
wire [7:0] feedback_data_42;
wire feedback_stall_41;
wire feedback_valid_41;
wire [7:0] feedback_data_41;
wire feedback_stall_40;
wire feedback_valid_40;
wire [7:0] feedback_data_40;
wire feedback_stall_39;
wire feedback_valid_39;
wire [7:0] feedback_data_39;
wire feedback_stall_38;
wire feedback_valid_38;
wire [7:0] feedback_data_38;
wire feedback_stall_37;
wire feedback_valid_37;
wire [7:0] feedback_data_37;
wire feedback_stall_34;
wire feedback_valid_34;
wire [7:0] feedback_data_34;
wire feedback_stall_33;
wire feedback_valid_33;
wire [7:0] feedback_data_33;
wire feedback_stall_32;
wire feedback_valid_32;
wire [7:0] feedback_data_32;
wire feedback_stall_31;
wire feedback_valid_31;
wire [7:0] feedback_data_31;
wire feedback_stall_30;
wire feedback_valid_30;
wire [7:0] feedback_data_30;
wire feedback_stall_29;
wire feedback_valid_29;
wire [7:0] feedback_data_29;
wire feedback_stall_28;
wire feedback_valid_28;
wire [7:0] feedback_data_28;
wire feedback_stall_27;
wire feedback_valid_27;
wire [7:0] feedback_data_27;
wire feedback_stall_26;
wire feedback_valid_26;
wire [7:0] feedback_data_26;
wire feedback_stall_25;
wire feedback_valid_25;
wire [7:0] feedback_data_25;
wire feedback_stall_24;
wire feedback_valid_24;
wire [7:0] feedback_data_24;
wire feedback_stall_23;
wire feedback_valid_23;
wire [7:0] feedback_data_23;
wire feedback_stall_22;
wire feedback_valid_22;
wire [7:0] feedback_data_22;
wire feedback_stall_21;
wire feedback_valid_21;
wire [7:0] feedback_data_21;
wire feedback_stall_20;
wire feedback_valid_20;
wire [7:0] feedback_data_20;
wire feedback_stall_18;
wire feedback_valid_18;
wire [7:0] feedback_data_18;
wire feedback_stall_17;
wire feedback_valid_17;
wire [7:0] feedback_data_17;
wire feedback_stall_16;
wire feedback_valid_16;
wire [7:0] feedback_data_16;
wire feedback_stall_15;
wire feedback_valid_15;
wire [7:0] feedback_data_15;
wire feedback_stall_14;
wire feedback_valid_14;
wire [7:0] feedback_data_14;
wire feedback_stall_13;
wire feedback_valid_13;
wire [7:0] feedback_data_13;
wire feedback_stall_12;
wire feedback_valid_12;
wire [7:0] feedback_data_12;
wire feedback_stall_11;
wire feedback_valid_11;
wire [7:0] feedback_data_11;
wire feedback_stall_10;
wire feedback_valid_10;
wire [7:0] feedback_data_10;
wire feedback_stall_9;
wire feedback_valid_9;
wire [7:0] feedback_data_9;
wire feedback_stall_8;
wire feedback_valid_8;
wire [7:0] feedback_data_8;
wire feedback_stall_7;
wire feedback_valid_7;
wire [7:0] feedback_data_7;
wire feedback_stall_6;
wire feedback_valid_6;
wire [7:0] feedback_data_6;
wire feedback_stall_5;
wire feedback_valid_5;
wire [7:0] feedback_data_5;
wire feedback_stall_4;
wire feedback_valid_4;
wire [7:0] feedback_data_4;
wire feedback_stall_54;
wire feedback_valid_54;
wire [10:0] feedback_data_54;
wire feedback_stall_19;
wire feedback_valid_19;
wire [7:0] feedback_data_19;
wire feedback_stall_3;
wire feedback_valid_3;
wire [7:0] feedback_data_3;
wire feedback_stall_36;
wire feedback_valid_36;
wire [7:0] feedback_data_36;
wire feedback_stall_2;
wire feedback_valid_2;
wire [7:0] feedback_data_2;
wire feedback_stall_35;
wire feedback_valid_35;
wire [7:0] feedback_data_35;
wire feedback_stall_1;
wire feedback_valid_1;
wire feedback_data_1;
wire feedback_stall_55;
wire feedback_valid_55;
wire [3:0] feedback_data_55;
wire loop_limiter_0_stall_out;
wire loop_limiter_0_valid_out;
wire writes_pending;
wire [1:0] lsus_active;

erosion_basic_block_0 erosion_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.input_iterations(input_iterations),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.valid_out(bb_0_valid_out),
	.stall_in(loop_limiter_0_stall_out),
	.lvb_bb0_cmp6(bb_0_lvb_bb0_cmp6),
	.workgroup_size(workgroup_size)
);


erosion_basic_block_1 erosion_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_img_in(input_img_in),
	.input_img_out(input_img_out),
	.input_iterations(input_iterations),
	.input_wii_cmp6(bb_0_lvb_bb0_cmp6),
	.valid_in_0(bb_1_acl_pipelined_valid),
	.stall_out_0(bb_1_stall_out_0),
	.input_forked_0(1'b0),
	.valid_in_1(loop_limiter_0_valid_out),
	.stall_out_1(bb_1_stall_out_1),
	.input_forked_1(1'b1),
	.valid_out_0(bb_1_valid_out_0),
	.stall_in_0(bb_2_stall_out),
	.valid_out_1(bb_1_valid_out_1),
	.stall_in_1(1'b0),
	.workgroup_size(workgroup_size),
	.start(start),
	.feedback_valid_in_55(feedback_valid_55),
	.feedback_stall_out_55(feedback_stall_55),
	.feedback_data_in_55(feedback_data_55),
	.feedback_valid_in_0(feedback_valid_0),
	.feedback_stall_out_0(feedback_stall_0),
	.feedback_data_in_0(feedback_data_0),
	.feedback_valid_in_1(feedback_valid_1),
	.feedback_stall_out_1(feedback_stall_1),
	.feedback_data_in_1(feedback_data_1),
	.acl_pipelined_valid(bb_1_acl_pipelined_valid),
	.acl_pipelined_stall(bb_1_stall_out_0),
	.acl_pipelined_exiting_valid(bb_1_acl_pipelined_exiting_valid),
	.acl_pipelined_exiting_stall(bb_1_acl_pipelined_exiting_stall),
	.feedback_valid_in_53(feedback_valid_53),
	.feedback_stall_out_53(feedback_stall_53),
	.feedback_data_in_53(feedback_data_53),
	.feedback_valid_in_52(feedback_valid_52),
	.feedback_stall_out_52(feedback_stall_52),
	.feedback_data_in_52(feedback_data_52),
	.feedback_valid_out_53(feedback_valid_53),
	.feedback_stall_in_53(feedback_stall_53),
	.feedback_data_out_53(feedback_data_53),
	.feedback_valid_out_0(feedback_valid_0),
	.feedback_stall_in_0(feedback_stall_0),
	.feedback_data_out_0(feedback_data_0),
	.feedback_valid_out_52(feedback_valid_52),
	.feedback_stall_in_52(feedback_stall_52),
	.feedback_data_out_52(feedback_data_52),
	.feedback_valid_out_55(feedback_valid_55),
	.feedback_stall_in_55(feedback_stall_55),
	.feedback_data_out_55(feedback_data_55),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__burstcount),
	.local_bb1_ld__active(bb_1_local_bb1_ld__active),
	.clock2x(clock2x),
	.feedback_valid_out_1(feedback_valid_1),
	.feedback_stall_in_1(feedback_stall_1),
	.feedback_data_out_1(feedback_data_1),
	.feedback_valid_in_34(feedback_valid_34),
	.feedback_stall_out_34(feedback_stall_34),
	.feedback_data_in_34(feedback_data_34),
	.feedback_valid_in_35(feedback_valid_35),
	.feedback_stall_out_35(feedback_stall_35),
	.feedback_data_in_35(feedback_data_35),
	.feedback_valid_in_33(feedback_valid_33),
	.feedback_stall_out_33(feedback_stall_33),
	.feedback_data_in_33(feedback_data_33),
	.feedback_valid_in_32(feedback_valid_32),
	.feedback_stall_out_32(feedback_stall_32),
	.feedback_data_in_32(feedback_data_32),
	.feedback_valid_in_31(feedback_valid_31),
	.feedback_stall_out_31(feedback_stall_31),
	.feedback_data_in_31(feedback_data_31),
	.feedback_valid_in_30(feedback_valid_30),
	.feedback_stall_out_30(feedback_stall_30),
	.feedback_data_in_30(feedback_data_30),
	.feedback_valid_in_28(feedback_valid_28),
	.feedback_stall_out_28(feedback_stall_28),
	.feedback_data_in_28(feedback_data_28),
	.feedback_valid_in_27(feedback_valid_27),
	.feedback_stall_out_27(feedback_stall_27),
	.feedback_data_in_27(feedback_data_27),
	.feedback_valid_in_26(feedback_valid_26),
	.feedback_stall_out_26(feedback_stall_26),
	.feedback_data_in_26(feedback_data_26),
	.feedback_valid_in_20(feedback_valid_20),
	.feedback_stall_out_20(feedback_stall_20),
	.feedback_data_in_20(feedback_data_20),
	.feedback_valid_in_19(feedback_valid_19),
	.feedback_stall_out_19(feedback_stall_19),
	.feedback_data_in_19(feedback_data_19),
	.feedback_valid_in_21(feedback_valid_21),
	.feedback_stall_out_21(feedback_stall_21),
	.feedback_data_in_21(feedback_data_21),
	.feedback_valid_in_22(feedback_valid_22),
	.feedback_stall_out_22(feedback_stall_22),
	.feedback_data_in_22(feedback_data_22),
	.feedback_valid_in_23(feedback_valid_23),
	.feedback_stall_out_23(feedback_stall_23),
	.feedback_data_in_23(feedback_data_23),
	.feedback_valid_in_24(feedback_valid_24),
	.feedback_stall_out_24(feedback_stall_24),
	.feedback_data_in_24(feedback_data_24),
	.feedback_valid_in_54(feedback_valid_54),
	.feedback_stall_out_54(feedback_stall_54),
	.feedback_data_in_54(feedback_data_54),
	.feedback_valid_in_25(feedback_valid_25),
	.feedback_stall_out_25(feedback_stall_25),
	.feedback_data_in_25(feedback_data_25),
	.feedback_valid_in_29(feedback_valid_29),
	.feedback_stall_out_29(feedback_stall_29),
	.feedback_data_in_29(feedback_data_29),
	.feedback_valid_out_35(feedback_valid_35),
	.feedback_stall_in_35(feedback_stall_35),
	.feedback_data_out_35(feedback_data_35),
	.feedback_valid_out_31(feedback_valid_31),
	.feedback_stall_in_31(feedback_stall_31),
	.feedback_data_out_31(feedback_data_31),
	.feedback_valid_out_30(feedback_valid_30),
	.feedback_stall_in_30(feedback_stall_30),
	.feedback_data_out_30(feedback_data_30),
	.feedback_valid_out_29(feedback_valid_29),
	.feedback_stall_in_29(feedback_stall_29),
	.feedback_data_out_29(feedback_data_29),
	.feedback_valid_in_13(feedback_valid_13),
	.feedback_stall_out_13(feedback_stall_13),
	.feedback_data_in_13(feedback_data_13),
	.feedback_valid_in_14(feedback_valid_14),
	.feedback_stall_out_14(feedback_stall_14),
	.feedback_data_in_14(feedback_data_14),
	.feedback_valid_in_15(feedback_valid_15),
	.feedback_stall_out_15(feedback_stall_15),
	.feedback_data_in_15(feedback_data_15),
	.feedback_valid_in_16(feedback_valid_16),
	.feedback_stall_out_16(feedback_stall_16),
	.feedback_data_in_16(feedback_data_16),
	.feedback_valid_in_17(feedback_valid_17),
	.feedback_stall_out_17(feedback_stall_17),
	.feedback_data_in_17(feedback_data_17),
	.feedback_valid_in_18(feedback_valid_18),
	.feedback_stall_out_18(feedback_stall_18),
	.feedback_data_in_18(feedback_data_18),
	.feedback_valid_out_3(feedback_valid_3),
	.feedback_stall_in_3(feedback_stall_3),
	.feedback_data_out_3(feedback_data_3),
	.feedback_valid_out_18(feedback_valid_18),
	.feedback_stall_in_18(feedback_stall_18),
	.feedback_data_out_18(feedback_data_18),
	.feedback_valid_out_20(feedback_valid_20),
	.feedback_stall_in_20(feedback_stall_20),
	.feedback_data_out_20(feedback_data_20),
	.feedback_valid_out_21(feedback_valid_21),
	.feedback_stall_in_21(feedback_stall_21),
	.feedback_data_out_21(feedback_data_21),
	.feedback_valid_out_22(feedback_valid_22),
	.feedback_stall_in_22(feedback_stall_22),
	.feedback_data_out_22(feedback_data_22),
	.feedback_valid_in_3(feedback_valid_3),
	.feedback_stall_out_3(feedback_stall_3),
	.feedback_data_in_3(feedback_data_3),
	.feedback_valid_in_10(feedback_valid_10),
	.feedback_stall_out_10(feedback_stall_10),
	.feedback_data_in_10(feedback_data_10),
	.feedback_valid_in_8(feedback_valid_8),
	.feedback_stall_out_8(feedback_stall_8),
	.feedback_data_in_8(feedback_data_8),
	.feedback_valid_in_7(feedback_valid_7),
	.feedback_stall_out_7(feedback_stall_7),
	.feedback_data_in_7(feedback_data_7),
	.feedback_valid_in_9(feedback_valid_9),
	.feedback_stall_out_9(feedback_stall_9),
	.feedback_data_in_9(feedback_data_9),
	.feedback_valid_in_12(feedback_valid_12),
	.feedback_stall_out_12(feedback_stall_12),
	.feedback_data_in_12(feedback_data_12),
	.feedback_valid_in_11(feedback_valid_11),
	.feedback_stall_out_11(feedback_stall_11),
	.feedback_data_in_11(feedback_data_11),
	.feedback_valid_out_23(feedback_valid_23),
	.feedback_stall_in_23(feedback_stall_23),
	.feedback_data_out_23(feedback_data_23),
	.feedback_valid_out_12(feedback_valid_12),
	.feedback_stall_in_12(feedback_stall_12),
	.feedback_data_out_12(feedback_data_12),
	.feedback_valid_out_13(feedback_valid_13),
	.feedback_stall_in_13(feedback_stall_13),
	.feedback_data_out_13(feedback_data_13),
	.feedback_valid_out_14(feedback_valid_14),
	.feedback_stall_in_14(feedback_stall_14),
	.feedback_data_out_14(feedback_data_14),
	.feedback_valid_out_15(feedback_valid_15),
	.feedback_stall_in_15(feedback_stall_15),
	.feedback_data_out_15(feedback_data_15),
	.feedback_valid_out_16(feedback_valid_16),
	.feedback_stall_in_16(feedback_stall_16),
	.feedback_data_out_16(feedback_data_16),
	.feedback_valid_out_17(feedback_valid_17),
	.feedback_stall_in_17(feedback_stall_17),
	.feedback_data_out_17(feedback_data_17),
	.feedback_valid_in_40(feedback_valid_40),
	.feedback_stall_out_40(feedback_stall_40),
	.feedback_data_in_40(feedback_data_40),
	.feedback_valid_in_41(feedback_valid_41),
	.feedback_stall_out_41(feedback_stall_41),
	.feedback_data_in_41(feedback_data_41),
	.feedback_valid_in_42(feedback_valid_42),
	.feedback_stall_out_42(feedback_stall_42),
	.feedback_data_in_42(feedback_data_42),
	.feedback_valid_in_36(feedback_valid_36),
	.feedback_stall_out_36(feedback_stall_36),
	.feedback_data_in_36(feedback_data_36),
	.feedback_valid_in_37(feedback_valid_37),
	.feedback_stall_out_37(feedback_stall_37),
	.feedback_data_in_37(feedback_data_37),
	.feedback_valid_in_38(feedback_valid_38),
	.feedback_stall_out_38(feedback_stall_38),
	.feedback_data_in_38(feedback_data_38),
	.feedback_valid_in_39(feedback_valid_39),
	.feedback_stall_out_39(feedback_stall_39),
	.feedback_data_in_39(feedback_data_39),
	.feedback_valid_in_6(feedback_valid_6),
	.feedback_stall_out_6(feedback_stall_6),
	.feedback_data_in_6(feedback_data_6),
	.feedback_valid_in_5(feedback_valid_5),
	.feedback_stall_out_5(feedback_stall_5),
	.feedback_data_in_5(feedback_data_5),
	.feedback_valid_in_4(feedback_valid_4),
	.feedback_stall_out_4(feedback_stall_4),
	.feedback_data_in_4(feedback_data_4),
	.feedback_valid_out_54(feedback_valid_54),
	.feedback_stall_in_54(feedback_stall_54),
	.feedback_data_out_54(feedback_data_54),
	.feedback_valid_out_19(feedback_valid_19),
	.feedback_stall_in_19(feedback_stall_19),
	.feedback_data_out_19(feedback_data_19),
	.feedback_valid_out_9(feedback_valid_9),
	.feedback_stall_in_9(feedback_stall_9),
	.feedback_data_out_9(feedback_data_9),
	.feedback_valid_out_7(feedback_valid_7),
	.feedback_stall_in_7(feedback_stall_7),
	.feedback_data_out_7(feedback_data_7),
	.feedback_valid_out_6(feedback_valid_6),
	.feedback_stall_in_6(feedback_stall_6),
	.feedback_data_out_6(feedback_data_6),
	.feedback_valid_out_8(feedback_valid_8),
	.feedback_stall_in_8(feedback_stall_8),
	.feedback_data_out_8(feedback_data_8),
	.feedback_valid_out_10(feedback_valid_10),
	.feedback_stall_in_10(feedback_stall_10),
	.feedback_data_out_10(feedback_data_10),
	.feedback_valid_in_48(feedback_valid_48),
	.feedback_stall_out_48(feedback_stall_48),
	.feedback_data_in_48(feedback_data_48),
	.feedback_valid_in_43(feedback_valid_43),
	.feedback_stall_out_43(feedback_stall_43),
	.feedback_data_in_43(feedback_data_43),
	.feedback_valid_in_44(feedback_valid_44),
	.feedback_stall_out_44(feedback_stall_44),
	.feedback_data_in_44(feedback_data_44),
	.feedback_valid_in_46(feedback_valid_46),
	.feedback_stall_out_46(feedback_stall_46),
	.feedback_data_in_46(feedback_data_46),
	.feedback_valid_in_47(feedback_valid_47),
	.feedback_stall_out_47(feedback_stall_47),
	.feedback_data_in_47(feedback_data_47),
	.feedback_valid_in_45(feedback_valid_45),
	.feedback_stall_out_45(feedback_stall_45),
	.feedback_data_in_45(feedback_data_45),
	.feedback_valid_out_41(feedback_valid_41),
	.feedback_stall_in_41(feedback_stall_41),
	.feedback_data_out_41(feedback_data_41),
	.feedback_valid_out_42(feedback_valid_42),
	.feedback_stall_in_42(feedback_stall_42),
	.feedback_data_out_42(feedback_data_42),
	.feedback_valid_out_43(feedback_valid_43),
	.feedback_stall_in_43(feedback_stall_43),
	.feedback_data_out_43(feedback_data_43),
	.feedback_valid_out_37(feedback_valid_37),
	.feedback_stall_in_37(feedback_stall_37),
	.feedback_data_out_37(feedback_data_37),
	.feedback_valid_out_38(feedback_valid_38),
	.feedback_stall_in_38(feedback_stall_38),
	.feedback_data_out_38(feedback_data_38),
	.feedback_valid_out_39(feedback_valid_39),
	.feedback_stall_in_39(feedback_stall_39),
	.feedback_data_out_39(feedback_data_39),
	.feedback_valid_out_40(feedback_valid_40),
	.feedback_stall_in_40(feedback_stall_40),
	.feedback_data_out_40(feedback_data_40),
	.feedback_valid_in_49(feedback_valid_49),
	.feedback_stall_out_49(feedback_stall_49),
	.feedback_data_in_49(feedback_data_49),
	.feedback_valid_in_50(feedback_valid_50),
	.feedback_stall_out_50(feedback_stall_50),
	.feedback_data_in_50(feedback_data_50),
	.feedback_valid_in_51(feedback_valid_51),
	.feedback_stall_out_51(feedback_stall_51),
	.feedback_data_in_51(feedback_data_51),
	.feedback_valid_out_49(feedback_valid_49),
	.feedback_stall_in_49(feedback_stall_49),
	.feedback_data_out_49(feedback_data_49),
	.feedback_valid_out_44(feedback_valid_44),
	.feedback_stall_in_44(feedback_stall_44),
	.feedback_data_out_44(feedback_data_44),
	.feedback_valid_out_45(feedback_valid_45),
	.feedback_stall_in_45(feedback_stall_45),
	.feedback_data_out_45(feedback_data_45),
	.feedback_valid_out_47(feedback_valid_47),
	.feedback_stall_in_47(feedback_stall_47),
	.feedback_data_out_47(feedback_data_47),
	.feedback_valid_out_48(feedback_valid_48),
	.feedback_stall_in_48(feedback_stall_48),
	.feedback_data_out_48(feedback_data_48),
	.feedback_valid_out_46(feedback_valid_46),
	.feedback_stall_in_46(feedback_stall_46),
	.feedback_data_out_46(feedback_data_46),
	.feedback_valid_in_2(feedback_valid_2),
	.feedback_stall_out_2(feedback_stall_2),
	.feedback_data_in_2(feedback_data_2),
	.feedback_valid_out_50(feedback_valid_50),
	.feedback_stall_in_50(feedback_stall_50),
	.feedback_data_out_50(feedback_data_50),
	.feedback_valid_out_51(feedback_valid_51),
	.feedback_stall_in_51(feedback_stall_51),
	.feedback_data_out_51(feedback_data_51),
	.feedback_valid_out_36(feedback_valid_36),
	.feedback_stall_in_36(feedback_stall_36),
	.feedback_data_out_36(feedback_data_36),
	.feedback_valid_out_33(feedback_valid_33),
	.feedback_stall_in_33(feedback_stall_33),
	.feedback_data_out_33(feedback_data_33),
	.feedback_valid_out_34(feedback_valid_34),
	.feedback_stall_in_34(feedback_stall_34),
	.feedback_data_out_34(feedback_data_34),
	.feedback_valid_out_32(feedback_valid_32),
	.feedback_stall_in_32(feedback_stall_32),
	.feedback_data_out_32(feedback_data_32),
	.feedback_valid_out_27(feedback_valid_27),
	.feedback_stall_in_27(feedback_stall_27),
	.feedback_data_out_27(feedback_data_27),
	.feedback_valid_out_26(feedback_valid_26),
	.feedback_stall_in_26(feedback_stall_26),
	.feedback_data_out_26(feedback_data_26),
	.feedback_valid_out_25(feedback_valid_25),
	.feedback_stall_in_25(feedback_stall_25),
	.feedback_data_out_25(feedback_data_25),
	.feedback_valid_out_28(feedback_valid_28),
	.feedback_stall_in_28(feedback_stall_28),
	.feedback_data_out_28(feedback_data_28),
	.feedback_valid_out_24(feedback_valid_24),
	.feedback_stall_in_24(feedback_stall_24),
	.feedback_data_out_24(feedback_data_24),
	.feedback_valid_out_11(feedback_valid_11),
	.feedback_stall_in_11(feedback_stall_11),
	.feedback_data_out_11(feedback_data_11),
	.feedback_valid_out_5(feedback_valid_5),
	.feedback_stall_in_5(feedback_stall_5),
	.feedback_data_out_5(feedback_data_5),
	.feedback_valid_out_4(feedback_valid_4),
	.feedback_stall_in_4(feedback_stall_4),
	.feedback_data_out_4(feedback_data_4),
	.feedback_valid_out_2(feedback_valid_2),
	.feedback_stall_in_2(feedback_stall_2),
	.feedback_data_out_2(feedback_data_2),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.local_bb1_st_c0_exe1_active(bb_1_local_bb1_st_c0_exe1_active)
);


erosion_basic_block_2 erosion_basic_block_2 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_1_valid_out_0),
	.stall_out(bb_2_stall_out),
	.valid_out(bb_2_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start)
);


acl_loop_limiter loop_limiter_0 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_0_valid_out),
	.i_stall(bb_1_stall_out_1),
	.i_valid_exit(bb_1_acl_pipelined_exiting_valid),
	.i_stall_exit(bb_1_acl_pipelined_exiting_stall),
	.o_valid(loop_limiter_0_valid_out),
	.o_stall(loop_limiter_0_stall_out)
);

defparam loop_limiter_0.ENTRY_WIDTH = 1;
defparam loop_limiter_0.EXIT_WIDTH = 1;
defparam loop_limiter_0.THRESHOLD = 1;

erosion_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign workgroup_size = 32'h1;
assign valid_out = bb_2_valid_out;
assign stall_out = bb_0_stall_out;
assign writes_pending = bb_1_local_bb1_st_c0_exe1_active;
assign lsus_active[0] = bb_1_local_bb1_ld__active;
assign lsus_active[1] = bb_1_local_bb1_st_c0_exe1_active;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		has_a_write_pending <= 1'b0;
		has_a_lsu_active <= 1'b0;
	end
	else
	begin
		has_a_write_pending <= (|writes_pending);
		has_a_lsu_active <= (|lsus_active);
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module erosion_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output 		avs_cra_waitrequest,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [255:0] 		avm_local_bb1_ld__inst0_readdata,
		input 		avm_local_bb1_ld__inst0_readdatavalid,
		input 		avm_local_bb1_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb1_ld__inst0_address,
		output 		avm_local_bb1_ld__inst0_read,
		output 		avm_local_bb1_ld__inst0_write,
		input 		avm_local_bb1_ld__inst0_writeack,
		output [255:0] 		avm_local_bb1_ld__inst0_writedata,
		output [31:0] 		avm_local_bb1_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb1_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb1_st_c0_exe1_inst0_readdata,
		input 		avm_local_bb1_st_c0_exe1_inst0_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_inst0_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_inst0_address,
		output 		avm_local_bb1_st_c0_exe1_inst0_read,
		output 		avm_local_bb1_st_c0_exe1_inst0_write,
		input 		avm_local_bb1_st_c0_exe1_inst0_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_inst0_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_inst0_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_inst0_burstcount
	);

// Responsible for interfacing a kernel with the outside world. It comprises a
// slave interface to specify the kernel arguments and retain kernel status. 

// This section of the wrapper implements the slave interface.
// twoXclock_consumer uses clock2x, even if nobody inside the kernel does. Keeps interface to acl_iface consistent for all kernels.
 reg start_NO_SHIFT_REG;
 reg started_NO_SHIFT_REG;
wire finish;
 reg [31:0] status_NO_SHIFT_REG;
wire has_a_write_pending;
wire has_a_lsu_active;
 reg [159:0] kernel_arguments_NO_SHIFT_REG;
 reg twoXclock_consumer_NO_SHIFT_REG /* synthesis  preserve  noprune  */;
 reg [31:0] workgroup_size_NO_SHIFT_REG;
 reg [31:0] global_size_NO_SHIFT_REG[2:0];
 reg [31:0] num_groups_NO_SHIFT_REG[2:0];
 reg [31:0] local_size_NO_SHIFT_REG[2:0];
 reg [31:0] work_dim_NO_SHIFT_REG;
 reg [31:0] global_offset_NO_SHIFT_REG[2:0];
 reg [63:0] profile_data_NO_SHIFT_REG;
 reg [31:0] profile_ctrl_NO_SHIFT_REG;
 reg [63:0] profile_start_cycle_NO_SHIFT_REG;
 reg [63:0] profile_stop_cycle_NO_SHIFT_REG;
wire dispatched_all_groups;
wire [31:0] group_id_tmp[2:0];
wire [31:0] global_id_base_out[2:0];
wire start_out;
wire [31:0] local_id[0:0][2:0];
wire [31:0] global_id[0:0][2:0];
wire [31:0] group_id[0:0][2:0];
wire iter_valid_in;
wire iter_stall_out;
wire stall_in;
wire stall_out;
wire valid_in;
wire valid_out;

always @(posedge clock2x or negedge resetn)
begin
	if (~(resetn))
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b1;
	end
end



// Work group dispatcher is responsible for issuing work-groups to id iterator(s)
acl_work_group_dispatcher group_dispatcher (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.num_groups(num_groups_NO_SHIFT_REG),
	.local_size(local_size_NO_SHIFT_REG),
	.stall_in(iter_stall_out),
	.valid_out(iter_valid_in),
	.group_id_out(group_id_tmp),
	.global_id_base_out(global_id_base_out),
	.start_out(start_out),
	.dispatched_all_groups(dispatched_all_groups)
);

defparam group_dispatcher.NUM_COPIES = 1;
defparam group_dispatcher.RUN_FOREVER = 0;


// This section of the wrapper implements an Avalon Slave Interface used to configure a kernel invocation.
// The few words words contain the status and the workgroup size registers.
// The remaining addressable space is reserved for kernel arguments.
wire [63:0] bitenable;

assign bitenable[7:0] = (avs_cra_byteenable[0] ? 8'hFF : 8'h0);
assign bitenable[15:8] = (avs_cra_byteenable[1] ? 8'hFF : 8'h0);
assign bitenable[23:16] = (avs_cra_byteenable[2] ? 8'hFF : 8'h0);
assign bitenable[31:24] = (avs_cra_byteenable[3] ? 8'hFF : 8'h0);
assign bitenable[39:32] = (avs_cra_byteenable[4] ? 8'hFF : 8'h0);
assign bitenable[47:40] = (avs_cra_byteenable[5] ? 8'hFF : 8'h0);
assign bitenable[55:48] = (avs_cra_byteenable[6] ? 8'hFF : 8'h0);
assign bitenable[63:56] = (avs_cra_byteenable[7] ? 8'hFF : 8'h0);
assign avs_cra_waitrequest = 1'b0;
assign cra_irq = (status_NO_SHIFT_REG[1] | status_NO_SHIFT_REG[3]);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		start_NO_SHIFT_REG <= 1'b0;
		started_NO_SHIFT_REG <= 1'b0;
		kernel_arguments_NO_SHIFT_REG <= 160'h0;
		status_NO_SHIFT_REG <= 32'h30000;
		profile_ctrl_NO_SHIFT_REG <= 32'h4;
		profile_start_cycle_NO_SHIFT_REG <= 64'h0;
		profile_stop_cycle_NO_SHIFT_REG <= 64'hFFFFFFFFFFFFFFFF;
		work_dim_NO_SHIFT_REG <= 32'h0;
		workgroup_size_NO_SHIFT_REG <= 32'h0;
		global_size_NO_SHIFT_REG[0] <= 32'h0;
		global_size_NO_SHIFT_REG[1] <= 32'h0;
		global_size_NO_SHIFT_REG[2] <= 32'h0;
		num_groups_NO_SHIFT_REG[0] <= 32'h0;
		num_groups_NO_SHIFT_REG[1] <= 32'h0;
		num_groups_NO_SHIFT_REG[2] <= 32'h0;
		local_size_NO_SHIFT_REG[0] <= 32'h0;
		local_size_NO_SHIFT_REG[1] <= 32'h0;
		local_size_NO_SHIFT_REG[2] <= 32'h0;
		global_offset_NO_SHIFT_REG[0] <= 32'h0;
		global_offset_NO_SHIFT_REG[1] <= 32'h0;
		global_offset_NO_SHIFT_REG[2] <= 32'h0;
	end
	else
	begin
		if (avs_cra_write)
		begin
			case (avs_cra_address)
				4'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				4'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h5:
				begin
					work_dim_NO_SHIFT_REG <= ((work_dim_NO_SHIFT_REG & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size_NO_SHIFT_REG <= ((workgroup_size_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h6:
				begin
					global_size_NO_SHIFT_REG[0] <= ((global_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_NO_SHIFT_REG[1] <= ((global_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h7:
				begin
					global_size_NO_SHIFT_REG[2] <= ((global_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[0] <= ((num_groups_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h8:
				begin
					num_groups_NO_SHIFT_REG[1] <= ((num_groups_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[2] <= ((num_groups_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h9:
				begin
					local_size_NO_SHIFT_REG[0] <= ((local_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_NO_SHIFT_REG[1] <= ((local_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hA:
				begin
					local_size_NO_SHIFT_REG[2] <= ((local_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[0] <= ((global_offset_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hB:
				begin
					global_offset_NO_SHIFT_REG[1] <= ((global_offset_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[2] <= ((global_offset_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hC:
				begin
					kernel_arguments_NO_SHIFT_REG[31:0] <= ((kernel_arguments_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[63:32] <= ((kernel_arguments_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hD:
				begin
					kernel_arguments_NO_SHIFT_REG[95:64] <= ((kernel_arguments_NO_SHIFT_REG[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[127:96] <= ((kernel_arguments_NO_SHIFT_REG[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hE:
				begin
					kernel_arguments_NO_SHIFT_REG[159:128] <= ((kernel_arguments_NO_SHIFT_REG[159:128] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
				end

				default:
				begin
				end

			endcase
		end
		else
		begin
			if (status_NO_SHIFT_REG[0])
			begin
				start_NO_SHIFT_REG <= 1'b1;
			end
			if (start_NO_SHIFT_REG)
			begin
				status_NO_SHIFT_REG[0] <= 1'b0;
				started_NO_SHIFT_REG <= 1'b1;
			end
			if (started_NO_SHIFT_REG)
			begin
				start_NO_SHIFT_REG <= 1'b0;
			end
			if (finish)
			begin
				status_NO_SHIFT_REG[1] <= 1'b1;
				started_NO_SHIFT_REG <= 1'b0;
			end
		end
		status_NO_SHIFT_REG[11] <= local_router_hang;
		status_NO_SHIFT_REG[12] <= (|has_a_lsu_active);
		status_NO_SHIFT_REG[13] <= (|has_a_write_pending);
		status_NO_SHIFT_REG[14] <= (|valid_in);
		status_NO_SHIFT_REG[15] <= started_NO_SHIFT_REG;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdata <= 64'h0;
	end
	else
	begin
		case (avs_cra_address)
			4'h0:
			begin
				avs_cra_readdata[31:0] <= status_NO_SHIFT_REG;
				avs_cra_readdata[63:32] <= 32'h0;
			end

			4'h1:
			begin
				avs_cra_readdata[31:0] <= 'x;
				avs_cra_readdata[63:32] <= 32'h0;
			end

			4'h2:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h3:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h4:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h5:
			begin
				avs_cra_readdata[31:0] <= work_dim_NO_SHIFT_REG;
				avs_cra_readdata[63:32] <= workgroup_size_NO_SHIFT_REG;
			end

			4'h6:
			begin
				avs_cra_readdata[31:0] <= global_size_NO_SHIFT_REG[0];
				avs_cra_readdata[63:32] <= global_size_NO_SHIFT_REG[1];
			end

			4'h7:
			begin
				avs_cra_readdata[31:0] <= global_size_NO_SHIFT_REG[2];
				avs_cra_readdata[63:32] <= num_groups_NO_SHIFT_REG[0];
			end

			4'h8:
			begin
				avs_cra_readdata[31:0] <= num_groups_NO_SHIFT_REG[1];
				avs_cra_readdata[63:32] <= num_groups_NO_SHIFT_REG[2];
			end

			4'h9:
			begin
				avs_cra_readdata[31:0] <= local_size_NO_SHIFT_REG[0];
				avs_cra_readdata[63:32] <= local_size_NO_SHIFT_REG[1];
			end

			4'hA:
			begin
				avs_cra_readdata[31:0] <= local_size_NO_SHIFT_REG[2];
				avs_cra_readdata[63:32] <= global_offset_NO_SHIFT_REG[0];
			end

			4'hB:
			begin
				avs_cra_readdata[31:0] <= global_offset_NO_SHIFT_REG[1];
				avs_cra_readdata[63:32] <= global_offset_NO_SHIFT_REG[2];
			end

			4'hC:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[31:0];
				avs_cra_readdata[63:32] <= kernel_arguments_NO_SHIFT_REG[63:32];
			end

			4'hD:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[95:64];
				avs_cra_readdata[63:32] <= kernel_arguments_NO_SHIFT_REG[127:96];
			end

			4'hE:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[159:128];
				avs_cra_readdata[63:32] <= 32'h0;
			end

			default:
			begin
				avs_cra_readdata <= status_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdatavalid <= 1'b0;
	end
	else
	begin
		avs_cra_readdatavalid <= (avs_cra_read & ~(avs_cra_waitrequest));
	end
end


// Handshaking signals used to control data through the pipeline

// Determine when the kernel is finished.
acl_kernel_finish_detector kernel_finish_detector (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.wg_size(workgroup_size_NO_SHIFT_REG),
	.wg_dispatch_valid_out(iter_valid_in),
	.wg_dispatch_stall_in(iter_stall_out),
	.dispatched_all_groups(dispatched_all_groups),
	.kernel_copy_valid_out(valid_out),
	.kernel_copy_stall_in(stall_in),
	.pending_writes(has_a_write_pending),
	.finish(finish)
);

defparam kernel_finish_detector.NUM_COPIES = 1;
defparam kernel_finish_detector.WG_SIZE_W = 32;

assign stall_in = 1'b0;

// Creating ID iterator and kernel instance for every requested kernel copy

// ID iterator is responsible for iterating over all local ids for given work-groups
acl_id_iterator id_iter_inst0 (
	.clock(clock),
	.resetn(resetn),
	.start(start_out),
	.valid_in(iter_valid_in),
	.stall_out(iter_stall_out),
	.stall_in(stall_out),
	.valid_out(valid_in),
	.group_id_in(group_id_tmp),
	.global_id_base_in(global_id_base_out),
	.local_size(local_size_NO_SHIFT_REG),
	.global_size(global_size_NO_SHIFT_REG),
	.local_id(local_id[0]),
	.global_id(global_id[0]),
	.group_id(group_id[0])
);



// This section instantiates a kernel function block
erosion_function erosion_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__inst0_readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__inst0_readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__inst0_waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__inst0_address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__inst0_read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__inst0_write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__inst0_writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__inst0_writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__inst0_byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__inst0_burstcount),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_inst0_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_inst0_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_inst0_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_inst0_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_inst0_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_inst0_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_inst0_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_inst0_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_inst0_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_inst0_burstcount),
	.start(start_out),
	.input_iterations(kernel_arguments_NO_SHIFT_REG[159:128]),
	.clock2x(clock2x),
	.input_img_in(kernel_arguments_NO_SHIFT_REG[63:0]),
	.input_img_out(kernel_arguments_NO_SHIFT_REG[127:64]),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);



endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module erosion_sys_cycle_time
	(
		input 		clock,
		input 		resetn,
		output [31:0] 		cur_cycle
	);


 reg [31:0] cur_count_NO_SHIFT_REG;

assign cur_cycle = cur_count_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cur_count_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		cur_count_NO_SHIFT_REG <= (cur_count_NO_SHIFT_REG + 32'h1);
	end
end

endmodule

