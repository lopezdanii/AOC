#juan lopez y daniel lopez
.data
#cadena1: .asciiz "-50 25 -250"
#cadena2: .asciiz "gasdasdasd"


.text
#.globl main
#main:

	
#	la $a0,cadena1
#	la $a1, cadena2
#	la $a2, ' '
#	jal sumaNumTokens
#	move $a0,$v0
#	li $v0,4
#	syscall
#	li $v0,10
#	syscall

#$a0:  Dirección de la cadena con los tokens
#$a1 - Dirección de la cadena destino
#$a2 - Carácter tokenizador. Cualquier carácter es un tokenizador válido, excepto '\0', '-', '+' y los caracteres numéricos ['0'-'9']	
sumaNumTokens:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	beqz $a2,CaracterInvalidoSumNum
	addi $t0,$zero,0
	
	bgt $a2,'9',TokenizadorValidoSumNum
	beq $a2,'+',CaracterInvalidoSumNum
	beq $a2,'-',CaracterInvalidoSumNum
	bgt $a2,'/',CaracterInvalidoSumNum	
TokenizadorValidoSumNum:
	
	
	add $t1,$zero,$a0
	addi $t9,$zero,0 #numero tokens
	
	
BucleSumNum:
	lb $t3,0($t1)
	addi $t1,$t1,1
	
	
	bgt $t3,'9',IncrementoTokenizadorSumNum
	blt $t3,'0',IncrementoTokenizadorSumNum
	
	
	sub $t3,$t3,48		#pasar a entero
	add $t5,$t7,$t3
	blt $t5, $zero, Error3SumNum
	
	mul $t7,$t5,10
	blt $t7, $zero, Error3SumNum
	
	
	
	b BucleSumNum

NegativoSumNum:
	addi $t4,$zero,1	#indicador de si es negativo	
	
	b BucleSumNum
IncrementoTokenizadorSumNum:
	beq $t4,1,RestaSumNum
SiguienteSumNum:
	add $t6,$t6,$t5	#suma total
	
	blt $t6,$zero,Error4SumNum
	beqz $t3,FinSumNum
	add $t5,$zero,$zero	#se ponen a 0 todas las variables utilizadas para guardar numero, para la siguiente vuelta
	add $t7,$zero,$zero
	#Es un numero, o caracter - o +
	beq $t3,'-',NegativoSumNum
	beq $t3,'+',BucleSumNum
	
	bne $t3,$a2,Error2SumNum
	addi $t9,$t9,1
	b BucleSumNum
RestaSumNum:
	sub $t5,$zero,$t5
	add $t4,$zero,$zero	
	b SiguienteSumNum
	
	

		#suma total
	
FinSumNum:
	add $a0,$zero,$t6
	add $v1,$zero,$zero
	jal itoa
	lw $ra, 0($sp)		#cargar direccion retorno	
	addi $sp, $sp, 4
	add $v0,$zero,$a1
	#add $v0,$zero,$t6
	jr $ra
Error4SumNum:
	addi $v1,$zero,4
	jr $ra	
Error3SumNum:
	addi $v1,$zero,3
	jr $ra			
Error2SumNum:
	addi $v1,$zero,2
	jr $ra		
CaracterInvalidoSumNum:
	addi $v1,$zero,1
	jr $ra	
	
	
#$a0: dirección de string de búsqueda
#$a1: caracter tokenizador
countTokens:
	
	jr $ra
	
atoi:
	jr $ra
itoa:
#Convierte numero de decimal a ascii //DEPURARRR
	addi $t3, $zero, 0
	addi $t4, $zero, 0
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
	add $t4,$t4,'0'			#Se codifica el nÃºmero en ASCII
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
	
#Invierte la cadena de la direccion dada y se aÃ±ade signo si es negativo
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
 	beq $a2,$zero, bucle2	#si a2 es 1 aÃ±adir signo antes del nÃºmero y aÃ±adir 1 
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

