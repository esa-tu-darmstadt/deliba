-- --------------------------------------------------------------
--  Copyright (c) 2015-2020 Xilinx, Inc.
--  This design is confidential and proprietary of Xilinx, Inc.
--  All Rights Reserved.
-- --------------------------------------------------------------
--    ____  ____
--   /   /\/   /
--  /___/  \  /   Vendor: Xilinx
--  \   \   \/    Version: 1.2
--   \   \        Application: Dynamic Function eXchange
--   /   /        Filename: top.vhd
--  /___/   /\    Date Last Modified: 20 Feb 2020
--  \   \  /  \
--   \___\/\___\
-- --------------------------------------------------------------
-- This is the tutorial design controlled by a prototype Dynamic Function eXchange Controller
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

library UNISIM;
use UNISIM.vcomponents.all;

entity top is
  port(
    -- Clocks
    --
    clk_p     : in  std_logic;                     -- 200MHz differential input clock
    clk_n     : in  std_logic;                     -- 200MHz differential input clock
    count_out : out std_logic_vector(3 downto 0);  -- mapped to general purpose LEDs[4-7]
    shift_out : out std_logic_vector(3 downto 0);  -- mapped to general purpose LEDs[0-3]

    -- Buttons
    -- 
    GPIO_SW_N : in std_logic;
    GPIO_SW_S : in std_logic;
    GPIO_SW_W : in std_logic;
    GPIO_SW_E : in std_logic;
    GPIO_SW_C : in std_logic;

    -- ROM
    --
    rom_data_in : in  std_logic_vector(15 downto 0);
    rom_address : out std_logic_vector(25 downto 0);
    rom_cen     : out std_logic_vector(0 downto 0);  -- CEn gets attached to FPGA_FCS (Common chip select) but the M0 switch has to be low or the BPI is completely disabled
    rom_oen     : out std_logic_vector(0 downto 0);
    rom_wait    : in  std_logic_vector(0 downto 0);
    rom_adv_ldn : out std_logic;
    rom_wen     : out std_logic
    );
end top;

