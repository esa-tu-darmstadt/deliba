##////////////////////////////////////////////////////////////////////////////
## © Copyright 2022 Xilinx, Inc.
## This design is confidential and proprietary of Xilinx, Inc.
## All Rights Reserved.
##/////////////////////////////////////////////////////////////////////////////
##   ____  ____
##  /   /\/   /
## /___/  \  /   Vendor: Xilinx
## \   \   \/    Version: 2021.1
##  \   \        Application: Isolation Design Flow + Dynamic Function eXchange tutorial
##  /   /        Filename: create_top_bd.tcl
## /___/   /\    Date Last Modified: 15 AUG 2022
## \   \  /  \
##  \___\/\___\
##
##
##
## Board:  ZCU102
## Device: zu9eg
## Design Name: project_idf_dfx_zcu102
## Purpose: Isolation Design Flow + Dynamic Function eXchange Example
create_project project_idf_dfx_zcu102 ./project_idf_dfx_zcu102 -part xczu9eg-ffvb1156-2-e -force
set_property BOARD_PART [get_board_parts xilinx.com:zcu102:part0:* -latest_file_version] [current_project]
add_files -norecurse -scan_for_includes {./sources/icap_mux.v}
add_files -norecurse -scan_for_includes {./sources/icap_wrapper.v}
add_files -norecurse -scan_for_includes {./sources/edge_det.v}
add_files -norecurse -scan_for_includes {./sources/timer_flag.v}
add_files -norecurse -scan_for_includes {./sources/debouncer.vhd}
add_files -norecurse -scan_for_includes {./sources/count_up/count_up.v}
add_files -norecurse -scan_for_includes {./sources/shift_right/shift_right.v}
add_files -norecurse -scan_for_includes {./sources/shift_left/shift_left.v}
add_files -norecurse -scan_for_includes {./sources/shift_addr.v}
add_files -norecurse -scan_for_includes {./sources/count_down/count_down.v}
update_compile_order -fileset sources_1
import_files -force -norecurse {./sources/icap_mux.v}
import_files -force -norecurse {./sources/icap_wrapper.v}
import_files -force -norecurse {./sources/edge_det.v}
import_files -force -norecurse {./sources/timer_flag.v}
import_files -force -norecurse {./sources/debouncer.vhd}
import_files -force -norecurse {./sources/count_up/count_up.v}
import_files -force -norecurse {./sources/shift_right/shift_right.v}
import_files -force -norecurse {./sources/shift_left/shift_left.v}
import_files -force -norecurse {./sources/shift_addr.v}
import_files -force -norecurse {./sources/count_down/count_down.v}
update_compile_order -fileset sources_1
create_bd_design "mb_dfx_controller"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4 ddr4
endgroup
set_property -dict [list CONFIG.RESET_BOARD_INTERFACE {reset} CONFIG.C0_CLOCK_BOARD_INTERFACE {user_si570_sysclk} CONFIG.C0_DDR4_BOARD_INTERFACE {ddr4_sdram_075} CONFIG.C0.DDR4_TimePeriod {833} CONFIG.C0.DDR4_InputClockPeriod {3332} CONFIG.C0.DDR4_Specify_MandD {false} CONFIG.C0.DDR4_CLKFBOUT_MULT {5} CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5} CONFIG.C0.DDR4_MemoryPart {MT40A256M16GE-075E} CONFIG.C0.DDR4_DataWidth {16} CONFIG.C0.DDR4_CasWriteLatency {12} CONFIG.C0.DDR4_AxiDataWidth {128} CONFIG.C0.DDR4_AxiAddressWidth {29} CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {150} CONFIG.ADDN_UI_CLKOUT2_FREQ_HZ {100} CONFIG.C0.BANK_GROUP_WIDTH {1}] [get_bd_cells ddr4]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze microblaze_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:microblaze -config { axi_intc {0} axi_periph {Enabled} cache {16KB} clk {/ddr4/addn_ui_clkout1 (150 MHz)} cores {1} debug_module {None} ecc {None} local_mem {128KB} preset {None}}  [get_bd_cells microblaze_0]
startgroup
set_property -dict [list CONFIG.C_USE_ICACHE {0} CONFIG.C_ADDR_TAG_BITS {0} CONFIG.C_USE_DCACHE {0} CONFIG.C_DCACHE_ADDR_TAG {0}] [get_bd_cells microblaze_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550 axi_uart16550_0
endgroup
set_property -dict [list CONFIG.UART_BOARD_INTERFACE {uart2_pl}] [get_bd_cells axi_uart16550_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer axi_timer_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_controller dfx_controller_0
endgroup
set_property -dict [list CONFIG.ALL_PARAMS {HAS_AXI_LITE_IF 1 RESET_ACTIVE_LEVEL 0 CP_FIFO_DEPTH 32 CP_FIFO_TYPE lutram CDC_STAGES 6 VS {vs_shift {ID 0 NAME vs_shift RM {rm_shift_right {ID 0 NAME rm_shift_right BS {0 {ID 0 ADDR 0 SIZE 0 CLEAR 0}} RESET_REQUIRED high} rm_shift_left {ID 1 NAME rm_shift_left BS {0 {ID 0 ADDR 0 SIZE 0 CLEAR 0}} RESET_REQUIRED high}} HAS_AXIS_STATUS 1 HAS_POR_RM 1 NUM_HW_TRIGGERS 2 POR_RM rm_shift_right} vs_count {ID 1 NAME vs_count RM {rm_count_up {ID 0 NAME rm_count_up BS {0 {ID 0 ADDR 0 SIZE 0 CLEAR 0}} RESET_REQUIRED high} rm_count_down {ID 1 NAME rm_count_down BS {0 {ID 0 ADDR 0 SIZE 0 CLEAR 0}} RESET_REQUIRED high}} HAS_AXIS_STATUS 1 HAS_POR_RM 1 POR_RM rm_count_up NUM_HW_TRIGGERS 2}} CP_FAMILY ultrascale_plus DIRTY 0 CP_ARBITRATION_PROTOCOL 1} CONFIG.GUI_CP_ARBITRATION_PROTOCOL {1} CONFIG.GUI_SELECT_VS {1} CONFIG.GUI_VS_NEW_NAME {vs_count} CONFIG.GUI_VS_NUM_RMS_ALLOCATED {2} CONFIG.GUI_VS_NUM_HW_TRIGGERS {2} CONFIG.GUI_VS_HAS_AXIS_STATUS {1} CONFIG.GUI_VS_HAS_POR_RM {1} CONFIG.GUI_VS_POR_RM {0} CONFIG.GUI_SELECT_RM {1} CONFIG.GUI_RM_NEW_NAME {rm_count_down} CONFIG.GUI_RM_RESET_REQUIRED {high} CONFIG.GUI_SELECT_TRIGGER_0 {0} CONFIG.GUI_SELECT_TRIGGER_1 {1} CONFIG.GUI_SELECT_TRIGGER_2 {0} CONFIG.GUI_SELECT_TRIGGER_3 {1}] [get_bd_cells dfx_controller_0]
create_bd_cell -type module -reference icap_mux icap_mux_0
create_bd_cell -type module -reference icap_wrapper icap_wrapper_0
create_bd_cell -type module -reference timer_flag timer_flag_0
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/ddr4/addn_ui_clkout1 (150 MHz)} Clk_slave {/ddr4/addn_ui_clkout2 (100 MHz)} Clk_xbar {Auto} Master {/microblaze_0 (Periph)} Slave {/axi_uart16550_0/S_AXI} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_uart16550_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {uart2_pl ( UART ) } Manual_Source {Auto}}  [get_bd_intf_pins axi_uart16550_0/UART]
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout1 (150 MHz)} Freq {150} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins icap_wrapper_0/CLK]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/ddr4/addn_ui_clkout1 (150 MHz)} Clk_slave {Auto} Clk_xbar {/ddr4/addn_ui_clkout1 (150 MHz)} Master {/microblaze_0 (Periph)} Slave {/axi_timer_0/S_AXI} ddr_seg {Auto} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_timer_0/S_AXI]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {ddr4_sdram_075 ( DDR4 SDRAM ) } Manual_Source {Auto}}  [get_bd_intf_pins ddr4/C0_DDR4]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/ddr4/addn_ui_clkout1 (150 MHz)} Clk_slave {/ddr4/c0_ddr4_ui_clk (300 MHz)} Clk_xbar {/ddr4/addn_ui_clkout1 (150 MHz)} Master {/microblaze_0 (Periph)} Slave {/ddr4/C0_DDR4_S_AXI} ddr_seg {Auto} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins ddr4/C0_DDR4_S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {user_si570_sysclk ( User Programmable differential clock ) } Manual_Source {Auto}}  [get_bd_intf_pins ddr4/C0_SYS_CLK]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {reset ( FPGA Reset ) } Manual_Source {Auto}}  [get_bd_pins ddr4/sys_rst]
endgroup
regenerate_bd_layout
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/ddr4/addn_ui_clkout1 (150 MHz)} Clk_slave {/ddr4/c0_ddr4_ui_clk (300 MHz)} Clk_xbar {/ddr4/addn_ui_clkout1 (150 MHz)} Master {/dfx_controller_0/M_AXI_MEM} Slave {/ddr4/C0_DDR4_S_AXI} ddr_seg {Auto} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins dfx_controller_0/M_AXI_MEM]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/ddr4/addn_ui_clkout1 (150 MHz)} Clk_slave {/ddr4/addn_ui_clkout1 (150 MHz)} Clk_xbar {/ddr4/addn_ui_clkout1 (150 MHz)} Master {/microblaze_0 (Periph)} Slave {/dfx_controller_0/s_axi_reg} ddr_seg {Auto} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins dfx_controller_0/s_axi_reg]
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {Custom} Manual_Source {Auto}}  [get_bd_pins rst_ddr4_100M/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {Custom} Manual_Source {Auto}}  [get_bd_pins rst_ddr4_150M/ext_reset_in]
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins timer_flag_0/clk]
regenerate_bd_layout
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1
connect_bd_net [get_bd_pins dfx_controller_0/icap_clk] [get_bd_pins ddr4/addn_ui_clkout1]
connect_bd_net [get_bd_pins icap_mux_0/icap_clk] [get_bd_pins ddr4/addn_ui_clkout1]
connect_bd_net [get_bd_pins dfx_controller_0/vsm_vs_shift_rm_decouple] [get_bd_pins timer_flag_0/vs_shift_decouple]
connect_bd_net [get_bd_pins dfx_controller_0/vsm_vs_count_rm_decouple] [get_bd_pins timer_flag_0/vs_count_decouple]
connect_bd_intf_net [get_bd_intf_pins dfx_controller_0/ICAP] [get_bd_intf_pins icap_mux_0/PRC_ICAP]
connect_bd_intf_net [get_bd_intf_pins dfx_controller_0/vsm_vs_shift_m_axis_status] [get_bd_intf_pins icap_mux_0/vs_shift_axis_status]
connect_bd_intf_net [get_bd_intf_pins dfx_controller_0/vsm_vs_count_m_axis_status] [get_bd_intf_pins icap_mux_0/vs_count_axis_status]
connect_bd_intf_net [get_bd_intf_pins icap_mux_0/ICAP] [get_bd_intf_pins icap_wrapper_0/ICAP]
connect_bd_net [get_bd_pins timer_flag_0/vs_shift_capture] [get_bd_pins axi_timer_0/capturetrig0]
connect_bd_net [get_bd_pins timer_flag_0/vs_count_capture] [get_bd_pins axi_timer_0/capturetrig1]
connect_bd_net [get_bd_pins dfx_controller_0/icap_reset] [get_bd_pins rst_ddr4_150M/peripheral_aresetn]
connect_bd_intf_net [get_bd_intf_pins icap_mux_0/dfx_controller_icap_arbiter] [get_bd_intf_pins dfx_controller_0/icap_arbiter]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__USE__M_AXI_GP0 {0} CONFIG.PSU__USE__M_AXI_GP1 {0} CONFIG.PSU__USE__S_AXI_GP6 {1} CONFIG.PSU__USE__IRQ0 {0}] [get_bd_cells zynq_ultra_ps_e_0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/ddr4/addn_ui_clkout1 (150 MHz)} Clk_slave {Auto} Clk_xbar {/ddr4/addn_ui_clkout1 (150 MHz)} Master {/microblaze_0 (Periph)} Slave {/zynq_ultra_ps_e_0/S_AXI_LPD} ddr_seg {Auto} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_LPD]
regenerate_bd_layout
group_bd_cells hier_mb [get_bd_cells microblaze_0] [get_bd_cells microblaze_0_local_memory]
group_bd_cells hier_ps [get_bd_cells zynq_ultra_ps_e_0]
group_bd_cells hier_dfxc [get_bd_cells timer_flag_0] [get_bd_cells dfx_controller_0] [get_bd_cells icap_wrapper_0] [get_bd_cells icap_mux_0] [get_bd_cells axi_timer_0]
group_bd_cells hier_rst [get_bd_cells rst_ddr4_150M] [get_bd_cells rst_ddr4_300M] [get_bd_cells rst_ddr4_100M]
regenerate_bd_layout
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila hier_dfxc/system_ila_0
endgroup
set_property -dict [list CONFIG.C_SLOT {3} CONFIG.C_NUM_OF_PROBES {5} CONFIG.C_NUM_MONITOR_SLOTS {4} CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} CONFIG.C_SLOT_2_INTF_TYPE {xilinx.com:interface:icap_rtl:1.0} CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:cap_rtl:1.0} CONFIG.C_MON_TYPE {MIX}] [get_bd_cells hier_dfxc/system_ila_0]
connect_bd_intf_net [get_bd_intf_pins hier_dfxc/system_ila_0/SLOT_0_AXIS] [get_bd_intf_pins hier_dfxc/icap_mux_0/vs_shift_axis_status]
connect_bd_intf_net [get_bd_intf_pins hier_dfxc/system_ila_0/SLOT_1_AXIS] [get_bd_intf_pins hier_dfxc/icap_mux_0/vs_count_axis_status]
connect_bd_intf_net [get_bd_intf_pins hier_dfxc/system_ila_0/SLOT_2_ICAP] [get_bd_intf_pins hier_dfxc/icap_wrapper_0/ICAP]
connect_bd_intf_net [get_bd_intf_pins hier_dfxc/system_ila_0/SLOT_3_CAP] [get_bd_intf_pins hier_dfxc/dfx_controller_0/icap_arbiter]
connect_bd_net [get_bd_pins hier_dfxc/system_ila_0/probe0] [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_shift_rm_decouple]
connect_bd_net [get_bd_pins hier_dfxc/system_ila_0/probe1] [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_shift_rm_reset]
connect_bd_net [get_bd_pins hier_dfxc/system_ila_0/probe2] [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_count_rm_decouple]
connect_bd_net [get_bd_pins hier_dfxc/system_ila_0/probe3] [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_count_rm_reset]
connect_bd_net [get_bd_pins hier_dfxc/system_ila_0/probe4] [get_bd_pins hier_dfxc/icap_wrapper_0/err_inserted]
connect_bd_net [get_bd_pins hier_dfxc/CLK] [get_bd_pins hier_dfxc/system_ila_0/clk]
connect_bd_net [get_bd_pins hier_dfxc/icap_reset] [get_bd_pins hier_dfxc/system_ila_0/resetn]
create_bd_cell -type module -reference debouncer debouncer_0
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins debouncer_0/clk]
copy_bd_objs /  [get_bd_cells {debouncer_0}]
copy_bd_objs /  [get_bd_cells {debouncer_0}]
copy_bd_objs /  [get_bd_cells {debouncer_0}]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins debouncer_1/clk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins debouncer_2/clk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins debouncer_3/clk]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0
endgroup
connect_bd_net [get_bd_pins debouncer_2/dout] [get_bd_pins xlconcat_0/In0]
connect_bd_net [get_bd_pins debouncer_3/dout] [get_bd_pins xlconcat_0/In1]
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_shift_hw_triggers]
copy_bd_objs /  [get_bd_cells {xlconcat_0}]
connect_bd_net [get_bd_pins debouncer_0/dout] [get_bd_pins xlconcat_1/In0]
connect_bd_net [get_bd_pins debouncer_1/dout] [get_bd_pins xlconcat_1/In1]
connect_bd_net [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_count_hw_triggers] [get_bd_pins xlconcat_1/dout]
copy_bd_objs /  [get_bd_cells {debouncer_2}]
connect_bd_net [get_bd_pins debouncer_4/clk] [get_bd_pins ddr4/addn_ui_clkout2]
connect_bd_net [get_bd_pins debouncer_4/dout] [get_bd_pins hier_dfxc/icap_wrapper_0/err_inj]
startgroup
make_bd_pins_external  [get_bd_pins debouncer_0/din]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins debouncer_1/din]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins debouncer_2/din]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins debouncer_3/din]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins debouncer_4/din]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler dfx_decoupler_0
endgroup
set_property -dict [list CONFIG.ALL_PARAMS {INTF {intf_0 {ID 0 VLNV xilinx.com:signal:data_rtl:1.0 SIGNALS {DATA {MANAGEMENT manual WIDTH 4}}}}} CONFIG.GUI_SELECT_INTERFACE {0} CONFIG.GUI_INTERFACE_NAME {intf_0} CONFIG.GUI_SELECT_VLNV {xilinx.com:signal:data_rtl:1.0} CONFIG.GUI_SIGNAL_SELECT_0 {DATA} CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} CONFIG.GUI_SIGNAL_PRESENT_0 {true} CONFIG.GUI_SIGNAL_WIDTH_0 {4} CONFIG.GUI_SIGNAL_MANAGEMENT_0 {manual}] [get_bd_cells dfx_decoupler_0]
connect_bd_net [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_shift_rm_decouple] [get_bd_pins dfx_decoupler_0/decouple]
startgroup
make_bd_pins_external  [get_bd_pins dfx_decoupler_0/s_intf_0_DATA]
endgroup
copy_bd_objs /  [get_bd_cells {dfx_decoupler_0}]
startgroup
make_bd_pins_external  [get_bd_pins dfx_decoupler_1/s_intf_0_DATA]
endgroup
connect_bd_net [get_bd_pins dfx_decoupler_1/decouple] [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_count_rm_decouple]
create_bd_cell -type module -reference count count_0
connect_bd_net [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_count_rm_reset] [get_bd_pins count_0/rst]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins count_0/clk]
connect_bd_net [get_bd_pins count_0/count_out] [get_bd_pins dfx_decoupler_1/rp_intf_0_DATA]
create_bd_cell -type module -reference shift shift_0
connect_bd_net [get_bd_pins hier_dfxc/dfx_controller_0/vsm_vs_shift_rm_reset] [get_bd_pins shift_0/en]
connect_bd_net [get_bd_pins shift_0/data_out] [get_bd_pins dfx_decoupler_0/rp_intf_0_DATA]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins shift_0/clk]
create_bd_cell -type module -reference shift_addr shift_addr_0
connect_bd_net [get_bd_pins shift_addr_0/addr_out] [get_bd_pins shift_0/addr]
set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_pins shift_addr_0/rst]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout2 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins shift_addr_0/clk]
regenerate_bd_layout
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:sem_ultra sem_ultra_0
endgroup
set_property -dict [list CONFIG.LOCATE_CONFIG_PRIM {example_design}] [get_bd_cells sem_ultra_0]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/ddr4/addn_ui_clkout1 (150 MHz)} Freq {150} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins sem_ultra_0/icap_clk]
connect_bd_net [get_bd_pins sem_ultra_0/icap_csib] [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_csib]
connect_bd_net [get_bd_pins sem_ultra_0/icap_rdwrb] [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_rdwrb]
connect_bd_net [get_bd_pins sem_ultra_0/icap_i] [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_i]
connect_bd_net [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_o] [get_bd_pins sem_ultra_0/icap_o]
connect_bd_net [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_prerror] [get_bd_pins sem_ultra_0/icap_prerror]
connect_bd_net [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_prdone] [get_bd_pins sem_ultra_0/icap_prdone]
connect_bd_net [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_avail] [get_bd_pins sem_ultra_0/icap_avail]
connect_bd_net [get_bd_pins sem_ultra_0/cap_req] [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_req]
connect_bd_net [get_bd_pins sem_ultra_0/cap_rel] [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_rel]
connect_bd_net [get_bd_pins sem_ultra_0/cap_gnt] [get_bd_pins hier_dfxc/icap_mux_0/sem_icap_gnt]
group_bd_cells rp1 [get_bd_cells shift_addr_0] [get_bd_cells shift_0]
group_bd_cells rp2 [get_bd_cells count_0]
group_bd_cells static_iso_wrapper [get_bd_cells debouncer_0] [get_bd_cells debouncer_1] [get_bd_cells xlconcat_0] [get_bd_cells debouncer_2] [get_bd_cells xlconcat_1] [get_bd_cells debouncer_3] [get_bd_cells debouncer_4] [get_bd_cells dfx_decoupler_1] [get_bd_cells ddr4] [get_bd_cells sem_ultra_0] [get_bd_cells axi_uart16550_0] [get_bd_cells dfx_decoupler_0] [get_bd_cells hier_mb] [get_bd_cells microblaze_0_axi_periph] [get_bd_cells hier_rst] [get_bd_cells hier_dfxc] [get_bd_cells hier_ps]
set_property name GPIO_SW_C [get_bd_ports din_0]
set_property name GPIO_SW_N [get_bd_ports din_1]
set_property name GPIO_SW_S [get_bd_ports din_2]
set_property name GPIO_SW_E [get_bd_ports din_3]
set_property name GPIO_SW_W [get_bd_ports din_4]
set_property name shift_out [get_bd_ports s_intf_0_DATA_0]
set_property name count_out [get_bd_ports s_intf_0_DATA_1]
startgroup
include_bd_addr_seg [get_bd_addr_segs -excluded static_iso_wrapper/hier_dfxc/dfx_controller_0/Data/SEG_axi_uart16550_0_Reg]
endgroup
startgroup
include_bd_addr_seg [get_bd_addr_segs -excluded static_iso_wrapper/hier_dfxc/dfx_controller_0/Data/SEG_axi_timer_0_Reg]
endgroup
startgroup
include_bd_addr_seg [get_bd_addr_segs -excluded static_iso_wrapper/hier_dfxc/dfx_controller_0/Data/SEG_dfx_controller_0_Reg]
endgroup
startgroup
include_bd_addr_seg [get_bd_addr_segs -excluded static_iso_wrapper/hier_dfxc/dfx_controller_0/Data/SEG_zynq_ultra_ps_e_0_LPD_LPS_OCM]
regenerate_bd_layout
validate_bd_design
save_bd_design
make_wrapper -files [get_files /wrk/xsjhdnobkup2/veeraven/xapp1361/vivado/project_idf_dfx_zcu102/project_idf_dfx_zcu102.srcs/sources_1/bd/mb_dfx_controller/mb_dfx_controller.bd] -top
add_files -norecurse /wrk/xsjhdnobkup2/veeraven/xapp1361/vivado/project_idf_dfx_zcu102/project_idf_dfx_zcu102.gen/sources_1/bd/mb_dfx_controller/hdl/mb_dfx_controller_wrapper.v
update_compile_order -fileset sources_1
validate_bd_design
save_bd_design
