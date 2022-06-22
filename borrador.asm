    mov     qword[contadorExterno],-1
    call    loopConjuntoA

loopConjuntoA:

    inc     qword[contadorExterno]      ;Inicializo en 0

    mov     qword[contadorInterno],0    ;Inicializo en 0
    
    mov     rsi,qword[contadorExterno]
    mov     al,byte[conjuntoA + rsi]    ;Almaceno 1er caracter del elemento

    ;Veo ContadorExterno
    mov     rcx,imprimirExterno
    mov     rdx,[contadorExterno]
    sub     rsp,32
    call    printf
    add     rsp,32

    inc     qword[contadorExterno]      ;Incremento contador externo

    mov     rsi,qword[contadorExterno]
    mov     ah,byte[conjuntoA + rsi]    ;Almaceno 2do caracter del elemento

    loopConjuntoB:
        mov     rsi,qword[contadorInterno]
        mov     bl,byte[conjuntoB + rsi]    ;Almaceno 1er caracter del elemento

        ;Veo ContadorInterno
        mov     rcx,imprimirInterno
        mov     rdx,[contadorInterno]
        sub     rsp,32
        call    printf
        add     rsp,32

        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bh,byte[conjuntoB + rsi]    ;Almaceno 2do caracter del elemento

        cmp     al,bl                       ;Comparo los dos primeros caracteres
        je      compararSegundoByte         ;Si son iguales evaluo el segundo caracter del elemento
        
        cmp     bl,0
        je      finNoIguales
        cmp     bh,0
        je      finNoIguales

        inc     qword[contadorInterno]      ;Incremento contador interno

        jmp     loopConjuntoB

        compararSegundoByte:
            cmp     ah,bh                   ;Si los 2 ultimos caracteres son iguales
            je      loopConjuntoA           ;significa que el elemento es el mismo y sigo con el siguiente

            jmp     loopConjuntoB           ;Sino, sigo recorriendo 
    
        


finNoIguales:
    
    ret


