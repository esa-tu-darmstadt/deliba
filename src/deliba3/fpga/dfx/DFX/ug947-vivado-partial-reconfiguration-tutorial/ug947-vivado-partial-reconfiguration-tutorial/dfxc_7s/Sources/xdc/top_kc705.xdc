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
#//  /   /        Filename: top_kc705.xdc
#// /___/   /\    Date Last Modified: 12 Feb 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: KC705 board Rev 1.1
#// Design Name: 
#// Purpose: Test DFX Controller using tutorial design
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# Clocks
#-------------------------------------------------
create_clock -name clk_p -period 5 [get_ports clk_p]

#set configuration voltage
set_property CONFIG_VOLTAGE 2.5 [current_design]
set_property CFGBVS VCCO [current_design]

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
#LED0
set_property PACKAGE_PIN AB8     [get_ports shift_out[0]]
set_property IOSTANDARD LVCMOS15 [get_ports shift_out[0]]

# LED1
set_property PACKAGE_PIN AA8     [get_ports shift_out[1]]
set_property IOSTANDARD LVCMOS15 [get_ports shift_out[1]]

# LED2
set_property PACKAGE_PIN AC9     [get_ports shift_out[2]]
set_property IOSTANDARD LVCMOS15 [get_ports shift_out[2]]

# LED3
set_property PACKAGE_PIN AB9     [get_ports shift_out[3]]
set_property IOSTANDARD LVCMOS15 [get_ports shift_out[3]]


# LED4
set_property PACKAGE_PIN AE26    [get_ports count_out[0]]
set_property IOSTANDARD LVCMOS25 [get_ports count_out[0]]

# LED5
set_property PACKAGE_PIN G19     [get_ports count_out[1]]
set_property IOSTANDARD LVCMOS25 [get_ports count_out[1]]

# LED6
set_property PACKAGE_PIN E18     [get_ports count_out[2]]
set_property IOSTANDARD LVCMOS25 [get_ports count_out[2]]

# LED7
set_property PACKAGE_PIN F16     [get_ports count_out[3]]
set_property IOSTANDARD LVCMOS25 [get_ports count_out[3]]



#-----------------------------------
# Clocks
#-----------------------------------
set_property PACKAGE_PIN AD11 [get_ports clk_n]
set_property IOSTANDARD LVDS  [get_ports clk_n]
set_property IOSTANDARD LVDS  [get_ports clk_p]
set_property PACKAGE_PIN AD12 [get_ports clk_p]


#-----------------------------------
# Push Buttons 
#-----------------------------------
set_property PACKAGE_PIN AA12    [get_ports GPIO_SW_N]
set_property IOSTANDARD LVCMOS15 [get_ports GPIO_SW_N]
set_property PACKAGE_PIN AB12    [get_ports GPIO_SW_S]
set_property IOSTANDARD LVCMOS15 [get_ports GPIO_SW_S]
set_property PACKAGE_PIN AC6     [get_ports GPIO_SW_W]
set_property IOSTANDARD LVCMOS15 [get_ports GPIO_SW_W]
set_property PACKAGE_PIN AG5     [get_ports GPIO_SW_E]
set_property IOSTANDARD LVCMOS15 [get_ports GPIO_SW_E]
set_property PACKAGE_PIN G12     [get_ports GPIO_SW_C]
set_property IOSTANDARD LVCMOS25 [get_ports GPIO_SW_C]





#-----------------------------------
# BPI Rom interface
#-----------------------------------
set_property PACKAGE_PIN P24     [get_ports rom_data_in[0]]
set_property PACKAGE_PIN R25     [get_ports rom_data_in[1]]
set_property PACKAGE_PIN R20     [get_ports rom_data_in[2]]
set_property PACKAGE_PIN R21     [get_ports rom_data_in[3]]
set_property PACKAGE_PIN T20     [get_ports rom_data_in[4]]
set_property PACKAGE_PIN T21     [get_ports rom_data_in[5]]
set_property PACKAGE_PIN T22     [get_ports rom_data_in[6]]
set_property PACKAGE_PIN T23     [get_ports rom_data_in[7]]
set_property PACKAGE_PIN U20     [get_ports rom_data_in[8]]
set_property PACKAGE_PIN P29     [get_ports rom_data_in[9]]
set_property PACKAGE_PIN R29     [get_ports rom_data_in[10]]
set_property PACKAGE_PIN P27     [get_ports rom_data_in[11]]
set_property PACKAGE_PIN P28     [get_ports rom_data_in[12]]
set_property PACKAGE_PIN T30     [get_ports rom_data_in[13]]
set_property PACKAGE_PIN P26     [get_ports rom_data_in[14]]
set_property PACKAGE_PIN R26     [get_ports rom_data_in[15]]

