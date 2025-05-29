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
#//  /   /        Filename: pblocks_vcu108.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VCU108 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_inst_count 
#            for pr instance inst_count 
#-------------------------------------------------
create_pblock pblock_inst_count
add_cells_to_pblock [get_pblocks pblock_inst_count] [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_inst_count] -add {SLICE_X30Y70:SLICE_X38Y109}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB18_X4Y28:RAMB18_X4Y43}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB36_X4Y14:RAMB36_X4Y21}

#-------------------------------------------------
# pblock_inst_shift
#            for pr instance inst_shift 
#-------------------------------------------------
create_pblock pblock_inst_shift
add_cells_to_pblock [get_pblocks pblock_inst_shift] [get_cells -quiet [list inst_shift]]
resize_pblock [get_pblocks pblock_inst_shift] -add {SLICE_X14Y130:SLICE_X23Y164}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB18_X1Y52:RAMB18_X2Y65}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB36_X1Y26:RAMB36_X2Y32}

