----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:51:50 04/01/2020 
-- Design Name: 
-- Module Name:    DECSTAGES - Behavioral 
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

entity DECSTAGES is
    Port ( Instr 			 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn 		 : in  STD_LOGIC;
           ALU_out 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
			  RF_WrData_sel2: in  STD_LOGIC;
           RF_B_sel 		 : in  STD_LOGIC;
           ImmExt 		 : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk 			 : in  STD_LOGIC;
			  Rst 			 : in  STD_LOGIC;
           Immed 			 : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A 			 : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B 			 : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGES;

architecture Behavioral of DECSTAGES is
 component Mux2_DEC2 is
    Port ( Instr1 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Instr2 	: in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel  : in  STD_LOGIC;
           RD2 		: out  STD_LOGIC_VECTOR (4 downto 0));
	 end component;			  

 component Mux2_DEC1 is
    Port ( ALU_out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel  : in  STD_LOGIC;
           Out_Write_Data : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

 component Mux2_DEC3 is
 Port 	 (Imm 		  			: in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_out 		   	: in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel2     : in  STD_LOGIC;
           Out_Write_Data_Imm : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;
	 
 component WholeRF is
    Port ( Adr1 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Awr 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Din 	: in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn 	: in  STD_LOGIC;
           Clk 	: in  STD_LOGIC;
           Rst 	: in  STD_LOGIC;
           Dout1 	: out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 	: out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;
 
 component Instr_ImmTo32 is
    Port ( Instr 	: in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (1 downto 0);
           Imm_out: out  STD_LOGIC_VECTOR (31 downto 0));
			  
	 end component	;	  

 signal dec1_out1,dec1_out2	 : STD_LOGIC_VECTOR (31 downto 0);
 signal RD2_out	 : STD_LOGIC_VECTOR (4 downto 0);
 signal temp_Imm	 : STD_LOGIC_VECTOR (31 downto 0);
 
 begin
 
 Mux2_DEC1_label:Mux2_DEC1
 port map(ALU_out=>ALU_out,
			 MEM_out=>MEM_out,
			 RF_WrData_sel=>RF_WrData_sel,
			 Out_Write_Data=>dec1_out1);

 Mux2_DEC2_label:Mux2_DEC2
 port map(RF_B_sel=>RF_B_sel,
			 Instr1=>Instr(15 downto 11),
			 Instr2=>Instr(20 downto 16),
			 RD2=>RD2_out);
			 
 Mux2_DEC3_label:Mux2_DEC3 --This Mux is when we want to do Li and Lui to take the Imm address
 port map(Imm=>temp_Imm,
			 Mux_out=>dec1_out1,
			 RF_WrData_sel2=>RF_WrData_sel2,
			 Out_Write_Data_Imm=>dec1_out2);

 RF_label:WholeRF	
 port map(Clk=>Clk,
			 Din=>dec1_out2,
			 Adr1=>Instr(25 downto 21),
			 Adr2=>RD2_out,
			 Awr=>Instr(20 downto 16),
			 WrEn=>RF_WrEn,
			 Rst=>Rst,
			 Dout1=>RF_A,
			 Dout2=>RF_B);
			 
 
 Instr_ImmTo32_label:Instr_ImmTo32
 port map(Instr=>Instr(15 downto 0),
			 Opcode=>ImmExt,
			 Imm_out=>temp_Imm );

 Immed<=temp_Imm;		 
end Behavioral;

