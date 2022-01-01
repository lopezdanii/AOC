

#juan lopez y daniel lopez
.data
#cadena1: .asciiz "     +++33bz"
#cadena2: .asciiz "abc"
#cadena3: .asciiz ""

.text
#.globl main
#main:

	
#	addi $a0,$zero,2147483648
#	la $a1, cadena3
#	la $a2,5
#	jal itoa
#	move $a0,$v0
#	li $v0,4
#	syscall
#	li $v0,10
#	syscall


countTokens:
	jr $ra


#a0: direccion cadena                                                                                 
atoi:	
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




