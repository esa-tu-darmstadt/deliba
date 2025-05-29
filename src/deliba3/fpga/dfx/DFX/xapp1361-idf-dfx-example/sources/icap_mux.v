//////////////////////////////////////////////////////////////////////////////
// © Copyright 2022 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 2021.1
//  \   \        Application: Isolation Design Flow + Dynamic Function eXchange tutorial
//  /   /        Filename: icap_mux.v
// /___/   /\    Date Last Modified: 15 AUG 2022
// \   \  /  \
//  \___\/\___\
//
//
//
// Board:  ZCU102
// Device: zu9eg
// Design Name: project_idf_dfx_zcu102
// Purpose: Isolation Design Flow + Dynamic Function eXchange Example
module icap_mux (

(* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF vs_shift_axis_status:vs_count_axis_status" *) input icap_clk,

(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 SEM_ICAP avail" *)   output        sem_icap_avail,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 SEM_ICAP o" *)       output [31:0] sem_icap_o,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 SEM_ICAP prdone" *)  output        sem_icap_prdone,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 SEM_ICAP prerror" *) output        sem_icap_prerror,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 SEM_ICAP csib" *)    input         sem_icap_csib,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 SEM_ICAP i" *)       input [31:0]  sem_icap_i,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 SEM_ICAP rdwrb" *)   input         sem_icap_rdwrb,

(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 PRC_ICAP avail" *)   output        dfx_controller_icap_avail,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 PRC_ICAP o" *)       output [31:0] dfx_controller_icap_o,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 PRC_ICAP prdone" *)  output        dfx_controller_icap_prdone,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 PRC_ICAP prerror" *) output        dfx_controller_icap_prerror,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 PRC_ICAP csib" *)    input         dfx_controller_icap_csib,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 PRC_ICAP i" *)       input [31:0]  dfx_controller_icap_i,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 PRC_ICAP rdwrb" *)   input         dfx_controller_icap_rdwrb,

(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 ICAP avail" *)       input         icap_avail,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 ICAP o" *)           input [31:0]  icap_o,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 ICAP prdone" *)      input         icap_prdone,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 ICAP prerror" *)     input         icap_prerror,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 ICAP csib" *)        output        icap_csib,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 ICAP i" *)           output [31:0] icap_i,
(* X_INTERFACE_INFO = "xilinx.com:interface:icap_rtl:1.0 ICAP rdwrb" *)       output        icap_rdwrb,

(* X_INTERFACE_INFO = "xilinx.com:interface:cap:1.0 sem_icap_arbiter REL" *)  output reg    sem_icap_rel = 1'b0,
(* X_INTERFACE_INFO = "xilinx.com:interface:cap:1.0 sem_icap_arbiter GNT" *)  output reg    sem_icap_gnt = 1'b0,
(* X_INTERFACE_INFO = "xilinx.com:interface:cap:1.0 sem_icap_arbiter REQ" *)  input         sem_icap_req,

(* X_INTERFACE_INFO = "xilinx.com:interface:cap:1.0 dfx_controller_icap_arbiter REL" *)  output reg    dfx_controller_icap_rel = 1'b0,
(* X_INTERFACE_INFO = "xilinx.com:interface:cap:1.0 dfx_controller_icap_arbiter GNT" *)  output reg    dfx_controller_icap_gnt = 1'b0,
(* X_INTERFACE_INFO = "xilinx.com:interface:cap:1.0 dfx_controller_icap_arbiter REQ" *)  input         dfx_controller_icap_req,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vs_shift_axis_status TDATA" *)   input [31:0] vs_shift_axis_status_tdata,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vs_shift_axis_status TVALID" *)  input        vs_shift_axis_status_tvalid,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vs_count_axis_status TDATA" *)   input [31:0] vs_count_axis_status_tdata,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vs_count_axis_status TVALID" *)  input        vs_count_axis_status_tvalid

);
//No PRDONE version

reg       vs_shift_err           = 1'b0;
reg       vs_shift_loading       = 1'b0;
reg [1:0] vs_shift_loading_shift = 2'b0;
reg       vs_count_err           = 1'b0;
reg       vs_count_loading       = 1'b0;
reg [1:0] vs_count_loading_shift = 2'b0;
reg       vs_loading_end         = 1'b0;
reg [2:0] state                  = 3'b0;

localparam ST_IDLE         = 0;
localparam ST_SEM_GNT      = 1;
localparam ST_SEM_WAIT_REL = 2;
localparam ST_PRC_GNT      = 3;
localparam ST_PRC_WAIT_REL = 4;

