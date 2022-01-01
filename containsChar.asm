.data
#cadena1: .asciiz ""
#cadena2: .asciiz "g"
.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1,'a'
#	#la $a2,5
#	jal containsChar
#	move $a0,$v0#
#	li $v0,1
#	syscall
#	li $v0,10
#	syscall





#$a0: Dirección del string de búsqueda
#$a1: Carácter a buscar
containsChar:
	add $t0,$zero,$zero
	
	beqz $a1,VacioContainsChar
Cadena1ContainsChar:
	add $t1,$t0,$a0
	lb  $t1,0($t1)
	beq $t1,$zero,NoCoincideContainsChar
	addi $t0,$t0,1
	bne $t1,$a1,Cadena1ContainsChar
	addi $v0,$zero,0
	jr $ra
NoCoincideContainsChar:
	addi $v0,$zero,1
	jr $ra
VacioContainsChar:
	addi $v0,$zero,0
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
countTokens:
	jr $ra