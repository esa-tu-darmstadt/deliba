###############################################################
###  Minimum settings required to run DFX flow:
###  1. Specify flow steps
###  2. Define target board
###  3. Identify source directories
###  4. Define static module
###  5. Define RPs, and their RM variants
###############################################################
####flow control (1 = run step , 0 = skip step)
set run.topSynth       1 ;#synthesize static
set run.rmSynth        1 ;#synthesize RM variants

###############################################################
###  Run Settings
###############################################################
####Input Directories
set srcDir     "./Sources"
set rtlDir     "$srcDir/hdl"
set prjDir     "$srcDir/prj"
set xdcDir     "$srcDir/xdc"
set coreDir    "$srcDir/cores"
set netlistDir "$srcDir/netlist"

####Output Directories
set synthDir  "./Synth"
set implDir   "./Implement"
set dcpDir    "./Checkpoint"
set bitDir    "./Bitstreams"

###############################################################
### Static Module Definition
###############################################################
set top "top"

###############################################################
### RP & RM Definitions (Repeat for each RP)
### 1. Define Reconfigurable Partition (RP) name
### 2. Associate Reconfigurable Modules (RMs) to the RP
###############################################################
set rp1 "shift"
set rm_variants($rp1) "shift_right shift_left"
set rp2 "count"
set rm_variants($rp2) "count_up count_down"
set rp3 "reconfig_inst"
set rm_variants($rp3) "reconfig_shifters reconfig_counters"

########################################################################
### RM Configurations (Valid combinations of RM variants)
### 1. Define initial configuration: rm_config(initial)
### 2. Define additional configurations: rm_config(xyz)
########################################################################

#This section is not used in Lab 8
#run_dfx.tcl is not set up for Nested DFX

########################################################################
### Task / flow portion
########################################################################
# Build the designs
source ./design_settings.tcl
source ./advanced_settings.tcl
source $tclDir/run.tcl

#exit ;#uncomment if running in batch mode
