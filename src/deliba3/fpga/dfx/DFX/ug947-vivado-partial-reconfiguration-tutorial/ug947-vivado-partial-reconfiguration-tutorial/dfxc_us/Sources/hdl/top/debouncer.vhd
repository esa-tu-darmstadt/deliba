-- --------------------------------------------------------------
--  Copyright (c) 2015-2020 Xilinx, Inc.
--  This design is confidential and proprietary of Xilinx, Inc.
--  All Rights Reserved.
-- --------------------------------------------------------------
--    ____  ____
--   /   /\/   /
--  /___/  \  /   Vendor: Xilinx
--  \   \   \/    Version: 1.1
--   \   \        Application: Dynamic Function eXchange
--   /   /        Filename: debouncer.vhd
--  /___/   /\    Date Last Modified: 14 FEB 2020
--  \   \  /  \
--   \___\/\___\
-- --------------------------------------------------------------
-- Debounce a signal to reject pulses that are below a certain duration
--
--
-- The debounce counter starts at 0 when the input changes
-- It counts when the MSB is 0
-- It stops counting when the MSB is one.
-- Therefore, it counts 2^(C_WIDTH-1) clock cycles
--
-- Debounce time = debounce_time
-- Clock period = clk_period = 1/f seconds (f = frequency in Hz)
-- Number of counter states needed = debounce_time / clock_period
-- Number of bits needed = log2(debounce_time / clock_period) + 1 (for the MSB overflow)
-- Number of bits needed = log2(debounce_time * frequency_in_hz) + 1 (for the MSB overflow)
--  
-- For approx 10ms:
--    50 MHz: 20 bits
--   100 MHz: 21 bits
--   150 MHz: 22 bits
--   200 MHz: 22 bits
--   250 MHz: 23 bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
  generic (
    C_WIDTH            :     integer := 10);  -- The number of bits in the debounce counter
  port (
    clk                : in  std_logic;
    input_to_debounce : in  std_logic;
    debounced_signal   : out std_logic := '0'
    );
end debouncer;

architecture rtl of debouncer is
  signal input_to_debounce_d1 : std_logic := '0';
begin

  -- Basic Algorithm
  -- -------------------------------
  -- The output can only change to the input if the input has been stable for long enough.
  -- We have a big counter.  When the input changes, start counting.
  -- When the counter reaches its terminal value, update the output.  For speed, use the MSB
  -- of the counter as the terminal count.  If it's 0 we haven't reached terminal count.  If it's 1
  -- then we have.  It wastes a bit but saves a C_WIDTH comparator looking for the all 1 case.

  p_counter                   : process (clk)
    variable v_us_count_value : unsigned(C_WIDTH-1 downto 0) := to_unsigned(0, C_WIDTH);
  begin
    if rising_edge(clk) then
      -- Save the previous value so we can check if it has changed
      --
      input_to_debounce_d1 <= input_to_debounce;

      if input_to_debounce /= input_to_debounce_d1 then
        -- The input has changed.  Reset the counter
        --
        v_us_count_value := to_unsigned(0, C_WIDTH);
      elsif v_us_count_value(C_WIDTH-1) /= '1' then
        -- We haven't reached terminal count yet
        --
        v_us_count_value := v_us_count_value + to_unsigned(1, C_WIDTH);
      end if;

      if v_us_count_value(C_WIDTH-1) = '1' then
        -- We have reached terminal count.  Update the output
        debounced_signal <= input_to_debounce_d1;
      end if;
    end if;
  end process p_counter;
end rtl;
