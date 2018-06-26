1;5201;0c IA32 Assembly SEL

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

For signed integers, the overflow flag is used when an overflow condition is present (the resulting value is less than
the minimum negative value, or greater than the maximum positive value allowed).

Carry Flag:

The carry flag is set when, if both operands are interpreted as unsigned integers, the first one is greater. This is easy to determine because it occurs whenever the subtraction passes through 00000000 into the higher range (11111111).
For example, 00000001 - 00000010 = 11111111, so carry is set. However, 00000010 - 00000001 = 00000001, so carry is not set.

For unsigned integers, the carry flag is set when an addition results in a carry condition in the binary addition (the result is larger than the maximum value allowed).

In substraction, The carry flag was set when the result was less than zero (which is invalid in unsigned integers).


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

If the value of ECX is already zero before the
LOOP instruction, it will be decreased by one, making it -1. Because this value is not zero, the LOOP
instruction continues on its way, looping back to the defined label. The loop will eventually exit when
the register overflows, and the incorrect value is displayed.

### Hight-Level Conditional Branches and Assembly Branches

The assembly language code used to implement an if statement looks like the following:
```
if:
	<condition to evaluate>
	jxx else
	; jump to the else part if the condition is false
	<code to implement the “then” statements>
	jmp end
	;jump to the end
else:
	< code to implement the “else” statements>
end:
```

`if(eax < ebx) || (eax == ecx) then ` creates the following assembly language code:
```
if:
	cmpl %eax, %ebx
	jle else
	cmpl %eax, %ecx
	jne else
then:
	< then logic code>
	jmp end
else:
	< else logic code >
end:
```

The framework for implementing for loops in assembly language. The
pseudocode looks something like this:
```
for:
	<condition to evaluate for loop counter value>
	jxx forcode
	; jump to the code of the condition is true
	jmp end
	; jump to the end if the condition is false
forcode:
	< for loop code to execute>
	<increment for loop counter>
	jmp for	   ; Go back to the start of the for-statement
end:
```

### Optimizing Branch Instructions

#### Branch branches

* Unconditional branches, When the new instruction location is determined in memory, the out-of-order engine must first deter-
mine if the instruction is available in the prefetch cache. If not, the entire prefetch cache must be cleared,
and reloaded with instructions from the new location. This can be costly to the performance of the
application.

* Conditional branches, Three main rules are implemented by the branch prediction algorithms:

1. Backward branches are assumed to be taken.
2. Forward branches are assumed to be not taken.
3. Branches that have been previously taken are taken again.


```
loop:     <-------+
	|         |
	|         |
	|	  | -- more likely backward loop
	|         |
	jnz loop -+
	|
	|
	| --- less likely fall-throught code
	|
	jmp end -------------------+
	|			   |
	|			   |
	| -- more likely           |
	|    fall-throught         | -- less likely forward jump
	|    code                  |
	|        	     	   |
	|        		   |
end:      <------------------------+  
	|
	|
	|
		
```

### Numeric Data Types

1. Basic numeric data types:

* Unsigned integers
* Signed integers
* Binary-coded decimal
* Packed binary-coded decimal
* Single-precision floating-point
* Double-precision floating-point
* Double-extended floating-point

2. Advanced numeric data types(SIMD extensions on Pentium processors):

* 64-bit packed integers
* 128-bit packed integers
* 128-bit packed single-precision floating-point
* 128-bit packed double-precision floating-point

### Extending integers

1. Extending unsigned integers
```
movzx source destination
```

2. Extending signed integer
```
movsx source destination
```

### Define 8-bytes integer
```
label:
	.qual -333252322
```

### IA-32 floating-point values

|Data Type|  Length|  Significand Bits|  Exponent Bits|  Range |
|:--------|:-------|:-----------------|:--------------|:-------|
|Single precision| 32| 24| 8| 1.18 x 10^-38 to 3.40 x 10^38 |
|Double precision| 64| 53| 11| 2.23 x 10^-308 to 1.79 x 10^308 |
|Double extended| 80| 64| 15| 3.37 x 10^-4932 to 1.18 x 10^4932 |


### Preset floating-point value

