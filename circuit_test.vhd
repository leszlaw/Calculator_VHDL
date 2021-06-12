LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY circuit_circuit_sch_tb IS
END circuit_circuit_sch_tb;
ARCHITECTURE behavioral OF circuit_circuit_sch_tb IS 

   COMPONENT circuit
   PORT( Clk_Sys	:	IN	STD_LOGIC; 
          PS2_Data	:	IN	STD_LOGIC; 
          PS2_Clk	:	IN	STD_LOGIC; 
          Result	:	OUT	STD_LOGIC_VECTOR (15 DOWNTO 0));
   END COMPONENT;

   SIGNAL Clk_Sys	:	STD_LOGIC := '0';
   SIGNAL PS2_Data	:	STD_LOGIC := '1';
   SIGNAL PS2_Clk	:	STD_LOGIC :='1';
   SIGNAL Result	:	STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN

   UUT: circuit PORT MAP(
		Clk_Sys => Clk_Sys, 
		PS2_Data => PS2_Data, 
		PS2_Clk => PS2_Clk, 
		Result => Result
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
		TransmPS2( X"36" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"36" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"1C" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"3D" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"1B" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"36" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"36" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"1B" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"2E" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"46" );
		wait for 200 us;
		TransmPS2( X"F0" );
		wait for 200 us;
		TransmPS2( X"1B" );
		
		wait; -- will wait forever
	END PROCESS;

END;
