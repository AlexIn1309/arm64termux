.text
.global _start

_start:
  // Lectura de buffer
  mov x8, #63 //  syscall read
  mov x0, #0  //  Leer teclado
  ldr x1, =buffer //  Direccion del buffer
  mov x2, #100  //  tamano
  svc #0  //  Llamada al sistema

  mov x1, =[buffer]
  mov x2, 

  mov x0, #1  //  File descriptor 1 (stdout)
  ldr x1, =buffer // direccion de buffer
  mov x2, #20  //  Tamano de buffer
  mov x8, #64 //  syscall for sys_write
  svc #0  //  Call Kernel

  mov x0, #0  //  Exit code 0
  mov x8, #93 //  syscall number for sys_exit
  svc #0

.data
  buffer: .skip 100 //  Espacio para 100 caracteres

