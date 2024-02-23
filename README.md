# Building-a-RISC-V-CPU-Core
Building a RISC-V CPU Core using TL-Verilog 
# CPU Implementation and Plan
*CPUs come in various types, ranging from microcontrollers to desktop and server processors.
*Microcontrollers are optimized for small area and low power consumption.
*Desktop and server processors are optimized for high performance.
*Constructing a CPU core suitable for a microcontroller can be accomplished within several hours.
*A desktop or server CPU chip typically requires a team of hundreds of engineers and several years to develop.
*In our CPU design, each instruction is fully executed within a single clock cycle.
*This approach necessitates a relatively slow clock speed to ensure all work can be completed within a single cycle.
*The initial implementation of the CPU will focus on executing a test program.
*As each piece of functionality is added, progress can be observed in the VIZ pane.
*The goal is to have the test program successfully summing numbers from one to nine.
*After achieving this milestone, additional support for the RV32I instruction set will be implemented.
*The components of the CPU will be examined in the order in which an instruction flows through the logic.

![image](https://github.com/Nithin9741/Building-a-RISC-V-CPU-Core/assets/101901668/b5f0b737-1dd9-4b9f-b94a-19aef0386436)
