# This script generates an instance of the DFX Controller, and also creates a modelsim
# compile script called compile_dfx_controller.do

# This TCL needs to be run by vivado batch mode"
#
#   vivado -mode batch -source gen_ip.tcl
if {![info exists part]} {
   set part "xc7vx690tffg1761-2"
}
if {![info exists ipDir]} {
   regexp {(.*)\/.*\.tcl} [info script] full scriptDir
   set ipDir "${scriptDir}/../ip"
}
file mkdir $ipDir
create_project -in_memory -part $part
set_property target_language VHDL [current_project]

# =======================================================================
# |                        Generate the DFX Controller                             | 
# =======================================================================
set ip_name dfx_controller
puts "Creating IP $ip_name at $ipDir"
  # Get the scripts that ship with the DFX Controller IP
  source [get_property REPOSITORY [get_ipdefs *dfx_controller:1.0]]/xilinx/dfx_controller_v1_0/tcl/api.tcl -notrace
  create_ip -dir $ipDir -name dfx_controller -vendor xilinx.com -library ip -module_name $ip_name
  # Allocate space for an extra RM in vs_shift.  I'll configure it through
  # the JTAG interface and use it for fetch errors
  dfx_controller_v1_0::set_property -dict [list                                                               \
                  CONFIG.HAS_AXI_LITE_IF                                   1                       \
                  CONFIG.RESET_ACTIVE_LEVEL                                1                       \
                  CONFIG.CP_FIFO_DEPTH                                     16                      \
                  CONFIG.CP_FIFO_TYPE                                      "lutram"                \
				  CONFIG.CP_ARBITRATION_PROTOCOL                           1                       \
				  CONFIG.CP_COMPRESSION                                    0					   \
				  CONFIG.CP_FAMILY                                         7series                 \
                  CONFIG.CDC_STAGES                                        2                       \
                  CONFIG.VS.vs_shift.HAS_AXIS_STATUS                       1                       \
                  CONFIG.VS.vs_shift.HAS_AXIS_CONTROL                      0                       \
                  CONFIG.VS.vs_shift.NUM_TRIGGERS_ALLOCATED                4                       \
                  CONFIG.VS.vs_shift.NUM_HW_TRIGGERS                       4                       \
                  CONFIG.VS.vs_shift.NUM_RMS_ALLOCATED                     3                       \
                  CONFIG.VS.vs_shift.HAS_POR_RM                            1                       \
                  CONFIG.VS.vs_shift.POR_RM                                rm_shift_right          \
                  CONFIG.VS.vs_shift.SKIP_RM_STARTUP_AFTER_RESET           0                       \
                  CONFIG.VS.vs_shift.START_IN_SHUTDOWN                     0                       \
                  CONFIG.VS.vs_shift.SHUTDOWN_ON_ERROR                     1                       \
                  CONFIG.VS.vs_shift.RM.rm_shift_left.SHUTDOWN_REQUIRED    no                      \
                  CONFIG.VS.vs_shift.RM.rm_shift_left.STARTUP_REQUIRED     no                      \
                  CONFIG.VS.vs_shift.RM.rm_shift_left.RESET_REQUIRED       high                    \
                  CONFIG.VS.vs_shift.RM.rm_shift_left.RESET_DURATION       3                       \
                  CONFIG.VS.vs_shift.RM.rm_shift_left.BS.0.ADDRESS         0x00800000              \
                  CONFIG.VS.vs_shift.RM.rm_shift_left.BS.0.SIZE            889252                  \
                  CONFIG.VS.vs_shift.RM.rm_shift_right.SHUTDOWN_REQUIRED   no                      \
                  CONFIG.VS.vs_shift.RM.rm_shift_right.STARTUP_REQUIRED    no                      \
                  CONFIG.VS.vs_shift.RM.rm_shift_right.RESET_REQUIRED      high                    \
                  CONFIG.VS.vs_shift.RM.rm_shift_right.RESET_DURATION      10                      \
                  CONFIG.VS.vs_shift.RM.rm_shift_right.BS.0.ADDRESS        0x008D9400              \
                  CONFIG.VS.vs_shift.RM.rm_shift_right.BS.0.SIZE           889252                  \
                  CONFIG.VS.vs_count.HAS_AXIS_STATUS                       0                       \
                  CONFIG.VS.vs_count.HAS_AXIS_CONTROL                      0                       \
                  CONFIG.VS.vs_count.NUM_TRIGGERS_ALLOCATED                4                       \
                  CONFIG.VS.vs_count.NUM_HW_TRIGGERS                       4                       \
                  CONFIG.VS.vs_count.NUM_RMS_ALLOCATED                     2                       \
                  CONFIG.VS.vs_count.HAS_POR_RM                            1                       \
                  CONFIG.VS.vs_count.POR_RM                                rm_count_up             \
                  CONFIG.VS.vs_count.SKIP_RM_STARTUP_AFTER_RESET           0                       \
                  CONFIG.VS.vs_count.START_IN_SHUTDOWN                     1                       \
                  CONFIG.VS.vs_count.SHUTDOWN_ON_ERROR                     0                       \
                  CONFIG.VS.vs_count.RM.rm_count_up.SHUTDOWN_REQUIRED      no                      \
                  CONFIG.VS.vs_count.RM.rm_count_up.STARTUP_REQUIRED       no                      \
                  CONFIG.VS.vs_count.RM.rm_count_up.RESET_REQUIRED         high                    \
                  CONFIG.VS.vs_count.RM.rm_count_up.RESET_DURATION         12                      \
                  CONFIG.VS.vs_count.RM.rm_count_up.BS.0.ADDRESS           0                       \
                  CONFIG.VS.vs_count.RM.rm_count_up.BS.0.SIZE              0                       \
                  CONFIG.VS.vs_count.RM.rm_count_down.SHUTDOWN_REQUIRED    no                      \
                  CONFIG.VS.vs_count.RM.rm_count_down.STARTUP_REQUIRED     no                      \
                  CONFIG.VS.vs_count.RM.rm_count_down.RESET_REQUIRED       high                    \
                  CONFIG.VS.vs_count.RM.rm_count_down.RESET_DURATION       16                      \
                  CONFIG.VS.vs_count.RM.rm_count_down.BS.0.ADDRESS         0                       \
                  CONFIG.VS.vs_count.RM.rm_count_down.BS.0.SIZE            0                       \
             ] [get_ips $ip_name]
  generate_target {all} [get_ips $ip_name]

