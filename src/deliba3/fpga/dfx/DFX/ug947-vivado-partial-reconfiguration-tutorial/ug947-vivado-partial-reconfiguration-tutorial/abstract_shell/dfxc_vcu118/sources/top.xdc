set_false_path -from [get_cells mb_dfxc_wrapper/mb_dfxc_i/hier_dfxc/dfxc/U0/i_vsm_vs_shift/rm_reset_i_reg]
set_false_path -from [get_cells debunc_*/dout_reg]


set_property PACKAGE_PIN BB24 [get_ports GPIO_SW_N]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_N]
set_property PACKAGE_PIN BF22 [get_ports GPIO_SW_W]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_W]
set_property PACKAGE_PIN BE22 [get_ports GPIO_SW_S]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_S]
set_property PACKAGE_PIN BE23 [get_ports GPIO_SW_E]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_E]
set_property PACKAGE_PIN BD23 [get_ports GPIO_SW_C]
set_property IOSTANDARD LVCMOS18 [get_ports GPIO_SW_C]

set_property PACKAGE_PIN L19 [get_ports reset]
set_property IOSTANDARD LVCMOS12 [get_ports reset]

set_property PACKAGE_PIN BA37 [get_ports {count_out[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {count_out[3]}]
set_property PACKAGE_PIN AV36 [get_ports {count_out[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {count_out[2]}]
set_property PACKAGE_PIN AU37 [get_ports {count_out[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {count_out[1]}]
set_property PACKAGE_PIN BF32 [get_ports {count_out[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {count_out[0]}]
set_property PACKAGE_PIN BB32 [get_ports {shift_out[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_out[3]}]
set_property PACKAGE_PIN AY30 [get_ports {shift_out[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_out[2]}]
set_property PACKAGE_PIN AV34 [get_ports {shift_out[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_out[1]}]
set_property PACKAGE_PIN AT32 [get_ports {shift_out[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {shift_out[0]}]

create_pblock pb_count
add_cells_to_pblock [get_pblocks pb_count] [get_cells -quiet [list u_count]]
resize_pblock [get_pblocks pb_count] -add {SLICE_X56Y495:SLICE_X59Y534}
resize_pblock [get_pblocks pb_count] -add {DSP48E2_X8Y198:DSP48E2_X8Y213}
resize_pblock [get_pblocks pb_count] -add {RAMB18_X4Y198:RAMB18_X4Y213}
resize_pblock [get_pblocks pb_count] -add {RAMB36_X4Y99:RAMB36_X4Y106}
set_property SNAPPING_MODE ON [get_pblocks pb_count]

create_pblock pb_shift
add_cells_to_pblock [get_pblocks pb_shift] [get_cells -quiet [list u_shift]]
resize_pblock [get_pblocks pb_shift] -add {SLICE_X49Y370:SLICE_X50Y409}
resize_pblock [get_pblocks pb_shift] -add {DSP48E2_X7Y148:DSP48E2_X7Y163}
resize_pblock [get_pblocks pb_shift] -add {RAMB18_X3Y148:RAMB18_X3Y163}
resize_pblock [get_pblocks pb_shift] -add {RAMB36_X3Y74:RAMB36_X3Y81}
set_property SNAPPING_MODE ON [get_pblocks pb_shift]


set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR yes [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE yes [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 72.9 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true [current_design]


set_property LOC CONFIG_SITE_X0Y1 [get_cells mb_dfxc_wrapper/mb_dfxc_i/hier_dfxc/icap_wrapper/inst/u_icap_master]
set_property LOC CONFIG_SITE_X0Y0 [get_cells mb_dfxc_wrapper/mb_dfxc_i/hier_dfxc/icap_wrapper/inst/u_icap_slave0]
set_property LOC CONFIG_SITE_X0Y2 [get_cells mb_dfxc_wrapper/mb_dfxc_i/hier_dfxc/icap_wrapper/inst/u_icap_slave1]

set tdata_trace_delay_max 0.45
set tdata_trace_delay_min 0.45
set tclk_trace_delay_max 0.4
set tclk_trace_delay_min 0.4
set tco_max 6
set tco_min 2
set tsu 1.75
set th 2

create_generated_clock -name clk_sck -source [get_pins -hierarchical *qspi/ext_spi_clk] [get_pins -hierarchical *inst/CCLK] -edges {1 3 5}

set_input_delay -clock clk_sck -max [expr $tco_max + $tdata_trace_delay_max + $tclk_trace_delay_max] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_input_delay -clock clk_sck -min [expr $tco_min + $tdata_trace_delay_min + $tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_multicycle_path 2 -setup     -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical *qspi/ext_spi_clk]]
set_multicycle_path 1 -hold -end -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical *qspi/ext_spi_clk]]
set_output_delay -clock clk_sck -max [expr $tsu + $tdata_trace_delay_max - $tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
set_output_delay -clock clk_sck -min [expr $tdata_trace_delay_min -$th - $tclk_trace_delay_max]   [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
set_multicycle_path 1 -hold -from [get_clocks -of_objects [get_pins -hierarchical *qspi/ext_spi_clk]] -to clk_sck

set_property C_CLK_INPUT_FREQ_HZ 100000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_100]