|Instruction| 	Description |
|:----------|:--------------|
|FLD1|		Push +1.0 into the FPU stack |
|FLDL2T| 	Push log(base 2) 10 onto the FPU stack |
|FLDL2E| 	Push log(base 2) e onto the FPU stack |
|FLDPI| 	Push the value of pi onto the FPU stack |
|FLDLG2| 	Push log(base 10) 2 onto the FPU stack |
|FLDLN2| 	Push log(base e) 2 onto the FPU stack |
|FLDZ| 		Push +0.0 onto the FPU stack |


### Incrementing and Decrementing

The INC and DEC instructions are used to increment (INC) and decrement (DEC) an unsigned integer
value. The INC and DEC instructions don’t affect the carry flag.


### Unsigned integer multiplication using MUL
```
mul source
```

|Source Operand Size|  Destination Operand|  Destination Location |
|:------------------|:--------------------|:----------------------|
|8 bits|	AL|	AX |
|16 bits|  	AX|  	DX:AX |
|32 bits|  	EAX|  	EDX:EAX |


### Signed integer multiplication using IMUL

The first format of the IMUL instruction takes one operand, and behaves exactly the same as the MUL instruction:
```
imul source
```
The source operand can be an 8-, 16-, or 32-bit register or value in memory, and it is multiplied with the
implied operand located in the AL, AX, or EAX registers (depending on the source operand size). The
result is then placed in the AX register, the DX:AX register pair, or the EDX:EAX register pair.


The second format of the IMUL instruction enables you to specify a destination operand other than the EAX register:
```
imul source, destination
```
where source can be a 16- or 32-bit register or value in memory, and destination must be a 16- or
32-bit general-purpose register. This format enables you to specify where the result of the multiplication
will go (instead of being forced to use the AX and DX registers).**Extreme care must be taken when using
this format that you do not overflow the destination register.  (check the carry or overflow flags using the
standard methods after the multiplication to ensure that the result fits in the destination register).**


The third format of the IMUL instruction enables you to specify three operands:
```
imul multiplier, source, destination
```
where multiplier is an immediate value, source is a 16- or 32-bit register or value in memory, and
destination must be a general-purpose register. This format enables you to perform a quick multi-
plication of a value (the source) with a signed integer (the multiplier), storing the result in a general-
purpose register (the destination).


### Unsigned divion

```
div divisor
```
where divisor is the value that is divided into the implied dividend, and can be an 8-, 16-, or 32-bit reg-
ister or value in memory.

|Dividend|  Dividend Size|  Quotient|  Remainder |
|:-------|:--------------|:---------|:-----------|
|AX|  16 bits|  AL|  AH |
|DX:AX|  32 bits|  AX|  DX |
|EDX:EAX|  64 bits|  EAX|  EDX |


### Signed divisor

Unlike the IMUL instruction, there is only one format for the IDIV instruction, which specifies the divisor
used in the division:
```
idiv divisor
```
where divisor can again be an 8-, 16-, or 32-bit register or value in memory.
The IDIV instruction returns the results using the same registers as the DIV instruction, and in the same
format of quotient and remainder (except that the results are signed integers).
**It is important to use the sign extension instructions (such as MOVSX) to extend the dividend
to the proper data size for the division. Failure to do so will corrupt the dividend value and produce
errors in your results.**


### Shift Instruction

To multiply integers by a power of 2, you must shift the value to the left. Two instructions can be used to
left shift integer values, SAL (shift arithmetic left) and SHL (shift logical left). Both of these instructions
perform the same operation, and are interchangeable. They have three different formats:
```
sal destination
sal %cl, destination
sal shifter, destination
```
The first format shifts the destination value left one position, which is the equivalent of multiplying
the value by 2.

The second format shifts the destination value left by the number of times specified in the CL register.

The final version shifts the destination value left the number of times indicated by the shifter value.
In all formats, the destination operand can be an 8-, 16-, or 32-bit register or value in memory.

** Any bits that are shifted out of the data size are first placed in the carry
flag, and then dropped in the next shift.**


The SHR instruction clears the bits emptied by the shift, which makes it useful only for shifting unsigned
integers. The SAR instruction either clears or sets the bits emptied by the shift, depending on the sign
bit of the integer. For negative numbers, the bits are set to 1, but for positive numbers, they are cleared to zero.

**Any bits shifted out of the data element (the least significant bits) are first moved to the carry flag, and then
shifted out (lost).**


### Unpacked BCD arithmetic

Four instructions are used to convert binary arithmetic results to unpacked BCD format:

