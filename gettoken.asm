#juan lopez y daniel lopez
.data
#cadena1: .asciiz "  en  la  casa  de  mama"
#cadena2: .asciiz "aaaaaaaaaaaaaaaa"


.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1, ' '
#	la $a2,3
#	la $a3,cadena2
	
#	jal getToken
	
#	beq $v1,1,FinMain
	
#	move $a0,$v0
#	li $v0,4
#	syscall
#FinMain:
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

#$a0:Direccion del string de busqueda
#$a1: Caracter tokenizador
#$a2: Numero de token a obtener
#$a3: Direccion de la cadena donde se guarda el token
getToken:
	bltz $a2,FormatoInvalidoGetToken
	addi $v1,$zero,0	#Inicializacion
	add $t0, $zero,$zero
	add $t2, $zero,$zero #para dos tokenizadores seguidos
	addi $t3,$zero,0	#numero de tokens
	add $t5, $zero,$zero
	

	add $t1, $t0,$a0
	lb $t1,0($t1)
	add $t0,$t0,1
	beqz $t1,FormatoInvalidoGetToken
	bne $t1,$a1,BucleGetToken
InicioGetToken:
	add $t1, $t0,$a0
	lb $t1,0($t1)
	add $t0,$t0,1
	beq $t1,$a1,InicioGetToken
BucleGetToken:
	beq $t3,$a2,GuardaPrimerTokenGetToken
	add $t1, $t0,$a0
	lb $t1,0($t1)
	
	addi $t0,$t0,1
	beqz $t1,FinGetToken
	
	add $t2,$t0,$zero
	add $t2,$t2,$a0
	lb $t7,0($t2)
	beq $t7,$t1,BucleGetToken
	beqz $t7,FormatoInvalidoGetToken
	
	bne $t1,$a1,BucleGetToken
	addi $t3,$t3, 1
	bne $t3,$a2,BucleGetToken
GuardaTokenGetToken:
	
	add $t1, $t0,$a0
	lb $t1,0($t1)
	addi $t0,$t0,1
	beqz $t1,FinGetToken
	beq $t1,$a1,FinGetToken
	bne $t3,$a2,FinGetToken
	
GuardaPrimerTokenGetToken:
	add $t4,$t5,$a3	
	sb $t1,0($t4)
	addi $t5,$t5,1
	b GuardaTokenGetToken
FinGetToken:
	beqz $t3,IncrementoGetToken
ComprobacionValido:
	bgt $a2,$t3,FormatoInvalidoGetToken
	add $t4,$t5,$a3	
	sb $zero,0($t4)
	addi $v1,$zero,0
	add $v0,$a3,$zero
	jr $ra
IncrementoGetToken:
	addi $t3,$t3,1
	bne $a2,$t3,ComprobacionValido
FormatoInvalidoGetToken:
	addi $v1,$zero,1
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
