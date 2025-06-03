To implement the Control stage, we utilized the Opcode of each instruction.
As can be observed, each Opcode is unique to its corresponding instruction — except for the special case of the Opcode "100000", which refers to operations executed by the Arithmetic Logic Unit (ALU) and requires an additional 6-bit control signal called Func.

Each unique Func signal corresponds to a specific operation listed in the control table.
To execute each instruction, certain actions are required, as detailed in the aforementioned table. These actions involve activating the appropriate control signals based on the instruction type.

Summary
The execution of each instruction is determined first by the Opcode, and then, if necessary, by the Func field.

Based on these fields, the corresponding control signals are activated, enabling the correct operations to be carried out for each instruction.

Implementation in Xilinx
To implement the Control stage in the Xilinx environment, the if...else technique was used to handle the decoding and assignment of control signals based on the Opcode and, where needed, the Func field.

