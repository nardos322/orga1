    .text
    .globl main
    
main:
    li a0, 10
    li a1, 5
    jal modulo
    li a1, 0
    bne a0, a1, noFunciona
funciona:
    li a1, 1
    j fin
noFunciona:
    li a1, 0
fin:
    j fin
    
modulo:
    addi sp, sp, -16
    sw ra, 12(sp)
    blt a0, a1, terminar
    sub a0, a0, a1
    jal modulo
terminar:
    lw ra, 12(sp)
    addi sp, sp, 16
    ret