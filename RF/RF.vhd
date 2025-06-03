----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:46:23 03/28/2020 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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

entity RF is
    Port ( CLK 	 : in  STD_LOGIC;
           RST 	 : in  STD_LOGIC;
           Datain  : in  STD_LOGIC_VECTOR (31 downto 0);
           WE		 : in  STD_LOGIC;
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is

begin
process (WE,CLK,RST)
	begin
		IF (RST='1') then --When we reset the Register has no address
			Dataout<="00000000000000000000000000000000";
		ELSE
			if WE = '1' AND (CLK'event AND CLK = '1')then
				Dataout <= Datain after 10 ns ;
			end if;
		end IF;	
	end process;


end Behavioral;

