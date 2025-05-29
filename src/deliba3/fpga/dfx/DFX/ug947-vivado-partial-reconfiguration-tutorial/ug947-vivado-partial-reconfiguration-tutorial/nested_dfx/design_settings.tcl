###############################################################
### Design Settings
###############################################################
# Load utilities
#Define location for "Tcl" directory. Defaults to "./tcl_HD"
if {[file exists "./Tcl_HD"]} { 
   set tclDir  "./Tcl_HD"
} else {
   error "ERROR: No valid location found for required Tcl scripts. Set \$tclDir in design.tcl to a valid location."
}
puts "Setting TCL dir to $tclDir"

####Source required Tcl Procs
source $tclDir/design_utils.tcl
source $tclDir/log_utils.tcl
source $tclDir/synth_utils.tcl
source $tclDir/impl_utils.tcl
source $tclDir/hd_utils.tcl
source $tclDir/dfx_utils.tcl

###############################################################
### Board Settings
### -Board: default device, package and speed for selected board
###############################################################
set xboard "vcu118"

switch $xboard {
vcu108 {
 set device       "xcvu095"
 set package      "-ffva2104"
 set speed        "-2-e"
}
kcu116 {
 set device       "xcku5p"
 set package      "-ffvb676"
 set speed        "-2-e"
}
kcu105 {
 set device       "xcku040"
 set package      "-ffva1156"
 set speed        "-2-e"
}
default {
#vcu118
 set device       "xcvu9p"
 set package      "-flga2104"
 set speed        "-2l-e"
}
}
set part         $device$package$speed
check_part $part


