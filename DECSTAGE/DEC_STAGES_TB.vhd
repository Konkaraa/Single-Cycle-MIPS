LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DEC_STAGES_TB IS
END DEC_STAGES_TB;
 
ARCHITECTURE behavior OF DEC_STAGES_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGES
    PORT(
			  Instr 			 : in  STD_LOGIC_VECTOR (31 downto 0);
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
           RF_B 			 : out  STD_LOGIC_VECTOR (31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr 			: std_logic_vector(31 downto 0) := (others => '0');
	signal ALU_out  		: std_logic_vector(31 downto 0) := (others => '0');
	signal MEM_out  		: std_logic_vector(31 downto 0) := (others => '0');
   signal ImmExt  		: std_logic_vector(1 downto 0) := (others => '0');
	signal RF_WrEn 		: std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
	signal RF_WrData_sel2: std_logic := '0';
   signal RF_B_sel 		: std_logic := '0';
   signal Clk 				: std_logic := '0';
	signal Rst 				: std_logic := '0';

 	--Outputs
   signal Immed  : std_logic_vector(31 downto 0);
	signal  RF_A  : std_logic_vector(31 downto 0);
	signal RF_B   : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGES PORT MAP (
          Instr => Instr,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          ImmExt => ImmExt,
          Clk => Clk,
			 Rst=>Rst,
          RF_WrEn => RF_WrEn,
			 RF_WrData_sel=>RF_WrData_sel,
			 RF_WrData_sel2=>RF_WrData_sel2,
			 RF_B_sel =>RF_B_sel,
		    Immed => Immed,
		    RF_A => RF_A,
			 RF_B =>RF_B
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
    begin	--Reset for one cycle clock
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="100000" & "00010" & "00010" & "00100" & "00000" & "000000";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000011";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';--ALU
		RF_WrData_Sel2<='1';--Mux_out1
		RF_B_Sel<='1';--Instr(20-16)
		ImmExt<="00";--SingExt
		Rst<='1';
		wait for 100 ns;--Taking address only the Out RF_A
      -- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="100000" & "00001" & "00001" & "10010" & "00100" & "000000";
		RF_WrEn<='1';
		ALU_out<="00000000000100000010000000000001";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_WrData_Sel2<='1';
		RF_B_Sel<='0';--Instr(15-11)
		ImmExt<="00";
		Rst<='0';
      wait for 100 ns;--Taking address both Outs RF_A,RF_B
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="100000" & "00010" & "00010" & "00100" & "00000" & "000000";
		RF_WrEn<='1';
		ALU_out<="00000000000000000000000000000011";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_WrData_Sel2<='1';
		RF_B_Sel<='1';
		ImmExt<="00";
		Rst<='0';
      wait for 100 ns;--Giving the address of the memory but they keep their previous address 
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="110010" & "00001" & "00010" & "10000" & "00100" & "000110";
		RF_WrEn<='0';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="00000000110000000000000000000011";
		RF_WrData_Sel<='1';--MEM
		RF_WrData_Sel2<='1';
		RF_B_Sel<='1';
		ImmExt<="01";--ZeroFilling
		Rst<='0';
      wait for 100 ns;--Dont write in Registers since RF_WE=0
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="111001" & "10000" & "10000" & "10000" & "00011" & "000011";
		RF_WrEn<='0';
		ALU_out<="00000000011110000000000000000000";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_WrData_Sel2<='1';
		RF_B_Sel<='1'; 
		ImmExt<="10";--Shifting 16 and Zerofilling the rest
		Rst<='0';
       wait for 100 ns;
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="111001" & "10000" & "10000" & "10000" & "00011" & "000011";
		RF_WrEn<='1';
		ALU_out<="00000000011110000000000000000000";
		MEM_out<="00000000000000000000000000000000";
		RF_WrData_Sel<='0';
		RF_WrData_Sel2<='1';
		RF_B_Sel<='1'; 
		ImmExt<="10";
		Rst<='0';
      wait;
   end process;

END;
