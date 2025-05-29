##////////////////////////////////////////////////////////////////////////////
## © Copyright 2021-2022 Xilinx, Inc.
## This design is confidential and proprietary of Xilinx, Inc.
## All Rights Reserved.
##/////////////////////////////////////////////////////////////////////////////
##   ____  ____
##  /   /\/   /
## /___/  \  /   Vendor: Xilinx
## \   \   \/    Version: 2021.1
##  \   \        Application: Isolation Design Flow + Dynamic Function eXchange tutorial
##  /   /        Filename: create_all_bitstreams_zcu102.tcl
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

set prjDir "project_idf_dfx_zcu102"
set bitDir  "./Bitstreams"

if { ![file exists "./Bitstreams"]} {
   exec mkdir Bitstreams
}

open_checkpoint $prjDir/$prjDir.runs/impl_1/mb_dfx_controller_wrapper_routed.dcp
set_property bitstream.general.compress false [current_design]
write_bitstream -force -bin_file $bitDir/top.bit 
close_project

open_checkpoint $prjDir/$prjDir.runs/child_0_impl_1/mb_dfx_controller_wrapper_routed.dcp
set_property bitstream.general.compress false [current_design]
write_bitstream -force -cell mb_dfx_controller_i/rp1 -bin_file $bitDir/rp_u_shift_shift_left_partial.bit 
write_bitstream -force -cell mb_dfx_controller_i/rp2 -bin_file $bitDir/rp_u_count_count_down_partial.bit 
close_project
