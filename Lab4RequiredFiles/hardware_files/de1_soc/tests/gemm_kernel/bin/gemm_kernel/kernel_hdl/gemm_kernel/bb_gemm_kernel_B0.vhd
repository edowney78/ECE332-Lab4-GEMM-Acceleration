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

-- VHDL created from bb_gemm_kernel_B0
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

entity bb_gemm_kernel_B0 is
    port (
        in_A : in std_logic_vector(63 downto 0);  -- ufix64
        in_B : in std_logic_vector(63 downto 0);  -- ufix64
        in_C : in std_logic_vector(63 downto 0);  -- ufix64
        in_K : in std_logic_vector(31 downto 0);  -- ufix32
        in_M : in std_logic_vector(31 downto 0);  -- ufix32
        in_N : in std_logic_vector(31 downto 0);  -- ufix32
        in_acl_hw_wg_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_0_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_1_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_stall_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exe1 : out std_logic_vector(31 downto 0);  -- ufix32
        out_global_id_0 : out std_logic_vector(31 downto 0);  -- ufix32
        out_global_id_1 : out std_logic_vector(31 downto 0);  -- ufix32
        out_stall_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_gemm_kernel_B0;

architecture normal of bb_gemm_kernel_B0 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component bb_gemm_kernel_B0_stall_region is
        port (
            in_K : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_acl_hw_wg_id : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_acl_hw_wg_id : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exe1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_global_id_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_global_id_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component gemm_kernel_B0_branch is
        port (
            in_acl_hw_wg_id : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_exe1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_acl_hw_wg_id : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exe1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_global_id_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_global_id_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component gemm_kernel_B0_merge is
        port (
            in_acl_hw_wg_id_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_0_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_global_id_1_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_acl_hw_wg_id : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_global_id_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_global_id_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal bb_gemm_kernel_B0_stall_region_out_acl_hw_wg_id : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B0_stall_region_out_c0_exe1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B0_stall_region_out_global_id_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B0_stall_region_out_global_id_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_gemm_kernel_B0_stall_region_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_gemm_kernel_B0_stall_region_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal gemm_kernel_B0_branch_out_acl_hw_wg_id : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B0_branch_out_c0_exe1 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B0_branch_out_global_id_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B0_branch_out_global_id_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B0_branch_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal gemm_kernel_B0_branch_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal gemm_kernel_B0_merge_out_acl_hw_wg_id : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B0_merge_out_global_id_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B0_merge_out_global_id_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal gemm_kernel_B0_merge_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal gemm_kernel_B0_merge_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- gemm_kernel_B0_merge(BLACKBOX,4)
    thegemm_kernel_B0_merge : gemm_kernel_B0_merge
    PORT MAP (
        in_acl_hw_wg_id_0 => in_acl_hw_wg_id_0,
        in_global_id_0_0 => in_global_id_0_0,
        in_global_id_1_0 => in_global_id_1_0,
        in_stall_in => bb_gemm_kernel_B0_stall_region_out_stall_out,
        in_valid_in_0 => in_valid_in_0,
        out_acl_hw_wg_id => gemm_kernel_B0_merge_out_acl_hw_wg_id,
        out_global_id_0 => gemm_kernel_B0_merge_out_global_id_0,
        out_global_id_1 => gemm_kernel_B0_merge_out_global_id_1,
        out_stall_out_0 => gemm_kernel_B0_merge_out_stall_out_0,
        out_valid_out => gemm_kernel_B0_merge_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bb_gemm_kernel_B0_stall_region(BLACKBOX,2)
    thebb_gemm_kernel_B0_stall_region : bb_gemm_kernel_B0_stall_region
    PORT MAP (
        in_K => in_K,
        in_acl_hw_wg_id => gemm_kernel_B0_merge_out_acl_hw_wg_id,
        in_global_id_0 => gemm_kernel_B0_merge_out_global_id_0,
        in_global_id_1 => gemm_kernel_B0_merge_out_global_id_1,
        in_stall_in => gemm_kernel_B0_branch_out_stall_out,
        in_valid_in => gemm_kernel_B0_merge_out_valid_out,
        out_acl_hw_wg_id => bb_gemm_kernel_B0_stall_region_out_acl_hw_wg_id,
        out_c0_exe1 => bb_gemm_kernel_B0_stall_region_out_c0_exe1,
        out_global_id_0 => bb_gemm_kernel_B0_stall_region_out_global_id_0,
        out_global_id_1 => bb_gemm_kernel_B0_stall_region_out_global_id_1,
        out_stall_out => bb_gemm_kernel_B0_stall_region_out_stall_out,
        out_valid_out => bb_gemm_kernel_B0_stall_region_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- gemm_kernel_B0_branch(BLACKBOX,3)
    thegemm_kernel_B0_branch : gemm_kernel_B0_branch
    PORT MAP (
        in_acl_hw_wg_id => bb_gemm_kernel_B0_stall_region_out_acl_hw_wg_id,
        in_c0_exe1 => bb_gemm_kernel_B0_stall_region_out_c0_exe1,
        in_global_id_0 => bb_gemm_kernel_B0_stall_region_out_global_id_0,
        in_global_id_1 => bb_gemm_kernel_B0_stall_region_out_global_id_1,
        in_stall_in_0 => in_stall_in_0,
        in_valid_in => bb_gemm_kernel_B0_stall_region_out_valid_out,
        out_acl_hw_wg_id => gemm_kernel_B0_branch_out_acl_hw_wg_id,
        out_c0_exe1 => gemm_kernel_B0_branch_out_c0_exe1,
        out_global_id_0 => gemm_kernel_B0_branch_out_global_id_0,
        out_global_id_1 => gemm_kernel_B0_branch_out_global_id_1,
        out_stall_out => gemm_kernel_B0_branch_out_stall_out,
        out_valid_out_0 => gemm_kernel_B0_branch_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- out_acl_hw_wg_id(GPOUT,16)
    out_acl_hw_wg_id <= gemm_kernel_B0_branch_out_acl_hw_wg_id;

    -- out_c0_exe1(GPOUT,17)
    out_c0_exe1 <= gemm_kernel_B0_branch_out_c0_exe1;

    -- out_global_id_0(GPOUT,18)
    out_global_id_0 <= gemm_kernel_B0_branch_out_global_id_0;

    -- out_global_id_1(GPOUT,19)
    out_global_id_1 <= gemm_kernel_B0_branch_out_global_id_1;

    -- out_stall_out_0(GPOUT,20)
    out_stall_out_0 <= gemm_kernel_B0_merge_out_stall_out_0;

    -- out_valid_out_0(GPOUT,21)
    out_valid_out_0 <= gemm_kernel_B0_branch_out_valid_out_0;

END normal;
