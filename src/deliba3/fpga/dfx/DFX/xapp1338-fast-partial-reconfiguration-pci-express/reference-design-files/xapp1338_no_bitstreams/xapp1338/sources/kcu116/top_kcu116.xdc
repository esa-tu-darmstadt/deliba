##-----------------------------------------------------------------------------
##
## (c) Copyright 2012-2012 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
##
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.
##
##-----------------------------------------------------------------------------
##
## Project    : The Xilinx PCI Express DMA
## File       : xilinx_pcie_xdma_ref_board.xdc
## Version    : 4.1
##-----------------------------------------------------------------------------
#
# User Configuration
# Link Width   - x8
# Link Speed   - Gen3
# Family       - virtexuplus
# Part         - xcvu9p
# Package      - flga2104
# Speed grade  - -2L
# Xilinx Reference Board is VCU118
###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
##
## Free Running Clock is Required for IBERT/DRP operations.
##
# Clock for the 300 MHz clock is already created in the Clock Wizard IP.
# 300 MHz clock pin constraints.
#set_property IOSTANDARD DIFF_SSTL12 [get_ports free_run_clock_p_in]
#set_property IOSTANDARD DIFF_SSTL12 [get_ports free_run_clock_n_in]
#set_property PACKAGE_PIN K22 [get_ports free_run_clock_p_in]
#set_property PACKAGE_PIN K23 [get_ports free_run_clock_n_in]
#

#############################################################################################################
create_clock -period 10.000 -name sys_clk [get_ports sys_clk_p]
#
#############################################################################################################
set_false_path -from [get_ports sys_rst_n]
set_property PULLUP true [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS18 [get_ports sys_rst_n]
set_property PACKAGE_PIN T19 [get_ports sys_rst_n]
#
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]
#
#############################################################################################################
#
set_property PACKAGE_PIN V6 [get_ports sys_clk_n]
set_property PACKAGE_PIN V7 [get_ports sys_clk_p]
#
#
#############################################################################################################
# LEDs for VCU118
set_property PACKAGE_PIN C9 [get_ports led_0]
# user_link_up
set_property PACKAGE_PIN D9 [get_ports led_1]
# Clock Up/Heart Beat(HB)
set_property PACKAGE_PIN E10 [get_ports led_2]
# cfg_current_speed[0] => 00: Gen1; 01: Gen2; 10:Gen3; 11:Gen4
set_property PACKAGE_PIN E11 [get_ports led_3]
# cfg_current_speed[1]
#set_property PACKAGE_PIN BF32 [get_ports led_4]
# cfg_negotiated_width[0] => 000: x1; 001: x2; 010: x4; 011: x8; 100: x16
#set_property PACKAGE_PIN AU37 [get_ports led_5]
# cfg_negotiated_width[1]
#set_property PACKAGE_PIN AV36 [get_ports led_6]
# cfg_negotiated_width[2]
#set_property PACKAGE_PIN BA37 [get_ports led_7]
#############################################################################################################

set_property IOSTANDARD LVCMOS33 [get_ports led_0]
set_property IOSTANDARD LVCMOS33 [get_ports led_1]
set_property IOSTANDARD LVCMOS33 [get_ports led_2]
set_property IOSTANDARD LVCMOS33 [get_ports led_3]
set_property DRIVE 8 [get_ports led_0]
set_property DRIVE 8 [get_ports led_1]
set_property DRIVE 8 [get_ports led_2]
set_property DRIVE 8 [get_ports led_3]
set_false_path -to [get_ports -filter NAME=~led_*]
#############################################################################################################

#shifter LEDs
#GPIO_LED_4 
set_property PACKAGE_PIN G10 [get_ports {shift_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[0]}]
                                          
#GPIO_LED_5      
set_property PACKAGE_PIN G9 [get_ports {shift_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[1]}]
                                          
#GPIO_LED_6      
set_property PACKAGE_PIN F10 [get_ports {shift_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[2]}]
                                          
#GPIO_LED_7     
set_property PACKAGE_PIN F9 [get_ports {shift_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[3]}]

#GPIO_SW_C (SW7) 
set_property PACKAGE_PIN A9 [get_ports rst_pr]
set_property IOSTANDARD LVCMOS33 [get_ports rst_pr]
#
#
#
set_false_path -to [get_pins -hier {*sync_reg[0]/D}]
#

