----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:09:02 04/01/2020 
-- Design Name: 
-- Module Name:    EXSTAGES - Behavioral 
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

entity EXSTAGES is
    Port ( RF_A 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel: in  STD_LOGIC;
           ALU_func 	 : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out 	 : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero 	 : out  STD_LOGIC);
end EXSTAGES;

architecture Behavioral of EXSTAGES is
 component ALU is
    Port ( A      : in  STD_LOGIC_VECTOR (31 downto 0);
           B 		: in  STD_LOGIC_VECTOR (31 downto 0);
           Op 		: in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero 	: out  STD_LOGIC;
           Cout 	: out  STD_LOGIC;
           Ovf 	: out  STD_LOGIC);
	 end component;
 
 component Mux2ALU is
    Port ( RF 				: in  STD_LOGIC_VECTOR (31 downto 0);
           Im 				: in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel  : in  STD_LOGIC;
           Mux2AlLU_out : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;
 
 signal RFB 	: STD_LOGIC_VECTOR (31 downto 0);
 signal Qtemp1 : STD_LOGIC_VECTOR (31 downto 0);
 signal Qtemp2 : STD_LOGIC ;
 
 begin
 Mux2ALU_label:Mux2ALU
 port map(RF=>RF_B,
			 Im=>Immed,
			 ALU_Bin_sel=>ALU_Bin_sel,
			 Mux2AlLU_out=>RFB);
 
 ALU_label:ALU
 port map(A=>RF_A,
			 B=>RFB,
			 Op=>ALU_func,
			 Output=>ALU_out,
			 Zero=>ALU_zero);
			 
 
end Behavioral;

