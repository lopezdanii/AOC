
.data
#cadena1: .asciiz ""
#cadena2: .asciiz ""
.text
#.globl main
#main:

#	
#	la $a0,cadena1
#	la $a1, cadena2
#	la $a2,4
#	jal containsSomeChars
#	move $a0,$v0
#	li $v0,1
#	syscall
#	li $v0,10
#	syscall





#$a0:Dirección del string de búsqueda
#$a1:Dirección del string con los caracteres a buscar0
#$a2: numero de caracteres a encontrar en $a0	
containsSomeChars:
	blt $a2,1,NoValidoSomeChars
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	add $t4,$zero,$zero
	
Cadena2SomeChars:
	add $t5,$t1,$a1
	lb  $t2,0($t5)
	addi $t1,$t1,1
	beq $t2,$zero,NoCoincideSomeChars
	
	
Cadena1SomeChars:
	add $t3,$t0,$a0
	lb  $t3,0($t3)
	
	beq $t3,$zero,VueltaSomeChars
	addi $t0,$t0,1
	
	bne $t2,$t3,Cadena1SomeChars
		
	addi $t4,$t4,1
	add $t0,$zero,$zero

	blt $t4,$a2,Cadena2SomeChars
	addi $v0,$zero,0
	add $v1,$zero,$zero
	jr $ra
NoIgualSomeChars:
	b Cadena2SomeChars
VueltaSomeChars:
	addi $t0,$zero,0
	b Cadena2SomeChars

NoCoincideSomeChars:
	add $v1,$zero,$zero
	addi $v0,$zero,1
	bgt $a2,$t1,NoValidoSomeChars
	jr $ra
	
NoValidoSomeChars:
	addi $v1,$zero,1
	jr $ra
	

	
atoi:
	jr $ra
itoa:
	jr $ra
containsAllChars:
	jr $ra
containsAnyChar:
	jr $ra

containsOnlyChars:
	jr $ra
containsChar:
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
countTokens:
	jr $ra
