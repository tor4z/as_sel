	.section .data
values:
	.int 1, 2, 3, 4, 5

fmt:
	.asciz "%d "
new_line:
	.asciz "\n"

	.section .text
	.globl _start
_start:
	movl $values, %edi
	movl $5, %ebx
loop:
	movl (%edi), %eax
	pushl %eax
	pushl $fmt
	call printf
	addl $8, %esp
done:	
	addl $4, %esp
	addl $4, %edi
	dec %ebx
	jnz loop

	pushl $new_line
	call printf
	addl $4, %esp

	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
