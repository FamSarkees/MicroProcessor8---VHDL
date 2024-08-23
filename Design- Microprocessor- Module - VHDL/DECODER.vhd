library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DECODER is
    Port (
           o_OPERATION  : in  STD_LOGIC_VECTOR (1 downto 0);
           i_DECEN 		: in  STD_LOGIC ;
           o_ALUEN		: out STD_LOGIC_VECTOR (1 downto 0);
           o_OPNUM 		: out STD_LOGIC_VECTOR (1 downto 0)
        );
end DECODER;

architecture Behavioral of DECODER is
begin
    process(o_OPERATION, i_DECEN)
    begin
		if 	i_DECEN	= '1' then
			case (o_OPERATION) is
				when "00" => 
					o_ALUEN  <= "00";
					o_OPNUM  <= "10";
				when "01" => 
					o_ALUEN  <= "01";
					o_OPNUM  <= "01";
				when others =>
					o_ALUEN  <= "11";
					o_OPNUM  <= "00";
			end case;
			else
				o_ALUEN  <= "11";
				o_OPNUM  <= "00";
		end if;
    end process;
end Behavioral;