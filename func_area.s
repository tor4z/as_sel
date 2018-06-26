	.section .data 
precision: 
	.byte 0x7f, 0x00	# Set single-precision

	
	.section .bss 
	.lcomm result, 4	# Reserve 4 byte to store result

	
	.section .text 
	.globl _start 
_start: 
	finit 			# Init FPU
	fldcw precision 	# Load the precision memory location to control register
	pushl $10 		# Push 10 to the stack as the parameter if area function
	call area 		# Call area function
	addl $4, %esp 		# Clean stack
	movl %eax, result	# Move the value return by area to the result memory location

	# Exit
	movl $1, %eax 
	movl $0, %ebx 
	int $0x80


	# Defining a C-Style function
	.type area, @function 	# Declare a function
area:
	# The prologue of the function
	pushl %ebp 
	movl %esp, %ebp 
	subl $4, %esp		# Reserve space to store local value
	
	fldpi 			# Load PI to the FPU stack
	filds 8(%ebp) 		# Load the argument to the FPU stack
	fmul %st(0), %st(0) 	
	fmulp %st(0), %st(1) 
	fstps -4(%ebp) 		# Store the result to local memory location
	movl -4(%ebp), %eax	# Move the result to EAX

	# The epilogue of the function
	movl %ebp, %esp 
	popl %ebp 
	ret 

	
