	.section .data
output:
	.asciz "The value is %d\n"
values:
	/* Define an array of int */
	.int 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60

	.section .text
	.globl _start
_start:	
	movl $0, %edi
loop:
	/* The data value retrieved located at:
	 * base_address + offset_address + index * size
	 * The instruction below loads the %edi-1 index value of 4
	 * bytes from `values` label to the EAX register.
	*/
	movl values(, %edi, 4), %eax
	/* Push the argument of printf to the stack
	 * in reverese sequence.
	*/
	pushl %eax
	pushl $output
	call printf	# call printf in libc

	addl $8, %esp	# Clean stack, we have push two 4-bytes data into the stack before
	inc %edi	# Move the pointer to the next position
	cmpl $11, %edi	# Compare %edi with 11, to check the current index of the array
	jne loop	# If %edi less then(not equal) to 11, then goto loop
			# Else goto the next instruction
	movl $0, %ebx	# Set the exit code to 0
	movl $1, %eax	# exit sys_call
	int $0x80	# call kernel
	
