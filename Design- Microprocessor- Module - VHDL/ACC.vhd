library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ACC is
    Port ( i_ACCEN : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           i_ACCOP1 : in  STD_LOGIC_vector( 7 downto 0);
           o_ACCOP2 : out  STD_LOGIC_vector( 7 downto 0)
			  );
end ACC;


architecture Behavioral of ACC is
begin

process(i_ACCEN,i_ACCOP1,clk)
begin

  if(rising_edge (clk))then
		if(i_ACCEN='1')then
			o_ACCOP2 <= i_ACCOP1;
			ELSE 
			o_ACCOP2 <= "00000000";
			end if;
		end if;
		
end process;
end Behavioral;