architecture rtl of top is

  -- -------------------------------------------------------------------------
  -- Board signals
  -- -------------------------------------------------------------------------
  signal gpio_sw_n_dbnc : std_logic;    -- Debounced input button
  signal gpio_sw_s_dbnc : std_logic;    -- Debounced input button
  signal gpio_sw_e_dbnc : std_logic;    -- Debounced input button
  signal gpio_sw_w_dbnc : std_logic;    -- Debounced input button
  signal gpio_sw_c_dbnc : std_logic;    -- Debounced input button


  -- -------------------------------------------------------------------------
  -- System signals
  -- -------------------------------------------------------------------------
  signal clk_100   : std_logic;         -- 100 MHz clock
  signal rst       : std_logic := '1';
  signal por_rst_n : std_logic := '0';


  constant DEBOUNCE_SIZE : integer := 21;  -- 10ms at 100MHz

  constant C_XDEVICEFAMILY      : string    := "kintex7";
  constant C_RESET_ACTIVE_LEVEL : std_logic := '1';  -- Active high resets

  constant C_NUM_VIRTUAL_SOCKETS   : integer := 2;
  constant C_NUM_TRIGGERS_VS_SHIFT : integer := 4;
  constant C_NUM_TRIGGERS_VS_COUNT : integer := 4;


  constant C_ICAP_DATA_WIDTH : integer := 32;
  constant C_CL0_ADDR_WIDTH  : integer := 32;  -- Used by the datamover so can only be 32 or 64
  constant C_CL0_DATA_WIDTH  : integer := 32;  -- The width of the AXI bus attached to the memory.  It's used by the datamover
                                               -- and can be 32, 64, 128, 256, 512 or 1024

  -- ------------------------------------------------------------------------  
  -- DUT Ports
  -- ------------------------------------------------------------------------

  -- The VSM interface signals
  signal vs_shift_hw_triggers     : std_logic_vector(C_NUM_TRIGGERS_VS_SHIFT -1 downto 0) := (others => '0');
  signal vs_shift_axis_status     : std_logic_vector(31 downto 0)                         := (others => '0');
  signal vs_shift_rm_shutdown_req : std_logic                                             := '0';
  signal vs_shift_rm_shutdown_ack : std_logic                                             := '1';
  signal vs_shift_rm_decouple     : std_logic                                             := '0';
  signal vs_shift_rm_reset        : std_logic                                             := '0';
  signal vs_count_hw_triggers     : std_logic_vector(C_NUM_TRIGGERS_VS_COUNT-1 downto 0)  := (others => '0');
  signal vs_count_rm_shutdown_req : std_logic                                             := '0';
  signal vs_count_rm_shutdown_ack : std_logic                                             := '1';
  signal vs_count_rm_decouple     : std_logic                                             := '0';
  signal vs_count_rm_reset        : std_logic                                             := '0';

  -- The ICAP interace signals
  signal icap_i     : std_logic_vector(C_ICAP_DATA_WIDTH-1 downto 0);                  -- Width is programable but ICAPE unisim hardwires it to 32
  signal icap_o     : std_logic_vector(C_ICAP_DATA_WIDTH-1 downto 0);                  -- Width is programable but ICAPE unisim hardwires it to 32
  signal icap_csib  : std_logic;
  signal icap_rdwrb : std_logic;
  signal cap_req    : std_logic := '1';  -- Request the ICAP port                      -- NOT USED
  signal cap_gnt    : std_logic := '1';  -- ICAP granted                               -- NOT USED
  signal cap_rel    : std_logic := '0';  -- Release the ICAP at the first opportunity  -- NOT USED

  -- The interface to the external memory
  signal m_axi_mem_araddr         : std_logic_vector(C_CL0_ADDR_WIDTH-1 downto 0);  -- First Read  Address
  signal m_axi_mem_arlen          : std_logic_vector(7 downto 0);                   -- Burst Length: 1-256 transfers.  Length = m_axi_mem_arlen+1
  signal m_axi_mem_arsize         : std_logic_vector(2 downto 0);                   -- Burst Size:  Bytes in transfer. 1, 2, 3, 8, 16, 32, 64 or 128 
  signal m_axi_mem_arburst        : std_logic_vector(1 downto 0);                   -- Burst Type: Fixed or incr
  signal m_axi_mem_arprot         : std_logic_vector(2 downto 0);                   -- Protection type
  signal m_axi_mem_arcache        : std_logic_vector(3 downto 0);                   -- Memory type 
  signal m_axi_mem_aruser         : std_logic_vector(3 downto 0);                   -- User signal
  signal m_axi_mem_arvalid        : std_logic;                                      -- Read address valid
  signal m_axi_mem_arready        : std_logic;                                      -- Read address ready.  
  signal m_axi_mem_rdata          : std_logic_vector(C_CL0_DATA_WIDTH-1 downto 0);
  signal m_axi_mem_rresp          : std_logic_vector(1 downto 0);
  signal m_axi_mem_rresp_original : std_logic_vector(1 downto 0);
  signal m_axi_mem_rlast          : std_logic;
  signal m_axi_mem_rvalid         : std_logic;
  signal m_axi_mem_rready         : std_logic;


  signal rom_address_full : std_logic_vector(31 downto 0);
  signal count_value      : std_logic_vector(34 downto 0);
  signal reset_vector     : std_logic_vector(15 downto 0) := (others => '1');

  signal rom_cen_i     : std_logic_vector(0 downto 0);
  signal rom_oen_i     : std_logic_vector(0 downto 0);
  signal rom_adv_ldn_i : std_logic_vector(0 downto 0);
  signal rom_wen_i     : std_logic_vector(0 downto 0);

  -- JTAG to AXI Lite interface signals
  signal m_axi_awaddr  : std_logic_vector(31 downto 0);
  signal m_axi_awvalid : std_logic;
  signal m_axi_awready : std_logic;
  signal m_axi_wdata   : std_logic_vector(31 downto 0);
  signal m_axi_wvalid  : std_logic;
  signal m_axi_wready  : std_logic;
  signal m_axi_bresp   : std_logic_vector(1 downto 0);
  signal m_axi_bvalid  : std_logic;
  signal m_axi_bready  : std_logic;
  signal m_axi_araddr  : std_logic_vector(31 downto 0);
  signal m_axi_arvalid : std_logic;
  signal m_axi_arready : std_logic;
  signal m_axi_rdata   : std_logic_vector(31 downto 0);
  signal m_axi_rresp   : std_logic_vector(1 downto 0);
  signal m_axi_rvalid  : std_logic;
  signal m_axi_rready  : std_logic;


  component dfx_controller
    port (
      clk                               : in  std_logic;
      reset                             : in  std_logic;
      vsm_vs_shift_hw_triggers          : in  std_logic_vector(3 downto 0);
      vsm_vs_shift_rm_shutdown_req      : out std_logic;
      vsm_vs_shift_rm_shutdown_ack      : in  std_logic;
      vsm_vs_shift_rm_decouple          : out std_logic;
      vsm_vs_shift_rm_reset             : out std_logic;
      vsm_vs_shift_event_error          : out std_logic;
      vsm_vs_shift_m_axis_status_tdata  : out std_logic_vector(31 downto 0);
      vsm_vs_shift_m_axis_status_tvalid : out std_logic;
      vsm_vs_count_hw_triggers          : in  std_logic_vector(3 downto 0);
      vsm_vs_count_rm_shutdown_req      : out std_logic;
      vsm_vs_count_rm_shutdown_ack      : in  std_logic;
      vsm_vs_count_rm_decouple          : out std_logic;
      vsm_vs_count_rm_reset             : out std_logic;
      vsm_vs_count_event_error          : out std_logic;
      icap_clk                          : in  std_logic;
      icap_reset                        : in  std_logic;
      icap_i                            : in  std_logic_vector(31 downto 0);
      icap_o                            : out std_logic_vector(31 downto 0);
      icap_csib                         : out std_logic;
      icap_rdwrb                        : out std_logic;
      cap_req                           : out std_logic;
      cap_gnt                           : in  std_logic;
      cap_rel                           : in  std_logic;
      s_axi_reg_awaddr                  : in  std_logic_vector(31 downto 0);
      s_axi_reg_awvalid                 : in  std_logic;
      s_axi_reg_awready                 : out std_logic;
      s_axi_reg_wdata                   : in  std_logic_vector(31 downto 0);
      s_axi_reg_wvalid                  : in  std_logic;
      s_axi_reg_wready                  : out std_logic;
      s_axi_reg_bresp                   : out std_logic_vector(1 downto 0);
      s_axi_reg_bvalid                  : out std_logic;
      s_axi_reg_bready                  : in  std_logic;
      s_axi_reg_araddr                  : in  std_logic_vector(31 downto 0);
      s_axi_reg_arvalid                 : in  std_logic;
      s_axi_reg_arready                 : out std_logic;
      s_axi_reg_rdata                   : out std_logic_vector(31 downto 0);
      s_axi_reg_rresp                   : out std_logic_vector(1 downto 0);
      s_axi_reg_rvalid                  : out std_logic;
      s_axi_reg_rready                  : in  std_logic;
      m_axi_mem_araddr                  : out std_logic_vector(31 downto 0);
      m_axi_mem_arlen                   : out std_logic_vector(7 downto 0);
      m_axi_mem_arsize                  : out std_logic_vector(2 downto 0);
      m_axi_mem_arburst                 : out std_logic_vector(1 downto 0);
      m_axi_mem_arprot                  : out std_logic_vector(2 downto 0);
      m_axi_mem_arcache                 : out std_logic_vector(3 downto 0);
      m_axi_mem_aruser                  : out std_logic_vector(3 downto 0);
      m_axi_mem_arvalid                 : out std_logic;
      m_axi_mem_arready                 : in  std_logic;
      m_axi_mem_rdata                   : in  std_logic_vector(31 downto 0);
      m_axi_mem_rresp                   : in  std_logic_vector(1 downto 0);
      m_axi_mem_rlast                   : in  std_logic;
      m_axi_mem_rvalid                  : in  std_logic;
      m_axi_mem_rready                  : out std_logic);
  end component;

  component jtag_to_axi
    port (
      aclk          : in  std_logic;
      aresetn       : in  std_logic;
      m_axi_awaddr  : out std_logic_vector(31 downto 0);
      m_axi_awprot  : out std_logic_vector(2 downto 0);
      m_axi_awvalid : out std_logic;
      m_axi_awready : in  std_logic;
      m_axi_wdata   : out std_logic_vector(31 downto 0);
      m_axi_wstrb   : out std_logic_vector(3 downto 0);
      m_axi_wvalid  : out std_logic;
      m_axi_wready  : in  std_logic;
      m_axi_bresp   : in  std_logic_vector(1 downto 0);
      m_axi_bvalid  : in  std_logic;
      m_axi_bready  : out std_logic;
      m_axi_araddr  : out std_logic_vector(31 downto 0);
      m_axi_arprot  : out std_logic_vector(2 downto 0);
      m_axi_arvalid : out std_logic;
      m_axi_arready : in  std_logic;
      m_axi_rdata   : in  std_logic_vector(31 downto 0);
      m_axi_rresp   : in  std_logic_vector(1 downto 0);
      m_axi_rvalid  : in  std_logic;
      m_axi_rready  : out std_logic
      );
  end component;

  component axi_emc_inst
    port (
      s_axi_aclk        : in  std_logic;
      s_axi_aresetn     : in  std_logic;
      rdclk             : in  std_logic;
      s_axi_mem_awid    : in  std_logic_vector(0 downto 0);
      s_axi_mem_awaddr  : in  std_logic_vector(31 downto 0);
      s_axi_mem_awlen   : in  std_logic_vector(7 downto 0);
      s_axi_mem_awsize  : in  std_logic_vector(2 downto 0);
      s_axi_mem_awburst : in  std_logic_vector(1 downto 0);
      s_axi_mem_awlock  : in  std_logic;
      s_axi_mem_awcache : in  std_logic_vector(3 downto 0);
      s_axi_mem_awprot  : in  std_logic_vector(2 downto 0);
      s_axi_mem_awvalid : in  std_logic;
      s_axi_mem_awready : out std_logic;
      s_axi_mem_wdata   : in  std_logic_vector(31 downto 0);
      s_axi_mem_wstrb   : in  std_logic_vector(3 downto 0);
      s_axi_mem_wlast   : in  std_logic;
      s_axi_mem_wvalid  : in  std_logic;
      s_axi_mem_wready  : out std_logic;
      s_axi_mem_bid     : out std_logic_vector(0 downto 0);
      s_axi_mem_bresp   : out std_logic_vector(1 downto 0);
      s_axi_mem_bvalid  : out std_logic;
      s_axi_mem_bready  : in  std_logic;
      s_axi_mem_arid    : in  std_logic_vector(0 downto 0);
      s_axi_mem_araddr  : in  std_logic_vector(31 downto 0);
      s_axi_mem_arlen   : in  std_logic_vector(7 downto 0);
      s_axi_mem_arsize  : in  std_logic_vector(2 downto 0);
      s_axi_mem_arburst : in  std_logic_vector(1 downto 0);
      s_axi_mem_arlock  : in  std_logic;
      s_axi_mem_arcache : in  std_logic_vector(3 downto 0);
      s_axi_mem_arprot  : in  std_logic_vector(2 downto 0);
      s_axi_mem_arvalid : in  std_logic;
      s_axi_mem_arready : out std_logic;
      s_axi_mem_rid     : out std_logic_vector(0 downto 0);
      s_axi_mem_rdata   : out std_logic_vector(31 downto 0);
      s_axi_mem_rresp   : out std_logic_vector(1 downto 0);
      s_axi_mem_rlast   : out std_logic;
      s_axi_mem_rvalid  : out std_logic;
      s_axi_mem_rready  : in  std_logic;
      mem_dq_i          : in  std_logic_vector(15 downto 0);
      mem_dq_o          : out std_logic_vector(15 downto 0);
      mem_dq_t          : out std_logic_vector(15 downto 0);
      mem_a             : out std_logic_vector(31 downto 0);
      mem_ce            : out std_logic_vector(0 downto 0);
      mem_cen           : out std_logic_vector(0 downto 0);
      mem_oen           : out std_logic_vector(0 downto 0);
      mem_wen           : out std_logic;
      mem_ben           : out std_logic_vector(1 downto 0);
      mem_qwen          : out std_logic_vector(1 downto 0);
      mem_rpn           : out std_logic;
      mem_adv_ldn       : out std_logic;
      mem_lbon          : out std_logic;
      mem_cken          : out std_logic;
      mem_rnw           : out std_logic;
      mem_cre           : out std_logic;
      mem_wait          : in  std_logic_vector(0 downto 0)
      );
  end component;

  component clocks
    port (
      clk_p   : in  std_logic;
      clk_n   : in  std_logic;
      rst     : in  std_logic;
      clk_out : out std_logic
      );
  end component;

  component shift
    port(
      en       : in  std_logic;
      clk      : in  std_logic;
      addr     : in  std_logic_vector (11 downto 0);
      data_out : out std_logic_vector (3 downto 0)
      );
  end component;

  component count
    port (
      rst       : in  std_logic;
      clk       : in  std_logic;
      count_out : out std_logic_vector(3 downto 0)
      );
  end component;

  component ila_vs_count
    port (
      clk          : in  std_logic;
      trig_out     : out std_logic;
      trig_out_ack : in  std_logic;
      probe0       : in  std_logic_vector(3 downto 0);  -- awid
      probe1       : in  std_logic_vector(0 downto 0);  -- awaddr
      probe2       : in  std_logic_vector(0 downto 0);  -- awlen
      probe3       : in  std_logic_vector(0 downto 0);  -- awsize
      probe4       : in  std_logic_vector(0 downto 0)   -- awburst
      );
  end component;

  component ila_vs_shift
    port (
      clk          : in  std_logic;
      trig_out     : out std_logic;
      trig_out_ack : in  std_logic;
      probe0       : in  std_logic_vector(3 downto 0);
      probe1       : in  std_logic_vector(0 downto 0);
      probe2       : in  std_logic_vector(0 downto 0);
      probe3       : in  std_logic_vector(0 downto 0);
      probe4       : in  std_logic_vector(0 downto 0);
      probe5       : in  std_logic_vector(31 downto 0)
      );
  end component;

  component ila_rom
    port (
      clk          : in  std_logic;
      trig_out     : out std_logic;
      trig_out_ack : in  std_logic;
      probe0       : in  std_logic_vector(15 downto 0);
      probe1       : in  std_logic_vector(25 downto 0);
      probe2       : in  std_logic_vector( 0 downto 0);
      probe3       : in  std_logic_vector( 0 downto 0);
      probe4       : in  std_logic_vector( 0 downto 0);
      probe5       : in  std_logic_vector( 0 downto 0);
      probe6       : in  std_logic_vector( 0 downto 0)
      );
  end component;


  component ila_icap
    port (
      clk          : in  std_logic;
      trig_out     : out std_logic;
      trig_out_ack : in  std_logic;
      probe0       : in  std_logic_vector(31 downto 0);
      probe1       : in  std_logic_vector(3 downto 0);
      probe2       : in  std_logic_vector(0 downto 0);
      probe3       : in  std_logic_vector(0 downto 0)
      );
  end component;

  component ila_axi_mem
    port (
      clk     : in std_logic;
      probe0  : in std_logic_vector(31 downto 0);
      probe1  : in std_logic_vector(7 downto 0);
      probe2  : in std_logic_vector(2 downto 0);
      probe3  : in std_logic_vector(1 downto 0);
      probe4  : in std_logic_vector(2 downto 0);
      probe5  : in std_logic_vector(3 downto 0);
      probe6  : in std_logic_vector(3 downto 0);
      probe7  : in std_logic_vector(0 downto 0);
      probe8  : in std_logic_vector(0 downto 0);
      probe9  : in std_logic_vector(31 downto 0);
      probe10 : in std_logic_vector(1 downto 0);
      probe11 : in std_logic_vector(0 downto 0);
      probe12 : in std_logic_vector(0 downto 0);
      probe13 : in std_logic_vector(0 downto 0)
      );
  end component;



  component ila_axi_reg
    port (
      clk     : in std_logic;
      probe0  : in std_logic_vector(31 downto 0);
      probe1  : in std_logic_vector(0 downto 0);
      probe2  : in std_logic_vector(0 downto 0);
      probe3  : in std_logic_vector(31 downto 0);
      probe4  : in std_logic_vector(0 downto 0);
      probe5  : in std_logic_vector(0 downto 0);
      probe6  : in std_logic_vector(1 downto 0);
      probe7  : in std_logic_vector(0 downto 0);
      probe8  : in std_logic_vector(0 downto 0);
      probe9  : in std_logic_vector(31 downto 0);
      probe10 : in std_logic_vector(0 downto 0);
      probe11 : in std_logic_vector(0 downto 0);
      probe12 : in std_logic_vector(31 downto 0);
      probe13 : in std_logic_vector(1 downto 0);
      probe14 : in std_logic_vector(0 downto 0);
      probe15 : in std_logic_vector(0 downto 0)
      );
  end component;


  -- Don't touch signals used for debug.  
  attribute dont_touch                             : string;
  attribute dont_touch of vs_count_rm_shutdown_req : signal is "true";
  attribute dont_touch of vs_count_rm_shutdown_ack : signal is "true";
  attribute dont_touch of vs_count_rm_decouple     : signal     is "true";
  attribute dont_touch of vs_count_rm_reset        : signal        is "true";
  attribute dont_touch of vs_shift_rm_shutdown_req : signal is "true";
  attribute dont_touch of vs_shift_rm_shutdown_ack : signal is "true";
  attribute dont_touch of vs_shift_rm_decouple     : signal     is "true";
  attribute dont_touch of vs_shift_rm_reset        : signal        is "true";
  attribute dont_touch of vs_shift_axis_status     : signal     is "true";
  attribute dont_touch of rom_address_full         : signal         is "true";

