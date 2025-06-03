----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:21:22 04/01/2020 
-- Design Name: 
-- Module Name:    MEMSTAGES - Behavioral 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGES is
    Port ( clk          : in  STD_LOGIC;
           ByteOp       : in  STD_LOGIC;
           Mem_WrEn     : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn   : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut  : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr      : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEN      : out  STD_LOGIC;
			  MM_RdData		:in STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData    : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGES;

architecture Behavioral of MEMSTAGES is

 signal temp1 				 :std_logic_vector(31 downto 0);
 signal temp_out 			 :std_logic_vector(31 downto 0);
 signal temp_MEM_DataOut :std_logic_vector(31 downto 0);
 
begin
process(ByteOp,ALU_MEM_Addr,temp_out,MM_RdData)
begin
 if (ByteOp='1') then --To choose sb/lb
        temp1<=ALU_MEM_Addr;
        temp_out<=temp1+"00000000000000000000010000000000";--Add 1024 to the address
		  temp_MEM_DataOut(31 downto 8)<="000000000000000000000000";--Zero filling
		  temp_MEM_DataOut(7 downto 0)<=MM_RdData(7 downto 0);
    elsif    (ByteOp='0') then 		--To choose sw/lw
        temp_out<=ALU_MEM_Addr+"00000000000000000000010000000000"; --Add 1024 to the address
		  temp_MEM_DataOut<=MM_RdData;
    end if;
 end process;

 
MEM_DataOut<=temp_MEM_DataOut;
MM_WrData<=MEM_DataIn;
MM_WrEN <=MeM_WrEn;
MM_Addr<=temp_out;

end Behavioral;
