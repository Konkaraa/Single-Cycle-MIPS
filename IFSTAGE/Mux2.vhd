----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:23:41 03/31/2020 
-- Design Name: 
-- Module Name:    Mux2 - Behavioral 
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

entity Mux2 is
    Port ( A 	: in  STD_LOGIC_VECTOR (31 downto 0);
           B 	: in  STD_LOGIC_VECTOR (31 downto 0);
           Sel : in  STD_LOGIC;
           Op 	: out  STD_LOGIC_VECTOR (31 downto 0));
end Mux2;

architecture Behavioral of Mux2 is

begin

Op <= 	A after 10 ns  when (Sel='0') else B after 10 ns  ;

end Behavioral;

