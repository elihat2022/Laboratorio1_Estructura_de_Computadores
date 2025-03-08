.data
	mensaje_inicio: .asciiz "Ingrese la cantidad de números de la serie de Fibonacci que desee ver: " # Mensaje para solicitar la cantidad de números
	mensaje_numero_actual: .asciiz "\n El número actual de la serie es: "                            # Mensaje para mostrar cada número de la serie
	mensaje_final: .asciiz "\n la suma total de la serie es: "                                       # Mensaje para mostrar la suma total
.text 
    li $v0, 4              # Carga el código 4 en $v0 para la llamada al sistema para imprimir un string
    la $a0, mensaje_inicio # Carga la dirección del mensaje_inicio en $a0 como argumento para la llamada al sistema
    syscall                # Ejecuta la llamada al sistema para imprimir el mensaje inicial
    
    li $v0, 5              # Carga el código 5 en $v0 para la llamada al sistema para leer un entero
    syscall                # Ejecuta la llamada al sistema para leer la cantidad de números
    move $t1, $v0          # Guarda la cantidad de números de Fibonacci solicitados en el registro $t1
    
    # Comprobación de la entrada: verifica que la cantidad sea un número positivo
    ble $t1, 0, exit       # Si la cantidad es menor o igual a 0, salta a la etiqueta exit
    
	li $t0, 0              # Inicializa el contador en 0
	li $t2, 0              # Inicializa $t2 (a) con el primer número de Fibonacci (0)
	li $t3, 1              # Inicializa $t3 (b) con el segundo número de Fibonacci (1)
	li $t5, 0              # Inicializa $t5 con 0 para acumular la suma total de los números
	
loop:
    bge $t0, $t1, show     # Si el contador es mayor o igual que la cantidad solicitada, salta a la etiqueta show
    
	li $v0, 4              # Carga el código para imprimir un string
	la $a0, mensaje_numero_actual # Carga la dirección del mensaje para mostrar el número actual
	syscall                # Ejecuta la llamada al sistema para imprimir el mensaje
    
    li $v0, 1              # Carga el código para imprimir un entero
    move $a0, $t2          # Mueve el número actual de Fibonacci (a) a $a0 para imprimirlo
    syscall                # Ejecuta la llamada al sistema para imprimir el número
    
    add $t4, $t2, $t3      # Calcula el siguiente número de Fibonacci (c = a + b) y lo guarda en $t4
    
	add $t5, $t5, $t2      # Suma el número actual de Fibonacci (a) al acumulador total en $t5
	
	move $t2, $t3          # Actualiza a = b (para la siguiente iteración)
	move $t3, $t4          # Actualiza b = c (para la siguiente iteración)
   	
    addi $t0, $t0, 1       # Incrementa el contador en 1
    j loop                 # Salta incondicionalmente a la etiqueta loop para la siguiente iteración
 
show:    
    # Muestra la suma total de los números de Fibonacci
    li $v0, 4              # Carga el código para imprimir un string
    la $a0, mensaje_final  # Carga la dirección del mensaje final
    syscall                # Ejecuta la llamada al sistema para imprimir el mensaje
    
    li $v0, 1              # Carga el código para imprimir un entero
    move $a0, $t5          # Mueve la suma total acumulada a $a0 para imprimirla
    syscall                # Ejecuta la llamada al sistema para imprimir la suma total
    
exit:
    li $v0, 10             # Carga el código 10 en $v0 para la llamada al sistema para terminar el programa
    syscall                # Ejecuta la llamada al sistema para terminar el programa