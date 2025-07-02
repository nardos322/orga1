main:
    li a0, 90
    li a1, 87
    jal ra, mayor
    li a2, 90
    bne a0, a2, noFunciona
funciona:
    li a1, 1
    j fin
noFunciona:
    li a1, 0
fin:
    j fin

mayor:
    addi sp, sp, -4
    sw ra, 0(sp)
    mv t0, a0
    bgt t0, a1, terminar
    mv t0, a1
terminar:
    mv a0, t0
    lw ra, 0(sp)
    addi sp, sp, 4
    ret