#Create a new reconfigurable module rp1rm2 for RP1 BDC
set curdesign [get_bd_designs design_1]
create_bd_design -boundary_from_container [get_bd_cells /rp1] rp1rm2
#Creating new RM variant for an RP will automatically add the new variant to the SYNTH list of that BDC
current_bd_design $curdesign
set_property -dict [list CONFIG.LIST_SYNTH_BD {rp1rm1.bd:rp1rm2.bd} CONFIG.LIST_SIM_BD {rp1rm1.bd:rp1rm2.bd}] [get_bd_cells /rp1]
current_bd_design [get_bd_designs rp1rm2]
update_compile_order -fileset sources_1


#Populate the New RM
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
set_property -dict [list CONFIG.C_ALL_INPUTS {1}] [get_bd_cells axi_gpio_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
set_property -dict [list CONFIG.CONST_WIDTH {32} CONFIG.CONST_VAL {0xFACEFEED}] [get_bd_cells xlconstant_0]
connect_bd_net [get_bd_pins axi_gpio_0/gpio_io_i] [get_bd_pins xlconstant_0/dout]
connect_bd_intf_net [get_bd_intf_ports S_AXI] [get_bd_intf_pins axi_gpio_0/S_AXI]
connect_bd_net [get_bd_ports s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk]
connect_bd_net [get_bd_ports s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn]

#Address Assignment for GPIO
assign_bd_address -target_address_space /S_AXI [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] -force
set_property offset 0xA0010000 [get_bd_addr_segs {S_AXI/SEG_axi_gpio_0_Reg}]

validate_bd_design
save_bd_design

