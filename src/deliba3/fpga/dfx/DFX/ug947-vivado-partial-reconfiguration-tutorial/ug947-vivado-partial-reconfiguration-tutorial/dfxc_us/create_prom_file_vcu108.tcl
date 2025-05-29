# Create a programming file for the PROM containing the static and the 
# partial bitstreams
# 
# 

# ------------------------------
# Options for the complete MCS
# ------------------------------
#open_checkpoint ./Implement/Config_shift_right_count_up/top_route_design.dcp
#set_property BITSTREAM.GENERAL.COMPRESS true [current_design]
#write_bitstream -force -raw_bitfile -no_par

set final_target    "-format MCS"
set options         "-force -checksum FF -size 128"
set bpi_options     "-interface BPIx16"

set static  "Config_shift_right_count_up"
set partials  { \
                 pblock_shift_shift_left_partial\
                 pblock_shift_shift_left_partial_clear\
                 pblock_shift_shift_right_partial\
                 pblock_shift_shift_right_partial_clear\
                 pblock_count_count_up_partial\
                 pblock_count_count_up_partial_clear\
                 pblock_count_count_down_partial\
                 pblock_count_count_down_partial_clear\
                 pblock_shift_greybox_partial\
                 pblock_shift_greybox_partial_clear\
                 pblock_count_greybox_partial\
                 pblock_count_greybox_partial_clear\
              }

# Convert each partial bitfile into a bin file formatted for the ICAP port
#
foreach p $partials {
    set cmd "write_cfgmem -force -format BIN -interface SMAPx32 -disablebitswap -loadbit \"up 0 Bitstreams/$p.bit\" Bitstreams/$p"
    eval $cmd 
}

# Now do the static and pack the partials as datafiles
set cmd "write_cfgmem $options $final_target $bpi_options -loadbit \"up 0 Bitstreams/${static}_full.bit \" -loaddata \""
append cmd " up 00580000 Bitstreams/pblock_shift_shift_left_partial.bin"
append cmd " up 005AE000 Bitstreams/pblock_shift_shift_left_partial_clear.bin"
append cmd " up 005B1400 Bitstreams/pblock_shift_shift_right_partial.bin"
append cmd " up 005DF400 Bitstreams/pblock_shift_shift_right_partial_clear.bin"
append cmd " up 005E2800 Bitstreams/pblock_count_count_up_partial.bin"
append cmd " up 00604000 Bitstreams/pblock_count_count_up_partial_clear.bin"
append cmd " up 00606C00 Bitstreams/pblock_count_count_down_partial.bin" 
append cmd " up 00628400 Bitstreams/pblock_count_count_down_partial_clear.bin"
append cmd " up 0062B000 Bitstreams/pblock_shift_greybox_partial.bin" 
append cmd " up 00659000 Bitstreams/pblock_shift_greybox_partial_clear.bin"
append cmd " up 0065C400 Bitstreams/pblock_count_greybox_partial.bin"   
append cmd " up 0067DC00 Bitstreams/pblock_count_greybox_partial_clear.bin"
append cmd "\" Bitstreams/dfx_prom"

puts $cmd
eval $cmd 


# Now create a report with the sizes
foreach p $partials {
    set ret [file size Bitstreams/$p.bin]
    puts "$p : $ret bytes"
}

#exit

