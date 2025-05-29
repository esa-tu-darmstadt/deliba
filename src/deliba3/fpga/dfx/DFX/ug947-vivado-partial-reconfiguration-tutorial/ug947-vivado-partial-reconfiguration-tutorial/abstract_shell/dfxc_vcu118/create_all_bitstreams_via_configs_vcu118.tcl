set prjDir "project_dfxc_vcu118"
set absDir "abstract_shell"
set bitDir  "./Bitstreams"
set part "xcvu9p-flga2104-2L-e"

if { ![file exists "./Bitstreams"]} { 
   exec mkdir Bitstreams
}

#includes BIN file generation for all partials

#create partial bitstreams for count_up and shift_right from impl_1, with and without per-frame CRC
exec cp -f $prjDir/$prjDir.runs/impl_1/top.bit $bitDir
open_checkpoint $prjDir/$prjDir.runs/impl_1/top_routed.dcp
set_property bitstream.general.compress false [current_design]
#write_bitstream -force -no_partial_bitfile $bitDir/top.bit
set_property CONFIG_MODE "S_SELECTMAP32" [current_design]
write_bitstream -force -cell u_count $bitDir/u_count_count_up_partial.bit
write_bitstream -force -cell u_shift $bitDir/u_shift_shift_right_partial.bit
set_property bitstream.general.perFrameCRC yes [current_design]
write_bitstream -force -cell u_count $bitDir/u_count_count_up_partial_pfcrc.bit
write_bitstream -force -cell u_shift $bitDir/u_shift_shift_right_partial_pfcrc.bit
set_property bitstream.general.perFrameCRC no [current_design]
write_debug_probes -force $bitDir/top_count_up_shift_right.ltx
close_project

#create a child_0 checkpoint by assembling the locked static checkpoint with RMs from abstract shells
create_project -in_memory -part $part 
add_files ./$prjDir/$prjDir.runs/impl_1/top_routed_bb.dcp
add_files ./$absDir/abs_shift_left/rm_shift_left_route_design.dcp 
set_property SCOPED_TO_CELLS {inst_shift} [get_files ./$absDir/abs_shift_left/rm_shift_left_route_design.dcp] 
add_files ./$absDir/abs_count_down/rm_count_down_route_design.dcp
set_property SCOPED_TO_CELLS {inst_count} [get_files ./$absDir/abs_count_down/rm_count_down_route_design.dcp] 
link_design -mode default -reconfig_partitions {u_shift u_count} -part $part -top top
write_checkpoint -force $absDir/config_shift_left_count_down_import/top_route_design.dcp

#create partial bitstreams for count_down from the assembled child_0 checkpoint, with and without per-frame CRC
set_property bitstream.general.compress false [current_design]
set_property CONFIG_MODE "S_SELECTMAP32" [current_design]
write_bitstream -force -cell u_count $bitDir/u_count_count_down_partial.bit
write_bitstream -force -cell u_shift $bitDir/u_shift_shift_left_partial.bit
set_property bitstream.general.perFrameCRC yes [current_design]
write_bitstream -force -cell u_count $bitDir/u_count_count_down_partial_pfcrc.bit
write_bitstream -force -cell u_shift $bitDir/u_shift_shift_left_partial_pfcrc.bit
set_property bitstream.general.perFrameCRC no [current_design]
write_debug_probes -force $bitDir/top_count_down_shift_left.ltx
close_project

