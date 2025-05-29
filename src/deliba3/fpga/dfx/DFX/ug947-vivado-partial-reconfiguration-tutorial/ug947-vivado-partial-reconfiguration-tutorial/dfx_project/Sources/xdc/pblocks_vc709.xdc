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
#//  /   /        Filename: pblocks_vc709.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VC709 board Rev 1.0
#// Design Name: led_shift_shift
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_shift_high 
#            for pr instance reconfig_module_count
#-------------------------------------------------
create_pblock pblock_shift_high
add_cells_to_pblock [get_pblocks pblock_shift_high]  [get_cells -quiet [list inst_shift_high]]
resize_pblock [get_pblocks pblock_shift_high] -add {SLICE_X14Y150:SLICE_X23Y199}
resize_pblock [get_pblocks pblock_shift_high] -add {RAMB18_X1Y60:RAMB18_X1Y79}
resize_pblock [get_pblocks pblock_shift_high] -add {RAMB36_X1Y30:RAMB36_X1Y39}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_shift_high]
set_property SNAPPING_MODE ON [get_pblocks pblock_shift_high]

#-------------------------------------------------
# pblock_shift_low 
#            for pr instance reconfig_module_shift
#-------------------------------------------------

create_pblock pblock_shift_low
add_cells_to_pblock [get_pblocks pblock_shift_low]  [get_cells -quiet [list inst_shift_low]]
resize_pblock [get_pblocks pblock_shift_low] -add {SLICE_X160Y50:SLICE_X169Y99} 
resize_pblock [get_pblocks pblock_shift_low] -add {RAMB18_X10Y20:RAMB18_X10Y39} 
resize_pblock [get_pblocks pblock_shift_low] -add {RAMB36_X10Y10:RAMB36_X10Y19}
resize_pblock [get_pblocks pblock_shift_low] -add {DSP48_X14Y20:DSP48_X14Y39}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_shift_low]
set_property SNAPPING_MODE ON [get_pblocks pblock_shift_low]