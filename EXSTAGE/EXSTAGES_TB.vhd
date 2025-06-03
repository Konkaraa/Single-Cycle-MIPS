--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:11:22 04/04/2020
-- Design Name:   
-- Module Name:   /home/ise/Desktop/hry312ex1/EXSTAGES_TB.vhd
-- Project Name:  hry312ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXSTAGES
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
 
ENTITY EXSTAGES_TB IS
END EXSTAGES_TB;
 
ARCHITECTURE behavior OF EXSTAGES_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGES
    PORT(
         RF_A 			: IN  std_logic_vector(31 downto 0);
         RF_B 			: IN  std_logic_vector(31 downto 0);
         Immed 		: IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func 	: IN  std_logic_vector(3 downto 0);
         ALU_out 		: OUT  std_logic_vector(31 downto 0);
         ALU_zero 	: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A 		: std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B 		: std_logic_vector(31 downto 0) := (others => '0');
   signal Immed 		: std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel: std_logic := '0';
   signal ALU_func 	: std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out  : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGES PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero
        );

  

   -- Stimulus process
   stim_proc: process
    begin	--Adding with carry out	and overflow
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "01000000000000000000000001000010";
		Immed <= "01000000000000000000000001000011";
		ALU_Bin_Sel <= '0';--RF_B
		ALU_func <= "0000";
		wait for 100 ns;-- Subbing with zero result
		RF_A  <= "01000000000000000000000000000000";
		RF_B  <= "01000000000000000000000000000000";
		Immed <= "11000000000000000000000000000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0001";
		wait for 100 ns;-- Subbing with carry out and overflow
		RF_A  <= "10000000000000000000000000000000";
		RF_B  <= "01000000000000000000000001000010";
		Immed <= "01000000000000000000000000000000";
		ALU_Bin_Sel <= '1';--Immed
		ALU_func <= "0001";
		wait for 100 ns;-- Doing And
		RF_A  <= "11000000000000000000000000000011";
		RF_B  <= "11000000000000000000000000000011";
		Immed <= "01000000000000000000000000000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0010";
		wait for 100 ns;--Doing Nand
		RF_A  <= "11000000000000000000000000000011";
		RF_B  <= "11000000000000000000000000000011";
		Immed <= "01000000000000000000000000000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0101";
		wait for 100 ns;--Doing Nor
		RF_A  <= "11000000000000000000000000000011";
		RF_B  <= "11000000000000000000000000000011";
		Immed <= "01000000000000000000000000000000";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0110";
      wait;
   end process;

END;
