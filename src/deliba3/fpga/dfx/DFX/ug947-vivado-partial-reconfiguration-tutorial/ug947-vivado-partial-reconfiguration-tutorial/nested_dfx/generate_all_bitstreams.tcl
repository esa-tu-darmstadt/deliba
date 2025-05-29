#Define first and second order Reconfigurable Partitions
set firstRP1 "inst_RP"
set secondRP1 "inst_shift"
set secondRP2 "inst_count"
#Set to "true" to generate grey box partial bitstreams
set grey "false"

#Create folders for storing full, first-order and second-order bitstreams
file mkdir ./Bitstreams
file mkdir ./Bitstreams/$firstRP1
file mkdir ./Bitstreams/$secondRP1
file mkdir ./Bitstreams/$secondRP2

#Generate a full bitstream for power-on configuration, and second order partial bistreams for shifters
puts "#HD: Generating full and partial bitstreams for shift_right functions"
open_checkpoint ./Implement/sub_shifters/top_shift_right_right_route_design.dcp
write_bitstream -force -no_partial_bitfile ./Bitstreams/top_shift_right_right.bit
write_bitstream -force -cell $firstRP1/${secondRP1}_upper ./Bitstreams/$secondRP1/shift_right_upper_partial.bit
write_bitstream -force -cell $firstRP1/${secondRP1}_lower ./Bitstreams/$secondRP1/shift_right_lower_partial.bit
if {$grey == "true"} {
update_design -black_box -cell $firstRP1/${secondRP1}_upper
update_design -black_box -cell $firstRP1/${secondRP1}_lower
update_design -buffer_ports -cell $firstRP1/${secondRP1}_upper
update_design -buffer_ports -cell $firstRP1/${secondRP1}_lower
place_design
route_design
write_checkpoint -force ./Implement/sub_shifters/top_shift_grey_grey_route_design.dcp
write_bitstream -force -cell $firstRP1/${secondRP1}_upper ./Bitstreams/$secondRP1/shift_upper_grey_partial.bit
write_bitstream -force -cell $firstRP1/${secondRP1}_lower ./Bitstreams/$secondRP1/shift_lower_grey_partial.bit
pr_recombine -cell $firstRP1
#This partial contains grey boxes for shifters, but the first-order RP still contains logic
write_checkpoint -force ./Implement/sub_shifters/top_shift_recombined_grey_grey_route_design.dcp
write_bitstream -force -cell $firstRP1 ./Bitstreams/$firstRP1/${firstRP1}_reconfig_shifters_grey_grey_partial.bit
}
puts "	#HD: Completed"
close_project

#Generate more second-order partial bitstreams for shifters
puts "#HD: Generating partial bitstreams for shift_left functions"
open_checkpoint ./Implement/sub_shifters/top_shift_left_left_route_design.dcp
write_bitstream -force -cell $firstRP1/${secondRP1}_upper ./Bitstreams/$secondRP1/shift_left_upper_partial.bit
write_bitstream -force -cell $firstRP1/${secondRP1}_lower ./Bitstreams/$secondRP1/shift_left_lower_partial.bit
puts "	#HD: Completed"
close_project

#Generate first-order partial bitstreams for shift functions
puts "#HD: Generating partial bitstreams for inst_RP/shift level"
open_checkpoint ./Implement/sub_shifters/top_shift_right_right_recombined.dcp
write_bitstream -force -cell $firstRP1 ./Bitstreams/$firstRP1/${firstRP1}_shift_right_right_recombined_partial.bit
if {$grey == "true"} {
update_design -black_box -cell $firstRP1
update_design -buffer_ports -cell $firstRP1
place_design
route_design
write_checkpoint -force ./Implement/top_static/top_${firstRP1}_grey_route_design.dcp
write_bitstream -force -cell inst_RP ./Bitstreams/$firstRP1/${firstRP1}_grey_partial.bit
}
puts "	#HD: Completed"
close_project


#Generate second-order partial bitstreams for counters
puts "#HD: Generating partial bitstreams for count_up functions"
open_checkpoint ./Implement/sub_counters/top_count_up_up_route_design.dcp
write_bitstream -force -cell $firstRP1/${secondRP2}_upper ./Bitstreams/$secondRP2/count_up_upper_partial.bit
write_bitstream -force -cell $firstRP1/${secondRP2}_lower ./Bitstreams/$secondRP2/count_up_lower_partial.bit
if {$grey == "true"} {
update_design -black_box -cell $firstRP1/${secondRP2}_upper
update_design -black_box -cell $firstRP1/${secondRP2}_lower
update_design -buffer_ports -cell $firstRP1/${secondRP2}_upper
update_design -buffer_ports -cell $firstRP1/${secondRP2}_lower
place_design
route_design
write_checkpoint -force ./Implement/sub_counters/top_count_grey_grey_route_design.dcp
write_bitstream -force -cell $firstRP1/${secondRP2}_upper ./Bitstreams/$secondRP2/count_upper_grey_partial.bit
write_bitstream -force -cell $firstRP1/${secondRP2}_lower ./Bitstreams/$secondRP2/count_lower_grey_partial.bit
pr_recombine -cell inst_RP
#This partial contains grey boxes for counters, but the first-order RP still contains logic
write_checkpoint -force ./Implement/sub_counters/top_count_recombined_grey_grey_route_design.dcp
write_bitstream -force -cell inst_RP ./Bitstreams/$firstRP1/${firstRP1}_reconfig_counters_grey_grey_partial.bit
}
puts "	#HD: Completed"
close_project

#Generate more second-order partial bitstreams for counters
puts "#HD: Generating partial bitstreams for count_down functions"
open_checkpoint ./Implement/sub_counters/top_count_down_down_route_design.dcp
write_bitstream -force -cell $firstRP1/${secondRP2}_upper ./Bitstreams/$secondRP2/count_down_upper_partial.bit
write_bitstream -force -cell $firstRP1/${secondRP2}_lower ./Bitstreams/$secondRP2/count_down_lower_partial.bit
puts "	#HD: Completed"
close_project

#Generate first-order partial bitstreams for count functions
puts "#HD: Generating partial bitstreams for inst_RP/count level"
open_checkpoint ./Implement/sub_counters/top_count_up_up_recombined.dcp
write_bitstream -force -cell inst_RP ./Bitstreams/$firstRP1/${firstRP1}_count_up_up_recombined_partial.bit
puts "	#HD: Completed"
close_project

