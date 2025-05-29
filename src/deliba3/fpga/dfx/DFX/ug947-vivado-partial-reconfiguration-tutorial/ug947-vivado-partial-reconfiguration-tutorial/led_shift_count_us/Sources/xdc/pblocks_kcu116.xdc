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
#//  /   /        Filename: pblocks_kcu116.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: KCU116 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_inst_count
#            for pr instance inst_count
#-------------------------------------------------
create_pblock pblock_inst_count
add_cells_to_pblock [get_pblocks pblock_inst_count] [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_inst_count] -add {SLICE_X2Y186:SLICE_X9Y221}
resize_pblock [get_pblocks pblock_inst_count] -add {DSP48E2_X0Y76:DSP48E2_X0Y87}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB18_X0Y76:RAMB18_X0Y87}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB36_X0Y38:RAMB36_X0Y43}

#-------------------------------------------------
# pblock_inst_shift
#            for pr instance inst_shift
#-------------------------------------------------
create_pblock pblock_inst_shift
add_cells_to_pblock [get_pblocks pblock_inst_shift] [get_cells -quiet [list inst_shift]]
resize_pblock [get_pblocks pblock_inst_shift] -add {SLICE_X11Y142:SLICE_X21Y161}
resize_pblock [get_pblocks pblock_inst_shift] -add {DSP48E2_X2Y58:DSP48E2_X3Y63}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB18_X1Y58:RAMB18_X1Y63}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB36_X1Y29:RAMB36_X1Y31}