#  # Example of using set_property
#  dfx_controller_v1_0::get_property CONFIG.VS.vs_count.RM.rm_count_down.RESET_DURATION [get_ips $ip_name]
#  dfx_controller_v1_0::set_property CONFIG.VS.vs_count.RM.rm_count_down.RESET_DURATION 10 [get_ips $ip_name]
#  dfx_controller_v1_0::get_property CONFIG.VS.vs_count.RM.rm_count_down.RESET_DURATION [get_ips $ip_name]
#   
#   
#  # Example of using get_properties
#  dfx_controller_v1_0::get_properties  [get_ips dfx_controller]


# =======================================================================
# |                        Generate the EMC                             | 
# =======================================================================
set ip_name axi_emc_inst
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name axi_emc -vendor xilinx.com -library ip -module_name $ip_name
# I need to set the TB clock period here (C_AXI_CLK_PERIOD_PS) to match the clock in the design
# ive set the upper address too low in an attempt to force fetch errors
set_property -dict [list CONFIG.C_TAVDV_PS_MEM_0 {100000} \
                         CONFIG.C_TCEDV_PS_MEM_0 {100000}  \
                         CONFIG.C_MAX_MEM_WIDTH {16}       \
                         CONFIG.C_MEM0_TYPE {2}            \
                         CONFIG.C_S_AXI_MEM_ID_WIDTH {1}     \
                         CONFIG.C_AXI_CLK_PERIOD_PS {10000}\
                         CONFIG.C_S_AXI_MEM0_BASEADDR {0x00000000}\
                         CONFIG.C_S_AXI_MEM0_HIGHADDR {0x0FFFFFFF}]\
    [get_ips $ip_name]

set_property generate_synth_checkpoint false [get_files $ip_name.xci]
generate_target {all} [get_ips $ip_name]



