	.section .data
value1:
	# Defining packed BCD value
	.byte 0x25, 0x81, 0x02
value2:
	.byte 0x33, 0x29, 0x05

	.section .bss
	.lcomm result, 3		# Reserve space to store result

	.section .text
	.globl _start
_start:
	xor %edi, %edi			# Clean EDi register
	movl $3, %ecx			# Set loop times
loop_calc:
	movb value2(, %edi, 1), %al	# Load the value of the memory location of value2+EDI to AL
	sbbb value1(, %edi, 1), %al	# Subtract the value of the memory location of value1+EDI from AL
	das				# Adjust After subtract
	movb %al, result(, %edi, 1)	# Store the result
	inc %edi			# Shift to next value
	loop loop_calc			# Loop it

	sbbb $0, result(, %edi, 1)	# Subtract with carry from result

	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
