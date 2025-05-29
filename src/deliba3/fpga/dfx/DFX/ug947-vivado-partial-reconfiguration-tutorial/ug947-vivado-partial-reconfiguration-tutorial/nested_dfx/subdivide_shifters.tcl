
file delete -force ./Implement/sub_shifters
file mkdir ./Implement/sub_shifters
file mkdir ./Implement/sub_shifters/reports
open_checkpoint ./Implement/top_static/top_route_design.dcp
puts "#HD: Subdividing inst_RP into second-order shifter RPs"
pr_subdivide -cell inst_RP -subcells {inst_RP/inst_shift_upper inst_RP/inst_shift_lower} ./Synth/reconfig_shifters/reconfig_inst_synth.dcp
write_checkpoint -force ./Implement/sub_shifters/top_static_shifters.dcp
puts "	#HD: Completed"
close_project

