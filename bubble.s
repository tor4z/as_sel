	.section .data
new_line:
	.asciz "\n"
fmt:
	# Print the number format
	.asciz "%d "
values:
	# The array to be sort
	.int 105, 235, 61, 315, 134, 221, 53, 145, 117, 5

	.section .text
	.globl _start
_start:
	movl $values, %esi	# Move the base address of the array to ESI
	movl $9, %ecx		# Set initial pass compare times
	movl $9, %ebx		# Set the loop times

loop:
	movl (%esi), %eax	# Move the value in adderss of ESI, to EAX
	cmp %eax, 4(%esi)	# compare the value of EAX with the value of (ESI+4)
	jge skip		# If the value of (ESI+4) greater than the value in EAX, then jump to skip
	xchg %eax, 4(%esi)	# Else exchange the value
	movl %eax, (%esi)	# Store the value of EAX to the memory ESI pointing to
skip:
	addl $4, %esi		# ESI point to the next number in the value
	dec %ebx		# compare times -1
	jnz loop		# If compare times not equal to 0, then jump to loop
	dec %ecx		# Decrease the pass times
	jz print		# If pass times equal to 0, then jump to print
	movl $values, %esi	# Else to initial next pass, set the base address to ESI
	movl %ecx, %ebx		# Set the ccompare times in current pass
	jmp loop		# jump to loop
print:
	movl $0, %edi		# set initial array index to print
print_loop:
	movl values(, %edi, 4), %eax	# Move the value in the location of `values + EDI * 4` to EAX
	pushl %eax			# Push the value of EAX to stack
	pushl $fmt			# Push the address of fmt to stack
	call printf			# call printf function of libc
	addl $8, %esp			# Restore the stack pointer
	inc %edi			# increase the array index, pointing to next value
	cmp $10, %edi			# Check is reach to the end of the array
	jne print_loop			# If not, jump to print_loop

	# print '\n'
	pushl $new_line
	call printf
	addl $4, %esp			# Restore the stack pointer
end:
	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
