# Create a programming file for the PROM containing the static and the 
# partial bitstreams
# 
# 

# ------------------------------
# Options for the complete MCS
# ------------------------------
set final_target    "-format MCS"
set options         "-force -checksum FF -size 32"
set bpi_options     "-interface BPIx16"

set static  "Config_shift_right_count_up"
set partials  { \
                    pblock_shift_shift_left_partial\
                    pblock_shift_shift_right_partial\
                    pblock_count_count_up_partial\
                    pblock_count_count_down_partial\
		      		pblock_shift_greybox_partial\
				    pblock_count_greybox_partial\
              }

# Convert each partial bitfile into a bin file formatted for the ICAP port
#
foreach p $partials {
    set cmd "write_cfgmem -force -format BIN -interface SMAPx32 -disablebitswap -loadbit \"up 0 Bitstreams/$p.bit\" Bitstreams/$p"
    eval $cmd 
}

# Now do the static and pack the partials as datafiles
set cmd "write_cfgmem $options $final_target $bpi_options -loadbit \"up 0 Bitstreams/${static}_full.bit \" -loaddata \""
append cmd " up 009AAE00 Bitstreams/pblock_shift_shift_left_partial.bin"
append cmd " up 00A01600 Bitstreams/pblock_shift_shift_right_partial.bin"
append cmd " up 00A57E00 Bitstreams/pblock_count_count_up_partial.bin"
append cmd " up 00AAE600 Bitstreams/pblock_count_count_down_partial.bin" 
append cmd " up 00B04E00 Bitstreams/pblock_shift_greybox_partial.bin" 
append cmd " up 00B5B600 Bitstreams/pblock_count_greybox_partial.bin" 
append cmd "\" Bitstreams/dfx_prom"

puts $cmd
eval $cmd 


# Now create a report with the sizes
foreach p $partials {
    set ret [file size Bitstreams/$p.bin]
    puts "$p : $ret bytes"
}

#exit

