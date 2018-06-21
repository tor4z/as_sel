	.section .data
dividend:
	.quad 8335	# Defining a 64-bit data
divisor:
	.int 25
quotient:
	.int 0		# To store quotient
remainder:
	.int 0		# To store remainder
output:
	.asciz "The quotient is %d, and the remainder is %d\n"

	.section .text
	.globl _start
_start:
	movl dividend, %eax	# Move the low 32-bit of dividend to EAX
	movl dividend+4, %edx	# Move the hight 32-bit of devidend to EDX
	divl divisor		# Divided into the dividend

	movl %eax, quotient	# Store quotient to the quotient memory location
	movl %edx, remainder	# Store remainder to the remainder memory location

	# Print the result
	pushl remainder
	pushl quotient
	pushl $output
	call printf

	# Restore stack
	addl $12, %esp

	# Exit
	pushl $0
	call exit
