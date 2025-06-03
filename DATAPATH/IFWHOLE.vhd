----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:25 04/02/2020 
-- Design Name: 
-- Module Name:    IFWHOLE - Behavioral 
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

entity IFWHOLE is
 Port 	( PC_Immed 	: in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel 	: in  STD_LOGIC;
           PC_LdEn 	: in  STD_LOGIC;
           Reset 		: in  STD_LOGIC;
           Clk 		: in  STD_LOGIC;
           Instr_out 		: out  STD_LOGIC_VECTOR (31 downto 0));
end IFWHOLE;

architecture Behavioral of IFWHOLE is

 component RAM is
 port		(clk		 : in std_logic;
			inst_addr : in std_logic_vector(10 downto 0); 
			inst_dout : out std_logic_vector(31 downto 0); 
			data_we   : in std_logic; 
			data_addr : in std_logic_vector(10 downto 0); 
			data_din  : in std_logic_vector(31 downto 0); 
			data_dout : out std_logic_vector(31 downto 0)); 
 end component;


 component IFSTAGE is
  Port 	( PC_Immed 	: in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel 	: in  STD_LOGIC;
           PC_LdEn 	: in  STD_LOGIC;
           Reset 		: in  STD_LOGIC;
           Clk 		: in  STD_LOGIC;
           Instr 		: out  STD_LOGIC_VECTOR (31 downto 0));
 end component;			  
 SIGNAL pcout:STD_LOGIC_VECTOR(31 DOWNTO 0);
 
 begin

 IF_Mem_label:RAM
 port map (clk=>Clk	,	 
			  inst_addr=>pcout(12 downto 2), 
			  inst_dout=>Instr_out  ,
			  data_we=>'0',  
			  data_addr=>"00000000000",  
			  data_din=> "00000000000000000000000000000000",  
			  data_dout=>open );
			  
 IFSTAGES_label:IFSTAGE
 port map(PC_Immed=>PC_Immed,
			 PC_sel=>PC_sel,
			 PC_LdEn=>PC_LdEn,
			 Reset=>Reset,
			 Clk=>Clk,
			 Instr=>pcout); 
			 
			 
			 
end Behavioral;

