# Description
# -------------
# This file contains very basic TCL procs for interacting with a DFX Controller IP core 
# using the AXI Lite Interface through Vivado Hardware Debugger.
#
# NOTE: These are hardwired to the Tutorial Design and will not work on a generic
#       DFX Controller configuration without modification.
# 
# 
# Example usage
# -------------
# 
#       dfxc_jtag_setup         
#       dfxc_shutdown_vsm          vs_shift
#       dfxc_show_rm_configuration vs_shift 0
#       dfxc_show_rm_configuration vs_shift 1
#       dfxc_decode_status         vs_shift
#       dfxc_restart_vsm_no_status vs_shift
#       dfxc_send_sw_trigger       vs_shift 2
#
#     Other commands exist to access the AXI IF  
#       dfxc_read_register  reg_name
#       dfxc_write_register reg_name data


# ========================================================================
# [MANDATORY] This proc must be called before any other proc in this file
# ========================================================================
# Set up a generic transaction to use
#
proc dfxc_jtag_setup {} {
    create_hw_axi_txn -address 0 -type read dfxc_txn [get_hw_axis hw_axi_1] -quiet
    reset_hw_axi [get_hw_axis hw_axi_1]
}

# ========================================================================
# Command : Shutdown VSM
# ========================================================================
#
proc dfxc_shutdown_vsm {vs_name} {
    dfxc_write_register ${vs_name}_control 0
    if {[is_vsm_in_shutdown $vs_name] == 0} {
        puts "ERROR: status[7] = 0 after a shutdown command"
    }   
}

# ========================================================================
# Command : Restart VSM with no status
# ========================================================================
#
proc dfxc_restart_vsm_no_status {vs_name } {
    dfxc_write_register ${vs_name}_control 1
    if {[is_vsm_in_shutdown $vs_name] == 1} {
        puts "ERROR: status[7] = 0 after a shutdown command"
    } 
}

# ========================================================================
# Command : Send a Software Trigger to VSM
# ========================================================================
#
proc dfxc_send_sw_trigger {vs_name id} {
    set hex_id [format %08x $id]
    set_property CMD.ADDR [dfxc_get_address ${vs_name}_sw_trigger] [get_hw_axi_txns dfxc_txn]
    set_property TYPE WRITE                                       [get_hw_axi_txns dfxc_txn]
    set_property DATA $hex_id                                     [get_hw_axi_txns dfxc_txn]
    run_hw_axi dfxc_txn 
}



# ========================================================================
# Status : Find out if a VSM is in the shutdown state
# ========================================================================
#
proc is_vsm_in_shutdown {vs_name} {
    set status [dfxc_read_register ${vs_name}_status]

    # bit 7 is the shutdown bit
    if { [expr ${status} & 128]} {
        return 1
    } else {
        return 0
    }   
}



# ========================================================================
# Debug : Display a VSM status in a human readable format
# ========================================================================
#
proc dfxc_decode_status {vs_name} {
    set status [dfxc_read_register ${vs_name}_status]
   
    set status_code  [expr ($status & 7) ]
    set error_code   [expr ($status & 120) / 8]
    set shutdown_bit [expr ($status & 128) / 128]
    set rm_id        [expr ($status & 16776960) / 256]

    if {$shutdown_bit == 0 } {
        switch -nocase -- $status_code {
            0       { set status_code_str "EMPTY"  }
            1       { set status_code_str "HW_SHUTDOWN"  }
            2       { set status_code_str "SW_SHUTDOWN"  }
            3       { set status_code_str "CLEAR"  }
            4       { set status_code_str "LOAD"  }
            5       { set status_code_str "SW_STARTUP"  }
            6       { set status_code_str "RM RESET"  }
            7       { set status_code_str "FULL"  }
        }
    } else {
        set status_code_str "RM_SHUTDOWN_ACK : $status_code"
    }

    switch -nocase -- $error_code {
        0       { set error_code_str "No Error"  }
        1       { set error_code_str "BAD CONFIG"  }
        2       { set error_code_str "BS ERROR"  }
        3       { set error_code_str "LOST ERROR"  }
        4       { set error_code_str "FETCH ERROR"  }
        5       { set error_code_str "BS + FETCH ERRORs"  }
        6       { set error_code_str "LOST + FETCH ERRORs"  }
		7       { set error_code_str "BAD SIZE ERROR"  }
        8       { set error_code_str "BAD FORMAT ERROR"  }
        15      { set error_code_str "UNKNOWN ERROR"  }
        default { set error_code_str "RESERVED (this is bad - please let Xilinx know)"  }
    }
    
    puts "status         = $status "
    puts "status_code    = $status_code : $status_code_str "
    puts "error_code     = $error_code  : $error_code_str"
    puts "shutdown_bit   = $shutdown_bit"
    puts "rm_id          = $rm_id       "
}


