    .data
aportantes:
    .byte 66, 40
    .half 5000
    .byte 32, 30
    .half -500
    .byte 70, 33
    .half -1000
    .byte 70, 20
    .half 200
largo:
    .byte 4
    .text
    la t0, aportantes
    la t1, largo
    lb t1, 0(t1) #largo
    li t2, 0 #contador
    li t3, 0 #acumulador
    li t4, 0 #indice
    li a1, 65
    
while:
    bge t4, t1, return
    slli t6, t4, 2
    add t6, t0, t6
    lb t5, 0(t6)
    bge t5, a1, acumular
    j cont
    
acumular:
    lh t5, 2(t6)
    add t3, t3, t5
    addi t2, t2, 1

cont:
    addi t4, t4, 1
    j while
return:
    div a0, t3, t2
fin:
    j fin
    
  