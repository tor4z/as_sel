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

The flags is divided into three groups base on function:

* Status flags
* Control flags
* System flags

#### Status flags

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


### .string vs .ascii vs .asciz

* .ascii "string"...

.ascii expects zero or more string literals separated by commas. It assembles each string (with no automatic trailing zero byte) into consecutive addresses.

* .asciz "string"...

.asciz is just like .ascii, but each string is followed by a zero byte. The "z" in `.asciz' stands for "zero".

* .string "str"

Copy the characters in str to the object file. You may specify more than one string to copy, separated by commas.
Unless otherwise specified for a pafffrticular machine, the assembler marks the end of each string with a 0 byte.
You can use any of the escape sequences described in section Strings.

[See more](http://web.mit.edu/gnu/doc/html/as_7.html)

### Instruction names

Instruction names usually end in either "l", "w", or "b", indicating the size of the operands: long (32 bits), word (16 bits), or byte (8 bits),
respectively. For our purposes, we will usually be using the "l" (long) suffix. [See more](http://www.hep.wisc.edu/~pinghc/x86AssmTutorial.htm)

### The directive used to reserve memory for specific type of data element

|Directive| 	Data Type|
|:--------|:-----------------------|
|.ascii |	Text string |
|.asciz| 	Null-terminated text string |
|.byte| 	Byte value |
|.double| 	Double-precision floating-point number |
|.float| 	Single-precision floating-point number |
|.int| 	 	32-bit integer number |
|.long| 	32-bit integer number (same as .int) |
|.octa| 	16-byte integer number |
|.quad| 	8-byte integer number |
|.short| 	16-bit integer number |
|.single| 	Single-precision floating-point number (same as .float) |
|.fill|		Enable assembly to automatically create specific byte of data element for you|


### The directive to declare buffer in .bss section

|Directive|  Description |
|:--------|:-------------|
|.comm|   Declares a common memory area for data that is not initialized |
|.lcomm|  Declares a local common memory area for data that is not initialized |



