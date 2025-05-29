//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2020 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 11.4
//  \   \        Application: Dynamic Function eXchange
//  /   /        Filename: count_down.v
// /___/   /\    Date Last Modified: 12 Feb 2020
// \   \  /  \
//  \___\/\___\
// Board:  KC705 Rev 1
// Device: xc7k325t-1-ffg900
// Design Name: module_count
// Purpose: Dynamic Function eXchange Tutorial
///////////////////////////////////////////////////////////////////////////////
// Reconfigurable Module: module_count
// Binary count down visable on 4 LEDs

module count (
   S_BSCAN_drck,
   S_BSCAN_shift,
   S_BSCAN_tdi,
   S_BSCAN_update,
   S_BSCAN_sel,
   S_BSCAN_tdo,
   S_BSCAN_tms,
   S_BSCAN_tck,
   S_BSCAN_runtest,
   S_BSCAN_reset,
   S_BSCAN_capture,
   S_BSCAN_bscanid_en,

   rst,
   clk,
   count_out
);

   input rst;                // Active high reset
   input clk;                // 200MHz input clock
   output [3:0] count_out;   // Output to LEDs

   input S_BSCAN_drck;
   input S_BSCAN_shift;
   input S_BSCAN_tdi;
   input S_BSCAN_update;
   input S_BSCAN_sel;
   input S_BSCAN_tms;
   input S_BSCAN_tck;
   input S_BSCAN_runtest;
   input S_BSCAN_reset;
   input S_BSCAN_capture;
   input S_BSCAN_bscanid_en;
   output S_BSCAN_tdo;

   reg [24:0] count;
   reg [3:0]  count_out;
   reg [3:0]  count_en = 4'b1010;  // Special init register to test REST_AFTER_RECONFIG(aka GSR)

   //Counter to reduce speed of output
   always @(posedge clk)
      if (rst) begin
         count <= 0;
      end
      else begin
         count <= count + 1;
      end

    always @(posedge clk)
      if (rst)
         count_out <= 4'b1111;
      else begin
         if (count == 25'b1111111111111111111111111 && count_en == 4'b1010) begin
            count_out <= count_out - 1;
         end
      end

ila_count_down ila (
  .clk(clk), // input wire clk
  .probe0(count_out) // input wire [3:0] probe0
);

endmodule
