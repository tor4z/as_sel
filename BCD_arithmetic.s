	.section .data
value1:
	# Defining BCD value *little-endian* format
	.byte 0x05, 0x02, 0x01, 0x08, 0x02
value2:
	.byte 0x03, 0x03, 0x09, 0x02, 0x05

	.section .bss
	.lcomm sum, 6	# Reserve 6 byte to store the result

	.section .text
	.globl _start
_start:
	xor %edi, %edi	# Clean EDI register
	movl $5, %ecx	# Set loop times

sum_loop:
	movb value1(, %edi, 1), %al	# Load a byte of value1 to AL
	adcb value2(, %edi, 1), %al	# Add a byte of value2 to AL
	aaa				# Adjust After Add 
	movb %al, sum(, %edi, 1)	# Store the result to the sum memory location
	inc %edi			# Shift to the next byte
	loop sum_loop			# Loop

	adcb $0, sum(, %edi, 1)		# Add 0 with crray and the low 1 byte, and store to the memory location of sum + EDI

	# Exit
	movl $1, %eax
	movl $0, %ebx
	int $0x80
