	.section .text
	.globl _start
_start:
	# Extending unsigned integer test
	movl $279, %ecx		# Set the value of ECX to 0x117
	movzx %cl, %ebx		# The value of EBX is 0x17

	# Clean register
	movl $0, %ecx
	movl $0, %ebx

	# Extending signed integer test
	movw $-79, %cx		# Set the value of CX to 0xffb1
	movl $0, %ebx		# Clean EBX
	movw %cx, %bx		# The value of BX is 0xffb1
	movsx %cx, %eax		# Extending the value of CX from word to doubleword,
				# and store to EAX, the value of EAX is 0xffffffb1
	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
