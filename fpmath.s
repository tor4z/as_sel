/*
 ((43.65 / 22) + (76.34 * 3.1)) / ((12.43 * 6) – (140.2 / 94.21))

Load 43.65 into ST0.
Divide ST0 by 22, saving the results in ST0.
Load 76.34 in ST0 (the answer from step 2 moves to ST1).
Load 3.1 in ST0 (the value in step 3 moves to ST1, and the answer from Step 2 moves to ST2).
Multiply ST0 and ST1, leaving the answer in ST0.
Add ST0 and ST2, leaving the answer in ST0 (this is the left side of the equation).
Load 12.43 into ST0 (the answer from Step 6 moves to ST1).
Multiply ST0 by 6, leaving the answer in ST0.
Load 140.2 into ST0 (the answer from Step 8 moves to ST1, and from Step 6 to ST2).
Load 94.21 into ST0 (the answer from Step 8 moves to ST2, and from Step 6 to ST3).
Divide ST1 by ST0, popping the stack and saving the results in ST0 (the answer from Step 8
moves to ST1, and from Step 6 to ST2 ).
Subtract ST0 from ST1, storing the result in ST0 (this is the right side of the equation).
Divide ST2 by ST0, storing the result in ST0 (this is the final answer).

*/
	.section .data
value1:
	.float 43.65
value2:
	.int 22
value3:
	.float 76.34
value4:
	.float 3.1
value5:
	.float 12.43
value6:
	.int 6
value7:
	.float 140.2
value8:
	.float 94.21
output:
	.asciz "The result is %f\n"

	.section .text
	.globl _start
_start:
	finit			# Intialize FPU stack
	flds value1		# Load value1 to the FPU stack
	fidiv value2		# Divide ST0 by the value in the memory location of value2
	flds value3		# Load value3 to the FPU stack
	flds value4		# Load value4 to the FPU stack
	fmul %st(1), %st(0)	# Multiply ST0 and ST1, leaving the answer in St0
	fadd %st(2), %st(0)	# Multiply ST0 and ST2, leaving the answer in St0
	flds value5		# Load value5 to the FPU stack
	fimul value6		# Multiply ST0 and the value in the memory location of value6, leaving the answer in ST0
	flds value7		# Load value7 to the FPU stack
	flds value8		# Load value8 to the FPU stack
	fdivrp			# Divide ST1 by ST0, poping the stack and saving the answer in ST0
	fsubr %st(1), %st(0)	# Subtract St0 from ST1, storing the result in ST0
	fdivr %st(2), %st(0)	# Divide ST2 by ST0, storing the result in ST0
	subl $8, %esp		# Reserve space to store result in the stack
	fstpl (%esp)		# Storing the result into the stack
	pushl $output		# Pushing output format into the stack
	call printf		# Call printf of libc
	addl $12, %esp		# Restoring stack

	# Exit
	pushl $0
	call exit
	
