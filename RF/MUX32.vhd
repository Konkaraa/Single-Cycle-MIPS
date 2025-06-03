----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:10 03/30/2020 
-- Design Name: 
-- Module Name:    MUX32 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
library work;
use work.regarray_type.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX32 is
Port 		(Registers 	: in regarray;
			 Ard  		: in  STD_LOGIC_VECTOR (4 downto 0);
          Rout 	   : out  STD_LOGIC_VECTOR (31 downto 0));

end MUX32;

architecture Behavioral of MUX32 is

begin
WITH Ard SELECT
	Rout <=  Registers(0) after 10 ns WHEN "00000",
			   Registers(1) after 10 ns WHEN "00001",
			   Registers(2) after 10 ns WHEN "00010",
			   Registers(3) after 10 ns WHEN "00011",
			   Registers(4) after 10 ns WHEN "00100",
			   Registers(5) after 10 ns WHEN "00101",
			   Registers(6) after 10 ns WHEN "00110",
			   Registers(7) after 10 ns WHEN "00111",
			   Registers(8) after 10 ns WHEN "01000",
			   Registers(9) after 10 ns WHEN "01001",
			   Registers(10) after 10 ns WHEN "01010",
			   Registers(11) after 10 ns WHEN "01011",
			   Registers(12) after 10 ns WHEN "01100",
			   Registers(13) after 10 ns WHEN "01101",
			   Registers(14) after 10 ns WHEN "01110",
			   Registers(15) after 10 ns WHEN "01111",
				Registers(16) after 10 ns WHEN "10000",
				Registers(17) after 10 ns WHEN "10001",
				Registers(18) after 10 ns WHEN "10010",
				Registers(19) after 10 ns WHEN "10011",
				Registers(20) after 10 ns WHEN "10100",
				Registers(21) after 10 ns WHEN "10101",
				Registers(22) after 10 ns WHEN "10110",
				Registers(23) after 10 ns WHEN "10111",
				Registers(24) after 10 ns WHEN "11000",
				Registers(25) after 10 ns WHEN "11001",
				Registers(26) after 10 ns WHEN "11010",
				Registers(27) after 10 ns WHEN "11011",
				Registers(28) after 10 ns WHEN "11100",
				Registers(29) after 10 ns WHEN "11101",
				Registers(30) after 10 ns WHEN "11110",
				Registers(31) after 10 ns WHEN others;


end Behavioral;

