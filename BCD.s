	.section .data
data1:
	# Set the value of data1, 1234 in Decimal
	.byte 0x34, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
data2:
	.int 2

	.section .text
	.globl _start
_start:
	fbld data1	# Load the value of data1 into the top of the FPU stack
	fimul data2	# Multiply the top of the FPU stack with the value in data2 memory location
	fbstp data1	# Move the value in the top of the FPU stack to the data1 memory location

	# Exit
	movl $1,%eax
	movl $0, %ebx
	int $0x80
