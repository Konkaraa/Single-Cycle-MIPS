----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:43 04/05/2020 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
    Port ( ZERO			  	 : out STD_LOGIC;
			  Datapath_Data  	 : out  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out  	 		 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_Addr  	 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_WrEn  	 : out  STD_LOGIC;
			  INSTRUCTION  	 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_RdData  : in  STD_LOGIC_VECTOR (31 downto 0);
			  ByteOp			 	 : in  STD_LOGIC;
			  Reset 			  	 : in  STD_LOGIC;
			  MeM_WrEn		 	 : in  STD_LOGIC;
			  PC_LdEn		 	 : in  STD_LOGIC;
			  PC_Sel				 : in  STD_LOGIC;
			  RF_WrEn 			 : in  STD_LOGIC;
			  RF_WrData_sel  	 : in  STD_LOGIC;
			  RF_WrData_sel2 	 : in  STD_LOGIC;
			  RF_B_sel 		 	 : in  STD_LOGIC;
			  ALU_Bin_sel 	 	 : in  STD_LOGIC;
			  ALU_func		  	 : in  STD_LOGIC_VECTOR (3 downto 0);
			  ImmExt			 	 : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk 			 	 : in  STD_LOGIC);
end DATAPATH;

architecture Behavioral of DATAPATH is

 component IFSTAGE is
 Port		 (PC_Immed 	: in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel 	: in  STD_LOGIC;
           PC_LdEn 	: in  STD_LOGIC;
           Reset 		: in  STD_LOGIC;
           Clk 		: in  STD_LOGIC;
           PC 			: out  STD_LOGIC_VECTOR (31 downto 0));
 end component;

 component DECSTAGES is
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
 end component;

 component EXSTAGES is
    Port ( RF_A 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel: in  STD_LOGIC;
           ALU_func 	 : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out 	 : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero	 : out  STD_LOGIC);
 end component;			  

 component MEMSTAGES is
    Port ( clk				: in  STD_LOGIC;
			  ByteOp 		: in  STD_LOGIC;
           Mem_WrEn  	: in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn 	: in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut  : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr 		: out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEN 		: out  STD_LOGIC;
			  MM_RdData    : in  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData 	: out  STD_LOGIC_VECTOR (31 downto 0)
           );
  end component; 
 
 
 signal temp_RF_B ,temp_RF_A					  : STD_LOGIC_VECTOR (31 downto 0);
 signal temp_ALU_out,temp_MEM_out,temp_Immed: STD_LOGIC_VECTOR (31 downto 0);
 
 begin
 IFWHOLE_label:IFSTAGE
 port map(PC_Immed=>temp_Immed,
			 Reset=>	Reset,
			 Clk=>Clk,
			 PC_LdEn=>PC_LdEn,
			 PC_sel=>PC_sel,
			 PC=>PC_out);
 
 DECSTAGES_label:DECSTAGES
 port map(Instr=>INSTRUCTION  ,
			 RF_WrEn=>RF_WrEn,
			 RF_WrData_sel=>RF_WrData_sel,
			 RF_WrData_sel2=>RF_WrData_sel2,
			 RF_B_sel=>RF_B_sel,
			 ImmExt=>ImmExt,
			 Clk=>Clk,
			 Rst=>Reset,
			 ALU_out=>temp_ALU_out, 
			 MEM_out=>temp_MEM_out,
			 Immed=>temp_Immed,
			 RF_A=>temp_RF_A, 
			 RF_B=>temp_RF_B); 
			 
 EXSTAGES_label:EXSTAGES
 port map( RF_A=>temp_RF_A,
			  RF_B=>temp_RF_B,
			  Immed=>temp_Immed,
			  ALU_out=>temp_ALU_out, 
			  ALU_Bin_sel=>ALU_Bin_sel,
			  ALU_func=>ALU_func,
			  ALU_zero=>ZERO );
	
 MEMSTAGE_label:MEMSTAGES
 port map (ByteOp => ByteOp,
			  Clk => Clk,
           Mem_WrEn => Mem_WrEn,
           ALU_MEM_Addr => temp_ALU_out,
           MEM_DataIn => temp_RF_B,
           MEM_DataOut => temp_MEM_out,
			  MM_Addr =>Datapath_Addr,
           MM_WrEn => Datapath_WrEn,
			  MM_RdData=>Datapath_RdData,
           MM_WrData => Datapath_Data );
 
end Behavioral;

