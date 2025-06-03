----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:25 04/01/2020 
-- Design Name: 
-- Module Name:    Mux2_DEC2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux2_DEC2 is
    Port ( Instr1 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Instr2 	: in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel  : in  STD_LOGIC;
           RD2 		: out  STD_LOGIC_VECTOR (4 downto 0));
end Mux2_DEC2;

architecture Behavioral of Mux2_DEC2 is

begin
RD2 <= 	Instr1 after 10 ns when RF_B_sel='0' else Instr2 after 10 ns;

end Behavioral;

