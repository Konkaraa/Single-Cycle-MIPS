----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:18:39 04/09/2020 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
Port ( 	  ZERO			  : in STD_LOGIC;
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
end CONTROL;

architecture Behavioral of CONTROL is



begin
	process(Reset,INSTRUCTION,ZERO)
	begin
	If (Reset='1') then			--Reset for some cycle clock to start the processor 
			PC_sel			<= '0';
			PC_LdEn			<= '0';
			PC_Reset			<= '1';
			RF_WrEn			<= '0';
			RF_WrData_sel	<= '0';
			RF_WrData_sel2 <= '0'; 
			ImmExt			<= "00";
			RF_B_sel			<= '0';
			ALU_Bin_sel		<= '0';
			ALU_func			<= "0000";
			MEM_WrEn			<= '0';
			ByteOp			<= '0';
	Else		
			PC_Reset		   <=	'0';
			if(INSTRUCTION="00000000000000000000000000000000") then --Deafult ,in the case we have his instruction
				RF_WrEn	<='0';
				MEM_WrEn <= '0';
				PC_LdEn	<= '1';
				PC_Sel	<= '0';
			elsif(INSTRUCTION(31 downto 26)="100000") then --ALU
				RF_B_Sel <= '0';
				ALU_Bin_Sel	<= '0';
				if INSTRUCTION(5 downto 0)="110000" then	--Add
				ALU_func<= "0000";			
				elsif INSTRUCTION(5 downto 0)="110001" then --Sub
				ALU_func<= "0001";		
				elsif INSTRUCTION(5 downto 0)="110010" then --And
				ALU_func<= "0010";
				elsif INSTRUCTION(5 downto 0)="110011" then --Or
				ALU_func<= "0011";
				elsif INSTRUCTION(5 downto 0)="110100" then --Not
				ALU_func<= "0100";
				elsif INSTRUCTION(5 downto 0)="110101" then --Nand
				ALU_func<= "0101";
				elsif INSTRUCTION(5 downto 0)="110110" then --Nor
				ALU_func<= "0110";
				elsif INSTRUCTION(5 downto 0)="111000" then --Sra
				ALU_func<= "1000";
				elsif INSTRUCTION(5 downto 0)="111001" then --Srl
				ALU_func<= "1001";
				elsif INSTRUCTION(5 downto 0)="111010" then --Sll
				ALU_func<= "1010";
				elsif INSTRUCTION(5 downto 0)="111100" then --Rol
				ALU_func<= "1100";
				elsif INSTRUCTION(5 downto 0)="111101" then --Ror
				ALU_func<= "1101";
				end if;
				RF_WrData_sel  <= '0';
				RF_WrData_sel2 <= '1';
				RF_WrEn	<= '1';
				PC_LdEn	<= '1';
				PC_Sel	<= '0';
			elsif(INSTRUCTION(31 downto 26)="111000") then --Li
				ImmExt		<= "00";				
				RF_WrData_sel2 <= '0';
				RF_WrEn	<= '1';
				PC_LdEn	<= '1';
				PC_Sel	<= '0';
			elsif(INSTRUCTION(31 downto 26)="111001") then --Lui
				ImmExt		<= "10";
				RF_WrData_sel2 <= '0';
				RF_WrEn	<= '1';
				PC_LdEn	<= '1';
				PC_Sel	<= '0';
			elsif(INSTRUCTION(31 downto 26)="110000") then	--Addi
				ALU_Bin_Sel	<= '1';
				ALU_func<= "0000";
				ImmExt		<= "00";				
				RF_WrData_sel <= '0';
				RF_WrData_sel2 <= '1';
				RF_WrEn	<= '1';
				PC_LdEn	<= '1';
				PC_Sel	<= '0';
			elsif(INSTRUCTION(31 downto 26)="110010") then --Nandi
				ALU_Bin_Sel	<= '1';
				ALU_func<= "0101";
				ImmExt		<= "01";
				RF_WrData_sel <= '0';
				RF_WrData_sel2 <= '1';
				RF_WrEn	<= '1';
				PC_LdEn	<= '1';
				PC_Sel	<= '0';
			elsif(INSTRUCTION(31 downto 26)="110011") then --Ori
				ALU_Bin_Sel	<= '1';
				ALU_func<= "0011";
				ImmExt		<= "01";
				RF_WrData_sel <= '0';
				RF_WrData_sel2 <= '1';
				RF_WrEn	<= '1';
				PC_LdEn	<= '1';
				PC_Sel	<= '0';
			elsif(INSTRUCTION(31 downto 26)="111111") then --B
				ImmExt		<= "00";
				RF_WrEn 		<= '0';
				PC_LdEn	<= '1';
				PC_Sel	<= '1';				
			elsif(INSTRUCTION(31 downto 26)="000000") then --Beq
				ImmExt		<= "00";
				RF_WrEn 		<= '0';
				RF_B_sel <='1';
				ALU_Bin_sel <= '0';
				ALU_func		<= "0001";
				if(ZERO = '1') then 
					PC_LdEn	<= '1';
					PC_Sel	<= '1';
				else
				   PC_LdEn	<= '1';
					PC_Sel	<= '0';
				end if;
			elsif(INSTRUCTION(31 downto 26)="000001") then --Bneq
				ImmExt		<= "00";
				RF_WrEn 		<= '0';	
				RF_B_sel <='1';
				ALU_Bin_sel <= '0';
				ALU_func		<= "0001";
				if(ZERO = '0') then 
					PC_LdEn	<= '1';
					PC_Sel	<= '1';
				else
					PC_LdEn	<= '1';
					PC_Sel	<= '0';
				end if;
			elsif(INSTRUCTION(31 downto 26)="000111") then --Sb
				RF_B_sel<='1';
				RF_WrEn <='0';
				PC_LdEn	<= '1';
				ALU_Bin_Sel <= '1';
				ALU_func		<= "0000";
				ImmExt		<= "00";	
				ByteOp	<= '1';
				MeM_WrEn	<= '1';
			elsif(INSTRUCTION(31 downto 26)="011111") then --Sw
				RF_B_sel<='1';
				RF_WrEn <='0';
				PC_LdEn	<= '1';
				ALU_Bin_Sel <= '1';
				ALU_func		<= "0000";
				ImmExt		<= "00";	
				ByteOp	<= '0';
				MeM_WrEn	<= '1';
			elsif(INSTRUCTION(31 downto 26)="000011") then --Lb
				ALU_Bin_Sel <= '1';
				ALU_func		<= "0000";
				ImmExt		<= "00";	
				ByteOp	<= '1';
				Mem_WrEn	<= '0'; 
				RF_WrEn	<='1';
				PC_LdEn	<= '1';
				RF_WrData_sel <= '1';
			elsif(INSTRUCTION(31 downto 26)="001111") then --Lw
				ALU_Bin_Sel <= '1';
				ALU_func		<= "0000";
				ImmExt		<= "00";	
				ByteOp	<= '0';
				Mem_WrEn	<= '0'; 
				RF_WrEn	<='1';
				PC_LdEn	<= '1';
				RF_WrData_sel <= '1';
			end if;
		end If;	
	end process;

end Behavioral;

