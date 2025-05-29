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
#//  /   /        Filename: pblocks_vc707.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VC707 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_count 
#            for pr instance reconfig_module_count
#-------------------------------------------------
create_pblock pblock_count
add_cells_to_pblock [get_pblocks pblock_count]  [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_count] -add {SLICE_X16Y150:SLICE_X23Y199}
resize_pblock [get_pblocks pblock_count] -add {RAMB18_X1Y60:RAMB18_X1Y79}
resize_pblock [get_pblocks pblock_count] -add {RAMB36_X1Y30:RAMB36_X1Y39}
resize_pblock [get_pblocks pblock_count] -add {DSP48_X0Y60:DSP48_X0Y79}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_count]
set_property SNAPPING_MODE ON [get_pblocks pblock_count]

#-------------------------------------------------
# pblock_shift 
#            for pr instance reconfig_module_shift
#-------------------------------------------------
create_pblock pblock_shift
add_cells_to_pblock [get_pblocks pblock_shift]  [get_cells -quiet [list inst_shift]]
resize_pblock pblock_shift -add {SLICE_X160Y50:SLICE_X167Y99} 
resize_pblock pblock_shift -add {RAMB18_X10Y20:RAMB18_X10Y39} 
resize_pblock pblock_shift -add {RAMB36_X10Y10:RAMB36_X10Y19}
resize_pblock pblock_shift -add {DSP48_X15Y20:DSP48_X15Y39}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_shift]
set_property SNAPPING_MODE ON [get_pblocks pblock_shift]