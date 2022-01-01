#juan lopez y daniel lopez
.data
#cadena1: .asciiz " asd  asd"
#cadena2: .asciiz "g"


.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1, ' '
	#la $a2,5
#	jal countTokens
#	move $a0,$v0
#	li $v0,1
#	syscall
#	li $v0,10
#	syscall
#$a0: dirección de string de búsqueda
#$a1: caracter tokenizador
countTokens:
	beq $a1,$zero,NoToken
	add $t0, $zero,$zero
	#add $t2, $zero,$zero
	addi $v0,$zero,1

	add $t1, $t0,$a0
	lb $t1,0($t1)
	add $t0,$t0,1
	beqz $t1,CadenaVaciaCountToken
	bne $t1,$a1,BucleCountToken
InicioCountToken:
	add $t1, $t0,$a0
	lb $t1,0($t1)
	add $t0,$t0,1
	beq $t1,$a1,InicioCountToken

	
BucleCountToken:
	add $t1, $t0,$a0
	lb $t1,0($t1)
	addi $t0,$t0,1
	beqz $t1,FinCountToken
	#beq $t2,$t1,SiguienteCountToken
	#add $t2,$t1,$zero
	add $t3, $t0,$a0
	lb $t3,0($t3)
	beq $t3,$t1,BucleCountToken
	beqz $t3,FinCountToken
	
	bne $t1,$a1,BucleCountToken
	addi $v0,$v0, 1
	b BucleCountToken	

CadenaVaciaCountToken:
	add $v0,$zero,$zero
	jr $ra
NoToken:
	addi $v0,$zero,1
FinCountToken:
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
strcmp:
	jr $ra
strncmp:
	jr $ra
strSearch:
	jr $ra
sumaNumTokens:
	jr $ra