* AAA: Adjusts the result of an addition process
* AAS: Adjusts the result of a subtraction process
* AAM: Adjusts the result of a multiplication process
* AAD: Prepares the dividend of a division process

These instructions must be used in combination with the normal unsigned integer ADD, ADC, SUB, SBB,
MUL, and DIV instructions. The AAA, AAS, and AAM instructions are used after their respective operation to
convert a binary result into unpacked BCD format.**The AAD instruction is somewhat different in that it is
used before the DIV instruction to prepare the dividend value to produce an unpacked BCD result.**


### Packed BCD arithmetic
When working with packed BCD values, only two instructions are available for use:

* DAA: Adjusts the result of the ADD or ADC instructions
* DAS: Adjusts the result of the SUB or SBB instructions
 
These instructions perform the same functions as the AAA and AAS instructions, but with packed BCD
values. They also use the implied operand located in the AL register, and place the result of the conver-
sion in the AL register, with the carry bit placed in the AH register and the auxiliary carry flag bit.


### Bit Testting

The IA-32 platform provides the TEST instruction. The TEST instruction performs
a bit-wise logical AND between two 8-, 16-, or 32-bit values, and sets the sign, zero, and parity flags
accordingly, without modifying the destination value.


### Floating-point Math

|Instructioin| Description|
|:-----------|:------------|
|FADD|		Floating-point addition |
|FDIV| 		Floating-point division |
|FDIVR| 	Reverse floating-point division |
|FMUL| 		Floating-point multiplication |
|FSUB| 		Floating-point subtraction |
|FSUBR| 	Reverse floating-point subtraction |

Actually, each of these functions has separate instructions and formats that can be used to produce six
possible functions, depending on exactly what operation you want to perform. For example, the FADD
instruction can be used as follows:

* FADD source: Add a 32- or 64-bit value from memory to the ST0 register
* FADD %st(x), %st(0): Add st(x) to st(0) and store the result in st(0)
* FADD %st(0), %st(x): Add st(0) to st(x) and store the result in st(x)
* FADDP %st(0), %st(x): Add st(0) to st(x), store the result in st(x), and pop st(0)
* FADDP: Add st(0) to st(1), store the result in st(1), and pop st(0)
* FIADD source: Add a 16- or 32-bit integer value to st(0) and store the result in st(0)

### The FCOM instruction family

|Instruction| 	Description |
|:----------|:--------------|
|FCOM| 		Compare the ST0 register with the ST1 register. |
|FCOM ST(x)| 	Compare the ST0 register with another FPU register. |
|FCOM source| 	Compare the ST0 register with a 32- or 64-bit memory value. |
|FCOMP| 	Compare the ST0 register with the ST1 register value and pop the stack. |
|FCOMP ST(x)| 	Compare the ST0 register with another FPU register value and pop the stack. |
|FCOMP source| 	Compare the ST0 register with a 32 or 64-bit memory value and pop the stack. |
|FCOMPP| 	Compare the ST0 register with the ST1 register and pop the stack twice. |
|FTST| 		Compare the ST0 register with the value 0.0. |


|Condition|    C3|  C2|  C0 |
|:--------|------|----|-----|
|ST0 > source|  0|  0|  0 |
|ST0 < source|  0|  0|  1 |
|ST0 = source|  1|  0|  0 |


Combining the FSTSW and SAHF instructions moves the following:

* The C0 bit to the EFLAGS carry flag 
* The C2 bit to the EFLAGS parity flag 
* The C3 bit to the EFLAGS zero flag 

### The FCOMI instruction family

The FCOMI family of instructions performs the floating-point comparisons and places the results in the EFLAGS reg-
isters using the carry, parity, and zero flags.

|Instruction| 	Description|
|:----------|:-----------|
|FCOMI| 	Compare the ST0 register with the ST(x) register. |
|FCOMIP| 	Compare the ST0 register with the ST(x) register and pop the stack. |
|FUCOMI| 	Check for unordered values before the comparison. |
|FUCOMIP| 	Check for unordered values before the comparison and pop the stack afterward. |

The output of the FCOMI instructions uses the EFLAGS registers, as shown in the following table.

|Condition|   ZF|  PF|  CF |
|:--------|:----|:----|:-----|
|ST0 > ST(x)|  0|  0|  0 |
|ST0 < ST(x)|  0|  0|  1 |
|ST0 = ST(x)|  1|  0|  0 |


