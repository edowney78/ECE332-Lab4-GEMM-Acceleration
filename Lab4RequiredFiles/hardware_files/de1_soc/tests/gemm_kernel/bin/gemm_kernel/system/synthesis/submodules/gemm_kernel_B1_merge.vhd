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

-- VHDL created from gemm_kernel_B1_merge
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

entity gemm_kernel_B1_merge is
    port (
        in_acl_hw_wg_id8_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_acl_hw_wg_id8_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exe11_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exe11_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_04_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_04_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_16_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_16_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_k_05_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_k_05_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        in_sum_04_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_sum_04_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_valid_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_1 : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id8 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exe11 : out std_logic_vector(31 downto 0);  -- ufix32
        out_global_id_04 : out std_logic_vector(31 downto 0);  -- ufix32
        out_global_id_16 : out std_logic_vector(31 downto 0);  -- ufix32
        out_k_05 : out std_logic_vector(31 downto 0);  -- ufix32
        out_stall_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out_1 : out std_logic_vector(0 downto 0);  -- ufix1
        out_sum_04 : out std_logic_vector(31 downto 0);  -- float32_m23
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end gemm_kernel_B1_merge;

architecture normal of gemm_kernel_B1_merge is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal acl_hw_wg_id8_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal acl_hw_wg_id8_mux_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c0_exe11_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exe11_mux_q : STD_LOGIC_VECTOR (31 downto 0);
    signal global_id_04_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal global_id_04_mux_q : STD_LOGIC_VECTOR (31 downto 0);
    signal global_id_16_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal global_id_16_mux_q : STD_LOGIC_VECTOR (31 downto 0);
    signal k_05_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal k_05_mux_q : STD_LOGIC_VECTOR (31 downto 0);
    signal stall_out_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stall_out_1_specific_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sum_04_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal sum_04_mux_q : STD_LOGIC_VECTOR (31 downto 0);
    signal valid_or_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- acl_hw_wg_id8_mux(MUX,2)
    acl_hw_wg_id8_mux_s <= in_valid_in_0;
    acl_hw_wg_id8_mux_combproc: PROCESS (acl_hw_wg_id8_mux_s, in_acl_hw_wg_id8_1, in_acl_hw_wg_id8_0)
    BEGIN
        CASE (acl_hw_wg_id8_mux_s) IS
            WHEN "0" => acl_hw_wg_id8_mux_q <= in_acl_hw_wg_id8_1;
            WHEN "1" => acl_hw_wg_id8_mux_q <= in_acl_hw_wg_id8_0;
            WHEN OTHERS => acl_hw_wg_id8_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_acl_hw_wg_id8(GPOUT,22)
    out_acl_hw_wg_id8 <= acl_hw_wg_id8_mux_q;

    -- c0_exe11_mux(MUX,3)
    c0_exe11_mux_s <= in_valid_in_0;
    c0_exe11_mux_combproc: PROCESS (c0_exe11_mux_s, in_c0_exe11_1, in_c0_exe11_0)
    BEGIN
        CASE (c0_exe11_mux_s) IS
            WHEN "0" => c0_exe11_mux_q <= in_c0_exe11_1;
            WHEN "1" => c0_exe11_mux_q <= in_c0_exe11_0;
            WHEN OTHERS => c0_exe11_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_c0_exe11(GPOUT,23)
    out_c0_exe11 <= c0_exe11_mux_q;

    -- global_id_04_mux(MUX,4)
    global_id_04_mux_s <= in_valid_in_0;
    global_id_04_mux_combproc: PROCESS (global_id_04_mux_s, in_global_id_04_1, in_global_id_04_0)
    BEGIN
        CASE (global_id_04_mux_s) IS
            WHEN "0" => global_id_04_mux_q <= in_global_id_04_1;
            WHEN "1" => global_id_04_mux_q <= in_global_id_04_0;
            WHEN OTHERS => global_id_04_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_global_id_04(GPOUT,24)
    out_global_id_04 <= global_id_04_mux_q;

    -- global_id_16_mux(MUX,5)
    global_id_16_mux_s <= in_valid_in_0;
    global_id_16_mux_combproc: PROCESS (global_id_16_mux_s, in_global_id_16_1, in_global_id_16_0)
    BEGIN
        CASE (global_id_16_mux_s) IS
            WHEN "0" => global_id_16_mux_q <= in_global_id_16_1;
            WHEN "1" => global_id_16_mux_q <= in_global_id_16_0;
            WHEN OTHERS => global_id_16_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_global_id_16(GPOUT,25)
    out_global_id_16 <= global_id_16_mux_q;

    -- k_05_mux(MUX,21)
    k_05_mux_s <= in_valid_in_0;
    k_05_mux_combproc: PROCESS (k_05_mux_s, in_k_05_1, in_k_05_0)
    BEGIN
        CASE (k_05_mux_s) IS
            WHEN "0" => k_05_mux_q <= in_k_05_1;
            WHEN "1" => k_05_mux_q <= in_k_05_0;
            WHEN OTHERS => k_05_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_k_05(GPOUT,26)
    out_k_05 <= k_05_mux_q;

    -- valid_or(LOGICAL,34)
    valid_or_q <= in_valid_in_0 or in_valid_in_1;

    -- stall_out(LOGICAL,31)
    stall_out_q <= valid_or_q and in_stall_in;

    -- out_stall_out_0(GPOUT,27)
    out_stall_out_0 <= stall_out_q;

    -- stall_out_1_specific(LOGICAL,32)
    stall_out_1_specific_q <= in_valid_in_0 or stall_out_q;

    -- out_stall_out_1(GPOUT,28)
    out_stall_out_1 <= stall_out_1_specific_q;

    -- sum_04_mux(MUX,33)
    sum_04_mux_s <= in_valid_in_0;
    sum_04_mux_combproc: PROCESS (sum_04_mux_s, in_sum_04_1, in_sum_04_0)
    BEGIN
        CASE (sum_04_mux_s) IS
            WHEN "0" => sum_04_mux_q <= in_sum_04_1;
            WHEN "1" => sum_04_mux_q <= in_sum_04_0;
            WHEN OTHERS => sum_04_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_sum_04(GPOUT,29)
    out_sum_04 <= sum_04_mux_q;

    -- out_valid_out(GPOUT,30)
    out_valid_out <= valid_or_q;

END normal;
