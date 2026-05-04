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

-- VHDL created from bb_gemm_kernel_B1_stall_region
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

entity bb_gemm_kernel_B1_stall_region is
    port (
        in_unnamed_gemm_kernel1_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_gemm_kernel1_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel1_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_gemm_kernel1_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel1_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel1_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel1_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_gemm_kernel1_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_gemm_kernel1_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_B : in std_logic_vector(63 downto 0);  -- ufix64
        in_acl_hw_wg_id8 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exe11 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_04 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_16 : in std_logic_vector(31 downto 0);  -- ufix32
        in_k_05 : in std_logic_vector(31 downto 0);  -- ufix32
        in_sum_04 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id8 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exe11 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c1_exe1 : out std_logic_vector(31 downto 0);  -- float32_m23
        out_exitcond_GUARD_GUARD : out std_logic_vector(0 downto 0);  -- ufix1
        out_global_id_04 : out std_logic_vector(31 downto 0);  -- ufix32
        out_global_id_16 : out std_logic_vector(31 downto 0);  -- ufix32
        out_inc : out std_logic_vector(31 downto 0);  -- ufix32
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_K : in std_logic_vector(31 downto 0);  -- ufix32
        in_M : in std_logic_vector(31 downto 0);  -- ufix32
        in_N : in std_logic_vector(31 downto 0);  -- ufix32
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel0_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_gemm_kernel0_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_gemm_kernel0_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_gemm_kernel0_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_gemm_kernel0_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_A : in std_logic_vector(63 downto 0);  -- ufix64
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_gemm_kernel_B1_stall_region;

architecture normal of bb_gemm_kernel_B1_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component gemm_kernel_B1_merge_reg is
        port (
            in_data_in_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_data_in_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_3 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_4 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_5 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_data_out_2 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_3 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_4 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_5 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel is
        port (
            in_c0_eni2_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni2_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_eni2_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_B : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_N : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit16_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit16_1 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel is
        port (
            in_c1_eni3_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_eni3_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_c1_eni3_2 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_c1_eni3_3 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_load_unnamed_gemm_kernel0_gemm_kernel28 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel0_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel0_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_readdata : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_load_unnamed_gemm_kernel1_gemm_kernel30 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_readdata : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_a_sync_buffer_gemm_kernel5 is
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


    component i_syncbuf_k_sync_buffer5_gemm_kernel13 is
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


    component i_syncbuf_k_sync_buffer_gemm_kernel7 is
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


    component i_syncbuf_m_sync_buffer_gemm_kernel9 is
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


    component i_syncbuf_n_sync_buffer_gemm_kernel11 is
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
    signal bgTrunc_i_add_gemm_kernel_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bgTrunc_i_inc_gemm_kernel_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal gemm_kernel_B1_merge_reg_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_multconst_x_q : STD_LOGIC_VECTOR (60 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_idxprom_gemm_kernel_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_c0_exit16_1 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_c1_exit_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal c_i32_1gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_add_gemm_kernel_a : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_gemm_kernel_b : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_gemm_kernel_o : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_gemm_kernel_q : STD_LOGIC_VECTOR (32 downto 0);
    signal i_cmp63_neg_rm_gemm_kernel_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp63_neg_rm_gemm_kernel_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp63_neg_rm_gemm_kernel_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp63_neg_rm_gemm_kernel_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_gemm_kernel_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_guard_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_guard_guard_gemm_kernel_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_guard_guard_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_inc_gemm_kernel_a : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_gemm_kernel_b : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_gemm_kernel_o : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_gemm_kernel_q : STD_LOGIC_VECTOR (32 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_readdata : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_readdata : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_notlhs_gemm_kernel_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_notlhs_gemm_kernel_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_notlhs_gemm_kernel_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_notlhs_gemm_kernel_n : STD_LOGIC_VECTOR (0 downto 0);
    signal i_notrhs_gemm_kernel_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_notrhs_gemm_kernel_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_notrhs_gemm_kernel_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_notrhs_gemm_kernel_n : STD_LOGIC_VECTOR (0 downto 0);
    signal i_or_cond_neg_or_rm_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_or_cond_neg_rm_gemm_kernel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_a_sync_buffer_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_a_sync_buffer_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_a_sync_buffer_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_k_sync_buffer5_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_k_sync_buffer5_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_k_sync_buffer5_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_k_sync_buffer_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_k_sync_buffer_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_k_sync_buffer_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_m_sync_buffer_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_m_sync_buffer_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_m_sync_buffer_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer_gemm_kernel_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_n_sync_buffer_gemm_kernel_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer_gemm_kernel_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_13_q : STD_LOGIC_VECTOR (56 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_14_q : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_14_qint : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_16_q : STD_LOGIC_VECTOR (66 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_5_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist13_bgTrunc_i_add_gemm_kernel_sel_x_b_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q : STD_LOGIC_VECTOR (191 downto 0);
    signal bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_c : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_d : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_e : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_f : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_g : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_load_unnamed_gemm_kernel0_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_load_unnamed_gemm_kernel0_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_load_unnamed_gemm_kernel1_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_load_unnamed_gemm_kernel1_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_a_sync_buffer_gemm_kernel_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_a_sync_buffer_gemm_kernel_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_k_sync_buffer5_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_k_sync_buffer5_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_k_sync_buffer_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_k_sync_buffer_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_m_sync_buffer_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_m_sync_buffer_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_n_sync_buffer_gemm_kernel_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_n_sync_buffer_gemm_kernel_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (191 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_c : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_d : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_e : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_f : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_g : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg7 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg7 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed7 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg8 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg8 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed8 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg9 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg9 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed9 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg10 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg10 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed10 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or7 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or8 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or9 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V7 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V8 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V9 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V10 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp63_neg_rm_gemm_kernel_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notlhs_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notlhs_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notlhs_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notlhs_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notlhs_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notlhs_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notrhs_gemm_kernel_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notrhs_gemm_kernel_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notrhs_gemm_kernel_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notrhs_gemm_kernel_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notrhs_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_notrhs_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_or_rm_gemm_kernel_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_or_cond_neg_rm_gemm_kernel_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_out_bitsignaltemp : std_logic;
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_exitcond_gemm_kernel_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notlhs_gemm_kernel_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_notrhs_gemm_kernel_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_gemm_kernel_D1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_D1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_D1 : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x(STALLENABLE,232)
    -- Valid signal propagation
    SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_V0 <= SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_wireValid;
    -- Backward Stall generation
    SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_backStall <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_stall or not (SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_wireValid <= SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_V;

    -- SE_i_notlhs_gemm_kernel(STALLENABLE,245)
    -- Valid signal propagation
    SE_i_notlhs_gemm_kernel_V0 <= SE_i_notlhs_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_notlhs_gemm_kernel_s_tv_0 <= SE_i_or_cond_neg_rm_gemm_kernel_backStall and SE_i_notlhs_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_notlhs_gemm_kernel_backEN <= not (SE_i_notlhs_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_notlhs_gemm_kernel_v_s_0 <= SE_i_notlhs_gemm_kernel_backEN and SR_SE_i_notlhs_gemm_kernel_V;
    -- Backward Stall generation
    SE_i_notlhs_gemm_kernel_backStall <= not (SE_i_notlhs_gemm_kernel_backEN);
    SE_i_notlhs_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_notlhs_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_notlhs_gemm_kernel_backEN = "0") THEN
                SE_i_notlhs_gemm_kernel_R_v_0 <= SE_i_notlhs_gemm_kernel_R_v_0 and SE_i_notlhs_gemm_kernel_s_tv_0;
            ELSE
                SE_i_notlhs_gemm_kernel_R_v_0 <= SE_i_notlhs_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- bubble_join_gemm_kernel_B1_merge_reg_aunroll_x(BITJOIN,155)
    bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q <= gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5 & gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4 & gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3 & gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2 & gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1 & gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0;

    -- bubble_select_gemm_kernel_B1_merge_reg_aunroll_x(BITSELECT,156)
    bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q(31 downto 0));
    bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_c <= STD_LOGIC_VECTOR(bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q(63 downto 32));
    bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_d <= STD_LOGIC_VECTOR(bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q(95 downto 64));
    bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_e <= STD_LOGIC_VECTOR(bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q(127 downto 96));
    bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_f <= STD_LOGIC_VECTOR(bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q(159 downto 128));
    bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_g <= STD_LOGIC_VECTOR(bubble_join_gemm_kernel_B1_merge_reg_aunroll_x_q(191 downto 160));

    -- SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4(STALLENABLE,318)
    -- Valid signal propagation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_V0 <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_backStall <= i_syncbuf_n_sync_buffer_gemm_kernel_out_stall_out or not (SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_wireValid <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_out;

    -- i_syncbuf_n_sync_buffer_gemm_kernel(BLACKBOX,71)@9
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_n_sync_buffer_gemm_kernel : i_syncbuf_n_sync_buffer_gemm_kernel11
    PORT MAP (
        in_buffer_in => in_N,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_backStall,
        in_valid_in => SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_V0,
        out_buffer_out => i_syncbuf_n_sync_buffer_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_n_sync_buffer_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_n_sync_buffer_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_n_sync_buffer_gemm_kernel(BITJOIN,189)
    bubble_join_i_syncbuf_n_sync_buffer_gemm_kernel_q <= i_syncbuf_n_sync_buffer_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_n_sync_buffer_gemm_kernel(BITSELECT,190)
    bubble_select_i_syncbuf_n_sync_buffer_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_n_sync_buffer_gemm_kernel_q(31 downto 0));

    -- bubble_join_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo(BITJOIN,211)
    bubble_join_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_q <= redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_data_out;

    -- bubble_select_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo(BITSELECT,212)
    bubble_select_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_q(31 downto 0));

    -- SE_out_i_syncbuf_n_sync_buffer_gemm_kernel(STALLENABLE,258)
    -- Valid signal propagation
    SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_V0 <= SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_backStall <= SR_SE_i_notrhs_gemm_kernel_backStall or not (SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_wireValid <= i_syncbuf_n_sync_buffer_gemm_kernel_out_valid_out;

    -- SE_i_notrhs_gemm_kernel(STALLENABLE,246)
    -- Valid signal propagation
    SE_i_notrhs_gemm_kernel_V0 <= SE_i_notrhs_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_notrhs_gemm_kernel_s_tv_0 <= SE_i_or_cond_neg_rm_gemm_kernel_backStall and SE_i_notrhs_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_notrhs_gemm_kernel_backEN <= not (SE_i_notrhs_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_notrhs_gemm_kernel_v_s_0 <= SE_i_notrhs_gemm_kernel_backEN and SR_SE_i_notrhs_gemm_kernel_V;
    -- Backward Stall generation
    SE_i_notrhs_gemm_kernel_backStall <= not (SE_i_notrhs_gemm_kernel_backEN);
    SE_i_notrhs_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_notrhs_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_notrhs_gemm_kernel_backEN = "0") THEN
                SE_i_notrhs_gemm_kernel_R_v_0 <= SE_i_notrhs_gemm_kernel_R_v_0 and SE_i_notrhs_gemm_kernel_s_tv_0;
            ELSE
                SE_i_notrhs_gemm_kernel_R_v_0 <= SE_i_notrhs_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_i_notrhs_gemm_kernel(STALLREG,415)
    SR_SE_i_notrhs_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_notrhs_gemm_kernel_r_valid <= (others => '0');
            SR_SE_i_notrhs_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_i_notrhs_gemm_kernel_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_notrhs_gemm_kernel_r_valid <= SE_i_notrhs_gemm_kernel_backStall and (SR_SE_i_notrhs_gemm_kernel_r_valid or SR_SE_i_notrhs_gemm_kernel_i_valid);

            IF (SR_SE_i_notrhs_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_notrhs_gemm_kernel_r_data0 <= STD_LOGIC_VECTOR(bubble_select_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_b);
                SR_SE_i_notrhs_gemm_kernel_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_n_sync_buffer_gemm_kernel_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_notrhs_gemm_kernel_and0 <= SE_out_i_syncbuf_n_sync_buffer_gemm_kernel_V0;
    SR_SE_i_notrhs_gemm_kernel_i_valid <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_V0 and SR_SE_i_notrhs_gemm_kernel_and0;
    -- Stall signal propagation
    SR_SE_i_notrhs_gemm_kernel_backStall <= SR_SE_i_notrhs_gemm_kernel_r_valid or not (SR_SE_i_notrhs_gemm_kernel_i_valid);

    -- Valid
    SR_SE_i_notrhs_gemm_kernel_V <= SR_SE_i_notrhs_gemm_kernel_r_valid WHEN SR_SE_i_notrhs_gemm_kernel_r_valid = "1" ELSE SR_SE_i_notrhs_gemm_kernel_i_valid;

    -- Data0
    SR_SE_i_notrhs_gemm_kernel_D0 <= SR_SE_i_notrhs_gemm_kernel_r_data0 WHEN SR_SE_i_notrhs_gemm_kernel_r_valid = "1" ELSE bubble_select_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_b;
    -- Data1
    SR_SE_i_notrhs_gemm_kernel_D1 <= SR_SE_i_notrhs_gemm_kernel_r_data1 WHEN SR_SE_i_notrhs_gemm_kernel_r_valid = "1" ELSE bubble_select_i_syncbuf_n_sync_buffer_gemm_kernel_b;

    -- SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo(STALLENABLE,298)
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg0 <= (others => '0');
            SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg0 <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_toReg0;
            -- Succesor 1
            SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg1 <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed0 <= (not (SR_SE_i_notrhs_gemm_kernel_backStall) and SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireValid) or SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg0;
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed1 <= (not (redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_out) and SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireValid) or SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg1;
    -- Consuming
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_StallValid <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_backStall and SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireValid;
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_toReg0 <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_StallValid and SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed0;
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_toReg1 <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_StallValid and SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed1;
    -- Backward Stall generation
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_or0 <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed0;
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireStall <= not (SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_consumed1 and SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_or0);
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_backStall <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireStall;
    -- Valid signal propagation
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_V0 <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireValid and not (SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg0);
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_V1 <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireValid and not (SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_wireValid <= redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_out;

    -- redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo(STALLFIFO,148)
    redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V9;
    redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_in <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_backStall;
    redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_data_in <= bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_f;
    redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_in_bitsignaltemp <= redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_in(0);
    redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_in_bitsignaltemp <= redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_in(0);
    redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_out(0) <= redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_out_bitsignaltemp;
    redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_out(0) <= redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_out_bitsignaltemp;
    theredist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 9,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_in_bitsignaltemp,
        stall_in => redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_f,
        valid_out => redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_valid_out_bitsignaltemp,
        stall_out => redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_out_bitsignaltemp,
        data_out => redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo(STALLFIFO,146)
    redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V8;
    redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_in <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_backStall;
    redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_data_in <= bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_e;
    redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_in_bitsignaltemp <= redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_in(0);
    redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_in_bitsignaltemp <= redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_in(0);
    redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_out(0) <= redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_out_bitsignaltemp;
    redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_out(0) <= redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_out_bitsignaltemp;
    theredist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 9,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_in_bitsignaltemp,
        stall_in => redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_e,
        valid_out => redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_out_bitsignaltemp,
        stall_out => redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_out_bitsignaltemp,
        data_out => redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x(BLACKBOX,43)@1
    -- in in_i_stall@20000000
    -- out out_c0_exit16_0@10
    -- out out_c0_exit16_1@10
    -- out out_o_stall@20000000
    -- out out_o_valid@10
    thei_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x : i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel
    PORT MAP (
        in_c0_eni2_0 => GND_q,
        in_c0_eni2_1 => bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_b,
        in_c0_eni2_2 => bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_f,
        in_B => in_B,
        in_N => in_N,
        in_i_stall => SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_backStall,
        in_i_valid => SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V6,
        out_c0_exit16_1 => i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_c0_exit16_1,
        out_o_stall => i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_0(REG,138)
    redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backEN = "1") THEN
                redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_0_q <= STD_LOGIC_VECTOR(bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_d);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0(REG,130)
    redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backEN = "1") THEN
                redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_q <= STD_LOGIC_VECTOR(bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_1(REG,139)
    redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backEN = "1") THEN
                redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_1_q <= STD_LOGIC_VECTOR(SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_D1);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_2(REG,140)
    redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_2_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backEN = "1") THEN
                redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_2_q <= STD_LOGIC_VECTOR(redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1(REG,131)
    redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backEN = "1") THEN
                redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_q <= STD_LOGIC_VECTOR(SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2(REG,132)
    redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backEN = "1") THEN
                redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_q <= STD_LOGIC_VECTOR(redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_3(REG,141)
    redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_3_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backEN = "1") THEN
                redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_3_q <= STD_LOGIC_VECTOR(SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_D1);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_4(REG,142)
    redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_4_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backEN = "1") THEN
                redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_4_q <= STD_LOGIC_VECTOR(redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_3_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3(REG,133)
    redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backEN = "1") THEN
                redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_q <= STD_LOGIC_VECTOR(SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4(REG,134)
    redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backEN = "1") THEN
                redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_q <= STD_LOGIC_VECTOR(redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_5(REG,143)
    redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_5_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backEN = "1") THEN
                redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_5_q <= STD_LOGIC_VECTOR(SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_D1);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6(REG,144)
    redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backEN = "1") THEN
                redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6_q <= STD_LOGIC_VECTOR(redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_5_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5(REG,135)
    redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backEN = "1") THEN
                redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_q <= STD_LOGIC_VECTOR(SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6(REG,136)
    redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backEN = "1") THEN
                redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_q <= STD_LOGIC_VECTOR(redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_q);
            END IF;
        END IF;
    END PROCESS;

    -- i_add_gemm_kernel(ADD,53)@8
    i_add_gemm_kernel_a <= STD_LOGIC_VECTOR("0" & redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_q);
    i_add_gemm_kernel_b <= STD_LOGIC_VECTOR("0" & redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6_q);
    i_add_gemm_kernel_o <= STD_LOGIC_VECTOR(UNSIGNED(i_add_gemm_kernel_a) + UNSIGNED(i_add_gemm_kernel_b));
    i_add_gemm_kernel_q <= i_add_gemm_kernel_o(32 downto 0);

    -- bgTrunc_i_add_gemm_kernel_sel_x(BITSELECT,2)@8
    bgTrunc_i_add_gemm_kernel_sel_x_b <= i_add_gemm_kernel_q(31 downto 0);

    -- c_i32_1gr(CONSTANT,48)
    c_i32_1gr_q <= "00000000000000000000000000000001";

    -- i_inc_gemm_kernel(ADD,60)@8
    i_inc_gemm_kernel_a <= STD_LOGIC_VECTOR("0" & redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_q);
    i_inc_gemm_kernel_b <= STD_LOGIC_VECTOR("0" & c_i32_1gr_q);
    i_inc_gemm_kernel_o <= STD_LOGIC_VECTOR(UNSIGNED(i_inc_gemm_kernel_a) + UNSIGNED(i_inc_gemm_kernel_b));
    i_inc_gemm_kernel_q <= i_inc_gemm_kernel_o(32 downto 0);

    -- bgTrunc_i_inc_gemm_kernel_sel_x(BITSELECT,3)@8
    bgTrunc_i_inc_gemm_kernel_sel_x_b <= i_inc_gemm_kernel_q(31 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_multconst_x(CONSTANT,36)
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_multconst_x_q <= "0000000000000000000000000000000000000000000000000000000000000";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist13_bgTrunc_i_add_gemm_kernel_sel_x_b_1_0(REG,153)
    redist13_bgTrunc_i_add_gemm_kernel_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist13_bgTrunc_i_add_gemm_kernel_sel_x_b_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN = "1") THEN
                redist13_bgTrunc_i_add_gemm_kernel_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_D1);
            END IF;
        END IF;
    END PROCESS;

    -- i_idxprom_gemm_kernel_sel_x(BITSELECT,42)@9
    i_idxprom_gemm_kernel_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(redist13_bgTrunc_i_add_gemm_kernel_sel_x_b_1_0_q(31 downto 0)), 64)));

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select(BITSELECT,113)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_b <= i_idxprom_gemm_kernel_sel_x_b(17 downto 0);
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_c <= i_idxprom_gemm_kernel_sel_x_b(63 downto 54);
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_d <= i_idxprom_gemm_kernel_sel_x_b(35 downto 18);
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_e <= i_idxprom_gemm_kernel_sel_x_b(53 downto 36);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im3_shift0(BITSHIFT,110)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im3_shift0_qint <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_c & "00";
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im3_shift0_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im3_shift0_qint(11 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_15(BITSHIFT,103)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im3_shift0_q) & "000000000000000";
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_15_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im6_shift0(BITSHIFT,111)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im6_shift0_qint <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_d & "00";
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im6_shift0_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im6_shift0_qint(19 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_14(BITSHIFT,102)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_14_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_14_qint(38 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_16(BITJOIN,104)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_16_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_15_q & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_14_q;

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im9_shift0(BITSHIFT,112)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im9_shift0_qint <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_e & "00";
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im9_shift0_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im9_shift0_qint(19 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_12(BITSHIFT,100)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im9_shift0_q) & "000000000000000";
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_12_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im0_shift0(BITSHIFT,109)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im0_shift0_qint <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_bs1_merged_bit_select_b & "00";
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im0_shift0_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im0_shift0_qint(19 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_13(BITJOIN,101)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_13_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_im0_shift0_q);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0(ADD,105)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_13_q);
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_join_16_q);
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_b));
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_o(67 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_mult_extender_x(BITJOIN,35)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_mult_extender_x_q <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_multconst_x_q & i_arrayidx_gemm_kernel_gemm_kernel27_mult_x_result_add_0_0_q(66 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x(BITSELECT,37)@9
    i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b <= i_arrayidx_gemm_kernel_gemm_kernel27_mult_extender_x_q(63 downto 0);

    -- SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2(STALLENABLE,314)
    -- Valid signal propagation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_V0 <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_backStall <= i_syncbuf_k_sync_buffer_gemm_kernel_out_stall_out or not (SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_wireValid <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_out;

    -- i_syncbuf_k_sync_buffer_gemm_kernel(BLACKBOX,69)@9
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_k_sync_buffer_gemm_kernel : i_syncbuf_k_sync_buffer_gemm_kernel7
    PORT MAP (
        in_buffer_in => in_K,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_backStall,
        in_valid_in => SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_V0,
        out_buffer_out => i_syncbuf_k_sync_buffer_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_k_sync_buffer_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_k_sync_buffer_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_k_sync_buffer_gemm_kernel(STALLENABLE,254)
    -- Valid signal propagation
    SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_V0 <= SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_backStall <= SE_i_cmp63_neg_rm_gemm_kernel_backStall or not (SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_wireValid <= i_syncbuf_k_sync_buffer_gemm_kernel_out_valid_out;

    -- SE_i_cmp63_neg_rm_gemm_kernel(STALLENABLE,236)
    -- Valid signal propagation
    SE_i_cmp63_neg_rm_gemm_kernel_V0 <= SE_i_cmp63_neg_rm_gemm_kernel_R_v_0;
    SE_i_cmp63_neg_rm_gemm_kernel_V1 <= SE_i_cmp63_neg_rm_gemm_kernel_R_v_1;
    -- Stall signal propagation
    SE_i_cmp63_neg_rm_gemm_kernel_s_tv_0 <= SE_i_exitcond_guard_gemm_kernel_backStall and SE_i_cmp63_neg_rm_gemm_kernel_R_v_0;
    SE_i_cmp63_neg_rm_gemm_kernel_s_tv_1 <= SE_i_or_cond_neg_or_rm_gemm_kernel_backStall and SE_i_cmp63_neg_rm_gemm_kernel_R_v_1;
    -- Backward Enable generation
    SE_i_cmp63_neg_rm_gemm_kernel_or0 <= SE_i_cmp63_neg_rm_gemm_kernel_s_tv_0;
    SE_i_cmp63_neg_rm_gemm_kernel_backEN <= not (SE_i_cmp63_neg_rm_gemm_kernel_s_tv_1 or SE_i_cmp63_neg_rm_gemm_kernel_or0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp63_neg_rm_gemm_kernel_v_s_0 <= SE_i_cmp63_neg_rm_gemm_kernel_backEN and SE_out_i_syncbuf_k_sync_buffer_gemm_kernel_V0;
    -- Backward Stall generation
    SE_i_cmp63_neg_rm_gemm_kernel_backStall <= not (SE_i_cmp63_neg_rm_gemm_kernel_v_s_0);
    SE_i_cmp63_neg_rm_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp63_neg_rm_gemm_kernel_R_v_0 <= (others => '0');
            SE_i_cmp63_neg_rm_gemm_kernel_R_v_1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp63_neg_rm_gemm_kernel_backEN = "0") THEN
                SE_i_cmp63_neg_rm_gemm_kernel_R_v_0 <= SE_i_cmp63_neg_rm_gemm_kernel_R_v_0 and SE_i_cmp63_neg_rm_gemm_kernel_s_tv_0;
            ELSE
                SE_i_cmp63_neg_rm_gemm_kernel_R_v_0 <= SE_i_cmp63_neg_rm_gemm_kernel_v_s_0;
            END IF;

            IF (SE_i_cmp63_neg_rm_gemm_kernel_backEN = "0") THEN
                SE_i_cmp63_neg_rm_gemm_kernel_R_v_1 <= SE_i_cmp63_neg_rm_gemm_kernel_R_v_1 and SE_i_cmp63_neg_rm_gemm_kernel_s_tv_1;
            ELSE
                SE_i_cmp63_neg_rm_gemm_kernel_R_v_1 <= SE_i_cmp63_neg_rm_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_k_sync_buffer_gemm_kernel(BITJOIN,183)
    bubble_join_i_syncbuf_k_sync_buffer_gemm_kernel_q <= i_syncbuf_k_sync_buffer_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_k_sync_buffer_gemm_kernel(BITSELECT,184)
    bubble_select_i_syncbuf_k_sync_buffer_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_k_sync_buffer_gemm_kernel_q(31 downto 0));

    -- i_cmp63_neg_rm_gemm_kernel(COMPARE,54)@9 + 1
    i_cmp63_neg_rm_gemm_kernel_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => bubble_select_i_syncbuf_k_sync_buffer_gemm_kernel_b(31)) & bubble_select_i_syncbuf_k_sync_buffer_gemm_kernel_b));
    i_cmp63_neg_rm_gemm_kernel_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => c_i32_1gr_q(31)) & c_i32_1gr_q));
    i_cmp63_neg_rm_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp63_neg_rm_gemm_kernel_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp63_neg_rm_gemm_kernel_backEN = "1") THEN
                i_cmp63_neg_rm_gemm_kernel_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp63_neg_rm_gemm_kernel_a) - SIGNED(i_cmp63_neg_rm_gemm_kernel_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp63_neg_rm_gemm_kernel_c(0) <= i_cmp63_neg_rm_gemm_kernel_o(33);

    -- i_or_cond_neg_or_rm_gemm_kernel(LOGICAL,65)@10
    i_or_cond_neg_or_rm_gemm_kernel_q <= i_cmp63_neg_rm_gemm_kernel_c or i_or_cond_neg_rm_gemm_kernel_q;

    -- redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0(REG,129)
    redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_a_sync_buffer_gemm_kernel(BITJOIN,176)
    bubble_join_i_syncbuf_a_sync_buffer_gemm_kernel_q <= i_syncbuf_a_sync_buffer_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_a_sync_buffer_gemm_kernel(BITSELECT,177)
    bubble_select_i_syncbuf_a_sync_buffer_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_a_sync_buffer_gemm_kernel_q(63 downto 0));

    -- i_arrayidx_gemm_kernel_gemm_kernel27_add_x(ADD,38)@10
    i_arrayidx_gemm_kernel_gemm_kernel27_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_a_sync_buffer_gemm_kernel_b);
    i_arrayidx_gemm_kernel_gemm_kernel27_add_x_b <= STD_LOGIC_VECTOR("0" & redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_q);
    i_arrayidx_gemm_kernel_gemm_kernel27_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_gemm_kernel_gemm_kernel27_add_x_a) + UNSIGNED(i_arrayidx_gemm_kernel_gemm_kernel27_add_x_b));
    i_arrayidx_gemm_kernel_gemm_kernel27_add_x_q <= i_arrayidx_gemm_kernel_gemm_kernel27_add_x_o(64 downto 0);

    -- i_arrayidx_gemm_kernel_gemm_kernel27_dupName_0_trunc_sel_x(BITSELECT,32)@10
    i_arrayidx_gemm_kernel_gemm_kernel27_dupName_0_trunc_sel_x_b <= i_arrayidx_gemm_kernel_gemm_kernel27_add_x_q(63 downto 0);

    -- SE_i_or_cond_neg_or_rm_gemm_kernel(STALLENABLE,247)
    SE_i_or_cond_neg_or_rm_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg0 <= (others => '0');
            SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg0 <= SE_i_or_cond_neg_or_rm_gemm_kernel_toReg0;
            -- Succesor 1
            SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg1 <= SE_i_or_cond_neg_or_rm_gemm_kernel_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_i_or_cond_neg_or_rm_gemm_kernel_consumed0 <= (not (SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall) and SE_i_or_cond_neg_or_rm_gemm_kernel_wireValid) or SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg0;
    SE_i_or_cond_neg_or_rm_gemm_kernel_consumed1 <= (not (SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_backStall) and SE_i_or_cond_neg_or_rm_gemm_kernel_wireValid) or SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg1;
    -- Consuming
    SE_i_or_cond_neg_or_rm_gemm_kernel_StallValid <= SE_i_or_cond_neg_or_rm_gemm_kernel_backStall and SE_i_or_cond_neg_or_rm_gemm_kernel_wireValid;
    SE_i_or_cond_neg_or_rm_gemm_kernel_toReg0 <= SE_i_or_cond_neg_or_rm_gemm_kernel_StallValid and SE_i_or_cond_neg_or_rm_gemm_kernel_consumed0;
    SE_i_or_cond_neg_or_rm_gemm_kernel_toReg1 <= SE_i_or_cond_neg_or_rm_gemm_kernel_StallValid and SE_i_or_cond_neg_or_rm_gemm_kernel_consumed1;
    -- Backward Stall generation
    SE_i_or_cond_neg_or_rm_gemm_kernel_or0 <= SE_i_or_cond_neg_or_rm_gemm_kernel_consumed0;
    SE_i_or_cond_neg_or_rm_gemm_kernel_wireStall <= not (SE_i_or_cond_neg_or_rm_gemm_kernel_consumed1 and SE_i_or_cond_neg_or_rm_gemm_kernel_or0);
    SE_i_or_cond_neg_or_rm_gemm_kernel_backStall <= SE_i_or_cond_neg_or_rm_gemm_kernel_wireStall;
    -- Valid signal propagation
    SE_i_or_cond_neg_or_rm_gemm_kernel_V0 <= SE_i_or_cond_neg_or_rm_gemm_kernel_wireValid and not (SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg0);
    SE_i_or_cond_neg_or_rm_gemm_kernel_V1 <= SE_i_or_cond_neg_or_rm_gemm_kernel_wireValid and not (SE_i_or_cond_neg_or_rm_gemm_kernel_fromReg1);
    -- Computing multiple Valid(s)
    SE_i_or_cond_neg_or_rm_gemm_kernel_and0 <= SE_i_cmp63_neg_rm_gemm_kernel_V1;
    SE_i_or_cond_neg_or_rm_gemm_kernel_wireValid <= SE_i_or_cond_neg_rm_gemm_kernel_V1 and SE_i_or_cond_neg_or_rm_gemm_kernel_and0;

    -- SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1(STALLENABLE,312)
    -- Valid signal propagation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_V0 <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_backStall <= i_syncbuf_a_sync_buffer_gemm_kernel_out_stall_out or not (SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_wireValid <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_out;

    -- i_syncbuf_a_sync_buffer_gemm_kernel(BLACKBOX,67)@10
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_a_sync_buffer_gemm_kernel : i_syncbuf_a_sync_buffer_gemm_kernel5
    PORT MAP (
        in_buffer_in => in_A,
        in_i_dependence => GND_q,
        in_stall_in => SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall,
        in_valid_in => SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_V0,
        out_buffer_out => i_syncbuf_a_sync_buffer_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_a_sync_buffer_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_a_sync_buffer_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_a_sync_buffer_gemm_kernel(STALLENABLE,250)
    -- Valid signal propagation
    SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_V0 <= SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_stall or not (SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_wireValid <= SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_V;

    -- SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel(STALLREG,419)
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid <= (others => '0');
            SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid <= SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall and (SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid or SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_i_valid);

            IF (SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data0 <= i_arrayidx_gemm_kernel_gemm_kernel27_dupName_0_trunc_sel_x_b;
                SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data1 <= i_or_cond_neg_or_rm_gemm_kernel_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_and0 <= i_syncbuf_a_sync_buffer_gemm_kernel_out_valid_out;
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_and1 <= SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_V0 and SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_and0;
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_i_valid <= SE_i_or_cond_neg_or_rm_gemm_kernel_V0 and SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_and1;
    -- Stall signal propagation
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall <= SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid or not (SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_i_valid);

    -- Valid
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_V <= SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid WHEN SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid = "1" ELSE SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_i_valid;

    -- Data0
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_D0 <= SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data0 WHEN SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid = "1" ELSE i_arrayidx_gemm_kernel_gemm_kernel27_dupName_0_trunc_sel_x_b;
    -- Data1
    SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_D1 <= SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_data1 WHEN SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_r_valid = "1" ELSE i_or_cond_neg_or_rm_gemm_kernel_q;

    -- SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0(STALLENABLE,274)
    -- Valid signal propagation
    SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_V0 <= SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_R_v_0;
    -- Stall signal propagation
    SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_s_tv_0 <= SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_backStall and SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_R_v_0;
    -- Backward Enable generation
    SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backEN <= not (SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_v_s_0 <= SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backEN and SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_V;
    -- Backward Stall generation
    SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backStall <= not (SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backEN);
    SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_R_v_0 <= SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_R_v_0 and SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_s_tv_0;
            ELSE
                SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_R_v_0 <= SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0(STALLREG,418)
    SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid <= (others => '0');
            SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid <= SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backStall and (SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid or SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_i_valid);

            IF (SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_data0 <= STD_LOGIC_VECTOR(i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_i_valid <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V2;
    -- Stall signal propagation
    SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backStall <= SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid or not (SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_i_valid);

    -- Valid
    SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_V <= SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid WHEN SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid = "1" ELSE SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_i_valid;

    SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_D0 <= SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_data0 WHEN SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_r_valid = "1" ELSE i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b;

    -- SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5(STALLENABLE,320)
    -- Valid signal propagation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_V0 <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_backStall <= i_syncbuf_k_sync_buffer5_gemm_kernel_out_stall_out or not (SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_wireValid <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_out;

    -- i_syncbuf_k_sync_buffer5_gemm_kernel(BLACKBOX,68)@9
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_k_sync_buffer5_gemm_kernel : i_syncbuf_k_sync_buffer5_gemm_kernel13
    PORT MAP (
        in_buffer_in => in_K,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_backStall,
        in_valid_in => SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_V0,
        out_buffer_out => i_syncbuf_k_sync_buffer5_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_k_sync_buffer5_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_k_sync_buffer5_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_k_sync_buffer5_gemm_kernel(BITJOIN,179)
    bubble_join_i_syncbuf_k_sync_buffer5_gemm_kernel_q <= i_syncbuf_k_sync_buffer5_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_k_sync_buffer5_gemm_kernel(BITSELECT,180)
    bubble_select_i_syncbuf_k_sync_buffer5_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_k_sync_buffer5_gemm_kernel_q(31 downto 0));

    -- redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0(REG,151)
    redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN = "1") THEN
                redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel(STALLENABLE,252)
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg0 <= (others => '0');
            SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg0 <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_toReg0;
            -- Succesor 1
            SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg1 <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed0 <= (not (bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_out) and SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireValid) or SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg0;
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed1 <= (not (SR_SE_i_exitcond_gemm_kernel_backStall) and SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireValid) or SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg1;
    -- Consuming
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_StallValid <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_backStall and SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireValid;
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_toReg0 <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_StallValid and SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed0;
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_toReg1 <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_StallValid and SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed1;
    -- Backward Stall generation
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_or0 <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed0;
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireStall <= not (SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_consumed1 and SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_or0);
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_backStall <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireStall;
    -- Valid signal propagation
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_V0 <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireValid and not (SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg0);
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_V1 <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireValid and not (SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_wireValid <= i_syncbuf_k_sync_buffer5_gemm_kernel_out_valid_out;

    -- SE_i_exitcond_gemm_kernel(STALLENABLE,237)
    -- Valid signal propagation
    SE_i_exitcond_gemm_kernel_V0 <= SE_i_exitcond_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_exitcond_gemm_kernel_s_tv_0 <= SE_i_exitcond_guard_gemm_kernel_backStall and SE_i_exitcond_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_exitcond_gemm_kernel_backEN <= not (SE_i_exitcond_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_exitcond_gemm_kernel_v_s_0 <= SE_i_exitcond_gemm_kernel_backEN and SR_SE_i_exitcond_gemm_kernel_V;
    -- Backward Stall generation
    SE_i_exitcond_gemm_kernel_backStall <= not (SE_i_exitcond_gemm_kernel_backEN);
    SE_i_exitcond_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_exitcond_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_exitcond_gemm_kernel_backEN = "0") THEN
                SE_i_exitcond_gemm_kernel_R_v_0 <= SE_i_exitcond_gemm_kernel_R_v_0 and SE_i_exitcond_gemm_kernel_s_tv_0;
            ELSE
                SE_i_exitcond_gemm_kernel_R_v_0 <= SE_i_exitcond_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_i_exitcond_gemm_kernel(STALLREG,413)
    SR_SE_i_exitcond_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_exitcond_gemm_kernel_r_valid <= (others => '0');
            SR_SE_i_exitcond_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_i_exitcond_gemm_kernel_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_exitcond_gemm_kernel_r_valid <= SE_i_exitcond_gemm_kernel_backStall and (SR_SE_i_exitcond_gemm_kernel_r_valid or SR_SE_i_exitcond_gemm_kernel_i_valid);

            IF (SR_SE_i_exitcond_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_exitcond_gemm_kernel_r_data0 <= STD_LOGIC_VECTOR(redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_q);
                SR_SE_i_exitcond_gemm_kernel_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_k_sync_buffer5_gemm_kernel_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_exitcond_gemm_kernel_and0 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V0;
    SR_SE_i_exitcond_gemm_kernel_i_valid <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_V1 and SR_SE_i_exitcond_gemm_kernel_and0;
    -- Stall signal propagation
    SR_SE_i_exitcond_gemm_kernel_backStall <= SR_SE_i_exitcond_gemm_kernel_r_valid or not (SR_SE_i_exitcond_gemm_kernel_i_valid);

    -- Valid
    SR_SE_i_exitcond_gemm_kernel_V <= SR_SE_i_exitcond_gemm_kernel_r_valid WHEN SR_SE_i_exitcond_gemm_kernel_r_valid = "1" ELSE SR_SE_i_exitcond_gemm_kernel_i_valid;

    -- Data0
    SR_SE_i_exitcond_gemm_kernel_D0 <= SR_SE_i_exitcond_gemm_kernel_r_data0 WHEN SR_SE_i_exitcond_gemm_kernel_r_valid = "1" ELSE redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_q;
    -- Data1
    SR_SE_i_exitcond_gemm_kernel_D1 <= SR_SE_i_exitcond_gemm_kernel_r_data1 WHEN SR_SE_i_exitcond_gemm_kernel_r_valid = "1" ELSE bubble_select_i_syncbuf_k_sync_buffer5_gemm_kernel_b;

    -- SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0(STALLENABLE,303)
    -- Valid signal propagation
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V0 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_0;
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V1 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_1;
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V2 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_2;
    -- Stall signal propagation
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_0 <= SR_SE_i_exitcond_gemm_kernel_backStall and SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_0;
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_1 <= redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_out and SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_1;
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_2 <= SR_SE_redist1_i_arrayidx_gemm_kernel_gemm_kernel27_trunc_sel_x_b_1_0_backStall and SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_2;
    -- Backward Enable generation
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_or0 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_0;
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_or1 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_1 or SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_or0;
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN <= not (SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_2 or SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_or1);
    -- Determine whether to write valid data into the first register stage
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_v_s_0 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN and SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V;
    -- Backward Stall generation
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backStall <= not (SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN);
    SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_0 <= (others => '0');
            SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_1 <= (others => '0');
            SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_2 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN = "0") THEN
                SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_0 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_0 and SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_0;
            ELSE
                SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_0 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_v_s_0;
            END IF;

            IF (SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN = "0") THEN
                SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_1 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_1 and SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_1;
            ELSE
                SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_1 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_v_s_0;
            END IF;

            IF (SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backEN = "0") THEN
                SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_2 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_2 and SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_s_tv_2;
            ELSE
                SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_R_v_2 <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0(STALLREG,412)
    SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid <= (others => '0');
            SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data0 <= (others => '-');
            SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backStall and (SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid or SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_i_valid);

            IF (SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data0 <= STD_LOGIC_VECTOR(bgTrunc_i_inc_gemm_kernel_sel_x_b);
                SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data1 <= STD_LOGIC_VECTOR(bgTrunc_i_add_gemm_kernel_sel_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_i_valid <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_V0;
    -- Stall signal propagation
    SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backStall <= SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid or not (SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_i_valid);

    -- Valid
    SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V <= SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid WHEN SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid = "1" ELSE SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_i_valid;

    -- Data0
    SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_D0 <= SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data0 WHEN SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid = "1" ELSE bgTrunc_i_inc_gemm_kernel_sel_x_b;
    -- Data1
    SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_D1 <= SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_data1 WHEN SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_r_valid = "1" ELSE bgTrunc_i_add_gemm_kernel_sel_x_b;

    -- SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6(STALLENABLE,281)
    -- Valid signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_V0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_0;
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_V1 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_1;
    -- Stall signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_0 <= SR_SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_backStall and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_0;
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_1 <= redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_out and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_1;
    -- Backward Enable generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_or0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_0;
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backEN <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_1 or SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_or0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_v_s_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backEN and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_V0;
    -- Backward Stall generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backStall <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_v_s_0);
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_0 <= (others => '0');
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_0 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_0;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_v_s_0;
            END IF;

            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_1 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_1 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_s_tv_1;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_R_v_1 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5(STALLENABLE,280)
    -- Valid signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_V0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_R_v_0;
    -- Stall signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_s_tv_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_backStall and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_R_v_0;
    -- Backward Enable generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backEN <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_v_s_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backEN and SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_V;
    -- Backward Stall generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backStall <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backEN);
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_R_v_0 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_s_tv_0;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5(STALLREG,411)
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid <= (others => '0');
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data0 <= (others => '-');
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backStall and (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid or SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_i_valid);

            IF (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data0 <= STD_LOGIC_VECTOR(redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_q);
                SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data1 <= STD_LOGIC_VECTOR(redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_4_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_i_valid <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_V0;
    -- Stall signal propagation
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backStall <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid or not (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_i_valid);

    -- Valid
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_V <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid = "1" ELSE SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_i_valid;

    -- Data0
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_D0 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data0 WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid = "1" ELSE redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_q;
    -- Data1
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_D1 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_data1 WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_r_valid = "1" ELSE redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_4_q;

    -- SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4(STALLENABLE,279)
    -- Valid signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_V0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_R_v_0;
    -- Stall signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_s_tv_0 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_5_backStall and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_R_v_0;
    -- Backward Enable generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backEN <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_v_s_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backEN and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_V0;
    -- Backward Stall generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backStall <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_v_s_0);
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_R_v_0 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_s_tv_0;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3(STALLENABLE,278)
    -- Valid signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_V0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_R_v_0;
    -- Stall signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_s_tv_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_4_backStall and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_R_v_0;
    -- Backward Enable generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backEN <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_v_s_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backEN and SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_V;
    -- Backward Stall generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backStall <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backEN);
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_R_v_0 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_s_tv_0;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3(STALLREG,410)
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid <= (others => '0');
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data0 <= (others => '-');
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backStall and (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid or SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_i_valid);

            IF (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data0 <= STD_LOGIC_VECTOR(redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_q);
                SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data1 <= STD_LOGIC_VECTOR(redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_2_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_i_valid <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_V0;
    -- Stall signal propagation
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backStall <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid or not (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_i_valid);

    -- Valid
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_V <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid = "1" ELSE SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_i_valid;

    -- Data0
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_D0 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data0 WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid = "1" ELSE redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_q;
    -- Data1
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_D1 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_data1 WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_r_valid = "1" ELSE redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_2_q;

    -- SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2(STALLENABLE,277)
    -- Valid signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_V0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_R_v_0;
    -- Stall signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_s_tv_0 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_3_backStall and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_R_v_0;
    -- Backward Enable generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backEN <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_v_s_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backEN and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_V0;
    -- Backward Stall generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backStall <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_v_s_0);
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_R_v_0 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_s_tv_0;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1(STALLENABLE,276)
    -- Valid signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_V0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_R_v_0;
    -- Stall signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_s_tv_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_2_backStall and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_R_v_0;
    -- Backward Enable generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backEN <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_v_s_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backEN and SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_V;
    -- Backward Stall generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backStall <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backEN);
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_R_v_0 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_s_tv_0;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1(STALLREG,409)
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid <= (others => '0');
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data0 <= (others => '-');
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backStall and (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid or SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_i_valid);

            IF (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data0 <= STD_LOGIC_VECTOR(redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_q);
                SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data1 <= STD_LOGIC_VECTOR(redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_0_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_i_valid <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_V0;
    -- Stall signal propagation
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backStall <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid or not (SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_i_valid);

    -- Valid
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_V <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid = "1" ELSE SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_i_valid;

    -- Data0
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_D0 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data0 WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid = "1" ELSE redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_q;
    -- Data1
    SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_D1 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_data1 WHEN SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_r_valid = "1" ELSE redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_0_q;

    -- SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0(STALLENABLE,275)
    -- Valid signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_V0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_R_v_0;
    -- Stall signal propagation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_s_tv_0 <= SR_SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_1_backStall and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_R_v_0;
    -- Backward Enable generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backEN <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_v_s_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backEN and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V5;
    -- Backward Stall generation
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backStall <= not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_v_s_0);
    SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backEN = "0") THEN
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_R_v_0 and SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_s_tv_0;
            ELSE
                SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_R_v_0 <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg(STALLFIFO,407)
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V4;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_in <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_backStall;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_out_bitsignaltemp;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_out_bitsignaltemp;
    thebubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 9,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg(STALLFIFO,406)
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V3;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_in <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_backStall;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_out_bitsignaltemp;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_out_bitsignaltemp;
    thebubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 9,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg(STALLFIFO,404)
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V1;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_in <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_backStall;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_out_bitsignaltemp;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_out_bitsignaltemp;
    thebubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 9,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg(STALLFIFO,403)
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V0;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_in <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_backStall;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp;
    thebubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 10,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_stall_entry(STALLENABLE,259)
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid;
    -- Backward Stall generation
    SE_stall_entry_backStall <= gemm_kernel_B1_merge_reg_aunroll_x_out_stall_out or not (SE_stall_entry_wireValid);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- bubble_join_stall_entry(BITJOIN,192)
    bubble_join_stall_entry_q <= in_sum_04 & in_k_05 & in_global_id_16 & in_global_id_04 & in_c0_exe11 & in_acl_hw_wg_id8;

    -- bubble_select_stall_entry(BITSELECT,193)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(31 downto 0));
    bubble_select_stall_entry_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(63 downto 32));
    bubble_select_stall_entry_d <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(95 downto 64));
    bubble_select_stall_entry_e <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(127 downto 96));
    bubble_select_stall_entry_f <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(159 downto 128));
    bubble_select_stall_entry_g <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(191 downto 160));

    -- gemm_kernel_B1_merge_reg_aunroll_x(BLACKBOX,31)@0
    -- in in_stall_in@20000000
    -- out out_data_out_0@1
    -- out out_data_out_1@1
    -- out out_data_out_2@1
    -- out out_data_out_3@1
    -- out out_data_out_4@1
    -- out out_data_out_5@1
    -- out out_stall_out@20000000
    -- out out_valid_out@1
    thegemm_kernel_B1_merge_reg_aunroll_x : gemm_kernel_B1_merge_reg
    PORT MAP (
        in_data_in_0 => bubble_select_stall_entry_f,
        in_data_in_1 => bubble_select_stall_entry_g,
        in_data_in_2 => bubble_select_stall_entry_c,
        in_data_in_3 => bubble_select_stall_entry_d,
        in_data_in_4 => bubble_select_stall_entry_e,
        in_data_in_5 => bubble_select_stall_entry_b,
        in_stall_in => SE_out_gemm_kernel_B1_merge_reg_aunroll_x_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_data_out_0 => gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0,
        out_data_out_1 => gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1,
        out_data_out_2 => gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2,
        out_data_out_3 => gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3,
        out_data_out_4 => gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4,
        out_data_out_5 => gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5,
        out_stall_out => gemm_kernel_B1_merge_reg_aunroll_x_out_stall_out,
        out_valid_out => gemm_kernel_B1_merge_reg_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_gemm_kernel_B1_merge_reg_aunroll_x(STALLENABLE,225)
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg0 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg1 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg2 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg3 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg4 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg5 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg6 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg7 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg8 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg9 <= (others => '0');
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg10 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg0 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg0;
            -- Succesor 1
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg1 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg1;
            -- Succesor 2
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg2 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg2;
            -- Succesor 3
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg3 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg3;
            -- Succesor 4
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg4 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg4;
            -- Succesor 5
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg5 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg5;
            -- Succesor 6
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg6 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg6;
            -- Succesor 7
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg7 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg7;
            -- Succesor 8
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg8 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg8;
            -- Succesor 9
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg9 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg9;
            -- Succesor 10
            SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg10 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg10;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed0 <= (not (bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_1_reg_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg0;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed1 <= (not (bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_2_reg_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg1;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed2 <= (not (bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg2;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed3 <= (not (bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_4_reg_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg3;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed4 <= (not (bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_5_reg_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg4;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed5 <= (not (SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_0_backStall) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg5;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed6 <= (not (i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_o_stall) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg6;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed7 <= (not (redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg7;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed8 <= (not (redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg8;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed9 <= (not (redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg9;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed10 <= (not (redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_out) and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid) or SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg10;
    -- Consuming
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_backStall and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg0 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed0;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg1 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed1;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg2 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed2;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg3 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed3;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg4 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed4;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg5 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed5;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg6 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed6;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg7 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed7;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg8 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed8;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg9 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed9;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_toReg10 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_StallValid and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed10;
    -- Backward Stall generation
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or0 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed0;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or1 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed1 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or0;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or2 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed2 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or1;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or3 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed3 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or2;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or4 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed4 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or3;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or5 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed5 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or4;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or6 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed6 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or5;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or7 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed7 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or6;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or8 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed8 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or7;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or9 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed9 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or8;
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireStall <= not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_consumed10 and SE_out_gemm_kernel_B1_merge_reg_aunroll_x_or9);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_backStall <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireStall;
    -- Valid signal propagation
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V0 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg0);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V1 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg1);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V2 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg2);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V3 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg3);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V4 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg4);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V5 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg5);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V6 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg6);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V7 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg7);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V8 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg8);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V9 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg9);
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V10 <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid and not (SE_out_gemm_kernel_B1_merge_reg_aunroll_x_fromReg10);
    -- Computing multiple Valid(s)
    SE_out_gemm_kernel_B1_merge_reg_aunroll_x_wireValid <= gemm_kernel_B1_merge_reg_aunroll_x_out_valid_out;

    -- bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg(STALLFIFO,405)
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V2;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_in <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_backStall;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_in_bitsignaltemp <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_in(0);
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_out_bitsignaltemp;
    bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_out(0) <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_out_bitsignaltemp;
    thebubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 9,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3(STALLENABLE,316)
    -- Valid signal propagation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_V0 <= SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_backStall <= i_syncbuf_m_sync_buffer_gemm_kernel_out_stall_out or not (SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_wireValid <= bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_reg_valid_out;

    -- i_syncbuf_m_sync_buffer_gemm_kernel(BLACKBOX,70)@9
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_m_sync_buffer_gemm_kernel : i_syncbuf_m_sync_buffer_gemm_kernel9
    PORT MAP (
        in_buffer_in => in_M,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_backStall,
        in_valid_in => SE_out_bubble_out_gemm_kernel_B1_merge_reg_aunroll_x_3_V0,
        out_buffer_out => i_syncbuf_m_sync_buffer_gemm_kernel_out_buffer_out,
        out_stall_out => i_syncbuf_m_sync_buffer_gemm_kernel_out_stall_out,
        out_valid_out => i_syncbuf_m_sync_buffer_gemm_kernel_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_m_sync_buffer_gemm_kernel(BITJOIN,186)
    bubble_join_i_syncbuf_m_sync_buffer_gemm_kernel_q <= i_syncbuf_m_sync_buffer_gemm_kernel_out_buffer_out;

    -- bubble_select_i_syncbuf_m_sync_buffer_gemm_kernel(BITSELECT,187)
    bubble_select_i_syncbuf_m_sync_buffer_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_m_sync_buffer_gemm_kernel_q(31 downto 0));

    -- bubble_join_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo(BITJOIN,205)
    bubble_join_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_q <= redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_data_out;

    -- bubble_select_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo(BITSELECT,206)
    bubble_select_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_q(31 downto 0));

    -- SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo(STALLENABLE,294)
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg0 <= (others => '0');
            SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg0 <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_toReg0;
            -- Succesor 1
            SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg1 <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed0 <= (not (SR_SE_i_notlhs_gemm_kernel_backStall) and SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireValid) or SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg0;
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed1 <= (not (redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_out) and SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireValid) or SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg1;
    -- Consuming
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_StallValid <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_backStall and SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireValid;
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_toReg0 <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_StallValid and SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed0;
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_toReg1 <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_StallValid and SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed1;
    -- Backward Stall generation
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_or0 <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed0;
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireStall <= not (SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_consumed1 and SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_or0);
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_backStall <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireStall;
    -- Valid signal propagation
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_V0 <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireValid and not (SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg0);
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_V1 <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireValid and not (SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_wireValid <= redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_valid_out;

    -- SE_out_i_syncbuf_m_sync_buffer_gemm_kernel(STALLENABLE,256)
    -- Valid signal propagation
    SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_V0 <= SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_backStall <= SR_SE_i_notlhs_gemm_kernel_backStall or not (SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_wireValid <= i_syncbuf_m_sync_buffer_gemm_kernel_out_valid_out;

    -- SR_SE_i_notlhs_gemm_kernel(STALLREG,414)
    SR_SE_i_notlhs_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_notlhs_gemm_kernel_r_valid <= (others => '0');
            SR_SE_i_notlhs_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_i_notlhs_gemm_kernel_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_notlhs_gemm_kernel_r_valid <= SE_i_notlhs_gemm_kernel_backStall and (SR_SE_i_notlhs_gemm_kernel_r_valid or SR_SE_i_notlhs_gemm_kernel_i_valid);

            IF (SR_SE_i_notlhs_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_notlhs_gemm_kernel_r_data0 <= STD_LOGIC_VECTOR(bubble_select_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_b);
                SR_SE_i_notlhs_gemm_kernel_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_m_sync_buffer_gemm_kernel_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_notlhs_gemm_kernel_and0 <= SE_out_i_syncbuf_m_sync_buffer_gemm_kernel_V0;
    SR_SE_i_notlhs_gemm_kernel_i_valid <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_V0 and SR_SE_i_notlhs_gemm_kernel_and0;
    -- Stall signal propagation
    SR_SE_i_notlhs_gemm_kernel_backStall <= SR_SE_i_notlhs_gemm_kernel_r_valid or not (SR_SE_i_notlhs_gemm_kernel_i_valid);

    -- Valid
    SR_SE_i_notlhs_gemm_kernel_V <= SR_SE_i_notlhs_gemm_kernel_r_valid WHEN SR_SE_i_notlhs_gemm_kernel_r_valid = "1" ELSE SR_SE_i_notlhs_gemm_kernel_i_valid;

    -- Data0
    SR_SE_i_notlhs_gemm_kernel_D0 <= SR_SE_i_notlhs_gemm_kernel_r_data0 WHEN SR_SE_i_notlhs_gemm_kernel_r_valid = "1" ELSE bubble_select_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_b;
    -- Data1
    SR_SE_i_notlhs_gemm_kernel_D1 <= SR_SE_i_notlhs_gemm_kernel_r_data1 WHEN SR_SE_i_notlhs_gemm_kernel_r_valid = "1" ELSE bubble_select_i_syncbuf_m_sync_buffer_gemm_kernel_b;

    -- i_notlhs_gemm_kernel(COMPARE,63)@9 + 1
    i_notlhs_gemm_kernel_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_notlhs_gemm_kernel_D0(31)) & SR_SE_i_notlhs_gemm_kernel_D0));
    i_notlhs_gemm_kernel_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_notlhs_gemm_kernel_D1(31)) & SR_SE_i_notlhs_gemm_kernel_D1));
    i_notlhs_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_notlhs_gemm_kernel_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_notlhs_gemm_kernel_backEN = "1") THEN
                i_notlhs_gemm_kernel_o <= STD_LOGIC_VECTOR(SIGNED(i_notlhs_gemm_kernel_a) - SIGNED(i_notlhs_gemm_kernel_b));
            END IF;
        END IF;
    END PROCESS;
    i_notlhs_gemm_kernel_n(0) <= not (i_notlhs_gemm_kernel_o(33));

    -- i_notrhs_gemm_kernel(COMPARE,64)@9 + 1
    i_notrhs_gemm_kernel_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_notrhs_gemm_kernel_D0(31)) & SR_SE_i_notrhs_gemm_kernel_D0));
    i_notrhs_gemm_kernel_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_notrhs_gemm_kernel_D1(31)) & SR_SE_i_notrhs_gemm_kernel_D1));
    i_notrhs_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_notrhs_gemm_kernel_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_notrhs_gemm_kernel_backEN = "1") THEN
                i_notrhs_gemm_kernel_o <= STD_LOGIC_VECTOR(SIGNED(i_notrhs_gemm_kernel_a) - SIGNED(i_notrhs_gemm_kernel_b));
            END IF;
        END IF;
    END PROCESS;
    i_notrhs_gemm_kernel_n(0) <= not (i_notrhs_gemm_kernel_o(33));

    -- i_or_cond_neg_rm_gemm_kernel(LOGICAL,66)@10
    i_or_cond_neg_rm_gemm_kernel_q <= i_notrhs_gemm_kernel_n or i_notlhs_gemm_kernel_n;

    -- i_exitcond_gemm_kernel(LOGICAL,55)@9 + 1
    i_exitcond_gemm_kernel_qi <= "1" WHEN SR_SE_i_exitcond_gemm_kernel_D0 = SR_SE_i_exitcond_gemm_kernel_D1 ELSE "0";
    i_exitcond_gemm_kernel_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_exitcond_gemm_kernel_qi, xout => i_exitcond_gemm_kernel_q, ena => SE_i_exitcond_gemm_kernel_backEN(0), clk => clock, aclr => resetn );

    -- i_exitcond_guard_gemm_kernel(LOGICAL,56)@10
    i_exitcond_guard_gemm_kernel_q <= i_exitcond_gemm_kernel_q or i_cmp63_neg_rm_gemm_kernel_c;

    -- SE_i_or_cond_neg_rm_gemm_kernel(STALLENABLE,248)
    SE_i_or_cond_neg_rm_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_or_cond_neg_rm_gemm_kernel_fromReg0 <= (others => '0');
            SE_i_or_cond_neg_rm_gemm_kernel_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_i_or_cond_neg_rm_gemm_kernel_fromReg0 <= SE_i_or_cond_neg_rm_gemm_kernel_toReg0;
            -- Succesor 1
            SE_i_or_cond_neg_rm_gemm_kernel_fromReg1 <= SE_i_or_cond_neg_rm_gemm_kernel_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_i_or_cond_neg_rm_gemm_kernel_consumed0 <= (not (SR_SE_i_exitcond_guard_guard_gemm_kernel_backStall) and SE_i_or_cond_neg_rm_gemm_kernel_wireValid) or SE_i_or_cond_neg_rm_gemm_kernel_fromReg0;
    SE_i_or_cond_neg_rm_gemm_kernel_consumed1 <= (not (SE_i_or_cond_neg_or_rm_gemm_kernel_backStall) and SE_i_or_cond_neg_rm_gemm_kernel_wireValid) or SE_i_or_cond_neg_rm_gemm_kernel_fromReg1;
    -- Consuming
    SE_i_or_cond_neg_rm_gemm_kernel_StallValid <= SE_i_or_cond_neg_rm_gemm_kernel_backStall and SE_i_or_cond_neg_rm_gemm_kernel_wireValid;
    SE_i_or_cond_neg_rm_gemm_kernel_toReg0 <= SE_i_or_cond_neg_rm_gemm_kernel_StallValid and SE_i_or_cond_neg_rm_gemm_kernel_consumed0;
    SE_i_or_cond_neg_rm_gemm_kernel_toReg1 <= SE_i_or_cond_neg_rm_gemm_kernel_StallValid and SE_i_or_cond_neg_rm_gemm_kernel_consumed1;
    -- Backward Stall generation
    SE_i_or_cond_neg_rm_gemm_kernel_or0 <= SE_i_or_cond_neg_rm_gemm_kernel_consumed0;
    SE_i_or_cond_neg_rm_gemm_kernel_wireStall <= not (SE_i_or_cond_neg_rm_gemm_kernel_consumed1 and SE_i_or_cond_neg_rm_gemm_kernel_or0);
    SE_i_or_cond_neg_rm_gemm_kernel_backStall <= SE_i_or_cond_neg_rm_gemm_kernel_wireStall;
    -- Valid signal propagation
    SE_i_or_cond_neg_rm_gemm_kernel_V0 <= SE_i_or_cond_neg_rm_gemm_kernel_wireValid and not (SE_i_or_cond_neg_rm_gemm_kernel_fromReg0);
    SE_i_or_cond_neg_rm_gemm_kernel_V1 <= SE_i_or_cond_neg_rm_gemm_kernel_wireValid and not (SE_i_or_cond_neg_rm_gemm_kernel_fromReg1);
    -- Computing multiple Valid(s)
    SE_i_or_cond_neg_rm_gemm_kernel_and0 <= SE_i_notlhs_gemm_kernel_V0;
    SE_i_or_cond_neg_rm_gemm_kernel_wireValid <= SE_i_notrhs_gemm_kernel_V0 and SE_i_or_cond_neg_rm_gemm_kernel_and0;

    -- SE_i_exitcond_guard_gemm_kernel(STALLENABLE,238)
    -- Valid signal propagation
    SE_i_exitcond_guard_gemm_kernel_V0 <= SE_i_exitcond_guard_gemm_kernel_wireValid;
    -- Backward Stall generation
    SE_i_exitcond_guard_gemm_kernel_backStall <= SR_SE_i_exitcond_guard_guard_gemm_kernel_backStall or not (SE_i_exitcond_guard_gemm_kernel_wireValid);
    -- Computing multiple Valid(s)
    SE_i_exitcond_guard_gemm_kernel_and0 <= SE_i_cmp63_neg_rm_gemm_kernel_V0;
    SE_i_exitcond_guard_gemm_kernel_wireValid <= SE_i_exitcond_gemm_kernel_V0 and SE_i_exitcond_guard_gemm_kernel_and0;

    -- SR_SE_i_exitcond_guard_guard_gemm_kernel(STALLREG,416)
    SR_SE_i_exitcond_guard_guard_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid <= (others => '0');
            SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data0 <= (others => '-');
            SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid <= SE_i_exitcond_guard_guard_gemm_kernel_backStall and (SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid or SR_SE_i_exitcond_guard_guard_gemm_kernel_i_valid);

            IF (SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data0 <= i_exitcond_guard_gemm_kernel_q;
                SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data1 <= i_or_cond_neg_rm_gemm_kernel_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_exitcond_guard_guard_gemm_kernel_and0 <= SE_i_exitcond_guard_gemm_kernel_V0;
    SR_SE_i_exitcond_guard_guard_gemm_kernel_i_valid <= SE_i_or_cond_neg_rm_gemm_kernel_V0 and SR_SE_i_exitcond_guard_guard_gemm_kernel_and0;
    -- Stall signal propagation
    SR_SE_i_exitcond_guard_guard_gemm_kernel_backStall <= SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid or not (SR_SE_i_exitcond_guard_guard_gemm_kernel_i_valid);

    -- Valid
    SR_SE_i_exitcond_guard_guard_gemm_kernel_V <= SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid WHEN SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid = "1" ELSE SR_SE_i_exitcond_guard_guard_gemm_kernel_i_valid;

    -- Data0
    SR_SE_i_exitcond_guard_guard_gemm_kernel_D0 <= SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data0 WHEN SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid = "1" ELSE i_exitcond_guard_gemm_kernel_q;
    -- Data1
    SR_SE_i_exitcond_guard_guard_gemm_kernel_D1 <= SR_SE_i_exitcond_guard_guard_gemm_kernel_r_data1 WHEN SR_SE_i_exitcond_guard_guard_gemm_kernel_r_valid = "1" ELSE i_or_cond_neg_rm_gemm_kernel_q;

    -- i_exitcond_guard_guard_gemm_kernel(LOGICAL,57)@10 + 1
    i_exitcond_guard_guard_gemm_kernel_qi <= SR_SE_i_exitcond_guard_guard_gemm_kernel_D0 or SR_SE_i_exitcond_guard_guard_gemm_kernel_D1;
    i_exitcond_guard_guard_gemm_kernel_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_exitcond_guard_guard_gemm_kernel_qi, xout => i_exitcond_guard_guard_gemm_kernel_q, ena => SE_i_exitcond_guard_guard_gemm_kernel_backEN(0), clk => clock, aclr => resetn );

    -- SE_i_exitcond_guard_guard_gemm_kernel(STALLENABLE,239)
    -- Valid signal propagation
    SE_i_exitcond_guard_guard_gemm_kernel_V0 <= SE_i_exitcond_guard_guard_gemm_kernel_R_v_0;
    -- Stall signal propagation
    SE_i_exitcond_guard_guard_gemm_kernel_s_tv_0 <= redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_out and SE_i_exitcond_guard_guard_gemm_kernel_R_v_0;
    -- Backward Enable generation
    SE_i_exitcond_guard_guard_gemm_kernel_backEN <= not (SE_i_exitcond_guard_guard_gemm_kernel_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_exitcond_guard_guard_gemm_kernel_v_s_0 <= SE_i_exitcond_guard_guard_gemm_kernel_backEN and SR_SE_i_exitcond_guard_guard_gemm_kernel_V;
    -- Backward Stall generation
    SE_i_exitcond_guard_guard_gemm_kernel_backStall <= not (SE_i_exitcond_guard_guard_gemm_kernel_backEN);
    SE_i_exitcond_guard_guard_gemm_kernel_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_exitcond_guard_guard_gemm_kernel_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_exitcond_guard_guard_gemm_kernel_backEN = "0") THEN
                SE_i_exitcond_guard_guard_gemm_kernel_R_v_0 <= SE_i_exitcond_guard_guard_gemm_kernel_R_v_0 and SE_i_exitcond_guard_guard_gemm_kernel_s_tv_0;
            ELSE
                SE_i_exitcond_guard_guard_gemm_kernel_R_v_0 <= SE_i_exitcond_guard_guard_gemm_kernel_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo(STALLFIFO,128)
    redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_in <= SE_i_exitcond_guard_guard_gemm_kernel_V0;
    redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall;
    redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_data_in <= i_exitcond_guard_guard_gemm_kernel_q;
    redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_in_bitsignaltemp <= redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_in(0);
    redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_in_bitsignaltemp <= redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_in(0);
    redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_out(0) <= redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_out_bitsignaltemp;
    redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_out(0) <= redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_out_bitsignaltemp;
    theredist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 175,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_in_bitsignaltemp,
        stall_in => redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_in_bitsignaltemp,
        data_in => i_exitcond_guard_guard_gemm_kernel_q,
        valid_out => redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_out_bitsignaltemp,
        stall_out => redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_stall_out_bitsignaltemp,
        data_out => redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo(STALLFIFO,145)
    redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_in <= SE_redist2_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_0_7_6_V1;
    redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall;
    redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_data_in <= redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6_q;
    redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_in_bitsignaltemp <= redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_in(0);
    redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_in_bitsignaltemp <= redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_in(0);
    redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_out(0) <= redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_out_bitsignaltemp;
    redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_out(0) <= redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_out_bitsignaltemp;
    theredist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 178,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_in_bitsignaltemp,
        stall_in => redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_in_bitsignaltemp,
        data_in => redist4_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_7_6_q,
        valid_out => redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_out_bitsignaltemp,
        stall_out => redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_stall_out_bitsignaltemp,
        data_out => redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo(STALLFIFO,147)
    redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_in <= SE_out_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_V1;
    redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall;
    redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_data_in <= bubble_select_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_b;
    redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_in_bitsignaltemp <= redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_in(0);
    redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_in_bitsignaltemp <= redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_in(0);
    redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_out(0) <= redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_out_bitsignaltemp;
    redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_out(0) <= redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_out_bitsignaltemp;
    theredist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 177,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_in_bitsignaltemp,
        stall_in => redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_redist6_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_8_fifo_b,
        valid_out => redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_out_bitsignaltemp,
        stall_out => redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_stall_out_bitsignaltemp,
        data_out => redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo(STALLFIFO,149)
    redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_in <= SE_out_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_V1;
    redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall;
    redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_data_in <= bubble_select_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_b;
    redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_in_bitsignaltemp <= redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_in(0);
    redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_in_bitsignaltemp <= redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_in(0);
    redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_out(0) <= redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_out_bitsignaltemp;
    redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_out(0) <= redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_out_bitsignaltemp;
    theredist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 177,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_in_bitsignaltemp,
        stall_in => redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_redist8_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_8_fifo_b,
        valid_out => redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_out_bitsignaltemp,
        stall_out => redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_stall_out_bitsignaltemp,
        data_out => redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo(STALLFIFO,150)
    redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V10;
    redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall;
    redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_data_in <= bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_g;
    redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_in_bitsignaltemp <= redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_in(0);
    redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_in_bitsignaltemp <= redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_in(0);
    redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_out(0) <= redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_out_bitsignaltemp;
    redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_out(0) <= redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_out_bitsignaltemp;
    theredist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 185,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_in_bitsignaltemp,
        stall_in => redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_g,
        valid_out => redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_out_bitsignaltemp,
        stall_out => redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_stall_out_bitsignaltemp,
        data_out => redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo(STALLFIFO,152)
    redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_in <= SE_redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_V1;
    redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall;
    redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_data_in <= redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_q;
    redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_in_bitsignaltemp <= redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_in(0);
    redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_in_bitsignaltemp <= redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_in(0);
    redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_out(0) <= redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_out_bitsignaltemp;
    redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_out(0) <= redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_out_bitsignaltemp;
    theredist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 177,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_in_bitsignaltemp,
        stall_in => redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_in_bitsignaltemp,
        data_in => redist11_bgTrunc_i_inc_gemm_kernel_sel_x_b_1_0_q,
        valid_out => redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_out_bitsignaltemp,
        stall_out => redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_stall_out_bitsignaltemp,
        data_out => redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg(STALLFIFO,408)
    bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_in <= SE_out_i_syncbuf_k_sync_buffer5_gemm_kernel_V0;
    bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_in <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall;
    bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_in_bitsignaltemp <= bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_in(0);
    bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_in_bitsignaltemp <= bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_in(0);
    bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_out(0) <= bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_out_bitsignaltemp;
    bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_out(0) <= bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_out_bitsignaltemp;
    thebubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 177,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1(STALLENABLE,348)
    -- Valid signal propagation
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_V0 <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall <= in_stall_in or not (SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and0 <= bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_reg_valid_out;
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and1 <= redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_valid_out and SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and0;
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and2 <= redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_valid_out and SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and1;
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and3 <= redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_valid_out and SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and2;
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and4 <= redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_valid_out and SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and3;
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and5 <= redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_valid_out and SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and4;
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and6 <= redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_valid_out and SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and5;
    SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_wireValid <= i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_o_valid and SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_and6;

    -- bubble_join_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo(BITJOIN,199)
    bubble_join_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_q <= redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_data_out;

    -- bubble_select_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo(BITSELECT,200)
    bubble_select_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_q(31 downto 0));

    -- bubble_join_i_load_unnamed_gemm_kernel1_gemm_kernel(BITJOIN,173)
    bubble_join_i_load_unnamed_gemm_kernel1_gemm_kernel_q <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_readdata;

    -- bubble_select_i_load_unnamed_gemm_kernel1_gemm_kernel(BITSELECT,174)
    bubble_select_i_load_unnamed_gemm_kernel1_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_load_unnamed_gemm_kernel1_gemm_kernel_q(31 downto 0));

    -- bubble_join_i_load_unnamed_gemm_kernel0_gemm_kernel(BITJOIN,170)
    bubble_join_i_load_unnamed_gemm_kernel0_gemm_kernel_q <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_readdata;

    -- bubble_select_i_load_unnamed_gemm_kernel0_gemm_kernel(BITSELECT,171)
    bubble_select_i_load_unnamed_gemm_kernel0_gemm_kernel_b <= STD_LOGIC_VECTOR(bubble_join_i_load_unnamed_gemm_kernel0_gemm_kernel_q(31 downto 0));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x(BLACKBOX,44)@160
    -- in in_i_stall@20000000
    -- out out_c1_exit_0@185
    -- out out_c1_exit_1@185
    -- out out_o_stall@20000000
    -- out out_o_valid@185
    thei_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x : i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel
    PORT MAP (
        in_c1_eni3_0 => GND_q,
        in_c1_eni3_1 => bubble_select_i_load_unnamed_gemm_kernel0_gemm_kernel_b,
        in_c1_eni3_2 => bubble_select_i_load_unnamed_gemm_kernel1_gemm_kernel_b,
        in_c1_eni3_3 => bubble_select_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_b,
        in_i_stall => SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_backStall,
        in_i_valid => SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_V0,
        out_c1_exit_1 => i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_c1_exit_1,
        out_o_stall => i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- i_load_unnamed_gemm_kernel0_gemm_kernel(BLACKBOX,61)@10
    -- in in_i_stall@20000000
    -- out out_o_readdata@160
    -- out out_o_stall@20000000
    -- out out_o_valid@160
    -- out out_unnamed_gemm_kernel0_avm_address@20000000
    -- out out_unnamed_gemm_kernel0_avm_burstcount@20000000
    -- out out_unnamed_gemm_kernel0_avm_byteenable@20000000
    -- out out_unnamed_gemm_kernel0_avm_enable@20000000
    -- out out_unnamed_gemm_kernel0_avm_read@20000000
    -- out out_unnamed_gemm_kernel0_avm_write@20000000
    -- out out_unnamed_gemm_kernel0_avm_writedata@20000000
    thei_load_unnamed_gemm_kernel0_gemm_kernel : i_load_unnamed_gemm_kernel0_gemm_kernel28
    PORT MAP (
        in_flush => in_flush,
        in_i_address => SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_D0,
        in_i_predicate => SR_SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_D1,
        in_i_stall => SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_backStall,
        in_i_valid => SE_out_i_syncbuf_a_sync_buffer_gemm_kernel_V0,
        in_unnamed_gemm_kernel0_avm_readdata => in_unnamed_gemm_kernel0_avm_readdata,
        in_unnamed_gemm_kernel0_avm_readdatavalid => in_unnamed_gemm_kernel0_avm_readdatavalid,
        in_unnamed_gemm_kernel0_avm_waitrequest => in_unnamed_gemm_kernel0_avm_waitrequest,
        in_unnamed_gemm_kernel0_avm_writeack => in_unnamed_gemm_kernel0_avm_writeack,
        out_o_readdata => i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_readdata,
        out_o_stall => i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_stall,
        out_o_valid => i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_valid,
        out_unnamed_gemm_kernel0_avm_address => i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_address,
        out_unnamed_gemm_kernel0_avm_burstcount => i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_burstcount,
        out_unnamed_gemm_kernel0_avm_byteenable => i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_byteenable,
        out_unnamed_gemm_kernel0_avm_enable => i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_enable,
        out_unnamed_gemm_kernel0_avm_read => i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_read,
        out_unnamed_gemm_kernel0_avm_write => i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_write,
        out_unnamed_gemm_kernel0_avm_writedata => i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo(STALLFIFO,137)
    redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_in <= SE_out_gemm_kernel_B1_merge_reg_aunroll_x_V7;
    redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_in <= SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_backStall;
    redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_data_in <= bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_c;
    redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_in_bitsignaltemp <= redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_in(0);
    redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_in_bitsignaltemp <= redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_in(0);
    redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_out(0) <= redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_out_bitsignaltemp;
    redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_out(0) <= redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_out_bitsignaltemp;
    theredist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 160,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_in_bitsignaltemp,
        stall_in => redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_gemm_kernel_B1_merge_reg_aunroll_x_c,
        valid_out => redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_out_bitsignaltemp,
        stall_out => redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_stall_out_bitsignaltemp,
        data_out => redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo(STALLENABLE,283)
    -- Valid signal propagation
    SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_V0 <= SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_backStall <= i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_o_stall or not (SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_and0 <= redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_valid_out;
    SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_and1 <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_valid and SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_and0;
    SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_wireValid <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_o_valid and SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_and1;

    -- bubble_join_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x(BITJOIN,163)
    bubble_join_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_q <= i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_c0_exit16_1;

    -- bubble_select_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x(BITSELECT,164)
    bubble_select_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_q(63 downto 0));

    -- SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x(STALLREG,417)
    SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid <= (others => '0');
            SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data0 <= (others => '-');
            SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid <= SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_backStall and (SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid or SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_i_valid);

            IF (SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid = "0") THEN
                -- Data(s)
                SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data0 <= bubble_select_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_b;
                SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data1 <= i_or_cond_neg_or_rm_gemm_kernel_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_and0 <= i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_out_o_valid;
    SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_i_valid <= SE_i_or_cond_neg_or_rm_gemm_kernel_V1 and SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_and0;
    -- Stall signal propagation
    SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_backStall <= SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid or not (SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_i_valid);

    -- Valid
    SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_V <= SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid WHEN SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid = "1" ELSE SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_i_valid;

    -- Data0
    SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_D0 <= SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data0 WHEN SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid = "1" ELSE bubble_select_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_b;
    -- Data1
    SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_D1 <= SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_data1 WHEN SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_r_valid = "1" ELSE i_or_cond_neg_or_rm_gemm_kernel_q;

    -- i_load_unnamed_gemm_kernel1_gemm_kernel(BLACKBOX,62)@10
    -- in in_i_stall@20000000
    -- out out_o_readdata@160
    -- out out_o_stall@20000000
    -- out out_o_valid@160
    -- out out_unnamed_gemm_kernel1_avm_address@20000000
    -- out out_unnamed_gemm_kernel1_avm_burstcount@20000000
    -- out out_unnamed_gemm_kernel1_avm_byteenable@20000000
    -- out out_unnamed_gemm_kernel1_avm_enable@20000000
    -- out out_unnamed_gemm_kernel1_avm_read@20000000
    -- out out_unnamed_gemm_kernel1_avm_write@20000000
    -- out out_unnamed_gemm_kernel1_avm_writedata@20000000
    thei_load_unnamed_gemm_kernel1_gemm_kernel : i_load_unnamed_gemm_kernel1_gemm_kernel30
    PORT MAP (
        in_flush => in_flush,
        in_i_address => SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_D0,
        in_i_predicate => SR_SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_D1,
        in_i_stall => SE_out_redist3_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_1_159_fifo_backStall,
        in_i_valid => SE_out_i_sfc_c0_for_body_gemm_kernel_c0_enter13_gemm_kernel_aunroll_x_V0,
        in_unnamed_gemm_kernel1_avm_readdata => in_unnamed_gemm_kernel1_avm_readdata,
        in_unnamed_gemm_kernel1_avm_readdatavalid => in_unnamed_gemm_kernel1_avm_readdatavalid,
        in_unnamed_gemm_kernel1_avm_waitrequest => in_unnamed_gemm_kernel1_avm_waitrequest,
        in_unnamed_gemm_kernel1_avm_writeack => in_unnamed_gemm_kernel1_avm_writeack,
        out_o_readdata => i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_readdata,
        out_o_stall => i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_stall,
        out_o_valid => i_load_unnamed_gemm_kernel1_gemm_kernel_out_o_valid,
        out_unnamed_gemm_kernel1_avm_address => i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_address,
        out_unnamed_gemm_kernel1_avm_burstcount => i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_burstcount,
        out_unnamed_gemm_kernel1_avm_byteenable => i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_byteenable,
        out_unnamed_gemm_kernel1_avm_enable => i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_enable,
        out_unnamed_gemm_kernel1_avm_read => i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_read,
        out_unnamed_gemm_kernel1_avm_write => i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_write,
        out_unnamed_gemm_kernel1_avm_writedata => i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,5)
    out_unnamed_gemm_kernel1_avm_address <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_address;
    out_unnamed_gemm_kernel1_avm_enable <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_enable;
    out_unnamed_gemm_kernel1_avm_read <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_read;
    out_unnamed_gemm_kernel1_avm_write <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_write;
    out_unnamed_gemm_kernel1_avm_writedata <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_writedata;
    out_unnamed_gemm_kernel1_avm_byteenable <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_byteenable;
    out_unnamed_gemm_kernel1_avm_burstcount <= i_load_unnamed_gemm_kernel1_gemm_kernel_out_unnamed_gemm_kernel1_avm_burstcount;

    -- bubble_join_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo(BITJOIN,220)
    bubble_join_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_q <= redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_data_out;

    -- bubble_select_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo(BITSELECT,221)
    bubble_select_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_q(31 downto 0));

    -- bubble_join_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo(BITJOIN,214)
    bubble_join_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_q <= redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_data_out;

    -- bubble_select_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo(BITSELECT,215)
    bubble_select_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_q(31 downto 0));

    -- bubble_join_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo(BITJOIN,208)
    bubble_join_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_q <= redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_data_out;

    -- bubble_select_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo(BITSELECT,209)
    bubble_select_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_q(31 downto 0));

    -- bubble_join_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo(BITJOIN,196)
    bubble_join_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_q <= redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_data_out;

    -- bubble_select_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo(BITSELECT,197)
    bubble_select_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_q(0 downto 0));

    -- bubble_join_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x(BITJOIN,166)
    bubble_join_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_q <= i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_out_c1_exit_1;

    -- bubble_select_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x(BITSELECT,167)
    bubble_select_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_q(31 downto 0));

    -- bubble_join_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo(BITJOIN,202)
    bubble_join_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_q <= redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_data_out;

    -- bubble_select_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo(BITSELECT,203)
    bubble_select_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_q(31 downto 0));

    -- bubble_join_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo(BITJOIN,217)
    bubble_join_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_q <= redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_data_out;

    -- bubble_select_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo(BITSELECT,218)
    bubble_select_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_q(31 downto 0));

    -- dupName_0_sync_out_x(GPOUT,10)@185
    out_acl_hw_wg_id8 <= bubble_select_redist10_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_5_184_fifo_b;
    out_c0_exe11 <= bubble_select_redist5_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_2_184_fifo_b;
    out_c1_exe1 <= bubble_select_i_sfc_c1_for_body_gemm_kernel_c1_enter_gemm_kernel_aunroll_x_b;
    out_exitcond_GUARD_GUARD <= bubble_select_redist0_i_exitcond_guard_guard_gemm_kernel_q_175_fifo_b;
    out_global_id_04 <= bubble_select_redist7_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_3_184_fifo_b;
    out_global_id_16 <= bubble_select_redist9_gemm_kernel_B1_merge_reg_aunroll_x_out_data_out_4_184_fifo_b;
    out_inc <= bubble_select_redist12_bgTrunc_i_inc_gemm_kernel_sel_x_b_177_fifo_b;
    out_valid_out <= SE_out_bubble_out_i_syncbuf_k_sync_buffer5_gemm_kernel_1_V0;

    -- ext_sig_sync_out(GPOUT,52)
    out_unnamed_gemm_kernel0_avm_address <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_address;
    out_unnamed_gemm_kernel0_avm_enable <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_enable;
    out_unnamed_gemm_kernel0_avm_read <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_read;
    out_unnamed_gemm_kernel0_avm_write <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_write;
    out_unnamed_gemm_kernel0_avm_writedata <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_writedata;
    out_unnamed_gemm_kernel0_avm_byteenable <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_byteenable;
    out_unnamed_gemm_kernel0_avm_burstcount <= i_load_unnamed_gemm_kernel0_gemm_kernel_out_unnamed_gemm_kernel0_avm_burstcount;

    -- sync_out(GPOUT,87)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
