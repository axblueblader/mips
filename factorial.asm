.data
	tb1:	.asciiz "Nhap so n (n > 0): "	#string for input
	tb2:	.asciiz "Ket qua giai thua: "	#string for output
.text
input:
	la	$a0, tb1		#put string in reg for printing
	li	$v0, 4			#put print code in reg
	syscall				#call print
	li	$v0, 5			#put input int code in reg
	syscall				#call read input	
	blez	$v0,input		#check n > 0
	
	#n > 0
main:
	move	$t0,$v0			#store n in t0
	addi	$t1,$zero,1		#add 1 to factorial result (f)
	
loop:
	addi	$t2,$t2,1		#add 1 to index (i)
	mult 	$t1,$t2			#Lo = f*i
	mflo	$t1			#f=t1=Lo
	bne	$t2,$t0,loop		#loop if i != n
	
output:
	la	$a0, tb2		#put string in reg for output
	li	$v0, 4			#put print code in reg
	syscall				#print output message
	
	move	$a0, $t1		#put result in correct reg for output		
	li	$v0, 1			#put print code in reg
	syscall				#print result
	
	li	$v0, 10			#put exit code in reg
	syscall				#exit program
	
	
	