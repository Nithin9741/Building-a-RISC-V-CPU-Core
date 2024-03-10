# Building-a-RISC-V-CPU-Core
Building a RISC-V CPU Core using TL-Verilog 
# CPU Implementation and Plan
- CPUs come in various types, ranging from microcontrollers to desktop and server processors.
- Microcontrollers are optimized for small area and low power consumption.
- Desktop and server processors are optimized for high performance.
- Constructing a CPU core suitable for a microcontroller can be accomplished within several hours.
- A desktop or server CPU chip typically requires a team of hundreds of engineers and several years to develop.
- In our CPU design, each instruction is fully executed within a single clock cycle.
- This approach necessitates a relatively slow clock speed to ensure all work can be completed within a single cycle.
- The initial implementation of the CPU will focus on executing a test program.
- As each piece of functionality is added, progress can be observed in the VIZ pane.
- The goal is to have the test program successfully summing numbers from one to nine.
- After achieving this milestone, additional support for the RV32I instruction set will be implemented.
- The components of the CPU will be examined in the order in which an instruction flows through the logic.


![image](https://github.com/Nithin9741/Building-a-RISC-V-CPU-Core/assets/101901668/b5f0b737-1dd9-4b9f-b94a-19aef0386436)

1. **Logic:** This logic is responsible for the program counter (PC). The PC identifies the instruction our CPU will execute next. Most instructions execute sequentially, meaning the default behavior of the PC is to increment to the following instruction each clock cycle. Branch and jump instructions, however, are non-sequential. They specify a target instruction to execute next, and the PC logic must update the PC accordingly.
   
2. **Fetch:** The instruction memory (IMem) holds the instructions to execute. To read the IMem, or "fetch", we simply pull out the instruction pointed to by the PC.
   
3. **Decode Logic:** Now that we have an instruction to execute, we must interpret, or decode, it. We must break it into fields based on its type. These fields would tell us which registers to read, which operation to perform, etc.
   
4. **Register File Read:** The register file is a small local storage of values the program is actively working with. We decoded the instruction to determine which registers we need to operate on. Now, we need to read those registers from the register file.
   
5. **Arithmetic Logic Unit (ALU):** Now that we have the register values, it’s time to operate on them. This is the job of the ALU. It will add, subtract, multiply, shift, etc., based on the operation specified in the instruction.
   
6. **Register File Write:** Now the result value from the ALU can be written back to the destination register specified in the instruction.
   
7. **DMem:** Our test program executes entirely out of the register file and does not require a data memory (DMem). But no CPU is complete without one. The DMem is written to by store instructions and read from by load instructions.

Designing the basic processor of 3 stages fetch, decode and execute based on RISC-V ISA.

1. **Fetch**

   Designing the basic processor of 3 stages fetch, decode and execute based on RISC-V ISA.
   * Program Counter (PC): Holds the address of next Instruction
   * Instruction Memory (IM): Holds the set of instructions to be executed
   fetching instructions from memory based on the program counter value and controlling the instruction memory read operation.

  ![Screenshot (3)](https://github.com/Nithin9741/Building-a-RISC-V-CPU-Core/assets/101901668/7f97958f-ec8d-4ee2-aa6b-c0ab22f22f50)
  
3. **Decode**

 There are 6 types of Instructions:

- R-type - Register
- I-type - Immediate
- S-type - Store
- B-type - Branch (Conditional Jump)
- U-type - Upper Immediate
- J-type - Jump (Unconditional Jump)
- Instruction Format includes Opcode, immediate value, source address, destination address. During Decode Stage, processor decodes the instruction based on instruction format and type of instruction.

Below is snapshot from Makerchip IDE after performing the Decode Stage.

![Screenshot (4)](https://github.com/Nithin9741/Building-a-RISC-V-CPU-Core/assets/101901668/84a6b25a-b752-4559-8b4a-610c4a932b81)

3. **Register File Read and Write**

Here the Register file is 2 read, 1 write means 2 read and 1 write operation can happen simultanously.

Inputs:
- Read_Enable - Enable signal to perform read operation
- Read_Address1 - Address1 from where data has to be read
- Read_Address2 - Address2 from where data has to be read
- Write_Enable - Enable signal to perform write operation
- Write_Address - Address where data has to be written
- Write_Data - Data to be written at Write_Address

Outputs:
- Read_Data1 - Data from Read_Address1
- Read_Data2 - Data from Read_Address2

4. **Execute**

During the Execute Stage, both the operands perform the operation based on Opcode.

Below is snapshot from Makerchip IDE after performing the Execute Stage.

![Screenshot (5)](https://github.com/Nithin9741/Building-a-RISC-V-CPU-Core/assets/101901668/8594bd30-ce41-46b6-b2a0-e60023afd25a)

5. **Control Logic**

During Decode Stage, branch target address is calculated and fed into PC mux. Before Execute Stage, once the operands are ready branch condition is checked.

Below is snapshot from Makerchip IDE after including the control logic for branch instructions.
 
 ![Screenshot (6)](https://github.com/Nithin9741/Building-a-RISC-V-CPU-Core/assets/101901668/290c9edd-8014-42a1-8d72-b613a754bb0b)

6. **Load and store instructions and memory**

Similar to branch, load will also have 3 cycle delay. So, added a Data Memory 1 write/read memory.

Inputs:

- Read_Enable - Enable signal to perform read operation
- Write_Enable - Enable signal to perform write operation
- Address - Address specified whether to read/write from
- Write_Data - Data to be written on Address (Store Instruction)
Output:

- Read_Data - Data to be read from Address (Load Instruction)

7.**Completing the RISC-V CPU**.
Added Jumps and completed Instruction Decode and ALU for all instruction present in RV32I base integer instruction set.

Below is final Snapshot of Complete Pipelined RISC-V CPU.

![Screenshot (2)](https://github.com/Nithin9741/Building-a-RISC-V-CPU-Core/assets/101901668/e64deb6e-86e9-4542-a1c4-777835eab54f)

**Acknowledge**

[Steve Hoover](https://github.com/stevehoover), Founder, Redwood EDA





