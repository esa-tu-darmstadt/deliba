##////////////////////////////////////////////////////////////////////////////
## © Copyright 2022 Xilinx, Inc.
## This design is confidential and proprietary of Xilinx, Inc.
## All Rights Reserved.
##/////////////////////////////////////////////////////////////////////////////
##   ____  ____
##  /   /\/   /
## /___/  \  /   Vendor: Xilinx
## \   \   \/    Version: 2021.1
##  \   \        Application: Isolation Design Flow + Dynamic Function eXchange tutorial
##  /   /        Filename: pb_shift_right.xdc
## /___/   /\    Date Last Modified: 15 AUG 2022
## \   \  /  \
##  \___\/\___\
##
##
##
## Board:  ZCU102
## Device: zu9eg
## Design Name: project_idf_dfx_zcu102
## Purpose: Isolation Design Flow + Dynamic Function eXchange Example
create_pblock pblock_shift
add_cells_to_pblock [get_pblocks pblock_shift] [get_cells -quiet [list mb_dfx_controller_i/rp1/iso_2]]
resize_pblock [get_pblocks pblock_shift] -add {SLICE_X56Y300:SLICE_X75Y359}
resize_pblock [get_pblocks pblock_shift] -add {BUFCE_LEAF_X304Y20:BUFCE_LEAF_X407Y23}
resize_pblock [get_pblocks pblock_shift] -add {BUFCE_ROW_FSR_X76Y5:BUFCE_ROW_FSR_X102Y5}
resize_pblock [get_pblocks pblock_shift] -add {DSP48E2_X12Y120:DSP48E2_X14Y143}
resize_pblock [get_pblocks pblock_shift] -add {HARD_SYNC_X14Y10:HARD_SYNC_X19Y11}
resize_pblock [get_pblocks pblock_shift] -add {RAMB18_X7Y120:RAMB18_X9Y143}
resize_pblock [get_pblocks pblock_shift] -add {RAMB36_X7Y60:RAMB36_X9Y71}
set_property SNAPPING_MODE FINE_GRAINED [get_pblocks pblock_shift]
set_property IS_SOFT FALSE [get_pblocks pblock_shift]
set_property PARENT pb_rp_shift [get_pblocks pblock_shift]
