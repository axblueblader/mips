.data
	file_loc: .asciiz "BieuThuc.txt" #note: when launching from commandline, test.asm should be within the same folder as Mars.jar
	buffer: .space 1024 #buffer of 1024
	new_line: .asciiz "\n"  #where would I actually use this?
	equal: .asciiz " = "
	#error strings
	readErrorMsg: .asciiz "\nError in reading file\n"
	openErrorMsg: .asciiz "\nError in opening file\n"
	
	int1:	.word 0
	int2:	.word 0
	ans:	.word 0
.text
main:
	jal openFile
	j endProgram

openFile:
	#Open file for for reading purposes
	li $v0, 13          #syscall 13 - open file
	la $a0, file_loc    #passing in file name
	li $a1, 0               #set to read mode
	li $a2, 0               #mode is ignored
	syscall
	bltz $v0, openError     #if $v0 is less than 0, there is an error found
	move $s0, $v0           #else save the file descriptor

	#Read input from file
	li $v0, 14          #syscall 14 - read filea
	move $a0, $s0           #sets $a0 to file descriptor
	la $a1, buffer          #stores read info into buffer
	li $a2, 1024            #hardcoded size of buffer
	syscall             
	bltz $v0, readError     #if error it will go to read error
parse:
	la $t0, buffer
	addi $t5,$zero,10
loop1:
	add $t6,$t0,$t7		#add to address a[i]
	lb $t4, 0($t6)		#load ascii code
	beq $t4,32,space
	
	addi $t4,$t4,-48	#convert to int number
	
	mult $t1,$t5		# t1*10
	mflo $t1
	
	add $t1,$t1,$t4		#t1= t1*10 + t4
	addi $t7,$t7,1		#increase index
	j loop1
	
space:
	add $t7,$t7,1
	add $t6,$t0,$t7
	lb $s0,0($t6)		#load operator
	sw $t1,int1		#save first int to int1
	add $t7,$t7,2
	add $t1,$zero,$zero
	
loop2:
	add $t6,$t0,$t7		#add to address a[i]
	lb $t4, 0($t6)		#load ascii code
	beqz $t4,calculate
	addi $t4,$t4,-48	#convert to int number
	
	mult $t1,$t5		# t1*10
	mflo $t1
	
	add $t1,$t1,$t4		#t1= t1*10 + t4
	addi $t7,$t7,1		#increase index
	j loop2

calculate:
	sw $t1,int2		#save second int to int2
	lw $t1,int1
	lw $t2,int2
	
	beq $s0,42, multiply
	beq $s0,43, addition
	beq $s0,45, subtraction
	beq $s0,47, divition
	beq $s0,37, mod
	
multiply:
	mult $t1,$t2
	mflo $a0
	sw $a0,ans
	j print
	
addition:
	add $a0,$t1,$t2
	sw $a0,ans
	j print
subtraction:
	sub $a0,$t1,$t2
	sw $a0,ans
	j print
divition:
	div $t1,$t2
	mflo $a0
	sw $a0,ans
	j print
mod:
	div $t1,$t2
	mfhi $a0
	sw $a0,ans
	j print
print:
	li $v0, 4
	la $a0, buffer
	syscall

	li $v0, 4
	la $a0, equal
	syscall
	
	li $v0, 1
	lw $a0,ans
	syscall
	
	#Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file
	jr $ra

openError:
	la $a0, openErrorMsg
	li $v0, 4
	syscall
	j endProgram

readError:
	la $a0, readErrorMsg
	li $v0, 4
	syscall
	j endProgram

endProgram:
	li $v0, 10
	syscall
