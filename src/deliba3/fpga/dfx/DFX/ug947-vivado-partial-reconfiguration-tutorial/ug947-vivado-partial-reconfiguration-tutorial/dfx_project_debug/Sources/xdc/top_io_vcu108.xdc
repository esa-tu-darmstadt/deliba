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
#//  /   /        Filename: top_io_vcu108.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  / 
#//  \___\/\___ 
#// Device: VCU108 board Rev 1.0
#// Design Name: pr_project_debug
#// Purpose: Partial Reconfiguration Tutorial
#///////////////////////////////////////////////////////////////////////////////

# set clock frequency
#create_clock -name clk_in1_p -period 3.333 [get_ports clk_in1_p]

# assign LEDs for outputs
set_property PACKAGE_PIN BA37 [get_ports {count_out[7]}]
set_property PACKAGE_PIN AY35 [get_ports {count_out[6]}]
set_property PACKAGE_PIN AV36 [get_ports {count_out[5]}]
set_property PACKAGE_PIN BF32 [get_ports {count_out[4]}]
set_property PACKAGE_PIN BB32 [get_ports {count_out[3]}]
set_property PACKAGE_PIN AY30 [get_ports {count_out[2]}]
set_property PACKAGE_PIN AV34 [get_ports {count_out[1]}]
set_property PACKAGE_PIN AT32 [get_ports {count_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[0]}]

# input buttons
# reset is middle button
set_property PACKAGE_PIN AW27 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports reset]

# pause is S button
set_property PACKAGE_PIN D9 [get_ports pause]
set_property IOSTANDARD LVCMOS18 [get_ports pause]

# toggle is N button
set_property PACKAGE_PIN E34 [get_ports toggle]
set_property IOSTANDARD LVCMOS18 [get_ports toggle]

# differential clock
set_property PACKAGE_PIN BC9 [get_ports clk_in1_p]
set_property IOSTANDARD LVDS [get_ports clk_in1_p]

set_property PACKAGE_PIN BC8 [get_ports clk_in1_n]
set_property IOSTANDARD LVDS [get_ports clk_in1_n]

# programming voltages
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]


######################################## END PIN ASSIGNMENT ########################################

