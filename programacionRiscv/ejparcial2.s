    .data
tablaCalificaciones:
        .half 5523
        .byte 3
        .half 8732
        .byte 6
        .half 8437
        .byte 3
        .half 3423
        .byte 7
        .half 0
        
        .globl main
        .text
main:
    la a0, tablaCalificaciones
    jal sumaNotaIdImpar
    mv a1, a0
    li a7, 1
    ecall
    ret
    
    
sumaNotaIdImpar:
    li t2, 0 #contador
    mv t3, a0
while:
    lh t0, 0(t3)
    beqz t0, done
    andi t1, t0, 1
    bnez t1, esImpar
   
cont:
    addi t3, t3, 3
    j while
    
esImpar:
    lbu t1, 2(t3)
    add t2, t2, t1
    j cont
done:
    mv a0, t2
    ret