### The FCMOV Instruction Family

|Instruction|  Description |
|:----------|:-------------|
|FCMOVB|  Move if ST(0) is below ST(x). |
|FCMOVE|  Move if ST(0) is equal to ST(x). |
|FCMOVBE|  Move if ST(0) is below or equal to ST(x). |
|FCMOVU|  Move if ST(0) is unordered. |
|FCMOVNB|  Move if ST(0) is not below ST(x). |
|FCMOVNE|  Move it ST(0) is not equal to ST(x). |
|FCMOVNBE|  Move if ST(0) is not below or equal to ST(x). |
|FCMOVNU|  Move if ST(0) is not unordered. |

The GNU format of the instructions is
```
fcmovxx source, destination
```
where source is the ST(x) register, and destination is the ST(0) register. 


### Optimizing Floating-Point Calculations

Intel has provided some simple tips to follow when coding floating-point programs:

* Make sure the floating-point values do not overflow or underflow the data elements. 
* Set the precision control bit for single precision. 
* Use lookup tables for simple trig functions. 
* Break dependence chains when possible. For example, instead of calculating z = a + b + c + d, 
calculate x = a + b; y = c + d; z = x + y. 
* Keep equation values in the FPU registers as much as possible. 
* When working with integers and floating-point values, loading the integers into the FPU registers
and performing a calculation is quicker than using a floating-point instruction with the integer.
For example, instead of using FIDIV, use FILD to load the integer, and then the FDIVP 
instruction on the values in the FPU registers. 
* Use FCOMI instructions instead of FCOM instructions as much as possible. 


### Other REP Instruction

Besides monitoring the value of the ECX register, there are REP instructions that also monitor the status
of the zero flag (ZF). The following table describes the other REP instructions that can be used.

|Instruction| 	Description |
|:----------|:--------------|
|REPE| 		Repeat while equal |
|REPNE| 	Repeat while not equal |
|REPNZ| 	Repeat while not zero |
|REPZ| 		Repeat while zero |


### The CMPS Instrction

* CMPSB: Compares a byte value 
* CMPSW: Compares a word (2 bytes) value 
* CMPSL: Compares a doubleword (4 bytes) value 

As with the other string instructions, the locations of the implied source and destination operands are
again stored in the ESI and EDI registers. Each time the CMPS instruction is executed, the ESI and EDI
registers are incremented or decremented by the amount of the data size compared, depending on the DF
flag setting.


###  The REP family: REPE, REPNE, REPZ, and REPNZ


### The C-Style Funtion

* Passing Data value

The C solution for passing input values to functions is to use the stack. The stack is accessible from the
main program as well as from any functions used within the program.

Likewise, the C style defines a common method for returning values to the main program, using the EAX
register for 32-bit results (such as short integers), the EDX:EAX register pair for 64-bit integer values, and
the FPU ST(0) register for floating-point values.


* Function prologue and epilogue

```
function:
	pushl %ebp
	movl %esp, %ebp
	.
	.
	movl %ebp, %esp
     popl %ebp
     ret

```

The ENTER and LEAVE instructions are specifically designed for setting up function prologues (the ENTER
instruction) and epilogues (the LEAVE instruction). These can be used instead of creating the prologues
by hand.

* Defining local function data

Now that the local variables are defined on the stack, they can easily be referenced using the EBP register.
Assuming 4-byte data values, the first local variable would be accessed by referencing –4(%ebp),
while the second local variable would be accessed by referencing –8(%ebp). at the start of the function
code another line is addd to reserve a set amount of stack space for local variables by subtracting the
value from the ESP register.

```
		    Program Stack
		+-----------------------+
		|			|
		|			|  Indirect address
		|			|
		+-----------------------+
		| Function paramater 3  |  16(%ebp)
		+-----------------------+
		| Function paramater 2  |  12(%ebp)
		+-----------------------+
		| Function paramater 1  |  8(%ebp)
		+-----------------------+
		|    Return Address     |  4(%ebp)
		+-----------------------+
		|    Old EBP Value      |  (%ebp)
		+-----------------------+
		|    Local variable 1   |  -4(%ebp)
		+-----------------------+
		|    Local variable 2   |  -8(%ebp)
		+-----------------------+
     ESP --->	|    Local variable 3   |  -12(%ebp)
		+-----------------------+
		|                       |
		+-----------------------+
		|			|
		+-----------------------+
```