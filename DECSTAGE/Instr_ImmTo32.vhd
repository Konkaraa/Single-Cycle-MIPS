----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:30:39 04/01/2020 
-- Design Name: 
-- Module Name:    Instr_ImmTo32 - Behavioral 
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instr_ImmTo32 is
    Port ( Instr   : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode  : in  STD_LOGIC_VECTOR (1 downto 0);
           Imm_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Instr_ImmTo32;

architecture Behavioral of Instr_ImmTo32 is

 SIGNAL QTEMP1:STD_LOGIC_VECTOR (31 downto 0);
 
 
 begin
 process(Instr,Opcode,QTEMP1)
	begin
	If (Opcode="00") then --SingExt
	QTEMP1(15 downto 0)<=Instr;
	QTEMP1(31 downto 16)<=(31 downto 16 => Instr(15));
	Elsif (Opcode="01") then --ZeroFill
	QTEMP1(15 downto 0)<=Instr;
	QTEMP1(31 downto 16)<="0000000000000000";
   Elsif (Opcode="10") then --Shift 16 
	QTEMP1(31 downto 16)<=Instr;
	QTEMP1(15 downto 0) <="0000000000000000";
	Elsif (Opcode="11") then --Do nothing
	QTEMP1(15 downto 0)<=Instr;
	end If;
 Imm_out<=QTEMP1 ;
 end process;
end Behavioral;

