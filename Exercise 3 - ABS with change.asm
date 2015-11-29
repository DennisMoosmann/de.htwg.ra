.data
	A: .word 1 8 7
	B: .word 3 4 1
	C: .word 0 0 0
	k: .word 3
.text
	la $s0, A
	la $s1, B
	la $s2, C
	la $s3, k
	
	move $t0, $zero
	lw $t2, 0($s3)
	
LOOP:	addi $t0, $t0, 1
	lw $a0, 0($s0)
	lw $a1, 0($s1)
	
	slt $t1, $a1, $a0
	bne $t1, $zero, CHANGE
	jal ABS
	sw $v0, 0($s2)
	#Adress increase
	addi $s0, $s0, 4
	addi $s1, $s1, 4
	addi $s2, $s2, 4
	bne $t0, $t2, LOOP
	j EXIT
	
	
CHANGE:
	move $t3, $a0
	move $a0, $a1
	move $a1, $t3 
	  
ABS:
	sub $v0, $a1, $a0
	jr $ra

EXIT: