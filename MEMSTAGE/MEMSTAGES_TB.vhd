--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:45:53 04/06/2020
-- Design Name:   
-- Module Name:   /home/ise/Desktop/hry312ex1/MEMSTAGES_TB.vhd
-- Project Name:  hry312ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGES
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEMSTAGE_TB IS
END MEMSTAGE_TB;
 
ARCHITECTURE behavior OF MEMSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGES
    PORT(
         ByteOp 		: IN  std_logic;
			Clk 			: IN  std_logic;
         Mem_WrEn 	: IN  std_logic;
         MM_RdData 	: IN  std_logic_vector(31 downto 0);
			ALU_MEM_Addr: IN  std_logic_vector(31 downto 0);
         MEM_DataIn 	: IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_Addr 		: OUT  std_logic_vector(31 downto 0);
         MM_WrEn	 	: OUT  std_logic;
         MM_WrData 	: OUT  std_logic_vector(31 downto 0)   
        );
    END COMPONENT;
    

   --Inputs
   signal ByteOp   		: std_logic := '0';
	signal Clk 			   : std_logic := '0';
   signal Mem_WrEn 		: std_logic := '0';
   signal ALU_MEM_Addr  : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn 	: std_logic_vector(31 downto 0) := (others => '0');
	
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_Addr 	 : std_logic_vector(31 downto 0);
   signal MM_WrEn 	 : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGES PORT MAP (
          ByteOp => ByteOp,
			 Clk => Clk,
			 MM_RdData=>MM_RdData,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData
      
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 


   -- Stimulus process
   stim_proc: process
      begin--Choosing to Sw/Lw
        ByteOp<='0';
        Mem_WrEn<='0';
        MEM_DataIn  <="00000000000000000000000000000100";
        ALU_MEM_Addr<="00000000000000000000001111111111";
		  MM_RdData   <="00000000000000000000001111111111";
		  wait for 100 ns;
        ByteOp<='0';
        Mem_WrEn<='0';
        MEM_DataIn  <="00000000000000000000000000000010";
        ALU_MEM_Addr<="00000000000000000000000000001110";
		  MM_RdData   <="00000000000000000000001111111000";
        wait for 100 ns;--Writing in the Mem
        ByteOp<='0';
        Mem_WrEn<='1';
        MEM_DataIn  <="00000000000000000000000001110000";
        ALU_MEM_Addr<="00000000000011100000000010101000";
		  MM_RdData   <="00000000000000000000000001111111";
		  wait for 100 ns;--Choosing to Sb/Lb
        ByteOp<='1';
        Mem_WrEn<='1';
        MEM_DataIn  <="00000000000000000000000001110000";
        ALU_MEM_Addr<="00000000000011100000000010101000"; 
		  MM_RdData   <="00000000000000000000001111111111";
		  wait for 100 ns;--Choosing to Sb/Lb
        ByteOp<='1';
        Mem_WrEn<='1';
        MEM_DataIn  <="00000000000000000000000001110000";
        ALU_MEM_Addr<="00000000000011100000000010101000"; 
		  MM_RdData   <="00000000000000000000000000011111";
      wait;
   end process;

END;
