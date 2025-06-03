--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:15:22 03/30/2020
-- Design Name:   
-- Module Name:   /home/ise/Desktop/hry312ex1/WholeRF_TB.vhd
-- Project Name:  hry312ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WholeRF
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
 
ENTITY WholeRF_TB IS
END WholeRF_TB;
 
ARCHITECTURE behavior OF WholeRF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WholeRF
    PORT(
         Adr1	: IN  std_logic_vector(4 downto 0);
         Adr2	: IN  std_logic_vector(4 downto 0);
         Awr 	: IN  std_logic_vector(4 downto 0);
         Din 	: IN  std_logic_vector(31 downto 0);
         WrEn	: IN  std_logic;
         Clk	: IN  std_logic;
         Rst 	: IN  std_logic;
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Adr1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Adr2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr  : std_logic_vector(4 downto 0) := (others => '0');
   signal Din  : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk  : std_logic := '0';
   signal Rst  : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WholeRF PORT MAP (
          Adr1 => Adr1,
          Adr2 => Adr2,
          Awr => Awr,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
          Rst => Rst,
          Dout1 => Dout1,
          Dout2 => Dout2
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
   begin		--Reset the Whole Rf
		Adr1 <= "01000";
		Adr2 <= "00010";
		Awr  <= "00101";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '0';
		Rst  <= '1';
		wait for 100 ns;--Dont write since WrEn=0
		Adr1 <= "01000";
		Adr2 <= "00010";
		Awr  <= "00101";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '0';
		Rst  <= '0';
      wait for 100 ns;--Write in Register but there is not Adr
		Awr  <= "00101";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '1';
      wait for 100 ns;--Write in the Register and  have both Out1,Out2 with the same Din 
		Adr1 <= "00100";
		Awr  <= "00100";
		Adr2 <= "00100";
		Din  <= "00000011110001010101100000000111";
		WrEn <= '1';
      wait for 100 ns;--Have different Address in the Outs
		Adr2 <= "00101";
		Adr1 <= "00100";
		WrEn <= '1';
		Din  <= "00000011110001010101100000000111";
      wait for 100 ns;--Keeping the same Out2 and Changing the Out1 
		Adr1 <= "00011";
		Awr  <= "00011";
		Din  <= "11111111110001010101100000000111";
		WrEn <= '1';
      wait for 100 ns;
		Adr1 <= "00000";
		Awr  <= "00000";
		Din  <= "11111111110001010101100000000111";
		WrEn <= '1';
      wait;
   end process;

END;
