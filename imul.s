	.section .data
value1:
	.int 10
value2:
	.int -35
value3:
	.int 400

	.section .text
	.globl _start
_start:
	movl value1, %ebx	# Move the value of value1 memory location to EBX
	movl value2, %ecx	# Move the value of value2 memory location to ECX
	imull %ebx, %ecx	# ECX = EBX * ECX, the value of ECX is -350
	
	movl value3, %edx	# Move the value of value3 memory location to EDX
	imull $2, %edx, %eax	# EAX = EDX * 2, the value of EAX is 800

	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
