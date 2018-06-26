	.section .data
string1:
	.ascii "This is a test - a long text string to scan."
length:
	.int 11			# (length of string1)/4
string2:
	.ascii "test"

	.section .text
	.globl _start
_start:
	leal string1, %edi
	leal string2, %esi
	movl length, %ecx
	lodsl			# Load string2 to EAX
	cld			# Set DF flag to 0

	repne scasl		# repeatedly compare the string in EAX with the string in the memory of EDI, if not equal
	jne notfound		# If not found, jump to notfound
	subw length, %cx
	neg %cx

	# Exit with the position
	movl $1, %eax
	movl %ecx, %ebx
	int $0x80

notfound:
	# Exit with 0
	movl $1, %eax
	movl $0, %ebx
	int $0x80

/*
|This| is |a te|st -| a l|ong |text| str|ing |to s|can.|
  1     2   3     4    5    6    7    8    9   10   11
*/
