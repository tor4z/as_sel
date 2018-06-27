	.section .data
output1:
	.asciz "Thera are %d parameters:\n"
output2:
	.asciz "%s\n"

	.section .text
	.globl _start
_start:
	movl (%esp), %ecx

	# Print the parameter count
	pushl %ecx
	pushl $output1
	call printf
	
	addl $4, %esp		# Clean up the stack
	popl %ecx		# Set parameter count
	movl %esp, %ebp		# MAke EBP point to parameter count
	addl $4, %ebp		# Move the EBP point to the first parameter

loop_para:
	pushl %ecx		# Save the value in ECX

	# Print parameter
	pushl (%ebp)
	pushl $output2
	call printf
	
	addl $8, %esp		# Clean up the stack
	popl %ecx		# Restore the value in ECX
	addl $4, %ebp		# Move to next parameter
	loop loop_para

	# Exit with 0
	pushl $0
	call exit
	
	
