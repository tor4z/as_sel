	.section .data
output:
	.asciz "%s\n"
addr:
	.asciz "%p\n"
	
	.section .text
	.globl _start
_start:
	# Set EBP, make EBP point to first environment variable
	movl %esp, %ebp
	addl $12, %ebp		# Skip, parament_count program_name 0x00000000

loop_env:
	cmpl $0, (%ebp)		# Check of reach to the end of the environment variable list
	je end			# If so, Jump to end

	# Print environment variable and clean up the stack and eat the current variable pointer stack space
	pushl (%ebp)
	push $output
	call printf
	addl $12, %esp

	# Print The address of the envronment variable and clean up the stack
	pushl %ebp
	pushl $addr
	call printf
	addl $8, %esp

	addl $4, %ebp		# Point to next environment variable
	loop loop_env		# Loop it

end:
	# Exit with 0
	pushl $0
	call exit
