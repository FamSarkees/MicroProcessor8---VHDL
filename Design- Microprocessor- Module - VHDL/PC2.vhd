library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity PC2 is
    Port ( i_PCEN2 : in  STD_LOGIC;
			  clk,rst: in std_logic;
           o_RAM2ADDR : out  STD_LOGIC_vector(2 downto 0)
			  );
end PC2;

architecture Behavioral of PC2 is

signal COUNTER_PC2: std_logic_vector(2 downto 0);

begin
process(i_PCEN2,rst,clk)
begin

		
	if(rst='1')then
	COUNTER_PC2 <= "000";
	else if(rising_edge (clk))then
	if(i_PCEN2='1')then
				COUNTER_PC2 <= std_logic_vector(unsigned(COUNTER_PC2) + 1);   -- increment
	end if;
	end if;
	end if;
end process;
				o_RAM2ADDR<=COUNTER_PC2; 
end Behavioral;

