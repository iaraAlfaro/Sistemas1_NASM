;4. Se ingresan un entero N y, a continuación, N números enteros. La computadora muestra el promedio de los números pares ingresados y la suma de los impares.
global main
global _start

extern printf
extern scanf
extern exit

section .data

	fmtInt:
		db	"%d", 0

	fmtLF:
		db	0xA, 0

	numero:
		dd	0x0

	numeroAux:
		dd	0x0

	contadorUno:
		dd	0x0

	contadorDos:
		dd	0x0


	numeroPar:
		dd	0x0

	promedio:
		dd  0x0


	numeroImpar:
		dd	0x0



section .text

	leerNumero:
		push numero
		push fmtInt
		call scanf
		add esp, 8
		ret

	mostrarNumero:
		push dword [numero]
		push fmtInt
		call printf
		add esp, 8
		ret

	mostrarPromedio:
		push dword [promedio]
		push fmtInt
		call printf
		add esp, 8
		ret

	mostrarNumeroPar:
		push dword [numeroPar]
		push fmtInt
		call printf
		add esp, 8
		ret

	mostrarSaltoDeLinea:
		push fmtLF
		call printf
		add esp, 4
		ret

	salirDelPrograma:
		push 0
		call exit

_start:
main:
	call leerNumero
	mov eax, [numero]
	inc eax
	mov [contadorUno], eax
	mov eax, 0
	mov [contadorDos], eax
	call mostrarSaltoDeLinea

	bucle:
		mov esi, [contadorUno]
		dec esi
		mov [contadorUno], esi
		cmp esi, 0
		je imprimir
		call leerNumero
		mov eax, [numero]
		mov [numeroAux], eax
		mov cl, 2
		div cl
		cmp ah, 0
		je sumarPares
		jne sumarImpar

	sumarPares:
		mov esi, [contadorDos]
		inc esi
		mov [contadorDos], esi
		add eax, eax
		add eax, [numeroPar]
		mov [numeroPar], eax
		mov edi, [contadorUno]
		cmp edi, 0
		jne bucle
		jmp imprimir

	sumarImpar:
		mov eax, [numeroAux]
		add eax, [numeroImpar]
		mov [numeroImpar], eax
		mov esi, [contadorUno]
		cmp esi, 0
		jne bucle
	
	imprimir:
		mov eax, [numeroPar]
		mov edx, 0
		mov ecx, [contadorDos]
		idiv ecx
		mov [promedio], eax
		call mostrarSaltoDeLinea
		call mostrarPromedio
		call mostrarSaltoDeLinea
		mov eax, [numeroImpar]
		mov [numero], eax
		call mostrarNumero
		call mostrarSaltoDeLinea
		call salirDelPrograma

	
	



