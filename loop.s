	.section .data
output:
	.asciz "The value is %d\n"

	.section .text
	.globl _start
_start:
	movl $100, %ecx	# Set the loop times
	movl $0, %eax	# Set the initial value
sum:
	jcxz done	# Jump to done if the value in ECX is equal to 0.
	addl %ecx, %eax
	loop sum

done:
	# Print the result
	pushl %eax
	pushl $output
	call printf
	addl $8, %esp	# Restore the stack pointer
	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80

	
