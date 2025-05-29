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
##  /   /        Filename: pins.xdc
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
set_property PACKAGE_PIN AG15 [get_ports GPIO_SW_N]
set_property IOSTANDARD LVCMOS33 [get_ports GPIO_SW_N]
set_property PACKAGE_PIN AF15 [get_ports GPIO_SW_W]
set_property IOSTANDARD LVCMOS33 [get_ports GPIO_SW_W]
set_property PACKAGE_PIN AE15 [get_ports GPIO_SW_S]
set_property IOSTANDARD LVCMOS33 [get_ports GPIO_SW_S]
set_property PACKAGE_PIN AE14 [get_ports GPIO_SW_E]
set_property IOSTANDARD LVCMOS33 [get_ports GPIO_SW_E]
set_property PACKAGE_PIN AG13 [get_ports GPIO_SW_C]
set_property IOSTANDARD LVCMOS33 [get_ports GPIO_SW_C]


set_property PACKAGE_PIN AL12 [get_ports {count_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[3]}]
set_property PACKAGE_PIN AH14 [get_ports {count_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[2]}]
set_property PACKAGE_PIN AH13 [get_ports {count_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[1]}]
set_property PACKAGE_PIN AJ15 [get_ports {count_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[0]}]
set_property PACKAGE_PIN AJ14 [get_ports {shift_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[3]}]
set_property PACKAGE_PIN AE13 [get_ports {shift_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[2]}]
set_property PACKAGE_PIN AF13 [get_ports {shift_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[1]}]
set_property PACKAGE_PIN AG14 [get_ports {shift_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {shift_out[0]}]
