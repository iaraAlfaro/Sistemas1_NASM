;5.Se ingresan 100 caracteres. La computadora los muestra ordenados sin repeticiones.

global main
global _start

extern printf
extern scanf
extern exit
extern gets

section .bss
	
	cadenaTexto:
		resb	0x0100

	cadena:
		resb	0x0100

	cadenaTres:
		resb	0x0100

section .data
	
	fmtString:
		db	"%s", 0

	fmtChar:
		db	"%c", 0

	fmtLF:
		db	0xA, 0

	auxiliar:
		dd  0x0

	auxiliarPrueba:
		dd  0x0

	caracter:
		dd  0x0

	strUno:
		db	"Ingrese 50 caracteres de forma aleatoria: ", 0

section .text

	leerCadena:
		push cadena
		call gets
		add esp, 4
		ret

	mostrarCadenaTexto:
		push cadenaTexto
		push fmtString
		call printf
		add esp, 8
		ret

	mostrarCadena:
		push cadena
		push fmtString
		call printf
		add esp, 8
		ret

	mostrarCaracter:
		push dword [caracter]
		push fmtChar
		call printf
		add esp, 8
		ret

	mostrarAuxiliarPrueba:
		push dword [auxiliarPrueba]
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
			mov al, [edi + strUno]
			mov [edi + cadenaTexto], al
			inc edi
			cmp al, 0
			jne cargarCadena

		call mostrarCadenaTexto
		call mostrarSaltoDeLinea
		call leerCadena
		mov esi, 0
		mov bl, 49
		mov cl, 49

	bucle:
		sub bl, 1
		mov ah, [esi + cadena]
		cmp ah, [esi + 1 + cadena]
		jl menorQue
		jg mayorQue

	mayorQue:
		xchg ah, [esi + 1 + cadena]
		mov [esi + cadena], ah
		add esi, 1
		cmp bl, 0
		je inicializar
		jne bucle
		
	menorQue:
		add esi, 1
		cmp bl, 0
		je inicializar
		jne bucle

	saltarRepetidos:
		mov al, [edi + cadena]
		mov ah, [edi + 1 + cadena]
		mov [caracter], al
		inc edi
		cmp al, ah
		jl imprimir
		je saltarRepetidos

	imprimir:
		call mostrarCaracter
		mov al, [edi + cadena]
		cmp al, 0
		je salir
		jne saltarRepetidos

	inicializar:
		mov bl, 49
		mov esi, 0
		sub cl, 1
		mov edi, 0
		cmp cl, 0
		je saltarRepetidos
		jne bucle

	salir:
		call mostrarSaltoDeLinea
		call salirDelPrograma

