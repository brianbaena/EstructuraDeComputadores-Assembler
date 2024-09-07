.data
mensaje1: .asciiz "Ingrese la cantidad de números (3-5): "
mensaje2: .asciiz "Ingrese el número: "
mensaje3: .asciiz "El número menor es: "
numeros: .space 20  # Espacio para almacenar hasta 5 números (4 bytes cada uno)

.text
.globl main
main:
    # Pedir la cantidad de números
    li $v0, 4
    la $a0, mensaje1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # Cantidad de números en $t0

    # Validar la cantidad de números
    li $t1, 3
    blt $t0, $t1, error  # Si es menor a 3, ir a error
    li $t1, 5
    bgt $t0, $t1, error  # Si es mayor a 5, ir a error

    # Leer los números
    li $t1, 0
    la $t2, numeros  # Cargar la dirección base del arreglo
bucle_lectura:
    beq $t1, $t0, fin_lectura  # Si ya se leyeron todos, terminar
    li $v0, 4
    la $a0, mensaje2
    syscall

    li $v0, 5
    syscall
    sw $v0, 0($t2)  # Almacenar el número en el arreglo

    addi $t2, $t2, 4  # Avanzar al siguiente elemento del arreglo
    addi $t1, $t1, 1  # Incrementar el contador
    j bucle_lectura

fin_lectura:
    # Encontrar el número menor
    la $t1, numeros     # Cargar la dirección del primer elemento en $t1
    lw $t2, 0($t1)      # Inicializar el menor con el primer número
    addi $t1, $t1, 4    # Avanzar al segundo número
    li $t3, 1           # Contador de iteraciones (ya leímos el primer número)

bucle_menor:
    beq $t3, $t0, fin_menor  # Si se procesaron todos los números, terminar
    lw $t4, 0($t1)           # Cargar el siguiente número en $t4
    blt $t2, $t4, siguiente  # Si el actual es menor, no actualizar
    move $t2, $t4            # Actualizar el menor si $t4 es menor

siguiente:
    addi $t1, $t1, 4    # Avanzar al siguiente número
    addi $t3, $t3, 1    # Incrementar el contador de iteraciones
    j bucle_menor

fin_menor:
    # Mostrar el resultado
    li $v0, 4
    la $a0, mensaje3
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    # Salir del programa
    li $v0, 10
    syscall

error:
    # Mensaje de error (implementar según sea necesario)
    li $v0, 10
    syscall
