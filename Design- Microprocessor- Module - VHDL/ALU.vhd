library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ALU is
    Port (
           i_ACCOP1   : in  STD_LOGIC_VECTOR (7 downto 0);
           i_ACCOP2   : in  STD_LOGIC_VECTOR (7 downto 0);
           o_ALUEN	 : in  STD_LOGIC_VECTOR (1 downto 0);
           o_ALURES   : out STD_LOGIC_VECTOR (7 downto 0)
        );
end ALU;

architecture Behavioral of ALU is
signal ALU_Result : std_logic_vector (7 downto 0);
begin
    process(i_ACCOP2, i_ACCOP1, o_ALUEN)
    begin
        case (o_ALUEN) is
            when "00" => -- Add i_1 and i_2
                ALU_Result <= i_ACCOP1 + i_ACCOP2;
            when "01" => -- Increment i_1
                ALU_Result <= i_ACCOP1 + "00000001";
            when others =>
                ALU_Result <= "00000000";
        end case;
    end process;
	 o_ALURES <= ALU_Result;
end Behavioral;