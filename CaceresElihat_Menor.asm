.data
	mensaje_inicio: .asciiz "Ingrese la cantidad de números a comparar entre 3-5: " # Mensaje para solicitar cantidad de números
	mensaje_numero: .asciiz "Ingrese un número a comparar: "                       # Mensaje para solicitar cada número
	mensaje_final: .asciiz "El número menor es: "                                  # Mensaje para mostrar el resultado final
	
.text 
	li $v0, 4              # Carga el código 4 en $v0 para la llamada al sistema para imprimir un string
	la $a0, mensaje_inicio # Carga la dirección del mensaje_inicio en $a0 como argumento para la llamada al sistema
	syscall                # Ejecuta la llamada al sistema para imprimir el mensaje inicial
	
	li $v0, 5              # Carga el código 5 en $v0 para la llamada al sistema para leer un entero
	syscall                # Ejecuta la llamada al sistema para leer la cantidad de números a comparar
	move $t1, $v0          # Guarda la cantidad de números a comparar (entre 3-5) en el registro $t1
	
	# Comprobación de la entrada: verifica que la cantidad esté entre 3 y 5
	blt $t1, 3, exit       # Si la cantidad es menor que 3, salta a la etiqueta exit
  	bgt $t1, 5, exit       # Si la cantidad es mayor que 5, salta a la etiqueta exit
  	
  	# Almacena el primer número ingresado
  	li $v0, 4              # Carga el código para imprimir un string
  	la $a0, mensaje_numero # Carga la dirección del mensaje para pedir un número
	syscall                # Ejecuta la llamada al sistema para imprimir el mensaje
	li $v0, 5              # Carga el código para leer un entero
	syscall                # Ejecuta la llamada al sistema para leer el primer número
	move $t2, $v0          # Guarda el primer número en $t2 como valor mínimo inicial
	
	li $t0, 1              # Inicializa el contador en 1
	
loop:
	bge $t0, $t1, show     # Si el contador es mayor o igual que la cantidad de números, salta a la etiqueta show
	
  	li $v0, 4              # Carga el código para imprimir un string
  	la $a0, mensaje_numero # Carga la dirección del mensaje para pedir un número
	syscall                # Ejecuta la llamada al sistema para imprimir el mensaje
	li $v0, 5              # Carga el código para leer un entero
	syscall                # Ejecuta la llamada al sistema para leer el siguiente número
	
	bge $v0, $t2, siguiente # Si el número leído es mayor o igual que el mínimo actual, salta a la etiqueta siguiente
	move $t2, $v0           # Si el número es menor, actualiza el mínimo actual en $t2
	
siguiente:
	addi $t0, $t0, 1       # Incrementa el contador en 1
	j loop                 # Salta incondicionalmente a la etiqueta loop para la siguiente iteración
	
show:	
	# Muestra el número mínimo encontrado
	li $v0, 4              # Carga el código para imprimir un string
	la $a0, mensaje_final  # Carga la dirección del mensaje final
	syscall                # Ejecuta la llamada al sistema para imprimir el mensaje
	li $v0, 1              # Carga el código para imprimir un entero
	move $a0, $t2          # Mueve el número mínimo encontrado a $a0 como argumento
	syscall                # Ejecuta la llamada al sistema para imprimir el número mínimo
		
exit:
    li $v0, 10            # Carga el código 10 en $v0 para la llamada al sistema para terminar el programa
    syscall               # Ejecuta la llamada al sistema para terminar el programa