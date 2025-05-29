#Create bin and mcs files for the PR over PCIe application note

set static  "design_1_wrapper"

set partials  { \
                    inst_shift_shift_right_partial\
                    inst_shift_shift_left_partial\
				}


# Convert each partial bitfile into a bin file formatted for the ICAP port
#
foreach p $partials {
    set cmd "write_cfgmem -force -format BIN -interface SMAPx32 -loadbit \"up 0x00000000 Bitstreams/$p.bit\" Bitstreams/$p"
    eval $cmd 
}

# Now do the static alone for dual QSPI programming
set    cmd "write_cfgmem -force -format MCS -interface SPIx8 -size 256 -loadbit \"up 0x00000000 Bitstreams/${static}.bit"

append cmd "\" Bitstreams/PR_over_PCIe_prom"

puts $cmd
eval $cmd 


# Now create a report with the sizes
foreach p $partials {
    set ret [file size Bitstreams/$p.bin]
    puts "$p : $ret bytes"
}


