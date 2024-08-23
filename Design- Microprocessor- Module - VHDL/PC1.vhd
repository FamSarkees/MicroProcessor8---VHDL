library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity PC1 is
    Port ( i_PCEN1 : in  STD_LOGIC;
			  clk,rst : in std_logic;
           o_RAM1ADDR : out  STD_LOGIC_vector(1 downto 0)
			  );
end PC1;


architecture Behavioral of PC1 is

signal COUNTER_PC1: std_logic_vector(1 downto 0);

begin

process(i_PCEN1,clk,rst)
begin
   if(rst='1')then
	COUNTER_PC1 <= "00";
	else if(rising_edge (clk))then
	if(i_PCEN1='1')then
				COUNTER_PC1 <= std_logic_vector(unsigned(COUNTER_PC1) + 1);   -- increment
	end if;
	end if;
	end if;
end process;
				o_RAM1ADDR<=COUNTER_PC1; 
end Behavioral;