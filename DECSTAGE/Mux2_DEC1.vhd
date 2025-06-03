----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:42:30 04/01/2020 
-- Design Name: 
-- Module Name:    Mux2_DEC1 - Behavioral 
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

entity Mux2_DEC1 is
    Port ( ALU_out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel  : in  STD_LOGIC;
           Out_Write_Data : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux2_DEC1;

architecture Behavioral of Mux2_DEC1 is

begin
Out_Write_Data <= 	ALU_out after 10 ns when RF_WrData_sel='0' else MEM_out after 10 ns ;

end Behavioral;

