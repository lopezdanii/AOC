
#juan lopez y daniel lopez
.data
#cadena1: .asciiz "ouh mamah"
#cadena2: .asciiz "abc"


.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1, cadena2
	#la $a2,5
#	jal strSearch
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
	jr $ra
strncmp:
	jr $ra

#$a0:Direccion de la primera cadena de caracteres
#$a1:Direccion de la segunda cadena de caracteres   
strSearch:
#Comprueba si la cadena a1 esta contenida en a0
	
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	add $t6,$zero,$zero
Cadena1StrSearch:
	add $t5,$t1,$a0
	lb  $t2,0($t5)
	addi $t1,$t1,1
	
	
	
Cadena2StrSearch:

	add $t3,$t0,$a1
	lb  $t3,0($t3)
	beq $t3,$zero,CoincideStrSearch
	beq $t2,$zero,NoCoincideStrSearch
	bne $t2,$t3,Cadena1StrSearch

	sub $t6,$t1,$t0
	addi $t0,$t0,1
	b Cadena1StrSearch
	
	
CoincideStrSearch:
	addi $t6,$t6,-1
	add $v0,$zero,$t6
	jr $ra

NoCoincideStrSearch:
	addi $v0,$zero,-1
	jr $ra
	
	


sumaNumTokens:
	jr $ra
