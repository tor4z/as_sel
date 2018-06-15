# IA32 Assembly SEL

## Quick note

### Registers

| Register | Description|
|:---------------------:|:------------:|
|General purpose	|Eight 32-bit registers used for storing working data|
|Segment 	        |Six 16-bit registers used for handling memory access
|Instruction pointer	|A single 32-bit register pointing to the next instruction code to execute|
|Floating-point	data	|Eight 80-bit registers used for floating-point arithmetic data |
|Control 		|Five 32-bit registers used to determine the operating mode of the processor |
|Debug 			|Eight 32-bit registers used to contain information when debugging the processor |


### General-purpose registers

|Register| 	Description |
|:------:|:----------------:|
|EAX| 	Accumulator for operands and results data |
|EBX| 	Pointer to data in the data memory segment |
|ECX| 	Counter for string and loop operations |
|EDX| 	I/O pointer |
|EDI| 	Data pointer for destination of string operations |
|ESI| 	Data pointer for source of string operations |
|ESP|	Stack pointer |
|EBP| 	Stack data pointer |


### Segment Registers

|Segment|	Register| 	Description |
|:------:|:------------:|:----------------:|
|CS| 		Code segment |
|DS|		Data segment |
|SS| 		Stack segment |
|ES| 		Extra segment pointer |
|FS| 		Extra segment pointer |
|GS| 		Extra segment pointer |


### Control Regisers

|Control Register| 	Description |
|:---------------:|:----------------:|
|CR0| 		System flags that control the operating mode and states of the processor |
|CR1| 		Not currently used |
|CR2| 		Memory page fault information |
|CR3| 		Memory page directory information |
|CR4| 		Flags that enable processor features and indicate feature capabilities of the processor |


### Flags

|Flag|  Bit|  Name |
|:----:|:-----:|:------:|
|CF|  0|  Carry flag |
|PF|  2|  Parity flag |
|AF|  4|  Adjust flag |
|ZF|  6|  Zero flag |
|SF|  7|  Sign flag |
|OF|  11|  Overflow flag |

###  three different methods of accessing system memory

* Flat memory model: The flat memory model presents all system memory as a contiguous address space. All instructions,
data, and the stack are contained in the same address space. Each memory location is accessed by a spe-
cific address, called a linear address.

* Segmented memory model: The segmented memory model divides the system memory into groups of independent segments, refer-
enced by pointers located in the segment registers. Each segment is used to contain a specific type of
data. One segment is used to contain instruction codes, another data elements, and a third the program
stack.

* Real-address mode: Memory locations in segments are defined by logical addresses. A logical address consists of a segment
address and an offset address. The processor translates a logical address to a corresponding linear
address location to access the byte of memory.


