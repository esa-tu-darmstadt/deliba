set prjDir "project_dfxc_vcu118"
set bitDir  "./Bitstreams"

if { ![file exists "./Bitstreams"]} { 
   exec mkdir Bitstreams
}

#includes BIN file generation for all partials

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

open_checkpoint $prjDir/$prjDir.runs/child_0_impl_1/top_routed.dcp
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

