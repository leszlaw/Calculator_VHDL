LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY calculator_test IS
END calculator_test;
 
ARCHITECTURE behavior OF calculator_test IS 
 
 
    COMPONENT calculator
    PORT(
         DI : IN  std_logic_vector(7 downto 0);
         F0 : IN  std_logic;
         DI_Rdy : IN  std_logic;
         Clk_Sys : IN  std_logic;
         Result : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal DI : std_logic_vector(7 downto 0) := (others => '0');
   signal F0 : std_logic := '0';
   signal DI_Rdy : std_logic := '0';
   signal Clk_Sys : std_logic := '0';

 	--Outputs
   signal Result : std_logic_vector(15 downto 0);
 
BEGIN
 
   uut: calculator PORT MAP (
          DI => DI,
          F0 => F0,
          DI_Rdy => DI_Rdy,
          Clk_Sys => Clk_Sys,
          Result => Result
        );

	Clk_Sys <= not Clk_Sys after 10 ns;
	
	F0 <= '0';
	F0 <= '1';

END;