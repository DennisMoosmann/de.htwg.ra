.data
	a: .word 10			# Store value in memory
	b: .word 20			# Store value in memory
.text

	lw $s0, a			# Load word from memory 
	lw $s1, b			# Load word from memory

	sub $a0, $s0, $s1		# $a0 = $s0 - $s1
	jal ABS				# Jump to ABS
	move $s3, $v0			# Move return value of function ABS ($v0) to $s3
	j EXIT				# Jump to EXIT

ABS:
	blt $a0, $zero, NEGATIVE	# If $a0 < $zero branch to NEGATIVE
	move $v0, $a0			# Else move $a0 to $v0 
	jr $ra				# Jump to caller
	
NEGATIVE:
	sub $v0,$zero,$a0		# $v0 = 0 - $a0
	jr $ra				# Jump to caller

EXIT:					# End of program
	