# ========================================================================
# Debug : Display a RM's configuration in a VSM
# ========================================================================
#
proc dfxc_show_rm_configuration {vs_name rm_id} {
    # The VSM must be in shutdown

    if {[is_vsm_in_shutdown $vs_name] == 0} {
        puts "VSM $vs_name must be in shutdown for the dfxc_show_rm_configuration command to work"
        return
    }

    set control    [dfxc_read_register ${vs_name}_rm_control${rm_id}]
    set bs_index   [dfxc_read_register ${vs_name}_rm_bs_index${rm_id}]
    set bs_index   [expr $bs_index * 1]
    set bs_size    [dfxc_read_register ${vs_name}_bs_size${bs_index}]
    set bs_address [dfxc_read_register ${vs_name}_bs_address${bs_index}]
    set bs_address [format %08x $bs_address]

    puts "RM ID $rm_id | CONTROL = $control | BS_INDEX = $bs_index | BS SIZE = $bs_size | BS ADDRESS = $bs_address"
}


# ========================================================================
# Low Level register access: Convert a register name to an address
# ========================================================================
#
proc dfxc_get_address {reg_name} {
    switch -nocase -- $reg_name {
        "vs_shift_status"       { return 0x00000000 }
        "vs_shift_control"      { return 0x00000000 }
        "vs_shift_sw_trigger"   { return 0x00000004 }
        "vs_shift_trigger0"     { return 0x00000040 }
        "vs_shift_trigger1"     { return 0x00000044 }
        "vs_shift_trigger2"     { return 0x00000048 }
        "vs_shift_trigger3"     { return 0x0000004c }
        "vs_shift_rm_bs_index0" { return 0x00000080 }
        "vs_shift_rm_control0"  { return 0x00000084 }
        "vs_shift_rm_bs_index1" { return 0x00000088 }
        "vs_shift_rm_control1"  { return 0x0000008c }
        "vs_shift_rm_bs_index2" { return 0x00000090 }
        "vs_shift_rm_control2"  { return 0x00000094 }
        "vs_shift_rm_bs_index3" { return 0x00000098 }
        "vs_shift_rm_control3"  { return 0x0000009c }
        "vs_shift_bs_id0"       { return 0x000000c0 }
        "vs_shift_bs_address0"  { return 0x000000c4 }
        "vs_shift_bs_size0"     { return 0x000000c8 }
        "vs_shift_bs_id1"       { return 0x000000d0 }
        "vs_shift_bs_address1"  { return 0x000000d4 }
        "vs_shift_bs_size1"     { return 0x000000d8 }
        "vs_shift_bs_id2"       { return 0x000000e0 }
        "vs_shift_bs_address2"  { return 0x000000e4 }
        "vs_shift_bs_size2"     { return 0x000000e8 }
        "vs_shift_bs_id3"       { return 0x000000f0 }
        "vs_shift_bs_address3"  { return 0x000000f4 }
        "vs_shift_bs_size3"     { return 0x000000f8 }
        "vs_count_status"       { return 0x00000100 }
        "vs_count_control"      { return 0x00000100 }
        "vs_count_sw_trigger"   { return 0x00000104 }
        "vs_count_trigger0"     { return 0x00000140 }
        "vs_count_trigger1"     { return 0x00000144 }
        "vs_count_trigger2"     { return 0x00000148 }
        "vs_count_trigger3"     { return 0x0000014c }
        "vs_count_rm_bs_index0" { return 0x00000180 }
        "vs_count_rm_control0"  { return 0x00000184 }
        "vs_count_rm_bs_index1" { return 0x00000188 }
        "vs_count_rm_control1"  { return 0x0000018c }
        "vs_count_bs_id0"       { return 0x000001c0 }
        "vs_count_bs_address0"  { return 0x000001c4 }
        "vs_count_bs_size0"     { return 0x000001c8 }
        "vs_count_bs_id1"       { return 0x000001d0 }
        "vs_count_bs_address1"  { return 0x000001d4 }
        "vs_count_bs_size1"     { return 0x000001d8 }
        default {                return "Unknown register $reg_name"
        }
    }
}

# ========================================================================
# Low Level register access: READ
# ========================================================================
#
proc dfxc_read_register {reg_name} {
    set_property CMD.ADDR [dfxc_get_address $reg_name] [get_hw_axi_txns dfxc_txn]
    set_property TYPE READ                            [get_hw_axi_txns dfxc_txn]
    run_hw_axi dfxc_txn -quiet
    set data_in_hex [get_property DATA [get_hw_axi_txns dfxc_txn]] 

    # data_in_hex is a hex string, padded on the left with zeros to be 0 chars wide.
    #  e.g.
    #    00000001
    #    000abcde
    # This can give problems elsewhere, so convert to decimal with no loading zeros.
    
    set data_in_dec [expr 0x$data_in_hex]
    return $data_in_dec
}


# ========================================================================
# Low Level register access: WRITE
# ========================================================================
#
proc dfxc_write_register {reg_name data} {
    set data [format %08x $data]
    set_property CMD.ADDR [dfxc_get_address $reg_name] [get_hw_axi_txns dfxc_txn]
    set_property TYPE WRITE                           [get_hw_axi_txns dfxc_txn]
    set_property DATA $data                           [get_hw_axi_txns dfxc_txn] -quiet
    run_hw_axi dfxc_txn 
}
