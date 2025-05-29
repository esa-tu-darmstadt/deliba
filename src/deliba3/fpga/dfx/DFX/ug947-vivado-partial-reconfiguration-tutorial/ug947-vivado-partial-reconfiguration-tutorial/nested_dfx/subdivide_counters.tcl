
file delete -force ./Implement/sub_counters
file mkdir ./Implement/sub_counters
file mkdir ./Implement/sub_counters/reports
open_checkpoint ./Implement/top_static/top_route_design.dcp
puts "#HD: Subdividing inst_RP into second-order counter RPs"
pr_subdivide -cell inst_RP -subcells {inst_RP/inst_count_upper inst_RP/inst_count_lower} ./Synth/reconfig_counters/reconfig_inst_synth.dcp
write_checkpoint -force ./Implement/sub_counters/top_static_counters.dcp
puts "	#HD: Completed"
close_project

