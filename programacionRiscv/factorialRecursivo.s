    .text
    .global main
    
main:
    li a0, 5
    jal factorial
    li a1, 120
    bne a0, a1, noFunciona
    li a0, 6
    jal factorial
    li a1, 720
    bne a0, a1, noFunciona
    li a0, 8
    jal factorial
    li a1, 40320
    bne a0, a1, noFunciona

funciona:
    li a1, 1
    j fin

noFunciona:
    li a1, 0

fin:
    j fin
    

factorial:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw a0, 8(sp)
    
    beq a0, zero, casoBase
    addi a0, a0, -1
    jal factorial
    
    lw t0, 8(sp)
    mul a0, a0, t0
    j epilogo
casoBase:
    li a0, 1
    
epilogo:
    lw ra, 12(sp)
    addi sp, sp, 16
    ret