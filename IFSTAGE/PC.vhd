----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:27:04 03/31/2020 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC_RF is
port (Din 			: in std_logic_vector(31 downto 0); 
		PC_LdEn 		: in std_logic; 
		Clk, Reset 	: in std_logic; 
		Dout 			: out std_logic_vector(31 downto 0)); 
end PC_RF;

architecture Behavioral of PC_RF is

begin
process(Clk,Reset)
begin 
	
	if Reset = '1' then   --When we reset the PC starts from the begining  
		Dout <= "00000000000000000000000000000000" after 10 ns ;
		
	elsif Clk'event and Clk = '1' then
		if PC_LdEn='1' then 
			Dout <= Din after 10 ns ;
		else 
			null;
		end if;
	end if;
end process;

end Behavioral;

