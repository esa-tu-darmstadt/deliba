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
#//  \   \        Application: Dynamic Function eXchange
#//  /   /        Filename: top_io_vcu118.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VCU118 board Rev 1.0
#// Design Name: led_shift_shift
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

###############################################################################
# Configuration properties for VCU108 
###############################################################################
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]

###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
create_clock -name clk_p -period 5 [get_ports clk_p]


#CLK_125MHZ_P 
set_property PACKAGE_PIN AY24 [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_p]

#CLK_125MHZ_N 
set_property PACKAGE_PIN AY23 [get_ports clk_n]
set_property IOSTANDARD LVDS [get_ports clk_n]


#GPIO_SW_C (SW7) 
set_property PACKAGE_PIN BD23 [get_ports rst_n]
set_property IOSTANDARD LVCMOS12 [get_ports rst_n]


#GPIO_LED_0 
set_property PACKAGE_PIN AT32 [get_ports {shift_low_out[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_low_out[0]}]

#GPIO_LED_1 
set_property PACKAGE_PIN AV34 [get_ports {shift_low_out[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_low_out[1]}]

#GPIO_LED_2 
set_property PACKAGE_PIN AY30 [get_ports {shift_low_out[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_low_out[2]}]

#GPIO_LED_3 
set_property PACKAGE_PIN BB32 [get_ports {shift_low_out[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_low_out[3]}]

#GPIO_LED_4 
set_property PACKAGE_PIN BF32 [get_ports {shift_high_out[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_high_out[0]}]
                                          
#GPIO_LED_5      
set_property PACKAGE_PIN AU37 [get_ports {shift_high_out[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_high_out[1]}]
                                          
#GPIO_LED_6      
set_property PACKAGE_PIN AV36 [get_ports {shift_high_out[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_high_out[2]}]
                                          
#GPIO_LED_7     
set_property PACKAGE_PIN BA37 [get_ports {shift_high_out[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_high_out[3]}]
