-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from bb_hidden_B2_stall_region
-- VHDL created on Mon May 04 19:48:20 2026


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity bb_hidden_B2_stall_region is
    port (
        out_lsu_unnamed_hidden2_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        in_input_tile_size : in std_logic_vector(31 downto 0);  -- ufix32
        in_acl_hw_wg_id4 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c1_exe11 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_global_id_02 : in std_logic_vector(31 downto 0);  -- ufix32
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id4 : out std_logic_vector(31 downto 0);  -- ufix32
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_output_neurons_tile_size : in std_logic_vector(31 downto 0);  -- ufix32
        in_output_tile : in std_logic_vector(63 downto 0);  -- ufix64
        in_unnamed_hidden2_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_hidden2_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_hidden2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_hidden2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_hidden2_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_hidden2_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_hidden2_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_hidden2_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_hidden2_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_hidden2_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_hidden2_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_hidden_B2_stall_region;

architecture normal of bb_hidden_B2_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_store_unnamed_hidden2_hidden36 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_writedata : in std_logic_vector(31 downto 0);  -- Floating Point
            in_unnamed_hidden2_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_hidden2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_hidden2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_hidden2_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_lsu_unnamed_hidden2_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_hidden2_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_hidden2_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_hidden2_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_hidden2_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_hidden2_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_hidden2_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_hidden2_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_input_tile_size_sync_buffer1_hidden30 is
        port (
            in_buffer_in : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_dependence : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_buffer_out : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden27 is
        port (
            in_buffer_in : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_dependence : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_buffer_out : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_output_tile_sync_buffer_hidden33 is
        port (
            in_buffer_in : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_dependence : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_buffer_out : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component acl_valid_fifo_counter is
        generic (
            DEPTH : INTEGER := 0;
            ASYNC_RESET : INTEGER := 1;
            STRICT_DEPTH : INTEGER := 0;
            ALLOW_FULL_WRITE : INTEGER := 0
        );
        port (
            clock : in std_logic;
            resetn : in std_logic;
            valid_in : in std_logic;
            stall_in : in std_logic;
            valid_out : out std_logic;
            stall_out : out std_logic;
            full : out std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx9_hidden_hidden35_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_multconst_x_q : STD_LOGIC_VECTOR (60 downto 0);
    signal i_arrayidx9_hidden_hidden35_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx9_hidden_hidden35_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx9_hidden_hidden35_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx9_hidden_hidden35_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx9_hidden_hidden35_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_idxprom8_hidden_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal c_float_0_000000e_00_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c_i32_0gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_cmp21_rm13_hidden_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_rm13_hidden_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_rm13_hidden_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_rm13_hidden_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp_neg_rm14_hidden_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp_rm12_hidden_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm12_hidden_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm12_hidden_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm12_hidden_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_do_directly_for_end_loopexit_sel9_hidden_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_select4_hidden_s : STD_LOGIC_VECTOR (0 downto 0);
    signal i_select4_hidden_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_lsu_unnamed_hidden2_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_syncbuf_input_tile_size_sync_buffer1_hidden_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_input_tile_size_sync_buffer1_hidden_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_input_tile_size_sync_buffer1_hidden_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_output_tile_sync_buffer_hidden_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_output_tile_sync_buffer_hidden_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_output_tile_sync_buffer_hidden_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_join_13_q : STD_LOGIC_VECTOR (56 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_align_14_q : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_align_14_qint : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_join_16_q : STD_LOGIC_VECTOR (66 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_stall_entry_o4_4_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_stall_entry_o4_4_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_stall_entry_o4_4_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_stall_entry_o4_4_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_stall_entry_o5_2_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_stall_entry_o5_2_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_stall_entry_o6_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_i_arrayidx9_hidden_hidden35_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_input_tile_size_sync_buffer1_hidden_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_input_tile_size_sync_buffer1_hidden_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_output_tile_sync_buffer_hidden_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_output_tile_sync_buffer_hidden_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (95 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_c : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_d : STD_LOGIC_VECTOR (31 downto 0);
    signal SE_i_cmp21_rm13_hidden_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_rm13_hidden_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_rm13_hidden_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_rm13_hidden_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_rm13_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_rm13_hidden_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm12_hidden_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm12_hidden_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm12_hidden_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm12_hidden_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm12_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm12_hidden_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_store_unnamed_hidden2_hidden_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_store_unnamed_hidden2_hidden_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_store_unnamed_hidden2_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_store_unnamed_hidden2_hidden_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_tile_sync_buffer_hidden_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_tile_sync_buffer_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_output_tile_sync_buffer_hidden_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_R_v_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_R_v_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_s_tv_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_s_tv_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_0_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_1_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_2_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_2_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_2_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_2_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_3_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_3_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_3_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_3_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_stall_entry_o4_4_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_3_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_3_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_3_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_3_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_stall_out_bitsignaltemp : std_logic;
    signal SR_SE_i_cmp21_rm13_hidden_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp21_rm13_hidden_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp21_rm13_hidden_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp21_rm13_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp21_rm13_hidden_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp21_rm13_hidden_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_r_data2 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_1_D2 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm12_hidden_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_3_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_3_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_3_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_3_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_stall_entry_o4_4_3_D0 : STD_LOGIC_VECTOR (31 downto 0);

begin


    -- redist0_stall_entry_o4_4_1(REG,85)
    redist0_stall_entry_o4_4_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_stall_entry_o4_4_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_1_backEN = "1") THEN
                redist0_stall_entry_o4_4_1_q <= STD_LOGIC_VECTOR(SR_SE_redist0_stall_entry_o4_4_1_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_stall_entry_o4_4_2(REG,86)
    redist0_stall_entry_o4_4_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_stall_entry_o4_4_2_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_2_backEN = "1") THEN
                redist0_stall_entry_o4_4_2_q <= STD_LOGIC_VECTOR(redist0_stall_entry_o4_4_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- SE_redist0_stall_entry_o4_4_3(STALLENABLE,143)
    -- Valid signal propagation
    SE_redist0_stall_entry_o4_4_3_V0 <= SE_redist0_stall_entry_o4_4_3_R_v_0;
    -- Stall signal propagation
    SE_redist0_stall_entry_o4_4_3_s_tv_0 <= SE_out_i_store_unnamed_hidden2_hidden_backStall and SE_redist0_stall_entry_o4_4_3_R_v_0;
    -- Backward Enable generation
    SE_redist0_stall_entry_o4_4_3_backEN <= not (SE_redist0_stall_entry_o4_4_3_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_stall_entry_o4_4_3_v_s_0 <= SE_redist0_stall_entry_o4_4_3_backEN and SR_SE_redist0_stall_entry_o4_4_3_V;
    -- Backward Stall generation
    SE_redist0_stall_entry_o4_4_3_backStall <= not (SE_redist0_stall_entry_o4_4_3_backEN);
    SE_redist0_stall_entry_o4_4_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_stall_entry_o4_4_3_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_3_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_3_R_v_0 <= SE_redist0_stall_entry_o4_4_3_R_v_0 and SE_redist0_stall_entry_o4_4_3_s_tv_0;
            ELSE
                SE_redist0_stall_entry_o4_4_3_R_v_0 <= SE_redist0_stall_entry_o4_4_3_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist0_stall_entry_o4_4_3(STALLREG,178)
    SR_SE_redist0_stall_entry_o4_4_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist0_stall_entry_o4_4_3_r_valid <= (others => '0');
            SR_SE_redist0_stall_entry_o4_4_3_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist0_stall_entry_o4_4_3_r_valid <= SE_redist0_stall_entry_o4_4_3_backStall and (SR_SE_redist0_stall_entry_o4_4_3_r_valid or SR_SE_redist0_stall_entry_o4_4_3_i_valid);

            IF (SR_SE_redist0_stall_entry_o4_4_3_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist0_stall_entry_o4_4_3_r_data0 <= STD_LOGIC_VECTOR(redist0_stall_entry_o4_4_2_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist0_stall_entry_o4_4_3_i_valid <= SE_redist0_stall_entry_o4_4_2_V0;
    -- Stall signal propagation
    SR_SE_redist0_stall_entry_o4_4_3_backStall <= SR_SE_redist0_stall_entry_o4_4_3_r_valid or not (SR_SE_redist0_stall_entry_o4_4_3_i_valid);

    -- Valid
    SR_SE_redist0_stall_entry_o4_4_3_V <= SR_SE_redist0_stall_entry_o4_4_3_r_valid WHEN SR_SE_redist0_stall_entry_o4_4_3_r_valid = "1" ELSE SR_SE_redist0_stall_entry_o4_4_3_i_valid;

    SR_SE_redist0_stall_entry_o4_4_3_D0 <= SR_SE_redist0_stall_entry_o4_4_3_r_data0 WHEN SR_SE_redist0_stall_entry_o4_4_3_r_valid = "1" ELSE redist0_stall_entry_o4_4_2_q;

    -- SE_redist0_stall_entry_o4_4_2(STALLENABLE,142)
    -- Valid signal propagation
    SE_redist0_stall_entry_o4_4_2_V0 <= SE_redist0_stall_entry_o4_4_2_R_v_0;
    -- Stall signal propagation
    SE_redist0_stall_entry_o4_4_2_s_tv_0 <= SR_SE_redist0_stall_entry_o4_4_3_backStall and SE_redist0_stall_entry_o4_4_2_R_v_0;
    -- Backward Enable generation
    SE_redist0_stall_entry_o4_4_2_backEN <= not (SE_redist0_stall_entry_o4_4_2_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_stall_entry_o4_4_2_v_s_0 <= SE_redist0_stall_entry_o4_4_2_backEN and SE_redist0_stall_entry_o4_4_1_V0;
    -- Backward Stall generation
    SE_redist0_stall_entry_o4_4_2_backStall <= not (SE_redist0_stall_entry_o4_4_2_v_s_0);
    SE_redist0_stall_entry_o4_4_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_stall_entry_o4_4_2_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_2_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_2_R_v_0 <= SE_redist0_stall_entry_o4_4_2_R_v_0 and SE_redist0_stall_entry_o4_4_2_s_tv_0;
            ELSE
                SE_redist0_stall_entry_o4_4_2_R_v_0 <= SE_redist0_stall_entry_o4_4_2_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist0_stall_entry_o4_4_1(STALLENABLE,141)
    -- Valid signal propagation
    SE_redist0_stall_entry_o4_4_1_V0 <= SE_redist0_stall_entry_o4_4_1_R_v_0;
    SE_redist0_stall_entry_o4_4_1_V1 <= SE_redist0_stall_entry_o4_4_1_R_v_1;
    -- Stall signal propagation
    SE_redist0_stall_entry_o4_4_1_s_tv_0 <= SE_redist0_stall_entry_o4_4_2_backStall and SE_redist0_stall_entry_o4_4_1_R_v_0;
    SE_redist0_stall_entry_o4_4_1_s_tv_1 <= SE_out_i_syncbuf_output_tile_sync_buffer_hidden_backStall and SE_redist0_stall_entry_o4_4_1_R_v_1;
    -- Backward Enable generation
    SE_redist0_stall_entry_o4_4_1_or0 <= SE_redist0_stall_entry_o4_4_1_s_tv_0;
    SE_redist0_stall_entry_o4_4_1_backEN <= not (SE_redist0_stall_entry_o4_4_1_s_tv_1 or SE_redist0_stall_entry_o4_4_1_or0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_stall_entry_o4_4_1_v_s_0 <= SE_redist0_stall_entry_o4_4_1_backEN and SR_SE_redist0_stall_entry_o4_4_1_V;
    -- Backward Stall generation
    SE_redist0_stall_entry_o4_4_1_backStall <= not (SE_redist0_stall_entry_o4_4_1_backEN);
    SE_redist0_stall_entry_o4_4_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_stall_entry_o4_4_1_R_v_0 <= (others => '0');
            SE_redist0_stall_entry_o4_4_1_R_v_1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_1_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_1_R_v_0 <= SE_redist0_stall_entry_o4_4_1_R_v_0 and SE_redist0_stall_entry_o4_4_1_s_tv_0;
            ELSE
                SE_redist0_stall_entry_o4_4_1_R_v_0 <= SE_redist0_stall_entry_o4_4_1_v_s_0;
            END IF;

            IF (SE_redist0_stall_entry_o4_4_1_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_1_R_v_1 <= SE_redist0_stall_entry_o4_4_1_R_v_1 and SE_redist0_stall_entry_o4_4_1_s_tv_1;
            ELSE
                SE_redist0_stall_entry_o4_4_1_R_v_1 <= SE_redist0_stall_entry_o4_4_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- i_arrayidx9_hidden_hidden35_mult_multconst_x(CONSTANT,18)
    i_arrayidx9_hidden_hidden35_mult_multconst_x_q <= "0000000000000000000000000000000000000000000000000000000000000";

    -- bubble_join_stall_entry(BITJOIN,103)
    bubble_join_stall_entry_q <= in_global_id_02 & in_c1_exe11 & in_acl_hw_wg_id4;

    -- bubble_select_stall_entry(BITSELECT,104)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(31 downto 0));
    bubble_select_stall_entry_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(63 downto 32));
    bubble_select_stall_entry_d <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(95 downto 64));

    -- redist2_stall_entry_o6_1_0(REG,90)
    redist2_stall_entry_o6_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_stall_entry_o6_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_0_backEN = "1") THEN
                redist2_stall_entry_o6_1_0_q <= STD_LOGIC_VECTOR(bubble_select_stall_entry_d);
            END IF;
        END IF;
    END PROCESS;

    -- i_idxprom8_hidden_sel_x(BITSELECT,24)@1
    i_idxprom8_hidden_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(redist2_stall_entry_o6_1_0_q(31 downto 0)), 64)));

    -- i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select(BITSELECT,79)@1
    i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_b <= i_idxprom8_hidden_sel_x_b(17 downto 0);
    i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_c <= i_idxprom8_hidden_sel_x_b(63 downto 54);
    i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_d <= i_idxprom8_hidden_sel_x_b(35 downto 18);
    i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_e <= i_idxprom8_hidden_sel_x_b(53 downto 36);

    -- i_arrayidx9_hidden_hidden35_mult_x_im3_shift0(BITSHIFT,76)@1
    i_arrayidx9_hidden_hidden35_mult_x_im3_shift0_qint <= i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_c & "00";
    i_arrayidx9_hidden_hidden35_mult_x_im3_shift0_q <= i_arrayidx9_hidden_hidden35_mult_x_im3_shift0_qint(11 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_x_align_15(BITSHIFT,71)@1
    i_arrayidx9_hidden_hidden35_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx9_hidden_hidden35_mult_x_im3_shift0_q) & "000000000000000";
    i_arrayidx9_hidden_hidden35_mult_x_align_15_q <= i_arrayidx9_hidden_hidden35_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_x_im6_shift0(BITSHIFT,77)@1
    i_arrayidx9_hidden_hidden35_mult_x_im6_shift0_qint <= i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_d & "00";
    i_arrayidx9_hidden_hidden35_mult_x_im6_shift0_q <= i_arrayidx9_hidden_hidden35_mult_x_im6_shift0_qint(19 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_x_align_14(BITSHIFT,70)@1
    i_arrayidx9_hidden_hidden35_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx9_hidden_hidden35_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx9_hidden_hidden35_mult_x_align_14_q <= i_arrayidx9_hidden_hidden35_mult_x_align_14_qint(38 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_x_join_16(BITJOIN,72)@1
    i_arrayidx9_hidden_hidden35_mult_x_join_16_q <= i_arrayidx9_hidden_hidden35_mult_x_align_15_q & i_arrayidx9_hidden_hidden35_mult_x_align_14_q;

    -- i_arrayidx9_hidden_hidden35_mult_x_im9_shift0(BITSHIFT,78)@1
    i_arrayidx9_hidden_hidden35_mult_x_im9_shift0_qint <= i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_e & "00";
    i_arrayidx9_hidden_hidden35_mult_x_im9_shift0_q <= i_arrayidx9_hidden_hidden35_mult_x_im9_shift0_qint(19 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_x_align_12(BITSHIFT,68)@1
    i_arrayidx9_hidden_hidden35_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx9_hidden_hidden35_mult_x_im9_shift0_q) & "000000000000000";
    i_arrayidx9_hidden_hidden35_mult_x_align_12_q <= i_arrayidx9_hidden_hidden35_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_x_im0_shift0(BITSHIFT,75)@1
    i_arrayidx9_hidden_hidden35_mult_x_im0_shift0_qint <= i_arrayidx9_hidden_hidden35_mult_x_bs1_merged_bit_select_b & "00";
    i_arrayidx9_hidden_hidden35_mult_x_im0_shift0_q <= i_arrayidx9_hidden_hidden35_mult_x_im0_shift0_qint(19 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_x_join_13(BITJOIN,69)@1
    i_arrayidx9_hidden_hidden35_mult_x_join_13_q <= i_arrayidx9_hidden_hidden35_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx9_hidden_hidden35_mult_x_im0_shift0_q);

    -- i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0(ADD,73)@1
    i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx9_hidden_hidden35_mult_x_join_13_q);
    i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx9_hidden_hidden35_mult_x_join_16_q);
    i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_b));
    i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_q <= i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_o(67 downto 0);

    -- i_arrayidx9_hidden_hidden35_mult_extender_x(BITJOIN,17)@1
    i_arrayidx9_hidden_hidden35_mult_extender_x_q <= i_arrayidx9_hidden_hidden35_mult_multconst_x_q & i_arrayidx9_hidden_hidden35_mult_x_result_add_0_0_q(66 downto 0);

    -- i_arrayidx9_hidden_hidden35_trunc_sel_x(BITSELECT,19)@1
    i_arrayidx9_hidden_hidden35_trunc_sel_x_b <= i_arrayidx9_hidden_hidden35_mult_extender_x_q(63 downto 0);

    -- redist1_stall_entry_o5_2_0(REG,88)
    redist1_stall_entry_o5_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_stall_entry_o5_2_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_0_backEN = "1") THEN
                redist1_stall_entry_o5_2_0_q <= STD_LOGIC_VECTOR(bubble_select_stall_entry_c);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_stall_entry_o4_4_0(REG,84)
    redist0_stall_entry_o4_4_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_stall_entry_o4_4_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_0_backEN = "1") THEN
                redist0_stall_entry_o4_4_0_q <= STD_LOGIC_VECTOR(bubble_select_stall_entry_b);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_input_tile_size_sync_buffer1_hidden(BITJOIN,94)
    bubble_join_i_syncbuf_input_tile_size_sync_buffer1_hidden_q <= i_syncbuf_input_tile_size_sync_buffer1_hidden_out_buffer_out;

    -- bubble_select_i_syncbuf_input_tile_size_sync_buffer1_hidden(BITSELECT,95)
    bubble_select_i_syncbuf_input_tile_size_sync_buffer1_hidden_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_input_tile_size_sync_buffer1_hidden_q(31 downto 0));

    -- SE_i_cmp21_rm13_hidden(STALLENABLE,114)
    -- Valid signal propagation
    SE_i_cmp21_rm13_hidden_V0 <= SE_i_cmp21_rm13_hidden_R_v_0;
    -- Stall signal propagation
    SE_i_cmp21_rm13_hidden_s_tv_0 <= SE_out_i_syncbuf_output_tile_sync_buffer_hidden_backStall and SE_i_cmp21_rm13_hidden_R_v_0;
    -- Backward Enable generation
    SE_i_cmp21_rm13_hidden_backEN <= not (SE_i_cmp21_rm13_hidden_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp21_rm13_hidden_v_s_0 <= SE_i_cmp21_rm13_hidden_backEN and SR_SE_i_cmp21_rm13_hidden_V;
    -- Backward Stall generation
    SE_i_cmp21_rm13_hidden_backStall <= not (SE_i_cmp21_rm13_hidden_backEN);
    SE_i_cmp21_rm13_hidden_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp21_rm13_hidden_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp21_rm13_hidden_backEN = "0") THEN
                SE_i_cmp21_rm13_hidden_R_v_0 <= SE_i_cmp21_rm13_hidden_R_v_0 and SE_i_cmp21_rm13_hidden_s_tv_0;
            ELSE
                SE_i_cmp21_rm13_hidden_R_v_0 <= SE_i_cmp21_rm13_hidden_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_i_cmp21_rm13_hidden(STALLREG,175)
    SR_SE_i_cmp21_rm13_hidden_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_cmp21_rm13_hidden_r_valid <= (others => '0');
            SR_SE_i_cmp21_rm13_hidden_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_cmp21_rm13_hidden_r_valid <= SE_i_cmp21_rm13_hidden_backStall and (SR_SE_i_cmp21_rm13_hidden_r_valid or SR_SE_i_cmp21_rm13_hidden_i_valid);

            IF (SR_SE_i_cmp21_rm13_hidden_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_cmp21_rm13_hidden_r_data0 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_input_tile_size_sync_buffer1_hidden_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_cmp21_rm13_hidden_i_valid <= SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_V0;
    -- Stall signal propagation
    SR_SE_i_cmp21_rm13_hidden_backStall <= SR_SE_i_cmp21_rm13_hidden_r_valid or not (SR_SE_i_cmp21_rm13_hidden_i_valid);

    -- Valid
    SR_SE_i_cmp21_rm13_hidden_V <= SR_SE_i_cmp21_rm13_hidden_r_valid WHEN SR_SE_i_cmp21_rm13_hidden_r_valid = "1" ELSE SR_SE_i_cmp21_rm13_hidden_i_valid;

    SR_SE_i_cmp21_rm13_hidden_D0 <= SR_SE_i_cmp21_rm13_hidden_r_data0 WHEN SR_SE_i_cmp21_rm13_hidden_r_valid = "1" ELSE bubble_select_i_syncbuf_input_tile_size_sync_buffer1_hidden_b;

    -- SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden(STALLENABLE,122)
    -- Valid signal propagation
    SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_V0 <= SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_backStall <= SR_SE_i_cmp21_rm13_hidden_backStall or not (SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_wireValid <= i_syncbuf_input_tile_size_sync_buffer1_hidden_out_valid_out;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_syncbuf_input_tile_size_sync_buffer1_hidden(BLACKBOX,41)@1
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_input_tile_size_sync_buffer1_hidden : i_syncbuf_input_tile_size_sync_buffer1_hidden30
    PORT MAP (
        in_buffer_in => in_input_tile_size,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_input_tile_size_sync_buffer1_hidden_backStall,
        in_valid_in => SE_redist0_stall_entry_o4_4_0_V3,
        out_buffer_out => i_syncbuf_input_tile_size_sync_buffer1_hidden_out_buffer_out,
        out_stall_out => i_syncbuf_input_tile_size_sync_buffer1_hidden_out_stall_out,
        out_valid_out => i_syncbuf_input_tile_size_sync_buffer1_hidden_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden(STALLENABLE,124)
    -- Valid signal propagation
    SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_V0 <= SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_backStall <= SR_SE_i_cmp_rm12_hidden_backStall or not (SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_wireValid <= i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_valid_out;

    -- i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden(BLACKBOX,42)@1
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_output_neurons_tile_size_sync_buffer3_hidden : i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden27
    PORT MAP (
        in_buffer_in => in_output_neurons_tile_size,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_backStall,
        in_valid_in => SE_redist0_stall_entry_o4_4_0_V2,
        out_buffer_out => i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_buffer_out,
        out_stall_out => i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_stall_out,
        out_valid_out => i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden(BITJOIN,97)
    bubble_join_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_q <= i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_buffer_out;

    -- bubble_select_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden(BITSELECT,98)
    bubble_select_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_q(31 downto 0));

    -- SE_i_cmp_rm12_hidden(STALLENABLE,116)
    -- Valid signal propagation
    SE_i_cmp_rm12_hidden_V0 <= SE_i_cmp_rm12_hidden_R_v_0;
    -- Stall signal propagation
    SE_i_cmp_rm12_hidden_s_tv_0 <= SE_out_i_syncbuf_output_tile_sync_buffer_hidden_backStall and SE_i_cmp_rm12_hidden_R_v_0;
    -- Backward Enable generation
    SE_i_cmp_rm12_hidden_backEN <= not (SE_i_cmp_rm12_hidden_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp_rm12_hidden_v_s_0 <= SE_i_cmp_rm12_hidden_backEN and SR_SE_i_cmp_rm12_hidden_V;
    -- Backward Stall generation
    SE_i_cmp_rm12_hidden_backStall <= not (SE_i_cmp_rm12_hidden_backEN);
    SE_i_cmp_rm12_hidden_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp_rm12_hidden_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_rm12_hidden_backEN = "0") THEN
                SE_i_cmp_rm12_hidden_R_v_0 <= SE_i_cmp_rm12_hidden_R_v_0 and SE_i_cmp_rm12_hidden_s_tv_0;
            ELSE
                SE_i_cmp_rm12_hidden_R_v_0 <= SE_i_cmp_rm12_hidden_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_i_cmp_rm12_hidden(STALLREG,177)
    SR_SE_i_cmp_rm12_hidden_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_cmp_rm12_hidden_r_valid <= (others => '0');
            SR_SE_i_cmp_rm12_hidden_r_data0 <= (others => '-');
            SR_SE_i_cmp_rm12_hidden_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_cmp_rm12_hidden_r_valid <= SE_i_cmp_rm12_hidden_backStall and (SR_SE_i_cmp_rm12_hidden_r_valid or SR_SE_i_cmp_rm12_hidden_i_valid);

            IF (SR_SE_i_cmp_rm12_hidden_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_cmp_rm12_hidden_r_data0 <= STD_LOGIC_VECTOR(redist2_stall_entry_o6_1_0_q);
                SR_SE_i_cmp_rm12_hidden_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_cmp_rm12_hidden_and0 <= SE_redist0_stall_entry_o4_4_0_V1;
    SR_SE_i_cmp_rm12_hidden_i_valid <= SE_out_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_V0 and SR_SE_i_cmp_rm12_hidden_and0;
    -- Stall signal propagation
    SR_SE_i_cmp_rm12_hidden_backStall <= SR_SE_i_cmp_rm12_hidden_r_valid or not (SR_SE_i_cmp_rm12_hidden_i_valid);

    -- Valid
    SR_SE_i_cmp_rm12_hidden_V <= SR_SE_i_cmp_rm12_hidden_r_valid WHEN SR_SE_i_cmp_rm12_hidden_r_valid = "1" ELSE SR_SE_i_cmp_rm12_hidden_i_valid;

    -- Data0
    SR_SE_i_cmp_rm12_hidden_D0 <= SR_SE_i_cmp_rm12_hidden_r_data0 WHEN SR_SE_i_cmp_rm12_hidden_r_valid = "1" ELSE redist2_stall_entry_o6_1_0_q;
    -- Data1
    SR_SE_i_cmp_rm12_hidden_D1 <= SR_SE_i_cmp_rm12_hidden_r_data1 WHEN SR_SE_i_cmp_rm12_hidden_r_valid = "1" ELSE bubble_select_i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_b;

    -- i_syncbuf_output_tile_sync_buffer_hidden(BLACKBOX,43)@2
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_output_tile_sync_buffer_hidden : i_syncbuf_output_tile_sync_buffer_hidden33
    PORT MAP (
        in_buffer_in => in_output_tile,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_output_tile_sync_buffer_hidden_backStall,
        in_valid_in => SE_out_bubble_out_stall_entry_3_V0,
        out_buffer_out => i_syncbuf_output_tile_sync_buffer_hidden_out_buffer_out,
        out_stall_out => i_syncbuf_output_tile_sync_buffer_hidden_out_stall_out,
        out_valid_out => i_syncbuf_output_tile_sync_buffer_hidden_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_stall_entry_3(STALLENABLE,171)
    -- Valid signal propagation
    SE_out_bubble_out_stall_entry_3_V0 <= SE_out_bubble_out_stall_entry_3_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_stall_entry_3_backStall <= i_syncbuf_output_tile_sync_buffer_hidden_out_stall_out or not (SE_out_bubble_out_stall_entry_3_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_stall_entry_3_wireValid <= bubble_out_stall_entry_3_reg_valid_out;

    -- bubble_out_stall_entry_3_reg(STALLFIFO,174)
    bubble_out_stall_entry_3_reg_valid_in <= SE_stall_entry_V0;
    bubble_out_stall_entry_3_reg_stall_in <= SE_out_bubble_out_stall_entry_3_backStall;
    bubble_out_stall_entry_3_reg_valid_in_bitsignaltemp <= bubble_out_stall_entry_3_reg_valid_in(0);
    bubble_out_stall_entry_3_reg_stall_in_bitsignaltemp <= bubble_out_stall_entry_3_reg_stall_in(0);
    bubble_out_stall_entry_3_reg_valid_out(0) <= bubble_out_stall_entry_3_reg_valid_out_bitsignaltemp;
    bubble_out_stall_entry_3_reg_stall_out(0) <= bubble_out_stall_entry_3_reg_stall_out_bitsignaltemp;
    thebubble_out_stall_entry_3_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 3,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_stall_entry_3_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_stall_entry_3_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_stall_entry_3_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_stall_entry_3_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_stall_entry(STALLENABLE,127)
    SE_stall_entry_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_stall_entry_fromReg0 <= (others => '0');
            SE_stall_entry_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_stall_entry_fromReg0 <= SE_stall_entry_toReg0;
            -- Succesor 1
            SE_stall_entry_fromReg1 <= SE_stall_entry_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_stall_entry_consumed0 <= (not (bubble_out_stall_entry_3_reg_stall_out) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg0;
    SE_stall_entry_consumed1 <= (not (SE_redist0_stall_entry_o4_4_0_backStall) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg1;
    -- Consuming
    SE_stall_entry_StallValid <= SE_stall_entry_backStall and SE_stall_entry_wireValid;
    SE_stall_entry_toReg0 <= SE_stall_entry_StallValid and SE_stall_entry_consumed0;
    SE_stall_entry_toReg1 <= SE_stall_entry_StallValid and SE_stall_entry_consumed1;
    -- Backward Stall generation
    SE_stall_entry_or0 <= SE_stall_entry_consumed0;
    SE_stall_entry_wireStall <= not (SE_stall_entry_consumed1 and SE_stall_entry_or0);
    SE_stall_entry_backStall <= SE_stall_entry_wireStall;
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg0);
    SE_stall_entry_V1 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg1);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- SE_redist0_stall_entry_o4_4_0(STALLENABLE,140)
    -- Valid signal propagation
    SE_redist0_stall_entry_o4_4_0_V0 <= SE_redist0_stall_entry_o4_4_0_R_v_0;
    SE_redist0_stall_entry_o4_4_0_V1 <= SE_redist0_stall_entry_o4_4_0_R_v_1;
    SE_redist0_stall_entry_o4_4_0_V2 <= SE_redist0_stall_entry_o4_4_0_R_v_2;
    SE_redist0_stall_entry_o4_4_0_V3 <= SE_redist0_stall_entry_o4_4_0_R_v_3;
    -- Stall signal propagation
    SE_redist0_stall_entry_o4_4_0_s_tv_0 <= SR_SE_redist0_stall_entry_o4_4_1_backStall and SE_redist0_stall_entry_o4_4_0_R_v_0;
    SE_redist0_stall_entry_o4_4_0_s_tv_1 <= SR_SE_i_cmp_rm12_hidden_backStall and SE_redist0_stall_entry_o4_4_0_R_v_1;
    SE_redist0_stall_entry_o4_4_0_s_tv_2 <= i_syncbuf_output_neurons_tile_size_sync_buffer3_hidden_out_stall_out and SE_redist0_stall_entry_o4_4_0_R_v_2;
    SE_redist0_stall_entry_o4_4_0_s_tv_3 <= i_syncbuf_input_tile_size_sync_buffer1_hidden_out_stall_out and SE_redist0_stall_entry_o4_4_0_R_v_3;
    -- Backward Enable generation
    SE_redist0_stall_entry_o4_4_0_or0 <= SE_redist0_stall_entry_o4_4_0_s_tv_0;
    SE_redist0_stall_entry_o4_4_0_or1 <= SE_redist0_stall_entry_o4_4_0_s_tv_1 or SE_redist0_stall_entry_o4_4_0_or0;
    SE_redist0_stall_entry_o4_4_0_or2 <= SE_redist0_stall_entry_o4_4_0_s_tv_2 or SE_redist0_stall_entry_o4_4_0_or1;
    SE_redist0_stall_entry_o4_4_0_backEN <= not (SE_redist0_stall_entry_o4_4_0_s_tv_3 or SE_redist0_stall_entry_o4_4_0_or2);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_stall_entry_o4_4_0_v_s_0 <= SE_redist0_stall_entry_o4_4_0_backEN and SE_stall_entry_V1;
    -- Backward Stall generation
    SE_redist0_stall_entry_o4_4_0_backStall <= not (SE_redist0_stall_entry_o4_4_0_v_s_0);
    SE_redist0_stall_entry_o4_4_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_stall_entry_o4_4_0_R_v_0 <= (others => '0');
            SE_redist0_stall_entry_o4_4_0_R_v_1 <= (others => '0');
            SE_redist0_stall_entry_o4_4_0_R_v_2 <= (others => '0');
            SE_redist0_stall_entry_o4_4_0_R_v_3 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_0_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_0_R_v_0 <= SE_redist0_stall_entry_o4_4_0_R_v_0 and SE_redist0_stall_entry_o4_4_0_s_tv_0;
            ELSE
                SE_redist0_stall_entry_o4_4_0_R_v_0 <= SE_redist0_stall_entry_o4_4_0_v_s_0;
            END IF;

            IF (SE_redist0_stall_entry_o4_4_0_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_0_R_v_1 <= SE_redist0_stall_entry_o4_4_0_R_v_1 and SE_redist0_stall_entry_o4_4_0_s_tv_1;
            ELSE
                SE_redist0_stall_entry_o4_4_0_R_v_1 <= SE_redist0_stall_entry_o4_4_0_v_s_0;
            END IF;

            IF (SE_redist0_stall_entry_o4_4_0_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_0_R_v_2 <= SE_redist0_stall_entry_o4_4_0_R_v_2 and SE_redist0_stall_entry_o4_4_0_s_tv_2;
            ELSE
                SE_redist0_stall_entry_o4_4_0_R_v_2 <= SE_redist0_stall_entry_o4_4_0_v_s_0;
            END IF;

            IF (SE_redist0_stall_entry_o4_4_0_backEN = "0") THEN
                SE_redist0_stall_entry_o4_4_0_R_v_3 <= SE_redist0_stall_entry_o4_4_0_R_v_3 and SE_redist0_stall_entry_o4_4_0_s_tv_3;
            ELSE
                SE_redist0_stall_entry_o4_4_0_R_v_3 <= SE_redist0_stall_entry_o4_4_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist0_stall_entry_o4_4_1(STALLREG,176)
    SR_SE_redist0_stall_entry_o4_4_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist0_stall_entry_o4_4_1_r_valid <= (others => '0');
            SR_SE_redist0_stall_entry_o4_4_1_r_data0 <= (others => '-');
            SR_SE_redist0_stall_entry_o4_4_1_r_data1 <= (others => '-');
            SR_SE_redist0_stall_entry_o4_4_1_r_data2 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist0_stall_entry_o4_4_1_r_valid <= SE_redist0_stall_entry_o4_4_1_backStall and (SR_SE_redist0_stall_entry_o4_4_1_r_valid or SR_SE_redist0_stall_entry_o4_4_1_i_valid);

            IF (SR_SE_redist0_stall_entry_o4_4_1_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist0_stall_entry_o4_4_1_r_data0 <= STD_LOGIC_VECTOR(redist0_stall_entry_o4_4_0_q);
                SR_SE_redist0_stall_entry_o4_4_1_r_data1 <= STD_LOGIC_VECTOR(redist1_stall_entry_o5_2_0_q);
                SR_SE_redist0_stall_entry_o4_4_1_r_data2 <= STD_LOGIC_VECTOR(i_arrayidx9_hidden_hidden35_trunc_sel_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist0_stall_entry_o4_4_1_i_valid <= SE_redist0_stall_entry_o4_4_0_V0;
    -- Stall signal propagation
    SR_SE_redist0_stall_entry_o4_4_1_backStall <= SR_SE_redist0_stall_entry_o4_4_1_r_valid or not (SR_SE_redist0_stall_entry_o4_4_1_i_valid);

    -- Valid
    SR_SE_redist0_stall_entry_o4_4_1_V <= SR_SE_redist0_stall_entry_o4_4_1_r_valid WHEN SR_SE_redist0_stall_entry_o4_4_1_r_valid = "1" ELSE SR_SE_redist0_stall_entry_o4_4_1_i_valid;

    -- Data0
    SR_SE_redist0_stall_entry_o4_4_1_D0 <= SR_SE_redist0_stall_entry_o4_4_1_r_data0 WHEN SR_SE_redist0_stall_entry_o4_4_1_r_valid = "1" ELSE redist0_stall_entry_o4_4_0_q;
    -- Data1
    SR_SE_redist0_stall_entry_o4_4_1_D1 <= SR_SE_redist0_stall_entry_o4_4_1_r_data1 WHEN SR_SE_redist0_stall_entry_o4_4_1_r_valid = "1" ELSE redist1_stall_entry_o5_2_0_q;
    -- Data2
    SR_SE_redist0_stall_entry_o4_4_1_D2 <= SR_SE_redist0_stall_entry_o4_4_1_r_data2 WHEN SR_SE_redist0_stall_entry_o4_4_1_r_valid = "1" ELSE i_arrayidx9_hidden_hidden35_trunc_sel_x_b;

    -- redist1_stall_entry_o5_2_1(REG,89)
    redist1_stall_entry_o5_2_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_stall_entry_o5_2_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_1_backEN = "1") THEN
                redist1_stall_entry_o5_2_1_q <= STD_LOGIC_VECTOR(SR_SE_redist0_stall_entry_o4_4_1_D1);
            END IF;
        END IF;
    END PROCESS;

    -- c_float_0_000000e_00(FLOATCONSTANT,25)
    c_float_0_000000e_00_q <= "00000000000000000000000000000000";

    -- c_i32_0gr(CONSTANT,28)
    c_i32_0gr_q <= "00000000000000000000000000000000";

    -- i_cmp21_rm13_hidden(COMPARE,33)@1 + 1
    i_cmp21_rm13_hidden_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => c_i32_0gr_q(31)) & c_i32_0gr_q));
    i_cmp21_rm13_hidden_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp21_rm13_hidden_D0(31)) & SR_SE_i_cmp21_rm13_hidden_D0));
    i_cmp21_rm13_hidden_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp21_rm13_hidden_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp21_rm13_hidden_backEN = "1") THEN
                i_cmp21_rm13_hidden_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp21_rm13_hidden_a) - SIGNED(i_cmp21_rm13_hidden_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp21_rm13_hidden_c(0) <= i_cmp21_rm13_hidden_o(33);

    -- i_cmp_rm12_hidden(COMPARE,35)@1 + 1
    i_cmp_rm12_hidden_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_rm12_hidden_D0(31)) & SR_SE_i_cmp_rm12_hidden_D0));
    i_cmp_rm12_hidden_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_rm12_hidden_D1(31)) & SR_SE_i_cmp_rm12_hidden_D1));
    i_cmp_rm12_hidden_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp_rm12_hidden_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_rm12_hidden_backEN = "1") THEN
                i_cmp_rm12_hidden_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp_rm12_hidden_a) - SIGNED(i_cmp_rm12_hidden_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp_rm12_hidden_c(0) <= i_cmp_rm12_hidden_o(33);

    -- i_do_directly_for_end_loopexit_sel9_hidden(LOGICAL,36)@2
    i_do_directly_for_end_loopexit_sel9_hidden_q <= i_cmp_rm12_hidden_c and i_cmp21_rm13_hidden_c;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- i_select4_hidden(MUX,39)@2
    i_select4_hidden_s <= i_do_directly_for_end_loopexit_sel9_hidden_q;
    i_select4_hidden_combproc: PROCESS (i_select4_hidden_s, c_float_0_000000e_00_q, redist1_stall_entry_o5_2_1_q)
    BEGIN
        CASE (i_select4_hidden_s) IS
            WHEN "0" => i_select4_hidden_q <= c_float_0_000000e_00_q;
            WHEN "1" => i_select4_hidden_q <= redist1_stall_entry_o5_2_1_q;
            WHEN OTHERS => i_select4_hidden_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- SE_out_i_syncbuf_output_tile_sync_buffer_hidden(STALLENABLE,126)
    -- Valid signal propagation
    SE_out_i_syncbuf_output_tile_sync_buffer_hidden_V0 <= SE_out_i_syncbuf_output_tile_sync_buffer_hidden_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_output_tile_sync_buffer_hidden_backStall <= i_store_unnamed_hidden2_hidden_out_o_stall or not (SE_out_i_syncbuf_output_tile_sync_buffer_hidden_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and0 <= i_syncbuf_output_tile_sync_buffer_hidden_out_valid_out;
    SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and1 <= SE_i_cmp21_rm13_hidden_V0 and SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and0;
    SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and2 <= SE_redist0_stall_entry_o4_4_1_V1 and SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and1;
    SE_out_i_syncbuf_output_tile_sync_buffer_hidden_wireValid <= SE_i_cmp_rm12_hidden_V0 and SE_out_i_syncbuf_output_tile_sync_buffer_hidden_and2;

    -- SE_out_i_store_unnamed_hidden2_hidden(STALLENABLE,120)
    -- Valid signal propagation
    SE_out_i_store_unnamed_hidden2_hidden_V0 <= SE_out_i_store_unnamed_hidden2_hidden_wireValid;
    -- Backward Stall generation
    SE_out_i_store_unnamed_hidden2_hidden_backStall <= in_stall_in or not (SE_out_i_store_unnamed_hidden2_hidden_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_store_unnamed_hidden2_hidden_and0 <= i_store_unnamed_hidden2_hidden_out_o_valid;
    SE_out_i_store_unnamed_hidden2_hidden_wireValid <= SE_redist0_stall_entry_o4_4_3_V0 and SE_out_i_store_unnamed_hidden2_hidden_and0;

    -- i_cmp_neg_rm14_hidden(LOGICAL,34)@2
    i_cmp_neg_rm14_hidden_q <= i_cmp_rm12_hidden_c xor VCC_q;

    -- redist3_i_arrayidx9_hidden_hidden35_trunc_sel_x_b_1_0(REG,91)
    redist3_i_arrayidx9_hidden_hidden35_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_i_arrayidx9_hidden_hidden35_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_1_backEN = "1") THEN
                redist3_i_arrayidx9_hidden_hidden35_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist0_stall_entry_o4_4_1_D2);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_output_tile_sync_buffer_hidden(BITJOIN,100)
    bubble_join_i_syncbuf_output_tile_sync_buffer_hidden_q <= i_syncbuf_output_tile_sync_buffer_hidden_out_buffer_out;

    -- bubble_select_i_syncbuf_output_tile_sync_buffer_hidden(BITSELECT,101)
    bubble_select_i_syncbuf_output_tile_sync_buffer_hidden_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_output_tile_sync_buffer_hidden_q(63 downto 0));

    -- i_arrayidx9_hidden_hidden35_add_x(ADD,20)@2
    i_arrayidx9_hidden_hidden35_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_output_tile_sync_buffer_hidden_b);
    i_arrayidx9_hidden_hidden35_add_x_b <= STD_LOGIC_VECTOR("0" & redist3_i_arrayidx9_hidden_hidden35_trunc_sel_x_b_1_0_q);
    i_arrayidx9_hidden_hidden35_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx9_hidden_hidden35_add_x_a) + UNSIGNED(i_arrayidx9_hidden_hidden35_add_x_b));
    i_arrayidx9_hidden_hidden35_add_x_q <= i_arrayidx9_hidden_hidden35_add_x_o(64 downto 0);

    -- i_arrayidx9_hidden_hidden35_dupName_0_trunc_sel_x(BITSELECT,14)@2
    i_arrayidx9_hidden_hidden35_dupName_0_trunc_sel_x_b <= i_arrayidx9_hidden_hidden35_add_x_q(63 downto 0);

    -- i_store_unnamed_hidden2_hidden(BLACKBOX,40)@2
    -- in in_i_stall@20000000
    -- out out_lsu_unnamed_hidden2_o_active@20000000
    -- out out_o_stall@20000000
    -- out out_o_valid@4
    -- out out_unnamed_hidden2_avm_address@20000000
    -- out out_unnamed_hidden2_avm_burstcount@20000000
    -- out out_unnamed_hidden2_avm_byteenable@20000000
    -- out out_unnamed_hidden2_avm_enable@20000000
    -- out out_unnamed_hidden2_avm_read@20000000
    -- out out_unnamed_hidden2_avm_write@20000000
    -- out out_unnamed_hidden2_avm_writedata@20000000
    thei_store_unnamed_hidden2_hidden : i_store_unnamed_hidden2_hidden36
    PORT MAP (
        in_flush => in_flush,
        in_i_address => i_arrayidx9_hidden_hidden35_dupName_0_trunc_sel_x_b,
        in_i_predicate => i_cmp_neg_rm14_hidden_q,
        in_i_stall => SE_out_i_store_unnamed_hidden2_hidden_backStall,
        in_i_valid => SE_out_i_syncbuf_output_tile_sync_buffer_hidden_V0,
        in_i_writedata => i_select4_hidden_q,
        in_unnamed_hidden2_avm_readdata => in_unnamed_hidden2_avm_readdata,
        in_unnamed_hidden2_avm_readdatavalid => in_unnamed_hidden2_avm_readdatavalid,
        in_unnamed_hidden2_avm_waitrequest => in_unnamed_hidden2_avm_waitrequest,
        in_unnamed_hidden2_avm_writeack => in_unnamed_hidden2_avm_writeack,
        out_lsu_unnamed_hidden2_o_active => i_store_unnamed_hidden2_hidden_out_lsu_unnamed_hidden2_o_active,
        out_o_stall => i_store_unnamed_hidden2_hidden_out_o_stall,
        out_o_valid => i_store_unnamed_hidden2_hidden_out_o_valid,
        out_unnamed_hidden2_avm_address => i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_address,
        out_unnamed_hidden2_avm_burstcount => i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_burstcount,
        out_unnamed_hidden2_avm_byteenable => i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_byteenable,
        out_unnamed_hidden2_avm_enable => i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_enable,
        out_unnamed_hidden2_avm_read => i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_read,
        out_unnamed_hidden2_avm_write => i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_write,
        out_unnamed_hidden2_avm_writedata => i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,2)
    out_lsu_unnamed_hidden2_o_active <= i_store_unnamed_hidden2_hidden_out_lsu_unnamed_hidden2_o_active;

    -- redist0_stall_entry_o4_4_3(REG,87)
    redist0_stall_entry_o4_4_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_stall_entry_o4_4_3_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_stall_entry_o4_4_3_backEN = "1") THEN
                redist0_stall_entry_o4_4_3_q <= STD_LOGIC_VECTOR(SR_SE_redist0_stall_entry_o4_4_3_D0);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_sync_out_x(GPOUT,7)@4
    out_acl_hw_wg_id4 <= redist0_stall_entry_o4_4_3_q;
    out_valid_out <= SE_out_i_store_unnamed_hidden2_hidden_V0;

    -- ext_sig_sync_out(GPOUT,32)
    out_unnamed_hidden2_avm_address <= i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_address;
    out_unnamed_hidden2_avm_enable <= i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_enable;
    out_unnamed_hidden2_avm_read <= i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_read;
    out_unnamed_hidden2_avm_write <= i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_write;
    out_unnamed_hidden2_avm_writedata <= i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_writedata;
    out_unnamed_hidden2_avm_byteenable <= i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_byteenable;
    out_unnamed_hidden2_avm_burstcount <= i_store_unnamed_hidden2_hidden_out_unnamed_hidden2_avm_burstcount;

    -- sync_out(GPOUT,55)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
