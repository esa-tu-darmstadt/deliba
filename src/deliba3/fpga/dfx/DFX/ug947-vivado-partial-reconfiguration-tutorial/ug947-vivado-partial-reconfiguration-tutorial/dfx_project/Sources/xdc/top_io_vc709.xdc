####################################################################################
#///////////////////////////////////////////////////////////////////////////////
#// Copyright (c) 2005-2016 Xilinx, Inc.
#// This design is confidential and proprietary of Xilinx, Inc.
#// All Rights Reserved.
#///////////////////////////////////////////////////////////////////////////////
#//   ____  ____
#//  /   /\/   /
#// /___/  \  /   Vendor: Xilinx
#// \   \   \/    Version: 2020.1
#//  \   \        Application: Dynamic Function eXchange
#//  /   /        Filename: top_io_vc709.xdc
#// /___/   /\    Date Last Modified: 14 FEB 2020
#// \   \  /  \
#//  \___\/\___\
#// Device: VC709 board Rev 1.0
#// Design Name: led_shift_shift
#// Purpose: Dynamic Function eXchange Tutorial
#///////////////////////////////////////////////////////////////////////////////

###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
create_clock -name clk_p -period 5 [get_ports clk_p]

#set configuration voltage
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]


#-----------------------------------
# LED LOCs 
#    LED[0-3] shift
#    LED[4-7] count
#-----------------------------------

# LED0
set_property PACKAGE_PIN AM39     [get_ports shift_low_out[0]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_low_out[0]]

# LED1
set_property PACKAGE_PIN AN39     [get_ports shift_low_out[1]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_low_out[1]]

# LED2
set_property PACKAGE_PIN AR37     [get_ports shift_low_out[2]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_low_out[2]]

# LED3
set_property PACKAGE_PIN AT37     [get_ports shift_low_out[3]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_low_out[3]]

# LED4
set_property PACKAGE_PIN AR35    [get_ports shift_high_out[0]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_high_out[0]]

# LED5
set_property PACKAGE_PIN AP41     [get_ports shift_high_out[1]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_high_out[1]]

# LED6
set_property PACKAGE_PIN AP42     [get_ports shift_high_out[2]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_high_out[2]]

# LED7
set_property PACKAGE_PIN AU39     [get_ports shift_high_out[3]]
set_property IOSTANDARD LVCMOS18 [get_ports shift_high_out[3]]



# For Programmable Clock Source over SMA
set_property PACKAGE_PIN H19 [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_p]

set_property PACKAGE_PIN G18 [get_ports clk_n]
set_property IOSTANDARD LVDS [get_ports clk_n]



#-----------------------------------
# push buttons LOCs
#-----------------------------------
# Reset Button on Switch SW5 "Center Button"
# GPIO_SW_C on Bank18 (VADJ 2.5 volt)
set_property PACKAGE_PIN AV39 [get_ports rst_n]
set_property IOSTANDARD LVCMOS18 [get_ports rst_n]


#-----------------------------------
# End
#-----------------------------------
