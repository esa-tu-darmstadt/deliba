#Enable BDC DFX
set_property PR_FLOW 1 [current_project] 

current_bd_design [get_bd_designs design_1]
#Enable DFX for the BDC rp1
set_property -dict [list CONFIG.ENABLE_DFX {true}] [get_bd_cells rp1]
#Lock the Static-RP interface
set_property -dict [list CONFIG.LOCK_PROPAGATE {true}] [get_bd_cells rp1]
#Set the Aperture for the S00_AXI interface to rp1 to be 128K
#set_property -dict [list APERTURES {{0xA000_0000 128K}}] [get_bd_intf_pins /rp1/S_AXI]
#Validate and Save the Top BD
validate_bd_design
save_bd_design

