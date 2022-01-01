
#juan lopez y daniel lopez
.data
#cadena1: .asciiz ""
#cadena2: .asciiz "a"


.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1, cadena2
	#la $a2,5
#	jal strcmp
#	move $a0,$v0
#	li $v0,1
#	syscall
#	li $v0,10
#	syscall

#$a0: dirección de string de búsqueda
#$a1: caracter tokenizador
countTokens:
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
containsOnlyChars:
	jr $ra
containsSomeChars:
	jr $ra
getToken:
	jr $ra
splitAtToken:
	move $v0, $a0
	jr $ra
	
#$a0: Dirección de la primera cadena de caracteres
#$a1: direccion de la segunda cadena de caracteres
strcmp:	
	addi $t0,$zero,0
	addi $t3,$zero,0
	
bucleStrCmp:
	add $t1,$t0,$a0
	add $t4,$t3,$a1
	
	lb $t2,0($t1)
	addi $t0,$t0,1
	
	lb $t5,0($t4)
	addi $t3,$t3,1
	
	
	blt $t2,$t5,MenorStrCmp
	bgt $t2,$t5,MayorStrCmp
	
	bnez $t2,bucleStrCmp
	addi $v0,$zero,0 
	jr $ra
MayorStrCmp:
	addi $v0,$zero,1
	jr $ra
MenorStrCmp:
	addi $v0,$zero,-1
	jr $ra
	
	
strncmp:
	jr $ra
strSearch:
	jr $ra
sumaNumTokens:
	jr $ra
