
#juan lopez y daniel lopez
.data
cadena1: .asciiz "22-1"
cadena2: .asciiz "abc"


.text
.globl main
main:

	
	la $a0,cadena1
	la $a1, cadena2
	la $a2,5
	jal atoi
	move $a0,$v0
	li $v0,1
	syscall
	li $v0,10
	syscall


countTokens:
	jr $ra


#a0: direccion cadena                                                                                 
atoi:	
#Recibe una cadena con un numero decimal, lo codifica en binario y
#lo devuelve, si es muy grande devuelve 2 por $v1 y 1 si no es un numero	
	add $v1,$zero,$zero
	addi $t5, $zero, 0 	#variable que cuenta si es negativo
	addi $t4, $zero, 0 	#variable que cuenta si es positivo
	addi $t1, $zero, 0 	#contador
inicioAtoI:	
	add $t2, $t1, $a0	#direccion byte a leer
	lb $t3, 0($t2)	

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
	add $t2, $t1, $a0	
	lb $t2, 0($t2)
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
	
	#add $v0,$zero,$zero
	addi $v1, $zero, 1	#1 en $v0 y termina
	jr $ra
caracter:addi $v1, $zero,2	#2 en $v1 si caracter no digito
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
