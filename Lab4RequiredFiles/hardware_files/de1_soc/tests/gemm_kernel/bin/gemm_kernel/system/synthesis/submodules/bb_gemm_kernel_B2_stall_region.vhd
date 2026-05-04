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

-- VHDL created from bb_gemm_kernel_B2_stall_region
-- VHDL created on Thu Apr 16 13:08:19 2026


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

entity bb_gemm_kernel_B2_stall_region is
    port (
        out_lsu_unnamed_gemm_kernel2_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        in_K : in std_logic_vector(31 downto 0);  -- ufix32
        in_acl_hw_wg_id7 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c1_exe12 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_global_id_03 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_15 : in std_logic_vector(31 downto 0);  -- ufix32
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id7 : out std_logic_vector(31 downto 0);  -- ufix32
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_M : in std_logic_vector(31 downto 0);  -- ufix32
        in_N : in std_logic_vector(31 downto 0);  -- ufix32
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel2_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_gemm_kernel2_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel2_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_gemm_kernel2_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel2_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel2_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel2_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_gemm_kernel2_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_gemm_kernel2_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_C : in std_logic_vector(63 downto 0);  -- ufix64
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_gemm_kernel_B2_stall_region;

architecture normal of bb_gemm_kernel_B2_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel is
        port (
            in_c0_eni219_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni219_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_eni219_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_C : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_N : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit24_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit24_1 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_store_unnamed_gemm_kernel2_gemm_kernel52 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_writedata : in std_logic_vector(31 downto 0);  -- Floating Point
            in_unnamed_gemm_kernel2_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel2_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_lsu_unnamed_gemm_kernel2_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_k_sync_buffer4_gemm_kernel39 is
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


    component i_syncbuf_m_sync_buffer3_gemm_kernel35 is
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


    component i_syncbuf_n_sync_buffer7_gemm_kernel37 is
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


    component acl_data_fifo is
        generic (
            DEPTH : INTEGER := 0;
            DATA_WIDTH : INTEGER := 32;
            STRICT_DEPTH : INTEGER := 0;
            ALLOW_FULL_WRITE : INTEGER := 0;
            IMPL : STRING := "ram"
        );
        port (
            clock : in std_logic;
            resetn : in std_logic;
            valid_in : in std_logic;
            stall_in : in std_logic;
            data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
            valid_out : out std_logic;
            stall_out : out std_logic;
            data_out : out std_logic_vector(DATA_WIDTH - 1 downto 0);
            full : out std_logic;
            almost_full : out std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_c0_exit24_1 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal c_float_0_000000e_00_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c_i32_0gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_cmp4_rm15_gemm_kernel_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp4_rm15_gemm_kernel_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp4_rm15_gemm_kernel_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp4_rm15_gemm_kernel_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp63_rm16_gemm_kernel_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp63_rm16_gemm_kernel_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp63_rm16_gemm_kernel_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp63_rm16_gemm_kernel_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp_rm14_gemm_kernel_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm14_gemm_kernel_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm14_gemm_kernel_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm14_gemm_kernel_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_do_directly_for_end_loopexit_sel11_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_or_cond_neg_rm17_demorgan_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_or_cond_neg_rm17_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_select6_gemm_kernel_s : STD_LOGIC_VECTOR (0 downto 0);
    signal i_select6_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_lsu_unnamed_gemm_kernel2_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_syncbuf_k_sync_buffer4_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_k_sync_buffer4_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_k_sync_buffer4_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_m_sync_buffer3_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_m_sync_buffer3_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_m_sync_buffer3_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer7_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_n_sync_buffer7_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer7_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_11_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_11_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_11_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_11_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_11_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_stall_entry_o4_11_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_11_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_11_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_11_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_11_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_stall_entry_o5_2_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_stall_entry_o5_2_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_stall_entry_o6_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_stall_entry_o7_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_i_select6_gemm_kernel_q_7_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_i_select6_gemm_kernel_q_7_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_i_select6_gemm_kernel_q_7_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_i_select6_gemm_kernel_q_7_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_i_select6_gemm_kernel_q_7_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_i_select6_gemm_kernel_q_7_5_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_i_cmp63_rm16_gemm_kernel_c_2_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_k_sync_buffer4_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_k_sync_buffer4_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_m_sync_buffer3_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_m_sync_buffer3_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_n_sync_buffer7_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_n_sync_buffer7_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (127 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_c : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_d : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_e : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist0_stall_entry_o4_11_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist0_stall_entry_o4_11_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_c_float_0_000000e_00_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp4_rm15_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp4_rm15_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp4_rm15_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp4_rm15_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp4_rm15_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp4_rm15_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_rm16_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_rm16_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_rm16_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_rm16_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_rm16_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_rm16_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm14_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm14_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm14_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm14_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm14_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm14_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_select6_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_select6_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_select6_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_select6_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_select6_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_select6_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_11_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_11_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_11_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_11_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_R_v_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_R_v_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_R_v_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_s_tv_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_s_tv_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_s_tv_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_or3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_0_V4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_stall_entry_o5_2_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_2_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_2_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_2_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_2_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_3_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_3_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_3_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_3_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_4_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_4_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_4_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_4_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_4_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_5_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_5_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_5_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_5_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist4_i_select6_gemm_kernel_q_7_5_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_r_data2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_0_D2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp4_rm15_gemm_kernel_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm14_gemm_kernel_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_1_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_1_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_1_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_1_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_stall_entry_o5_2_1_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_select6_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_select6_gemm_kernel_r_data2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_select6_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_select6_gemm_kernel_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_select6_gemm_kernel_D2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_0_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_2_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_2_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_2_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_4_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_4_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist4_i_select6_gemm_kernel_q_7_4_D0 : STD_LOGIC_VECTOR (31 downto 0);

begin


    -- SE_redist4_i_select6_gemm_kernel_q_7_2(STALLENABLE,128)
    -- Valid signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_2_V0 <= SE_redist4_i_select6_gemm_kernel_q_7_2_R_v_0;
    -- Stall signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_2_s_tv_0 <= SE_redist4_i_select6_gemm_kernel_q_7_3_backStall and SE_redist4_i_select6_gemm_kernel_q_7_2_R_v_0;
    -- Backward Enable generation
    SE_redist4_i_select6_gemm_kernel_q_7_2_backEN <= not (SE_redist4_i_select6_gemm_kernel_q_7_2_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist4_i_select6_gemm_kernel_q_7_2_v_s_0 <= SE_redist4_i_select6_gemm_kernel_q_7_2_backEN and SR_SE_redist4_i_select6_gemm_kernel_q_7_2_V;
    -- Backward Stall generation
    SE_redist4_i_select6_gemm_kernel_q_7_2_backStall <= not (SE_redist4_i_select6_gemm_kernel_q_7_2_backEN);
    SE_redist4_i_select6_gemm_kernel_q_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist4_i_select6_gemm_kernel_q_7_2_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_2_backEN = "0") THEN
                SE_redist4_i_select6_gemm_kernel_q_7_2_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_2_R_v_0 and SE_redist4_i_select6_gemm_kernel_q_7_2_s_tv_0;
            ELSE
                SE_redist4_i_select6_gemm_kernel_q_7_2_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_2_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist4_i_select6_gemm_kernel_q_7_0(STALLENABLE,126)
    -- Valid signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_0_V0 <= SE_redist4_i_select6_gemm_kernel_q_7_0_R_v_0;
    -- Stall signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_0_s_tv_0 <= SE_redist4_i_select6_gemm_kernel_q_7_1_backStall and SE_redist4_i_select6_gemm_kernel_q_7_0_R_v_0;
    -- Backward Enable generation
    SE_redist4_i_select6_gemm_kernel_q_7_0_backEN <= not (SE_redist4_i_select6_gemm_kernel_q_7_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist4_i_select6_gemm_kernel_q_7_0_v_s_0 <= SE_redist4_i_select6_gemm_kernel_q_7_0_backEN and SR_SE_redist4_i_select6_gemm_kernel_q_7_0_V;
    -- Backward Stall generation
    SE_redist4_i_select6_gemm_kernel_q_7_0_backStall <= not (SE_redist4_i_select6_gemm_kernel_q_7_0_backEN);
    SE_redist4_i_select6_gemm_kernel_q_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist4_i_select6_gemm_kernel_q_7_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_0_backEN = "0") THEN
                SE_redist4_i_select6_gemm_kernel_q_7_0_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_0_R_v_0 and SE_redist4_i_select6_gemm_kernel_q_7_0_s_tv_0;
            ELSE
                SE_redist4_i_select6_gemm_kernel_q_7_0_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- bubble_join_stall_entry(BITJOIN,91)
    bubble_join_stall_entry_q <= in_global_id_15 & in_global_id_03 & in_c1_exe12 & in_acl_hw_wg_id7;

    -- bubble_select_stall_entry(BITSELECT,92)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(31 downto 0));
    bubble_select_stall_entry_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(63 downto 32));
    bubble_select_stall_entry_d <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(95 downto 64));
    bubble_select_stall_entry_e <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(127 downto 96));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x(BLACKBOX,17)@0
    -- in in_i_stall@20000000
    -- out out_c0_exit24_0@9
    -- out out_c0_exit24_1@9
    -- out out_o_stall@20000000
    -- out out_o_valid@9
    thei_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x : i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel
    PORT MAP (
        in_c0_eni219_0 => GND_q,
        in_c0_eni219_1 => bubble_select_stall_entry_d,
        in_c0_eni219_2 => bubble_select_stall_entry_e,
        in_C => in_C,
        in_N => in_N,
        in_i_stall => SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_backStall,
        in_i_valid => SE_stall_entry_V3,
        out_c0_exit24_1 => i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_c0_exit24_1,
        out_o_stall => i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- redist0_stall_entry_o4_11_fifo(STALLFIFO,58)
    redist0_stall_entry_o4_11_fifo_valid_in <= SE_stall_entry_V2;
    redist0_stall_entry_o4_11_fifo_stall_in <= SE_out_redist0_stall_entry_o4_11_fifo_backStall;
    redist0_stall_entry_o4_11_fifo_data_in <= bubble_select_stall_entry_b;
    redist0_stall_entry_o4_11_fifo_valid_in_bitsignaltemp <= redist0_stall_entry_o4_11_fifo_valid_in(0);
    redist0_stall_entry_o4_11_fifo_stall_in_bitsignaltemp <= redist0_stall_entry_o4_11_fifo_stall_in(0);
    redist0_stall_entry_o4_11_fifo_valid_out(0) <= redist0_stall_entry_o4_11_fifo_valid_out_bitsignaltemp;
    redist0_stall_entry_o4_11_fifo_stall_out(0) <= redist0_stall_entry_o4_11_fifo_stall_out_bitsignaltemp;
    theredist0_stall_entry_o4_11_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 12,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist0_stall_entry_o4_11_fifo_valid_in_bitsignaltemp,
        stall_in => redist0_stall_entry_o4_11_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_stall_entry_b,
        valid_out => redist0_stall_entry_o4_11_fifo_valid_out_bitsignaltemp,
        stall_out => redist0_stall_entry_o4_11_fifo_stall_out_bitsignaltemp,
        data_out => redist0_stall_entry_o4_11_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_k_sync_buffer4_gemm_kernel(BITJOIN,82)
    bubble_join_i_syncbuf_k_sync_buffer4_gemm_kernel_q <= i_syncbuf_k_sync_buffer4_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_k_sync_buffer4_gemm_kernel(BITSELECT,83)
    bubble_select_i_syncbuf_k_sync_buffer4_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_k_sync_buffer4_gemm_kernel_q(31 downto 0));

    -- c_i32_0gr(CONSTANT,21)
    c_i32_0gr_q <= "00000000000000000000000000000000";

    -- i_cmp63_rm16_gemm_kernel(COMPARE,27)@0 + 1
    i_cmp63_rm16_gemm_kernel_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => c_i32_0gr_q(31)) & c_i32_0gr_q));
    i_cmp63_rm16_gemm_kernel_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => bubble_select_i_syncbuf_k_sync_buffer4_gemm_kernel_b(31)) & bubble_select_i_syncbuf_k_sync_buffer4_gemm_kernel_b));
    i_cmp63_rm16_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp63_rm16_gemm_kernel_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp63_rm16_gemm_kernel_backEN = "1") THEN
                i_cmp63_rm16_gemm_kernel_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp63_rm16_gemm_kernel_a) - SIGNED(i_cmp63_rm16_gemm_kernel_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp63_rm16_gemm_kernel_c(0) <= i_cmp63_rm16_gemm_kernel_o(33);

    -- SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0(STALLENABLE,139)
    -- Valid signal propagation
    SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_V0 <= SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_R_v_0;
    -- Stall signal propagation
    SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_s_tv_0 <= SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_backStall and SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_R_v_0;
    -- Backward Enable generation
    SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backEN <= not (SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_v_s_0 <= SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backEN and SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_V;
    -- Backward Stall generation
    SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backStall <= not (SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backEN);
    SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backEN = "0") THEN
                SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_R_v_0 <= SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_R_v_0 and SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_s_tv_0;
            ELSE
                SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_R_v_0 <= SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0(STALLREG,183)
    SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid <= (others => '0');
            SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid <= SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backStall and (SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid or SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_i_valid);

            IF (SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_data0 <= STD_LOGIC_VECTOR(i_cmp63_rm16_gemm_kernel_c);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_i_valid <= SE_i_cmp63_rm16_gemm_kernel_V0;
    -- Stall signal propagation
    SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backStall <= SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid or not (SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_i_valid);

    -- Valid
    SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_V <= SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid WHEN SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid = "1" ELSE SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_i_valid;

    SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_D0 <= SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_data0 WHEN SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_r_valid = "1" ELSE i_cmp63_rm16_gemm_kernel_c;

    -- SE_i_cmp63_rm16_gemm_kernel(STALLENABLE,104)
    -- Valid signal propagation
    SE_i_cmp63_rm16_gemm_kernel_V0 <= SE_i_cmp63_rm16_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_cmp63_rm16_gemm_kernel_s_tv_0 <= SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backStall and SE_i_cmp63_rm16_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_cmp63_rm16_gemm_kernel_backEN <= not (SE_i_cmp63_rm16_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp63_rm16_gemm_kernel_v_s_0 <= SE_i_cmp63_rm16_gemm_kernel_backEN and SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_V0;
    -- Backward Stall generation
    SE_i_cmp63_rm16_gemm_kernel_backStall <= not (SE_i_cmp63_rm16_gemm_kernel_v_s_0);
    SE_i_cmp63_rm16_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp63_rm16_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp63_rm16_gemm_kernel_backEN = "0") THEN
                SE_i_cmp63_rm16_gemm_kernel_R_v_0 <= SE_i_cmp63_rm16_gemm_kernel_R_v_0 and SE_i_cmp63_rm16_gemm_kernel_s_tv_0;
            ELSE
                SE_i_cmp63_rm16_gemm_kernel_R_v_0 <= SE_i_cmp63_rm16_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel(STALLENABLE,113)
    -- Valid signal propagation
    SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_V0 <= SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_backStall <= SE_i_cmp63_rm16_gemm_kernel_backStall or not (SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_wireValid <= i_syncbuf_k_sync_buffer4_gemm_kernel_out_valid_out;

    -- i_syncbuf_k_sync_buffer4_gemm_kernel(BLACKBOX,35)@0
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_k_sync_buffer4_gemm_kernel : i_syncbuf_k_sync_buffer4_gemm_kernel39
    PORT MAP (
        in_buffer_in => in_K,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_k_sync_buffer4_gemm_kernel_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_buffer_out => i_syncbuf_k_sync_buffer4_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_k_sync_buffer4_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_k_sync_buffer4_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_stall_entry(STALLENABLE,118)
    SE_stall_entry_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_stall_entry_fromReg0 <= (others => '0');
            SE_stall_entry_fromReg1 <= (others => '0');
            SE_stall_entry_fromReg2 <= (others => '0');
            SE_stall_entry_fromReg3 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_stall_entry_fromReg0 <= SE_stall_entry_toReg0;
            -- Succesor 1
            SE_stall_entry_fromReg1 <= SE_stall_entry_toReg1;
            -- Succesor 2
            SE_stall_entry_fromReg2 <= SE_stall_entry_toReg2;
            -- Succesor 3
            SE_stall_entry_fromReg3 <= SE_stall_entry_toReg3;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_stall_entry_consumed0 <= (not (i_syncbuf_k_sync_buffer4_gemm_kernel_out_stall_out) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg0;
    SE_stall_entry_consumed1 <= (not (SR_SE_redist1_stall_entry_o5_2_0_backStall) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg1;
    SE_stall_entry_consumed2 <= (not (redist0_stall_entry_o4_11_fifo_stall_out) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg2;
    SE_stall_entry_consumed3 <= (not (i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_o_stall) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg3;
    -- Consuming
    SE_stall_entry_StallValid <= SE_stall_entry_backStall and SE_stall_entry_wireValid;
    SE_stall_entry_toReg0 <= SE_stall_entry_StallValid and SE_stall_entry_consumed0;
    SE_stall_entry_toReg1 <= SE_stall_entry_StallValid and SE_stall_entry_consumed1;
    SE_stall_entry_toReg2 <= SE_stall_entry_StallValid and SE_stall_entry_consumed2;
    SE_stall_entry_toReg3 <= SE_stall_entry_StallValid and SE_stall_entry_consumed3;
    -- Backward Stall generation
    SE_stall_entry_or0 <= SE_stall_entry_consumed0;
    SE_stall_entry_or1 <= SE_stall_entry_consumed1 and SE_stall_entry_or0;
    SE_stall_entry_or2 <= SE_stall_entry_consumed2 and SE_stall_entry_or1;
    SE_stall_entry_wireStall <= not (SE_stall_entry_consumed3 and SE_stall_entry_or2);
    SE_stall_entry_backStall <= SE_stall_entry_wireStall;
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg0);
    SE_stall_entry_V1 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg1);
    SE_stall_entry_V2 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg2);
    SE_stall_entry_V3 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg3);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- SR_SE_redist1_stall_entry_o5_2_0(STALLREG,176)
    SR_SE_redist1_stall_entry_o5_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist1_stall_entry_o5_2_0_r_valid <= (others => '0');
            SR_SE_redist1_stall_entry_o5_2_0_r_data0 <= (others => '-');
            SR_SE_redist1_stall_entry_o5_2_0_r_data1 <= (others => '-');
            SR_SE_redist1_stall_entry_o5_2_0_r_data2 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist1_stall_entry_o5_2_0_r_valid <= SE_redist1_stall_entry_o5_2_0_backStall and (SR_SE_redist1_stall_entry_o5_2_0_r_valid or SR_SE_redist1_stall_entry_o5_2_0_i_valid);

            IF (SR_SE_redist1_stall_entry_o5_2_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist1_stall_entry_o5_2_0_r_data0 <= STD_LOGIC_VECTOR(bubble_select_stall_entry_c);
                SR_SE_redist1_stall_entry_o5_2_0_r_data1 <= STD_LOGIC_VECTOR(bubble_select_stall_entry_d);
                SR_SE_redist1_stall_entry_o5_2_0_r_data2 <= STD_LOGIC_VECTOR(bubble_select_stall_entry_e);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist1_stall_entry_o5_2_0_i_valid <= SE_stall_entry_V1;
    -- Stall signal propagation
    SR_SE_redist1_stall_entry_o5_2_0_backStall <= SR_SE_redist1_stall_entry_o5_2_0_r_valid or not (SR_SE_redist1_stall_entry_o5_2_0_i_valid);

    -- Valid
    SR_SE_redist1_stall_entry_o5_2_0_V <= SR_SE_redist1_stall_entry_o5_2_0_r_valid WHEN SR_SE_redist1_stall_entry_o5_2_0_r_valid = "1" ELSE SR_SE_redist1_stall_entry_o5_2_0_i_valid;

    -- Data0
    SR_SE_redist1_stall_entry_o5_2_0_D0 <= SR_SE_redist1_stall_entry_o5_2_0_r_data0 WHEN SR_SE_redist1_stall_entry_o5_2_0_r_valid = "1" ELSE bubble_select_stall_entry_c;
    -- Data1
    SR_SE_redist1_stall_entry_o5_2_0_D1 <= SR_SE_redist1_stall_entry_o5_2_0_r_data1 WHEN SR_SE_redist1_stall_entry_o5_2_0_r_valid = "1" ELSE bubble_select_stall_entry_d;
    -- Data2
    SR_SE_redist1_stall_entry_o5_2_0_D2 <= SR_SE_redist1_stall_entry_o5_2_0_r_data2 WHEN SR_SE_redist1_stall_entry_o5_2_0_r_valid = "1" ELSE bubble_select_stall_entry_e;

    -- redist1_stall_entry_o5_2_0(REG,59)
    redist1_stall_entry_o5_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_stall_entry_o5_2_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_stall_entry_o5_2_0_backEN = "1") THEN
                redist1_stall_entry_o5_2_0_q <= STD_LOGIC_VECTOR(SR_SE_redist1_stall_entry_o5_2_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel(STALLENABLE,117)
    -- Valid signal propagation
    SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_V0 <= SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_backStall <= SR_SE_i_cmp4_rm15_gemm_kernel_backStall or not (SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_wireValid <= i_syncbuf_n_sync_buffer7_gemm_kernel_out_valid_out;

    -- i_syncbuf_n_sync_buffer7_gemm_kernel(BLACKBOX,37)@1
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_n_sync_buffer7_gemm_kernel : i_syncbuf_n_sync_buffer7_gemm_kernel37
    PORT MAP (
        in_buffer_in => in_N,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_backStall,
        in_valid_in => SE_redist1_stall_entry_o5_2_0_V4,
        out_buffer_out => i_syncbuf_n_sync_buffer7_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_n_sync_buffer7_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_n_sync_buffer7_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel(STALLENABLE,115)
    -- Valid signal propagation
    SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_V0 <= SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_backStall <= SR_SE_i_cmp_rm14_gemm_kernel_backStall or not (SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_wireValid <= i_syncbuf_m_sync_buffer3_gemm_kernel_out_valid_out;

    -- i_syncbuf_m_sync_buffer3_gemm_kernel(BLACKBOX,36)@1
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_m_sync_buffer3_gemm_kernel : i_syncbuf_m_sync_buffer3_gemm_kernel35
    PORT MAP (
        in_buffer_in => in_M,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_backStall,
        in_valid_in => SE_redist1_stall_entry_o5_2_0_V3,
        out_buffer_out => i_syncbuf_m_sync_buffer3_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_m_sync_buffer3_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_m_sync_buffer3_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_n_sync_buffer7_gemm_kernel(BITJOIN,88)
    bubble_join_i_syncbuf_n_sync_buffer7_gemm_kernel_q <= i_syncbuf_n_sync_buffer7_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_n_sync_buffer7_gemm_kernel(BITSELECT,89)
    bubble_select_i_syncbuf_n_sync_buffer7_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_n_sync_buffer7_gemm_kernel_q(31 downto 0));

    -- redist3_stall_entry_o7_1_0(REG,62)
    redist3_stall_entry_o7_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_stall_entry_o7_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_stall_entry_o5_2_0_backEN = "1") THEN
                redist3_stall_entry_o7_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist1_stall_entry_o5_2_0_D2);
            END IF;
        END IF;
    END PROCESS;

    -- i_cmp4_rm15_gemm_kernel(COMPARE,26)@1 + 1
    i_cmp4_rm15_gemm_kernel_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp4_rm15_gemm_kernel_D0(31)) & SR_SE_i_cmp4_rm15_gemm_kernel_D0));
    i_cmp4_rm15_gemm_kernel_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp4_rm15_gemm_kernel_D1(31)) & SR_SE_i_cmp4_rm15_gemm_kernel_D1));
    i_cmp4_rm15_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp4_rm15_gemm_kernel_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp4_rm15_gemm_kernel_backEN = "1") THEN
                i_cmp4_rm15_gemm_kernel_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp4_rm15_gemm_kernel_a) - SIGNED(i_cmp4_rm15_gemm_kernel_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp4_rm15_gemm_kernel_c(0) <= i_cmp4_rm15_gemm_kernel_o(33);

    -- i_cmp_rm14_gemm_kernel(COMPARE,28)@1 + 1
    i_cmp_rm14_gemm_kernel_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_rm14_gemm_kernel_D0(31)) & SR_SE_i_cmp_rm14_gemm_kernel_D0));
    i_cmp_rm14_gemm_kernel_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_rm14_gemm_kernel_D1(31)) & SR_SE_i_cmp_rm14_gemm_kernel_D1));
    i_cmp_rm14_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp_rm14_gemm_kernel_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_rm14_gemm_kernel_backEN = "1") THEN
                i_cmp_rm14_gemm_kernel_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp_rm14_gemm_kernel_a) - SIGNED(i_cmp_rm14_gemm_kernel_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp_rm14_gemm_kernel_c(0) <= i_cmp_rm14_gemm_kernel_o(33);

    -- i_or_cond_neg_rm17_demorgan_gemm_kernel(LOGICAL,30)@2
    i_or_cond_neg_rm17_demorgan_gemm_kernel_q <= i_cmp_rm14_gemm_kernel_c and i_cmp4_rm15_gemm_kernel_c;

    -- redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0(REG,69)
    redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backEN = "1") THEN
                redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_q <= STD_LOGIC_VECTOR(SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1(REG,70)
    redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backEN = "1") THEN
                redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_q <= STD_LOGIC_VECTOR(redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2(REG,71)
    redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backEN = "1") THEN
                redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_q <= STD_LOGIC_VECTOR(SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3(REG,72)
    redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backEN = "1") THEN
                redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_q <= STD_LOGIC_VECTOR(redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4(REG,73)
    redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backEN = "1") THEN
                redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_q <= STD_LOGIC_VECTOR(SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5(REG,74)
    redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backEN = "1") THEN
                redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_q <= STD_LOGIC_VECTOR(redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_q);
            END IF;
        END IF;
    END PROCESS;

    -- SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6(STALLENABLE,138)
    -- Valid signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_V0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_R_v_0;
    -- Stall signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_s_tv_0 <= SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_backStall and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_R_v_0;
    -- Backward Enable generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backEN <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_v_s_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backEN and SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_V;
    -- Backward Stall generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backStall <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backEN);
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backEN = "0") THEN
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_R_v_0 and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_s_tv_0;
            ELSE
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6(STALLREG,182)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid <= (others => '0');
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backStall and (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid or SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_i_valid);

            IF (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_data0 <= STD_LOGIC_VECTOR(redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_i_valid <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_V0;
    -- Stall signal propagation
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backStall <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid or not (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_i_valid);

    -- Valid
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_V <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid = "1" ELSE SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_i_valid;

    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_D0 <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_data0 WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_r_valid = "1" ELSE redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_q;

    -- SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5(STALLENABLE,137)
    -- Valid signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_V0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_R_v_0;
    -- Stall signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_s_tv_0 <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backStall and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_R_v_0;
    -- Backward Enable generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backEN <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_v_s_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backEN and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_V0;
    -- Backward Stall generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backStall <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_v_s_0);
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backEN = "0") THEN
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_R_v_0 and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_s_tv_0;
            ELSE
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4(STALLENABLE,136)
    -- Valid signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_V0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_R_v_0;
    -- Stall signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_s_tv_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_5_backStall and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_R_v_0;
    -- Backward Enable generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backEN <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_v_s_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backEN and SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_V;
    -- Backward Stall generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backStall <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backEN);
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backEN = "0") THEN
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_R_v_0 and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_s_tv_0;
            ELSE
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4(STALLREG,181)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid <= (others => '0');
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backStall and (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid or SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_i_valid);

            IF (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_data0 <= STD_LOGIC_VECTOR(redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_i_valid <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_V0;
    -- Stall signal propagation
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backStall <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid or not (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_i_valid);

    -- Valid
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_V <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid = "1" ELSE SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_i_valid;

    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_D0 <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_data0 WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_r_valid = "1" ELSE redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_q;

    -- SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3(STALLENABLE,135)
    -- Valid signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_V0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_R_v_0;
    -- Stall signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_s_tv_0 <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_4_backStall and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_R_v_0;
    -- Backward Enable generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backEN <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_v_s_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backEN and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_V0;
    -- Backward Stall generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backStall <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_v_s_0);
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backEN = "0") THEN
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_R_v_0 and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_s_tv_0;
            ELSE
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2(STALLENABLE,134)
    -- Valid signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_V0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_R_v_0;
    -- Stall signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_s_tv_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_3_backStall and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_R_v_0;
    -- Backward Enable generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backEN <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_v_s_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backEN and SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_V;
    -- Backward Stall generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backStall <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backEN);
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backEN = "0") THEN
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_R_v_0 and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_s_tv_0;
            ELSE
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2(STALLREG,180)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid <= (others => '0');
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backStall and (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid or SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_i_valid);

            IF (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_data0 <= STD_LOGIC_VECTOR(redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_i_valid <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_V0;
    -- Stall signal propagation
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backStall <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid or not (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_i_valid);

    -- Valid
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_V <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid = "1" ELSE SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_i_valid;

    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_D0 <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_data0 WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_r_valid = "1" ELSE redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_q;

    -- SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1(STALLENABLE,133)
    -- Valid signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_V0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_R_v_0;
    -- Stall signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_s_tv_0 <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_2_backStall and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_R_v_0;
    -- Backward Enable generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backEN <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_v_s_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backEN and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_V0;
    -- Backward Stall generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backStall <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_v_s_0);
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backEN = "0") THEN
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_R_v_0 and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_s_tv_0;
            ELSE
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0(STALLENABLE,132)
    -- Valid signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_V0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_R_v_0;
    -- Stall signal propagation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_s_tv_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_1_backStall and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_R_v_0;
    -- Backward Enable generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backEN <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_v_s_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backEN and SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_V;
    -- Backward Stall generation
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backStall <= not (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backEN);
    SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backEN = "0") THEN
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_R_v_0 and SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_s_tv_0;
            ELSE
                SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_R_v_0 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0(STALLREG,179)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid <= (others => '0');
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backStall and (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid or SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_i_valid);

            IF (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_data0 <= STD_LOGIC_VECTOR(i_or_cond_neg_rm17_demorgan_gemm_kernel_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_i_valid <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_V1;
    -- Stall signal propagation
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backStall <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid or not (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_i_valid);

    -- Valid
    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_V <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid = "1" ELSE SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_i_valid;

    SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_D0 <= SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_data0 WHEN SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_r_valid = "1" ELSE i_or_cond_neg_rm17_demorgan_gemm_kernel_q;

    -- SE_i_cmp_rm14_gemm_kernel(STALLENABLE,105)
    -- Valid signal propagation
    SE_i_cmp_rm14_gemm_kernel_V0 <= SE_i_cmp_rm14_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_cmp_rm14_gemm_kernel_s_tv_0 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_backStall and SE_i_cmp_rm14_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_cmp_rm14_gemm_kernel_backEN <= not (SE_i_cmp_rm14_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp_rm14_gemm_kernel_v_s_0 <= SE_i_cmp_rm14_gemm_kernel_backEN and SR_SE_i_cmp_rm14_gemm_kernel_V;
    -- Backward Stall generation
    SE_i_cmp_rm14_gemm_kernel_backStall <= not (SE_i_cmp_rm14_gemm_kernel_backEN);
    SE_i_cmp_rm14_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp_rm14_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_rm14_gemm_kernel_backEN = "0") THEN
                SE_i_cmp_rm14_gemm_kernel_R_v_0 <= SE_i_cmp_rm14_gemm_kernel_R_v_0 and SE_i_cmp_rm14_gemm_kernel_s_tv_0;
            ELSE
                SE_i_cmp_rm14_gemm_kernel_R_v_0 <= SE_i_cmp_rm14_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_i_or_cond_neg_rm17_demorgan_gemm_kernel(STALLENABLE,107)
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg0 <= (others => '0');
            SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg0 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_toReg0;
            -- Succesor 1
            SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg1 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed0 <= (not (SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_backStall) and SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireValid) or SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg0;
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed1 <= (not (SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_0_backStall) and SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireValid) or SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg1;
    -- Consuming
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_StallValid <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_backStall and SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireValid;
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_toReg0 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_StallValid and SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed0;
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_toReg1 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_StallValid and SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed1;
    -- Backward Stall generation
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_or0 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed0;
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireStall <= not (SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_consumed1 and SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_or0);
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_backStall <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireStall;
    -- Valid signal propagation
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_V0 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireValid and not (SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg0);
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_V1 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireValid and not (SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_fromReg1);
    -- Computing multiple Valid(s)
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_and0 <= SE_i_cmp4_rm15_gemm_kernel_V0;
    SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_wireValid <= SE_i_cmp_rm14_gemm_kernel_V0 and SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_and0;

    -- SE_i_cmp4_rm15_gemm_kernel(STALLENABLE,103)
    -- Valid signal propagation
    SE_i_cmp4_rm15_gemm_kernel_V0 <= SE_i_cmp4_rm15_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_cmp4_rm15_gemm_kernel_s_tv_0 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_backStall and SE_i_cmp4_rm15_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_cmp4_rm15_gemm_kernel_backEN <= not (SE_i_cmp4_rm15_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp4_rm15_gemm_kernel_v_s_0 <= SE_i_cmp4_rm15_gemm_kernel_backEN and SR_SE_i_cmp4_rm15_gemm_kernel_V;
    -- Backward Stall generation
    SE_i_cmp4_rm15_gemm_kernel_backStall <= not (SE_i_cmp4_rm15_gemm_kernel_backEN);
    SE_i_cmp4_rm15_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp4_rm15_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp4_rm15_gemm_kernel_backEN = "0") THEN
                SE_i_cmp4_rm15_gemm_kernel_R_v_0 <= SE_i_cmp4_rm15_gemm_kernel_R_v_0 and SE_i_cmp4_rm15_gemm_kernel_s_tv_0;
            ELSE
                SE_i_cmp4_rm15_gemm_kernel_R_v_0 <= SE_i_cmp4_rm15_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_i_cmp4_rm15_gemm_kernel(STALLREG,177)
    SR_SE_i_cmp4_rm15_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_cmp4_rm15_gemm_kernel_r_valid <= (others => '0');
            SR_SE_i_cmp4_rm15_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_i_cmp4_rm15_gemm_kernel_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_cmp4_rm15_gemm_kernel_r_valid <= SE_i_cmp4_rm15_gemm_kernel_backStall and (SR_SE_i_cmp4_rm15_gemm_kernel_r_valid or SR_SE_i_cmp4_rm15_gemm_kernel_i_valid);

            IF (SR_SE_i_cmp4_rm15_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_cmp4_rm15_gemm_kernel_r_data0 <= STD_LOGIC_VECTOR(redist3_stall_entry_o7_1_0_q);
                SR_SE_i_cmp4_rm15_gemm_kernel_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_n_sync_buffer7_gemm_kernel_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_cmp4_rm15_gemm_kernel_and0 <= SE_redist1_stall_entry_o5_2_0_V2;
    SR_SE_i_cmp4_rm15_gemm_kernel_i_valid <= SE_out_i_syncbuf_n_sync_buffer7_gemm_kernel_V0 and SR_SE_i_cmp4_rm15_gemm_kernel_and0;
    -- Stall signal propagation
    SR_SE_i_cmp4_rm15_gemm_kernel_backStall <= SR_SE_i_cmp4_rm15_gemm_kernel_r_valid or not (SR_SE_i_cmp4_rm15_gemm_kernel_i_valid);

    -- Valid
    SR_SE_i_cmp4_rm15_gemm_kernel_V <= SR_SE_i_cmp4_rm15_gemm_kernel_r_valid WHEN SR_SE_i_cmp4_rm15_gemm_kernel_r_valid = "1" ELSE SR_SE_i_cmp4_rm15_gemm_kernel_i_valid;

    -- Data0
    SR_SE_i_cmp4_rm15_gemm_kernel_D0 <= SR_SE_i_cmp4_rm15_gemm_kernel_r_data0 WHEN SR_SE_i_cmp4_rm15_gemm_kernel_r_valid = "1" ELSE redist3_stall_entry_o7_1_0_q;
    -- Data1
    SR_SE_i_cmp4_rm15_gemm_kernel_D1 <= SR_SE_i_cmp4_rm15_gemm_kernel_r_data1 WHEN SR_SE_i_cmp4_rm15_gemm_kernel_r_valid = "1" ELSE bubble_select_i_syncbuf_n_sync_buffer7_gemm_kernel_b;

    -- bubble_join_i_syncbuf_m_sync_buffer3_gemm_kernel(BITJOIN,85)
    bubble_join_i_syncbuf_m_sync_buffer3_gemm_kernel_q <= i_syncbuf_m_sync_buffer3_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_m_sync_buffer3_gemm_kernel(BITSELECT,86)
    bubble_select_i_syncbuf_m_sync_buffer3_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_m_sync_buffer3_gemm_kernel_q(31 downto 0));

    -- redist2_stall_entry_o6_1_0(REG,61)
    redist2_stall_entry_o6_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_stall_entry_o6_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_stall_entry_o5_2_0_backEN = "1") THEN
                redist2_stall_entry_o6_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist1_stall_entry_o5_2_0_D1);
            END IF;
        END IF;
    END PROCESS;

    -- SR_SE_i_cmp_rm14_gemm_kernel(STALLREG,178)
    SR_SE_i_cmp_rm14_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_cmp_rm14_gemm_kernel_r_valid <= (others => '0');
            SR_SE_i_cmp_rm14_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_i_cmp_rm14_gemm_kernel_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_cmp_rm14_gemm_kernel_r_valid <= SE_i_cmp_rm14_gemm_kernel_backStall and (SR_SE_i_cmp_rm14_gemm_kernel_r_valid or SR_SE_i_cmp_rm14_gemm_kernel_i_valid);

            IF (SR_SE_i_cmp_rm14_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_cmp_rm14_gemm_kernel_r_data0 <= STD_LOGIC_VECTOR(redist2_stall_entry_o6_1_0_q);
                SR_SE_i_cmp_rm14_gemm_kernel_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_m_sync_buffer3_gemm_kernel_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_cmp_rm14_gemm_kernel_and0 <= SE_redist1_stall_entry_o5_2_0_V1;
    SR_SE_i_cmp_rm14_gemm_kernel_i_valid <= SE_out_i_syncbuf_m_sync_buffer3_gemm_kernel_V0 and SR_SE_i_cmp_rm14_gemm_kernel_and0;
    -- Stall signal propagation
    SR_SE_i_cmp_rm14_gemm_kernel_backStall <= SR_SE_i_cmp_rm14_gemm_kernel_r_valid or not (SR_SE_i_cmp_rm14_gemm_kernel_i_valid);

    -- Valid
    SR_SE_i_cmp_rm14_gemm_kernel_V <= SR_SE_i_cmp_rm14_gemm_kernel_r_valid WHEN SR_SE_i_cmp_rm14_gemm_kernel_r_valid = "1" ELSE SR_SE_i_cmp_rm14_gemm_kernel_i_valid;

    -- Data0
    SR_SE_i_cmp_rm14_gemm_kernel_D0 <= SR_SE_i_cmp_rm14_gemm_kernel_r_data0 WHEN SR_SE_i_cmp_rm14_gemm_kernel_r_valid = "1" ELSE redist2_stall_entry_o6_1_0_q;
    -- Data1
    SR_SE_i_cmp_rm14_gemm_kernel_D1 <= SR_SE_i_cmp_rm14_gemm_kernel_r_data1 WHEN SR_SE_i_cmp_rm14_gemm_kernel_r_valid = "1" ELSE bubble_select_i_syncbuf_m_sync_buffer3_gemm_kernel_b;

    -- SE_redist1_stall_entry_o5_2_0(STALLENABLE,122)
    -- Valid signal propagation
    SE_redist1_stall_entry_o5_2_0_V0 <= SE_redist1_stall_entry_o5_2_0_R_v_0;
    SE_redist1_stall_entry_o5_2_0_V1 <= SE_redist1_stall_entry_o5_2_0_R_v_1;
    SE_redist1_stall_entry_o5_2_0_V2 <= SE_redist1_stall_entry_o5_2_0_R_v_2;
    SE_redist1_stall_entry_o5_2_0_V3 <= SE_redist1_stall_entry_o5_2_0_R_v_3;
    SE_redist1_stall_entry_o5_2_0_V4 <= SE_redist1_stall_entry_o5_2_0_R_v_4;
    -- Stall signal propagation
    SE_redist1_stall_entry_o5_2_0_s_tv_0 <= SR_SE_redist1_stall_entry_o5_2_1_backStall and SE_redist1_stall_entry_o5_2_0_R_v_0;
    SE_redist1_stall_entry_o5_2_0_s_tv_1 <= SR_SE_i_cmp_rm14_gemm_kernel_backStall and SE_redist1_stall_entry_o5_2_0_R_v_1;
    SE_redist1_stall_entry_o5_2_0_s_tv_2 <= SR_SE_i_cmp4_rm15_gemm_kernel_backStall and SE_redist1_stall_entry_o5_2_0_R_v_2;
    SE_redist1_stall_entry_o5_2_0_s_tv_3 <= i_syncbuf_m_sync_buffer3_gemm_kernel_out_stall_out and SE_redist1_stall_entry_o5_2_0_R_v_3;
    SE_redist1_stall_entry_o5_2_0_s_tv_4 <= i_syncbuf_n_sync_buffer7_gemm_kernel_out_stall_out and SE_redist1_stall_entry_o5_2_0_R_v_4;
    -- Backward Enable generation
    SE_redist1_stall_entry_o5_2_0_or0 <= SE_redist1_stall_entry_o5_2_0_s_tv_0;
    SE_redist1_stall_entry_o5_2_0_or1 <= SE_redist1_stall_entry_o5_2_0_s_tv_1 or SE_redist1_stall_entry_o5_2_0_or0;
    SE_redist1_stall_entry_o5_2_0_or2 <= SE_redist1_stall_entry_o5_2_0_s_tv_2 or SE_redist1_stall_entry_o5_2_0_or1;
    SE_redist1_stall_entry_o5_2_0_or3 <= SE_redist1_stall_entry_o5_2_0_s_tv_3 or SE_redist1_stall_entry_o5_2_0_or2;
    SE_redist1_stall_entry_o5_2_0_backEN <= not (SE_redist1_stall_entry_o5_2_0_s_tv_4 or SE_redist1_stall_entry_o5_2_0_or3);
    -- Determine whether to write valid data into the first register stage
    SE_redist1_stall_entry_o5_2_0_v_s_0 <= SE_redist1_stall_entry_o5_2_0_backEN and SR_SE_redist1_stall_entry_o5_2_0_V;
    -- Backward Stall generation
    SE_redist1_stall_entry_o5_2_0_backStall <= not (SE_redist1_stall_entry_o5_2_0_backEN);
    SE_redist1_stall_entry_o5_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist1_stall_entry_o5_2_0_R_v_0 <= (others => '0');
            SE_redist1_stall_entry_o5_2_0_R_v_1 <= (others => '0');
            SE_redist1_stall_entry_o5_2_0_R_v_2 <= (others => '0');
            SE_redist1_stall_entry_o5_2_0_R_v_3 <= (others => '0');
            SE_redist1_stall_entry_o5_2_0_R_v_4 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_stall_entry_o5_2_0_backEN = "0") THEN
                SE_redist1_stall_entry_o5_2_0_R_v_0 <= SE_redist1_stall_entry_o5_2_0_R_v_0 and SE_redist1_stall_entry_o5_2_0_s_tv_0;
            ELSE
                SE_redist1_stall_entry_o5_2_0_R_v_0 <= SE_redist1_stall_entry_o5_2_0_v_s_0;
            END IF;

            IF (SE_redist1_stall_entry_o5_2_0_backEN = "0") THEN
                SE_redist1_stall_entry_o5_2_0_R_v_1 <= SE_redist1_stall_entry_o5_2_0_R_v_1 and SE_redist1_stall_entry_o5_2_0_s_tv_1;
            ELSE
                SE_redist1_stall_entry_o5_2_0_R_v_1 <= SE_redist1_stall_entry_o5_2_0_v_s_0;
            END IF;

            IF (SE_redist1_stall_entry_o5_2_0_backEN = "0") THEN
                SE_redist1_stall_entry_o5_2_0_R_v_2 <= SE_redist1_stall_entry_o5_2_0_R_v_2 and SE_redist1_stall_entry_o5_2_0_s_tv_2;
            ELSE
                SE_redist1_stall_entry_o5_2_0_R_v_2 <= SE_redist1_stall_entry_o5_2_0_v_s_0;
            END IF;

            IF (SE_redist1_stall_entry_o5_2_0_backEN = "0") THEN
                SE_redist1_stall_entry_o5_2_0_R_v_3 <= SE_redist1_stall_entry_o5_2_0_R_v_3 and SE_redist1_stall_entry_o5_2_0_s_tv_3;
            ELSE
                SE_redist1_stall_entry_o5_2_0_R_v_3 <= SE_redist1_stall_entry_o5_2_0_v_s_0;
            END IF;

            IF (SE_redist1_stall_entry_o5_2_0_backEN = "0") THEN
                SE_redist1_stall_entry_o5_2_0_R_v_4 <= SE_redist1_stall_entry_o5_2_0_R_v_4 and SE_redist1_stall_entry_o5_2_0_s_tv_4;
            ELSE
                SE_redist1_stall_entry_o5_2_0_R_v_4 <= SE_redist1_stall_entry_o5_2_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist1_stall_entry_o5_2_1(STALLREG,184)
    SR_SE_redist1_stall_entry_o5_2_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist1_stall_entry_o5_2_1_r_valid <= (others => '0');
            SR_SE_redist1_stall_entry_o5_2_1_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist1_stall_entry_o5_2_1_r_valid <= SE_redist1_stall_entry_o5_2_1_backStall and (SR_SE_redist1_stall_entry_o5_2_1_r_valid or SR_SE_redist1_stall_entry_o5_2_1_i_valid);

            IF (SR_SE_redist1_stall_entry_o5_2_1_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist1_stall_entry_o5_2_1_r_data0 <= STD_LOGIC_VECTOR(redist1_stall_entry_o5_2_0_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist1_stall_entry_o5_2_1_i_valid <= SE_redist1_stall_entry_o5_2_0_V0;
    -- Stall signal propagation
    SR_SE_redist1_stall_entry_o5_2_1_backStall <= SR_SE_redist1_stall_entry_o5_2_1_r_valid or not (SR_SE_redist1_stall_entry_o5_2_1_i_valid);

    -- Valid
    SR_SE_redist1_stall_entry_o5_2_1_V <= SR_SE_redist1_stall_entry_o5_2_1_r_valid WHEN SR_SE_redist1_stall_entry_o5_2_1_r_valid = "1" ELSE SR_SE_redist1_stall_entry_o5_2_1_i_valid;

    SR_SE_redist1_stall_entry_o5_2_1_D0 <= SR_SE_redist1_stall_entry_o5_2_1_r_data0 WHEN SR_SE_redist1_stall_entry_o5_2_1_r_valid = "1" ELSE redist1_stall_entry_o5_2_0_q;

    -- redist1_stall_entry_o5_2_1(REG,60)
    redist1_stall_entry_o5_2_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_stall_entry_o5_2_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_stall_entry_o5_2_1_backEN = "1") THEN
                redist1_stall_entry_o5_2_1_q <= STD_LOGIC_VECTOR(SR_SE_redist1_stall_entry_o5_2_1_D0);
            END IF;
        END IF;
    END PROCESS;

    -- c_float_0_000000e_00(FLOATCONSTANT,18)
    c_float_0_000000e_00_q <= "00000000000000000000000000000000";

    -- redist6_i_cmp63_rm16_gemm_kernel_c_2_0(REG,76)
    redist6_i_cmp63_rm16_gemm_kernel_c_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist6_i_cmp63_rm16_gemm_kernel_c_2_0_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_backEN = "1") THEN
                redist6_i_cmp63_rm16_gemm_kernel_c_2_0_q <= STD_LOGIC_VECTOR(SR_SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- i_do_directly_for_end_loopexit_sel11_gemm_kernel(LOGICAL,29)@2
    i_do_directly_for_end_loopexit_sel11_gemm_kernel_q <= i_or_cond_neg_rm17_demorgan_gemm_kernel_q and redist6_i_cmp63_rm16_gemm_kernel_c_2_0_q;

    -- SE_redist1_stall_entry_o5_2_1(STALLENABLE,123)
    -- Valid signal propagation
    SE_redist1_stall_entry_o5_2_1_V0 <= SE_redist1_stall_entry_o5_2_1_R_v_0;
    -- Stall signal propagation
    SE_redist1_stall_entry_o5_2_1_s_tv_0 <= SR_SE_i_select6_gemm_kernel_backStall and SE_redist1_stall_entry_o5_2_1_R_v_0;
    -- Backward Enable generation
    SE_redist1_stall_entry_o5_2_1_backEN <= not (SE_redist1_stall_entry_o5_2_1_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist1_stall_entry_o5_2_1_v_s_0 <= SE_redist1_stall_entry_o5_2_1_backEN and SR_SE_redist1_stall_entry_o5_2_1_V;
    -- Backward Stall generation
    SE_redist1_stall_entry_o5_2_1_backStall <= not (SE_redist1_stall_entry_o5_2_1_backEN);
    SE_redist1_stall_entry_o5_2_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist1_stall_entry_o5_2_1_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_stall_entry_o5_2_1_backEN = "0") THEN
                SE_redist1_stall_entry_o5_2_1_R_v_0 <= SE_redist1_stall_entry_o5_2_1_R_v_0 and SE_redist1_stall_entry_o5_2_1_s_tv_0;
            ELSE
                SE_redist1_stall_entry_o5_2_1_R_v_0 <= SE_redist1_stall_entry_o5_2_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel(STALLENABLE,106)
    -- Valid signal propagation
    SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_V0 <= SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_backStall <= SR_SE_i_select6_gemm_kernel_backStall or not (SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_and0 <= SE_i_or_cond_neg_rm17_demorgan_gemm_kernel_V0;
    SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_wireValid <= SE_redist6_i_cmp63_rm16_gemm_kernel_c_2_0_V0 and SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_and0;

    -- SE_c_float_0_000000e_00(STALLENABLE,102)
    -- Valid signal propagation
    SE_c_float_0_000000e_00_V0 <= "1";

    -- SR_SE_i_select6_gemm_kernel(STALLREG,185)
    SR_SE_i_select6_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_select6_gemm_kernel_r_valid <= (others => '0');
            SR_SE_i_select6_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_i_select6_gemm_kernel_r_data1 <= (others => '-');
            SR_SE_i_select6_gemm_kernel_r_data2 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_select6_gemm_kernel_r_valid <= SE_i_select6_gemm_kernel_backStall and (SR_SE_i_select6_gemm_kernel_r_valid or SR_SE_i_select6_gemm_kernel_i_valid);

            IF (SR_SE_i_select6_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_select6_gemm_kernel_r_data0 <= i_do_directly_for_end_loopexit_sel11_gemm_kernel_q;
                SR_SE_i_select6_gemm_kernel_r_data1 <= STD_LOGIC_VECTOR(c_float_0_000000e_00_q);
                SR_SE_i_select6_gemm_kernel_r_data2 <= STD_LOGIC_VECTOR(redist1_stall_entry_o5_2_1_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_select6_gemm_kernel_and0 <= SE_c_float_0_000000e_00_V0;
    SR_SE_i_select6_gemm_kernel_and1 <= SE_i_do_directly_for_end_loopexit_sel11_gemm_kernel_V0 and SR_SE_i_select6_gemm_kernel_and0;
    SR_SE_i_select6_gemm_kernel_i_valid <= SE_redist1_stall_entry_o5_2_1_V0 and SR_SE_i_select6_gemm_kernel_and1;
    -- Stall signal propagation
    SR_SE_i_select6_gemm_kernel_backStall <= SR_SE_i_select6_gemm_kernel_r_valid or not (SR_SE_i_select6_gemm_kernel_i_valid);

    -- Valid
    SR_SE_i_select6_gemm_kernel_V <= SR_SE_i_select6_gemm_kernel_r_valid WHEN SR_SE_i_select6_gemm_kernel_r_valid = "1" ELSE SR_SE_i_select6_gemm_kernel_i_valid;

    -- Data0
    SR_SE_i_select6_gemm_kernel_D0 <= SR_SE_i_select6_gemm_kernel_r_data0 WHEN SR_SE_i_select6_gemm_kernel_r_valid = "1" ELSE i_do_directly_for_end_loopexit_sel11_gemm_kernel_q;
    -- Data1
    SR_SE_i_select6_gemm_kernel_D1 <= SR_SE_i_select6_gemm_kernel_r_data1 WHEN SR_SE_i_select6_gemm_kernel_r_valid = "1" ELSE c_float_0_000000e_00_q;
    -- Data2
    SR_SE_i_select6_gemm_kernel_D2 <= SR_SE_i_select6_gemm_kernel_r_data2 WHEN SR_SE_i_select6_gemm_kernel_r_valid = "1" ELSE redist1_stall_entry_o5_2_1_q;

    -- i_select6_gemm_kernel(MUX,33)@2 + 1
    i_select6_gemm_kernel_s <= SR_SE_i_select6_gemm_kernel_D0;
    i_select6_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_select6_gemm_kernel_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_select6_gemm_kernel_backEN = "1") THEN
                CASE (i_select6_gemm_kernel_s) IS
                    WHEN "0" => i_select6_gemm_kernel_q <= SR_SE_i_select6_gemm_kernel_D1;
                    WHEN "1" => i_select6_gemm_kernel_q <= SR_SE_i_select6_gemm_kernel_D2;
                    WHEN OTHERS => i_select6_gemm_kernel_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- SE_i_select6_gemm_kernel(STALLENABLE,109)
    -- Valid signal propagation
    SE_i_select6_gemm_kernel_V0 <= SE_i_select6_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_select6_gemm_kernel_s_tv_0 <= SR_SE_redist4_i_select6_gemm_kernel_q_7_0_backStall and SE_i_select6_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_select6_gemm_kernel_backEN <= not (SE_i_select6_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_select6_gemm_kernel_v_s_0 <= SE_i_select6_gemm_kernel_backEN and SR_SE_i_select6_gemm_kernel_V;
    -- Backward Stall generation
    SE_i_select6_gemm_kernel_backStall <= not (SE_i_select6_gemm_kernel_backEN);
    SE_i_select6_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_select6_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_select6_gemm_kernel_backEN = "0") THEN
                SE_i_select6_gemm_kernel_R_v_0 <= SE_i_select6_gemm_kernel_R_v_0 and SE_i_select6_gemm_kernel_s_tv_0;
            ELSE
                SE_i_select6_gemm_kernel_R_v_0 <= SE_i_select6_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist4_i_select6_gemm_kernel_q_7_0(STALLREG,186)
    SR_SE_redist4_i_select6_gemm_kernel_q_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid <= (others => '0');
            SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid <= SE_redist4_i_select6_gemm_kernel_q_7_0_backStall and (SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid or SR_SE_redist4_i_select6_gemm_kernel_q_7_0_i_valid);

            IF (SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_data0 <= STD_LOGIC_VECTOR(i_select6_gemm_kernel_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist4_i_select6_gemm_kernel_q_7_0_i_valid <= SE_i_select6_gemm_kernel_V0;
    -- Stall signal propagation
    SR_SE_redist4_i_select6_gemm_kernel_q_7_0_backStall <= SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid or not (SR_SE_redist4_i_select6_gemm_kernel_q_7_0_i_valid);

    -- Valid
    SR_SE_redist4_i_select6_gemm_kernel_q_7_0_V <= SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid WHEN SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid = "1" ELSE SR_SE_redist4_i_select6_gemm_kernel_q_7_0_i_valid;

    SR_SE_redist4_i_select6_gemm_kernel_q_7_0_D0 <= SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_data0 WHEN SR_SE_redist4_i_select6_gemm_kernel_q_7_0_r_valid = "1" ELSE i_select6_gemm_kernel_q;

    -- redist4_i_select6_gemm_kernel_q_7_0(REG,63)
    redist4_i_select6_gemm_kernel_q_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_i_select6_gemm_kernel_q_7_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_0_backEN = "1") THEN
                redist4_i_select6_gemm_kernel_q_7_0_q <= STD_LOGIC_VECTOR(SR_SE_redist4_i_select6_gemm_kernel_q_7_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_i_select6_gemm_kernel_q_7_1(REG,64)
    redist4_i_select6_gemm_kernel_q_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_i_select6_gemm_kernel_q_7_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_1_backEN = "1") THEN
                redist4_i_select6_gemm_kernel_q_7_1_q <= STD_LOGIC_VECTOR(redist4_i_select6_gemm_kernel_q_7_0_q);
            END IF;
        END IF;
    END PROCESS;

    -- SE_redist4_i_select6_gemm_kernel_q_7_1(STALLENABLE,127)
    -- Valid signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_1_V0 <= SE_redist4_i_select6_gemm_kernel_q_7_1_R_v_0;
    -- Stall signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_1_s_tv_0 <= SR_SE_redist4_i_select6_gemm_kernel_q_7_2_backStall and SE_redist4_i_select6_gemm_kernel_q_7_1_R_v_0;
    -- Backward Enable generation
    SE_redist4_i_select6_gemm_kernel_q_7_1_backEN <= not (SE_redist4_i_select6_gemm_kernel_q_7_1_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist4_i_select6_gemm_kernel_q_7_1_v_s_0 <= SE_redist4_i_select6_gemm_kernel_q_7_1_backEN and SE_redist4_i_select6_gemm_kernel_q_7_0_V0;
    -- Backward Stall generation
    SE_redist4_i_select6_gemm_kernel_q_7_1_backStall <= not (SE_redist4_i_select6_gemm_kernel_q_7_1_v_s_0);
    SE_redist4_i_select6_gemm_kernel_q_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist4_i_select6_gemm_kernel_q_7_1_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_1_backEN = "0") THEN
                SE_redist4_i_select6_gemm_kernel_q_7_1_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_1_R_v_0 and SE_redist4_i_select6_gemm_kernel_q_7_1_s_tv_0;
            ELSE
                SE_redist4_i_select6_gemm_kernel_q_7_1_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist4_i_select6_gemm_kernel_q_7_2(STALLREG,187)
    SR_SE_redist4_i_select6_gemm_kernel_q_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid <= (others => '0');
            SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid <= SE_redist4_i_select6_gemm_kernel_q_7_2_backStall and (SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid or SR_SE_redist4_i_select6_gemm_kernel_q_7_2_i_valid);

            IF (SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_data0 <= STD_LOGIC_VECTOR(redist4_i_select6_gemm_kernel_q_7_1_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist4_i_select6_gemm_kernel_q_7_2_i_valid <= SE_redist4_i_select6_gemm_kernel_q_7_1_V0;
    -- Stall signal propagation
    SR_SE_redist4_i_select6_gemm_kernel_q_7_2_backStall <= SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid or not (SR_SE_redist4_i_select6_gemm_kernel_q_7_2_i_valid);

    -- Valid
    SR_SE_redist4_i_select6_gemm_kernel_q_7_2_V <= SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid WHEN SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid = "1" ELSE SR_SE_redist4_i_select6_gemm_kernel_q_7_2_i_valid;

    SR_SE_redist4_i_select6_gemm_kernel_q_7_2_D0 <= SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_data0 WHEN SR_SE_redist4_i_select6_gemm_kernel_q_7_2_r_valid = "1" ELSE redist4_i_select6_gemm_kernel_q_7_1_q;

    -- redist4_i_select6_gemm_kernel_q_7_2(REG,65)
    redist4_i_select6_gemm_kernel_q_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_i_select6_gemm_kernel_q_7_2_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_2_backEN = "1") THEN
                redist4_i_select6_gemm_kernel_q_7_2_q <= STD_LOGIC_VECTOR(SR_SE_redist4_i_select6_gemm_kernel_q_7_2_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_i_select6_gemm_kernel_q_7_3(REG,66)
    redist4_i_select6_gemm_kernel_q_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_i_select6_gemm_kernel_q_7_3_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_3_backEN = "1") THEN
                redist4_i_select6_gemm_kernel_q_7_3_q <= STD_LOGIC_VECTOR(redist4_i_select6_gemm_kernel_q_7_2_q);
            END IF;
        END IF;
    END PROCESS;

    -- SE_redist4_i_select6_gemm_kernel_q_7_3(STALLENABLE,129)
    -- Valid signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_3_V0 <= SE_redist4_i_select6_gemm_kernel_q_7_3_R_v_0;
    -- Stall signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_3_s_tv_0 <= SR_SE_redist4_i_select6_gemm_kernel_q_7_4_backStall and SE_redist4_i_select6_gemm_kernel_q_7_3_R_v_0;
    -- Backward Enable generation
    SE_redist4_i_select6_gemm_kernel_q_7_3_backEN <= not (SE_redist4_i_select6_gemm_kernel_q_7_3_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist4_i_select6_gemm_kernel_q_7_3_v_s_0 <= SE_redist4_i_select6_gemm_kernel_q_7_3_backEN and SE_redist4_i_select6_gemm_kernel_q_7_2_V0;
    -- Backward Stall generation
    SE_redist4_i_select6_gemm_kernel_q_7_3_backStall <= not (SE_redist4_i_select6_gemm_kernel_q_7_3_v_s_0);
    SE_redist4_i_select6_gemm_kernel_q_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist4_i_select6_gemm_kernel_q_7_3_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_3_backEN = "0") THEN
                SE_redist4_i_select6_gemm_kernel_q_7_3_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_3_R_v_0 and SE_redist4_i_select6_gemm_kernel_q_7_3_s_tv_0;
            ELSE
                SE_redist4_i_select6_gemm_kernel_q_7_3_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_3_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist4_i_select6_gemm_kernel_q_7_4(STALLREG,188)
    SR_SE_redist4_i_select6_gemm_kernel_q_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid <= (others => '0');
            SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid <= SE_redist4_i_select6_gemm_kernel_q_7_4_backStall and (SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid or SR_SE_redist4_i_select6_gemm_kernel_q_7_4_i_valid);

            IF (SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_data0 <= STD_LOGIC_VECTOR(redist4_i_select6_gemm_kernel_q_7_3_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist4_i_select6_gemm_kernel_q_7_4_i_valid <= SE_redist4_i_select6_gemm_kernel_q_7_3_V0;
    -- Stall signal propagation
    SR_SE_redist4_i_select6_gemm_kernel_q_7_4_backStall <= SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid or not (SR_SE_redist4_i_select6_gemm_kernel_q_7_4_i_valid);

    -- Valid
    SR_SE_redist4_i_select6_gemm_kernel_q_7_4_V <= SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid WHEN SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid = "1" ELSE SR_SE_redist4_i_select6_gemm_kernel_q_7_4_i_valid;

    SR_SE_redist4_i_select6_gemm_kernel_q_7_4_D0 <= SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_data0 WHEN SR_SE_redist4_i_select6_gemm_kernel_q_7_4_r_valid = "1" ELSE redist4_i_select6_gemm_kernel_q_7_3_q;

    -- SE_redist4_i_select6_gemm_kernel_q_7_4(STALLENABLE,130)
    -- Valid signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_4_V0 <= SE_redist4_i_select6_gemm_kernel_q_7_4_R_v_0;
    -- Stall signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_4_s_tv_0 <= SE_redist4_i_select6_gemm_kernel_q_7_5_backStall and SE_redist4_i_select6_gemm_kernel_q_7_4_R_v_0;
    -- Backward Enable generation
    SE_redist4_i_select6_gemm_kernel_q_7_4_backEN <= not (SE_redist4_i_select6_gemm_kernel_q_7_4_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist4_i_select6_gemm_kernel_q_7_4_v_s_0 <= SE_redist4_i_select6_gemm_kernel_q_7_4_backEN and SR_SE_redist4_i_select6_gemm_kernel_q_7_4_V;
    -- Backward Stall generation
    SE_redist4_i_select6_gemm_kernel_q_7_4_backStall <= not (SE_redist4_i_select6_gemm_kernel_q_7_4_backEN);
    SE_redist4_i_select6_gemm_kernel_q_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist4_i_select6_gemm_kernel_q_7_4_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_4_backEN = "0") THEN
                SE_redist4_i_select6_gemm_kernel_q_7_4_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_4_R_v_0 and SE_redist4_i_select6_gemm_kernel_q_7_4_s_tv_0;
            ELSE
                SE_redist4_i_select6_gemm_kernel_q_7_4_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_4_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist4_i_select6_gemm_kernel_q_7_5(STALLENABLE,131)
    -- Valid signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_5_V0 <= SE_redist4_i_select6_gemm_kernel_q_7_5_R_v_0;
    -- Stall signal propagation
    SE_redist4_i_select6_gemm_kernel_q_7_5_s_tv_0 <= SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_backStall and SE_redist4_i_select6_gemm_kernel_q_7_5_R_v_0;
    -- Backward Enable generation
    SE_redist4_i_select6_gemm_kernel_q_7_5_backEN <= not (SE_redist4_i_select6_gemm_kernel_q_7_5_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist4_i_select6_gemm_kernel_q_7_5_v_s_0 <= SE_redist4_i_select6_gemm_kernel_q_7_5_backEN and SE_redist4_i_select6_gemm_kernel_q_7_4_V0;
    -- Backward Stall generation
    SE_redist4_i_select6_gemm_kernel_q_7_5_backStall <= not (SE_redist4_i_select6_gemm_kernel_q_7_5_v_s_0);
    SE_redist4_i_select6_gemm_kernel_q_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist4_i_select6_gemm_kernel_q_7_5_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_5_backEN = "0") THEN
                SE_redist4_i_select6_gemm_kernel_q_7_5_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_5_R_v_0 and SE_redist4_i_select6_gemm_kernel_q_7_5_s_tv_0;
            ELSE
                SE_redist4_i_select6_gemm_kernel_q_7_5_R_v_0 <= SE_redist4_i_select6_gemm_kernel_q_7_5_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- redist4_i_select6_gemm_kernel_q_7_4(REG,67)
    redist4_i_select6_gemm_kernel_q_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_i_select6_gemm_kernel_q_7_4_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_4_backEN = "1") THEN
                redist4_i_select6_gemm_kernel_q_7_4_q <= STD_LOGIC_VECTOR(SR_SE_redist4_i_select6_gemm_kernel_q_7_4_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_i_select6_gemm_kernel_q_7_5(REG,68)
    redist4_i_select6_gemm_kernel_q_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_i_select6_gemm_kernel_q_7_5_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist4_i_select6_gemm_kernel_q_7_5_backEN = "1") THEN
                redist4_i_select6_gemm_kernel_q_7_5_q <= STD_LOGIC_VECTOR(redist4_i_select6_gemm_kernel_q_7_4_q);
            END IF;
        END IF;
    END PROCESS;

    -- SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x(STALLENABLE,101)
    -- Valid signal propagation
    SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_V0 <= SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_wireValid;
    -- Backward Stall generation
    SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_backStall <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_o_stall or not (SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_and0 <= i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_o_valid;
    SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_and1 <= SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_V0 and SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_and0;
    SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_wireValid <= SE_redist4_i_select6_gemm_kernel_q_7_5_V0 and SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_and1;

    -- SE_out_redist0_stall_entry_o4_11_fifo(STALLENABLE,121)
    -- Valid signal propagation
    SE_out_redist0_stall_entry_o4_11_fifo_V0 <= SE_out_redist0_stall_entry_o4_11_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist0_stall_entry_o4_11_fifo_backStall <= in_stall_in or not (SE_out_redist0_stall_entry_o4_11_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist0_stall_entry_o4_11_fifo_and0 <= redist0_stall_entry_o4_11_fifo_valid_out;
    SE_out_redist0_stall_entry_o4_11_fifo_wireValid <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_o_valid and SE_out_redist0_stall_entry_o4_11_fifo_and0;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6(REG,75)
    redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_backEN = "1") THEN
                redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_q <= STD_LOGIC_VECTOR(SR_SE_redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_D0);
            END IF;
        END IF;
    END PROCESS;

    -- i_or_cond_neg_rm17_gemm_kernel(LOGICAL,31)@9
    i_or_cond_neg_rm17_gemm_kernel_q <= redist5_i_or_cond_neg_rm17_demorgan_gemm_kernel_q_7_6_q xor VCC_q;

    -- bubble_join_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x(BITJOIN,78)
    bubble_join_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_q <= i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_out_c0_exit24_1;

    -- bubble_select_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x(BITSELECT,79)
    bubble_select_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_q(63 downto 0));

    -- i_store_unnamed_gemm_kernel2_gemm_kernel(BLACKBOX,34)@9
    -- in in_i_stall@20000000
    -- out out_lsu_unnamed_gemm_kernel2_o_active@20000000
    -- out out_o_stall@20000000
    -- out out_o_valid@11
    -- out out_unnamed_gemm_kernel2_avm_address@20000000
    -- out out_unnamed_gemm_kernel2_avm_burstcount@20000000
    -- out out_unnamed_gemm_kernel2_avm_byteenable@20000000
    -- out out_unnamed_gemm_kernel2_avm_enable@20000000
    -- out out_unnamed_gemm_kernel2_avm_read@20000000
    -- out out_unnamed_gemm_kernel2_avm_write@20000000
    -- out out_unnamed_gemm_kernel2_avm_writedata@20000000
    thei_store_unnamed_gemm_kernel2_gemm_kernel : i_store_unnamed_gemm_kernel2_gemm_kernel52
    PORT MAP (
        in_flush => in_flush,
        in_i_address => bubble_select_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_b,
        in_i_predicate => i_or_cond_neg_rm17_gemm_kernel_q,
        in_i_stall => SE_out_redist0_stall_entry_o4_11_fifo_backStall,
        in_i_valid => SE_out_i_sfc_c0_for_end_loopexit_gemm_kernel_c0_enter20_gemm_kernel_aunroll_x_V0,
        in_i_writedata => redist4_i_select6_gemm_kernel_q_7_5_q,
        in_unnamed_gemm_kernel2_avm_readdata => in_unnamed_gemm_kernel2_avm_readdata,
        in_unnamed_gemm_kernel2_avm_readdatavalid => in_unnamed_gemm_kernel2_avm_readdatavalid,
        in_unnamed_gemm_kernel2_avm_waitrequest => in_unnamed_gemm_kernel2_avm_waitrequest,
        in_unnamed_gemm_kernel2_avm_writeack => in_unnamed_gemm_kernel2_avm_writeack,
        out_lsu_unnamed_gemm_kernel2_o_active => i_store_unnamed_gemm_kernel2_gemm_kernel_out_lsu_unnamed_gemm_kernel2_o_active,
        out_o_stall => i_store_unnamed_gemm_kernel2_gemm_kernel_out_o_stall,
        out_o_valid => i_store_unnamed_gemm_kernel2_gemm_kernel_out_o_valid,
        out_unnamed_gemm_kernel2_avm_address => i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_address,
        out_unnamed_gemm_kernel2_avm_burstcount => i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_burstcount,
        out_unnamed_gemm_kernel2_avm_byteenable => i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_byteenable,
        out_unnamed_gemm_kernel2_avm_enable => i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_enable,
        out_unnamed_gemm_kernel2_avm_read => i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_read,
        out_unnamed_gemm_kernel2_avm_write => i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_write,
        out_unnamed_gemm_kernel2_avm_writedata => i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,2)
    out_lsu_unnamed_gemm_kernel2_o_active <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_lsu_unnamed_gemm_kernel2_o_active;

    -- bubble_join_redist0_stall_entry_o4_11_fifo(BITJOIN,98)
    bubble_join_redist0_stall_entry_o4_11_fifo_q <= redist0_stall_entry_o4_11_fifo_data_out;

    -- bubble_select_redist0_stall_entry_o4_11_fifo(BITSELECT,99)
    bubble_select_redist0_stall_entry_o4_11_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist0_stall_entry_o4_11_fifo_q(31 downto 0));

    -- dupName_0_sync_out_x(GPOUT,7)@11
    out_acl_hw_wg_id7 <= bubble_select_redist0_stall_entry_o4_11_fifo_b;
    out_valid_out <= SE_out_redist0_stall_entry_o4_11_fifo_V0;

    -- ext_sig_sync_out(GPOUT,25)
    out_unnamed_gemm_kernel2_avm_address <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_address;
    out_unnamed_gemm_kernel2_avm_enable <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_enable;
    out_unnamed_gemm_kernel2_avm_read <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_read;
    out_unnamed_gemm_kernel2_avm_write <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_write;
    out_unnamed_gemm_kernel2_avm_writedata <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_writedata;
    out_unnamed_gemm_kernel2_avm_byteenable <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_byteenable;
    out_unnamed_gemm_kernel2_avm_burstcount <= i_store_unnamed_gemm_kernel2_gemm_kernel_out_unnamed_gemm_kernel2_avm_burstcount;

    -- sync_out(GPOUT,50)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
