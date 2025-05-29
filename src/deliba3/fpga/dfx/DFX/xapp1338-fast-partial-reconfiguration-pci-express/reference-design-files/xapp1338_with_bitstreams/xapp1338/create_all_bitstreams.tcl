set prjDir "PR_over_PCIe"
set top "design_1_wrapper"
set bitDir  "./Bitstreams"

if { ![file exists "./Bitstreams"]} { 
   file mkdir Bitstreams
}


#write shift right partial
#exec cp -f $prjDir.runs/impl_1/${top}.bit $bitDir
open_checkpoint $prjDir/$prjDir.runs/impl_1/${top}_routed.dcp
set_property CONFIG_MODE S_SELECTMAP32 [current_design]
write_bitstream -force -cell inst_shift $bitDir/inst_shift_shift_right_partial.bit
write_debug_probes -force $bitDir/${top}_shift_right.ltx

#write compressed top level bitstream
set_property bitstream.general.compress true [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 51.0 [current_design]
set_property CONFIG_MODE SPIx8 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8 [current_design]
write_bitstream -force -no_partial_bitfile $bitDir/${top}.bit
close_project

#write shift left partial
open_checkpoint $prjDir/$prjDir.runs/child_0_impl_1/${top}_routed.dcp
set_property CONFIG_MODE S_SELECTMAP32 [current_design]
write_bitstream -force -cell inst_shift $bitDir/inst_shift_shift_left_partial.bit
write_debug_probes -force $bitDir/${top}_shift_left.ltx
close_project

