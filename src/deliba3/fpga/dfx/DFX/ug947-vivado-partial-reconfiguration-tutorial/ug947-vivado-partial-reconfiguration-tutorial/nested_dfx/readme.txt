*************************************************************************
   ____  ____ 
  /   /\/   / 
 /___/  \  /   
 \   \   \/    � Copyright 2022 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary 
  /   /        information of Xilinx, Inc. and is protected under U.S. 
 /___/   /\    and international copyright and other intellectual 
 \   \  /  \   property laws. 
  \___\/\___\ 
 
*************************************************************************

Vendor: Xilinx 
Current readme.txt Version: 1.03
Date Last Modified:  24MAY2022
Date Created: 14MAY2020

Associated Filename: UG947
Associated Document: Dynamic Function eXchange Tutorial for Vivado

Supported Device(s): all UltraScale and UltraScale+ FPGAs
Target Devices as delivered: KU040-FFVA1156-2
							 VU095-FFVA2104-2
							 XCKU5P-FFVB676-2
							 XCVU9P-FLGA2104-2L
   
*************************************************************************

Disclaimer: 

      This disclaimer is not a license and does not grant any rights to 
      the materials distributed herewith. Except as otherwise provided in 
      a valid license issued to you by Xilinx, and to the maximum extent 
      permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE 
      "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL 
      WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
      INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, 
      NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and 
      (2) Xilinx shall not be liable (whether in contract or tort, 
      including negligence, or under any other theory of liability) for 
      any loss or damage of any kind or nature related to, arising under 
      or in connection with these materials, including for any direct, or 
      any indirect, special, incidental, or consequential loss or damage 
      (including loss of data, profits, goodwill, or any type of loss or 
      damage suffered as a result of any action brought by a third party) 
      even if such damage or loss was reasonably foreseeable or Xilinx 
      had been advised of the possibility of the same.

Critical Applications:

      Xilinx products are not designed or intended to be fail-safe, or 
      for use in any application requiring fail-safe performance, such as 
      life-support or safety devices or systems, Class III medical 
      devices, nuclear facilities, applications related to the deployment 
      of airbags, or any other applications that could lead to death, 
      personal injury, or severe property or environmental damage 
      (individually and collectively, "Critical Applications"). Customer 
      assumes the sole risk and liability of any use of Xilinx products 
      in Critical Applications, subject only to applicable laws and 
      regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS 
FILE AT ALL TIMES.

*************************************************************************

This readme file contains these sections:

1. OVERVIEW
2. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
3. DESIGN FILE HIERARCHY
4. INSTALLATION AND OPERATING INSTRUCTIONS
5. OTHER INFORMATION (OPTIONAL)
6. SUPPORT



1. OVERVIEW

This readme describes how to use the files that come with UG947, the 
Dynamic Function eXchange Tutorial for Vivado.

This design targets the VCU118 demonstration platform by default and is used to 
highlight the software flow for Nested Dynamic Function eXchange.  It can also be used to 
target the KCU105, VCU108 or KCU116 demonstration platforms.


2. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

This tutorial requires Xilinx Vivado 2020.2 or newer. 


3. DESIGN FILE HIERARCHY

The directory structure underneath this top-level folder is described below:

\Bitstreams
 |   This folder is empty and will be the target location for all bitstream generation.
 |       
\Implement
 |   This folder is the target location for checkpoints and reports for each of
 |   of the design configurations.  Two subfolders are present, ready for 
 |   implementation results.
 |
 +-----  \top_static
 |        This is the location for the initial design configuration results, establishing the top-level static.
 |
 +-----  \sub_counters
 |        This is the location for the counter module configuration results.
 |
 +-----  \sub_shifters
 |        This is the location for the shifter module configuration results.
 |
\Sources
 |
 +-----  \hdl
 |       Verilog source code is located within these folders.  There are folders
 |       for static logic (top) and each reconfigurable module variant for first- and second-order RMs
 |    
 |           +--\count_down
 |           +--\count_up
 |           +--\shift_left
 |           +--\shift_right
 |           +--\reconfig_counters
 |           +--\reconfig_shifters 
 |           +--\top
 |
 +-----  \xdc 
 |        This folder contains the design constraint files.
 |        Each filename includes an extension to define which demonstration board it targets.
 |           top_io_<board>.xdc contains pinout and clocking constraints
 |           pblock_top_<board>.xdc contains the DFX floorplan for the upper level reconfig_inst
 |           pblocks_shifters_<board>.xdc contains the DFX floorplan for the configurations with shifters
 |           pblocks_counters_<board>.xdc contains the DFX floorplan for the configurations with counters
 |
\Synth
 |   This folder contains empty folders that will receive the post-synthesis
 |   checkpoints for all the modules of the design.
 |
 +-----  \count_down
 +-----  \count_up
 +-----  \shift_left
 +-----  \shift_right
 +-----  \reconfig_counters
 +-----  \reconfig_shifters
 +-----  \Static
 |
 \Tcl_HD
 |   This folder contains all the lower-level Tcl scripts invoked by the Tcl
 |   scripts (just run_synth.tcl in this lab) at the top level.  The readme.txt is located here. 
 |   Anymodifications to accommodate user designs should be done to run_synth.tcl or
 |   advanced_settings.tcl in the top level, not with these scripts here.
 

4. INSTALLATION AND OPERATING INSTRUCTIONS 

Follow the instructions provided in UG947 Lab 8 to run the tutorial.

To compile a full design, edit run_all.tcl and set all flow control steps to 1 and
uncomment the "exit" command at the bottom.
Open the Tcl Shell from Vivado 2020.2 or newer, navigate to this folder, 
and type the following on the command line:

source run_all.tcl -notrace

This will compile the entire design, from RTL to bitstreams.  

The tutorial, uses the default flow control settings in run_synth.tcl so that it only
runs synthesis and leaves the Tcl Shell open for further actions.

If a device other than the VU9P is desired, open advanced_settings.tcl and change 
the xboard variable to target a different board/device. 


5. OTHER INFORMATION 

For more information on Dynamic Function eXchange in Vivado, please consult UG909.


6. SUPPORT

To obtain technical support for this reference design, go to 
www.xilinx.com/support to locate answers to known issues in the Xilinx
Answers Database or to create a WebCase.  
