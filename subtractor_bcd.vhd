library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity subtractor_bcd is
    Port ( 
				A : in  STD_LOGIC_VECTOR (3 downto 0):= X"0";
           B : in  STD_LOGIC_VECTOR (3 downto 0):= X"0";
			  BORROW_IN: in  STD_LOGIC;
           RESULT : out  STD_LOGIC_VECTOR (3 downto 0):= X"0";
           BORROW : out  STD_LOGIC:= '0'
			  );
end subtractor_bcd;

architecture Behavioral of subtractor_bcd is

begin
process(A,B,BORROW_IN)

variable sum_temp : unsigned(4 downto 0);
variable temp_a : unsigned(4 downto 0);
variable temp_a_borrow : unsigned(4 downto 0);
variable temp_b : unsigned(4 downto 0);

begin
	 temp_a := unsigned('0' & A);
	 temp_b := unsigned('0' & B);
	 temp_a_borrow := unsigned('0' & A) + 10;
    if(temp_a < temp_b ) then
			sum_temp := temp_a_borrow - temp_b - ("0000" & BORROW_IN);
        BORROW <= '1';
    else
			sum_temp := temp_a - temp_b - ("0000" & BORROW_IN);
        BORROW <= '0';
    end if; 
	 RESULT <= std_logic_vector(sum_temp(3 downto 0));

end process;  

end Behavioral;

