#Juan Lopez Iglesias y Daniel Lopez Gonzalez
.data
cad_interna:  .asciiz "esto es una funcion de ejemplo que multiplica el argumento por 2\n"

.text 
#Función de ejemplo (eliminar para versión final)
funcExample:   
		move $t0, $a0
		la  $a0  cad_interna
  	        li   $v0 4  
	        syscall 
	        sll $v0, $t0, 1
	        jr $ra
	
#biblioteca de funciones del trabajo final	            
cambiarIntro:
	addi $t0, $zero, 0
inicBucle:add $t1, $t0, $a0
	lb $t2, 0($t1)
	addi $t0,$t0, 1
	bne $t2, '\n', inicBucle
	sb $zero, 0($t1)
	jr $ra
	
atoi:


	
#Recibe una cadena con un numero decimal, lo codifica en binario y
#lo devuelve, si es muy grande devuelve 2 por $v1 y 1 si no es un numero	
#a0: direccion cadena
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
	bgt $t2, ':', caracter	#comprobar que sea digito
	blt $t2, '/', caracter	
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
	

itoa:#Convierte numero de decimal a ascii //DEPURARRR
#$a0: Numero a convertir.
#$a1: Direccion de la cadena donde quedara el nUmero 
#	anterior en decimal codificado en ASCII
	addi $sp, $sp, -4
	sw $ra, 0($sp)			#salvar direccion retorno (funciones anidadas)
	slt $a2,$a0,$zero		#Se pone a 1 si es negativo (funcion invertir)
	abs $a0,$a0			#Utilizamos el valor absoluto por si es negativo
	addi $t3, $zero, 0
	addi $t0,$zero,10		#t0=10
	#add $t3, $a0,$zero	
	
Division:

	div $a0,$t0			#Se divide entre 10 para obtener los digitos hasta que el cociente sea 0 y se van introduciendo en la cadena
	bne $a0, $zero, sigNum		#si es 0 el cociente de la division termina si no es la primera iteracio
	bnez $t3, Stop			#si es la primera iteracion se ha de codificar el 0
sigNum:	mfhi $t4			#resto en t4 y cociente en a0 para obtener sig. digito
	mflo $a0			
	add $t4,$t4,'0'			#Se codifica el número en ASCII
	add $t5,$t3,$a1			#guardar byte codificado
	sb $t4,0($t5)
	addi $t3, $t3, 1
	b Division			# iterar
Stop:
	jal InvierteCadena		#invertir cadena para mostrarla en orden correcto
	lw $ra, 0($sp)			#cargar direccion retorno	
	addi $sp, $sp, 4
	jr $ra
	
#Invierte la cadena de la direccion dada y se añade signo si es negativo
#$a1 Direccion cadena a invertir
#$a2 indicador signo
InvierteCadena:
	li $t1, 0   	#Contador de la longitud
bucle:	add $t2,$t1, $a1	
 	lb $t0, 0($t2) 		#Leo un caracter de la cadena origen
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
 bucle2:lb $t0, 0($sp) 		#Desapilo una letra de la pila
 	addi $sp, $sp, 1
 	add $t3,$t2, $a1
 	sb $t0, 0($t3) 		#La guardo en la cadena de destino
 	addi $t2, $t2, 1
 	bne $t1, $t2, bucle2 	#Mientras me queden letras apiladas, sigo desapilando
 	add $t2,$t2, $a1
 	sb $zero, 0($t2)  	#Al final, almaceno el caracter fin de cadena
 	jr $ra 			#Fin de la funcion

#Cuenta el numero de veces que aparece el caracter en la cadena
#$a1 caracter a contar
#$a0 dir cadena
ContarC:addi $t0, $zero, 0 	#contador
	addi $v0, $zero, 0
BuclCont:add $t2, $t0, $a0 	#direccion cadena[i]	
	lb $t1, 0($t2)		#cargar caracter
	bne $t1, $a1, diff	#si son iguales se suma uno al retorno
	addi $v0, $v0, 1
diff:	addi $t0, $t0, 1	#i++
	bne $t1, $zero, BuclCont	#comprobar si cadena 
	jr $ra
	
strcmp:	
	jr $ra
	
strncmp:	
	jr $ra	
	
	   
strSearch:
	jr $ra

containsChar:
#$a0-direccion string de busqueda
#$a1- caracter a buscar
	addi $t0, $zero,$zero
bucleCad:addi $t1,$t0,$a0
	lb $t1, 0($t1)
	beqz $t1, finCad
	addi $t0,$t0,1
	bne $a1, $t1, bucleCad
	add $v0, $zero, $zero
	jr $ra
finCad: addi $v0,$zero,1
	jr $ra
	
	
containsAnyChar:
	jr $ra

containsSomeChars:
	jr $ra
	
containsAllChars:
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
