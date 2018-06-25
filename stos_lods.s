	.section .data
string1:
	.asciz "This is a TEST, of the conversion program\n"
length:
	.int 43			# Length of the string

	.section .text
	.globl _start
_start:
	leal string1, %esi	# Set sorece address
	movl %esi, %edi		# Set destination address
	movl length, %ecx	# Set loop times
	cld			# Set DF flag to 0

loop_cov:
	lodsb			# Load a character to AL
	cmpb $'a', %al		# If the character in AL lower than 'a'
	jl skip			# Then jump to skip
	cmpb $'z', %al		# If the character in AL greatter 'z'
	jg skip			# Then jump to skip
	subb $0x20, %al		# Convert to upper case

skip:
	stosb			# Store back the character
	loop loop_cov		# Loop it

end:
	# Print the string
	pushl $string1
	call printf
	addl $4, %esp

	# Exit
	pushl $0
	call exit
