    .text
    .globl main
main:
    li a0, 4
    jal funcion
    li a1, 5
    bne a0, a1, noFunciona
    li a0, 5
    jal funcion
    li a1, 8
    bne a0, a1, noFunciona
    li a0, 6
    jal funcion
    li a1, 13
    bne a0, a1, noFunciona
funciona:
    li a1, 1
    j fin
noFunciona:
    li a1, 0
fin:
    j fin
    
# ------------------------------------------------------------
# a0 = n              (entrada)
# ----                ----------------------------------------
# a0 = F(n)           (salida)
# Usa pila (frame de 16 B) y dos llamadas recursivas
# ------------------------------------------------------------
funcion:
    addi  sp, sp, -16        # crea frame alineado (16 B)
    sw    ra, 12(sp)         # guarda ra
    sw    a0,  8(sp)         # guarda n

    li    t0, 1              # t0 = 1
    beq   a0, zero, base     # n == 0  ? caso base
    beq   a0, t0,  base      # n == 1  ? caso base

    # ---------- F(n-1) ----------
    addi  a0, a0, -1         # a0 = n-1
    jal   funcion            # = F(n-1)
    sw    a0, 4(sp)          # guarda F(n-1) en stack

    # ---------- F(n-2) ----------
    lw    a0, 8(sp)          # restaura n original
    addi  a0, a0, -2         # a0 = n-2
    jal   funcion            # = F(n-2)

    # ---------- suma ----------
    lw    t0, 4(sp)          # t0 = F(n-1)
    add   a0, a0, t0         # a0 = F(n-1) + F(n-2)
    j     epilogue

base:                         # caso base: F(0) = F(1) = 1
    li    a0, 1

epilogue:
    lw    ra, 12(sp)         # restaura ra
    addi  sp, sp, 16         # libera frame
    ret                      # vuelve al llamador