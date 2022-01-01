#JUAN L�PEZ IGLESIAS Y DANIEL L�PEZ GONZ�LEZ

.data
#######################
#        PRUEBAS      #
#######################

#cadena1:.asciiz "acaba"
cadena2:.asciiz "abcsdfsdfsdfsdfsdfsdfsdf"
#cadena3: .asciiz "z"
cadena3: .asciiz "12 12"
#cadena4: .space 100
#cadenaErrorOverflow: .asciiz "Error por desbordamiento"
#cadenaError2: .asciiz " : Par�metro no valido :"
#.include "aoc-strings.asm"

.text 	
.globl main
#biblioteca de funciones del trabajo final	
main:
#	la $a0,cadena1
	la $a1, cadena2
	#la $a2,cadena3
	la $a0,cadena3
	la $a2,' '
	#la $a0,20000000000
	#la $a1,cadena4
	jal sumaNumTokens
	add $a0,$v0,$zero
	li $v0,4
	syscall

	li $v0,10
	syscall
                                      
#a0: direccion cadena                                                                                 
                                                                                
atoi:	
#Recibe una cadena con un numero decimal, lo codifica en binario y
#lo devuelve, si es muy grande devuelve 2 por $v1 y 1 si no es un numero	
		#2 en $v1 si caracter no digito
	jr $ra



#$a0: Numero a convertir.
#$a1: Direccion de la cadena donde quedara el nUmero 
#anterior en decimal codificado en ASCII
itoa:
#Convierte numero de decimal a ascii //DEPURARRR
	addi $t3, $zero, 0
	addi $t0,$zero,10	#t0=10
	
	add $t7,$zero,$zero
	addi $sp, $sp, -4
	sw $ra, 0($sp)			#salvar direccion retorno (funciones anidadas)
	slt $a2,$a0,$zero
				#Se pone a 1 si es negativo (funcion invertir)
	bne $a2,1,Division
	bne $a0,-2147483648,LimiteItoA	
	
	addi $a0,$a0,1
	addi $t9,$zero,1 	#1 si limite inferior
	#hacer arreglo
LimiteItoA:
	abs $a0,$a0			#Utilizamos el valor absoluto por si es negativo
	
Division:

	div $a0,$t0			#Se divide entre 10 para obtener los digitos hasta que el cociente sea 0 y se van introduciendo en la cadena
	bne $a0, $zero, sigNum		#si es 0 el cociente de la division termina si no es la primera iteracio
	bnez $t3, Stop			#si es la primera iteracion se ha de codificar el 0
sigNum:	mfhi $t4			#resto en t4 y cociente en a0 para obtener sig. digito
	mflo $a0			
	add $t4,$t4,'0'			#Se codifica el número en ASCII
		#comprobar si hay overflow
	add $t5,$t3,$a1			#guardar byte codificado
	sb $t4,0($t5)
	addi $t3, $t3, 1
	b Division
#overflow2:
	
	#la $a0,cadenaErrorOverflow
#	add $v0,$a0,$zero
#	addi $v1, $zero, 1	#1 en $v1 y termina
#	jr $ra				# iterar
Stop:
	add $t3,$t3,$a1
	sb $zero,  0($t3)
	bne $t9,1,LlamadaItoA
	lb $t2,0($a1)
	addi $t8,$zero,56		#Si  limite inferior entonces restauramos la ultima unidad
	sb $t8,0($a1)
LlamadaItoA:
	jal InvierteCadena		#invertir cadena para mostrarla en orden correcto
	lw $ra, 0($sp)			#cargar direccion retorno	
	addi $sp, $sp, 4
	jr $ra
	
#Invierte la cadena de la direccion dada y se añade signo si es negativo
#$a1 Direccion cadena a invertir
#$a2 indicador signo
InvierteCadena:
	
	li $t1, 0   	#Contador de la longitud
bucle:	add $t6,$t1, $a1	
 	lb $t0, 0($t6) 		#Leo un caracter de la cadena origen
	beqz $t0, desapila 	#Si es el fin de cadena, he acabado de leer
	addi $sp, $sp, -1  	#Apilo el caracter en la pila
	sb $t0, 0($sp)
	addi $t1, $t1, 1 	#Cuento que he apilado un caracter mas
	j bucle
desapila:
 #Ya he apilado toda la cadena, la desapilo y la voy guardando  
 	li $t2, 0		#contador
 	beq $a2,$zero, bucle2	#si a2 es 1 añadir signo antes del número y añadir 1 
 	addi $t1, $t1, 1	#al contador para la pos y al contador de longitud
 	addi $t4, $zero, 45
 	add $t3,$t2, $a1
 	sb $t4, 0($t3)
 	addi $t2, $t2, 1
 bucle2:
 	
 	lb $t0, 0($sp) 		#Desapilo una letra de la pila
 	addi $sp, $sp, 1
 	add $t3,$t2, $a1
 	sb $t0, 0($t3) 		#La guardo en la cadena de destino
 	addi $t2, $t2, 1
 	bne $t1, $t2, bucle2 	#Mientras me queden letras apiladas, sigo desapilando
 	add $t2,$t2, $a1
 	sb $zero, 0($t2)  	#Al final, almaceno el caracter fin de cadena
 	add $v0,$a1,$zero
 	jr $ra 			#Fin de la funcion






