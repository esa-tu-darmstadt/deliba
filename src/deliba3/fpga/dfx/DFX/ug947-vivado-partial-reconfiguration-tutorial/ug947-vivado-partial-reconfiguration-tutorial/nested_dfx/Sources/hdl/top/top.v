//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Application: Dynamic Function eXchange 
//  /   /        Filename: top.v
// /___/   /\    Date Last Modified: 14 FEB 2020
// \   \  /  \
//  \___\/\___\
//
//
// Board:  VCU118 rev 1
// Device: xcvu9p
// Design Name: led_shift_count_nested
// Purpose: Dynamic Function eXchange Tutorial
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
//  Top-level, static design
//////////////////////////////////////////////////////////////////////////////

module top(
   input            clk_p,       // 200MHz differential input clock
   input            clk_n,       // 200MHz differential input clock
   input            rst_n,       // Reset mapped to center push button
   output reg [3:0] upper_out,   // mapped to general purpose LEDs[4-7]
   output reg [3:0] lower_out    // mapped to general purpose LEDs[0-3]
);

   wire        rst;
   wire        gclk;
   wire [3:0]  upper;
   wire [3:0]  lower;
   
   assign rst = rst_n;

   // instantiate clock module to divide 200MHz to 100MHz
   clocks U0_clocks (
      .clk_p(clk_p),
      .clk_n(clk_n),
      .rst(rst),
      .clk_out(gclk)
   );
 
   // instantiate top-level reconfigurable partition
   reconfig_inst inst_RP (
      .rst       (rst),
      .gclk       (gclk),
      .upper     (upper),
      .lower     (lower)
   );
   
   always @(posedge gclk)
     if (rst)
       begin
         upper_out <= 4'b0;
         lower_out <= 4'b0;
       end
     else
       begin
         upper_out <= upper;
         lower_out <= lower;
       end

endmodule



// black box definition for reconfig_inst
module reconfig_inst(
   input rst,
   input gclk,
   output [3:0] upper,
   output [3:0] lower
   );
endmodule