# =======================================================================
# |                        Test Description                             | 
# =======================================================================
# This test sets up the DFX Controller to have 2 Virtual Sockets with 2 RMs each.
# It is based on the DFX tutorial with the up/down counter and the 
# left/right shifter.
#

#  Set up some information about the design.  This isn't
#  strictly necessary but it's better to avoid magic 
#  numbers in the rest of the code

# "Shift" Virtual Socket ( ID 0)
# -----------------------------

set rm_shift_left_address           0xB00000
set rm_shift_left_size                375996
set rm_clearing_shift_left_address  0xB5C000
set rm_clearing_shift_left_size        26036

set rm_shift_right_address          0xB62800
set rm_shift_right_size               375996
set rm_clearing_shift_right_address 0xBBE800
set rm_clearing_shift_right_size       26036



# "Count" Virtual Socket ( ID 1)
# ------------------------------
set rm_count_up_address             0xBC5000
set rm_count_up_size                  274104
set rm_clearing_count_up_address    0xC08000
set rm_clearing_count_up_size          22028

set rm_count_down_address           0xC0D800 
set rm_count_down_size                274104
set rm_clearing_count_down_address  0xC50800 
set rm_clearing_count_down_size        22028

