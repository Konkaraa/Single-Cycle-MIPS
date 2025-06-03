----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:36:51 03/30/2020 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
 Port 	( PC_Immed 	: in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel 	: in  STD_LOGIC;
           PC_LdEn 	: in  STD_LOGIC;
           Reset 		: in  STD_LOGIC;
           Clk 		: in  STD_LOGIC;
           PC			: out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
 component ADD4 is
 port		(A:in std_logic_vector(31 downto 0);
			 B:out std_logic_vector(31 downto 0));
 end component;

 component ADD_Imm is
 port		(A : in  STD_LOGIC_VECTOR (31 downto 0);
          B : in  STD_LOGIC_VECTOR (31 downto 0);
          S : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;

 
 
 component Mux2 is
 port		(A   : in  STD_LOGIC_VECTOR (31 downto 0);
          B   : in  STD_LOGIC_VECTOR (31 downto 0);
          Sel : in  STD_LOGIC;
          Op  : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;
 
 component PC_RF is
 port		(Din 			: in std_logic_vector(31 downto 0); 
			 PC_LdEn 	: in std_logic; 
			 Clk, Reset	: in std_logic; 
			 Dout 		: out std_logic_vector(31 downto 0)); 
 end component; 
 
 SIGNAL tempadd4 	  :STD_LOGIC_VECTOR(31 DOWNTO 0);
 SIGNAL tempadd_imm :STD_LOGIC_VECTOR(31 DOWNTO 0);
 SIGNAL pcout		  :STD_LOGIC_VECTOR(31 DOWNTO 0);
 SIGNAL pcin		  :STD_LOGIC_VECTOR(31 DOWNTO 0);
 
 begin
 ADD4_label:ADD4
	Port map(A=>pcout,
				B=>tempadd4);
 
 ADD_Imm_label:ADD_Imm
	Port map(A=>PC_Immed,
				B=>tempadd4,
				S=>tempadd_imm);
				
 Mux2_label:Mux2
	Port map(A=>tempadd4,
				B=>tempadd_imm,
				Sel=> PC_sel,
				Op=>pcin);
				

 PC_label:PC_RF
	Port map(Din=>pcin,
				PC_LdEn=>PC_LdEn,
				Clk=> Clk,
				Reset=>Reset,
				Dout=>pcout );
	
	PC<=pcout;
	
end Behavioral;

