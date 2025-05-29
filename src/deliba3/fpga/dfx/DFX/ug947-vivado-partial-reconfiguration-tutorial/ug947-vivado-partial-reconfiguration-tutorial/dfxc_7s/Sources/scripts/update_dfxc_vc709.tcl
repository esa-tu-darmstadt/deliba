global ipDir
regexp {(.*)\/.*\.tcl} [info script] full scriptDir
if {![info exists ipDir]} {
   set ipDir "${scriptDir}/../ip"
}
add_files $ipDir/dfx_controller/dfx_controller.xci
set config [get_property CONFIG.ALL_PARAMS [get_ips dfx_controller]]

# Load the DFX Controller's API the build
source [get_property REPOSITORY [get_ipdefs *dfx_controller:1.0]]/xilinx/dfx_controller_v1_0/tcl/api.tcl -notrace

# This script defines the bitstream addresses and sizes
#
source $scriptDir/dfx_info_vc709.tcl -notrace

set descriptor [dfx_controller_v1_0::netlist::get_descriptor $config "i_dfx_controller/U0" ]

# NOTE: The exact reset durations set here are unimportant
#dfx_controller_v1_0::netlist::set_rm_bs_address     descriptor vs_shift rm_shift_left $rm_shift_left_address
#dfx_controller_v1_0::netlist::set_rm_bs_size        descriptor vs_shift rm_shift_left $rm_shift_left_size
#dfx_controller_v1_0::netlist::set_rm_reset_duration descriptor vs_shift rm_shift_left 3

#dfx_controller_v1_0::netlist::set_rm_bs_address     descriptor vs_shift rm_shift_right $rm_shift_right_address
#dfx_controller_v1_0::netlist::set_rm_bs_size        descriptor vs_shift rm_shift_right $rm_shift_right_size
#dfx_controller_v1_0::netlist::set_rm_reset_duration descriptor vs_shift rm_shift_right 10

dfx_controller_v1_0::netlist::set_rm_bs_address     descriptor vs_count rm_count_up $rm_count_up_address
dfx_controller_v1_0::netlist::set_rm_bs_size        descriptor vs_count rm_count_up $rm_count_up_size
#dfx_controller_v1_0::netlist::set_rm_reset_duration descriptor vs_count rm_count_up 12

dfx_controller_v1_0::netlist::set_rm_bs_address     descriptor vs_count rm_count_down $rm_count_down_address
dfx_controller_v1_0::netlist::set_rm_bs_size        descriptor vs_count rm_count_down $rm_count_down_size
#dfx_controller_v1_0::netlist::set_rm_reset_duration descriptor vs_count rm_count_down 16

dfx_controller_v1_0::netlist::apply_descriptor descriptor

