create_pblock pblock_rp1
add_cells_to_pblock [get_pblocks pblock_rp1] [get_cells -quiet [list design_1_i/rp1]]
resize_pblock [get_pblocks pblock_rp1] -add {CLOCKREGION_X1Y4:CLOCKREGION_X1Y4}
set_property SNAPPING_MODE ON [get_pblocks pblock_rp1]
