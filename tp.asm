global main
extern gets
extern puts
extern printf
extern sscanf


section .data

    msjIngreseConjuntos      db  "Ingrese la cantidad de conjuntos:",0
    msjIngreseConjunto       db  "Ingrese el conjutno %lli:",10,0
    
    formatoNumero            db  "%lli",0
    formatoConjunto          db  "%s",0

    imprimir                 db  "%lli",10,0
    
    imprimirConjA            db  "Conjunto A  %s",10,0
    imprimirConjB            db  "Conjunto B  %s",10,0
    imprimir4                db  "Paso por aca",10,0
    imprimir5                db  "Paso por aca 2",10,0
    
    ;Prueba
    imprimirExterno          db  "Cont Externo: %lli",10,0
    imprimirInterno          db  "Cont Interno: %lli",10,0
    imprimirExt              db  "[conjuntoExt + rsi]: %c",10,0
    imprimirInt              db  "[conjuntoInt + rsi]: %c",10,0

    
    

    msjRangoInvalido         db  "El rango ingresado es invalido",10,0
    msjFinNoIguales          db  "Los conjuntos A y B no son iguales",10,0

    contadorExterno          dq  0
    contadorInterno          dq  0

    reg1                     dq  0
    reg2                     dq  0

section .bss

    buffer          resb    500
    cantConjuntos   resq    1
    conjuntoA       resb    500
    conjuntoB       resb    500
    conjuntoC       resb    500
    conjuntoD       resb    500
    conjuntoE       resb    500
    conjuntoF       resb    500


section .text

main:

preguntarCantidadDeConjuntos:

    mov     rcx,msjIngreseConjuntos
    sub     rsp,32
    call    puts
    add     rsp,32

    mov     rcx,buffer
    sub     rsp,32
    call    gets
    add     rsp,32

    mov     rcx,buffer
    mov     rdx,formatoNumero
    mov     r8,cantConjuntos
    sub     rsp,32
    call    sscanf
    add     rsp,32

    call    validarRango
    cmp     rax,0
    je      preguntarCantidadDeConjuntos

    mov     rsi,0
    call    cargarConjuntos

    mov     qword[contadorExterno],-1
    call    loopConjuntoA

    ret

loopConjuntoA:

    inc     qword[contadorExterno]      ;Inicializo contador externo en 0
    mov     qword[contadorInterno],-1    ;Inicializo contador interno en -1
    
    mov     rsi,qword[contadorExterno]
    mov     al,byte[conjuntoA + rsi]    ;Almaceno 1er caracter del elemento
    mov     byte[reg1],al


    inc     qword[contadorExterno]      ;Incremento contador externo

    mov     rsi,qword[contadorExterno]
    mov     ah,byte[conjuntoA + rsi]    ;Almaceno 2do caracter del elemento
    mov     byte[reg2],ah

    loopConjuntoB:
        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bl,byte[conjuntoB + rsi]    ;Almaceno 1er caracter del elemento

        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bh,byte[conjuntoB + rsi]    ;Almaceno 2do caracter del elemento


        cmp     bl,byte[reg1]               ;Comparo los dos primeros caracteres
        je      compararSegundoByte         ;Si son iguales evaluo el segundo caracter del elemento

        cmp     bl,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      finNoIguales

        cmp     bh,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      finNoIguales


        ;Condicion de que si largo Conjunto B es igual al 

        jmp     loopConjuntoB

        compararSegundoByte:
            mov     rcx,imprimir5
            sub     rsp,32
            call    printf
            add     rsp,32

            cmp     bh,byte[reg2]                   ;Si los 2 ultimos caracteres son iguales
            je      loopConjuntoA           ;significa que el elemento es el mismo y sigo con el siguiente

            mov     rcx,imprimir5
            sub     rsp,32
            call    printf
            add     rsp,32

            jmp     loopConjuntoB           ;Sino, sigo recorriendo
    
        


finNoIguales:
    
    ;Veo ContadorInterno
    mov     rcx,msjFinNoIguales
    sub     rsp,32
    call    printf
    add     rsp,32
    
    ret


; FUNCIONES DE CARGA
cargarConjuntos:

    inc     rsi

    mov     rcx,msjIngreseConjunto
    mov     rdx,rsi
    sub     rsp,32
    call    printf
    add     rsp,32


    cmp	    rsi,1
    je      completarConjuntoA
    cmp	    rsi,2
    je      completarConjuntoB
    cmp	    rsi,3
    je      completarConjuntoC
    cmp	    rsi,4
    je      completarConjuntoD
    cmp	    rsi,5
    je      completarConjuntoE
    cmp	    rsi,6
    je      completarConjuntoF

    continuarConjuntos:

    cmp     rsi,qword[cantConjuntos]
    jl      cargarConjuntos

    mov     rcx,imprimirConjA
    mov     rdx,conjuntoA
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,imprimirConjB
    mov     rdx,conjuntoB
    sub     rsp,32
    call    printf
    add     rsp,32

    ret

; FUNCIONES DE CARGA
completarConjuntoA:

    mov     rcx,conjuntoA
    sub     rsp,32
    call    gets
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoB:

    mov     rcx,conjuntoB
    sub     rsp,32
    call    gets
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoC:

    mov     rcx,conjuntoC
    sub     rsp,32
    call    gets
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoD:

    mov     rcx,conjuntoD
    sub     rsp,32
    call    gets
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoE:

    mov     rcx,conjuntoE
    sub     rsp,32
    call    gets
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoF:

    mov     rcx,conjuntoF
    sub     rsp,32
    call    gets
    add     rsp,32

    jmp     continuarConjuntos



; FUNCIONES DE VALIDACION
validarRango:

    mov     rax,1
    cmp     qword[cantConjuntos],0
    jle     rangoInvalido           ;Chequeo si el rango < 0
    cmp     qword[cantConjuntos],6
    jg      rangoInvalido           ;Chequeo si el rango > 6
    ret

rangoInvalido:

    mov     rax,0

    mov     rcx,msjRangoInvalido
    sub     rsp,32
    call    puts
    add     rsp,32

    ret