# =======================================================================
# |                        Generate the JTAG to AXI master                            | 
# =======================================================================
set ip_name jtag_to_axi
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name jtag_axi -vendor xilinx.com -library ip -module_name $ip_name
set_property -dict [list CONFIG.PROTOCOL {2}] [get_ips $ip_name]
generate_target {all} [get_ips $ip_name]

# =======================================================================
# |                        Generate the ila_vs_count                            | 
# =======================================================================
set ip_name ila_vs_count
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name ila -vendor xilinx.com -library ip -module_name $ip_name
set_property -dict [list CONFIG.C_PROBE4_WIDTH {1} \
                         CONFIG.C_PROBE3_WIDTH {1} \
                         CONFIG.C_PROBE2_WIDTH {1} \
                         CONFIG.C_PROBE1_WIDTH {1}\
                         CONFIG.C_PROBE0_WIDTH {4}\
                         CONFIG.C_DATA_DEPTH {16384}\
                         CONFIG.C_NUM_OF_PROBES {5}\
                         CONFIG.C_TRIGOUT_EN {true}\
                         CONFIG.C_MONITOR_TYPE {Native}] [get_ips $ip_name]

set_property generate_synth_checkpoint false [get_files $ip_name.xci]
generate_target {all} [get_ips $ip_name]


# =======================================================================
# |                        Generate the ila_icap                            | 
# =======================================================================
set ip_name ila_icap
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name ila -vendor xilinx.com -library ip -module_name $ip_name
set_property -dict [list CONFIG.C_PROBE3_WIDTH        {1} \
                         CONFIG.C_PROBE2_WIDTH        {1} \
                         CONFIG.C_PROBE1_WIDTH        {4} \
                         CONFIG.C_PROBE0_WIDTH        {32}\
                         CONFIG.C_DATA_DEPTH          {16384} \
                         CONFIG.C_NUM_OF_PROBES       {4} \
                         CONFIG.C_TRIGOUT_EN          {true} \
                         CONFIG.C_EN_STRG_QUAL        {1} \
                         CONFIG.C_INPUT_PIPE_STAGES   {0} \
                         CONFIG.C_ADV_TRIGGER         {true} \
                         CONFIG.C_PROBE3_MU_CNT       {4} \
                         CONFIG.C_PROBE2_MU_CNT       {4} \
                         CONFIG.C_PROBE1_MU_CNT       {4} \
                         CONFIG.C_PROBE0_MU_CNT       {4} \
                         CONFIG.ALL_PROBE_SAME_MU     {false} \
                         CONFIG.C_MONITOR_TYPE        {Native} \
                         CONFIG.ALL_PROBE_SAME_MU_CNT {2} \
                         CONFIG.C_ENABLE_ILA_AXI_MON  {false}] [get_ips $ip_name]

set_property generate_synth_checkpoint false [get_files $ip_name.xci]
generate_target {all} [get_ips $ip_name]

# =======================================================================
# |                        Generate the ila_vs_shift                    | 
# =======================================================================
set ip_name ila_vs_shift
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name ila -vendor xilinx.com -library ip -module_name $ip_name
set_property -dict [list CONFIG.C_PROBE5_WIDTH {32} \
                         CONFIG.C_PROBE4_WIDTH {1} \
                         CONFIG.C_PROBE3_WIDTH {1} \
                         CONFIG.C_PROBE2_WIDTH {1}\
                         CONFIG.C_PROBE1_WIDTH {1}\
                         CONFIG.C_PROBE0_WIDTH {4}\
                         CONFIG.C_DATA_DEPTH {16384}\
                         CONFIG.C_NUM_OF_PROBES {6} \
                         CONFIG.C_TRIGOUT_EN {true} \
                         CONFIG.C_MONITOR_TYPE {Native}] [get_ips $ip_name]
set_property generate_synth_checkpoint false [get_files  $ip_name.xci]
generate_target {all} [get_ips $ip_name]

