	.section .data
data1:
	.int 315814	# Defining 32 bit integer
data2:
	.int 165432	# Defining 32 bit integer
result:
	.quad 0		# Defining 64 bit integer to store the result
output:
	.asciz "The value is %qd \n"

	.section .text
	.globl _start
_start:
	movl data1, %eax	# Move the value in data1 memory location to EAX, as destination operand
	mull data2		# Multiply EAX with the value in data2 memory location
	movl %eax, result	# Store low 32-bit of the result to the result memory location
	movl %edx, result+4	# Store hight 32-bit of the result to the result+4 memory location

	pushl %edx		# Pushing hight 32-bit of the result to the stack
	pushl %eax		# Pushing low 32-bit of the result to the stack
	pushl $output		# Pushing printf format to the stack
	call printf		# Call printf of libc

	addl $12, %esp		# Restore stack pointer

	# Exit with exit function of libc
	pushl $0
	call exit
