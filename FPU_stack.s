	.section .data
value1:
	.int 40			# Defining a integer
value2:
	.float 92.4405		# Difining a single precision floating-point value
value3:
	.double 221.440321	# Defining a double precision floating-point value

	.section .bss
	.lcomm int1, 4
	.lcomm control, 2
	.lcomm status, 2
	.lcomm result, 4

	.section .text
	.globl _start
_start:
	/* ## finit
	 *
	 * It sets the control and status registers to their default values, but it does not
	 * alter the data contained in the FPU data registers. It is always a good idea to include this instruction in
	 * any program that utilizes the FPU.
	 *
	 * When the FINIT instruction is executed, it does
	 * not initialize the FPU data registers but changes the tag values to show that they are empty. 
	*/
	finit			# Initialize the FPU
	fstcw control		# Copy FPU control register value to the control memory location
	fstsw status		# Copy FPU status register value to the status memory location
	/* ## filds & fists
	 *
	 * the value was converted to the double-extended floating-point
	 * data type when it was stored in the FPU register. When the value was retrieved from the FPU register
	 * stack and placed in memory, it was automatically converted back to a doubleword integer (because the
	 * S character was specified on the FIST mnemonic).
	*/
	filds value1		# Load a doubleword integer value into the FPU stack
	fists int1		# Retrive the top of the FPU register stack and store to the int1 memory location
	
	flds value2		# Load the single-precision floating-point value
	fldl value3		# load the double-precision floating-point value

	/*
	 * Copy the data from ST0 FPU register to a memeory location or another FPU regisetr
	 * While keeping the original value in the ST0 register
	*/
	fst %st(4)

	/*
	 * Exchange the value of the ST0 register with another FPU register
	*/
	fxch %st(1)

	/*
	 * he FSTP instruction also copies the ST0 FPU register value, but then pops it from the FPU register
	 * stack. This shifts all of the FPU stack values up one place in the stack.
	*/
	fstps result

	movl $1, %eax
	movl $0, %ebx
	int $0x80
