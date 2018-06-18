	.section .data
output:
	.asciz "The value is %d\n"

	.section .text
	.globl _start
_start:
	movl $100, %ecx
	movl $0, %eax
sum:	
	addl %ecx, %eax
	loop sum
	pushl %eax
	pushl $output
	call printf
	addl $8, %esp

	movl $1, %eax
	movl $0, %ebx
	int $0x80

	
