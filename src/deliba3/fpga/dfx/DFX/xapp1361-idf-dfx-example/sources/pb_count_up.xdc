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
##  /   /        Filename: pb_count_up.xdc
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
create_pblock pblock_count
add_cells_to_pblock [get_pblocks pblock_count] [get_cells -quiet [list mb_dfx_controller_i/rp2/iso_3]]
resize_pblock [get_pblocks pblock_count] -add {SLICE_X56Y241:SLICE_X75Y298}
resize_pblock [get_pblocks pblock_count] -add {BUFCE_LEAF_X304Y16:BUFCE_LEAF_X407Y19}
resize_pblock [get_pblocks pblock_count] -add {BUFCE_ROW_FSR_X76Y4:BUFCE_ROW_FSR_X102Y4}
resize_pblock [get_pblocks pblock_count] -add {DSP48E2_X12Y98:DSP48E2_X14Y117}
resize_pblock [get_pblocks pblock_count] -add {HARD_SYNC_X14Y8:HARD_SYNC_X19Y9}
resize_pblock [get_pblocks pblock_count] -add {RAMB18_X7Y98:RAMB18_X9Y117}
resize_pblock [get_pblocks pblock_count] -add {RAMB36_X7Y49:RAMB36_X9Y58}
set_property SNAPPING_MODE FINE_GRAINED [get_pblocks pblock_count]
set_property IS_SOFT FALSE [get_pblocks pblock_count]
set_property PARENT pb_rp_count [get_pblocks pblock_count]
