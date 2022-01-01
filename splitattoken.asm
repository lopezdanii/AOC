#juan lopez y daniel lopez
.data
#cadena1: .asciiz "  en  la  casa  de  mama"
#cadena2: .asciiz "aaaaaaaaaaaaaaaa"


.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1, ' '
#	la $a2,0
#	la $a3,cadena2
#	
#	jal splitAtToken
	
#	beq $v1,1,FinMain
#	move $s0,$v0
#	move $a0,$s0
#	li $v0,1
#	syscall
	
#	move $a0,$s0
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
	jr $ra

	
	
#$a0:Direccion del string de busqueda
#$a1: Caracter tokenizador
#$a2: Numero de token donde partiremos la cadena	
splitAtToken:
	bltz $a2,FormatoInvalidoSplitToken
	add $v0,$zero,$zero
	addi $v1,$zero,0
	add $t0, $zero,$zero
	add $t2, $zero,$zero #para dos tokenizadores seguidos
	addi $t3,$zero,0	#numero de tokens
	add $t5, $zero,$a0
	
	add $t1, $t0,$a0
	lb $t1,0($t1)
	add $t0,$t0,1
	beqz $t1,FormatoInvalidoSplitToken
	bne $t1,$a1,BucleSplitToken
InicioSplitToken:
	add $t1, $t0,$a0
	add $t6,$t1,$zero
	lb $t1,0($t1)
	add $t0,$t0,1
	beq $t1,$a1,InicioSplitToken
	beq $t3,$a2,FinSplitToken
BucleSplitToken:
	beq $t3,$a2,Fin2SplitToken
	add $t1, $t0,$a0
	lb $t1,0($t1)
	
	addi $t0,$t0,1
	beqz $t1,FinSplitToken
	
	add $t2,$t0,$zero
	add $t2,$t2,$a0
	lb $t7,0($t2)
	beq $t7,$t1,BucleSplitToken
	beqz $t7,FormatoInvalidoSplitToken
	
	bne $t1,$a1,BucleSplitToken
	addi $t3,$t3, 1
	bne $t3,$a2,BucleSplitToken
GuardaTokenSplitToken:
	add $t1, $t0,$a0
	add $t6,$t1,$zero

FinSplitToken:
	beqz $t3,IncrementoSplitToken
ComprobacionValidoSplitToken:
	bgt $a2,$t3,FormatoInvalidoSplitToken

	addi $v1,$zero,0
	add $v0,$t6,$zero
	jr $ra
Fin2SplitToken:
	add $v0,$t5,$zero
	jr $ra
IncrementoSplitToken:
	addi $t3,$t3,1
	bne $a2,$t3,ComprobacionValidoSplitToken
FormatoInvalidoSplitToken:
	addi $v1,$zero,1
	jr $ra



strcmp:
	jr $ra
strncmp:
	jr $ra
strSearch:
	jr $ra
sumaNumTokens:
	jr $ra
