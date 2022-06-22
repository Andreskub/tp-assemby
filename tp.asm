global main
extern gets
extern puts
extern printf
extern sscanf


section .data

    msjIngreseConjuntos      db  "Ingrese la cantidad de conjuntos:",0
    msjIngreseConjunto       db  "Ingrese el conjutno:",0
    
    formatoNumero            db  "%lli",0
    formatoConjunto          db  "%s",0

    imprimir                 db  "%lli",10,0
    imprimir2                db  "Completar conjunto %lli",10,0
    
    ;Prueba
    imprimirExterno          db  "Externo: %lli",10,0
    imprimirInterno          db  "Interno: %lli",10,0
    imprimirAl               db  "[conjuntoA + rsi]: %c",10,0
    

    msjRangoInvalido         db  "El rango ingresado es invalido",0

    contadorExterno          dq  0
    contadorInterno          dq  0

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

loopConjuntoA:

    ;Veo ContadorExterno
    mov     rcx,imprimirExterno
    mov     rdx,[contadorExterno]
    sub     rsp,32
    call    printf
    add     rsp,32

    inc     qword[contadorExterno]

    

    ;mov     rsi,qword[contadorInterno]
    mov     qword[contadorInterno],0
    
    mov     rsi,qword[contadorExterno]
    mov     al,byte[conjuntoA + rsi]

    ;Veo ContadorExterno
    mov     rcx,imprimirExterno
    mov     rdx,[contadorExterno]
    sub     rsp,32
    call    printf
    add     rsp,32

    inc     qword[contadorExterno]
    mov     rsi,qword[contadorExterno]
    mov     ah,byte[conjuntoA + rsi]

    loopConjuntoB:
        mov     rsi,qword[contadorInterno]
        mov     bl,byte[conjuntoB + rsi]

        ;Veo ContadorInterno
        mov     rcx,imprimirInterno
        mov     rdx,[contadorInterno]
        sub     rsp,32
        call    printf
        add     rsp,32

        inc     qword[contadorInterno]

        mov     rsi,qword[contadorInterno]
        mov     bh,byte[conjuntoB + rsi]

        cmp     al,bl
        je      compararSegundoByte
        
        cmp     bl,0
        je      finNoIguales
        cmp     bh,0
        je      finNoIguales

        inc     qword[contadorInterno]

        jmp     loopConjuntoB

        compararSegundoByte:
            cmp     ah,bh
            je      loopConjuntoA

            jmp     loopConjuntoB
    
        


finNoIguales:
    
    ret




; FUNCIONES DE CARGA
cargarConjuntos:

    inc     rsi

    mov     rcx,imprimir2
    mov     rdx,rsi
    sub     rsp,32
    call    printf
    add     rsp,32


    cmp	    rsi,1
    jmp     completarConjuntoA
    cmp	    rsi,2
    jmp     completarConjuntoB
    cmp	    rsi,3
    jmp     completarConjuntoC
    cmp	    rsi,4
    jmp     completarConjuntoD
    cmp	    rsi,5
    jmp     completarConjuntoE
    cmp	    rsi,6
    jmp     completarConjuntoF

    continuarConjuntos:

    cmp     rsi,qword[cantConjuntos]
    jl      cargarConjuntos

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