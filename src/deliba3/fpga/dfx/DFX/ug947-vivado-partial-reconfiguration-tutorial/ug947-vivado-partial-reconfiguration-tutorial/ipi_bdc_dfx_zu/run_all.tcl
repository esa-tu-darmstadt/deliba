#Source this script to compile the full Zynq MPSoC DFX tutorial design in Vivado 2021.2
#Source individual steps to work more interactively with the tools / flow


#Create the flat deisgn using IPI
source create_top_bd.tcl


#Create the BDC for RP1 hierarchy
source create_rp1_bdc.tcl


#Enable DFX for the RP1 BDC
source enable_dfx_bdc.tcl


#Create the RM2 variant of RP1
source create_rp1rm2.tcl 


#Create an HDL Wrapper, set up the DFX Wizard, then run the implementation flow through bitstream generation and XSA export
source run_impl.tcl
