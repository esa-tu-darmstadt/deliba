source ./design_settings.tcl
set loc "./Implement/sub_counters"

puts "#HD: Running implementation count_up_count_up"
create_project -in_memory -part $part > $loc/create_project.log
add_file $loc/top_static_counters.dcp
add_file ./Synth/count_up/count_synth.dcp
set_property SCOPED_TO_CELLS {inst_RP/inst_count_upper inst_RP/inst_count_lower} [get_files ./Synth/count_up/count_synth.dcp]
add_files ./Sources/xdc/pblocks_counters_$xboard.xdc
set_property USED_IN {implementation} [get_files ./Sources/xdc/pblocks_counters_$xboard.xdc]
set_property PROCESSING_ORDER LATE [get_files ./Sources/xdc/pblocks_counters_$xboard.xdc]
link_design -mode default -reconfig_partitions {inst_RP/inst_count_upper inst_RP/inst_count_lower} -part $part -top top
write_checkpoint -force $loc/top_count_up_up_link_design.dcp > $loc/write_checkpoint.log
opt_design > $loc/top_count_up_up_opt_design.log
puts "	#HD: Completed: opt_design"
write_checkpoint -force $loc/top_count_up_up_opt_design.dcp > $loc/write_checkpoint.log
place_design > $loc/top_count_up_up_place_design.log
puts "	#HD: Completed: place_design"
write_checkpoint -force $loc/top_count_up_up_place_design.dcp > $loc/write_checkpoint.log
phys_opt_design > $loc/top_count_up_up_phys_opt_design.log
puts "	#HD: Completed: phys_opt_design"
write_checkpoint -force $loc/top_count_up_up_phys_opt_design.dcp > $loc/write_checkpoint.log
route_design > $loc/top_count_up_up_route_design.log
puts "	#HD: Completed: route_design" 
write_checkpoint -force $loc/top_count_up_up_route_design.dcp > $loc/write_checkpoint.log
write_checkpoint -force -cell inst_RP/inst_count_upper $loc/count_up_upper_RM.dcp
write_checkpoint -force -cell inst_RP/inst_count_lower $loc/count_up_lower_RM.dcp
report_utilization -file $loc/reports/top_count_up_up_utilization_route_design.rpt > $loc/temp.log
report_route_status -file $loc/reports/top_count_up_up_route_status.rpt > $loc/temp.log
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $loc/reports/top_count_up_up_timing_summary.rpt > $loc/temp.log
debug::report_design_status > $loc/reports/top_count_up_up_design_status.rpt
report_drc -ruledeck bitstream_checks -name top -file $loc/reports/top_count_up_up_drc_bitstream_checks.rpt > $loc/reports/temp.log

update_design -black_box -cell inst_RP/inst_count_upper
update_design -black_box -cell inst_RP/inst_count_lower
lock_design -level routing
write_checkpoint -force $loc/top_static_counters_static.dcp
close_project


puts "#HD: Running implementation count_down_count_down"
create_project -in_memory -part $part > $loc/create_project.log
add_file $loc/top_static_counters_static.dcp
add_file ./Synth/count_down/count_synth.dcp
set_property SCOPED_TO_CELLS {inst_RP/inst_count_upper inst_RP/inst_count_lower} [get_files ./Synth/count_down/count_synth.dcp]
link_design -mode default -reconfig_partitions {inst_RP/inst_count_upper inst_RP/inst_count_lower} -part $part -top top
write_checkpoint -force $loc/top_count_down_down_link_design.dcp > $loc/write_checkpoint.log
opt_design > $loc/top_count_down_down_opt_design.log
puts "	#HD: Completed: opt_design"
write_checkpoint -force $loc/top_count_down_down_opt_design.dcp > $loc/write_checkpoint.log
place_design > $loc/top_count_down_down_place_design.log
puts "	#HD: Completed: place_design"
write_checkpoint -force $loc/top_count_down_down_place_design.dcp > $loc/write_checkpoint.log
phys_opt_design > $loc/top_count_down_down_phys_opt_design.log
puts "	#HD: Completed: phys_opt_design"
write_checkpoint -force $loc/top_count_down_down_phys_opt_design.dcp > $loc/write_checkpoint.log
route_design > $loc/top_count_down_down_route_design.log
puts "	#HD: Completed: route_design" 
write_checkpoint -force $loc/top_count_down_down_route_design.dcp > $loc/write_checkpoint.log
write_checkpoint -force -cell inst_RP/inst_count_upper $loc/count_down_upper_RM.dcp
write_checkpoint -force -cell inst_RP/inst_count_lower $loc/count_down_lower_RM.dcp
report_utilization -file $loc/reports/top_count_down_down_utilization_route_design.rpt > $loc/temp.log
report_route_status -file $loc/reports/top_count_down_down_route_status.rpt > $loc/temp.log
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $loc/reports/top_count_down_down_timing_summary.rpt > $loc/temp.log
debug::report_design_status > $loc/reports/top_count_down_down_design_status.rpt
report_drc -ruledeck bitstream_checks -name top -file $loc/reports/top_count_down_down_drc_bitstream_checks.rpt > $loc/reports/temp.log
close_project


open_checkpoint ./Implement/sub_counters/top_count_up_up_route_design.dcp
pr_recombine -cell inst_RP
write_checkpoint -force ./Implement/sub_counters/top_count_up_up_recombined.dcp
puts "	#HD: Completed"
close_project