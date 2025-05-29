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
#//  /   /        Filename: top_io_vcu108.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VCU108 board Rev 1.0
#// Design Name: led_shift_count
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


#CLK_125MHZ_P - VCU108 - BC9/LVDS
set_property PACKAGE_PIN BC9 [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_p]

#CLK_125MHZ_N - VCU108 - BC8/LVDS
set_property PACKAGE_PIN BC8 [get_ports clk_n]
set_property IOSTANDARD LVDS [get_ports clk_n]


#GPIO_SW_C (SW7)  - VCU108 - AW27/LVCMOS18
set_property PACKAGE_PIN AW27 [get_ports rst_n]
set_property IOSTANDARD LVCMOS18 [get_ports rst_n]


#GPIO_LED_0 - VCU108 - AT32/LVCMOS18
set_property PACKAGE_PIN AT32 [get_ports {shift_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[3]}]

#GPIO_LED_1 - VCU108 - AV34/LVCMOS18
set_property PACKAGE_PIN AV34 [get_ports {shift_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[2]}]

#GPIO_LED_2 - VCU108 - AY30/LVCMOS18
set_property PACKAGE_PIN AY30 [get_ports {shift_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[1]}]

#GPIO_LED_3 - VCU108 - BB32/LVCMOS18
set_property PACKAGE_PIN BB32 [get_ports {shift_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {shift_out[0]}]

#GPIO_LED_4 - VCU108 - BF32/LVCMOS18
set_property PACKAGE_PIN BF32 [get_ports {count_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[0]}]
                                          
#GPIO_LED_5 - VCU108 - AV36/LVCMOS18      
set_property PACKAGE_PIN AV36 [get_ports {count_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[1]}]
                                          
#GPIO_LED_6 - VCU108 - AY35/LVCMOS18      
set_property PACKAGE_PIN AY35 [get_ports {count_out[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[2]}]
                                          
#GPIO_LED_7 - VCU108 - BA37/LVCMOS18      
set_property PACKAGE_PIN BA37 [get_ports {count_out[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {count_out[3]}]
