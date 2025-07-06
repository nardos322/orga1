    .text
    .globl main

main:
    
    li a0, 5
    jal    fibonacci_3

fin:
    j    fin
    

# ------------------------------------------------------------
# a0 = n         (entrada)          -?  a0 = F3(n) (salida)
# F3(0)=0, F3(1)=1, F3(2)=2, F3(n)=F3(n-1)+F3(n-2)+F3(n-3)
# Usa 16 B de frame:  ra(12) | n(8) | F(n-1)(4) | F(n-2)(0)
# ------------------------------------------------------------    
    
fibonacci_3:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw a0, 8(sp)
    li t1, 1
    li t2, 2
    beq a0, zero, casoBase0
    beq a0, t1, casoBase1
    beq a0, t2, casoBase2
    
    #--------------- F3(n-1) ----------------
    addi  a0, a0, -1         # a0 = n-1
    jal   fibonacci_3        # devuelve F3(n-1) en a0
    sw    a0, 4(sp)          # guarda F3(n-1)
    
    #-------------- F3(n-2) -----------------
    lw    a0, 8(sp)          # recupera n
    addi  a0, a0, -2         # a0 = n-2
    jal   fibonacci_3        # devuelve F3(n-2)
    sw    a0, 0(sp)          # guarda F3(n-2)
    
    # ---------- F3(n-3) ----------
    lw    a0, 8(sp)          # n
    addi  a0, a0, -3         # n-3
    jal   fibonacci_3        # devuelve F3(n-3) en a0
    
   # ---------- suma: a0 = F(n-3) + F(n-2) + F(n-1) ----------
    lw    t3, 0(sp)          # t3 = F(n-2)
    add   a0, a0, t3         # a0 += F(n-2)
    lw    t3, 4(sp)          # t3 = F(n-1)
    add   a0, a0, t3         # a0 += F(n-1)
    j     epilogo
    
casoBase0:
    li a0, 0
    j     epilogo
    
casoBase1:
    li a0, 1
    j     epilogo
    
casoBase2:
    li a0, 2
    
epilogo:
    lw ra, 12(sp)
    addi sp, sp, 16
    ret
