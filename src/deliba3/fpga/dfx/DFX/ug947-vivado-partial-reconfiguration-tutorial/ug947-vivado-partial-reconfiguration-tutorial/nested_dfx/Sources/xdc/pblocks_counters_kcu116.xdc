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
#//  /   /        Filename: pblocks_counters_kcu116.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: KCU116 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Nested Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_inst_count_upper
#            for pr instance inst_count_upper
#-------------------------------------------------
create_pblock pblock_inst_count_upper
add_cells_to_pblock [get_pblocks pblock_inst_count_upper] [get_cells -quiet [list inst_RP/inst_count_upper]]
resize_pblock [get_pblocks pblock_inst_count_upper] -add {SLICE_X9Y130:SLICE_X24Y169}
resize_pblock [get_pblocks pblock_inst_count_upper] -add {DSP48E2_X1Y52:DSP48E2_X3Y67}
resize_pblock [get_pblocks pblock_inst_count_upper] -add {RAMB18_X1Y52:RAMB18_X1Y67}
resize_pblock [get_pblocks pblock_inst_count_upper] -add {RAMB36_X1Y26:RAMB36_X1Y33}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_count_upper]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_count_upper]

#-------------------------------------------------
# pblock_inst_count_lower
#            for pr instance inst_count_lower
#-------------------------------------------------
create_pblock pblock_inst_count_lower
add_cells_to_pblock [get_pblocks pblock_inst_count_lower] [get_cells -quiet [list inst_RP/inst_count_lower]]
resize_pblock [get_pblocks pblock_inst_count_lower] -add {SLICE_X9Y74:SLICE_X24Y114}
resize_pblock [get_pblocks pblock_inst_count_lower] -add {DSP48E2_X1Y30:DSP48E2_X3Y45}
resize_pblock [get_pblocks pblock_inst_count_lower] -add {RAMB18_X1Y30:RAMB18_X1Y45}
resize_pblock [get_pblocks pblock_inst_count_lower] -add {RAMB36_X1Y15:RAMB36_X1Y22}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_count_lower]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_count_lower]

