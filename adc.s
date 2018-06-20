	.section .data
data1:
	.quad 7252051615	# Defining a 8-bytes value
data2:
	.quad 5732348928	# Defining an another 8-bytes value
output:
	.asciz "The result is %qd\n"

	.section .text
	.globl _start
_start:
	movl data1, %ebx	# Load low 4-bytes of data1 to EBX
	movl data1+4, %eax	# Load hight 4-bytes of data1 to EAX

	movl data2, %edx	# Load low 4-bytes of data2 to EDX
	movl data2+4, %ecx	# Load hight 4-bytes of data2 to ECX

	addl %ebx, %edx		# Add low 4 bytes of data1 and data2
	adcl %eax, %ecx		# Add hight 4 bytes of data1 and data2 with carry

	pushl %ecx		# Pushing hight 4 bytes of result to the stack
	pushl %edx		# Pushing low 4 bytes of result to the stack
	pushl $output		# Pushing the address of output to the stack
	call printf		# Call printf of libc

	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80

/*
	Decimal			Hexadecimal			Register Values
							      EAX          EBX
      7,252,051,615	        0x01B041869F		   0x00000001   0xB041869F
							      ECX	   EDX
    + 5,732,348,928             0x0155ACB400		   0x00000001   0x55ACB400
  ------------------------------------------------------------------------------------
							      ECX          EDX
     12,984,400,543		0x0305EE3A9F	           0x00000003   0x05EE3A9F
*/
