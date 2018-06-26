	.section .data
value1:
	.int 1
value2:
	.int 2

	.section .text
	.globl _start
_start:
	movl value1, %eax
	movl value2, %ebx

	cmpl %eax, %ebx	# preform as EBX-EAX, but not set the result
	jg greater	# ZF=0 and OF=SF

less:	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
greater:
	# The result
	movl $1, %eax
	movl $1, %ebx
	int $0x80
