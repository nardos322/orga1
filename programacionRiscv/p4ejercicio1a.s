main:
    li s1, 2024
    mv a0, s1
    jal ra, compA2
    add a0, s1, a0
    bnez a0, noFunciona
funciona:
    li a1, 1
    j fin
noFunciona:
    li a1, 0
fin: 
    j fin

compA2:
    addi sp, sp, -8
    sw s1, 0(sp)
    sw ra, 4(sp)
    not s1, a0  #compl a 1
    addi a0, s1, 1  #compA2 
    lw ra, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 8
    ret