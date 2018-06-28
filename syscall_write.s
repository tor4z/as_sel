	.section .data
output:
	.asciz "This is a test message.\n"
output_end:
	.equ len, output_end - output	# Defining the length of the string by subtracting the two lable
					# The len lable is treated as an immediate valur
	.section .text
	.globl _start
_start:
	movl $4, %eax			# Write system call
	movl $1, %ebx			# Print to stdout file description
	movl $output, %ecx		# The sting to print
	movl $len, %edx			# The length of the string, len label is treated as an immediate
	int $0x80			# Call kernel

	# Exit with 0
	movl $1, %eax
	movl $0, %ebx
	int $0x80

