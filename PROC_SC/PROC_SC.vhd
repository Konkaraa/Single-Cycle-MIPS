----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:50 04/10/2020 
-- Design Name: 
-- Module Name:    PROC_SC - Behavioral 
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

entity PROC_SC is
    Port ( Clk 	: in  STD_LOGIC;
           Reset  : in  STD_LOGIC);
end PROC_SC;

architecture Behavioral of PROC_SC is
 
 component DATAPATH is
	 Port ( ZERO			  	 : out STD_LOGIC;
			  Datapath_Data  	 : out  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out  	 		 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_Addr  	 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_WrEn  	 : out  STD_LOGIC;
			  INSTRUCTION  	 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_RdData  : in  STD_LOGIC_VECTOR (31 downto 0);
			  ByteOp			  	 : in  STD_LOGIC;
			  Reset 			  	 : in  STD_LOGIC;
			  MeM_WrEn		 	 : in  STD_LOGIC;
			  PC_LdEn		 	 : in  STD_LOGIC;
			  PC_Sel			 	 : in  STD_LOGIC;
			  RF_WrEn 		 	 : in  STD_LOGIC;
			  RF_WrData_sel 	 : in  STD_LOGIC;
			  RF_WrData_sel2	 : in  STD_LOGIC;
			  RF_B_sel 		 	 : in  STD_LOGIC;
			  ALU_Bin_sel 	 	 : in  STD_LOGIC;
			  ALU_func		 	 : in  STD_LOGIC_VECTOR (3 downto 0);
			  ImmExt			 	 : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk 			 	 : in  STD_LOGIC);
 end component; 

 component CONTROL is
	Port (  ZERO			  : in STD_LOGIC;
			  INSTRUCTION    : in  STD_LOGIC_VECTOR (31 downto 0);
			  ByteOp			  : out  STD_LOGIC;
			  Reset 			  : in STD_LOGIC;
			  PC_Reset 		  : out STD_LOGIC;
			  MeM_WrEn		  : out  STD_LOGIC;
			  PC_LdEn		  : out  STD_LOGIC;
			  PC_Sel			  : out  STD_LOGIC;
			  RF_WrEn 		  : out  STD_LOGIC;
			  RF_WrData_sel  : out  STD_LOGIC;
			  RF_WrData_sel2 : out  STD_LOGIC;
			  RF_B_sel 		  : out  STD_LOGIC;
			  ALU_Bin_sel 	  : out  STD_LOGIC;
			  ALU_func		  : out  STD_LOGIC_VECTOR (3 downto 0);
			  ImmExt			  : out  STD_LOGIC_VECTOR (1 downto 0);
           Clk 			  : in  STD_LOGIC);
 end component;

 component RAM is 
	Port( clk		 : in std_logic;
			inst_addr : in std_logic_vector(10 downto 0); 
			inst_dout : out std_logic_vector(31 downto 0); 
			data_we   : in std_logic; 
			data_addr : in std_logic_vector(10 downto 0); 
			data_din  : in std_logic_vector(31 downto 0); 
			data_dout : out std_logic_vector(31 downto 0)); 
  end component;

 signal temp_ZERO 			 :  std_logic;
 signal temp_Datapath_WrEn  :  std_logic;
 signal temp_ByteOp 			 :  std_logic;
 signal temp_MeM_WrEn 		 :  std_logic;
 signal temp_PC_LdEn 		 :  std_logic;
 signal temp_PC_Sel 			 :  std_logic;
 signal temp_RF_WrEn 		 :  std_logic;
 signal temp_Reset 			 :  std_logic;
 signal temp_RF_WrData_sel  :  std_logic;
 signal temp_RF_WrData_sel2 :  std_logic;
 signal temp_RF_B_sel 		 :  std_logic;
 signal temp_ALU_Bin_sel 	 :  std_logic;
 signal temp_ALU_func		 : std_logic_vector(3 downto 0);
 signal temp_ImmExt			 : std_logic_vector(1 downto 0);
 signal temp_Datapath_Data  : std_logic_vector(31 downto 0);
 signal temp_PC_out			 : std_logic_vector(31 downto 0);
 signal temp_Datapath_Addr  : std_logic_vector(31 downto 0);
 signal temp_INSTRUCTION	 : std_logic_vector(31 downto 0);
 signal temp_Datapath_RdData: std_logic_vector(31 downto 0);
 
begin

 Datapath_label:DATAPATH
 port map (ZERO=>temp_ZERO,			  	 
			  Datapath_Data=>temp_Datapath_Data,  	 
			  PC_out=>temp_PC_out,  	 		 
			  Datapath_Addr=>temp_Datapath_Addr,  	 
			  Datapath_WrEn=>temp_Datapath_WrEn,  	 
			  INSTRUCTION=>temp_INSTRUCTION,  	 
			  Datapath_RdData=>temp_Datapath_RdData, 
			  ByteOp=>temp_ByteOp,			  
			  Reset=>temp_Reset, 			 
			  MeM_WrEn=>temp_MeM_WrEn,		  
			  PC_LdEn=>temp_PC_LdEn,		  
			  PC_Sel=>temp_PC_Sel,			  
			  RF_WrEn=>temp_RF_WrEn, 		  
			  RF_WrData_sel=>temp_RF_WrData_sel,  
			  RF_WrData_sel2=>temp_RF_WrData_sel2,
			  RF_B_sel=>temp_RF_B_sel, 		  
			  ALU_Bin_sel=>temp_ALU_Bin_sel,  	 
			  ALU_func=>temp_ALU_func,		  
			  ImmExt=>temp_ImmExt,			  
           Clk=>Clk); 			  

 CONTROL_label:CONTROL
 port map (ZERO=>temp_ZERO,			  
			  INSTRUCTION=>temp_INSTRUCTION,     
			  ByteOp=>temp_ByteOp,			  
			  Reset=>Reset, 			  
			  PC_Reset=>temp_Reset, 		 
			  MeM_WrEn=>temp_MeM_WrEn,		  
			  PC_LdEn=>temp_PC_LdEn,		 
			  PC_Sel=>temp_PC_Sel,			 
			  RF_WrEn=>temp_RF_WrEn, 		  
			  RF_WrData_sel=>temp_RF_WrData_sel,  
			  RF_WrData_sel2=>temp_RF_WrData_sel2, 
			  RF_B_sel=>temp_RF_B_sel, 		  
			  ALU_Bin_sel=>temp_ALU_Bin_sel,  	  
			  ALU_func=>temp_ALU_func,		  
			  ImmExt=>temp_ImmExt,			  
           Clk=>Clk 	);
			  
 RAM_label:RAM
 port map(clk=>Clk,		 
			 inst_addr=>temp_PC_out(12 downto 2), 
			 inst_dout=>temp_INSTRUCTION,  
			 data_we=>temp_Datapath_WrEn,    
			 data_addr=>temp_Datapath_Addr(12 downto 2),  
			 data_din=>temp_Datapath_Data,   
			 data_dout=>temp_Datapath_RdData ); 

end Behavioral;

