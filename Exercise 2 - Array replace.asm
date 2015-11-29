   .data			# Daten auf den Hauptspeicher legen
A: .word 2 1 3			# Array mit 3 Zahlen anlegen
k: .word 3			# Größe des Arrays festlegen
b: .word 10			# Variable festlegen

.text				
	la $s0, A		# Adresse von Array A in $s0 speichern
	lw $s1, k 		# Lade Größe des Array (k) in $s1
	lw $s2, b		# Lade Variable b in Register $s2
	
	lw $t0, 0($s0)		# Lade ein Word (4 Byte) von der Adresse in $s0 nach $t0 (Der Offset ist 0)
	addi $t1, $s0, 0	# Lade Ergebnis der Addition von $s0 und 0 nach Register $t1
	addi $t3, $s0, 4	# Lade Ergebnis der Addition von $s0 und 4 nach Register $t3
	sll $s1, $s1, 2		# Logischer Shift um 2 Bit nach links
	add $t2, $s0, $s1	# Lade Ergebnis der Addition von $s0 und $1 nach Register $t2

TESTK:	beq $t3, $t2, END	# Wenn Inhalt der Register $t3 und $t2 identisch sind verzweige nach END
	lw $t4, 0($t3)		# Lade ein Word von der Adresse in $t3 nach $t4 (Der Offset ist 0)	 
	slt $t5, $t4, $t0	# Wenn $t4 kleiner ist als $t0 schreibe eine 1 in $t5, ansonsten schreibe eine 0 in $t5
	beq $t5, $zero, NEXT	# Wenn Inhalt von Register $t5 gleich 0 ist verzweige nach NEXT
	addi $t0, $t4, 0	# Lade Ergebnis der Addition von $t4 und 0 nach Register $t0
	addi $t1, $t3, 0	# Lade Ergebnis der Addition von $t3 und 0 nach Register $t1

NEXT:	addi $t3, $t3, 4	# Lade Ergebnis der Addition von $t3 und 4 nach Register $t3
	j TESTK			# Springe nach TESTK 

END:	sw $s2, 0($t1)		#  Inhalt von $s2 wird an die Adresse von $t1 geschrieben
