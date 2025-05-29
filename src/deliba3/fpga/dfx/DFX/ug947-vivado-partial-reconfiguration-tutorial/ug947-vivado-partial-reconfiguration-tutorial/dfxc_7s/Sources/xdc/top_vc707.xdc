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
#//  /   /        Filename: top_vc707.xdc
#// /___/   /\    Date Last Modified: 12 Feb 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VC707 board Rev 1
#// Design Name: 
#// Purpose: Test DFX Controller using tutorial design
#///////////////////////////////////////////////////////////////////////////////

###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
create_clock -name clk_p -period 5 [get_ports clk_p]

#set configuration voltage
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]

#-----------------------------------
# ICAPE2 constraints
#-----------------------------------
set icap_clock       [get_clocks -of_objects [get_ports ICAPE2_inst/CLK]]

#-----------------------------------
# LED LOCs
#-----------------------------------
#    LED[0-3] shift
#    LED[4-7] count
#-----------------------------------
# LED0
set_property PACKAGE_PIN AM39     [get_ports shift_out[0]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_out[0]]

# LED1
set_property PACKAGE_PIN AN39     [get_ports shift_out[1]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_out[1]]

# LED2
set_property PACKAGE_PIN AR37     [get_ports shift_out[2]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_out[2]]

# LED3
set_property PACKAGE_PIN AT37     [get_ports shift_out[3]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_out[3]]

# LED4
set_property PACKAGE_PIN AR35    [get_ports count_out[0]]
set_property IOSTANDARD LVCMOS18 [get_ports count_out[0]]

# LED5
set_property PACKAGE_PIN AP41     [get_ports count_out[1]]
set_property IOSTANDARD LVCMOS18 [get_ports count_out[1]]

# LED6
set_property PACKAGE_PIN AP42     [get_ports count_out[2]]
set_property IOSTANDARD LVCMOS18 [get_ports count_out[2]]

# LED7
set_property PACKAGE_PIN AU39     [get_ports count_out[3]]
set_property IOSTANDARD LVCMOS18 [get_ports count_out[3]]



#-----------------------------------
# Clocks
#-----------------------------------
set_property PACKAGE_PIN E18 [get_ports clk_n]
set_property IOSTANDARD LVDS  [get_ports clk_n]
set_property IOSTANDARD LVDS  [get_ports clk_p]
set_property PACKAGE_PIN E19 [get_ports clk_p]


#-----------------------------------
# Push Buttons 
#-----------------------------------
set_property PACKAGE_PIN AR40    [get_ports GPIO_SW_N]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_N]
set_property PACKAGE_PIN AP40    [get_ports GPIO_SW_S]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_S]
set_property PACKAGE_PIN AW40     [get_ports GPIO_SW_W]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_W]
set_property PACKAGE_PIN AU38     [get_ports GPIO_SW_E]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_E]
set_property PACKAGE_PIN AV39     [get_ports GPIO_SW_C]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_C]





#-----------------------------------
# BPI Rom interface
#-----------------------------------
set_property PACKAGE_PIN AM36     [get_ports rom_data_in[0]]
set_property PACKAGE_PIN AN36     [get_ports rom_data_in[1]]
set_property PACKAGE_PIN AJ36     [get_ports rom_data_in[2]]
set_property PACKAGE_PIN AJ37     [get_ports rom_data_in[3]]
set_property PACKAGE_PIN AK37     [get_ports rom_data_in[4]]
set_property PACKAGE_PIN AL37     [get_ports rom_data_in[5]]
set_property PACKAGE_PIN AN35     [get_ports rom_data_in[6]]
set_property PACKAGE_PIN AP35     [get_ports rom_data_in[7]]
set_property PACKAGE_PIN AM37     [get_ports rom_data_in[8]]
set_property PACKAGE_PIN AG33     [get_ports rom_data_in[9]]
set_property PACKAGE_PIN AH33     [get_ports rom_data_in[10]]
set_property PACKAGE_PIN AK35     [get_ports rom_data_in[11]]
set_property PACKAGE_PIN AL35     [get_ports rom_data_in[12]]
set_property PACKAGE_PIN AJ31     [get_ports rom_data_in[13]]
set_property PACKAGE_PIN AH34     [get_ports rom_data_in[14]]
set_property PACKAGE_PIN AJ35     [get_ports rom_data_in[15]]

set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[0]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[1]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[2]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[3]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[4]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[5]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[6]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[7]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[8]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[9]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[10]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[11]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[12]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[13]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[14]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[15]]

