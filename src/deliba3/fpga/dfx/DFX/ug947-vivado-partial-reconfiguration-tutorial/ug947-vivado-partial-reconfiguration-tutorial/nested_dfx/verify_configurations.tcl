#Verify checkpoints with only the first-order Reconfigurable Partition
puts "	#HD: Comparing top-level static regions"
pr_verify ./Implement/sub_shifters/top_shift_right_right_recombined.dcp ./Implement/sub_counters/top_count_up_up_recombined.dcp -file ./Implement/pr_verify_recombined.log
puts "	#HD: Completed"

puts "	#HD: Comparing inst_RP shifter regions"
#Verify checkpoints with the second-order Reconfigurable Partitions for the shift functions
pr_verify ./Implement/sub_shifters/top_shift_right_right_route_design.dcp ./Implement/sub_shifters/top_shift_left_left_route_design.dcp -file ./Implement/pr_verify_shifters.log
puts "	#HD: Completed"

puts "	#HD: Comparing inst_RP counter regions"
#Verify checkpoints with the second-order Reconfigurable Partitions for the count functions
pr_verify ./Implement/sub_counters/top_count_up_up_route_design.dcp ./Implement/sub_counters/top_count_down_down_route_design.dcp -file ./Implement/pr_verify_counters.log
puts "	#HD: Completed"