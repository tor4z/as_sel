	.section .data
output:
	# Define the output string
	.asciz "The largest value is %d\n"
values:
	# Definee an array of int
	.int 105, 235, 61, 315, 134, 221, 53, 145, 117, 5

	.section .text
	.globl _start
_start:
	# Move the first value of the array to EBX
	# assume that is the largest
	movl values, %ebx
	# To start off, the second value of the array to be compare with tfhe value in EAX
	movl $1, %edi
loop:
	# Move the value to be compare with the value in EBX to EAX
	movl values(, %edi, 4), %eax
	/* The CMP instruction substract the first operand from the second and
	 * set the EFLAGS register appropriately.
	 * If the value of EBX larger than the value in EBX
	 * Carry Flag will be set to 0
	 * else Carry Flag will be set to 1
	 * The value of CF is use to determine whether to move the value in EAX to EBX
	 *
	 * If the value of EBX is larger than the value in EAX
	 * the CF will set to 0
	 * and then move the value of EAX to EBX
	*/
	cmp %ebx, %eax
	/* CMP instruction is similar to subl,
	 * but not store the result to any register, just set the flags appropriately
	 * The CMP instruction is performed like %ebx - %eax
	*/
	cmova %eax, %ebx
	inc %edi		# Pointing to next index
	cmp $10, %edi		# Check is reach to the end of fthe array
	jne loop


	# Print the result use printf in libc
	pushl %ebx
	pushl $output
	call printf

	# Exit
	addl $8, %esp
	pushl $0
	call exit