set_property PACKAGE_PIN AM32     [get_ports rom_address[15]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[15]]
set_property PACKAGE_PIN AM33     [get_ports rom_address[14]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[14]]
set_property PACKAGE_PIN AN33     [get_ports rom_address[13]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[13]]
set_property PACKAGE_PIN AL29     [get_ports rom_address[12]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[12]]
set_property PACKAGE_PIN AL30     [get_ports rom_address[11]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[11]]
set_property PACKAGE_PIN AH29     [get_ports rom_address[10]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[10]]
set_property PACKAGE_PIN AH30     [get_ports rom_address[9]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[9]]
set_property PACKAGE_PIN AJ30     [get_ports rom_address[8]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[8]]
set_property PACKAGE_PIN AK30     [get_ports rom_address[7]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[7]]
set_property PACKAGE_PIN AG29     [get_ports rom_address[6]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[6]]
set_property PACKAGE_PIN AK28     [get_ports rom_address[5]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[5]]
set_property PACKAGE_PIN AK29     [get_ports rom_address[4]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[4]]
set_property PACKAGE_PIN AF30     [get_ports rom_address[3]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[3]]
set_property PACKAGE_PIN AG31     [get_ports rom_address[2]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[2]]
set_property PACKAGE_PIN AH28     [get_ports rom_address[1]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[1]]
set_property PACKAGE_PIN AJ28     [get_ports rom_address[0]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[0]]
set_property PACKAGE_PIN BB39     [get_ports rom_address[23]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[23]]
set_property PACKAGE_PIN BA39     [get_ports rom_address[22]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[22]]
set_property PACKAGE_PIN BA40     [get_ports rom_address[21]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[21]]
set_property PACKAGE_PIN AT41     [get_ports rom_address[20]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[20]]
set_property PACKAGE_PIN AU42     [get_ports rom_address[19]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[19]]
set_property PACKAGE_PIN BA42     [get_ports rom_address[18]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[18]]
set_property PACKAGE_PIN AU41     [get_ports rom_address[17]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[17]]
set_property PACKAGE_PIN AV41     [get_ports rom_address[16]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[16]]
set_property PACKAGE_PIN AW41     [get_ports rom_address[25]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[25]]
set_property PACKAGE_PIN AW42     [get_ports rom_address[24]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[24]]
set_property PACKAGE_PIN AY37     [get_ports rom_adv_ldn]
set_property IOSTANDARD LVCMOS18 [get_ports rom_adv_ldn]
set_property PACKAGE_PIN BA41     [get_ports rom_oen]
set_property IOSTANDARD LVCMOS18 [get_ports rom_oen]
set_property PACKAGE_PIN BB41     [get_ports rom_wen]
set_property IOSTANDARD LVCMOS18 [get_ports rom_wen]
set_property PACKAGE_PIN AM34     [get_ports rom_wait]
set_property IOSTANDARD LVCMOS18 [get_ports rom_wait]
set_property PACKAGE_PIN AL36     [get_ports rom_cen]
set_property IOSTANDARD LVCMOS18 [get_ports rom_cen]



#-------------------------------------------------
# pblock_count 
#-------------------------------------------------
create_pblock pblock_count
add_cells_to_pblock [get_pblocks pblock_count]  [get_cells -quiet [list inst_count]]
resize_pblock pblock_count -add {SLICE_X16Y150:SLICE_X23Y199}
resize_pblock pblock_count -add {DSP48_X0Y60:DSP48_X0Y79}
resize_pblock pblock_count -add {RAMB18_X1Y60:RAMB18_X1Y79}
resize_pblock pblock_count -add {RAMB36_X1Y30:RAMB36_X1Y39}
set_property RESET_AFTER_RECONFIG 1 [get_pblocks pblock_count]

#-------------------------------------------------
# pblock_shift 
#-------------------------------------------------
create_pblock pblock_shift
add_cells_to_pblock [get_pblocks pblock_shift]  [get_cells -quiet [list inst_shift]]
resize_pblock pblock_shift -add {SLICE_X160Y50:SLICE_X167Y99}
resize_pblock pblock_shift -add {DSP48_X15Y20:DSP48_X15Y39}
resize_pblock pblock_shift -add {RAMB18_X10Y20:RAMB18_X10Y39}
resize_pblock pblock_shift -add {RAMB36_X10Y10:RAMB36_X10Y19}
set_property RESET_AFTER_RECONFIG 1 [get_pblocks pblock_shift]

#-----------------------------------
# End
#-----------------------------------
