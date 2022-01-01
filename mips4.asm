#JUAN LÓPEZ IGLESIAS Y DANIEL LÓPEZ GONZÁLEZ

.data
#######################
#        PRUEBAS      #
#######################

#cadena1:.asciiz "acaba"
#cadena2:.asciiz "abc"
#cadena3: .asciiz "z"
#cadena3: .asciiz "200000000"
#cadena4: .space 100
#cadenaErrorOverflow: .asciiz "Error por desbordamiento"
#cadenaError2: .asciiz " : Parámetro no valido :"
#.include "aoc-strings.asm"

.text 	
#.globl main
#biblioteca de funciones del trabajo final	
#main:
#	la $a0,cadena1
#	la $a1, cadena2
	#la $a2,cadena3
	#la $a0,cadena3
#	la $a2,0
	#la $a0,20000000000
	#la $a1,cadena4
	#jal atoi
	#add $a0,$v0,$zero
	#li $v0,1
	#syscall

	#li $v0,10
	#syscall

       
              
        
               
                            
#$a0: direccion cadena                                                                                                                                                          
atoi:	
#Recibe una cadena con un numero decimal, lo codifica en binario y
#lo devuelve, si es muy grande devuelve 2 por $v1 y 1 si no es un numero	
	add $v1,$zero,$zero
	addi $t5, $zero, 0 	#variable que cuenta si es negativo
	addi $t4, $zero, 0 	#variable que cuenta si es positivo
	add $t1, $zero, $a0 	#contador
inicioAtoI:			#direccion byte a leer
	lb $t3, 0($t1)	

	beq $t3,' ',espacio
	beq $t3,'+',positivo	
	bgt $t3, '9', caracter	#comprobar que sea un digito o signo
	bgt $t3, '/', bucleF
	bne $t3, '-', caracter
	addi $t5, $t5, 1   #se suma uno a los negativos
	addi $t1, $t1, 1			#leer siguiente byte despues del digito
	beq $t5,$t4,caracter
	blt $t5,2, inicioAtoI
	addi $v1,$zero,2
	jr $ra		
bucleF:	sub $t3, $t3, '0'	#decodificar de ascii a binario
	addi $t1, $t1, 1		#i++
		
	lb $t2, 0($t1)
	#beqz $t2, finAtoI		#si es byte a cero fin cadena
	bgt $t2, '9', finAtoI	#comprobar que sea digito
	blt $t2, '0', finAtoI
		
	mul $t3, $t3, 10	#multiplicar para obtener orden de magnitud del digito
	blt $t3, $zero, overflow	#comprobar si hay overflow
	addu $t3, $t3, $t2	#sumar a lo acumulado
	
	bgt $t3, $zero,bucleF	#comprobar si hay overflow en suma, si no sigue bucle
	#add $t0,$t1,$a0
	#sb $zero, 0($t0)
	subu $t3,$t3,$t2
	bgt $t2,'8',overflow
	blt $t2,'8',UltimaAtoI
	bne $t5,1,overflow
	sub $t2,$t2,'0'
	sub $t3,$zero,$t3
	sub $t3,$t3,$t2
	add $v1,$zero,$zero
	add $v0, $t3, $zero
	jr $ra
UltimaAtoI:
	sub $t2,$t2,'0'
	add $t3,$t3,$t2	
finAtoI:
	#add $t0,$t1,$a0
	#sb $zero, 0($t0)
	beqz $t5,overflow2	#comprobar si hay signo, si lo hay num = 0-num.abs
	sub $t3,$zero,$t3
overflow2: 
	srl $t0,$t3,31
	bne $t5,$t0,overflow	
			
sinSigno:
	add $v1,$zero,$zero
	add $v0, $t3, $zero
	jr $ra 
espacio: addi $t1,$t1,1
	b inicioAtoI
positivo:
	addi $t4,$t4,1			#contamos el numero de signos positivos
	addi $t1, $t1, 1
	beq $t5,$t4,caracter
	blt $t4,2,inicioAtoI		#si es 2 o mas entonces debe dar error y salir
	addi $v1,$zero,2
	jr $ra
overflow:
	addi $v1, $zero, 1	#1 en $v0 y termina
	jr $ra
caracter:addi $v1, $zero,2	#2 en $v1 si caracter no digito
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
	


















#$a0: Dirección de la primera cadena de caracteres
#$a1: direccion de la segunda cadena de caracteres	
strcmp:	
	add $t0,$zero,$a0
	add $t3,$zero,$a1
	
