    .text
    .globl main
    
main:
    li a0, 4
    jal rec
    
    
fin: 
    j    fin

rec:
    addi sp, sp -16
    sw ra, 12(sp)
    sw a0, 8(sp)
    li t1, 1
    li t2, 2
    li t3, 3
    
    beq a0, zero, casoBase0
    beq a0, t1, casoBase1
    
    addi a0, a0, -1
    jal rec
    sw a0, 4(sp)
    
    lw a0, 8(sp)
    addi a0, a0, -2
    jal rec
    
    lw t0, 4(sp)
    mul t0, t2, t0
    mul a0, t3, a0
    add a0, t0, a0
    
    j epilogo
    
    
casoBase0:
    li a0, 0
    j epilogo

casoBase1:
    li a0, 1

epilogo:
    lw ra, 12(sp)
    addi sp, sp, 16
    ret
    
