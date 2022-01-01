#juan lopez y daniel lopez
.data
#cadena1: .asciiz ""
#cadena2: .asciiz ""


.text
#.globl main
#main:

	
	#la $a0,cadena1
	#la $a1, cadena2
	#la $a2,5
	#jal containsAllChars
	#move $a0,$v0
	#li $v0,1
	#syscall
	#li $v0,10
	#syscall

#$a0: dirección de string de búsqueda
#$a1: caracter tokenizador
countTokens:
	jr $ra
	
atoi:
	jr $ra
itoa:
	jr $ra

#$a0 - Dirección del string de búsqueda
#$a1 - Dirección del string con los caracteres a buscar	
containsAllChars:
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	add $t3,$t0,$a0
	lb  $t3,0($t3)
	#addi $t0,$t0,1
	beqz $t3,CoincideAllChars
Cadena2AllChars:
	add $t5,$t1,$a1
	lb  $t2,0($t5)
	addi $t1,$t1,1
	beq $t2,$zero,CoincideAllChars
		
Cadena1AllChars:
	add $t3,$t0,$a0
	lb  $t3,0($t3)
	beq $t3,$zero,NoCoincideAllChars
	addi $t0,$t0,1
	
	bne $t2,$t3,Cadena1AllChars
	add $t0,$zero,$zero
	b Cadena2AllChars
CoincideAllChars:
	addi $v0,$zero,0
	jr $ra
NoCoincideAllChars:
	addi $v0,$zero,1
	jr $ra
	
	
	
	
containsAnyChar:
	jr $ra
containsChar:
	jr $ra
containsOnlyChars:
	jr $ra
containsSomeChars:
	jr $ra
getToken:
	jr $ra
splitAtToken:
	move $v0, $a0
	jr $ra
strcmp:
	jr $ra
strncmp:
	jr $ra
strSearch:
	jr $ra
sumaNumTokens:
	jr $ra
