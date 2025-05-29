*************************************************************************
   ____  ____ 
  /   /\/   / 
 /___/  \  /   
 \   \   \/    © Copyright 2022 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary 
  /   /        information of Xilinx, Inc. and is protected under U.S. 
 /___/   /\    and international copyright and other intellectual 
 \   \  /  \   property laws. 
  \___\/\___\ 
 
*************************************************************************

Vendor: Xilinx 
Current readme.txt Version: 1.74
Date Last Modified:  24MAY2022
Date Created:        16MAR2016

Associated Filename: UG947
Associated Document: Dynamic Function eXchange Tutorial for Vivado

Supported Device(s): all 7 series FPGAs
Target Devices as delivered: 7K325TFFG900-2
		   	     7VX485TFFG1761-2
			     7VX690TFFG1761-2
Supported Vivado versions: 2020.2 or newer
   
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

This project is self reconfiguring version of the up/down left/right DFX tutorial
for the KC705, VC707 or VC709 boards.  This design has been validated with Vivado 2020.2.

--------------------------------------------------------------------------------
1. Generate the DFX Controller & other IP required for the design, then implement the design 
   ---------------------------------------------------
   vivado -mode tcl -source design.tcl

   Selection of the target board is done within this script.
   

2. Create a PROM file containing the static and the partials
   ---------------------------------------------------
   * This creates Bitstreams/dfx_prom.mcs containing the static and the partials
   * NOTE: This contains hardwired addresses for the partials in the ROM.  
           It MUST match the hardwired addresses in dfx_info.tcl 
   * NOTE: These sizes match bitstreams created by Vivado 2016.1 and newer tools.
           Changes in 2016.1 require modifications to match size changes from prior versions of software
		   The first published version of UG947 with the PR Controller lab was with 2016.1.
		   The 2016.3 version of UG947 added support for VC707 and VC709 boards.
		   The 2020.1 version migrates the IP from PR to DFX.
   * NOTE: The design script that generates the design IP (gen_ip_<board>.tcl) has version-specific information.
           The current archive is compatible with Vivado 2020.2 and DFX Controller IP version 1.0.
     
   vivado -mode tcl -source create_prom_file_<board>.tcl
    

3. Download the PROM image
   ---------------------------------------------------
   You will likely need to Refresh the device in Vivado Hardware Manager.
   Press the PROG button on the demonstration platform to program the device from flash.
   

4. Reconfiguration is triggered by the NSEW buttons:
   ---------------------------------------------------
   N: Up counter
   S: Down Counter
   W: Shift Left
   E: Shift Right
   C: Reset
   

5. Using the AXI Interface
   ----------------------------
   In Vivado Hardware Manager, source this script file to set up dfxc commands
     source ./Sources/scripts/axi_lite_procs.tcl 
     dfxc_jtag_setup         
     dfxc_shutdown_vsm          vs_shift
     dfxc_show_rm_configuration vs_shift 0
     dfxc_show_rm_configuration vs_shift 1
     dfxc_decode_status         vs_shift

   Other commands exist to access the AXI IF  
     dfxc_read_register  reg_name
     dfxc_write_register reg_name data

     