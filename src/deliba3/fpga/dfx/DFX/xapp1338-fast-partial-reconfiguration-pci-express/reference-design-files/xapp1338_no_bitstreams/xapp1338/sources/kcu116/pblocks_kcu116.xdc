####################################################################################
#///////////////////////////////////////////////////////////////////////////////
#// Copyright (c) 2005-2016 Xilinx, Inc.
#// This design is confidential and proprietary of Xilinx, Inc.
#// All Rights Reserved.
#///////////////////////////////////////////////////////////////////////////////
#//   ____  ____
#//  /   /\/   /
#// /___/  \  /   Vendor: Xilinx
#// \   \   \/    Version: 2017.3
#//  \   \        Application: Partial Reconfiguration
#//  /   /        Filename: pblocks_kcu116.xdc
#// /___/   /\    Date Last Modified: 25 JUL 2017
#// \   \  /  \
#//  \___\/\___\
#// Device: KCU116 board Rev 1.0
#// Design Name: led_shift_count
#// Purpose: Partial Reconfiguration Tutorial
#///////////////////////////////////////////////////////////////////////////////


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

