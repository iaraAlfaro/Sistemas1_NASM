
;2. Se ingresa una cadena. La computadora muestra las subcadenas formadas por las posiciones pares e impares de la cadena. Ej: FAISANSACRO : ASNAR FIASCO

global main              
global _start

extern printf            
extern scanf             
extern exit              
extern gets              


section .bss                     

cadena:
        resb    0x0100

cadenaTexto:
        resb    0x0100

caracter:
        resb    1
        resb    3



section .data                    


fmtString:
        db    "%s", 0            

fmtChar:
        db    "%c", 0            

fmtLF:
        db    0xA, 0

strInicio:
        db    "Ingrese una cadena, la computadora mostrara las subcadenas formadas por las posiciones pares e impares: ", 0          


section .text                    
 
leerCadena:                      
        push cadena
        call gets
        add esp, 4
        ret

leerCadenaTexto:
        push cadenaTexto
        call gets
        add esp, 4
        ret 

mostrarCadenaTexto:
        push cadenaTexto
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
                mov [edi + cadenaTexto], eax
                inc edi
                cmp eax, 0
                jne cargarCadena

        call mostrarCadenaTexto
        call mostrarSaltoDeLinea
        call leerCadena
        mov edi, 1               
        mov eax, 0              
seguir:
        mov al, [cadena + edi]
        cmp al, 0
        je seguirImpares
        cmp al, 97              
        jb imprimir
        cmp al, 122
        ja imprimir   

imprimir:                
        mov [caracter], al      
        call mostrarCaracter   
        add edi,2               
        jmp seguir              

seguirImpares:
        test edi,1            
        jp finPrograma          
        mov al,0x20             
        mov [caracter],al      
        call mostrarCaracter    
        mov edi,0              
        jmp seguir             

finPrograma:
        call mostrarSaltoDeLinea
        jmp salirDelPrograma