library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ps2_rx is
    Port ( PS2_Clk : in  STD_LOGIC;
           PS2_Data : in  STD_LOGIC;
           Clk_Sys : in  STD_LOGIC;
           DO : out  STD_LOGIC_VECTOR (7 downto 0);
           DO_Rdy : out  STD_LOGIC);
end ps2_rx;

architecture Behavioral of ps2_rx is
signal clk_reg : STD_LOGIC_VECTOR(1 downto 0) := "11";
signal data_reg : STD_LOGIC_VECTOR(10 downto 0) := "11111111111";
signal parity_check : STD_LOGIC;
type states is (waiting, reset,receive, test, send);
signal state, next_state : states;
begin

process(Clk_Sys)
begin
   if rising_edge(Clk_Sys) then 
      clk_reg(0) <= PS2_Clk;
		clk_reg(1) <= clk_reg(0);
    end if;
end process;

process(Clk_Sys)
begin
   if rising_edge(Clk_Sys) then
		if state = reset then
			data_reg <= "11111111111";
		elsif clk_reg(0) = '1' and clk_reg(1) = '0' then
      data_reg(0) <= PS2_Data;
		data_reg(10 downto 1) <= data_reg(9 downto 0);
		end if;
    end if;
end process;

process(Clk_Sys)
begin
   if(rising_edge(Clk_Sys)) then
      state <= next_state;
   end if;
end process;

parity_check <= not(data_reg(8) xor data_reg(7) xor data_reg(6) 
                  xor data_reg(5) xor data_reg(4) xor data_reg(3) 
                    xor data_reg(2) xor data_reg(1));

process(Clk_Sys, state, data_reg, parity_check, clk_reg)
begin

next_state <= state;
   
case state is

when waiting =>
	if clk_reg(0) = '0' and clk_reg(1) = '1' then
		next_state <= reset;
	end if;
	
when reset =>
	next_state <= receive;

when receive =>
	if data_reg(10) = '0' and data_reg(0) = '1' then
		next_state <= test;
	end if;

when test =>
	if data_reg(9) = parity_check then
		next_state <= send;
	else
		next_state <= waiting;
	end if;

when send =>
	next_state <= waiting;
end case;

end process;

DO_Rdy <= '1' when state = send
   else '0';

DO <= data_reg(9 downto 2);

end Behavioral;

