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

1. Logic
This logic is responsible for the program counter (PC). The PC identifies the instruction our CPU will execute next. Most instructions execute sequentially, meaning the default behavior of the PC is to increment to the following instruction each clock cycle. Branch and jump instructions, however, are non-sequential. They specify a target instruction to execute next, and the PC logic must update the PC accordingly.
2.Fetch
The instruction memory (IMem) holds the instructions to execute. To read the IMem, or "fetch", we simply pull out the instruction pointed to by the PC.
3.Decode Logic
Now that we have an instruction to execute, we must interpret, or decode, it. We must break it into fields based on its type. These fields would tell us which registers to read, which operation to perform, etc.
4.Register File Read
The register file is a small local storage of values the program is actively working with. We decoded the instruction to determine which registers we need to operate on. Now, we need to read those registers from the register file.
5.Arithmetic Logic Unit (ALU)
Now that we have the register values, it’s time to operate on them. This is the job of the ALU. It will add, subtract, multiply, shift, etc, based on the operation specified in the instruction.
6.Register File Write
Now the result value from the ALU can be written back to the destination register specified in the instruction.
7.DMem
Our test program executes entirely out of the register file and does not require a data memory (DMem). But no CPU is complete without one. The DMem is written to by store instructions and read from by load instructions.
