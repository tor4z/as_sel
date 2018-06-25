	.section .data
value1:
	.asciz "This is a test of the CMPS instruction"
value2:
	.asciz "This is a test of the CMPS Instruction"

	.section .text
	.globl _start
_start:
	movl $1, %eax		# Exit sys call
	leal value1, %esi	# Set source
	leal value2, %edi	# Set destination
	movl $39, %ecx		# Set repeat times
	cld			# Set DF flag to 0

	repe cmpsb		# repeatedly compare string byte by byte, until the value of ECX is 0 or zero flag is set
	je equal		# If zero flag is set, jump to equal
not_equal:
	# Exit with the value of ECX
	movl %ecx, %ebx
	int $0x80
equal:
	# Exit with 0
	movl $0, %ebx
	int $0x80
