#Create a level of hierarchy for rp1
set curdesign [current_bd_design]
group_bd_cells rp1 [get_bd_cells axi_gpio_1]
move_bd_cells [get_bd_cells rp1] [get_bd_cells xlconstant_1]

#Create a level of hierarchy for static_region
set curdesign [current_bd_design]
group_bd_cells static_region [get_bd_cells zynq_ultra_ps_e_0]
move_bd_cells [get_bd_cells static_region] [get_bd_cells smartconnect_0]
move_bd_cells [get_bd_cells static_region] [get_bd_cells proc_sys_reset_0]
move_bd_cells [get_bd_cells static_region] [get_bd_cells clk_wiz_0]
move_bd_cells [get_bd_cells static_region] [get_bd_cells dfx_decoupler_0]
move_bd_cells [get_bd_cells static_region] [get_bd_cells axi_gpio_0]
move_bd_cells [get_bd_cells static_region] [get_bd_cells xlconstant_0]

regenerate_bd_layout
validate_bd_design
save_bd_design


#Create the Block Design Container for the hierarchy rp1
set curdesign [current_bd_design]
create_bd_design -cell [get_bd_cells /rp1] rp1rm1
current_bd_design $curdesign
set new_cell [create_bd_cell -type container -reference rp1rm1 rp1_temp]
replace_bd_cell [get_bd_cells /rp1] $new_cell
delete_bd_objs  [get_bd_cells /rp1]
set_property name rp1 $new_cell
# Turn this RM down to 64K
set_property range 64K [get_bd_addr_segs {static_region/zynq_ultra_ps_e_0/Data/SEG_axi_gpio_1_Reg}]

validate_bd_design
save_bd_design

current_bd_design [get_bd_designs design_1]
upgrade_bd_cells [get_bd_cells rp1]
validate_bd_design 
save_bd_design

