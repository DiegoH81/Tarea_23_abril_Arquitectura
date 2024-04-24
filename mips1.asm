.data
array_size: .space 20
tab:.asciiz "\t"
endl: .asciiz "\n"

.text
.globl start
start:

la $s1, array_size #Cargar tama�o del array

addi $t1, $0, 5    #Carga 5 en s1[0]
sw $t1,0($s1)

addi $t1,$0, 3
sw $t1,4($s1)    #Carga 3 en s1[1]

addi $t1,$0, 29
sw $t1,8($s1)    #Carga 29 en s1[2]

addi $t1,$0, 1
sw $t1,12($s1)    #Carga 1 en s1[3]

addi $t1,$0, 1
sw $t1,16($s1)    #Carga 1 en s1[3]

li $s2, 5 #NUMERO DE ELEMENTOS DEL ARRAY

#IMPRIMIR ELEMENTOS DEL ARRAY
addi $t0, $zero, 0
loop_print:
    beq $t0, $s2, end_print
   
    add $t2, $t0, $t0
    add $t2, $t2, $t2 # i * 4
    add $t2, $t2, $s1 #CARGA EL NUMERO
    
    li $v0, 1
    lw $a0,0($t2) #NUMERO
    syscall    
    li $v0,4
    la $a0,tab   #Imprimir tab
    syscall
    
    add $t0, $t0, 1 ##Incremento del indice
    j loop_print
end_print:


#SALTO DE LINEA
li $v0, 4
la $a0, endl
syscall

# Inicializa el �ndice en 0
# t1: contador
# s2: n�mero de elementos en el array
# s1: direcci�n base del array
# t2: �ndice del m�nimo
# t3: contador para el segundo bucle
# t4: valor temporal (m�nimo)
# t5: posici�n del elemento para el sub-bucle
# t6: valor temporal para el sub-bucle


addi $t1, $zero, 0  # Inicializa el �ndice en 0
loop_selection_sort:
	beq $t1, $s2, loop_selection_end  # Comprueba si el �ndice ha alcanzado el final del array
	
	add $t7, $t1, $zero  # Copia el valor del contador a t7
	add $t2, $t1, $t1    # Calcula la posici�n del m�nimo (2 * i)
	add $t2, $t2, $t2    # Multiplica t2 por 4
	
	add $t5, $s1, $t2    # Calcula la posici�n del n�mero actual (n + 1)
	add $t2, $t2, $s1    # Calcula la posici�n del m�nimo (n)
	addi $t3, $t1, 1     # Inicializa el contador interno
	loop_in_selection_sort:
		beq $t3, $s2, end_in_selection_sort  # Verifica si el contador interno ha alcanzado el final del array
		
		lw $t4, 0($t2)     # Carga el valor del m�nimo actual
		addi $t5, $t5, 4   # Actualiza la posici�n al siguiente elemento
		lw $t6, 0($t5)     # Carga el valor del siguiente elemento
		
		blt $t6, $t4, swap   # Compara el valor del siguiente elemento con el m�nimo actual
		
		addi $t3, $t3, 1   # Incrementa el contador interno
		j loop_in_selection_sort  # Salta de nuevo al bucle interno
		
	swap: 
		move $t7, $t3       # Actualiza el �ndice del m�nimo encontrado
		
		add $s6, $t3, $t3   # Duplica el valor de t3 (2 * i)
	        add $s6, $s6, $s6   # Multiplica s6 por 4 (4 * i)
		add $t2, $s1, $s6   # Calcula la posici�n del nuevo m�nimo
		   
		addi $t3, $t3, 1    # Incrementa el contador interno
		j loop_in_selection_sort  # Salta de nuevo al bucle interno
		
	end_in_selection_sort:
	
	# Actualiza la posici�n del m�nimo actualizado
	add $t8, $t1, $t1
	add $t8, $t8, $t8    # Multiplica t8 por 4
	add $t8, $t8, $s1    # A�ade la direcci�n base del array
	
	# Realiza el intercambio entre el m�nimo y el elemento actual
	lw $t9, 0($t8)       # Carga el valor del n�mero actual
	add $s3, $t7, $t7    # Calcula la posici�n del m�nimo (2 * t7)
	add $s3, $s3, $s3    # Duplica s3 (4 * t7)
	add $t7, $s3, $s1    # A�ade la direcci�n base del array
	
	lw $s7, 0($t7)       # Carga el valor del m�nimo
	sw $s7, 0($t8)       # Guarda el valor del m�nimo en la posici�n del elemento actual
	sw $t9, 0($t7)       # Guarda el valor del elemento actual en la posici�n del m�nimo
	
	add $t1, $t1, 1      # Incrementa el �ndice en 1
	j loop_selection_sort  # Salta de nuevo al bucle principal

loop_selection_end:

#IMPRIMIR ELEMENTOS DEL ARRAY
addi $t0, $zero, 0
loop_print_1:
    beq $t0, $s2, end_print_1
   
    add $t2, $t0, $t0
    add $t2, $t2, $t2 # i * 4
    add $t2, $t2, $s1 #CARGA EL NUMERO
    
    li $v0, 1
    lw $a0,0($t2) #NUMERO
    syscall    
    li $v0,4
    la $a0,tab   #Imprimir tab
    syscall
    
    add $t0, $t0, 1 ##Incremento del indice
    j loop_print_1
end_print_1:





li $v0, 10
syscall
