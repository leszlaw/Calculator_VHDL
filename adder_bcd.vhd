library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity adder_bcd is
    Port ( 
				A : in  unsigned(3 downto 0) := X"0";
           B : in  unsigned(3 downto 0) := X"0";
           CARRY_IN : in  STD_LOGIC;
           SUM : out  STD_LOGIC_VECTOR(3 downto 0) := X"0";
           CARRY_OUT : out  STD_LOGIC := '0'
			);
end adder_bcd;

architecture Behavioral of adder_bcd is

begin

process(A,B,CARRY_IN)

variable sum_temp : unsigned(4 downto 0);

begin
    sum_temp := ('0' & A) + ('0' & B) + ("0000" & CARRY_IN); 
    if(sum_temp > 9) then
        CARRY_OUT <= '1';
        SUM <= std_logic_vector(resize((sum_temp + "00110"),4));
    else
        CARRY_OUT <= '0';
        SUM <= std_logic_vector(sum_temp(3 downto 0));
    end if; 
end process;   

end Behavioral;