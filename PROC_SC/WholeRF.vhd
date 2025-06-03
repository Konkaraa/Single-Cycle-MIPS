----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:23 03/28/2020 
-- Design Name: 
-- Module Name:    WholeRF - Behavioral 
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
library work;
use work.regarray_type.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WholeRF is
    Port ( Adr1 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Awr 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Din 	: in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn 	: in  STD_LOGIC;
           Clk 	: in  STD_LOGIC;
           Rst 	: in  STD_LOGIC;
           Dout1 	: out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 	: out  STD_LOGIC_VECTOR (31 downto 0));
end WholeRF;

architecture Behavioral of WholeRF is
 component RF is
 port		 (CLK 	: in  STD_LOGIC;
           RST 	: in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           WE 		: in  STD_LOGIC;
           Dataout: out  STD_LOGIC_VECTOR (31 downto 0));
 end component;

 component Decoder_5_32 is
 port		(Awr 			: in  STD_LOGIC_VECTOR (4 downto 0);
			 dec_output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

 Component MUX32 is
    Port (Registers  : in regarray;
			 Ard 	  		: in  STD_LOGIC_VECTOR (4 downto 0);
          Rout 	   : out  STD_LOGIC_VECTOR (31 downto 0));
	end Component;		 
			 
			 
 Signal temp1		  : STD_LOGIC_VECTOR (31 downto 0);
 SIGNAL arraymuxsig : regarray;
 SIGNAL we  		  : STD_LOGIC_VECTOR(31 DOWNTO 0);


 begin

 Dec: Decoder_5_32
 PORT MAP(Awr=> Awr,
			 dec_output=>temp1  );

 Register0 : RF --The first Register R(0) is always zero
 Port Map (CLK  => Clk, 
			  RST=>Rst,
	   	  Datain  => "00000000000000000000000000000000",
		     WE   => '1',
			  Dataout => arraymuxsig(0));

 GEN_RF:  --Creating the resr Registers
	for i in 1 to 31 generate 
		we(i)<=WrEn AND temp1(i) after 2 ns;
			Generate_RF: RF 
			port map	(CLK=>Clk,
						 RST=>Rst,
						 Datain=>Din,
						 WE=>we(i),
						 Dataout=>arraymuxsig(i));
	end generate GEN_RF ;

 mux32x1: MUX32 
 Port Map(Registers=>arraymuxsig,
			 Ard=>Adr1,
			 Rout=>Dout1); 
									
 mux32x2: MUX32 
 Port Map(Registers=>arraymuxsig,
			 Ard=>Adr2,
			 Rout=>Dout2 );										
	
	
end Behavioral;

