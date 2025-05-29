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
//  /   /        Filename: count_down.v
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

module count_down (
   rst,
   clk,
   count_out
);

   input rst;                // Active high reset
   input clk;                // 200MHz input clock
   output [3:0] count_out;   // Output to LEDs

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

endmodule
