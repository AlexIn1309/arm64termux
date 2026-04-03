.global _start
.align 4

_start:
    // Prólogo estándar
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // 20 - 7
    mov x0, #20
    mov x1, #7
    sub x2, x0, x1        // x2 = resultado (13)

    // Convertir resultado a ASCII (asumimos resultado < 100)
    mov x3, #10
    udiv x4, x2, x3       // x4 = decenas
    msub x5, x4, x3, x2   // x5 = unidades

    // Buffer en stack (3 bytes: "13\n")
    sub sp, sp, #16
    add x6, sp, #0

    add x4, x4, #'0'      // convertir decena a ASCII
    add x5, x5, #'0'      // convertir unidad a ASCII

    strb w4, [x6]         // primer dígito
    strb w5, [x6, #1]     // segundo dígito
    mov w7, #'\n'
    strb w7, [x6, #2]     // salto de línea

    // write(1, buffer, 3)
    mov x0, #1            // stdout
    mov x1, x6            // buffer
    mov x2, #3            // tamaño
    mov x8, #64           // syscall write en macOS
    svc #0

    // Epílogo
    add sp, sp, #16
    mov x0, #0
    mov x8, #93
    svc #0

