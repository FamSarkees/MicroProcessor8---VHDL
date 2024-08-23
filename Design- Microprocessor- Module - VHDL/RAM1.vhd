library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity RAM1 is
    Port (    
              i_RW           : in   STD_LOGIC;  -- Active Low
			     clk            : in   STD_LOGIC;  -- Active Low
              rst            : in   STD_LOGIC;  -- Active Low
           o_RAM1ADDR        : in   STD_LOGIC_VECTOR  (1 downto 0);
           o_OPERATION       : out  STD_LOGIC_VECTOR  (1 downto 0));
end RAM1;

architecture Behavioral of RAM1 is
type RAM_TYPE is array (0 to 3) of STD_LOGIC_VECTOR (1 downto 0);
signal RAM_MEM1 : RAM_TYPE := ("00","01","10","11");
signal RAM_OUT  : STD_LOGIC_VECTOR (1 downto 0);
signal RAM_OUT2  : STD_LOGIC_VECTOR (1 downto 0);
begin
process (clk,o_RAM1ADDR)
begin
   if (rising_edge(clk)) then
         if (i_RW = '0') then
			   RAM_OUT <= RAM_OUT;
			else
            RAM_OUT <= RAM_MEM1(to_integer(unsigned(o_RAM1ADDR)));
			end if;
   end if;
end process;
process(rst,RAM_OUT)
begin

		if (rst = '1') then
			RAM_OUT <= "ZZ";
		else
							RAM_OUT2 <= RAM_OUT;
		end if;

end process;
o_OPERATION <= RAM_OUT2;
end Behavioral;

