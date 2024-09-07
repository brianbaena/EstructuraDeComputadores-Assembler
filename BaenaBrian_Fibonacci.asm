.data
mensaje1: .asciiz "Ingrese la cantidad de números de la serie de Fibonacci: "
mensaje2: .asciiz "La serie de Fibonacci es: "
mensaje3: .asciiz "\nLa suma de los números de la serie es: "
espacio: .asciiz " "

.text
.globl main
main:
    # Pedir la cantidad de números
    li $v0, 4                  # Syscall para imprimir mensaje
    la $a0, mensaje1           # Cargar dirección del mensaje1
    syscall                    # Mostrar mensaje1

    li $v0, 5                  # Syscall para leer entero
    syscall                    # Leer la cantidad de números
    move $t0, $v0              # Guardar la cantidad de números en $t0

    # Inicializar la serie de Fibonacci
    li $s0, 0                  # Primer número de la serie (0)
    li $s1, 1                  # Segundo número de la serie (1)
    li $s3, 0                  # Inicializar la suma de la serie en 0

    # Imprimir los dos primeros números
    li $v0, 4                  # Syscall para imprimir mensaje
    la $a0, mensaje2           # Cargar la dirección del mensaje2
    syscall                    # Mostrar mensaje2

    li $v0, 1                  # Syscall para imprimir entero
    move $a0, $s0              # Cargar el primer número de Fibonacci (0) en $a0
    syscall                    # Imprimir el número 0

    add $s3, $s3, $s0          # Agregar el primer número (0) a la suma

    li $v0, 4                  # Syscall para imprimir espacio
    la $a0, espacio            # Cargar la dirección del espacio
    syscall                    # Imprimir espacio

    li $v0, 1                  # Syscall para imprimir entero
    move $a0, $s1              # Cargar el segundo número de Fibonacci (1) en $a0
    syscall                    # Imprimir el número 1

    add $s3, $s3, $s1          # Agregar el segundo número (1) a la suma

    # Generar el resto de la serie de Fibonacci
    addi $t0, $t0, -2          # Restar los dos primeros números ya impresos
bucle_fibonacci:
    beq $t0, 0, fin_fibonacci  # Si ya se generaron todos los números, salir del bucle
    add $s2, $s0, $s1          # Calcular el siguiente número de la serie
    move $s0, $s1              # Actualizar $s0 con el valor de $s1
    move $s1, $s2              # Actualizar $s1 con el valor de $s2

    li $v0, 4                  # Syscall para imprimir espacio
    la $a0, espacio            # Cargar la dirección del espacio
    syscall                    # Imprimir espacio

    li $v0, 1                  # Syscall para imprimir entero
    move $a0, $s2              # Cargar el siguiente número de Fibonacci en $a0
    syscall                    # Imprimir el número

    add $s3, $s3, $s2          # Agregar el número actual a la suma

    addi $t0, $t0, -1          # Decrementar contador de números restantes
    j bucle_fibonacci          # Volver a generar el siguiente número

fin_fibonacci:
    # Mostrar la suma de los números de la serie
    li $v0, 4                  # Syscall para imprimir mensaje
    la $a0, mensaje3           # Cargar la dirección del mensaje3
    syscall                    # Mostrar mensaje3

    li $v0, 1                  # Syscall para imprimir entero
    move $a0, $s3              # Cargar el valor de la suma en $a0
    syscall                    # Imprimir la suma

    # Terminar el programa
    li $v0, 10                 # Syscall para salir del programa
    syscall
