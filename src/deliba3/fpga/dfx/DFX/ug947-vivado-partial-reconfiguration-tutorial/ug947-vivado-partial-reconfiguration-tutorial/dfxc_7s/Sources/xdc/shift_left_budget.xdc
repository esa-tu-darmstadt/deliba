####Budget constraints for cell inst_shift####
#Input pins:
#Pin: inst_shift/addr[0]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[23]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_0_/I0] 4.0
#Pin: inst_shift/addr[1]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[24]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_1_/I0] 4.0
#Pin: inst_shift/addr[2]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[25]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_2_/I0] 4.0
#Pin: inst_shift/addr[3]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[26]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_3_/I0] 4.0
#Pin: inst_shift/addr[4]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[27]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_4_/I0] 4.0
#Pin: inst_shift/addr[5]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[28]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_5_/I0] 4.0
#Pin: inst_shift/addr[6]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[29]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_6_/I0] 4.0
#Pin: inst_shift/addr[7]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[30]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_7_/I0] 4.0
#Pin: inst_shift/addr[8]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[31]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_8_/I0] 4.0
#Pin: inst_shift/addr[9]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[32]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_9_/I0] 4.0
#Pin: inst_shift/addr[10]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[33]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_10_/I0] 4.0
#Pin: inst_shift/addr[11]	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list {count_value_reg[34]/C}]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_addr_11_/I0] 4.0
#Pin: inst_shift/en	Logic Levels: 0	Clock: clkout0	Period: 10.000	Budget: 0.4
set_max_delay -datapath_only -from [get_pins [list i_dfx_controller/U0/i_vsm_vs_shift/rm_reset_i_reg/C]] -to [get_pins inst_shift/HD_PR_Connection_S_IN_BUF_en/I0] 4.0

#Output pins:
