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
//  /   /        Filename: icap_mux.v
// /___/   /\    Date Last Modified: 14 FEB 2020
// \   \  /  \
//  \___\/\___\
//
//
//
// Board:  VCU118
// Device: xcvu9p
// Design Name: dfxc_usp
// Purpose: Dynamic Function eXchange Tutorial

`timescale 1 ps / 1 ps

module mb_dfxc_wrapper
   (clkout_100,
    clkout_icap,
    ddr4_sdram_c1_act_n,
    ddr4_sdram_c1_adr,
    ddr4_sdram_c1_ba,
    ddr4_sdram_c1_bg,
    ddr4_sdram_c1_ck_c,
    ddr4_sdram_c1_ck_t,
    ddr4_sdram_c1_cke,
    ddr4_sdram_c1_cs_n,
    ddr4_sdram_c1_dm_n,
    ddr4_sdram_c1_dq,
    ddr4_sdram_c1_dqs_c,
    ddr4_sdram_c1_dqs_t,
    ddr4_sdram_c1_odt,
    ddr4_sdram_c1_reset_n,
    dfxc_count_hw_trig,
    dfxc_err_inj,
    dfxc_shift_hw_trig,
    reset,
    sem_icap_arbiter_gnt,
    sem_icap_arbiter_rel,
    sem_icap_arbiter_req,
    sem_icap_avail,
    sem_icap_csib,
    sem_icap_i,
    sem_icap_o,
    sem_icap_prdone,
    sem_icap_prerror,
    sem_icap_rdwrb,
    sysclk_clk_n,
    sysclk_clk_p,
    uart_rxd,
    uart_txd,
    vs_count_rm_decouple,
    vs_count_rm_reset,
    vs_shift_rm_decouple,
    vs_shift_rm_reset);
  output clkout_100;
  output clkout_icap;
  output ddr4_sdram_c1_act_n;
  output [16:0]ddr4_sdram_c1_adr;
  output [1:0]ddr4_sdram_c1_ba;
  output ddr4_sdram_c1_bg;
  output ddr4_sdram_c1_ck_c;
  output ddr4_sdram_c1_ck_t;
  output ddr4_sdram_c1_cke;
  output ddr4_sdram_c1_cs_n;
  inout [7:0]ddr4_sdram_c1_dm_n;
  inout [63:0]ddr4_sdram_c1_dq;
  inout [7:0]ddr4_sdram_c1_dqs_c;
  inout [7:0]ddr4_sdram_c1_dqs_t;
  output ddr4_sdram_c1_odt;
  output ddr4_sdram_c1_reset_n;
  input [1:0]dfxc_count_hw_trig;
  input dfxc_err_inj;
  input [1:0]dfxc_shift_hw_trig;
  input reset;
  output sem_icap_arbiter_gnt;
  output sem_icap_arbiter_rel;
  input sem_icap_arbiter_req;
  output sem_icap_avail;
  input sem_icap_csib;
  input [31:0]sem_icap_i;
  output [31:0]sem_icap_o;
  output sem_icap_prdone;
  output sem_icap_prerror;
  input sem_icap_rdwrb;
  input sysclk_clk_n;
  input sysclk_clk_p;
  input uart_rxd;
  output uart_txd;
  output vs_count_rm_decouple;
  output vs_count_rm_reset;
  output vs_shift_rm_decouple;
  output vs_shift_rm_reset;

  wire clkout_100;
  wire clkout_icap;
  wire ddr4_sdram_c1_act_n;
  wire [16:0]ddr4_sdram_c1_adr;
  wire [1:0]ddr4_sdram_c1_ba;
  wire ddr4_sdram_c1_bg;
  wire ddr4_sdram_c1_ck_c;
  wire ddr4_sdram_c1_ck_t;
  wire ddr4_sdram_c1_cke;
  wire ddr4_sdram_c1_cs_n;
  wire [7:0]ddr4_sdram_c1_dm_n;
  wire [63:0]ddr4_sdram_c1_dq;
  wire [7:0]ddr4_sdram_c1_dqs_c;
  wire [7:0]ddr4_sdram_c1_dqs_t;
  wire ddr4_sdram_c1_odt;
  wire ddr4_sdram_c1_reset_n;
  wire [1:0]dfxc_count_hw_trig;
  wire dfxc_err_inj;
  wire [1:0]dfxc_shift_hw_trig;
  wire reset;
  wire sem_icap_arbiter_gnt;
  wire sem_icap_arbiter_rel;
  wire sem_icap_arbiter_req;
  wire sem_icap_avail;
  wire sem_icap_csib;
  wire [31:0]sem_icap_i;
  wire [31:0]sem_icap_o;
  wire sem_icap_prdone;
  wire sem_icap_prerror;
  wire sem_icap_rdwrb;
  wire sysclk_clk_n;
  wire sysclk_clk_p;
  wire uart_rxd;
  wire uart_txd;
  wire vs_count_rm_decouple;
  wire vs_count_rm_reset;
  wire vs_shift_rm_decouple;
  wire vs_shift_rm_reset;

  mb_dfxc mb_dfxc_i
       (.clkout_100(clkout_100),
        .clkout_icap(clkout_icap),
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
        .ddr4_sdram_c1_reset_n(ddr4_sdram_c1_reset_n),
        .dfxc_count_hw_trig(dfxc_count_hw_trig),
        .dfxc_err_inj(dfxc_err_inj),
        .dfxc_shift_hw_trig(dfxc_shift_hw_trig),
        .reset(reset),
        .sem_icap_arbiter_gnt(sem_icap_arbiter_gnt),
        .sem_icap_arbiter_rel(sem_icap_arbiter_rel),
        .sem_icap_arbiter_req(sem_icap_arbiter_req),
        .sem_icap_avail(sem_icap_avail),
        .sem_icap_csib(sem_icap_csib),
        .sem_icap_i(sem_icap_i),
        .sem_icap_o(sem_icap_o),
        .sem_icap_prdone(sem_icap_prdone),
        .sem_icap_prerror(sem_icap_prerror),
        .sem_icap_rdwrb(sem_icap_rdwrb),
        .sysclk_clk_n(sysclk_clk_n),
        .sysclk_clk_p(sysclk_clk_p),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd),
        .vs_count_rm_decouple(vs_count_rm_decouple),
        .vs_count_rm_reset(vs_count_rm_reset),
        .vs_shift_rm_decouple(vs_shift_rm_decouple),
        .vs_shift_rm_reset(vs_shift_rm_reset));
endmodule
