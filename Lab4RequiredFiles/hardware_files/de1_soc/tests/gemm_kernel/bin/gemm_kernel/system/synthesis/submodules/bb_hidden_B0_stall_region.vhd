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

-- VHDL created from bb_hidden_B0_stall_region
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

entity bb_hidden_B0_stall_region is
    port (
        in_acl_hw_wg_id : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id : out std_logic_vector(31 downto 0);  -- ufix32
        out_global_id_0 : out std_logic_vector(31 downto 0);  -- ufix32
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_hidden_B0_stall_region;

architecture normal of bb_hidden_B0_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component hidden_B0_merge_reg is
        port (
            in_data_in_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal hidden_B0_merge_reg_aunroll_x_out_data_out_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal hidden_B0_merge_reg_aunroll_x_out_data_out_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal hidden_B0_merge_reg_aunroll_x_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal hidden_B0_merge_reg_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_hidden_B0_merge_reg_aunroll_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_hidden_B0_merge_reg_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_hidden_B0_merge_reg_aunroll_x_c : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_c : STD_LOGIC_VECTOR (31 downto 0);
    signal SE_out_hidden_B0_merge_reg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_hidden_B0_merge_reg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_hidden_B0_merge_reg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- SE_stall_entry(STALLENABLE,22)
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid;
    -- Backward Stall generation
    SE_stall_entry_backStall <= hidden_B0_merge_reg_aunroll_x_out_stall_out or not (SE_stall_entry_wireValid);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- bubble_join_stall_entry(BITJOIN,17)
    bubble_join_stall_entry_q <= in_global_id_0 & in_acl_hw_wg_id;

    -- bubble_select_stall_entry(BITSELECT,18)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(31 downto 0));
    bubble_select_stall_entry_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(63 downto 32));

    -- hidden_B0_merge_reg_aunroll_x(BLACKBOX,4)@0
    -- in in_stall_in@20000000
    -- out out_data_out_0@1
    -- out out_data_out_1@1
    -- out out_stall_out@20000000
    -- out out_valid_out@1
    thehidden_B0_merge_reg_aunroll_x : hidden_B0_merge_reg
    PORT MAP (
        in_data_in_0 => bubble_select_stall_entry_c,
        in_data_in_1 => bubble_select_stall_entry_b,
        in_stall_in => SE_out_hidden_B0_merge_reg_aunroll_x_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_data_out_0 => hidden_B0_merge_reg_aunroll_x_out_data_out_0,
        out_data_out_1 => hidden_B0_merge_reg_aunroll_x_out_data_out_1,
        out_stall_out => hidden_B0_merge_reg_aunroll_x_out_stall_out,
        out_valid_out => hidden_B0_merge_reg_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_hidden_B0_merge_reg_aunroll_x(STALLENABLE,21)
    -- Valid signal propagation
    SE_out_hidden_B0_merge_reg_aunroll_x_V0 <= SE_out_hidden_B0_merge_reg_aunroll_x_wireValid;
    -- Backward Stall generation
    SE_out_hidden_B0_merge_reg_aunroll_x_backStall <= in_stall_in or not (SE_out_hidden_B0_merge_reg_aunroll_x_wireValid);
    -- Computing multiple Valid(s)
    SE_out_hidden_B0_merge_reg_aunroll_x_wireValid <= hidden_B0_merge_reg_aunroll_x_out_valid_out;

    -- bubble_join_hidden_B0_merge_reg_aunroll_x(BITJOIN,14)
    bubble_join_hidden_B0_merge_reg_aunroll_x_q <= hidden_B0_merge_reg_aunroll_x_out_data_out_1 & hidden_B0_merge_reg_aunroll_x_out_data_out_0;

    -- bubble_select_hidden_B0_merge_reg_aunroll_x(BITSELECT,15)
    bubble_select_hidden_B0_merge_reg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_hidden_B0_merge_reg_aunroll_x_q(31 downto 0));
    bubble_select_hidden_B0_merge_reg_aunroll_x_c <= STD_LOGIC_VECTOR(bubble_join_hidden_B0_merge_reg_aunroll_x_q(63 downto 32));

    -- dupName_0_sync_out_x(GPOUT,3)@1
    out_acl_hw_wg_id <= bubble_select_hidden_B0_merge_reg_aunroll_x_c;
    out_global_id_0 <= bubble_select_hidden_B0_merge_reg_aunroll_x_b;
    out_valid_out <= SE_out_hidden_B0_merge_reg_aunroll_x_V0;

    -- sync_out(GPOUT,12)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