begin

  -- Generate a synchronous reset pulse that's long enough for the various AXI IP.
  -- If I don't do this then a FIFO in the AXI_EMC becomes corrupted.  I never worked out why -
  -- I can only guess that the runt pulse created by the MMCM causes it to see a reset,
  -- which then doesn't last long enough.  
  --
  p_reset : process (clk_100)
  begin
    if rising_edge(clk_100) then
      reset_vector <= '0' & reset_vector(15 downto 1);
    end if;
  end process p_reset;

  -- Generate an active high reset for the DFX Controller, either at power on or when the user presses the center button
  rst <= '1' when reset_vector(0) = '1' or gpio_sw_c_dbnc = '1' else '0';

  -- Generate a reset for the AXI EMC block at power on
  por_rst_n <= not reset_vector(0);

  -- -------------------------------------------------------------------------
  -- System Connections
  -- -------------------------------------------------------------------------

  -- instantiate clock module to divide 200MHz to 100MHz
  U0_clocks : clocks
    port map(
      clk_p   => clk_p,
      clk_n   => clk_n,
      rst     => '0',
      clk_out => clk_100
      );

  -- -------------------------------------------------------------------------
  -- Virtual Sockets 
  -- -------------------------------------------------------------------------
  -- Virtual Socket 0: shift
  inst_shift : shift
    port map (
      en       => vs_shift_rm_reset,
      clk      => clk_100,
      addr     => count_value(34 downto 23),
      data_out => shift_out
      );

  -- Virtual Socket 1: count
  inst_count : count
    port map (
      rst       => vs_count_rm_reset,
      clk       => clk_100,
      count_out => count_out
      );


  -- -------------------------------------------------------------------------
  -- Dynamic Function eXchange Controller 
  -- -------------------------------------------------------------------------
  i_dfx_controller : dfx_controller port map ( clk   => clk_100,
                         reset => rst,

                         -- ----------------------------------------------------------------
                         -- Signals for vs_shift Interface
                         -- ----------------------------------------------------------------
                         vsm_vs_shift_hw_triggers          => vs_shift_hw_triggers,
                         vsm_vs_shift_rm_shutdown_req      => vs_shift_rm_shutdown_req,
                         vsm_vs_shift_rm_shutdown_ack      => vs_shift_rm_shutdown_ack,
                         vsm_vs_shift_rm_decouple          => vs_shift_rm_decouple,
                         vsm_vs_shift_rm_reset             => vs_shift_rm_reset,
                         vsm_vs_shift_m_axis_status_tdata  => vs_shift_axis_status,
                         vsm_vs_shift_m_axis_status_tvalid => open,

                         -- ----------------------------------------------------------------
                         -- Signals for VSM1 Interface
                         -- ----------------------------------------------------------------
                         vsm_vs_count_hw_triggers     => vs_count_hw_triggers,
                         vsm_vs_count_rm_shutdown_req => vs_count_rm_shutdown_req,
                         vsm_vs_count_rm_shutdown_ack => vs_count_rm_shutdown_ack,
                         vsm_vs_count_rm_decouple     => vs_count_rm_decouple,
                         vsm_vs_count_rm_reset        => vs_count_rm_reset,

                         -- ----------------------------------------------------------------
                         -- Signals for Configuration Ports
                         -- ----------------------------------------------------------------
                         icap_clk   => clk_100,
                         icap_reset => rst,

                         -- ----------------------------------------------------------------
                         --ICAP signals   
                         -- ----------------------------------------------------------------
                         icap_i     => icap_o,
                         icap_o     => icap_i,
                         icap_csib  => icap_csib,
                         icap_rdwrb => icap_rdwrb,
                         cap_req    => cap_req,
                         cap_gnt    => cap_gnt,
                         cap_rel    => cap_rel,

                         -- ----------------------------------------------------------------
                         -- Signals for AXI Lite Register interface
                         -- ----------------------------------------------------------------
                         s_axi_reg_awaddr  => m_axi_awaddr,
                         s_axi_reg_awvalid => m_axi_awvalid,
                         s_axi_reg_awready => m_axi_awready,
                         s_axi_reg_wdata   => m_axi_wdata,
                         s_axi_reg_wvalid  => m_axi_wvalid,
                         s_axi_reg_wready  => m_axi_wready,
                         s_axi_reg_bresp   => m_axi_bresp,
                         s_axi_reg_bvalid  => m_axi_bvalid,
                         s_axi_reg_bready  => m_axi_bready,
                         s_axi_reg_araddr  => m_axi_araddr,
                         s_axi_reg_arvalid => m_axi_arvalid,
                         s_axi_reg_arready => m_axi_arready,
                         s_axi_reg_rdata   => m_axi_rdata,
                         s_axi_reg_rresp   => m_axi_rresp,
                         s_axi_reg_rvalid  => m_axi_rvalid,
                         s_axi_reg_rready  => m_axi_rready,


                         -- ----------------------------------------------------------------
                         -- Signals for Configuration Libraries
                         -- ----------------------------------------------------------------
                         -- The interface to the External Memory Controller
                         --
                         m_axi_mem_araddr  => m_axi_mem_araddr,
                         m_axi_mem_arlen   => m_axi_mem_arlen,
                         m_axi_mem_arsize  => m_axi_mem_arsize,
                         m_axi_mem_arburst => m_axi_mem_arburst,
                         m_axi_mem_arprot  => m_axi_mem_arprot,
                         m_axi_mem_arcache => m_axi_mem_arcache,
                         m_axi_mem_aruser  => m_axi_mem_aruser,
                         m_axi_mem_arvalid => m_axi_mem_arvalid,
                         m_axi_mem_arready => m_axi_mem_arready,
                         m_axi_mem_rdata   => m_axi_mem_rdata,
                         m_axi_mem_rresp   => m_axi_mem_rresp,
                         m_axi_mem_rlast   => m_axi_mem_rlast,
                         m_axi_mem_rvalid  => m_axi_mem_rvalid,
                         m_axi_mem_rready  => m_axi_mem_rready
                         );

  -- Connect up the triggers

  -- The RM0/RM1 mappings to actual models is handled by the way I program the ROM and the addresses
  --       I set in the controller
  -- VS0: Shift
  --      RM0: Left
  --      RM1: Right
  -- VS1: Count
  --      RM0: Up
  --      RM1: Down
  vs_shift_hw_triggers(0) <= gpio_sw_w_dbnc;
  vs_shift_hw_triggers(1) <= gpio_sw_e_dbnc;
  vs_shift_hw_triggers(2) <= '0';
  vs_shift_hw_triggers(3) <= '0';

  vs_count_hw_triggers(0) <= gpio_sw_n_dbnc;
  vs_count_hw_triggers(1) <= gpio_sw_s_dbnc;
  vs_count_hw_triggers(2) <= '0';
  vs_count_hw_triggers(3) <= '0';


  -- Instantiate the JTAG to AXI master
  i_jtag_to_axi : jtag_to_axi
    port map (
      aclk          => clk_100,
      aresetn       => por_rst_n,
      m_axi_awaddr  => m_axi_awaddr,
      m_axi_awprot  => open,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_awready => m_axi_awready,
      m_axi_wdata   => m_axi_wdata,
      m_axi_wstrb   => open,
      m_axi_wvalid  => m_axi_wvalid,
      m_axi_wready  => m_axi_wready,
      m_axi_bresp   => m_axi_bresp,
      m_axi_bvalid  => m_axi_bvalid,
      m_axi_bready  => m_axi_bready,
      m_axi_araddr  => m_axi_araddr,
      m_axi_arprot  => open,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_arready => m_axi_arready,
      m_axi_rdata   => m_axi_rdata,
      m_axi_rresp   => m_axi_rresp,
      m_axi_rvalid  => m_axi_rvalid,
      m_axi_rready  => m_axi_rready
      );



  -- Instantiate ICAP primitive
  --
  ICAPE2_inst : ICAPE2
    generic map (
      DEVICE_ID  => X"3651093",         -- Device ID code for Kintex-7 XC7K325T-2FFG900C
      ICAP_WIDTH => "X32"               -- Specifies the input and output data width to be used with the ICAPE2.
      )
    port map (
      O          => icap_o,             -- 32-bit output: Configuration data output bus
      CLK        => clk_100,            -- 1-bit input: Clock Input
      CSIB       => icap_csib,          -- 1-bit input: Active-Low ICAP Enable
      I          => icap_i,             -- 32-bit input: Configuration data input bus
      RDWRB      => icap_rdwrb          -- 1-bit input: Read/Write Select input
      );


  -- -------------------------------------------------------------------------
  -- Debug
  -- -------------------------------------------------------------------------
  --VS_COUNT
  -- probe 0: vs_shift_hw_triggers    
  -- probe 1: vs_shift_rm_shutdown_req
  -- probe 2: vs_shift_rm_shutdown_ack
  -- probe 3: vs_shift_rm_decouple    
  -- probe 4: vs_shift_rm_reset       


  b_ila_vs_count                      : block
    signal vs_count_rm_shutdown_req_v : std_logic_vector(0 downto 0);
    signal vs_count_rm_shutdown_ack_v : std_logic_vector(0 downto 0);
    signal vs_count_rm_decouple_v     : std_logic_vector(0 downto 0);
    signal vs_count_rm_reset_v        : std_logic_vector(0 downto 0);
  begin

    vs_count_rm_shutdown_req_v(0) <= vs_count_rm_shutdown_req;
    vs_count_rm_shutdown_ack_v(0) <= vs_count_rm_shutdown_ack;
    vs_count_rm_decouple_v (0)    <= vs_count_rm_decouple;
    vs_count_rm_reset_v (0)       <= vs_count_rm_reset;

    i_ila_vs_count : ila_vs_count
      port map (
        clk          => clk_100,
        trig_out     => open,
        trig_out_ack => '1',
        probe0       => vs_count_hw_triggers,
        probe1       => vs_count_rm_shutdown_req_v,
        probe2       => vs_count_rm_shutdown_ack_v,
        probe3       => vs_count_rm_decouple_v,
        probe4       => vs_count_rm_reset_v
        );
  end block;

  b_ila_vs_shift                      : block
    signal vs_shift_rm_shutdown_req_v : std_logic_vector(0 downto 0);
    signal vs_shift_rm_shutdown_ack_v : std_logic_vector(0 downto 0);
    signal vs_shift_rm_decouple_v     : std_logic_vector(0 downto 0);
    signal vs_shift_rm_reset_v        : std_logic_vector(0 downto 0);
  begin

    vs_shift_rm_shutdown_req_v(0) <= vs_shift_rm_shutdown_req;
    vs_shift_rm_shutdown_ack_v(0) <= vs_shift_rm_shutdown_ack;
    vs_shift_rm_decouple_v (0)    <= vs_shift_rm_decouple;
    vs_shift_rm_reset_v (0)       <= vs_shift_rm_reset;

    i_ila_vs_shift : ila_vs_shift
      port map (
        clk          => clk_100,
        trig_out     => open,
        trig_out_ack => '1',
        probe0       => vs_shift_hw_triggers,
        probe1       => vs_shift_rm_shutdown_req_v,
        probe2       => vs_shift_rm_shutdown_ack_v,
        probe3       => vs_shift_rm_decouple_v,
        probe4       => vs_shift_rm_reset_v,
        probe5       => vs_shift_axis_status
        );
  end block;

  b_ila_rom   : block
  begin
    i_ila_rom : ila_rom
      port map (
        clk          => clk_100,
        trig_out     => open,
        trig_out_ack => '1',
        probe0       => rom_data_in,
        probe1       => rom_address_full(26 downto 1),
        probe2       => rom_cen_i,
        probe3       => rom_oen_i,
        probe4       => rom_wait,
        probe5       => rom_adv_ldn_i,
        probe6       => rom_wen_i
        );
  end block;

  b_ila_icap            : block
    signal icap_csib_v  : std_logic_vector(0 downto 0);
    signal icap_rdwrb_v : std_logic_vector(0 downto 0);
    signal icap_status  : std_logic_vector(3 downto 0);
  begin
    icap_csib_v(0)  <= icap_csib;
    icap_rdwrb_v(0) <= icap_rdwrb;
    icap_status     <= icap_o(7 downto 4);

    i_ila_icap : ila_icap
      port map (
        clk          => clk_100,
        trig_out     => open,
        trig_out_ack => '1',
        probe0       => icap_i,
        probe1       => icap_status,
        probe2       => icap_csib_v,
        probe3       => icap_rdwrb_v
        );
  end block;


  b_ila_axi_mem                : block
    signal m_axi_mem_arvalid_v : std_logic_vector(0 downto 0);
    signal m_axi_mem_arready_v : std_logic_vector(0 downto 0);
    signal m_axi_mem_rlast_v   : std_logic_vector(0 downto 0);
    signal m_axi_mem_rvalid_v  : std_logic_vector(0 downto 0);
    signal m_axi_mem_rready_v  : std_logic_vector(0 downto 0);
  begin
    m_axi_mem_arvalid_v(0) <= m_axi_mem_arvalid;
    m_axi_mem_arready_v(0) <= m_axi_mem_arready;
    m_axi_mem_rlast_v(0)   <= m_axi_mem_rlast;
    m_axi_mem_rvalid_v(0)  <= m_axi_mem_rvalid;
    m_axi_mem_rready_v(0)  <= m_axi_mem_rready;

    i_ila_axi_mem : ila_axi_mem
      port map (
        clk     => clk_100,
        probe0  => m_axi_mem_araddr,
        probe1  => m_axi_mem_arlen,
        probe2  => m_axi_mem_arsize,
        probe3  => m_axi_mem_arburst,
        probe4  => m_axi_mem_arprot,
        probe5  => m_axi_mem_arcache,
        probe6  => m_axi_mem_aruser,
        probe7  => m_axi_mem_arvalid_v,
        probe8  => m_axi_mem_arready_v,
        probe9  => m_axi_mem_rdata,
        probe10 => m_axi_mem_rresp,
        probe11 => m_axi_mem_rlast_v,
        probe12 => m_axi_mem_rvalid_v,
        probe13 => m_axi_mem_rready_v );
  end block;


  b_ila_axi_reg            : block
    signal m_axi_awvalid_v : std_logic_vector(0 downto 0);
    signal m_axi_awready_v : std_logic_vector(0 downto 0);
    signal m_axi_wvalid_v  : std_logic_vector(0 downto 0);
    signal m_axi_wready_v  : std_logic_vector(0 downto 0);
    signal m_axi_bvalid_v  : std_logic_vector(0 downto 0);
    signal m_axi_bready_v  : std_logic_vector(0 downto 0);
    signal m_axi_arvalid_v : std_logic_vector(0 downto 0);
    signal m_axi_arready_v : std_logic_vector(0 downto 0);
    signal m_axi_rvalid_v  : std_logic_vector(0 downto 0);
    signal m_axi_rready_v  : std_logic_vector(0 downto 0);
  begin
    m_axi_awvalid_v(0) <= m_axi_awvalid;
    m_axi_awready_v(0) <= m_axi_awready;
    m_axi_wvalid_v(0)  <= m_axi_wvalid;
    m_axi_wready_v(0)  <= m_axi_wready;
    m_axi_bvalid_v(0)  <= m_axi_bvalid;
    m_axi_bready_v(0)  <= m_axi_bready;
    m_axi_arvalid_v(0) <= m_axi_arvalid;
    m_axi_arready_v(0) <= m_axi_arready;
    m_axi_rvalid_v(0)  <= m_axi_rvalid;
    m_axi_rready_v(0)  <= m_axi_rready;



    i_ila_axi_reg : ila_axi_reg
      port map (
        clk     => clk_100,
        probe0  => m_axi_awaddr,
        probe1  => m_axi_awvalid_v,
        probe2  => m_axi_awready_v,
        probe3  => m_axi_wdata,
        probe4  => m_axi_wvalid_v,
        probe5  => m_axi_wready_v,
        probe6  => m_axi_bresp,
        probe7  => m_axi_bvalid_v,
        probe8  => m_axi_bready_v,
        probe9  => m_axi_araddr,
        probe10 => m_axi_arvalid_v,
        probe11 => m_axi_arready_v,
        probe12 => m_axi_rdata,
        probe13 => m_axi_rresp,
        probe14 => m_axi_rvalid_v,
        probe15 => m_axi_rready_v
        );
  end block;



  -- -------------------------------------------------------------------------
  -- Misc
  -- -------------------------------------------------------------------------
  -- This counter provides an address for the shift Virtual Socket where it is used to address a BRAM
  p_count : process (clk_100)
  begin
    if rising_edge(clk_100) then
      if rst = '1' then
        count_value <= (others => '0');
      else
        count_value <= std_logic_vector(unsigned(count_value) + 1);
      end if;
    end if;
  end process;

  -- Instantiate the External Memory Controller
  i_emc : axi_emc_inst
    port map (
      s_axi_aclk    => clk_100,
      s_axi_aresetn => por_rst_n,
      rdclk         => clk_100,

      s_axi_mem_awid    => std_logic_vector(TO_UNSIGNED(0, 1)),
      s_axi_mem_awaddr  => (others => '0'),
      s_axi_mem_awlen   => (others => '0'),
      s_axi_mem_awsize  => (others => '0'),
      s_axi_mem_awburst => (others => '0'),
      s_axi_mem_awlock  => '0',
      s_axi_mem_awcache => (others => '0'),
      s_axi_mem_awprot  => (others => '0'),
      s_axi_mem_awvalid => '0',
      s_axi_mem_awready => open,
      s_axi_mem_wdata   => (others => '0'),
      s_axi_mem_wstrb   => (others => '0'),
      s_axi_mem_wlast   => '0',
      s_axi_mem_wvalid  => '0',
      s_axi_mem_wready  => open,
      s_axi_mem_bresp   => open,
      s_axi_mem_bvalid  => open,
      s_axi_mem_bready  => '0',
      s_axi_mem_arid    => std_logic_vector(TO_UNSIGNED(0, 1)),
      s_axi_mem_araddr  => m_axi_mem_araddr,
      s_axi_mem_arlen   => m_axi_mem_arlen,
      s_axi_mem_arsize  => m_axi_mem_arsize,
      s_axi_mem_arburst => m_axi_mem_arburst,
      s_axi_mem_arlock  => '1',
      s_axi_mem_arcache => m_axi_mem_arcache,
      s_axi_mem_arprot  => m_axi_mem_arprot,
      s_axi_mem_arvalid => m_axi_mem_arvalid,
      s_axi_mem_arready => m_axi_mem_arready,
      s_axi_mem_rdata   => m_axi_mem_rdata,
      s_axi_mem_rresp   => m_axi_mem_rresp_original,
      s_axi_mem_rlast   => m_axi_mem_rlast,
      s_axi_mem_rvalid  => m_axi_mem_rvalid,
      s_axi_mem_rready  => m_axi_mem_rready,

      mem_dq_i    => rom_data_in,
      mem_dq_o    => open,
      mem_dq_t    => open,
      mem_a       => rom_address_full,  -- Hardwired to 32 so I need to extend this 26 bit signal
      mem_ce      => open,
      mem_cen     => rom_cen_i,
      mem_oen     => rom_oen_i,
      mem_wen     => rom_wen_i(0),
      mem_ben     => open,
      mem_qwen    => open,
      mem_rpn     => open,
      mem_adv_ldn => rom_adv_ldn_i(0),
      mem_lbon    => open,
      mem_cken    => open,
      mem_rnw     => open,
      mem_cre     => open,
      mem_wait    => rom_wait

      );

  rom_address <= rom_address_full(26 downto 1);
  rom_cen     <= rom_cen_i;
  rom_oen     <= rom_oen_i;
  rom_adv_ldn <= rom_adv_ldn_i(0);
  rom_wen     <= rom_wen_i(0);


  blk_fetch_errors          : block
    signal bad_address_seen : std_logic := '0';
  begin
    process (clk_100)
    begin
      if rising_edge(clk_100) then

        if m_axi_mem_araddr > "00000011111111111111111111111111" and m_axi_mem_arvalid = '1' and m_axi_mem_arready = '1' then
          bad_address_seen <= '1';
        elsif m_axi_mem_rresp = "10" and m_axi_mem_rvalid = '1' and m_axi_mem_rready = '1' then
          bad_address_seen <= '0';
        end if;
      end if;
    end process;

    m_axi_mem_rresp <= "10" when bad_address_seen = '1' else
                       m_axi_mem_rresp_original;
  end block;


  -- -------------------------------------------------------------------------
  -- Board Connections
  -- -------------------------------------------------------------------------

  -- Debounce buttons
  -- ----------------
  i_gpio_sw_n_dbnc : entity work.debouncer
    generic map(
      C_WIDTH           => DEBOUNCE_SIZE
      )
    port map(
      clk               => clk_100,
      input_to_debounce => GPIO_SW_N,
      debounced_signal  => gpio_sw_n_dbnc
      );
  i_gpio_sw_s_dbnc : entity work.debouncer
    generic map(
      C_WIDTH           => DEBOUNCE_SIZE
      )
    port map(
      clk               => clk_100,
      input_to_debounce => GPIO_SW_S,
      debounced_signal  => gpio_sw_s_dbnc
      );

  i_gpio_sw_e_dbnc : entity work.debouncer
    generic map(
      C_WIDTH           => DEBOUNCE_SIZE
      )
    port map(
      clk               => clk_100,
      input_to_debounce => GPIO_SW_E,
      debounced_signal  => gpio_sw_e_dbnc
      );
  i_gpio_sw_w_dbnc : entity work.debouncer
    generic map(
      C_WIDTH           => DEBOUNCE_SIZE
      )
    port map(
      clk               => clk_100,
      input_to_debounce => GPIO_SW_W,
      debounced_signal  => gpio_sw_w_dbnc
      );
  i_gpio_sw_c_dbnc : entity work.debouncer
    generic map(
      C_WIDTH           => DEBOUNCE_SIZE
      )
    port map(
      clk               => clk_100,
      input_to_debounce => GPIO_SW_C,
      debounced_signal  => gpio_sw_c_dbnc
      );

end rtl;

