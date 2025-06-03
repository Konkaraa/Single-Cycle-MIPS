----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:28 03/10/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A      : in  STD_LOGIC_VECTOR (31 downto 0);
           B 		: in  STD_LOGIC_VECTOR (31 downto 0);
           Op 		: in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero 	: out  STD_LOGIC;
           Cout 	: out  STD_LOGIC;
           Ovf 	: out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	SIGNAL QTEMP1:STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL Z,C,O:STD_LOGIC;
	SIGNAL In1:unsigned(31 downto 0);
	SIGNAL In2:signed(31 downto 0);
	signal In3 : Bit_vector(31 downto 0);
	
begin
process(A,B,Op,In1,In2,QTEMP1)
begin

If (Op="0000") then --Add
	QTEMP1<=A+B;
	Z<='0';
	O<='0';
	C<='0';
		if((A(31)=B(31))AND (B(31)/=QTEMP1(31))) then
		O<='1';
		C<='1';
		end if;
	
Elsif (Op="0001") then --Sub
	QTEMP1<=A-B;
	Z<='0';
	O<='0';
	C<='0';
		if(A=B) then
		Z<='1';
		end if;
		if((A(31)/=B(31))AND (B(31)=QTEMP1(31))) then
		O<='1';
		
		end if;
Elsif(Op="0010") then --And
	QTEMP1<=A AND B;
	Z<='0';
	O<='0';
	C<='0';
Elsif(Op="0011") then --Or
	QTEMP1<=A OR B;
	Z<='0';
	O<='0';
	C<='0';
Elsif(Op="0100") then --Not
	QTEMP1<=NOT A;
	Z<='0';
	O<='0';
	C<='0';
Elsif(Op="0101") then --Nand
	QTEMP1<=A NAND B;
	Z<='0';
	O<='0';
	C<='0';
Elsif(Op="0110") then --Nor
	QTEMP1<=A NOR B;
	Z<='0';
	O<='0';
	C<='0';	
Elsif(Op="1000") then --Sra
	In2<= signed(A);
	QTEMP1 <= std_logic_vector(shift_right(signed(In2), 1));
	Z<='0';
	O<='0';
	C<='0';
	
Elsif(Op="1001") then --Srl
	In1<= unsigned(A);
	QTEMP1<=std_logic_vector(In1 srl 1);
	Z<='0';
	O<='0';
	C<='0';
Elsif(Op="1010") then --Sll
	In2<= signed(A);
	QTEMP1<=std_logic_vector(In2 sll 1);
	Z<='0';
	O<='0';
	C<='0';
Elsif(Op="1100") then --Rol
	In2<= signed(A);
	QTEMP1<= std_logic_vector(In2 rol 1);
	Z<='0';
	O<='0';
	C<='0';
Elsif(Op="1101") then --Ror
	In2<= signed(A);
	QTEMP1<= std_logic_vector(In2 ror 1);
	Z<='0';
	O<='0';
	C<='0';
end If;
Output<=QTEMP1 after 10 ns;
Zero<=Z;
Cout<=C;
Ovf<=O;
end process;

end Behavioral;

