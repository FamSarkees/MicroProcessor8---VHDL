library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity RAM2 is
    Port (   -- i_RD2           : in   STD_LOGIC;  -- Active Low
              i_RW2           : in   STD_LOGIC;  -- Active Low
				  clk             : in   STD_LOGIC;  -- Active Low
              rst             : in   STD_LOGIC;  -- Active Low
           o_RAM2ADDR         : in   STD_LOGIC_VECTOR  (2 downto 0);
            ALU_RES           : in   STD_LOGIC_VECTOR  (7 downto 0);
            i_ACCOP           : out  STD_LOGIC_VECTOR  (7 downto 0));
end RAM2;

architecture Behavioral of RAM2 is
type RAM_TYPE is array (0 to 7) of STD_LOGIC_VECTOR (7 downto 0);
signal RAM_MEM2 : RAM_TYPE := ("00000000","00000001","00000010","00000011","00000100","00000101","00000110","00000111");
signal RAM_OUT,RAM_OUT2  : STD_LOGIC_VECTOR (7 downto 0);
begin
process (clk,i_RW2,o_RAM2ADDR,ALU_RES)
begin
   if (rising_edge(clk)) then
       
         if (i_RW2 = '0') then
			RAM_MEM2(2) <= ALU_RES;
         
         end if;
            RAM_OUT <= RAM_MEM2(to_integer(unsigned(o_RAM2ADDR)));
     
   end if;
end process;
process(rst,RAM_OUT)
begin

		if (rst = '1') then
			RAM_OUT <= "ZZZZZZZZ";
		else
							RAM_OUT2 <= RAM_OUT;
		end if;

end process;
i_ACCOP <= RAM_OUT2;
end Behavioral;
