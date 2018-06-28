# struct sysinfo { 
#	long uptime;  /*  Seconds since boot */ 
#	unsigned long  loads[3];  /*  1, 5, and 15 minute load averages */ 
#	unsigned long  totalram;  /*  Total usable main memory size */ 
#	unsigned long  freeram;  /*  Available memory size */ 
#	unsigned long  sharedram;  /*  Amount of shared memory */ 
#	unsigned long  bufferram;  /*  Memory used by buffers */ 
#	unsigned long totalswap; /* Total swap space size */ 
#	unsigned long freeswap; /* swap space still available */ 
#	unsigned short procs;  /* Number of current processes */ 
#	unsigned long totalhigh; /* Total high memory size */ 
#	unsigned int mem_unit;  /* Memory unit size in bytes */ 
#	char _f[20-2*sizeof(long)-sizeof(int)]; /* Padding for libc5 */ 
# } 

	.section .data 
result: 		# Point to the result
uptime: 		# The first field
	.int 0 
load1: 
	.int 0 
load5: 
	.int 0 
load15: 
	.int 0 
totalram: 
	.int 0 
freeram: 
	.int 0 
sharedram: 
	.int 0 
bufferram: 
	.int 0 
totalswap: 
	.int 0 
freeswap: 
	.int 0
procs: 
	.byte 0x00, 0x00 
totalhigh: 
	.int 0 
memunit: 
	.int 0
	
	.section .text 
	.globl _start 
_start: 
	movl $result, %ebx 	# parameter to store the result
	movl $116, %eax 	# sysinfo system call
	int $0x80		# Call kerenel

	# Exit with 0
	movl $0, %ebx 
	movl $1, %eax 
	int $0x80 
