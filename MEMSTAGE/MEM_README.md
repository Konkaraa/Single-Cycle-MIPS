For the implementation of the Memory Access (MEM) stage, the following were used:

A 1-bit control signal (ByteOp) to select between lw/sw (0) and lb/sb (1),

A 1-bit control signal (Mem_WrEn) for enabling memory write,

Two 32-bit input signals (MEM_Addr and MEM_DataIn), and

A 32-bit input signal (MM_RdData), which received memory addresses from the ROM (Rom Data) and passed them as input to the MEM stage.

There were two key implementations in this stage:

At the input (ALU_MEM_Addr), an offset of 0x400 (1024) was added, resulting in a 32-bit output (MM_Addr) that was increased by 0x400 (1024).

When the control signal (ByteOp) was set to 1, the 32-bit output (MEM_DataOut) would only take the first 8 bits (bits 0–7), and the rest would be filled with zeros (Zero Filling).

The other two 32-bit outputs (MM_WrEn and MM_WrData) remained unchanged. In general, all output signals to the RAM provided the necessary addresses so that the processor could determine whether to perform a Load or Store operation in memory.

To implement the Memory Access (MEM) stage in the Xilinx environment, the if...else technique was used along with the port mapping method to properly connect the generated circuits.