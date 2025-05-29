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
#//  /   /        Filename: top_vcu108.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020 
#// \   \  /  \
#//  \___\/\___\
#// Device: KCU105 board Rev 1
#// Design Name: dfxc_us
#// Purpose: Test DFX Controller using tutorial design
#///////////////////////////////////////////////////////////////////////////////
####################################################################################
# Constraints from file : 'top.xdc'
####################################################################################


#-------------------------------------------------
# Clocks
#-------------------------------------------------
create_clock -name clk_p -period 8 [get_ports clk_p]

#-----------------------------------
# ICAPE2 constraints
#-----------------------------------
set icap_clock       [get_clocks -of_objects [get_ports ICAPE3_inst/CLK]]

#-----------------------------------
# LED LOCs
#-----------------------------------
#    LED[0-3] shift
#    LED[4-7] count
#-----------------------------------
#LED0
set_property PACKAGE_PIN AT32     [get_ports shift_out[0]]
set_property IOSTANDARD LVCMOS12 [get_ports shift_out[0]]

# LED1
set_property PACKAGE_PIN AV34     [get_ports shift_out[1]]
set_property IOSTANDARD LVCMOS12 [get_ports shift_out[1]]

# LED2
set_property PACKAGE_PIN AY30     [get_ports shift_out[2]]
set_property IOSTANDARD LVCMOS12 [get_ports shift_out[2]]

# LED3
set_property PACKAGE_PIN BB32     [get_ports shift_out[3]]
set_property IOSTANDARD LVCMOS12 [get_ports shift_out[3]]


# LED4
set_property PACKAGE_PIN BF32     [get_ports count_out[0]]
set_property IOSTANDARD LVCMOS12 [get_ports count_out[0]]

# LED5
set_property PACKAGE_PIN AV36     [get_ports count_out[1]]
set_property IOSTANDARD LVCMOS12 [get_ports count_out[1]]

# LED6
set_property PACKAGE_PIN AY35     [get_ports count_out[2]]
set_property IOSTANDARD LVCMOS12 [get_ports count_out[2]]

# LED7
set_property PACKAGE_PIN BA37     [get_ports count_out[3]]
set_property IOSTANDARD LVCMOS12 [get_ports count_out[3]]



#-----------------------------------
# Clocks
#-----------------------------------
set_property PACKAGE_PIN BC8 [get_ports clk_n]
set_property IOSTANDARD LVDS  [get_ports clk_n]
set_property PACKAGE_PIN BC9 [get_ports clk_p]
set_property IOSTANDARD LVDS  [get_ports clk_p]


#-----------------------------------
# Push Buttons 
#-----------------------------------
set_property PACKAGE_PIN E34     [get_ports GPIO_SW_N]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_SW_N]
set_property PACKAGE_PIN D9      [get_ports GPIO_SW_S]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_SW_S]
set_property PACKAGE_PIN M22     [get_ports GPIO_SW_W]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_SW_W]
set_property PACKAGE_PIN A10     [get_ports GPIO_SW_E]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_SW_E]
set_property PACKAGE_PIN AW27    [get_ports GPIO_SW_C]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_SW_C]


#-----------------------------------
# BPI Rom interface
#-----------------------------------
#set_property PACKAGE_PIN AP11     [get_ports rom_data_in[0]]
#set_property PACKAGE_PIN AN11     [get_ports rom_data_in[1]]
#set_property PACKAGE_PIN AM11     [get_ports rom_data_in[2]]
#set_property PACKAGE_PIN AL11     [get_ports rom_data_in[3]]
set_property PACKAGE_PIN AM19     [get_ports rom_data_in[4]]
set_property PACKAGE_PIN AM18     [get_ports rom_data_in[5]]
set_property PACKAGE_PIN AN20     [get_ports rom_data_in[6]]
set_property PACKAGE_PIN AP20     [get_ports rom_data_in[7]]
set_property PACKAGE_PIN AN19     [get_ports rom_data_in[8]]
set_property PACKAGE_PIN AN18     [get_ports rom_data_in[9]]
set_property PACKAGE_PIN AR18     [get_ports rom_data_in[10]]
set_property PACKAGE_PIN AR17     [get_ports rom_data_in[11]]
set_property PACKAGE_PIN AT20     [get_ports rom_data_in[12]]
set_property PACKAGE_PIN AT19     [get_ports rom_data_in[13]]
set_property PACKAGE_PIN AT17     [get_ports rom_data_in[14]]
set_property PACKAGE_PIN AU17     [get_ports rom_data_in[15]]

#set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[0]]
#set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[1]]
#set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[2]]
#set_property IOSTANDARD LVCMOS18 [get_ports rom_data_in[3]]
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

