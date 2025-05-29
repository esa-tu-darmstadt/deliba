####################################################################################
#///////////////////////////////////////////////////////////////////////////////
#// Copyright (c) 2005-2016 Xilinx, Inc.
#// This design is confidential and proprietary of Xilinx, Inc.
#// All Rights Reserved.
#///////////////////////////////////////////////////////////////////////////////
#//   ____  ____
#//  /   /\/   /
#// /___/  \  /   Vendor: Xilinx
#// \   \   \/    Version: 2020.1
#//  \   \        Application: Partial Reconfiguration
#//  /   /        Filename: top_io_kcu116.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  / 
#//  \___\/\___ 
#// Device: KCU116 board Rev 1.0
#// Design Name: pr_project_debug
#// Purpose: Partial Reconfiguration Tutorial
#///////////////////////////////////////////////////////////////////////////////

# set clock frequency
#create_clock -name clk_in1_p -period 3.333 [get_ports clk_in1_p]

# assign LEDs for outputs
set_property PACKAGE_PIN G10 [get_ports {count_out[7]}]
set_property PACKAGE_PIN G9 [get_ports {count_out[6]}]
set_property PACKAGE_PIN F10 [get_ports {count_out[5]}]
set_property PACKAGE_PIN F9 [get_ports {count_out[4]}]
set_property PACKAGE_PIN E11 [get_ports {count_out[3]}]
set_property PACKAGE_PIN E10 [get_ports {count_out[2]}]
set_property PACKAGE_PIN D9 [get_ports {count_out[1]}]
set_property PACKAGE_PIN C9 [get_ports {count_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[0]}]

# input buttons
# reset is middle button
set_property PACKAGE_PIN A9 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# pause is bottom button
set_property PACKAGE_PIN C11 [get_ports pause]
set_property IOSTANDARD LVCMOS33 [get_ports pause]

# toggle is top button
set_property PACKAGE_PIN A10 [get_ports toggle]
set_property IOSTANDARD LVCMOS33 [get_ports toggle]

# differential clock
set_property PACKAGE_PIN K22 [get_ports clk_in1_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_in1_p]

set_property PACKAGE_PIN K23 [get_ports clk_in1_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_in1_n]

# programming voltages
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]


######################################## END PIN ASSIGNMENT ########################################

