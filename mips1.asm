#.data

#cadena1:.asciiz "containsAllChars"
#cadena2:.asciiz "aAcCh"

.text 	
#biblioteca de funciones del trabajo final	
#main:
	
#	la $a0,cadena1
#	la $a1, cadena2
	#la $a2,4
#	jal containsAllChars
#	add $a0,$v0,$zero
#	li $v0,1
#	syscall
#	li $v0,10
#	syscall
                     
atoi:
	jr $ra

itoa:

	jr $ra
	
strcmp:	
	jr $ra
	
strncmp:	
	jr $ra	
	
	   
strSearch:
	jr $ra

containsChar:
	jr $ra
	
	
#$a0: Dirección de string de búsqueda
#$a1: Dirección del string con los caracteres a buscar
containsAnyChar:
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	
RecorridoCadena1:
	
	add $t4,$t0,$a0
	lb  $t3,0($t4)
	
	beq $t3,$zero,NoCoincide
	addi $t0,$t0,1
RecorridoCadena2:
	
	add $t5,$t1,$a1
	lb  $t2,0($t5)
	addi $t1,$t1,1
	beq $t2,$zero,Vuelta
	

	bne $t2,$t3,RecorridoCadena2
	addi $v0,$zero,0
	jr $ra

Vuelta:	addi $t1,$zero,0
	b RecorridoCadena1

NoCoincide:
	addi $v0,$zero,1
	jr $ra
	
	
	
#$a0:Dirección del string de búsqueda
#$a1:Dirección del string con los caracteres a buscar0
#$a2: numero de caracteres a encontrar en $a0	
containsSomeChars:
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	add $t4,$zero,$zero
RecorridoCadena2_v2:
	add $t5,$t1,$a1
	lb  $t2,0($t5)
	addi $t1,$t1,1
	beq $t2,$zero,NoCoincide_v2
	
	
RecorridoCadena1_v2:
	
	
	add $t3,$t0,$a0
	lb  $t3,0($t3)
	
	beq $t3,$zero,Vuelta_v2
	addi $t0,$t0,1
	

	bne $t2,$t3,RecorridoCadena1_v2
	
	
	addi $t4,$t4,1
	add $t0,$zero,$zero
	#beq $t4,1,RecorridoCadena2_v2
	blt $t4,$a2,RecorridoCadena2_v2
	addi $v0,$zero,0
	jr $ra
NoIgual_v2:
	b RecorridoCadena2_v2
Vuelta_v2:	addi $t0,$zero,0
	b RecorridoCadena2_v2

NoCoincide_v2:
	addi $v0,$zero,1
	jr $ra
	
	

#$a0 - Dirección del string de búsqueda
#$a1 - Dirección del string con los caracteres a buscar	
containsAllChars:
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	
RecorridoCadena2_v3:
	add $t5,$t1,$a1
	lb  $t2,0($t5)
	addi $t1,$t1,1
	beq $t2,$zero,Coincide_v3
	
	
RecorridoCadena1_v3:

	add $t3,$t0,$a0
	lb  $t3,0($t3)
	beq $t3,$zero,NoCoincide_v3
	addi $t0,$t0,1
	
	
	bne $t2,$t3,RecorridoCadena1_v3
	add $t0,$zero,$zero
	b RecorridoCadena2_v3
	
	
Coincide_v3:
	addi $v0,$zero,0
	jr $ra
	
#Vuelta_v3:	addi $t1,$zero,0
	#b RecorridoCadena1_v3

NoCoincide_v3:
	addi $v0,$zero,1
	jr $ra
	
	
	
containsOnlyChars:
	jr $ra
			
countTokens:
	jr $ra

getToken:
	jr $ra			
	
splitAtToken:
	jr $ra
	
sumaNumTokens:
	jr $ra	