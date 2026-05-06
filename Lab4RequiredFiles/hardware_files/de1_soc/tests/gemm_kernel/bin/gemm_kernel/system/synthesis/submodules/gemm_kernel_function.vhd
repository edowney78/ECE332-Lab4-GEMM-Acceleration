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

-- VHDL created from gemm_kernel_function
-- VHDL created on Tue May 05 20:21:55 2026


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

entity gemm_kernel_function is
    port (
        in_arg_acl_hw_wg_id : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_global_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_global_size_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_global_size_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_global_size_2 : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_input_tile : in std_logic_vector(63 downto 0);  -- ufix64
        in_arg_input_tile_size : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_local_size_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_local_size_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_local_size_2 : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_output_neurons_tile_size : in std_logic_vector(31 downto 0);  -- ufix32
        in_arg_output_tile : in std_logic_vector(63 downto 0);  -- ufix64
        in_arg_weights_tile : in std_logic_vector(63 downto 0);  -- ufix64
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        in_start : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel0_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_gemm_kernel0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel0_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel1_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_gemm_kernel1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel1_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel2_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_gemm_kernel2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_gemm_kernel2_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id4 : out std_logic_vector(31 downto 0);  -- ufix32
        out_o_active_unnamed_gemm_kernel2 : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_gemm_kernel0_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        out_unnamed_gemm_kernel0_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_gemm_kernel0_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel0_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_gemm_kernel1_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_gemm_kernel1_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        out_unnamed_gemm_kernel1_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_gemm_kernel1_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel1_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel1_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel1_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_gemm_kernel2_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_gemm_kernel2_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        out_unnamed_gemm_kernel2_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_gemm_kernel2_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel2_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel2_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_gemm_kernel2_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end gemm_kernel_function;

architecture normal of gemm_kernel_function is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component bb_gemm_kernel_B1_sr_0 is
        port (
            in_i_data_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_data_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_i_data_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_data_3 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_data_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_data_2 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_data_3 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_gemm_kernel_B1_sr_1 is
        port (
            in_i_data_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_data_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_i_data_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_data_3 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_data_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_data_2 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_data_3 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_gemm_kernel_B2_sr_0 is
        port (
            in_i_data_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_i_data_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_data_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_data_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_data_2 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_gemm_kernel_B0 is
        port (
            in_acl_hw_wg_id_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_0_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_input_tile : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_input_tile_size : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_output_neurons_tile_size : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_output_tile : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_weights_tile : in std_logic_vector(63 downto 0);  -- Fixed Point
            out_acl_hw_wg_id : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_global_id_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_gemm_kernel_B1 is
        port (
            in_acl_hw_wg_id5_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_acl_hw_wg_id5_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_global_id_03_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_03_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_input_tile : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_input_tile_size : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_k_03_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_k_03_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_output_neurons_tile_size : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_output_tile : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_sum_02_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_sum_02_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_unnamed_gemm_kernel0_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel0_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel1_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_weights_tile : in std_logic_vector(63 downto 0);  -- Fixed Point
            out_acl_hw_wg_id5 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c1_exe1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_global_id_03 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_inc : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel0_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel1_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_gemm_kernel_B2 is
        port (
            in_acl_hw_wg_id4_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c1_exe11_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_global_id_02_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_input_tile_size : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_output_neurons_tile_size : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_output_tile : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel2_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_gemm_kernel2_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_acl_hw_wg_id4 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_lsu_unnamed_gemm_kernel2_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_gemm_kernel2_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component loop_limiter_gemm_kernel0 is
        port (
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall_exit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid_exit : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_2 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_3 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_2 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_3 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_2 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B0_out_acl_hw_wg_id : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B0_out_global_id_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B0_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B0_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_acl_hw_wg_id5 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_out_c1_exe1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_out_global_id_03 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_out_inc : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_stall_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal bb_gemm_kernel_B1_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B1_out_valid_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_out_acl_hw_wg_id4 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B2_out_lsu_unnamed_gemm_kernel2_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal bb_gemm_kernel_B2_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal c_float_0_000000e_00_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c_i32_0gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal loop_limiter_gemm_kernel0_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal loop_limiter_gemm_kernel0_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- loop_limiter_gemm_kernel0(BLACKBOX,38)
    theloop_limiter_gemm_kernel0 : loop_limiter_gemm_kernel0
    PORT MAP (
        in_i_stall => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_stall,
        in_i_stall_exit => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_stall,
        in_i_valid => bb_gemm_kernel_B0_out_valid_out_0,
        in_i_valid_exit => bb_gemm_kernel_B1_out_valid_out_0,
        out_o_stall => loop_limiter_gemm_kernel0_out_o_stall,
        out_o_valid => loop_limiter_gemm_kernel0_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bb_gemm_kernel_B0(BLACKBOX,5)
    thebb_gemm_kernel_B0 : bb_gemm_kernel_B0
    PORT MAP (
        in_acl_hw_wg_id_0 => in_arg_acl_hw_wg_id,
        in_global_id_0_0 => in_arg_global_id_0,
        in_input_tile => in_arg_input_tile,
        in_input_tile_size => in_arg_input_tile_size,
        in_output_neurons_tile_size => in_arg_output_neurons_tile_size,
        in_output_tile => in_arg_output_tile,
        in_stall_in_0 => loop_limiter_gemm_kernel0_out_o_stall,
        in_valid_in_0 => in_valid_in,
        in_weights_tile => in_arg_weights_tile,
        out_acl_hw_wg_id => bb_gemm_kernel_B0_out_acl_hw_wg_id,
        out_global_id_0 => bb_gemm_kernel_B0_out_global_id_0,
        out_stall_out_0 => bb_gemm_kernel_B0_out_stall_out_0,
        out_valid_out_0 => bb_gemm_kernel_B0_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- c_float_0_000000e_00(FLOATCONSTANT,8)
    c_float_0_000000e_00_q <= "00000000000000000000000000000000";

    -- c_i32_0gr(CONSTANT,9)
    c_i32_0gr_q <= "00000000000000000000000000000000";

    -- bb_gemm_kernel_B1_sr_1_aunroll_x(BLACKBOX,3)
    thebb_gemm_kernel_B1_sr_1_aunroll_x : bb_gemm_kernel_B1_sr_1
    PORT MAP (
        in_i_data_0 => c_i32_0gr_q,
        in_i_data_1 => c_float_0_000000e_00_q,
        in_i_data_2 => bb_gemm_kernel_B0_out_global_id_0,
        in_i_data_3 => bb_gemm_kernel_B0_out_acl_hw_wg_id,
        in_i_stall => bb_gemm_kernel_B1_out_stall_out_1,
        in_i_valid => loop_limiter_gemm_kernel0_out_o_valid,
        out_o_data_0 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_0,
        out_o_data_1 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_1,
        out_o_data_2 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_2,
        out_o_data_3 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_3,
        out_o_stall => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_stall,
        out_o_valid => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bb_gemm_kernel_B1_sr_0_aunroll_x(BLACKBOX,2)
    thebb_gemm_kernel_B1_sr_0_aunroll_x : bb_gemm_kernel_B1_sr_0
    PORT MAP (
        in_i_data_0 => bb_gemm_kernel_B1_out_inc,
        in_i_data_1 => bb_gemm_kernel_B1_out_c1_exe1,
        in_i_data_2 => bb_gemm_kernel_B1_out_global_id_03,
        in_i_data_3 => bb_gemm_kernel_B1_out_acl_hw_wg_id5,
        in_i_stall => bb_gemm_kernel_B1_out_stall_out_0,
        in_i_valid => bb_gemm_kernel_B1_out_valid_out_1,
        out_o_data_0 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_0,
        out_o_data_1 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_1,
        out_o_data_2 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_2,
        out_o_data_3 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_3,
        out_o_stall => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_stall,
        out_o_valid => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bb_gemm_kernel_B1(BLACKBOX,6)
    thebb_gemm_kernel_B1 : bb_gemm_kernel_B1
    PORT MAP (
        in_acl_hw_wg_id5_0 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_3,
        in_acl_hw_wg_id5_1 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_3,
        in_flush => in_start,
        in_global_id_03_0 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_2,
        in_global_id_03_1 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_2,
        in_input_tile => in_arg_input_tile,
        in_input_tile_size => in_arg_input_tile_size,
        in_k_03_0 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_0,
        in_k_03_1 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_0,
        in_output_neurons_tile_size => in_arg_output_neurons_tile_size,
        in_output_tile => in_arg_output_tile,
        in_stall_in_0 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_stall,
        in_stall_in_1 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_stall,
        in_sum_02_0 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_data_1,
        in_sum_02_1 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_data_1,
        in_unnamed_gemm_kernel0_avm_readdata => in_unnamed_gemm_kernel0_avm_readdata,
        in_unnamed_gemm_kernel0_avm_readdatavalid => in_unnamed_gemm_kernel0_avm_readdatavalid,
        in_unnamed_gemm_kernel0_avm_waitrequest => in_unnamed_gemm_kernel0_avm_waitrequest,
        in_unnamed_gemm_kernel0_avm_writeack => in_unnamed_gemm_kernel0_avm_writeack,
        in_unnamed_gemm_kernel1_avm_readdata => in_unnamed_gemm_kernel1_avm_readdata,
        in_unnamed_gemm_kernel1_avm_readdatavalid => in_unnamed_gemm_kernel1_avm_readdatavalid,
        in_unnamed_gemm_kernel1_avm_waitrequest => in_unnamed_gemm_kernel1_avm_waitrequest,
        in_unnamed_gemm_kernel1_avm_writeack => in_unnamed_gemm_kernel1_avm_writeack,
        in_valid_in_0 => bb_gemm_kernel_B1_sr_0_aunroll_x_out_o_valid,
        in_valid_in_1 => bb_gemm_kernel_B1_sr_1_aunroll_x_out_o_valid,
        in_weights_tile => in_arg_weights_tile,
        out_acl_hw_wg_id5 => bb_gemm_kernel_B1_out_acl_hw_wg_id5,
        out_c1_exe1 => bb_gemm_kernel_B1_out_c1_exe1,
        out_global_id_03 => bb_gemm_kernel_B1_out_global_id_03,
        out_inc => bb_gemm_kernel_B1_out_inc,
        out_stall_out_0 => bb_gemm_kernel_B1_out_stall_out_0,
        out_stall_out_1 => bb_gemm_kernel_B1_out_stall_out_1,
        out_unnamed_gemm_kernel0_avm_address => bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_address,
        out_unnamed_gemm_kernel0_avm_burstcount => bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_burstcount,
        out_unnamed_gemm_kernel0_avm_byteenable => bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_byteenable,
        out_unnamed_gemm_kernel0_avm_enable => bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_enable,
        out_unnamed_gemm_kernel0_avm_read => bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_read,
        out_unnamed_gemm_kernel0_avm_write => bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_write,
        out_unnamed_gemm_kernel0_avm_writedata => bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_writedata,
        out_unnamed_gemm_kernel1_avm_address => bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_address,
        out_unnamed_gemm_kernel1_avm_burstcount => bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_burstcount,
        out_unnamed_gemm_kernel1_avm_byteenable => bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_byteenable,
        out_unnamed_gemm_kernel1_avm_enable => bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_enable,
        out_unnamed_gemm_kernel1_avm_read => bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_read,
        out_unnamed_gemm_kernel1_avm_write => bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_write,
        out_unnamed_gemm_kernel1_avm_writedata => bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_writedata,
        out_valid_out_0 => bb_gemm_kernel_B1_out_valid_out_0,
        out_valid_out_1 => bb_gemm_kernel_B1_out_valid_out_1,
        clock => clock,
        resetn => resetn
    );

    -- bb_gemm_kernel_B2_sr_0_aunroll_x(BLACKBOX,4)
    thebb_gemm_kernel_B2_sr_0_aunroll_x : bb_gemm_kernel_B2_sr_0
    PORT MAP (
        in_i_data_0 => bb_gemm_kernel_B1_out_c1_exe1,
        in_i_data_1 => bb_gemm_kernel_B1_out_global_id_03,
        in_i_data_2 => bb_gemm_kernel_B1_out_acl_hw_wg_id5,
        in_i_stall => bb_gemm_kernel_B2_out_stall_out_0,
        in_i_valid => bb_gemm_kernel_B1_out_valid_out_0,
        out_o_data_0 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_0,
        out_o_data_1 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_1,
        out_o_data_2 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_2,
        out_o_stall => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_stall,
        out_o_valid => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bb_gemm_kernel_B2(BLACKBOX,7)
    thebb_gemm_kernel_B2 : bb_gemm_kernel_B2
    PORT MAP (
        in_acl_hw_wg_id4_0 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_2,
        in_c1_exe11_0 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_0,
        in_flush => in_start,
        in_global_id_02_0 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_data_1,
        in_input_tile_size => in_arg_input_tile_size,
        in_output_neurons_tile_size => in_arg_output_neurons_tile_size,
        in_output_tile => in_arg_output_tile,
        in_stall_in_0 => in_stall_in,
        in_unnamed_gemm_kernel2_avm_readdata => in_unnamed_gemm_kernel2_avm_readdata,
        in_unnamed_gemm_kernel2_avm_readdatavalid => in_unnamed_gemm_kernel2_avm_readdatavalid,
        in_unnamed_gemm_kernel2_avm_waitrequest => in_unnamed_gemm_kernel2_avm_waitrequest,
        in_unnamed_gemm_kernel2_avm_writeack => in_unnamed_gemm_kernel2_avm_writeack,
        in_valid_in_0 => bb_gemm_kernel_B2_sr_0_aunroll_x_out_o_valid,
        out_acl_hw_wg_id4 => bb_gemm_kernel_B2_out_acl_hw_wg_id4,
        out_lsu_unnamed_gemm_kernel2_o_active => bb_gemm_kernel_B2_out_lsu_unnamed_gemm_kernel2_o_active,
        out_stall_out_0 => bb_gemm_kernel_B2_out_stall_out_0,
        out_unnamed_gemm_kernel2_avm_address => bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_address,
        out_unnamed_gemm_kernel2_avm_burstcount => bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_burstcount,
        out_unnamed_gemm_kernel2_avm_byteenable => bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_byteenable,
        out_unnamed_gemm_kernel2_avm_enable => bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_enable,
        out_unnamed_gemm_kernel2_avm_read => bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_read,
        out_unnamed_gemm_kernel2_avm_write => bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_write,
        out_unnamed_gemm_kernel2_avm_writedata => bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_writedata,
        out_valid_out_0 => bb_gemm_kernel_B2_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- out_acl_hw_wg_id4(GPOUT,39)
    out_acl_hw_wg_id4 <= bb_gemm_kernel_B2_out_acl_hw_wg_id4;

    -- out_o_active_unnamed_gemm_kernel2(GPOUT,40)
    out_o_active_unnamed_gemm_kernel2 <= bb_gemm_kernel_B2_out_lsu_unnamed_gemm_kernel2_o_active;

    -- out_stall_out(GPOUT,41)
    out_stall_out <= bb_gemm_kernel_B0_out_stall_out_0;

    -- out_unnamed_gemm_kernel0_avm_address(GPOUT,42)
    out_unnamed_gemm_kernel0_avm_address <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_address;

    -- out_unnamed_gemm_kernel0_avm_burstcount(GPOUT,43)
    out_unnamed_gemm_kernel0_avm_burstcount <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_burstcount;

    -- out_unnamed_gemm_kernel0_avm_byteenable(GPOUT,44)
    out_unnamed_gemm_kernel0_avm_byteenable <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_byteenable;

    -- out_unnamed_gemm_kernel0_avm_enable(GPOUT,45)
    out_unnamed_gemm_kernel0_avm_enable <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_enable;

    -- out_unnamed_gemm_kernel0_avm_read(GPOUT,46)
    out_unnamed_gemm_kernel0_avm_read <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_read;

    -- out_unnamed_gemm_kernel0_avm_write(GPOUT,47)
    out_unnamed_gemm_kernel0_avm_write <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_write;

    -- out_unnamed_gemm_kernel0_avm_writedata(GPOUT,48)
    out_unnamed_gemm_kernel0_avm_writedata <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel0_avm_writedata;

    -- out_unnamed_gemm_kernel1_avm_address(GPOUT,49)
    out_unnamed_gemm_kernel1_avm_address <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_address;

    -- out_unnamed_gemm_kernel1_avm_burstcount(GPOUT,50)
    out_unnamed_gemm_kernel1_avm_burstcount <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_burstcount;

    -- out_unnamed_gemm_kernel1_avm_byteenable(GPOUT,51)
    out_unnamed_gemm_kernel1_avm_byteenable <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_byteenable;

    -- out_unnamed_gemm_kernel1_avm_enable(GPOUT,52)
    out_unnamed_gemm_kernel1_avm_enable <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_enable;

    -- out_unnamed_gemm_kernel1_avm_read(GPOUT,53)
    out_unnamed_gemm_kernel1_avm_read <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_read;

    -- out_unnamed_gemm_kernel1_avm_write(GPOUT,54)
    out_unnamed_gemm_kernel1_avm_write <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_write;

    -- out_unnamed_gemm_kernel1_avm_writedata(GPOUT,55)
    out_unnamed_gemm_kernel1_avm_writedata <= bb_gemm_kernel_B1_out_unnamed_gemm_kernel1_avm_writedata;

    -- out_unnamed_gemm_kernel2_avm_address(GPOUT,56)
    out_unnamed_gemm_kernel2_avm_address <= bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_address;

    -- out_unnamed_gemm_kernel2_avm_burstcount(GPOUT,57)
    out_unnamed_gemm_kernel2_avm_burstcount <= bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_burstcount;

    -- out_unnamed_gemm_kernel2_avm_byteenable(GPOUT,58)
    out_unnamed_gemm_kernel2_avm_byteenable <= bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_byteenable;

    -- out_unnamed_gemm_kernel2_avm_enable(GPOUT,59)
    out_unnamed_gemm_kernel2_avm_enable <= bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_enable;

    -- out_unnamed_gemm_kernel2_avm_read(GPOUT,60)
    out_unnamed_gemm_kernel2_avm_read <= bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_read;

    -- out_unnamed_gemm_kernel2_avm_write(GPOUT,61)
    out_unnamed_gemm_kernel2_avm_write <= bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_write;

    -- out_unnamed_gemm_kernel2_avm_writedata(GPOUT,62)
    out_unnamed_gemm_kernel2_avm_writedata <= bb_gemm_kernel_B2_out_unnamed_gemm_kernel2_avm_writedata;

    -- out_valid_out(GPOUT,63)
    out_valid_out <= bb_gemm_kernel_B2_out_valid_out_0;

END normal;
