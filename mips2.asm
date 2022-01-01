#JUAN LÓPEZ IGLESIAS Y DANIEL LÓPEZ GONZÁLEZ

.data

#cadena1:.asciiz "la casa de mama"
#cadena2:.asciiz "la csdme"
#cadena3: .asciiz "36"
#.include "aoc-strings.asm"

.text 	
.globl main
#biblioteca de funciones del trabajo final	
main:
	
	#la $a0,cadena1
#	la $a1, cadena2
	#la $a2,4
	la $a0,cadena3
	jal atoi
	add $a0,$v0,$zero
	li $v0,1
	syscall
	li $v0,10
	syscall
 
                     
                                         
#a0: direccion cadena                                                                                 
atoi:	
#Recibe una cadena con un numero decimal, lo codifica en binario y
#lo devuelve, si es muy grande devuelve 2 por $v1 y 1 si no es un numero	

	addi $t5, $zero, 0 	#variable que cuenta si es negativp
	addi $t1, $zero, 0 	#contador
inicio:	add $t2, $t1, $a0	#direccion byte a leer
	lb $t3, 0($t2)		
	bgt $t3, '9', caracter	#comprobar que sea un digito o signo
	bgt $t3, '/', bucleF
	bne $t3, '-', caracter
	addi $t5, $zero, 1 	#1 si es negativo
	addi $t1, $t1, 1	#i++
	b inicio		#leer siguiente byte despues del digito
bucleF:	sub $t3, $t3, '0'	#decodificar de ascii a binario
	addi $t1, $t1, 1		#i++
	add $t2, $t1, $a0	
	lb $t2, 0($t2)
	beqz $t2, fin		#si es byte a cero fin cadena
	bgt $t2, '9', fin	#comprobar que sea digito
	blt $t2, '0', fin	
	mul $t3, $t3, 10	#multiplicar para obtener orden de magnitud del digito
	blt $t3, $zero, overflow	#comprobar si hay overflow
	addu $t3, $t3, $t2	#sumar a lo acumulado
	bgt $t3, $zero,bucleF	#comprobar si hay overflow en suma, si no sigue bucle
overflow:addi $v1, $zero, 2	#2 en $v0 y termina
	jr $ra
fin:	beqz $t5,sinSigno	#comprobar si hay signo, si lo hay num = 0-num.abs
	sub $t3,$zero,$t3	
sinSigno:add $v0, $t3, $zero
	jr $ra 
caracter:addi $v1, $zero,1	#1 en $v1 si caracter no digito
	jr $ra
	

itoa:

	jr $ra
	
strcmp:	
	jr $ra
	
strncmp:	
	jr $ra	
	
	   
strSearch:
	jr $ra



#$a1: Dirección del string de búsqueda
#$a2: Carácter a buscar
containsChar:
	add $t0,$zero,$zero
	lb $t2,0($a1)
RecorridoCadena1_v4:
	add $t1,$t0,$a0
	lb  $t1,0($t1)
	beq $t1,$zero,NoCoincide_v4
	addi $t0,$t0,1
	bne $t1,$t2,RecorridoCadena1_v4
	addi $v0,$zero,0
	jr $ra
NoCoincide_v4:
	addi $v0,$zero,1
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
#mfc0 $k0, $13 # get EPC in $k0
#addiu $k0,$k0, 4 # make sure it points to next instruction
#rfe  # return from exception
#jr $k0 # replace PC with the return address

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

NoCoincide_v3:
	addi $v0,$zero,1
	jr $ra
	
	
#$a0: Dirección del string de búsqueda
#$a1: Dirección del string con los caracteres a buscar
containsOnlyChars:
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	
RecorridoCadena1_v5:
	add $t2,$t0,$a0
	lb  $t2,0($t2)
	addi $t0,$t0,1
	beq $t2,$zero,finCadena
			
RecorridoCadena2_v5:			
	add $t3,$t1,$a1
	lb  $t3,0($t3)
	addi $t1,$t1,1	
	beqz $t3,NoCoincide_v5
	bne $t3,$t2,RecorridoCadena2_v5
	add $t1,$zero,$zero
	add $v0,$zero,$zero
	b RecorridoCadena1_v5

NoCoincide_v5:
	addi $v0,$zero,1
	
finCadena:
	add $a0,$zero,$v0
	jr $ra
			
countTokens:
	jr $ra

getToken:
	jr $ra			
	
splitAtToken:
	move $v0, $a0
	jr $ra
	
sumaNumTokens:
	jr $ra	