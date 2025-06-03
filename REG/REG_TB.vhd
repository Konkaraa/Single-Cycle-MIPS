--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:01:19 04/12/2020
-- Design Name:   
-- Module Name:   /home/ise/Desktop/hry312ex1/REG_TB.vhd
-- Project Name:  hry312ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY REG_TB IS
END REG_TB;
 
ARCHITECTURE behavior OF REG_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         CLK 		: IN  std_logic;
         RST 		: IN  std_logic;
         Datain 	: IN  std_logic_vector(31 downto 0);
         WE 		: IN  std_logic;
         Dataout  : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK 		: std_logic := '0';
   signal RST 		: std_logic := '0';
   signal Datain  : std_logic_vector(31 downto 0) := (others => '0');
   signal WE 		: std_logic := '0';

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          CLK => CLK,
          RST => RST,
          Datain => Datain,
          WE => WE,
          Dataout => Dataout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		--Reset the Register
      RST<='1'; 
		WE<='0';
		Datain<="00000000000000000000000000000001";
      wait for 100 ns;	--Dont write cause WE
		RST<='0';
		WE<='0';
		Datain<="00000000000000000000000000000011";
      wait for 100 ns; --Start writing in Register-> Datain
		RST<='0';
		WE<='1';
		Datain<="00000000000000000000000000000011";
		wait for 100 ns;
		RST<='0';
		WE<='1';
		Datain<="00000000000000000001000111000011";
    

      wait;
   end process;

END;
