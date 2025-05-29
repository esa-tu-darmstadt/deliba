# =======================================================================
# |                        Test Description                             | 
# =======================================================================
# This test sets up the DFXC to have 2 Virtual Sockets with 2 RMs each.
# It is based on the DFX tutorial with the up/down counter and the 
# left/right shifter.
#

#  Set up some information about the design.  This isn't
#  strictly necessary but it's better to avoid magic 
#  numbers in the rest of the code

# "Shift" Virtual Socket ( ID 0)
# -----------------------------

set rm_shift_left_address  0x00800000
set rm_shift_left_size       889252

set rm_shift_right_address 0x008D9400
set rm_shift_right_size      889252



# "Count" Virtual Socket ( ID 1)
# ------------------------------
set rm_count_up_address    0x009B2800
set rm_count_up_size         895716

set rm_count_down_address  0x00A8D400 
set rm_count_down_size       895716

