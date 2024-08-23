--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : topm.vhf
-- /___/   /\     Timestamp : 03/26/2024 11:46:52
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl C:/Users/user/Downloads/Microprocessor/Microprocessor/topm.vhf -w C:/Users/user/Downloads/Microprocessor/Microprocessor/topm.sch
--Design Name: topm
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity topm is
   port ( clk     : in    std_logic; 
          i_ACCEN : in    std_logic; 
          i_DECEN : in    std_logic; 
          i_PCEN1 : in    std_logic; 
          i_PCEN2 : in    std_logic; 
          i_RW    : in    std_logic; 
          i_RW2   : in    std_logic; 
          rst     : in    std_logic;
          o_OPNUM : out   std_logic_vector (1 downto 0)
		  );
end topm;

architecture BEHAVIORAL of topm is
   signal XLXN_16 : std_logic_vector (1 downto 0);
   signal XLXN_34 : std_logic_vector (1 downto 0);
   signal XLXN_48 : std_logic_vector (7 downto 0);
   signal XLXN_62 : std_logic_vector (2 downto 0);
   signal XLXN_63 : std_logic_vector (7 downto 0);
   signal XLXN_67 : std_logic_vector (7 downto 0);
   signal XLXN_91 : std_logic_vector (1 downto 0);
   component ACC
      port ( i_ACCEN  : in    std_logic; 
             clk      : in    std_logic; 
             i_ACCOP1 : in    std_logic_vector (7 downto 0); 
             o_ACCOP2 : out   std_logic_vector (7 downto 0));
   end component;
   
   component ALU
      port ( i_ACCOP1 : in    std_logic_vector (7 downto 0); 
             i_ACCOP2 : in    std_logic_vector (7 downto 0); 
             o_ALUEN  : in    std_logic_vector (1 downto 0); 
             o_ALURES : out   std_logic_vector (7 downto 0));
   end component;
   
   component DECODER
      port ( i_DECEN     : in    std_logic; 
             o_OPERATION : in    std_logic_vector (1 downto 0); 
             o_ALUEN     : out   std_logic_vector (1 downto 0); 
             o_OPNUM     : out   std_logic_vector (1 downto 0));
   end component;
   
   component PC1
      port ( i_PCEN1    : in    std_logic; 
             o_RAM1ADDR : out   std_logic_vector (1 downto 0); 
             clk        : in    std_logic; 
             rst        : in    std_logic);
   end component;
   
   component PC2
      port ( i_PCEN2    : in    std_logic; 
             clk        : in    std_logic; 
             rst        : in    std_logic; 
             o_RAM2ADDR : out   std_logic_vector (2 downto 0));
   end component;
   
   component RAM2
      port ( i_RW2      : in    std_logic; 
             clk        : in    std_logic; 
             rst        : in    std_logic; 
             o_RAM2ADDR : in    std_logic_vector (2 downto 0); 
             ALU_RES    : in    std_logic_vector (7 downto 0); 
             i_ACCOP    : out   std_logic_vector (7 downto 0));
   end component;
   
   component RAM1
      port ( i_RW        : in    std_logic; 
             clk         : in    std_logic; 
             rst         : in    std_logic; 
             o_RAM1ADDR  : in    std_logic_vector (1 downto 0); 
             o_OPERATION : out   std_logic_vector (1 downto 0));
   end component;
   
begin
   XLXI_1 : ACC
      port map (clk=>clk,
                i_ACCEN=>i_ACCEN,
                i_ACCOP1(7 downto 0)=>XLXN_67(7 downto 0),
                o_ACCOP2(7 downto 0)=>XLXN_48(7 downto 0));
   
   XLXI_2 : ALU
      port map (i_ACCOP1(7 downto 0)=>XLXN_48(7 downto 0),
                i_ACCOP2(7 downto 0)=>XLXN_67(7 downto 0),
                o_ALUEN(1 downto 0)=>XLXN_91(1 downto 0),
                o_ALURES(7 downto 0)=>XLXN_63(7 downto 0));
   
   XLXI_3 : DECODER
      port map (i_DECEN=>i_DECEN,
                o_OPERATION(1 downto 0)=>XLXN_34(1 downto 0),
                o_ALUEN(1 downto 0)=>XLXN_91(1 downto 0),
                o_OPNUM(1 downto 0)=>o_OPNUM(1 downto 0));
   
   XLXI_4 : PC1
      port map (clk=>clk,
                i_PCEN1=>i_PCEN1,
                rst=>rst,
                o_RAM1ADDR(1 downto 0)=>XLXN_16(1 downto 0));
   
   XLXI_5 : PC2
      port map (clk=>clk,
                i_PCEN2=>i_PCEN2,
                rst=>rst,
                o_RAM2ADDR(2 downto 0)=>XLXN_62(2 downto 0));
   
   XLXI_7 : RAM2
      port map (ALU_RES(7 downto 0)=>XLXN_63(7 downto 0),
                clk=>clk,
                i_RW2=>i_RW2,
                o_RAM2ADDR(2 downto 0)=>XLXN_62(2 downto 0),
                rst=>rst,
                i_ACCOP(7 downto 0)=>XLXN_67(7 downto 0));
   
   XLXI_8 : RAM1
      port map (clk=>clk,
                i_RW=>i_RW,
                o_RAM1ADDR(1 downto 0)=>XLXN_16(1 downto 0),
                rst=>rst,
                o_OPERATION(1 downto 0)=>XLXN_34(1 downto 0));
   
end BEHAVIORAL;


