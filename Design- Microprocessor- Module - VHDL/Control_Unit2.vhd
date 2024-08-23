
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;


ENTITY Control_Unit IS  Port (    
				  o_OPNUM         : in   	STD_LOGIC_VECTOR (1 downto 0);  -- Active Low
			  	  clk             : in   	STD_LOGIC;  -- Active Low
              rst             : in   	STD_LOGIC;  -- Active Low
              i_ACCEN      		: out 	STD_LOGIC;
              i_DECEN      	  : out  	STD_LOGIC;
              i_RW            : out   STD_LOGIC;  -- Active Low
              i_RW2           : out   STD_LOGIC;  -- Active Low
              i_PCEN1         : out   STD_LOGIC;  -- Active Low
              i_PCEN2         : out   STD_LOGIC   -- Active Low
            );

END Control_Unit;
 
ARCHITECTURE behavior OF Control_Unit IS 
 
TYPE State_type IS (IDLE, FETCHM1, DECODE, FETCHM2, EXECUTE);  -- Define the states
	SIGNAL State,Next_State : State_Type;    -- Create a signal that uses 
							      -- the different states
BEGIN 
  PROCESS (clk, rst) 
  BEGIN 
    If (rst = '1') THEN            -- Upon reset, set the state to A
						State <= IDLE;
    ELSIF rising_edge(clk) THEN    -- if there is a rising edge of the
			 -- clock, then do the stuff below
 					State <= Next_State;

		END IF; 
END PROCESS;

process (next_state,o_OPNUM)
begin
  case next_state is
     when IDLE		 =>        --when current state is "A"
     										next_state <= FETCHM1;
     										i_ACCEN    <= '0';
              					i_DECEN    <= '0';
					              i_RW       <= '0';
					              i_RW2      <= '0';
					              i_PCEN1    <= '0';
					              i_PCEN2    <= '0';

     when FETCHM1	 =>        --when current state is "B"
     										next_state <= DECODE;
     										i_ACCEN    <= '0';
              					i_DECEN    <= '1';
					              i_RW       <= '0';
					              i_RW2      <= '0';
					              i_PCEN1    <= '0';
					              i_PCEN2    <= '0';
    when DECODE 	=>       --when current state is "C"

												if(o_OPNUM ="10" or o_OPNUM ="01" ) then
     										next_state <= FETCHM2;
     										i_ACCEN    <= '1';
              					i_DECEN    <= '1';
					              i_RW       <= '0';
					              i_RW2      <= '0';
					              i_PCEN1    <= '0';
					              i_PCEN2    <= '1';
												else
     										next_state <= EXECUTE;
     										i_ACCEN    <= '0';
              					i_DECEN    <= '1';
					              i_RW       <= '0';
					              i_RW2      <= '0';
					              i_PCEN1    <= '0';
					              i_PCEN2    <= '0';
												    end if;
  	when FETCHM2 	=>         --when current state is "D"
												if(o_OPNUM ="10") then
     										next_state <= FETCHM2;
     										i_ACCEN    <= '0';
              					i_DECEN    <= '1';
					              i_RW       <= '0';
					              i_RW2      <= '0';
					              i_PCEN1    <= '0';
					              i_PCEN2    <= '1';
												else
     										next_state <= EXECUTE;
     										i_ACCEN    <= '0';
              					i_DECEN    <= '1';
					              i_RW       <= '0';
					              i_RW2      <= '0';
					              i_PCEN1    <= '0';
					              i_PCEN2    <= '0';
					               end if;
	  when EXECUTE	=>         --when current state is "D"
     										next_state <= FETCHM1;
     										i_ACCEN    <= '0';
              					i_DECEN    <= '1';
					              i_RW       <= '0';
					              i_RW2      <= '1';
					              i_PCEN1    <= '1';
					              i_PCEN2    <= '1';
  end case;
end process;



END behavior;