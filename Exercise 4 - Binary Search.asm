.data 
A:	.word 1 3 5 7 9 11 13 15
n:	.word 8
x:	.word 7
.text
	la	$a0,A
	lw	$a1,n			# Anzahl Eintraege im Array
	lw	$a2,x
	jal	BS
	j PRINT
	
BS:	addi	$sp,$sp,-24		# Platz auf dem Stack
	sw	$s0,0($sp)		# Übergabeparameter sichern
	sw	$s1,4($sp)		
	sw	$s2,8($sp)		
	sw	$s3,12($sp)		
	sw	$ra,16($sp)		# Rücksprungadresse sichern
	sw	$fp,20($sp)		# Rücksprungadresse sichern
	
	addi	$s0,$a1,0		# $s0=n
	addi	$t0,$a0,0		# $t0=addr(A)
	beq	$s0,$zero,NFOUND	# Ende bei n=0
	sra	$s1,$s0,1		# m=floor(n/2)				7->3		6->3
	sll	$t2,$s1,2		# $t2=m*4				12		12
	add	$t1,$t0,$t2		# addr(A[m)])				addr(A[3])      addr(A[3])
	lw	$s3,0($t1)		# $s3=A[m])			
	beq	$s3,$a2,FOUND		# A[n/2]=x	
					# nicht gefunden
	slt	$t3,$s3,$a2		# $t3=($t2<$a2) (A[floor(n/2)]<x)	
	beq	$t3,$zero,LEFT		# wenn NOT($t3) dann LEFT
					# x>A[floor(n/2)
	addi	$a0,$t1,4		# $a0: addr(A[floor(n/2)]+1)
	sub	$a1,$s0,$s1		# $a1: n-m-1				7-3-1=3		6-3-1=2
	addi	$a1,$a1,-1
	addi	$s2,$s1,1		# index: m				7:3+1=4		6:3+1=4
	jal	BS
	j	CONT
LEFT:	addi	$s2,$zero,0		# index = 0
	addi	$a1,$s1,0		# n=floor(n/2)				7:3		6:3
	jal	BS
CONT:					# zur?ck aus Rekursion
	addi 	$t0,$zero,-1
	bne	$v0,$t0,FOUNDR	# gefunden?		
	j	JB
FOUND: 	add	$v0,$s1,$zero		# Infex=m
	j	JB
FOUNDR:	add	$v0,$v0,$s2		# Index= Index + $s2
	j	JB
NFOUND:	addi	$v0, $zero, -1		# nicht gefunden
	j	JB	

JB:	lw	$s0,0($sp)		# Uebergabeparameter sichern
	lw	$s1,4($sp)		
	lw	$s2,8($sp)		
	lw	$s3,12($sp)		
	lw	$ra,16($sp)		# Ruecksprungadresse sichern
	lw	$fp,20($sp)		# Ruecksprungadresse sichern
	addi	$sp,$sp,24		# Platz auf dem Stack
	jr	$ra			# zurueckspringen
	
PRINT:
	add $s0,$v0,$zero
	add $s1,$v1,$zero
	bne $s0,$zero,P1
	la $a0,OUT2
	addi $v0,$zero,4
	syscall
	j END		
P1:	la $a0, OUT1
	addi $v0,$zero,4
	syscall 
	add $a0,$s1,$zero
	addi $v0,$zero,1
	syscall 
END:	
.data
OUT1:	.asciiz	"Found at Index: "
OUT2:	.asciiz "Not found"