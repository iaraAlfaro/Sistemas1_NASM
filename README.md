Sistemas1_NASM

En GNU/Linux de 64 bits (Previamente, en Ubuntu, hay que ejecutar: sudo apt-get install libc6-dev-i386):
Ejemplo de ejcución del ejercicio Nro 1 "ej1.asm":

# 1) nasm -f elf ej1.asm

# 2) ld -m elf_i386 -s -o ej1 ej1.o -lc -I /lib/ld-linux.so.2

# 3) ./ej1
