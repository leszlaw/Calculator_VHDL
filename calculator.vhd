library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity calculator is
    Port ( DI : in  STD_LOGIC_VECTOR (7 downto 0);
			  F0 : in  STD_LOGIC;
           DI_Rdy : in  STD_LOGIC;
           Clk_Sys : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR (15 downto 0) );
end calculator;

architecture Behavioral of calculator is
signal DI_Rdy_reg : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal current_value : STD_LOGIC_VECTOR (15 downto 0) := X"0000";
signal final_value : STD_LOGIC_VECTOR (15 downto 0) := X"0000";
signal number : STD_LOGIC_VECTOR (3 downto 0) := "1111";
type states is (waiting, input, add, sub, reset);
signal state, next_state : states;

signal carry_out0,carry_out1,carry_out2: STD_LOGIC := '0';
signal sum : STD_LOGIC_VECTOR (15 downto 0) := X"0000";

signal borrow0, borrow1, borrow2 : STD_LOGIC := '0';
signal subtract : STD_LOGIC_VECTOR (15 downto 0) := X"0000";

component adder_bcd
   port(
				A : in  unsigned(3 downto 0);
           B : in  unsigned(3 downto 0);
           CARRY_IN : in  STD_LOGIC;
           SUM : out  STD_LOGIC_VECTOR(3 downto 0);
           CARRY_OUT : out  STD_LOGIC
       );
end component;

component subtractor_bcd
   port(
				A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
			  BORROW_IN: in  STD_LOGIC;
           RESULT : out  STD_LOGIC_VECTOR (3 downto 0);
           BORROW : out  STD_LOGIC
       );
end component;

begin

-- adder
a0: adder_bcd PORT MAP(
	A => unsigned(current_value(3 downto 0)),
	B => unsigned(final_value(3 downto 0)),
	CARRY_IN => '0',
	SUM => sum(3 downto 0),
	CARRY_OUT => carry_out0
	);
	
a1: adder_bcd PORT MAP(
	A => unsigned(current_value(7 downto 4)),
	B => unsigned(final_value(7 downto 4)),
	CARRY_IN => carry_out0,
	SUM => sum(7 downto 4),
	CARRY_OUT => carry_out1
	);
	
a2: adder_bcd PORT MAP(
	A => unsigned(current_value(11 downto 8)),
	B => unsigned(final_value(11 downto 8)),
	CARRY_IN => carry_out1,
	SUM => sum(11 downto 8),
	CARRY_OUT => carry_out2
	);
	
a3: adder_bcd PORT MAP(
	A => unsigned(current_value(15 downto 12)),
	B => unsigned(final_value(15 downto 12)),
	CARRY_IN => carry_out2,
	SUM => sum(15 downto 12),
	CARRY_OUT => open
	);
	
-- subtract
s0: subtractor_bcd PORT MAP(
	A => final_value(3 downto 0),
	B => current_value(3 downto 0),
	BORROW_IN => '0',
   RESULT =>subtract(3 downto 0),
   BORROW => borrow0
	);

s1: subtractor_bcd PORT MAP(
	A => final_value(7 downto 4),
	B => current_value(7 downto 4),
	BORROW_IN => borrow0,
   RESULT =>subtract(7 downto 4),
   BORROW => borrow1
	);

s2: subtractor_bcd PORT MAP(
	A => final_value(11 downto 8),
	B => current_value(11 downto 8),
	BORROW_IN => borrow1,
   RESULT =>subtract(11 downto 8),
   BORROW => borrow2
	);

s3: subtractor_bcd PORT MAP(
	A => final_value(15 downto 12),
	B => current_value(15 downto 12),
	BORROW_IN => borrow2,
   RESULT =>subtract(15 downto 12),
	BORROW => open
	);

REG : process(Clk_Sys)
begin
   if rising_edge(Clk_Sys) then 
      DI_Rdy_reg(0) <= DI_Rdy;
		DI_Rdy_reg(1) <= DI_Rdy_reg(0);
    end if;
end process;

DECODE : process(DI)
begin
   case DI is
		when X"45" => number <= X"0";
		when X"16" => number <= X"1"; 
		when X"1E" => number <= X"2";
		when X"26" => number <= X"3";
		when X"25" => number <= X"4";
		when X"2E" => number <= X"5";
		when X"36" => number <= X"6";
		when X"3D" => number <= X"7";
		when X"3E" => number <= X"8";
		when X"46" => number <= X"9";
		when others => number <= X"F";
	end case;
end process;

SET_STATE : process(Clk_Sys)
begin
	if(rising_edge(Clk_Sys)) then
		state <= next_state;
	end if;
end process;

ACTIONS : process(Clk_Sys)
begin
if(rising_edge(Clk_Sys)) then
case state is 
			
		when waiting =>
			
		when input =>
		if number < X"A" then
			current_value(15 downto 4) <= current_value(11 downto 0);
			current_value(3 downto 0) <= number;
		end if;
			
		when add =>
		final_value <= sum;
		current_value <= X"0000";
		
		when sub =>
		if current_value <= final_value then
			final_value <= subtract;
		end if;
		current_value <= X"0000";
					
		when reset =>
		final_value <= X"0000";
		current_value <= X"0000";
			
		end case;
end if;
end process;

STATE_MACHINE :process(Clk_Sys, state, F0, DI,DI_Rdy_reg)
begin
		next_state <= state;
			
		case state is 
			
			when waiting =>
			if F0 = '1' and DI_Rdy_reg(0) = '1' and DI_Rdy_reg(1) = '0' then
			if DI = X"76" then
				next_state <= reset;
			elsif DI = X"1C" then
				next_state <= add;
			elsif DI = X"1B" then
				next_state <= sub;
			else
				next_state <= input;
			end if;
			end if;
			
			when input =>
				next_state <= waiting;
			
			when add =>
				next_state <= waiting;
				
			when sub =>
				next_state <= waiting;
					
			when reset => 
				next_state <= waiting;
			
		end case;
end process;

Result <= final_value;

end Behavioral;

