.text
.global _start

_start:
  //-- Pedir numero
  mov x0, #1  //  File descriptor 1 (stdout)
  ldr x1, =msg // direccion de buffer
  mov x2, #17  //  Tamano de buffer
  mov x8, #64 //  syscall for sys_write
  svc #0  //  Call Kernel
  // Lectura de buffer
  mov x8, #63 //  syscall read
  mov x0, #0  //  Leer teclado
  ldr x1, =num1 //  Direccion del buffer
  mov x2, #100  //  tamano
  svc #0  //  Llamada al sistema

  //-- Pedir segundo numero
  mov x0, #1  //  File descriptor 1 (stdout)
  ldr x1, =msg // direccion de buffer
  mov x2, #17  //  Tamano de buffer
  mov x8, #64 //  syscall for sys_write
  svc #0  //  Call Kernel
  // Lectura de buffer
  mov x8, #63 //  syscall read
  mov x0, #0  //  Leer teclado
  ldr x1, =num2 //  Direccion del buffer
  mov x2, #100  //  tamano
  svc #0  //  Llamada al sistema

  ldr x0, =num1 //  Direcion num1
  ldrb w1, [x0] //  Leer el byte
  sub w1, w1, #48 //  Convertimos a decimal

  ldr x0, =num2 //  Direcion num2
  ldrb w2, [x0] //  Leer el byte
  sub w2, w2, #48 //  Convertimos a decimal

  add w3, w2, w1  //  Suma: resultado = num2 + num1

  mov w4, #10 //  divisor
  udiv w5, w3, w4 //  w5 = 12 / 10 = 1 (cociente: primer digito)
  msub w6, w5, w4, w3 //  w6 = 12 - (1 * 10) = 2 (residuo: segundo digito)

  //  Convertir ambos a ascci
  add w5, w5, #48
  add w6, w6, #48

  // Se guarda en res
  ldr x0, =final
  strb w5, [x0] //  Primer digito
  strb w6, [x0, #1] //  Segundo digito

  mov x0, #1  //  File descriptor 1 (stdout)
  ldr x1, =final // direccion de buffer
  mov x2, #3  //  Tamano de buffer
  mov x8, #64 //  syscall for sys_write
  svc #0  //  Call Kernel


  mov x0, #0  //  Exit code 0
  mov x8, #93 //  syscall number for sys_exit
  svc #0

.data
  num1: .skip 100 //  Espacio para 100 caracteres
  num2: .skip 100 //  Espacio para 100 caracteres
  resultado: .skip 100 //  Espacio para 100 caracteres
  final: .skip 100 //  Espacio para 100 caracteres
  msg: .asciz "Ingresa un numero"
