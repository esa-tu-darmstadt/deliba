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
#//  /   /        Filename: pblocks_vcu108.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VCU108 board Rev 1.0
#// Design Name: led_shift_shift
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_shift_high 
#            for pr instance inst_shift_high 
#-------------------------------------------------
create_pblock pblock_shift_high
add_cells_to_pblock [get_pblocks pblock_shift_high] [get_cells -quiet [list inst_shift_high]]
resize_pblock [get_pblocks pblock_shift_high] -add {SLICE_X30Y70:SLICE_X38Y109}
resize_pblock [get_pblocks pblock_shift_high] -add {RAMB18_X4Y28:RAMB18_X4Y43}
resize_pblock [get_pblocks pblock_shift_high] -add {RAMB36_X4Y14:RAMB36_X4Y21}
set_property SNAPPING_MODE ON [get_pblocks pblock_shift_high]

#-------------------------------------------------
# pblock_shift_low
#            for pr instance inst_shift_low 
#-------------------------------------------------
create_pblock pblock_shift_low
add_cells_to_pblock [get_pblocks pblock_shift_low] [get_cells -quiet [list inst_shift_low]]
resize_pblock [get_pblocks pblock_shift_low] -add {SLICE_X14Y130:SLICE_X23Y164}
resize_pblock [get_pblocks pblock_shift_low] -add {RAMB18_X1Y52:RAMB18_X2Y65}
resize_pblock [get_pblocks pblock_shift_low] -add {RAMB36_X1Y26:RAMB36_X2Y32}
set_property SNAPPING_MODE ON [get_pblocks pblock_shift_low]

