# Create a programming file for the PROM containing the static and the partial bitstreams
# 
# 

# ------------------------------
# Options for the complete MCS
# ------------------------------
set final_target    "-format MCS"
set options         "-force -checksum FF -size 32"
set bpi_options     "-interface SPIx4"

set static  "top"

set partials  { \
                    u_shift_shift_left_partial\
                    u_shift_shift_right_partial\
                    u_count_count_up_partial\
                    u_count_count_down_partial\
                    u_shift_shift_left_partial_pfcrc\
                    u_shift_shift_right_partial_pfcrc\
                    u_count_count_up_partial_pfcrc\
                    u_count_count_down_partial_pfcrc}


# Convert each partial bit file into a bin file formatted for the ICAP port
#
foreach p $partials {
    set cmd "write_cfgmem -force -format BIN -interface SMAPx32 -disablebitswap -loadbit \"up 0 Bitstreams/$p.bit\" Bitstreams/$p"
    eval $cmd 
}

# Now do the static and pack the partials as datafiles
set    cmd "write_cfgmem $options $final_target $bpi_options -loaddata \"up 0 Bitstreams/${static}.bit"
append cmd " up 01C9C400 Bitstreams/u_shift_shift_left_partial.bin"
append cmd " up 01CF0C00 Bitstreams/u_shift_shift_right_partial.bin"
append cmd " up 01D45400 Bitstreams/u_count_count_up_partial.bin"
append cmd " up 01D9BC00 Bitstreams/u_count_count_down_partial.bin" 
append cmd " up 01DF2400 Bitstreams/u_shift_shift_left_partial_pfcrc.bin"
append cmd " up 01E4B400 Bitstreams/u_shift_shift_right_partial_pfcrc.bin"
append cmd " up 01EA4400 Bitstreams/u_count_count_up_partial_pfcrc.bin"
append cmd " up 01EFF400 Bitstreams/u_count_count_down_partial_pfcrc.bin" 

append cmd "\" Bitstreams/dfxc_prom"

puts $cmd
eval $cmd 


# Now create a report with the sizes
foreach p $partials {
    set ret [file size Bitstreams/$p.bit]
    puts "$p : $ret bytes"
}

#exit/

