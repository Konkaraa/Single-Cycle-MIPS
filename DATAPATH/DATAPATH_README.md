Initially, the purpose of the Datapath stage is to properly connect IF, DEC ,EX, MEM stages together.
Regarding the Instruction Fetch (IF) stage, it remains untouched — it is not connected to any other stage at this point. It will only be involved during the final integration.

In contrast, the Instruction Decode (DECODE) stage is connected to both the Execution (EX) stage and the Memory Access (MEM) stage as follows:

The three 32-bit output signals from the DECODE stage (RF_A, RF_B, Immed) become:

Input signals of the same names for the EX stage (RF_A, RF_B, Immed), and

The 32-bit MEM_DataIn input for the MEM stage.

Additionally:

The 32-bit ALU_out output from the EX stage becomes:

A 32-bit input ALU_out back to the DECODE stage, and

A 32-bit ALU_MEM_Addr input for the MEM stage.

Finally:

The 32-bit MEM_DataOut output from the MEM stage becomes a 32-bit MEM_out input for the DECODE stage.

This completes the Datapath, excluding the control signals that will be integrated later from the Control Unit in the final stage.

For the implementation of the Datapath stage in the Xilinx environment, the Port Mapping technique was used to appropriately interconnect the generated circuit components.