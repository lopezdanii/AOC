
.data
#cadena1: .asciiz ""
#cadena2: .asciiz ""
.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1, cadena2
#	la $a2,5
#	jal containsAnyChar
#	move $a0,$v0
#	li $v0,1
#	syscall
#	li $v0,10
#	syscall





#$a0:Direcci�n del string de b�squeda
#$a1:Direcci�n del string con los caracteres a buscar0
#$a2: numero de caracteres a encontrar en $a0	
containsSomeChars:
	jr $ra
	
atoi:
	jr $ra
itoa:
	jr $ra
containsAllChars:
	jr $ra

#$a0: Direcci�n de string de b�squeda
#$a1: Direcci�n del string con los caracteres a buscar
containsAnyChar:
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	
Cadena1CntAnyChar:
	
	add $t4,$t0,$a0
	lb  $t3,0($t4)
	
	beq $t3,$zero,NoCoincideCntAnyChar
	addi $t0,$t0,1
Cadena2CntAnyChar:
	
	add $t5,$t1,$a1
	lb  $t2,0($t5)
	addi $t1,$t1,1
	beq $t2,$zero,VueltaCntAnyChar
	

	bne $t2,$t3,Cadena2CntAnyChar
	addi $v0,$zero,0
	jr $ra

VueltaCntAnyChar:
	addi $t1,$zero,0
	b Cadena1CntAnyChar

NoCoincideCntAnyChar:
	addi $v0,$zero,1
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