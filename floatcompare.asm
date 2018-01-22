	.data
str1:	.asciiz "\nNhap so thu nhat: "
str2:	.asciiz "\nNhap so thu hai: "
str3:	.asciiz "\nSo lon hon la: "
str4:	.asciiz "\nHai so bang nhau: "

	.text
main:
	la	$a0, str1	#load string 1 into reg
	addi	$v0, $zero, 4	#add print code into reg
	syscall			#call print
	
	li	$v0,5		#put 6 into v0 to call read_float
	syscall			#call read_float
	move	$t0,$v0		#copy float to t0 to store
	
	la	$a0, str2	#load string 2 into reg
	addi	$v0, $zero, 4	#add print code into reg
	syscall			#call print
	
	li	$v0,5		#read_float again
	syscall			#call read_float
	move	$t1,$v0		#store 2nd float to t1
	
	beq	$t0,$t1, EqualBranch#check equal to jump
	sub	$t2,$t0,$t1	#t3 = t0-t1
	bgtz	$t2, LargerBranch # if t3 > 0 jump LargerBranch
	add	$t3, $zero, $t1	# else $t3 = $t1
	j	Print		# goes to print result
EqualBranch:
	la	$a0, str4	#load string for equal branch
	addi	$v0, $zero, 4	#store print code into reg
	syscall			#call print
	j		Exit	#jump to exit
LargerBranch:
	add	$t3, $zero, $t0	#update t3 = t0
Print:
	la	$a0, str3	#load string 4
	addi	$v0, $zero, 4	#store print code into reg
	syscall			#call print
	
	move	$a0, $t3	#put result into correct reg to print
	addi	$v0, $zero, 1	#put print_float code into reg
	syscall			#call print_float
Exit:
	addi	$v0, $zero, 10	#put exit code into reg
	syscall			#call exit to exit program