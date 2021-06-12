library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ps2_kbd is
    Port ( PS2_Clk : in  STD_LOGIC;
           PS2_Data : in  STD_LOGIC;
           Clk_Sys : in  STD_LOGIC;
           DO : out  STD_LOGIC_VECTOR (7 downto 0);
           E0 : out  STD_LOGIC;
           F0 : out  STD_LOGIC;
           Do_Rdy : out  STD_LOGIC);
end ps2_kbd;

architecture Behavioral of ps2_kbd is

type states is (recieve ,set_F0,set_E0, send, reset);
signal state, next_state : states;

signal DO_rx : STD_LOGIC_VECTOR(7 downto 0);
signal DO_Rdy_rx : STD_LOGIC;
signal DO_Rdy_reg : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal F0_flag : STD_LOGIC := '0';
signal E0_flag : STD_LOGIC := '0';

signal DO_kbd : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal F0_kbd : STD_LOGIC := '0';
signal E0_kbd : STD_LOGIC := '0';

component ps2_rx
   port(
         PS2_Clk : in  STD_LOGIC;
         PS2_Data : in  STD_LOGIC;
         Clk_Sys : in  STD_LOGIC;
         DO : out  STD_LOGIC_VECTOR(7 downto 0);
         DO_Rdy : out STD_LOGIC
       );
end component;

begin

   c1: ps2_rx PORT MAP (
          PS2_Clk => PS2_Clk,
          PS2_Data => PS2_Data,
          Clk_Sys => Clk_Sys,
          DO => DO_rx,
          DO_Rdy => DO_Rdy_rx
        );
		  
	process(Clk_Sys)
	begin
		if rising_edge(Clk_Sys) then 
			DO_Rdy_reg(0) <= DO_Rdy_rx;
			DO_Rdy_reg(1) <= DO_Rdy_reg(0);
		end if;
	end process;

	process(Clk_Sys)
	begin
		if(rising_edge(Clk_Sys)) then
			state <= next_state;
		end if;
	end process;
	
	process(Clk_Sys)
	begin
	if rising_edge(Clk_Sys) then
	case state is 
			
				when recieve =>
			
				when set_F0 =>
					F0_flag <= '1';
		
				when set_E0 =>
					E0_flag <= '1';
		
				when send=>
					DO_kbd <= DO_rx(0) & DO_rx(1) & DO_rx(2) & DO_rx(3) & DO_rx(4) & DO_rx(5) & DO_rx(6) & DO_rx(7);
					F0_kbd <= F0_flag;
					E0_kbd <= E0_flag;

				when reset=>
					F0_flag <= '0';
					E0_flag <= '0';
			
			end case;
	end if;
	end process;

	process(Clk_Sys, state, DO_rx, DO_Rdy_rx, DO_Rdy_reg)
	begin

		next_state <= state;
   
		case state is
		
		when recieve =>
		if DO_Rdy_reg(0) = '1' and DO_Rdy_reg(1) = '0' then
			if DO_rx = "00001111" then
				next_state <= set_F0;
			elsif DO_rx = "00000111" then
				next_state <= set_E0;
			else
				next_state <= send;
			end if;
		end if;	
		
		when set_F0 =>
			next_state <= recieve;
		
		when set_E0 =>
			next_state <= recieve;
		
		when send=>
			next_state <= reset;

		when reset=>
			next_state <= recieve;
		
		end case;

	end process;
	
	DO <= DO_kbd;
	F0 <= F0_kbd;
	E0 <= E0_kbd;
	DO_Rdy <= '1' when state = reset
	else '0';

end Behavioral;