# =======================================================================
# |                        Generate the ila_rom                         | 
# =======================================================================
set ip_name ila_rom
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name ila -vendor xilinx.com -library ip -module_name $ip_name
set_property -dict [list CONFIG.C_PROBE6_WIDTH {1} \
                         CONFIG.C_PROBE5_WIDTH {1} \
                         CONFIG.C_PROBE4_WIDTH {1}\
                         CONFIG.C_PROBE3_WIDTH {1}\
                         CONFIG.C_PROBE2_WIDTH {1}\
                         CONFIG.C_PROBE1_WIDTH {26}\
                         CONFIG.C_PROBE0_WIDTH {16}\
                         CONFIG.C_DATA_DEPTH {16384}\
                         CONFIG.C_NUM_OF_PROBES {7}\
                         CONFIG.C_TRIGOUT_EN {true}\
                         CONFIG.C_MONITOR_TYPE {Native}] [get_ips $ip_name]
set_property generate_synth_checkpoint false [get_files $ip_name.xci]
generate_target {all} [get_ips $ip_name]

# =======================================================================
# |                        Generate the ila_axi_reg                     | 
# =======================================================================
set ip_name ila_axi_reg
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name ila -vendor xilinx.com -library ip -module_name $ip_name
set_property -dict [list CONFIG.C_PROBE0_WIDTH {32} \
                         CONFIG.C_PROBE1_WIDTH {1} \
                         CONFIG.C_PROBE2_WIDTH {1}\
                         CONFIG.C_PROBE3_WIDTH {32}\
                         CONFIG.C_PROBE4_WIDTH {1}\
                         CONFIG.C_PROBE5_WIDTH {1}\
                         CONFIG.C_PROBE6_WIDTH {2}\
                         CONFIG.C_PROBE7_WIDTH {1}\
                         CONFIG.C_PROBE8_WIDTH {1}\
                         CONFIG.C_PROBE9_WIDTH {32}\
                         CONFIG.C_PROBE10_WIDTH {1}\
                         CONFIG.C_PROBE11_WIDTH {1}\
                         CONFIG.C_PROBE12_WIDTH {32}\
                         CONFIG.C_PROBE13_WIDTH {2}\
                         CONFIG.C_PROBE14_WIDTH {1}\
                         CONFIG.C_PROBE15_WIDTH {1}\
                         CONFIG.C_DATA_DEPTH {1024}\
                         CONFIG.C_NUM_OF_PROBES {16}\
                         CONFIG.C_TRIGOUT_EN {true}\
                         CONFIG.C_MONITOR_TYPE {Native}] [get_ips $ip_name]

set_property generate_synth_checkpoint false [get_files $ip_name.xci]
generate_target {all} [get_ips $ip_name]

# =======================================================================
# |                        Generate the ila_axi_mem                      | 
# =======================================================================
set ip_name ila_axi_mem
puts "Creating IP $ip_name at $ipDir"
create_ip -dir $ipDir -name ila -vendor xilinx.com -library ip -module_name $ip_name
set_property -dict [list CONFIG.C_PROBE0_WIDTH {32} \
                         CONFIG.C_PROBE1_WIDTH {8} \
                         CONFIG.C_PROBE2_WIDTH {3}\
                         CONFIG.C_PROBE3_WIDTH {2}\
                         CONFIG.C_PROBE4_WIDTH {3}\
                         CONFIG.C_PROBE5_WIDTH {4}\
                         CONFIG.C_PROBE6_WIDTH {4}\
                         CONFIG.C_PROBE7_WIDTH {1}\
                         CONFIG.C_PROBE8_WIDTH {1}\
                         CONFIG.C_PROBE9_WIDTH {32}\
                         CONFIG.C_PROBE10_WIDTH {2}\
                         CONFIG.C_PROBE11_WIDTH {1}\
                         CONFIG.C_PROBE12_WIDTH {1}\
                         CONFIG.C_PROBE13_WIDTH {1}\
                         CONFIG.C_DATA_DEPTH {65536}\
                         CONFIG.C_NUM_OF_PROBES {14}\
                         CONFIG.C_TRIGOUT_EN {true}\
                         CONFIG.C_MONITOR_TYPE {Native}] [get_ips $ip_name]
set_property generate_synth_checkpoint false [get_files $ip_name.xci]
generate_target {all} [get_ips $ip_name]