set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[0]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[1]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[2]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[3]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[4]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[5]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[6]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[7]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[8]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[9]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[10]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[11]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[12]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[13]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[14]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_data_in[15]]

set_property PACKAGE_PIN V27     [get_ports rom_address[15]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[15]]
set_property PACKAGE_PIN V29     [get_ports rom_address[14]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[14]]
set_property PACKAGE_PIN V30     [get_ports rom_address[13]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[13]]
set_property PACKAGE_PIN V25     [get_ports rom_address[12]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[12]]
set_property PACKAGE_PIN W26     [get_ports rom_address[11]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[11]]
set_property PACKAGE_PIN V19     [get_ports rom_address[10]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[10]]
set_property PACKAGE_PIN V20     [get_ports rom_address[9]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[9]]
set_property PACKAGE_PIN W23     [get_ports rom_address[8]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[8]]
set_property PACKAGE_PIN W24     [get_ports rom_address[7]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[7]]
set_property PACKAGE_PIN U23     [get_ports rom_address[6]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[6]]
set_property PACKAGE_PIN V21     [get_ports rom_address[5]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[5]]
set_property PACKAGE_PIN V22     [get_ports rom_address[4]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[4]]
set_property PACKAGE_PIN U24     [get_ports rom_address[3]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[3]]
set_property PACKAGE_PIN V24     [get_ports rom_address[2]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[2]]
set_property PACKAGE_PIN W21     [get_ports rom_address[1]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[1]]
set_property PACKAGE_PIN W22     [get_ports rom_address[0]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[0]]
set_property PACKAGE_PIN N26     [get_ports rom_address[23]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[23]]
set_property PACKAGE_PIN N19     [get_ports rom_address[22]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[22]]
set_property PACKAGE_PIN N20     [get_ports rom_address[21]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[21]]
set_property PACKAGE_PIN N21     [get_ports rom_address[20]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[20]]
set_property PACKAGE_PIN N22     [get_ports rom_address[19]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[19]]
set_property PACKAGE_PIN N24     [get_ports rom_address[18]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[18]]
set_property PACKAGE_PIN P21     [get_ports rom_address[17]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[17]]
set_property PACKAGE_PIN P22     [get_ports rom_address[16]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[16]]
set_property PACKAGE_PIN M22     [get_ports rom_address[25]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[25]]
set_property PACKAGE_PIN M23     [get_ports rom_address[24]]
set_property IOSTANDARD LVCMOS25 [get_ports rom_address[24]]
set_property PACKAGE_PIN M30     [get_ports rom_adv_ldn]
set_property IOSTANDARD LVCMOS25 [get_ports rom_adv_ldn]
set_property PACKAGE_PIN M24     [get_ports rom_oen]
set_property IOSTANDARD LVCMOS25 [get_ports rom_oen]
set_property PACKAGE_PIN M25     [get_ports rom_wen]
set_property IOSTANDARD LVCMOS25 [get_ports rom_wen]
set_property PACKAGE_PIN U29     [get_ports rom_wait]
set_property IOSTANDARD LVCMOS25 [get_ports rom_wait]
set_property PACKAGE_PIN U19     [get_ports rom_cen]
set_property IOSTANDARD LVCMOS25 [get_ports rom_cen]


#-------------------------------------------------
# pblock_count 
#-------------------------------------------------
create_pblock pblock_count
add_cells_to_pblock [get_pblocks pblock_count]  [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_count] -add {SLICE_X136Y50:SLICE_X145Y99}
resize_pblock [get_pblocks pblock_count] -add {RAMB18_X6Y20:RAMB18_X6Y39}
resize_pblock [get_pblocks pblock_count] -add {RAMB36_X6Y10:RAMB36_X6Y19}
set_property RESET_AFTER_RECONFIG 1 [get_pblocks pblock_count]

#-------------------------------------------------
# pblock_shift 
#-------------------------------------------------
create_pblock pblock_shift
add_cells_to_pblock [get_pblocks pblock_shift]  [get_cells -quiet [list inst_shift]]
resize_pblock pblock_shift -add {SLICE_X4Y150:SLICE_X9Y199}
resize_pblock pblock_shift -add {RAMB18_X0Y60:RAMB18_X0Y79}
resize_pblock pblock_shift -add {RAMB36_X0Y30:RAMB36_X0Y39}
set_property RESET_AFTER_RECONFIG 1 [get_pblocks pblock_shift]

#-----------------------------------
# End
#-----------------------------------
