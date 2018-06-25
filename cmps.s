	.section .data
value1:
	.asciz "Test"
value2:
	.asciz "Test"

	.section .text
	.globl _start
_start:
	movl $1, %eax		# Exit sys call
	leal value1, %esi	# Set source address
	leal value2, %edi	# Set destination address
	cld			# Set DF flag to 0
	cmpsl			# Compare the string in the ESI memory location and the string in EDI memory location
	je equal		# If the tow string are equal, jump to equal
not_equal:
	# Exit with 1
	movl $1, %ebx
	int $0x80
equal:
	# Exit with 0
	movl $0, %ebx
	int $0x80
