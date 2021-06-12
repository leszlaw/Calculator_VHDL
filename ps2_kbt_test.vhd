LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY ps2_kbt_test IS
END ps2_kbt_test;
 
ARCHITECTURE behavior OF ps2_kbt_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ps2_kbd
    PORT(
         PS2_Clk : IN  std_logic;
         PS2_Data : IN  std_logic;
         Clk_Sys : IN  std_logic;
         DO : OUT  std_logic_vector(7 downto 0);
         E0 : OUT  std_logic;
         F0 : OUT  std_logic;
         Do_Rdy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal PS2_Clk : std_logic := '1';
   signal PS2_Data : std_logic := '1';
   signal Clk_Sys : std_logic := '0';

 	--Outputs
   signal DO : std_logic_vector(7 downto 0);
   signal E0 : std_logic;
   signal F0 : std_logic;
   signal Do_Rdy : std_logic;

   -- Clock period definitions
   constant PS2_Clk_period : time := 10 ns;
   constant Clk_Sys_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ps2_kbd PORT MAP (
          PS2_Clk => PS2_Clk,
          PS2_Data => PS2_Data,
          Clk_Sys => Clk_Sys,
          DO => DO,
          E0 => E0,
          F0 => F0,
          Do_Rdy => Do_Rdy
        );

   -- Clock process definitions
    Clk_Sys <= not Clk_Sys after 10ns;
    PROCESS
		procedure TransmPS2( Byte : std_logic_vector( 7 downto 0 ) ) is
		  variable Frame : std_logic_vector( 10 downto 0 ) := "11" & Byte & '0';
		begin
		  -- Parity calculation
		  for i in 0 to 7 loop
			Frame( 9 ) := Frame( 9 ) xor Byte( i );
		  end loop;
		  -- Transmission of the frame; Fclk = 10kHz
		  for i in 0 to 10 loop
			PS2_Data <= Frame( i );
			wait for 5 us;
			PS2_Clk <= '0', '1' after 50 us;
			wait for 95 us;
		  end loop;
		end procedure;
	BEGIN
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"E0" );
		wait for 200 us;
		TransmPS2( X"16" );
		wait for 200 us;
		TransmPS2( X"1E" );
		wait for 200 us;
		TransmPS2( X"26" );
		wait for 200 us;
		TransmPS2( X"25" );
		wait for 200 us;
		TransmPS2( X"2E" );
		wait for 200 us;
		TransmPS2( X"36" );
		wait for 200 us;
		TransmPS2( X"3D" );
		wait for 200 us;
		TransmPS2( X"3E" );
		wait for 200 us;
		TransmPS2( X"46" );
		wait for 200 us;
		TransmPS2( X"45" );
		wait; -- will wait forever
	END PROCESS;

END;
