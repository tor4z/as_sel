	.section .data
value1:
	.float 12.34		# Defining a float value
value2:
	.double 2353.631	# Defining a double value

	.section .bss
	.lcomm data, 8		# Reserve 8 byte space to store data

	.section .text
	.globl _start
_start:
	flds value1		# Load the value in the value1 memory location(single-precision float-point value) into the top of the FPU stack
	fldl value2		# Load the value in the value2 memory location(double-precision float-point value) into the top of the FPU stack
	fstl data		# Retrive the top value on the FPU stack to the data memory location

	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
