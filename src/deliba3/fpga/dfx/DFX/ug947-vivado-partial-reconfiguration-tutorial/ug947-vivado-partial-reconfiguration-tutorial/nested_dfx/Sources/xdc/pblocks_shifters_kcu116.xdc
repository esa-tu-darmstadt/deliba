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
#//  /   /        Filename: pblocks_shifters_kcu116.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: KCU116 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Nested Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_inst_shift_upper
#            for pr instance inst_shift_upper
#-------------------------------------------------
create_pblock pblock_inst_shift_upper
add_cells_to_pblock [get_pblocks pblock_inst_shift_upper] [get_cells -quiet [list inst_RP/inst_shift_upper]]
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {SLICE_X14Y130:SLICE_X22Y159}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {DSP48E2_X2Y52:DSP48E2_X3Y63}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {RAMB18_X1Y52:RAMB18_X1Y63}
resize_pblock [get_pblocks pblock_inst_shift_upper] -add {RAMB36_X1Y26:RAMB36_X1Y31}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_shift_upper]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_shift_upper]

#-------------------------------------------------
# pblock_inst_shift_lower
#            for pr instance inst_shift_lower
#-------------------------------------------------
create_pblock pblock_inst_shift_lower
add_cells_to_pblock [get_pblocks pblock_inst_shift_lower] [get_cells -quiet [list inst_RP/inst_shift_lower]]
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {SLICE_X14Y80:SLICE_X22Y109}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {DSP48E2_X2Y32:DSP48E2_X3Y43}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {RAMB18_X1Y32:RAMB18_X1Y43}
resize_pblock [get_pblocks pblock_inst_shift_lower] -add {RAMB36_X1Y16:RAMB36_X1Y21}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_shift_lower]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_shift_lower]

