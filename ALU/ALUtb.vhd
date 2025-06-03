--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:20:15 03/10/2020
-- Design Name:   
-- Module Name:   /home/ise/Desktop/hry312ex1/ALUtb.vhd
-- Project Name:  hry312ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALUtb IS
END ALUtb;
 
ARCHITECTURE behavior OF ALUtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(32 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(32 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      A<="00000000000000001101010111010101";
		B<="00000000000000001101010111010101";
		Op<="0000";
      wait for 100 ns;	
		A<="00000000000000001101010111010101";
		B<="00000000000000001101010111010101";
		Op<="0001";
      wait for 100 ns;

      A<="00000000000000001101010111010101";
		B<="00000000000000001101010111010101";
		Op<="1000"; 
		wait for 100 ns;

      A<="00000000000000001101010111010101";
		B<="00000000000000001101010111010101";
		Op<="1100"; 
      wait;
   end process;

END;
