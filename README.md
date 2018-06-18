# IA32 Assembly SEL

## Quick note


### Compile and Link

Compile 32-bit assembly source on 64-bit platform
```bash
as -o output source.s --32
```

Link 32-bit object file with ld in 64-bit platform
```bash
# gcc-multilib needed
# sudo apt-get install gcc-multilib
ld -dynamic-linker /lib/ld-linux.so.2 -o outout object.o -m elf_i386 -lc  # Used libc
```
Compile assembly source with gcc
```
gcc -o output source.s -m32	# compile 32-bit elf in 64-bit platform
```

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
```
b = byte (8 bit)
s = short (16 bit integer) or single (32-bit floating point)
w = word (16 bit)
l = long (32 bit integer or 64-bit floating point)
q = quad (64 bit)
t = ten bytes (80-bit floating point)
```
[See also](https://stackoverflow.com/questions/48251829/whats-the-difference-between-push-and-pushq-in-att-assembly)


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



### The unsigned conditional move instruction

|Instruction Pair| 	Description| 	EFLAGS Condition |
|:---------------|:-----------------|:---------------------|
|CMOVA/CMOVNBE| 	Above/not below or equal| 	(CF or ZF) = 0 |
|CMOVAE/CMOVNB| 	Above or equal/not below| 	CF=0 |
|CMOVNC| 		Not carry| 	   		CF=0 |
|CMOVB/CMOVNAE| 	Below/not above or equal| 	CF=1 |
|CMOVC| 		Carry| 	  	   		CF=1 |
|CMOVBE/CMOVNA| 	Below or equal/not above| 	(CF or ZF) = 1 |
|CMOVE/CMOVZ| 		Equal/zero| 	   		ZF=1 |
|CMOVNE/CMOVNZ| 	Not equal/not zero| 		ZF=0 |
|CMOVP/CMOVPE|		Parity/parity even| 		PF=1 |
|CMOVNP/CMOVPO| 	Not parity/parity odd| 		PF=0 |


### The signed conditional move instruction

|Instruction Pair| 	Description| 	EFLAGS Condition |
|:---------------|:-----------------|:---------------------|
|CMOVGE/CMOVNL| 	Greater or equal/not less| 	(SF xor OF)=0 |
|CMOVL/CMOVNGE| 	Less/not greater or equal| 	(SF xor OF)=1 |
|CMOVLE/CMOVNG| 	Less or equal/not greater| 	((SF xor OF) or ZF)=1 |
|CMOVO| 		Overflow| 	  		OF=1 |
|CMOVNO|		Not overflow| 			OF=0 |
|CMOVS| 		Sign (negative)| 		SF=1 |
|CMOVNS| 		Not sign (non-negative)| 	SF=0 |

### CMP & EFLAFGS

The CMP Instruction:

The CMP instruction operates by performing an implied subtraction of the two operands. This means that the result is not stored in memory. After subtracting them, it does a few quick tests, updating the Z,O,C,S, and P flags. The P, or parity, flag is rarely used, so we&#39;ll ignore it in this article for the purpose of brevity.

Binary subtraction is performed by adding the negated version of the second operand from the first. This is just like what you learned in middle school, about how 4+3 = 4 - (-3), and visa versa.
At the end of the article I will explain how this is done, but I&#39;ll move onto the more important matters for now since that knowledge is not really needed for cracking or coding.

Sign and Zero Flag:

The four flags that the CMP instruction can set - Z,O,C, and S, are known as the zero, overflow, carry, and sign flags respectively. The zero flag is set whenever the result of the subtraction is equal to zero. This, of course, only occurs when the operands are equal. The sign flag is set when the result of the subtraction is negative. Although we are inclined to think that this means the sign flag in combination with the zero flag are enough to test all &gt; &gt;= &lt; and &lt;=, this is not true, because the result can be negative even if the first number is greater than the second. This is because of overflow.

Overflow Flag:

Signed integers are represented in binary with the same amount of bits as unsigned integers. This means, of course, that the sign must be set in one of the bits of the integer. Signed integers store the sign in the MSB (most significant bit). This means that, while 00000001 converts to 1 in decimal, 10000001 converts to -127. I will discuss why it is -127 and not -1 or -2 later in the article.
When the processor performs subtraction, It wraps around if the subtraction goes below 00000000 or above 11111111. Therefore, if you subtract a negative number from a positive one, or subtract a positive number from a negative one, there is the possibility that the answer will overflow over the boundary. For example, 100 - (-100) is equal to 200, but the highest value an 8 bit signed integer can be is 127, so 200 will wrap through the upper boundary and end up as a negative number, even though it should be positive. The same problem occurs with -100 - 100; It wraps through the low end and ends up positive when it should be negative, causing an underflow. Note that an underflow also sets the overflow flag, and overflow will refer to both overflows and underflows further in the article. The CPU checks for this, and sets the overflow flag if it occurs.

Carry Flag:

The carry flag is set when, if both operands are interpreted as unsigned integers, the first one is greater. This is easy to determine because it occurs whenever the subtraction passes through 00000000 into the higher range (11111111).
For example, 00000001 - 00000010 = 11111111, so carry is set. However, 00000010 - 00000001 = 00000001, so carry is not set.

[See also](https://www.hellboundhackers.org/articles/read-article.php?article_id=729)

### POPing and PUSHing all the register

|Instruction|  Description |
|:----------|:-------------|
|PUSHA/POPA|  Push or pop all of the 16-bit general-purpose registers |
|PUSHAD/POPAD|  Push or pop all of the 32-bit general-purpose registers |
|PUSHF/POPF|  Push or pop the lower 16 bits of the EFLAGS register |
|PUSHFD/POPFD|  Push or pop the entire 32 bits of the EFLAGS register |

The PUSHA instruction pushes the 16-bit registers so they appear
on the stack in the following order: DI, SI, BP, BX, DX, CX, and finally, AX. The PUSHAD instruction pushes
the 32-bit counterparts of these registers in the same order. The POPA and POPAD instructions retrieve the
registers in the reverse order they were pushed.

### Intel suggests the rules when defining data

* Align 16-bit data on a 16-byte boundary. 
* Align 32-bit data so that its base address is a multiple of four. 
* Align 64-bit data so that its base address is a multiple of eight. 
* Avoid many small data transfers. Instead, use a single large data transfer. 
* Avoid using larger data sizes (such as 80- and 128-bit floating-point values) in the stack. 

 If you have a lot of similarly sized data elements, such as
integer and floating-point values, place them together at the beginning of the data section. This ensures
that they will maintain the proper alignment. If you have a lot of odd-sized data elements, such as
strings and buffers, place those at the end of the data section so they won’t throw off the alignment of
the other data elements.

The gas assembler supports the .align directive, which is used to align defined data elements on spe-
cific memory boundaries. The .align directive is placed immediately before the data definition in the
data section, instructing the assembler to position the data element on a memory boundary.

### Stack in function
```
function_label:
	pushl %ebp
	movl %esp, %ebp
	< normal function code goes here>
	movl %ebp, %esp
	popl %ebp
	ret
```
Once the EBP register has been saved, it can be used as the base pointer to the stack for all access to the
stack within the function. Before returning to the calling program, the ESP register must be restored to
the location pointing to the calling memory location.

### Conditional jump instruction

|Instruction| 	Description| 	EFLAGS |
|:----------|:------------|:------------|
|JA| 	Jump if above| 	CF=0 and ZF=0 |
|JAE| 	Jump if above or equal| 	CF=0 |
|JB| 	Jump if below| 	CF=1 |
|JBE| 	Jump if below or equal| 	CF=1 or ZF=1 |
|JC| 	Jump if carry| 	CF=1 |
|JCXZ| 	Jump if CX register is 0| 	|
|JECXZ| 	Jump if ECX register is 0| 	|
|JE| 	Jump if equal| 	ZF=1 |
|JG| 	Jump if greater| 	ZF=0 and SF=OF |
|JGE| 	Jump if greater or equal| 	SF=OF |
|JL| 	Jump if less| 	SF<>OF |
|JLE| 	Jump if less or equal| 	ZF=1 or SF<>OF |
|JNA| 	Jump if not above| 	CF=1 or ZF=1 |
|JNAE| 	Jump if not above or equal| 	CF=1 |
|JNB| 	Jump if not below| 	CF=0 |
|JNBE| 	Jump if not below or equal| 	CF=0 and ZF=0 |
|JNC| 	Jump if not carry| 	CF=0 |
|JNE| 	Jump if not equal| 	ZF=0 |
|JNG| 	Jump if not greater| 	ZF=1 or SF<>OF |
|JNGE| 	Jump if not greater or equal| 	SF<>OF |
|JNL| 	Jump if not less| 	SF=OF |
|JNLE| 	Jump if not less or equal| 	ZF=0 and SF=OF |
|JNO| 	Jump if not overflow| 	OF=0 |
|JNP| 	Jump if not parity| 	PF=0 |
|JNS| 	Jump if not sign| 	SF=0 |
|JNZ| 	Jump if not zero| 	ZF=0 |
|JO| 	Jump if overflow| 	OF=1 |
|JP| 	Jump if parity| 	PF=1 |
|JPE| 	Jump if parity even| 	PF=1 |
|JPO| 	Jump if parity odd| 	PF=0 |
|JS| 	Jump if sign| 	SF=1 |
|JZ| 	Jump if zero| 	ZF=1 |

### When to set carry flag

* The carry flag is used in mathematical expressions to indicate when an overflow has occurred in an
unsigned number (remember that signed numbers use the overflow flag). The carry flag is set when an
instruction causes a register to go beyond its data size limit.

* The carry flag will also be set when an unsigned value is less than zero.

|Instruction| 	Description |
|:----------|:--------------|
|CLC| 	Clear the carry flag (set it to zero) |
|CMC| 	Complement the carry flag (change it to the opposite of what is set) |
|STC| 	Set the carry flag (set it to one) |


### The loop instruction

The loop instructions use the ECX register as a counter and automatically decrease its value as the loop
instruction is executed.

|Instruction| 	Description |
|:---------|:---------------|
|LOOP|			Loop until the ECX register is zero |
|LOOPE/LOOPZ| 		Loop until either the ECX register is zero, or the ZF flag is not set |
|LOOPNE/LOOPNZ| 	Loop until either the ECX register is zero, or the ZF flag is set |

Before the loop starts, you must set the value for the number of iterations to perform in the ECX register.
This usually looks something like the following:
```
	< code before the loop >
	movl $100, %ecx
loop1:
	< code to loop through >
	loop loop1
	< code after the loop >
```
An added benefit of the loop instructions is that they decrease the value of the ECX register without
affecting the EFLAGS register flag bits. When the ECX register reaches zero, the Zero flag is not set.
