For the implementation of the Instruction Decode (DECODE) stage, a 32-bit input signal (Instr) was used, which was divided into the following parts: Instr(15:0), Instr(15:11), Instr(20:16), Instr(25:21), and Instr(31:26). The Instr(31:26) bits will be used in Phase 3 to activate the Control Unit as the OpCode input. The Instr(25:21) bits serve as an address input (Adr1) to the Register File, while the second address input (Adr2) is selected by a 2-to-1 multiplexer (Multiplexer), based on a 1-bit control signal (RF_sel). The inputs to this multiplexer are Instr(15:11) and Instr(20:16).

The Instr(20:16) bits are also used as the register write address (Awr). The Instr(15:0) bits are passed into a submodule (referred to as a "cloud") that performs one of the following operations, depending on a 2-bit control signal (ImmExt):

Sign Extend – uses the 15th bit of Instr to fill bits 16–31 with either 1s or 0s,

Zero Fill – fills bits 16–31 with zeros,

Shift Left 16 Bits – places Instr(15:0) in bits 16–31 and fills bits 0–15 with zeros,

No Operation – all bits set to zero.

This process outputs a 32-bit signal called Immed.

Next, a 2-to-1 multiplexer (Multiplexer) is used with a 1-bit control signal (RF_WrData_sel1), taking as inputs two 32-bit signals (ALU_out and MEM_out), and producing a temporary 32-bit signal (Mux_out1). For convenience in Phase 3 of the lab project, an additional 2-to-1 multiplexer (Multiplexer) was implemented, controlled by a 1-bit signal (RF_WrData_sel2). Its inputs are the 32-bit signals Immed and Mux_out1, and its output is a temporary 32-bit signal (Mux_out2), which functions as the 32-bit input signal (Din).

Ultimately, two 32-bit output signals (RF_A and RF_B) are produced, representing the final output values. In general, based on the control signals provided, the corresponding fields of the instruction (Instr) are selected and used as input to the Register File, and through appropriate addressing, the final outputs are determined.

To implement the Instruction Decode (DECODE) stage in the Xilinx environment, the when others technique was used for the conditional logic of the multiplexers, the port mapping method was used for the proper connection of generated circuits, and the following libraries were utilized: use IEEE.STD_LOGIC_1164.ALL, library work, and use work.regarray_type.all.