    .data
arreglo: 
    .byte 16, 8, 64, 12
len:
    .byte 4
    
    .text
    .globl main
    
##############################################################
# main
# =====
# Demostración mínima:
#   – Construye un arreglo de bytes       arreglo = {16, 3, 4}
#   – Llama a potenciasEnArreglo()
#   – Imprime el resultado y finaliza
#
# Convención:
#   – Usa servicios de ecall estilo SPIM a7 = 1 → print_int,
#                                         a7 = 10 → exit
##############################################################    
    
main:
    la a0, arreglo   # a0 ← &arreglo
    lb a1, len       # a1 ← longitud (sin signo)
    jal potenciasEnArreglo
    
    li a7, 1    # print_int
    ecall
    
    li a7, 10   # exit
    ecall
    


##############################################################
# potenciasEnArreglo
# ==================
# Cuenta cuántos elementos de un arreglo de bytes son potencias
# de dos.
#
# Entrada:
#   a0 = &arreglo   (puntero a los bytes)
#   a1 = len        (cantidad de elementos, 0-255)
#
# Salida:
#   a0 = cantidad de potencias de 2 encontradas   (unsigned)
#
# Registros temporales:
#   t0 = puntero de recorrido
#   t1 = contador de elementos restantes
#   t2 = contador de potencias halladas
#
# Protocolo de pila (RV32):
#   – Empuja 4 bytes para guardar ra y mantener la alineación.
##############################################################

potenciasEnArreglo:
    addi sp, sp, -16    # reserva espacio para ra
    sw ra, 0(sp)        # guarda la direccion de retorno
    
    mv   t0, a0           # t0 ← ptr
    mv   t1, a1           # t1 ← len
    li   t2, 0            # t2 ← contador = 0 
    
while:
    beq t1, zero, done       # ¿quedan elementos? → no → fin   
    lbu a0, 0(t0)            # a0 ← arreglo[i]
    jal esPotencia2          # a0 = 0 si SÍ es potencia de 2
    bne a0, zero, skip       # a0≠0 ⇒ no es potencia, saltar suma
    addi t2, t2, 1           # ++contador
    
skip:     
    addi t1, t1, -1         # --restantes
    addi t0, t0, 1          # avanza puntero (byte siguiente)
    j while
    
done:
    mv a0, t2               # valor de retorno en a0
    lw ra, 0(sp)            # restaura ra
    addi sp, sp, 16         # libera frame
    ret
    
##############################################################
# esPotencia2
# ===========
# Test rápido “n & (n-1)”:
#   – Devuelve 0  →  n es potencia de 2  (salvo n = 0)
#   – Devuelve ≠0 →  n NO es potencia de 2
#
# Entrada : a0 = n   (byte/word, sin signo)
# Salida  : a0 = 0   si potencia
#                  ≠0 si no
# Registros usados: t3, t4 (clobber)
# Nota: Leaf-function → no es necesario salvar ra.
##############################################################    
    
esPotencia2:
    beq a0, zero, noEsPotencia  # 0 ⇒ no cuenta como potencia
    addi t3, a0, -1             # t3 = n-1
    and t4, a0, t3              # t4 = n & (n-1)
    mv a0, t4                   # resultado en a0 (0 ↔ potencia)
    ret
    
noEsPotencia:
    li a0, 1                    # cualquier ≠0 indica “no potencia”
    ret