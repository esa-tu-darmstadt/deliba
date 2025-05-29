set part "xcvu9p-flga2104-2L-e"

add_files ./abstract_shell/ab_sh_count.dcp
add_files ./project_dfxc_vcu118/project_dfxc_vcu118.runs/count_down_synth_1/count.dcp
set_property SCOPED_TO_CELLS {u_count} [get_files ./project_dfxc_vcu118/project_dfxc_vcu118.runs/count_down_synth_1/count.dcp] 

link_design -mode default -reconfig_partitions {u_count} -part $part -top top

opt_design
place_design
route_design

write_checkpoint -force ./abstract_shell/abs_count_down/abstract_shell_count_down_routed.dcp
write_checkpoint -force -cell u_count ./abstract_shell/abs_count_down/rm_count_down_route_design.dcp
