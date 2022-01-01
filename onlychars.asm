
.data
#cadena1: .asciiz ""
#cadena2: .asciiz ""


.text
#.globl main
#main:

	
	#la $a0,cadena1
	#la $a1, cadena2
	#la $a2,5
	#jal containsOnlyChars
	#move $a0,$v0
	#li $v0,1
	#syscall
	#li $v0,10
	#syscall

	
#$a0: Dirección del string de búsqueda
#$a1: Dirección del string con los caracteres a buscar
containsOnlyChars:
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	add $t2,$t0,$a0
	lb  $t2,0($t2)
	addi $t0,$t0,1
	beq $t2,$zero,CadenaVacia
Cadena1OnlyChars:
	add $t2,$t0,$a0
	lb  $t2,0($t2)
	addi $t0,$t0,1
	beq $t2,$zero,finCadenaOnlyChars
			
Cadena2OnlyChars:			
	add $t3,$t1,$a1
	lb  $t3,0($t3)
	addi $t1,$t1,1	
	beqz $t3,NoCoincideOnlyChars
	bne $t3,$t2,Cadena2OnlyChars
	add $t1,$zero,$zero
	add $v0,$zero,$zero
	b Cadena1OnlyChars

NoCoincideOnlyChars:
	addi $v0,$zero,1
	
finCadenaOnlyChars:
	add $a0,$zero,$v0
	jr $ra
CadenaVacia:
	add $v0,$zero,$zero,
	jr $ra
	
atoi:
	jr $ra
itoa:
	jr $ra
containsAllChars:
	jr $ra
containsAnyChar:
	jr $ra
containsChar:
	jr $ra
countTokens:
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
