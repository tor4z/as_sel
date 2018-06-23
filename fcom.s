	.section .data
value1:
	.float 10.923
value2:
	.float 4.5532

	.section .text
	.globl _start
_start:
	flds value1	# Load value1 into the FPU stack
	fcoms value2	# Compare value1 with value2
	fstsw		# Store FPU status word in AX register after checking for pending unmasked floating-point exceptions.
	sahf		# Load SF, ZF, AF, PF, and CF from AH into EFLAGS register.
	ja greater	# Jump to greater, if value1 > value2
	jb lessthan	# Jump to lessthan, if value1 < value2

	# Exit if value1 == value2
	movl $1, %eax
	movl $0, %ebx
	int $0x80

greater:
	# Exit if value1 > value2
	movl $1, %eax
	movl $2, %ebx
	int $0x80

lessthan:
	# Exit if value1 < value2
	movl $1, %eax
	movl $1, %ebx
	int $0x80
