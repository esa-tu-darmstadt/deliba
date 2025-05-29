*************************************************************************
   ____  ____ 
  /   /\/   / 
 /___/  \  /   
 \   \   \/    © Copyright 2019 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary 
  /   /        information of Xilinx, Inc. and is protected under U.S. 
 /___/   /\    and international copyright and other intellectual 
 \   \  /  \   property laws. 
  \___\/\___\ 
 
*************************************************************************

Vendor: Xilinx 
Current readme.txt Version: 1.0
Date Last Modified:  07MAR2019
Date Created:        16MAR2016

Associated Filename: XAPP1338
Associated Document: Fast Partial Reconfiguration over PCI Express

Supported Device(s): all UltraScale FPGAs
Target Device(s) as delivered: XCVU9P-FLGA2104-2L
                               XCKU5P-FFVB676-2
Supported Vivado versions: 2018.1 and newer
   
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

1. REVISION HISTORY
2. OVERVIEW


1. REVISION HISTORY 

            Readme  
Date        Version      Revision Description
=========================================================================
07MAR2019   1.0          Initial Xilinx release.
=========================================================================



2. OVERVIEW

This project is the example design for XAPP1338 showing fast partial reconfiguration
over PCIe express on UltraScale+ devices.  It was created with Vivado 2018.1 but 
newer versions can be used.  Two archives are available: one targets the KCU116 and
the other the VCU118.  The designs are identical other than pinout and clock rates.

Run these scripts from within the Vivado Tcl Console or Tcl Shell.  First set the
current working directory to the location where these scripts exist.

--------------------------------------------------------------------------------
a. Open the project and implement the design 

Open the example project in the Vivado IDE by running the creation script.

IMPORTANT: Before running the following script, set the "board" variable in your Vivado session.
Or open the script and set the "board" variable to either either vcu118 or kcu116.  The default is kcu116.

Launch the project creation script to build the project:

source PR_over_PCIe_project.tcl

From the Flow Navigator, select Run Implementation.  This will pull the entire design
through synthesis of all modules and IP, then implementation of both parent and child runs.

When implementation completes, do NOT select Generate Bitstreams.


b. Generate bitstreams and PROM images

In the Tcl Console, navigate to the directory where these scripts reside.
Source this script to generate all full and partial bitstreams needed:

source create_all_bitstreams.tcl

Then source this script to generate the PROM programming files:

source create_bin_and_prom.tcl


c. Program the dual QSPI flash

In Hardware Manager, program the mt25qu01g-spix8 flash available on either board.
Select PR_over_PCIe_prom_primary.mcs and PR_over_PCIe_prom_secondary.mcs for programming.


d. Deliver partial bitstreams over PCIe.

Xilinx PCI Express DMA drivers and documentation can be found on this page:
https://www.xilinx.com/support/answers/65444.html



     