bucleStrCmp:
	lb $t2,0($t0)
	addi $t0,$t0,1
	
	lb $t5,0($t3)
	addi $t3,$t3,1
	
	blt $t2,$t5,MenorStrCmp
	bgt $t2,$t5,MayorStrCmp
	
	bnez $t2,bucleStrCmp
	addi $v0,$zero,0 
	jr $ra
MayorStrCmp:
	addi $v0,$zero,1
	jr $ra
MenorStrCmp:
	addi $v0,$zero,-1
	jr $ra

	
	
	
	
	
	
#$a0: direccion de la primera cadena de caracteres
#$a1:direccion de la segunda cadena de caracteres
#$a2: numero de caracteres a comprobar	
strncmp:
	blt $a2,0,NoValidoStrNCmp
	beq $a2,0,finCadenaStrNCmp
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	add $t4,$zero,$zero
BucleStrNCmp:
	lb $t2,0($t0)
	addi $t0,$t0,1	

	lb $t3,0($t1)
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
	
	
	
	
	
	
	
#$a0:Direccion de la primera cadena de caracteres
#$a1:Direccion de la segunda cadena de caracteres   
strSearch:
#Comprueba si la cadena a1 esta contenida en a0
	
	add $t0,$zero,$a1
	add $t1,$zero,$a0
	add $t6,$zero,$zero
Cadena1StrSearch:
	lb  $t2,0($t1)
	addi $t1,$t1,1	
Cadena2StrSearch:
	lb  $t3,0($t0)
	beq $t3,$zero,CoincideStrSearch
	beq $t2,$zero,NoCoincideStrSearch
	bne $t2,$t3,Cadena1StrSearch

	sub $t6,$t1,$t0
	addi $t0,$t0,1
	b Cadena1StrSearch	
CoincideStrSearch:
	addi $t6,$t6,-1
	add $v0,$zero,$t6
	jr $ra
NoCoincideStrSearch:
	addi $v0,$zero,-1
	jr $ra
	
	





#$a0: Dirección del string de búsqueda
#$a1: Carácter a buscar
containsChar:
	add $t0,$zero,$a0
	beqz $a1,VacioContainsChar
Cadena1ContainsChar:
	lb  $t1,0($t0)
	beq $t1,$zero,NoCoincideContainsChar
	addi $t0,$t0,1
	bne $t1,$a1,Cadena1ContainsChar
	addi $v0,$zero,0
	jr $ra
NoCoincideContainsChar:
	addi $v0,$zero,1
	jr $ra
VacioContainsChar:
	addi $v0,$zero,0
	jr $ra	
	

	
	
	
	
	
#$a0: Dirección de string de búsqueda
#$a1: Dirección del string con los caracteres a buscar
containsAnyChar:
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	
Cadena1CntAnyChar:
	lb  $t3,0($t0)
	beq $t3,$zero,NoCoincideCntAnyChar
	addi $t0,$t0,1
Cadena2CntAnyChar:
	lb  $t2,0($t1)
	addi $t1,$t1,1
	beq $t2,$zero,VueltaCntAnyChar
	
	bne $t2,$t3,Cadena2CntAnyChar
	addi $v0,$zero,0
	jr $ra
VueltaCntAnyChar:
	addi $t1,$zero,0
	b Cadena1CntAnyChar
NoCoincideCntAnyChar:
	addi $v0,$zero,1
	jr $ra
	
	
	
	
	
	
	
#$a0:Dirección del string de búsqueda
#$a1:Dirección del string con los caracteres a buscar0
#$a2: numero de caracteres a encontrar en $a0	
containsSomeChars:
	blt $a2,1,NoValidoSomeChars
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	add $t4,$zero,$zero
Cadena2SomeChars:
	lb  $t2,0($t1)
	addi $t1,$t1,1
	beq $t2,$zero,NoCoincideSomeChars	
Cadena1SomeChars:
	lb  $t3,0($t0)
	beq $t3,$zero,VueltaSomeChars
	addi $t0,$t0,1
	
	bne $t2,$t3,Cadena1SomeChars
		
	addi $t4,$t4,1
	add $t0,$zero,$zero

	blt $t4,$a2,Cadena2SomeChars
	addi $v0,$zero,0
	add $v1,$zero,$zero
	jr $ra
NoIgualSomeChars:
	b Cadena2SomeChars
VueltaSomeChars:
	addi $t0,$zero,0
	b Cadena2SomeChars

NoCoincideSomeChars:
	add $v1,$zero,$zero
	addi $v0,$zero,1
	bgt $a2,$t1,NoValidoSomeChars
	jr $ra
	
