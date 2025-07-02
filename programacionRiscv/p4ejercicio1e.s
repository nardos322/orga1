main:
    li a0, 8
    jal ra, funcion
    li a2, 36
    bne a0, a2, noFunciona
funciona:
    li a1, 1
    j fin
noFunciona: 
    li a1, 0
fin: 
    j fin

funcion:
    addi sp, sp, -4
    sw, ra, 0(sp)
    mv a1, a0
    mv a0, zero
inicioCiclo:
    beq a1, zero, finCiclo
    add a0, a0, a1
    addi a1, a1, -1
    j inicioCiclo
finCiclo:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret