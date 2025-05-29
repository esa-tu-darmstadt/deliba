source ./design_settings.tcl
set loc "./Implement/sub_shifters"

puts "#HD: Running implementation shift_right_shift_right"
create_project -in_memory -part $part > $loc/create_project.log
add_file $loc/top_static_shifters.dcp
add_file ./Synth/shift_right/shift_synth.dcp
set_property SCOPED_TO_CELLS {inst_RP/inst_shift_upper inst_RP/inst_shift_lower} [get_files ./Synth/shift_right/shift_synth.dcp]
add_files ./Sources/xdc/pblocks_shifters_$xboard.xdc
set_property USED_IN {implementation} [get_files ./Sources/xdc/pblocks_shifters_$xboard.xdc]
set_property PROCESSING_ORDER LATE [get_files ./Sources/xdc/pblocks_shifters_$xboard.xdc]
link_design -mode default -reconfig_partitions {inst_RP/inst_shift_upper inst_RP/inst_shift_lower} -part $part -top top
write_checkpoint -force $loc/top_shift_right_right_link_design.dcp > $loc/write_checkpoint.log
opt_design > $loc/top_shift_right_right_opt_design.log
puts "	#HD: Completed: opt_design"
write_checkpoint -force $loc/top_shift_right_right_opt_design.dcp > $loc/write_checkpoint.log
place_design > $loc/top_shift_right_right_place_design.log
puts "	#HD: Completed: place_design"
write_checkpoint -force $loc/top_shift_right_right_place_design.dcp > $loc/write_checkpoint.log
phys_opt_design > $loc/top_shift_right_right_phys_opt_design.log
puts "	#HD: Completed: phys_opt_design"
write_checkpoint -force $loc/top_shift_right_right_phys_opt_design.dcp > $loc/write_checkpoint.log
route_design > $loc/top_shift_right_right_route_design.log
puts "	#HD: Completed: route_design" 
write_checkpoint -force $loc/top_shift_right_right_route_design.dcp > $loc/write_checkpoint.log
write_checkpoint -force -cell inst_RP/inst_shift_upper $loc/shift_right_upper_RM.dcp
write_checkpoint -force -cell inst_RP/inst_shift_lower $loc/shift_right_lower_RM.dcp
report_utilization -file $loc/reports/top_shift_right_right_utilization_route_design.rpt > $loc/temp.log
report_route_status -file $loc/reports/top_shift_right_right_route_status.rpt > $loc/temp.log
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $loc/reports/top_shift_right_right_timing_summary.rpt > $loc/temp.log
debug::report_design_status > $loc/reports/top_shift_right_right_design_status.rpt
report_drc -ruledeck bitstream_checks -name top -file $loc/reports/top_shift_right_right_drc_bitstream_checks.rpt > $loc/reports/temp.log

update_design -black_box -cell inst_RP/inst_shift_upper
update_design -black_box -cell inst_RP/inst_shift_lower
lock_design -level routing
write_checkpoint -force $loc/top_static_shifters_static.dcp
close_project


puts "#HD: Running implementation shift_left_shift_left"
create_project -in_memory -part $part > $loc/create_project.log
add_file $loc/top_static_shifters_static.dcp
add_file ./Synth/shift_left/shift_synth.dcp
set_property SCOPED_TO_CELLS {inst_RP/inst_shift_upper inst_RP/inst_shift_lower} [get_files ./Synth/shift_left/shift_synth.dcp]
link_design -mode default -reconfig_partitions {inst_RP/inst_shift_upper inst_RP/inst_shift_lower} -part $part -top top
write_checkpoint -force $loc/top_shift_left_left_link_design.dcp > $loc/write_checkpoint.log
opt_design > $loc/top_shift_left_left_opt_design.log
puts "	#HD: Completed: opt_design"
write_checkpoint -force $loc/top_shift_left_left_opt_design.dcp > $loc/write_checkpoint.log
place_design > $loc/top_shift_left_left_place_design.log
puts "	#HD: Completed: place_design"
write_checkpoint -force $loc/top_shift_left_left_place_design.dcp > $loc/write_checkpoint.log
phys_opt_design > $loc/top_shift_left_left_phys_opt_design.log
puts "	#HD: Completed: phys_opt_design"
write_checkpoint -force $loc/top_shift_left_left_phys_opt_design.dcp > $loc/write_checkpoint.log
route_design > $loc/top_shift_left_left_route_design.log
puts "	#HD: Completed: route_design" 
write_checkpoint -force $loc/top_shift_left_left_route_design.dcp > $loc/write_checkpoint.log
write_checkpoint -force -cell inst_RP/inst_shift_upper $loc/shift_left_upper_RM.dcp
write_checkpoint -force -cell inst_RP/inst_shift_lower $loc/shift_left_lower_RM.dcp
report_utilization -file $loc/reports/top_shift_left_left_utilization_route_design.rpt > $loc/temp.log
report_route_status -file $loc/reports/top_shift_left_left_route_status.rpt > $loc/temp.log
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $loc/reports/top_shift_left_left_timing_summary.rpt > $loc/temp.log
debug::report_design_status > $loc/reports/top_shift_left_left_design_status.rpt
report_drc -ruledeck bitstream_checks -name top -file $loc/reports/top_shift_left_left_drc_bitstream_checks.rpt > $loc/reports/temp.log
close_project

puts "#HD: Recombining inst_RP/shifters"
open_checkpoint ./Implement/sub_shifters/top_shift_right_right_route_design.dcp
pr_recombine -cell inst_RP
write_checkpoint -force ./Implement/sub_shifters/top_shift_right_right_recombined.dcp
puts "	#HD: Completed"
close_project