;3. Se ingresa un año. La computadora indica si es bisiesto.
global main       
global _start

extern printf
extern scanf
extern exit
extern gets

section .bss

	numero:
		resd	1	; 1 dword (4 bytes)

	caracter:
		resb	1	; 1 byte(dato)
		resb	3	; 3 bytes(relleno)

	cadena:
		resb	0x0100

section .data

	fmtInt:
		db "%d", 0

	fmtChar:
		db	"%c", 0

	fmtString:
		db	"%s", 0

	fmtLF:
		db 0xA, 0

	strInicio:
		db	"Ingrese un año, la computadora indica si es bisiesto: ", 0

section .text

	leerCadena:
		push cadena
		call gets
		add esp, 4
		ret 

	mostrarCadena:
		push cadena
		push fmtString
		call printf
		add esp, 8
		ret

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

	mostrarCaracter:
		push dword [caracter]
		push fmtChar
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
	mov edi, 0
	cargarCadena:
		mov eax, [edi + strInicio]
		mov [edi + cadena], eax
		inc edi
		cmp eax, 0
		jne cargarCadena

	call mostrarCadena
	call mostrarSaltoDeLinea
	call leerNumero
	mov eax, [numero]
	mov edx, 0
	mov ecx, 4

	divisible4:
		div ecx
		cmp edx, 0
		je noDivisible100
		jne noEsBisiesto


	noDivisible100:
		mov eax, [numero]
		mov ecx, 100
		div ecx
		cmp edx, 0
		jne esBisiesto
		je divisible400

	divisible400:
		mov eax, [numero]
		mov ecx, 400
		div ecx
		cmp edx, 0
		je esBisiesto
		jne noEsBisiesto

	esBisiesto:
		mov cl, 83
		mov [caracter], cl
		call mostrarCaracter
		call mostrarSaltoDeLinea
		call salirDelPrograma

	noEsBisiesto:
		mov cl, 78
		mov [caracter], cl
		call mostrarCaracter
		call mostrarSaltoDeLinea
		call salirDelPrograma