
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;


ENTITY STAGE1TEST IS
   port ( clk     : in    std_logic; 
          rst     : in    std_logic
		  );
END STAGE1TEST;
 
ARCHITECTURE behavior OF STAGE1TEST IS 

	signal i_ACCEN : std_logic;
	signal i_DECEN : std_logic;
	signal i_RW : std_logic;
	signal i_RW2 : std_logic;
	signal i_PCEN1 : std_logic;
	signal i_PCEN2 : std_logic;
   signal o_RAM1ADDR       : std_logic_vector(1 downto 0) := (others => '0');
	signal o_OPNUM          : std_logic_vector(1 downto 0) := (others => '0');
   signal o_ALUEN          : std_logic_vector(1 downto 0) := (others => '0');
   signal o_RAM2ADDR       : std_logic_vector(2 downto 0) := (others => '0');
   signal o_OPERATION      : std_logic_vector(1 downto 0) := (others => '0');
   signal i_ACCOP          : std_logic_vector(7 downto 0) := (others => '0');
   signal i_ACCOP1         : std_logic_vector(7 downto 0) := (others => '0');
   signal ALU_RES          : std_logic_vector(7 downto 0) := (others => '0');



COMPONENT PC1 is
    Port ( i_PCEN1	 : in  STD_LOGIC;
			  clk,rst	 : in  std_logic;
           o_RAM1ADDR : out STD_LOGIC_vector(1 downto 0)
			  );
end COMPONENT;


COMPONENT Control_Unit is 
     port(    
				  o_OPNUM         : in   	STD_LOGIC_VECTOR (1 downto 0);  -- Active Low
			  	  clk             : in   	STD_LOGIC;  -- Active Low
              rst             : in   	STD_LOGIC;  -- Active Low
              i_ACCEN         : out 	STD_LOGIC;
              i_DECEN      	: out  	STD_LOGIC;
              i_RW            : out   STD_LOGIC;  -- Active Low
              i_RW2           : out   STD_LOGIC;  -- Active Low
              i_PCEN1         : out   STD_LOGIC;  -- Active Low
              i_PCEN2         : out   STD_LOGIC   -- Active Low
            );
end COMPONENT;



COMPONENT PC2 is
    Port ( i_PCEN2	 : in   STD_LOGIC;
			  clk,rst    : in   std_logic;
           o_RAM2ADDR : out  STD_LOGIC_vector(2 downto 0)
			  );
end COMPONENT;

COMPONENT RAM1 is
    Port ( 
           i_RW	           : in   STD_LOGIC;  -- Active Low
			  clk 	           : in   STD_LOGIC;  -- Active Low
           rst 	           : in   STD_LOGIC;  -- Active Low
           o_RAM1ADDR        : in   STD_LOGIC_VECTOR  (1 downto 0);
           o_OPERATION       : out  STD_LOGIC_VECTOR  (1 downto 0));
end COMPONENT;

 
COMPONENT RAM2 is
    Port ( 
           i_RW2           : in   STD_LOGIC;  -- Active Low
			  clk             : in   STD_LOGIC;  -- Active Low
           rst             : in   STD_LOGIC;  -- Active Low
           o_RAM2ADDR      : in   STD_LOGIC_VECTOR  (2 downto 0);
           ALU_RES         : in   STD_LOGIC_VECTOR  (7 downto 0);
           i_ACCOP         : out  STD_LOGIC_VECTOR  (7 downto 0));
end COMPONENT;


COMPONENT ALU is
    Port (
           i_ACCOP1   : in  STD_LOGIC_VECTOR (7 downto 0);
           i_ACCOP2   : in  STD_LOGIC_VECTOR (7 downto 0);
           o_ALUEN	 : in  STD_LOGIC_VECTOR (1 downto 0);
           o_ALURES   : out STD_LOGIC_VECTOR (7 downto 0)
        );
end COMPONENT;

COMPONENT DECODER is
    Port (
           o_OPERATION  : in  STD_LOGIC_VECTOR (1 downto 0);
           i_DECEN 		: in  STD_LOGIC ;
           o_ALUEN		: out STD_LOGIC_VECTOR (1 downto 0);
           o_OPNUM 		: out STD_LOGIC_VECTOR (1 downto 0)
        );
end COMPONENT;    

COMPONENT ACC is
    Port ( i_ACCEN 	: in  STD_LOGIC;
			  clk 		: in  STD_LOGIC;
           i_ACCOP1	: in  STD_LOGIC_vector( 7 downto 0);
           o_ACCOP2 	: out  STD_LOGIC_vector( 7 downto 0)
			  );
end COMPONENT;

BEGIN
  
  
  cu_test : Control_Unit PORT MAP (    
				  o_OPNUM         => o_OPNUM,
			  	  clk             => clk,
              rst             => rst,
              i_ACCEN         => i_ACCEN,
              i_DECEN      	=> i_DECEN,
              i_RW            => i_RW,
              i_RW2           => i_RW2,
              i_PCEN1         => i_PCEN1,
              i_PCEN2         => i_PCEN2
            );

	PC1_test: PC1 PORT MAP ( 	
				i_PCEN1   => i_PCEN1,
                  clk => clk,
                  rst => rst,
           o_RAM1ADDR => o_RAM1ADDR
			  );


	PC2_test: PC2 PORT MAP( 	
				i_PCEN2	 => i_PCEN2,
                  clk => clk,
                  rst => rst,
           o_RAM2ADDR => o_RAM2ADDR
			  );

 
   RAM1_test: RAM1 PORT MAP (
                 i_RW => i_RW,
                  clk => clk,
                  rst => rst,
          o_RAM1ADDR  => o_RAM1ADDR,
          o_OPERATION => o_OPERATION
                            );

   RAM2_test: RAM2 PORT MAP (
                 i_RW2=> i_RW2,
                  clk => clk,
                  rst => rst,
          o_RAM2ADDR  => o_RAM2ADDR,
             ALU_RES  => ALU_RES,
             i_ACCOP  => i_ACCOP
                            );

   ALU_test: ALU PORT MAP (
            i_ACCOP1  => i_ACCOP1,
            i_ACCOP2  => i_ACCOP,
            o_ALUEN   => o_ALUEN,
            o_ALURES  => ALU_RES
                            );

   DECODER_test: DECODER PORT MAP (
           o_OPERATION => o_OPERATION,
           i_DECEN     => i_DECEN,
           o_ALUEN     => o_ALUEN,
           o_OPNUM     => o_OPNUM 
                            );  

   ACC_test: ACC PORT MAP (
           i_ACCEN    => i_ACCEN,
           clk        => clk,
           i_ACCOP1   => i_ACCOP,
           o_ACCOP2   => i_ACCOP1
                           );                                                           

END;