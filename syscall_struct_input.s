# int  nanosleep(const struct timespec *req, struct timespec *rem);
#
# struct	timespec 	
# { 		
# 	time_t tv_sec; 	/* seconds */ 
#	long  tv_nsec; 	/* nanoseconds */ 
# }; 		
#
# Both of these values can be represented by 32-bit integer values in the assembly language program. 
#

	
	.section .data
timespec:	
	.int 5, 0			# The timespec parameter of nanosleep
output:
	.asciz "This is a test\n"	# The string to print
output_end:		
	.equ len, output - output_end	# The string length

	.section .bss
	.lcomm rem, 8			# Reserve 8 byte space to store rem

	.section .text
	.globl _start
_start:
	movl $10, %ecx			# Set loop times
loop_sleep:
	pushl %ecx			# Store the value in ECX

	# Print the string
	movl $4, %eax
	movl $1, %ebx
	movl $output, %ecx
	movl $len, %edx
	int $0x80

	# nanosleep system call
	movl $162, %eax
	movl $timespec, %ebx
	movl $rem, %ecx
	int $0x80

	popl %ecx			# Restore the value in ECX
	loop loop_sleep

	movl $1, %eax
	movl $0, %ebx
	int $0x80
