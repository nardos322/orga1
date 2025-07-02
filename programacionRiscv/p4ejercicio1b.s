main:
    li a0, 6
    li a1, 5
    jal ra, sumar
    li a2, 11
    bne a0, a2, noFunciona
funciona:
    li a1, 1
    j fin
noFunciona:
    li a1, 0
fin:
    j fin

sumar:
    addi sp, sp, -4
    sw ra, 0(sp)
    add a0, a0, a1
    lw ra, 0(sp)
    addi sp, sp, 4
    ret 