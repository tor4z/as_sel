	.section .data
string1:
	.ascii "test"
string2:
	.ascii "test1"
length1:
	.int 4			# The length of string1
length2:			# The lenght of string2
	.int 5

	.section .text
	.globl _start
_start:
	leal string1, %esi	# Set Source
	leal string2, %edi	# Set destination
	movl length1, %ecx	
	movl length2, %eax
	cmpl %ecx, %eax		# Compare two length
	ja longer
	xchg %ecx, %eax		# If EAX less than ECX, exchange

longer:
	cld			# Set DF flag to 0
	repe cmpsb		# Compare source string and destination string
	je equal		# If two string are equal, jump to equal
	jg greater		# If destination string are greater, jump to greater

less:
	# The result of this program
	# Exit with -1
	movl $1, %eax
	movl $-1, %ebx
	int $0x80

greater:
	# Exit with 1
	movl $1, %eax
	movl $1, %ebx
	int $0x80

equal:
	movl length1, %ecx	# The value in ECX is 4
	movl length2, %eax	# The value in EAX is 5
	cmpl %eax, %ecx		# Compare
	jg greater		# If ECX is greater than EAX, jump to greater
	jl less			# If ECX is less than ECX, jump to less

	# Exit with 0
	movl $1, %eax
	movl $0, %ebx
	int $0x80
