	.section .data 
string1: 
	.asciz "This is a test of the conversion program!\n"
length: 
	.int 43 
divisor: 
	.int 4
	
	.section .bss 
	.lcomm buffer, 43
	
	.section .text 
	.globl _start 
_start: 
	leal  string1, %esi 	# Set source 
	leal  buffer, %edi 	# Set destination

	# Set repeat move string times, and devided by 4
	movl  length, %ecx 
	shrl  $2, %ecx
	
	cld 			# Set direct flag to 0
	rep movsl 		# Move string 4 byte at a times

	# Set repeat times, ECX = length - (length / 4)
	movl length, %ecx 
	andl $3, %ecx

	rep movsb		# Move string 1 byte at a times

	# Exit
	movl $1, %eax 
	movl $0, %ebx 
	int $0x80 
