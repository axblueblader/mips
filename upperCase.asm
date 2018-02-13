# input a a string, output uppercase format of string

	.data
inStr:	.asciiz "\nNhap mot chuoi ky tu: "
outStr:	.asciiz "\nKy tu in hoa: "
inp:	.asciiz

	.text
main:
	la	$a0, inStr
	addi	$v0, $zero, 4
	syscall

	la 	$a0, inp	#storage address
	addi	$a1,$zero,255	#max length
	addi	$v0, $zero, 8	#input string
	syscall
	
	addi	$t1,$zero,0	#index i stores in t1	
Loop:
	add	$t2,$t1,$a0	#addr(a[i]) = addr(a[0]) + i
	lb	$t3,0($t2)
	slti	$t4,$t3,97	#if t3 < 97 then t4 = 1 else t4 = 0
	beqz	$t4,DownCase
CheckLoop:
	beq	$t1,$a1,Print	# i == n	
	addi	$t1,$t1,1
	j	Loop
DownCase:
	addi	$t3,$t3,-32 	# -32 to downcase
	sb	$t3,0($t2)	#store byte to memory
	j	CheckLoop
Print:
	la	$a0, outStr
	addi	$v0, $zero, 4
	syscall
	
	la	$a0, inp
	addi	$v0, $zero, 4
	syscall

	addi	$v0, $zero, 10
	syscall
