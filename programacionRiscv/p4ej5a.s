    .data
arreglo: 
    .word 40,21,3
len: .word 3
    
    .text
    .globl main


    
main:
    
    la a0, arreglo
    lw a1, len
    jal invertirArreglo
    
    li a7, 1
    ecall

    
    li a7, 10
    
    ecall
     
  


invertirArreglo:
    addi sp, sp, -16
    sw ra, 0(sp)
    mv t2, a0
    mv t3, a1

while:
    beq t3, zero, done
    lw a0, 0(t2)
    jal inverso
    sw a0, 0(t2)
    addi t2, t2, 4
    addi t3, t3, -1
    j while
    

done:
    lw ra, 0(sp)
    addi sp, sp, 16
    ret
    
inverso:
    mv t0, a0
    not t1, t0
    addi t1, t1, 1
    mv a0, t1
    ret