`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2020 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 2020.1
//  \   \        Application: Dynamic Function eXchange tutorial
//  /   /        Filename: top.v
// /___/   /\    Date Last Modified: 14 FEB 2020
// \   \  /  \
//  \___\/\___\
//
//
//
// Board:  VCU118
// Device: xcvu9p
// Design Name: led_shift_count
// Purpose: Dynamic Function eXchange Tutorial


module top(
  input         sysclk_clk_n,
  input         sysclk_clk_p,
  input         reset,

  input         uart_rxd,
  output        uart_txd,
 
  output [3:0]  count_out,
  output [3:0]  shift_out,
 
  input         GPIO_SW_N,
  input         GPIO_SW_S,
  input         GPIO_SW_W,
  input         GPIO_SW_E,
  input         GPIO_SW_C,
   
  output        ddr4_sdram_c1_act_n,
  output [16:0] ddr4_sdram_c1_adr,
  output [1:0]  ddr4_sdram_c1_ba,
  output        ddr4_sdram_c1_bg,
  output        ddr4_sdram_c1_ck_c,
  output        ddr4_sdram_c1_ck_t,
  output        ddr4_sdram_c1_cke,
  output        ddr4_sdram_c1_cs_n,
  inout [7:0]   ddr4_sdram_c1_dm_n,
  inout [63:0]  ddr4_sdram_c1_dq,
  inout [7:0]   ddr4_sdram_c1_dqs_c,
  inout [7:0]   ddr4_sdram_c1_dqs_t,
  output        ddr4_sdram_c1_odt,
  output        ddr4_sdram_c1_reset_n 
 );

wire [3:0]  count_out_int, shift_out_int;

wire        vs_count_rm_decouple;
wire        vs_shift_rm_decouple;
wire        vs_count_rm_reset;
wire        vs_shift_rm_reset;

wire [1:0]  dfxc_count_hw_trig;
wire [1:0]  dfxc_shift_hw_trig;

reg [34:0]  count_value;

wire [31:0] sem_icap_o;
wire        sem_icap_csib;
wire        sem_icap_rdwrb;
wire [31:0] sem_icap_i;
wire        sem_icap_prerror;
wire        sem_icap_prdone;
wire        sem_icap_avail;
wire        sem_cap_rel;
wire        sem_cap_gnt;
wire        sem_cap_req;
    
mb_dfxc_wrapper mb_dfxc_wrapper(
  .sysclk_clk_n(sysclk_clk_n),
  .sysclk_clk_p(sysclk_clk_p),
  .reset(reset),
  .uart_rxd(uart_rxd),
  .uart_txd(uart_txd),          
  .vs_count_rm_decouple(vs_count_rm_decouple),
  .vs_shift_rm_decouple(vs_shift_rm_decouple),
  .vs_count_rm_reset(vs_count_rm_reset),
  .vs_shift_rm_reset(vs_shift_rm_reset),
          
  .dfxc_shift_hw_trig(dfxc_shift_hw_trig),
  .dfxc_count_hw_trig(dfxc_count_hw_trig),
  .dfxc_err_inj(dfxc_err_inj),
          
  .clkout_100(clk_100),
  .clkout_icap(clk_icap),

  .sem_icap_arbiter_gnt(sem_icap_gnt),
  .sem_icap_arbiter_rel(sem_icap_rel),
  .sem_icap_arbiter_req(sem_icap_req),
  .sem_icap_avail(sem_icap_avail),
  .sem_icap_csib(sem_icap_csib),
  .sem_icap_i(sem_icap_i),
  .sem_icap_o(sem_icap_o),
  .sem_icap_prdone(sem_icap_prdone),
  .sem_icap_prerror(sem_icap_prerror),
  .sem_icap_rdwrb(sem_icap_rdwrb),
                  
  .ddr4_sdram_c1_act_n(ddr4_sdram_c1_act_n),
  .ddr4_sdram_c1_adr(ddr4_sdram_c1_adr),
  .ddr4_sdram_c1_ba(ddr4_sdram_c1_ba),
  .ddr4_sdram_c1_bg(ddr4_sdram_c1_bg),
  .ddr4_sdram_c1_ck_c(ddr4_sdram_c1_ck_c),
  .ddr4_sdram_c1_ck_t(ddr4_sdram_c1_ck_t),
  .ddr4_sdram_c1_cke(ddr4_sdram_c1_cke),
  .ddr4_sdram_c1_cs_n(ddr4_sdram_c1_cs_n),
  .ddr4_sdram_c1_dm_n(ddr4_sdram_c1_dm_n),
  .ddr4_sdram_c1_dq(ddr4_sdram_c1_dq),
  .ddr4_sdram_c1_dqs_c(ddr4_sdram_c1_dqs_c),
  .ddr4_sdram_c1_dqs_t(ddr4_sdram_c1_dqs_t),
  .ddr4_sdram_c1_odt(ddr4_sdram_c1_odt),
  .ddr4_sdram_c1_reset_n(ddr4_sdram_c1_reset_n)
  );
 
 

//Virtual Socket 0: shift
always @(posedge clk_100)
begin
  if (reset)
    count_value <= 0;
  else
    count_value <= count_value + 1'b1;
end

shift u_shift (
  .en(vs_shift_rm_reset),
  .clk(clk_100),
  .addr(count_value[34:23]),
  .data_out(shift_out_int)
  );


//Virtual Socket 1: count
count  u_count (
  .rst(vs_count_rm_reset),
  .clk(clk_100),
  .count_out(count_out_int),
  .S_BSCAN_drck(),
  .S_BSCAN_shift(),
  .S_BSCAN_tdi(),
  .S_BSCAN_update(),
  .S_BSCAN_sel(),
  .S_BSCAN_tdo(),
  .S_BSCAN_tms(),
  .S_BSCAN_tck(),
  .S_BSCAN_runtest(),
  .S_BSCAN_reset(),
  .S_BSCAN_capture(),
  .S_BSCAN_bscanid_en()
  );

//DFX Decoupler IP
dfx_decoupler  dfx_decoupler_shift (
  .s_intf_0_DATA(shift_out),
  .rp_intf_0_DATA(shift_out_int),
  .decouple(vs_shift_rm_decouple),
  .decouple_status()
  );

dfx_decoupler  dfx_decoupler_count (
  .s_intf_0_DATA(count_out),
  .rp_intf_0_DATA(count_out_int),
  .decouple(vs_count_rm_decouple),
  .decouple_status()
  );


sem_wrapper u_sem_wrapper (
  .icap_clk(clk_icap),
  .icap_o(sem_icap_o),
  .icap_csib(sem_icap_csib),
  .icap_rdwrb(sem_icap_rdwrb),
  .icap_i(sem_icap_i),
  .icap_prerror(sem_icap_prerror),
  .icap_prdone(sem_icap_prdone),
  .icap_avail(sem_icap_avail),
  .icap_rel(sem_icap_rel),
  .icap_gnt(sem_icap_gnt),
  .icap_req(sem_icap_req)
  );

debouncer #(.C_WIDTH(21)) debunc_w (.clk(clk_100), .dout(dfxc_shift_hw_trig[1]), .din(GPIO_SW_W));
debouncer #(.C_WIDTH(21)) debunc_e (.clk(clk_100), .dout(dfxc_shift_hw_trig[0]), .din(GPIO_SW_E));
debouncer #(.C_WIDTH(21)) debunc_n (.clk(clk_100), .dout(dfxc_count_hw_trig[0]), .din(GPIO_SW_N));
debouncer #(.C_WIDTH(21)) debunc_s (.clk(clk_100), .dout(dfxc_count_hw_trig[1]), .din(GPIO_SW_S));
debouncer #(.C_WIDTH(21)) debunc_c (.clk(clk_100), .dout(dfxc_err_inj),          .din(GPIO_SW_C));

endmodule
