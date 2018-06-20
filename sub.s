	.section .data
data:
	.int 40			# Difining a integer value

	.section .text
	.globl _start
_start:
	# Clean registers
	movl $0, %eax
	movl $0, %ebx
	movl $0, %ecx

	movb $20, %al		# Move 20 to AL
	subb $10, %al		# AL = AL - 10, the value in AL is 10

	movsx %al, %eax		# Extending the value
	movw $100, %cx		# Move 100 to CX
	subw %cx, %bx		# BX = BX - CX, the value in bx is -100
	movsx %bx, %ebx		# Extending the value

	movl $100, %edx		# Move 100 to EDX
	subl %eax, %edx		# EDX = EDX - EAX
	subl data, %eax 	# EAX = EAX - data, the value is EAX is -30
	subl %eax, data		# data = data - EAX, the value in the memory location is 70

	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
