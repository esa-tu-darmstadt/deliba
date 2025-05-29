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
##  /   /        Filename: pb_rp_count.xdc
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
create_pblock pb_rp_count
add_cells_to_pblock [get_pblocks pb_rp_count] [get_cells -quiet [list mb_dfx_controller_i/rp2]]
resize_pblock [get_pblocks pb_rp_count] -add {CLOCKREGION_X2Y4:CLOCKREGION_X2Y4}
set_property CONTAIN_ROUTING 1 [get_pblocks pb_rp_count]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pb_rp_count]
set_property SNAPPING_MODE FINE_GRAINED [get_pblocks pb_rp_count]
set_property IS_SOFT FALSE [get_pblocks pb_rp_count]
