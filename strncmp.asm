.data
#cadena1: .asciiz ""
#cadena2: .asciiz ""


.text
#.globl main
#main:

	
	#la $a0,cadena1
	#la $a1, cadena2
	#la $a2,4
	#jal strncmp
	#move $a0,$v1
	#li $v0,1
	#syscall
	
	
	#move $a0,$v0
	#li $v0,1
	#syscall
	#li $v0,10
	#syscall



##$a0:Dirección del string de búsqueda
#$a1:Dirección del string de busqueda 2
#$a2: numero de caracteres a comprobar	
strncmp:
	blt $a2,0,NoValidoStrNCmp
	beq $a2,0,finCadenaStrNCmp
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	add $t4,$zero,$zero
BucleStrNCmp:
	add $t2,$t0,$a0
	lb $t2,0($t2)
	addi $t0,$t0,1	


	add $t3,$t1,$a1
	lb $t3,0($t3)
	addi $t1,$t1,1	
	beqz $t2,finCadenaStrNCmp
	beqz $t3,finCadenaStrNCmp
	bgt $t2,$t3,MayorStrNCmp
	blt $t2,$t3,MenorStrNCmp
	
	addi $t4,$t4,1
	
	blt $t4,$a2,BucleStrNCmp
	add $v0,$zero,0 
	add $v1,$zero,$zero
	jr $ra
finCadenaStrNCmp:	
	addi $v0,$zero,0 
	add $v1,$zero,$zero
	jr $ra
	
MayorStrNCmp:
	addi $v0,$zero,1
	add $v1,$zero,$zero
	jr $ra
MenorStrNCmp:
	addi $v0,$zero,-1
	add $v1,$zero,$zero
	jr $ra	
NoValidoStrNCmp:
	addi $v1,$zero,1
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
#$a0: dirección de string de búsqueda
#$a1: caracter tokenizador
countToken:
	jr $ra
	
atoi:
	jr $ra
itoa:
	jr $ra
containsAllChars:
	jr $ra
containsOnlyChars:
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

strSearch:
	jr $ra
sumaNumTokens:
	jr $ra

