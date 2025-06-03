--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:19:45 04/10/2020
-- Design Name:   
-- Module Name:   /home/ise/Desktop/hry312ex1/CONTROL_TB.vhd
-- Project Name:  hry312ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
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
 
ENTITY CONTROL_TB IS
END CONTROL_TB;
 
ARCHITECTURE behavior OF CONTROL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         ZERO 		 		: IN  std_logic;
         INSTRUCTION 	: IN  std_logic_vector(31 downto 0);
         ByteOp 			: OUT  std_logic;
         Reset 			: IN  std_logic;
         PC_Reset 		: OUT  std_logic;
         MeM_WrEn 		: OUT  std_logic;
         PC_LdEn 			: OUT  std_logic;
         PC_Sel 			: OUT  std_logic;
         RF_WrEn 			: OUT  std_logic;
         RF_WrData_sel 	: OUT  std_logic;
         RF_WrData_sel2 : OUT  std_logic;
         RF_B_sel 		: OUT  std_logic;
         ALU_Bin_sel 	: OUT  std_logic;
         ALU_func 		: OUT  std_logic_vector(3 downto 0);
         ImmExt 			: OUT  std_logic_vector(1 downto 0);
         Clk 				: IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ZERO 		 : std_logic := '0';
   signal INSTRUCTION : std_logic_vector(31 downto 0) := (others => '0');
   signal Reset 		 : std_logic := '0';
   signal Clk 			 : std_logic := '0';

 	--Outputs
   signal ByteOp 	 		: std_logic;
   signal PC_Reset 		: std_logic;
   signal MeM_WrEn 		: std_logic;
   signal PC_LdEn  		: std_logic;
   signal PC_Sel 	 		: std_logic;
   signal RF_WrEn  		: std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_WrData_sel2: std_logic;
   signal RF_B_sel 		: std_logic;
   signal ALU_Bin_sel 	: std_logic;
   signal ALU_func 		: std_logic_vector(3 downto 0);
   signal ImmExt 			: std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          ZERO => ZERO,
          INSTRUCTION => INSTRUCTION,
          ByteOp => ByteOp,
          Reset => Reset,
          PC_Reset => PC_Reset,
          MeM_WrEn => MeM_WrEn,
          PC_LdEn => PC_LdEn,
          PC_Sel => PC_Sel,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_WrData_sel2 => RF_WrData_sel2,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ImmExt => ImmExt,
          Clk => Clk
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
   begin--Reset		
    ZERO <= '0';
    INSTRUCTION <= "1100"&"0000"&"0000"&"0101"&"0000"&"0000"&"0000"&"1000";
    Reset<= '1';
	 wait for 100 ns;--Addi
	 ZERO <= '0';
    INSTRUCTION <= "1100"&"0000"&"0000"&"0101"&"0000"&"0000"&"0000"&"1000";
    Reset<= '0';
	 wait for 100 ns;--Ori
	 ZERO <= '0';
    INSTRUCTION <= "1100"&"1100"&"0000"&"0011"&"1010"&"1011"&"1100"&"1101";
    Reset<= '0';
	 wait for 100 ns;--Sw
	 ZERO <= '0';
    INSTRUCTION <= "0111"&"1100"&"0000"&"0011"&"0000"&"0000"&"0000"&"0100";
    Reset<= '0';
	 wait for 100 ns;--Lw
	 ZERO <= '0';
    INSTRUCTION <= "0011"&"1100"&"1010"&"1010"&"1111"&"1111"&"1111"&"1100";
    Reset<= '0';	 
	 wait for 100 ns;--Bne
	 ZERO <= '0';
    INSTRUCTION <= "0000"&"0100"&"1010"&"0101"&"0000"&"0000"&"0000"&"1000";
    Reset<= '0';	     
      wait;
   end process;

END;
