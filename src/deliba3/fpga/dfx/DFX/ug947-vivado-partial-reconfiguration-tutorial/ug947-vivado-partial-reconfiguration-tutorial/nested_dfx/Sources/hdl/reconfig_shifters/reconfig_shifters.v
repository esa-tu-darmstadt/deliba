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
//  /   /        Filename: reconfig_shifters.v
// /___/   /\    Date Last Modified: 14 FEB 2020
// \   \  /  \
//  \___\/\___\
//
//
// Board:  VCU118 rev 1
// Device: xcvu9p
// Design Name: led_shift_count_nested
// Purpose: Nested Dynamic Function eXchange Tutorial
//////////////////////////////////////////////////////////////////////////////

module reconfig_inst(
    input             rst,
    input             gclk,
    output reg [3:0]  upper,
    output reg [3:0]  lower
    );

   reg [34:0]  count;
   wire [3:0]  shift_out_upper;
   wire [3:0]  shift_out_lower;

// instantiate module shift, upper bits
   shift inst_shift_upper (
      .en       (rst),
      .clk      (gclk),
      .addr     (count[34:23]),
      .data_out (shift_out_upper) 
   );
   
// instantiate module shift, lower bits
   shift inst_shift_lower (
      .en       (rst),
      .clk      (gclk),
      .addr     (count[34:23]),
      .data_out (shift_out_lower) 
   );
   
      // MAIN

   always @(posedge gclk)
     if (rst)
       begin
         count <= 0;
       end
     else
       begin
         count <= count + 1;
       end
       
   always @(posedge gclk)
     if (rst)
       begin
         upper <= 4'b0000;
         lower <= 4'b0000;
       end
     else
       begin
         upper <= shift_out_upper;
         lower <= shift_out_lower;
       end
       
endmodule


// black box definition for module_shift
module shift(
   input         en,
   input         clk,
   input  [11:0] addr,
   output  [3:0] data_out);
endmodule