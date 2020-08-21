;6. Se ingresa N. La computadora muestra los primeros N términos de la Secuencia de Connell.
global main
global _start

extern printf
extern scanf
extern exit
extern gets

section .bss

	numero:
		resd 1

	auxBucle:
		resd 1

	cadena:
		resb	0x0100

section .data

	fmtInt:
		db "%d", 0

	fmtLF:
		db 0xA, 0

	auxiliar:
		dd 0x0

	auxEcuacion:
		dd 0x0

	fmtString:
		db	"%s", 0

	espacio:
		db  0x20, 0

	strInicio:
		db	"ingrese N. La computadora muestra los primeros N términos de la Secuencia de Connell: ", 0

section .text
	
	leerNumero:
		push auxBucle
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

	mostrarEspacio:
		push espacio
		call printf
		add esp, 4
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
		mov eax, 1
		mov [numero], eax
		call mostrarNumero
		call mostrarEspacio
		mov ebx, 1
		mov [auxEcuacion], ebx
		bucle:
			mov eax, [auxEcuacion]
			add eax, 1
			mov [auxEcuacion], eax
			mov ebx, 8
			imul ebx
			mov ebx, 7
			sub eax, ebx
			mov [auxiliar], eax
			mov ebx, 1
			call raizCuadrada
			mov eax, [numero]
			add eax, 1
			mov ebx, 2
			mov edx, 0
			idiv ebx
			mov [numero], eax
			mov eax, 2
			mov ebx, [auxEcuacion]
			imul ebx
			mov ecx, [numero]
			sub eax, ecx
			mov [numero], eax
			call mostrarNumero
			call mostrarEspacio
			mov eax, [auxBucle]
			mov ebx, [auxEcuacion]
			cmp ebx, eax
			jl bucle
			je salir

			raizCuadrada:
				inc ebx
				mov [numero], ebx
				mov eax, ebx
				imul eax
				mov edx, [auxiliar]
				cmp eax, edx
				jl raizCuadrada
				jg esMayor
				ret

			esMayor:
				mov eax, [numero]
				sub eax, 1
				mov [numero], eax
				ret

			salir:
				call mostrarSaltoDeLinea
				call salirDelPrograma