NoValidoSomeChars:
	addi $v1,$zero,1
	jr $ra
	
	

	



#$a0 - Dirección del string de búsqueda
#$a1 - Dirección del string con los caracteres a buscar	
containsAllChars:
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	
	lb  $t3,0($t0)
	#addi $t0,$t0,1
	beqz $t3,CoincideAllChars
Cadena2AllChars:
	lb  $t2,0($t1)
	addi $t1,$t1,1
	beq $t2,$zero,CoincideAllChars
		
Cadena1AllChars:
	lb  $t3,0($t0)
	beq $t3,$zero,NoCoincideAllChars
	addi $t0,$t0,1
	
	bne $t2,$t3,Cadena1AllChars
	add $t0,$zero,$zero
	b Cadena2AllChars
CoincideAllChars:
	addi $v0,$zero,0
	jr $ra
NoCoincideAllChars:
	addi $v0,$zero,1
	jr $ra
	
	
	
	
	
	
	
#$a0: Dirección del string de búsqueda
#$a1: Dirección del string con los caracteres a buscar
containsOnlyChars:
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	
	lb  $t2,0($t0)
	addi $t0,$t0,1
	beq $t2,$zero,CadenaVacia
Cadena1OnlyChars:
	lb  $t2,0($t0)
	addi $t0,$t0,1
	beq $t2,$zero,finCadenaOnlyChars	
Cadena2OnlyChars:			
	lb  $t3,0($t1)
	addi $t1,$t1,1	
	beqz $t3,NoCoincideOnlyChars
	bne $t3,$t2,Cadena2OnlyChars
	add $t1,$zero,$zero
	add $v0,$zero,$zero
	b Cadena1OnlyChars
NoCoincideOnlyChars:
	addi $v0,$zero,1
finCadenaOnlyChars:
	add $a0,$zero,$v0
	jr $ra
CadenaVacia:
	add $v0,$zero,$zero,
	jr $ra
			
#$a0: dirección de string de búsqueda
#$a1: caracter tokenizador						
countTokens:
	beq $a1,$zero,NoTokenCountToken
	add $t0, $zero,$a0
	#add $t2, $zero,$zero
	addi $v0,$zero,1

	lb $t1,0($t0)
	add $t0,$t0,1
	beqz $t1,CadenaVaciaCountToken
	bne $t1,$a1,BucleCountToken
InicioCountToken:
	lb $t1,0($t0)
	add $t0,$t0,1
	beq $t1,$a1,InicioCountToken
BucleCountToken:
	lb $t1,0($t0)
	addi $t0,$t0,1
	beqz $t1,FinCountToken

	add $t3, $t0,$zero
	lb $t3,0($t3)
	beq $t3,$t1,BucleCountToken
	beqz $t3,FinCountToken
	
	bne $t1,$a1,BucleCountToken
	addi $v0,$v0, 1
	b BucleCountToken	
CadenaVaciaCountToken:
	add $v0,$zero,$zero
	jr $ra
NoTokenCountToken:
	addi $v0,$zero,1
FinCountToken:
	jr $ra
	
	
	
	
 
 
 
#$a0:Direccion del string de busqueda
#$a1: Caracter tokenizador
#$a2: Numero de token a obtener
#$a3: Direccion de la cadena donde se guarda el token
getToken:
	bltz $a2,FormatoInvalidoGetToken
	addi $v1,$zero,0	#Inicializacion
	add $t0, $zero,$a0
	add $t2, $zero,$zero #para dos tokenizadores seguidos
	addi $t3,$zero,0	#numero de tokens
	add $t5, $zero,$zero

	lb $t1,0($t0)
	add $t0,$t0,1
	beqz $t1,FormatoInvalidoGetToken
	bne $t1,$a1,BucleGetToken
InicioGetToken:
	lb $t1,0($t0)
	add $t0,$t0,1
	beq $t1,$a1,InicioGetToken
	#beq $t3,$a2,GuardaPrimerTokenGetToken
BucleGetToken:
	beq $t3,$a2,GuardaPrimerTokenGetToken
	
	lb $t1,0($t0)
	
	addi $t0,$t0,1
	beqz $t1,FinGetToken
	
	add $t2,$t0,$zero
	lb $t7,0($t2)
	beq $t7,$t1,BucleGetToken
	beqz $t7,FormatoInvalidoGetToken
	
	bne $t1,$a1,BucleGetToken
	addi $t3,$t3, 1
	bne $t3,$a2,BucleGetToken
GuardaTokenGetToken:
	lb $t1,0($t0)
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