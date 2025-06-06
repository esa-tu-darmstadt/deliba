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
#//  /   /        Filename: pblocks_vcu118.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VCU118 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

#-------------------------------------------------
# pblock_inst_count 
#            for pr instance inst_count 
#-------------------------------------------------
create_pblock pblock_inst_count
add_cells_to_pblock [get_pblocks pblock_inst_count] [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_inst_count] -add {SLICE_X24Y190:SLICE_X29Y229}
resize_pblock [get_pblocks pblock_inst_count] -add {DSP48E2_X3Y76:DSP48E2_X3Y91}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB18_X2Y76:RAMB18_X2Y91}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB36_X2Y38:RAMB36_X2Y45}

#-------------------------------------------------
# pblock_inst_shift
#            for pr instance inst_shift 
#-------------------------------------------------
create_pblock pblock_inst_shift
add_cells_to_pblock [get_pblocks pblock_inst_shift] [get_cells -quiet [list inst_shift]]
resize_pblock [get_pblocks pblock_inst_shift] -add {SLICE_X43Y75:SLICE_X50Y109}
resize_pblock [get_pblocks pblock_inst_shift] -add {DSP48E2_X7Y30:DSP48E2_X7Y43}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB18_X3Y30:RAMB18_X3Y43}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB36_X3Y15:RAMB36_X3Y21}