#########################################################333
###############################################################3
##################################3############################33
###############################################################3
################################3#############################3



#Cuenta el numero de veces que aparece el caracter en la cadena
#$a1 caracter a contar
#$a0 dir cadena
#ContarC:addi $t0, $zero, 0 	#contador
#	addi $v0, $zero, 0
#BuclCont:add $t2, $t0, $a0 	#direccion cadena[i]	
#	lb $t1, 0($t2)		#cargar caracter
#	bne $t1, $a1, diff	#si son iguales se suma uno al retorno
#	addi $v0, $v0, 1
#diff:	addi $t0, $t0, 1	#i++
#	bne $t1, $zero, BuclCont	#comprobar si cadena 
#	jr $ra
	


















#$a0: Direcci�n de la primera cadena de caracteres
#$a1: direccion de la segunda cadena de caracteres	
strcmp:	
	
	jr $ra

	
	
#$a0: direccion de la primera cadena de caracteres
#$a1:direccion de la segunda cadena de caracteres
#$a2: numero de caracteres a comprobar	
strncmp:
	
	jr $ra
	
	
	
	
	
	
#$a0:Direccion de la primera cadena de caracteres
#$a1:Direccion de la segunda cadena de caracteres   
strSearch:
#Comprueba si la cadena a1 esta contenida en a0
	
	jr $ra
	
	






#$a0: Direcci�n del string de b�squeda
#$a1: Car�cter a buscar
containsChar:
	
	jr $ra	
	

	
#$a0: Direcci�n de string de b�squeda
#$a1: Direcci�n del string con los caracteres a buscar
containsAnyChar:
	
	jr $ra
	
	
	
	
#$a0:Direcci�n del string de b�squeda
#$a1:Direcci�n del string con los caracteres a buscar0
#$a2: numero de caracteres a encontrar en $a0	
containsSomeChars:
	
	jr $ra
	
	

	

#$a0 - Direcci�n del string de b�squeda
#$a1 - Direcci�n del string con los caracteres a buscar	
containsAllChars:
	
	jr $ra
	
	
	
	
	
#$a0: Direcci�n del string de b�squeda
#$a1: Direcci�n del string con los caracteres a buscar
containsOnlyChars:
	
	jr $ra
			
#$a0: direcci�n de string de b�squeda
#$a1: caracter tokenizador						
countTokens:
	
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
#$a0:Direccion del string de busqueda
#$a1: Caracter tokenizador
#$a2: Numero de token donde partiremos la cadena	
splitAtToken:
	jr $ra

#$a0 direccion cadena a sumar
#a1 direccion donde dejar suma
#a2 char tokenizador

sumaNumTokens:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	bgt $a2, '9', CorrectoT
	bgt $a2, '/', ETokenizador
	beq $a2, '\0', ETokenizador
	beq $a2, '+', ETokenizador
	bne $a2, '-', CorrectoT
ETokenizador:
	addi $v1, $zero, 1
	j FinE
CorrectoT:
	add $t1, $zero, $zero #i
	add $t2, $zero, $zero #cuenta
	add $t3, $zero, $zero  #marca inicio token
	add $t4, $zero, $zero #dir
	add $t6, $zero, $zero #acumulador num
	add $t7, $zero, $zero #indica negativo
BucleSNT:
	add $t4, $a0, $t1
	lb $t5, 0($t4)
	beq $t5, '\0', FinSNT
	bgt $t5, '9', EToken
	bgt $t5, '/', CorrectoN	
	beq $t5, ' ', ComprobarI
	beq $t5, '+', ComprobarI
	beq $t5, '-', ComprobarN
	bne $t5, $a2, EToken
	beq $t3, $zero, EToken
	beq $t7, $zero, NPositivo
	sub $t6, $zero, $t6
NPositivo:
	add $t2, $t2, $t6
	add $t6, $zero, $zero
	bge $t2,$zero, NoOverf
	addi $v1, $zero, 4
	j FinE
ComprobarI:
	bnez $t3, EToken
	addi $t1, $t1, 1
	j BucleSNT
ComprobarN:
	bnez $t3, EToken
	addi $t7, $t7, 1
	addi $t1, $t1, 1
	j BucleSNT
EToken: addi $v1, $zero, 2
	j FinE
NoOverf:addi $t1, $t1, 1
	add $t3, $zero, $zero
	j BucleSNT
CorrectoN:
	bnez $t3, SeguirSNT
	add $t3,$t3, $zero
SeguirSNT:mul $t6, $t6, 10
	blt $t6, $zero, EOverflowP
	subi $t5, $t5,'0'
	add $t6, $t6, $t5
	bge $t6, $zero, Seguir1
EOverflowP:
	addi $v1, $zero, 3
	j FinE
Seguir1:addi $t1, $t1, 1
	j BucleSNT
FinSNT: add $t4, $zero, $a0
	move $a0, $t2
	jal itoa
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $v1,$zero,0
FinE:	jr $ra	
