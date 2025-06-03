----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:13:02 04/01/2020 
-- Design Name: 
-- Module Name:    Mux2ALU - Behavioral 
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

entity Mux2ALU is
    Port ( RF 				: in  STD_LOGIC_VECTOR (31 downto 0);
           Im 				: in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel  : in  STD_LOGIC;
           Mux2AlLU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux2ALU;

architecture Behavioral of Mux2ALU is

begin
Mux2AlLU_out <= 	RF after 10 ns when ALU_Bin_sel='0' else Im after 10 ns;

end Behavioral;

