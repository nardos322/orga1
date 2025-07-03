    .text
    .globl main
    
main:
    li a0, 4
    jal rec
    
    
fin: 
    j    fin

rec:
    # ————— Prologue: crear el frame de pila —————
    addi   sp, sp, -16    # Reservar 16 bytes en la pila
    sw     ra, 12(sp)     # Guardar return address (ra)
    sw     a0,  8(sp)     # Guardar n (en a0) para reutilizarlo más tarde

    # ————— Cargar constantes en registros temporales —————
    li     t1, 1          # t1 = 1, para comparar casos base
    li     t2, 2          # t2 = 2, coeficiente de rec(n-1)
    li     t3, 3          # t3 = 3, coeficiente de rec(n-2)

    # ————— Casos base —————
    beq    a0, zero, casoBase0   # si n == 0 ? resultado = 0
    beq    a0, t1,   casoBase1   # si n == 1 ? resultado = 1

    # ————— Caso recursivo n > 1 —————
    # 1 Calcular rec(n-1)
    addi   a0, a0, -1     # a0 = n - 1
    jal    rec            # llamada rec(n-1)
    sw     a0, 4(sp)      # guardar rec(n-1) en pila[4]

    # 2 Calcular rec(n-2)
    lw     a0, 8(sp)      # restaurar n original
    addi   a0, a0, -2     # a0 = n - 2
    jal    rec            # llamada rec(n-2)
    
    # 3 Combinar: 2*rec(n-1) + 3*rec(n-2)
    lw     t0, 4(sp)      # t0 = rec(n-1)
    mul    t0, t2, t0     # t0 = 2 * rec(n-1)
    mul    a0, t3, a0     # a0 = 3 * rec(n-2)
    add    a0, t0, a0     # a0 = 2*rec(n-1) + 3*rec(n-2)
    j      epilogo        # salto al epílogo

casoBase0:
    li     a0, 0          # resultado = 0
    j      epilogo

casoBase1:
    li     a0, 1          # resultado = 1
    # continúa al epílogo    

epilogo:
    # ————— Epílogo: restaurar estado y retornar —————
    lw     ra, 12(sp)     # restaurar ra
    addi   sp, sp, 16     # liberar espacio de pila
    ret                   # volver al llamador (retorna en a0)