//ICAP MUX
assign icap_csib  = (sem_icap_gnt)? sem_icap_csib  : ((dfx_controller_icap_gnt)? dfx_controller_icap_csib  : 1'b1);
assign icap_rdwrb = (sem_icap_gnt)? sem_icap_rdwrb : ((dfx_controller_icap_gnt)? dfx_controller_icap_rdwrb : 1'b1);
assign icap_i     = (sem_icap_gnt)? sem_icap_i     : ((dfx_controller_icap_gnt)? dfx_controller_icap_i     : 32'b0);

assign sem_icap_avail   = icap_avail;
assign sem_icap_o       = icap_o;
assign sem_icap_prdone  = icap_prdone ;
assign sem_icap_prerror = icap_prerror;

assign dfx_controller_icap_avail   = icap_avail;
assign dfx_controller_icap_o       = icap_o;
assign dfx_controller_icap_prdone  = icap_prdone;
assign dfx_controller_icap_prerror = icap_prerror;


//PRC error status extraction
always @(posedge icap_clk)
begin
  if (vs_shift_axis_status_tvalid)
    vs_shift_err <= |vs_shift_axis_status_tdata[6:3];

  if (vs_count_axis_status_tvalid)
    vs_count_err <= |vs_count_axis_status_tdata[6:3];
end


//PRC loading finish flag creation 
always @(posedge icap_clk)
begin
  if (vs_shift_axis_status_tvalid && vs_shift_axis_status_tdata[2:0] == 3'b100)
    vs_shift_loading <= 1'b1;
  else if (vs_shift_axis_status_tvalid && vs_shift_axis_status_tdata[2:0] != 3'b100)
    vs_shift_loading <= 1'b0;

  if (vs_count_axis_status_tvalid && vs_count_axis_status_tdata[2:0] == 3'b100)
    vs_count_loading <= 1'b1;
  else if (vs_count_axis_status_tvalid && vs_count_axis_status_tdata[2:0] != 3'b100)
    vs_count_loading <= 1'b0;

  vs_shift_loading_shift <= {vs_shift_loading_shift, vs_shift_loading};
  vs_count_loading_shift <= {vs_count_loading_shift, vs_count_loading};
  
  if (vs_shift_loading_shift == 2'b10 || vs_count_loading_shift == 2'b10)
    vs_loading_end <= 1'b1;
  else
    vs_loading_end <= 1'b0;
end


//ICAP arbitoration state machine
always @(posedge icap_clk)
begin
  case (state)
  ST_IDLE :
    begin
      if (sem_icap_gnt == 1'b1)
        state <= ST_SEM_GNT;
      else if (dfx_controller_icap_gnt == 1'b1)
        state <= ST_PRC_GNT;
      else if (sem_icap_req == 1'b1)
        state <= ST_SEM_GNT;
      else if (dfx_controller_icap_req == 1'b1)
        state <= ST_PRC_GNT;
      else
        state <= ST_IDLE;
    end

  ST_SEM_GNT :
    begin
      sem_icap_gnt <= 1'b1;

      if (dfx_controller_icap_req == 1'b1)
        state <= ST_SEM_WAIT_REL;
    end

  ST_SEM_WAIT_REL :
    begin
      sem_icap_rel <= 1'b1;

      if (sem_icap_req == 1'b0)
        begin
          sem_icap_rel <= 1'b0;
          sem_icap_gnt <= 1'b0;
          state <= ST_PRC_GNT;
        end
    end

  ST_PRC_GNT :
    begin
      dfx_controller_icap_gnt <= 1'b1;

      if (sem_icap_req == 1'b1)
        state <= ST_PRC_WAIT_REL;
    end

  ST_PRC_WAIT_REL :
    begin
      dfx_controller_icap_rel <= 1'b1;

      //If error is not detected after PR, PRC release ICAP(If there's error, hold ICAP and need to fix error)
      if (dfx_controller_icap_req == 1'b0 && vs_loading_end && (vs_count_err == 1'b0 && vs_shift_err == 1'b0))
        begin
          dfx_controller_icap_rel <= 1'b0;
          dfx_controller_icap_gnt <= 1'b0;
          state <= ST_SEM_GNT;
        end
    end

  default :
    begin
      dfx_controller_icap_gnt <= 1'b0;
      sem_icap_gnt <= 1'b0;
      dfx_controller_icap_rel <= 1'b0;
      sem_icap_rel <= 1'b0;
      state <= ST_IDLE;
    end
  endcase
end

endmodule
