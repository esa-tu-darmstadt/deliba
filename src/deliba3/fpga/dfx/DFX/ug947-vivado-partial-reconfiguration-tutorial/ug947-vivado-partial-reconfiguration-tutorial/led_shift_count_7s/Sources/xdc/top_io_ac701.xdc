####################################################################################
#///////////////////////////////////////////////////////////////////////////////
#// Copyright (c) 2005-2020 Xilinx, Inc.
#// This design is confidential and proprietary of Xilinx, Inc.
#// All Rights Reserved.
#///////////////////////////////////////////////////////////////////////////////
#//   ____  ____
#//  /   /\/   /
#// /___/  \  /   Vendor: Xilinx
#// \   \   \/    Version: 2020.1
#//  \   \        Application: Dynamic Function eXchange
#//  /   /        Filename: top_io_ac701.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: AC701 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
create_clock -name clk_p -period 5 [get_ports clk_p]

#set configuration voltage
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


#-----------------------------------
# LED LOCs 
#    LED[0-3] shift or count depending on switch setting
#-----------------------------------
 
# GPIO_LED0_LS on Bank33 (VCC1V5 1.5 volt)
set_property PACKAGE_PIN M26 [get_ports dout[0]]
set_property IOSTANDARD LVCMOS33 [get_ports dout[0]]

# GPIO_LED1_LS on Bank33 (VCC1V5 1.5 volt)
set_property PACKAGE_PIN T24 [get_ports dout[1]]
set_property IOSTANDARD LVCMOS33 [get_ports dout[1]]

# GPIO_LED2_LS on Bank33 (VCC1V5 1.5 volt)
set_property PACKAGE_PIN T25 [get_ports dout[2]]
set_property IOSTANDARD LVCMOS33 [get_ports dout[2]]

# GPIO_LED3_LS on Bank33 (VCC1V5 1.5 volt)
set_property PACKAGE_PIN R26 [get_ports dout[3]]
set_property IOSTANDARD LVCMOS33 [get_ports dout[3]]

# DIP Switch 
set_property PACKAGE_PIN R8      [get_ports switch]
set_property IOSTANDARD SSTL15   [get_ports switch]


# For Programable Clock Source over SMA
set_property PACKAGE_PIN M21 [get_ports clk_p]
set_property IOSTANDARD LVDS_25 [get_ports clk_p]

set_property PACKAGE_PIN M22 [get_ports clk_n]
set_property IOSTANDARD LVDS_25 [get_ports clk_n]


#-----------------------------------
# push buttons LOCs
#-----------------------------------
# Reset Button on Switch SW5 "Center Button"
# GPIO_SW_C on Bank18 (VADJ 2.5 volt)
set_property PACKAGE_PIN U6 [get_ports rst_n]
set_property IOSTANDARD SSTL15 [get_ports rst_n]


#-----------------------------------
# End
#-----------------------------------
