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
##  /   /        Filename: iso_exempt.xdc
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
set_property HD.ISOLATED_EXEMPT 1 [get_cells mb_dfx_controller_i/static_iso_wrapper/ddr4/inst/u_ddr4_infrastructure/u_bufg_addn_ui_clk_2]
set_property HD.ISOLATED_EXEMPT 1 [get_cells mb_dfx_controller_i/static_iso_wrapper/ddr4/inst/u_ddr4_infrastructure/u_bufg_addn_ui_clk_1]