set_property IOSTANDARD LVCMOS18 [get_ports rom_address[0]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[1]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[2]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[3]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[4]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[5]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[6]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[7]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[8]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[9]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[10]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[11]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[12]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[13]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[14]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[15]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[16]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[17]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[18]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[19]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[20]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[21]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[22]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[23]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[24]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_address[25]]
set_property IOSTANDARD LVCMOS18 [get_ports rom_adv_ldn]
#set_property IOSTANDARD LVCMOS18 [get_ports rom_cen]
set_property IOSTANDARD LVCMOS18 [get_ports rom_oen]
set_property IOSTANDARD LVCMOS18 [get_ports rom_wait]
set_property IOSTANDARD LVCMOS18 [get_ports rom_wen]

set_property PACKAGE_PIN AR20     [get_ports rom_address[0]]
set_property PACKAGE_PIN AR19     [get_ports rom_address[1]]
set_property PACKAGE_PIN AV20     [get_ports rom_address[2]]
set_property PACKAGE_PIN AW20     [get_ports rom_address[3]]
set_property PACKAGE_PIN AU19     [get_ports rom_address[4]]
set_property PACKAGE_PIN AU18     [get_ports rom_address[5]]
set_property PACKAGE_PIN AV19     [get_ports rom_address[6]]
set_property PACKAGE_PIN AV18     [get_ports rom_address[7]]
set_property PACKAGE_PIN AW18     [get_ports rom_address[8]]
set_property PACKAGE_PIN AY18     [get_ports rom_address[9]]
set_property PACKAGE_PIN AY19     [get_ports rom_address[10]]
set_property PACKAGE_PIN BA19     [get_ports rom_address[11]]
set_property PACKAGE_PIN BA17     [get_ports rom_address[12]]
set_property PACKAGE_PIN BB17     [get_ports rom_address[13]]
set_property PACKAGE_PIN BB19     [get_ports rom_address[14]]
set_property PACKAGE_PIN BC19     [get_ports rom_address[15]]
set_property PACKAGE_PIN BB18     [get_ports rom_address[16]]
set_property PACKAGE_PIN BC18     [get_ports rom_address[17]]
set_property PACKAGE_PIN AY20     [get_ports rom_address[18]]
set_property PACKAGE_PIN BA20     [get_ports rom_address[19]]
set_property PACKAGE_PIN BD18     [get_ports rom_address[20]]
set_property PACKAGE_PIN BD17     [get_ports rom_address[21]]
set_property PACKAGE_PIN BC20     [get_ports rom_address[22]]
set_property PACKAGE_PIN BD20     [get_ports rom_address[23]]
set_property PACKAGE_PIN BE20     [get_ports rom_address[24]]
set_property PACKAGE_PIN BF20     [get_ports rom_address[25]]
set_property PACKAGE_PIN BF17     [get_ports rom_oen]
set_property PACKAGE_PIN BF16     [get_ports rom_wen]
set_property PACKAGE_PIN AW17     [get_ports rom_adv_ldn]
#set_property PACKAGE_PIN AJ11     [get_ports rom_cen]
set_property PACKAGE_PIN BC23     [get_ports rom_wait]

set_property drive 8 [get_ports [list {shift_out[3]} {shift_out[2]} {shift_out[1]} {shift_out[0]}]]
set_property drive 8 [get_ports [list {count_out[3]} {count_out[2]} {count_out[1]} {count_out[0]}]]

#-------------------------------------------------
# pblock_count 
#-------------------------------------------------
create_pblock pblock_count
add_cells_to_pblock [get_pblocks pblock_count]  [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_count] -add {SLICE_X30Y70:SLICE_X38Y109}
resize_pblock [get_pblocks pblock_count] -add {RAMB18_X4Y28:RAMB18_X4Y43}
resize_pblock [get_pblocks pblock_count] -add {RAMB36_X4Y14:RAMB36_X4Y21}
#resize_pblock pblock_count -add CLOCKREGION_X1Y1:CLOCKREGION_X1Y1
#set_property RESET_AFTER_RECONFIG 1 [get_pblocks pblock_count]

#-------------------------------------------------
# pblock_shift 
#-------------------------------------------------
create_pblock pblock_shift
add_cells_to_pblock [get_pblocks pblock_shift]  [get_cells -quiet [list inst_shift]]
resize_pblock [get_pblocks pblock_shift] -add {SLICE_X14Y130:SLICE_X23Y164}
resize_pblock [get_pblocks pblock_shift] -add {RAMB18_X1Y52:RAMB18_X2Y65}
resize_pblock [get_pblocks pblock_shift] -add {RAMB36_X1Y26:RAMB36_X2Y32}
#resize_pblock pblock_shift -add CLOCKREGION_X0Y2:CLOCKREGION_X0Y2


#-----------------------------------
# End
#-----------------------------------

set_property CFGBVS GND [current_design]
set_property CONFIG_MODE BPI16 [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

