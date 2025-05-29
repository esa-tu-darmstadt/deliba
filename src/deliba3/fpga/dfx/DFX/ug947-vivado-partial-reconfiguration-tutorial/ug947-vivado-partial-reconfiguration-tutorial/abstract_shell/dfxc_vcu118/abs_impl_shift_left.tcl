set part "xcvu9p-flga2104-2L-e"

add_files ./abstract_shell/ab_sh_shift.dcp
add_files ./project_dfxc_vcu118/project_dfxc_vcu118.runs/shift_left_synth_1/shift.dcp
set_property SCOPED_TO_CELLS {u_shift} [get_files ./project_dfxc_vcu118/project_dfxc_vcu118.runs/shift_left_synth_1/shift.dcp] 

link_design -mode default -reconfig_partitions {u_shift} -part $part -top top

opt_design
place_design
route_design

write_checkpoint -force ./abstract_shell/abs_shift_left/abstract_shell_shift_left_routed.dcp
write_checkpoint -force -cell u_shift ./abstract_shell/abs_shift_left/rm_shift_left_route_design.dcp
