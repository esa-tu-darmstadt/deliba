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
#//  /   /        Filename: top_kcu116.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: KCU116 board Rev 1.0
#// Design Name: led_shift_shift
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

###############################################################################
# Configuration properties for kcu116 
###############################################################################
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]

###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
create_clock -name clk_p -period 5 [get_ports clk_p]

#-------------------------------------------------
# pblock_inst_shift_high
#            for pr instance inst_shift_high
#-------------------------------------------------
create_pblock pblock_inst_shift_high
add_cells_to_pblock [get_pblocks pblock_inst_shift_high] [get_cells -quiet [list inst_shift_high]]
resize_pblock [get_pblocks pblock_inst_shift_high] -add {SLICE_X2Y186:SLICE_X9Y221}   
resize_pblock [get_pblocks pblock_inst_shift_high] -add {DSP48E2_X0Y76:DSP48E2_X0Y87} 
resize_pblock [get_pblocks pblock_inst_shift_high] -add {RAMB18_X0Y76:RAMB18_X0Y87}   
resize_pblock [get_pblocks pblock_inst_shift_high] -add {RAMB36_X0Y38:RAMB36_X0Y43}   


#-------------------------------------------------
# pblock_inst_shift_low
#            for pr instance inst_shift_low
#-------------------------------------------------
create_pblock pblock_inst_shift_low
add_cells_to_pblock [get_pblocks pblock_inst_shift_low] [get_cells -quiet [list inst_shift_low]]
resize_pblock [get_pblocks pblock_inst_shift_low] -add {SLICE_X11Y142:SLICE_X21Y161}  
resize_pblock [get_pblocks pblock_inst_shift_low] -add {DSP48E2_X2Y58:DSP48E2_X3Y63}  
resize_pblock [get_pblocks pblock_inst_shift_low] -add {RAMB18_X1Y58:RAMB18_X1Y63}    
resize_pblock [get_pblocks pblock_inst_shift_low] -add {RAMB36_X1Y29:RAMB36_X1Y31}    


#CLK_300MHZ_P 
set_property PACKAGE_PIN K22 [get_ports clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_p]

#CLK_300MHZ_N 
set_property PACKAGE_PIN K23 [get_ports clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_n]

#GPIO_SW_C (SW7) 
set_property PACKAGE_PIN A9 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

#GPIO_LED_0 
set_property PACKAGE_PIN C9 [get_ports {shift_low_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_low_out[0]}]

#GPIO_LED_1 
set_property PACKAGE_PIN D9 [get_ports {shift_low_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_low_out[1]}]

#GPIO_LED_2 
set_property PACKAGE_PIN E10 [get_ports {shift_low_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_low_out[2]}]

#GPIO_LED_3 
set_property PACKAGE_PIN E11 [get_ports {shift_low_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_low_out[3]}]

#GPIO_LED_4 
set_property PACKAGE_PIN F9 [get_ports {shift_high_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_high_out[0]}]
                                         
#GPIO_LED_5       
set_property PACKAGE_PIN F10 [get_ports {shift_high_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_high_out[1]}]
                                         
#GPIO_LED_6      
set_property PACKAGE_PIN G9 [get_ports {shift_high_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_high_out[2]}]
                                         
#GPIO_LED_7     
set_property PACKAGE_PIN G10 [get_ports {shift_high_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_high_out[3]}]
