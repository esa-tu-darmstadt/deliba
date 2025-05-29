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
##  /   /        Filename: pb_iso_wrapper.xdc
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
create_pblock pblock_iso_wrapper
add_cells_to_pblock [get_pblocks pblock_iso_wrapper] [get_cells -quiet [list mb_dfx_controller_i/static_iso_wrapper]]
resize_pblock [get_pblocks pblock_iso_wrapper] -add {CLOCKREGION_X3Y4:CLOCKREGION_X3Y6 CLOCKREGION_X0Y0:CLOCKREGION_X3Y3}
resize_pblock [get_pblocks pblock_iso_wrapper] -add {CLOCKREGION_X2Y6:CLOCKREGION_X2Y6 CLOCKREGION_X0Y4:CLOCKREGION_X1Y5}
set_property SNAPPING_MODE FINE_GRAINED [get_pblocks pblock_iso_wrapper]
