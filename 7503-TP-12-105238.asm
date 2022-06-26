; TP n12 - Andrés Kübler - 104238
;
; Aclaraciones previas:
;   -> Los elementos deben poseer 2 caracteres
;   -> Los conjuntos no deben tener elementos repetidos( ej: {a,a,b}={a,a,b,b}={a,b} )
;   -> Las operaciones se realizaran sobre los primeros 2 conjuntos ingresados por el usuario
;   -> Para las operaciones de Conjuntos, el rango minimo de Conjuntos es 2
;


;REVISAR CALL Y JMP

;EL CALL NECESITA UN RET

global main
extern gets
extern puts
extern printf
extern sscanf

section .data

    msjIngreseCantConjuntos  db  "-> Ingrese la cantidad de conjuntos:",0
    msjIngreseConjunto       db  "-> Ingrese el conjutno %lli:",10,0
    msjIngreseConjunto2      db  "-> Ingrese el conjutno:",10,0
    msjIngreseElemento       db  "-> Ingrese el elemento:",10,0
    msjIngreseOperacion      db  "*",10
                             db  "| Operaciones disponibles",10
                             db  "| 1) Pertenencia de un conjunto a otro",10
                             db  "| 2) Igualdad de dos conjuntos",10
                             db  "| 3) Inclusion de un conjunto en otro",10
                             db  "| 4) Union entre conjuntos",10
                             db  "*",10
                             db  "-> Ingrese operacion: ",0
    
    formatoNumero            db  "%lli",0
    formatoConjunto          db  "%40s",0       ;Solo toma los primeros 40 caracteres
    formatoElemento          db  "%2s",0

    msjRangoInvalido         db  "Error! El rango ingresado es invalido",10,0
    msjElementoPertenece     db  "< El Elemento pertenece al conjunto >",10,0
    msjElementoNoPertenece   db  "Error! El Elemento no pertenece al conjunto >",10,0
    msjConjuntosIguales      db  "< Los conjuntos A y B son iguales >",10,0
    msjConjuntosDistintos    db  "< Los conjuntos A y B no son iguales >",10,0
    msjConjuntoIncluido      db  "< El conjunto A esta incluido en B >",10,0
    msjConjuntoIncluido2     db  "< El conjunto B esta incluido en A >",10,0
    msjConjuntoNoIncluido    db  "Error! Tanto el conjunto A como B no poseen inclusion",10,0
    msjConjuntoUnion         db  "< La union de A y B es: %s >"
    
    ;Prueba
    imprimir                 db  "%lli",10,0
    
    imprimirConjA            db  "Conjunto A  %s",10,0
    imprimirConjB            db  "Conjunto B  %s",10,0
    imprimir4                db  "Paso por aca",10,0
    imprimir5                db  "Paso por aca 2",10,0
    
    imprimirExterno          db  "Cont Externo: %lli",10,0
    imprimirInterno          db  "Cont Interno: %lli",10,0
    imprimirExt              db  "[conjuntoExt + rsi]: %c",10,0
    imprimirInt              db  "[conjuntoInt + rsi]: %c",10,0
    ;

    longitudDeConjunto       dq  0
    contadorExterno          dq  0
    contadorInterno          dq  0
    contadorExtra            dq  0
    contadorExtra2           dq  0
    contadorIncluidos        dq  0

    registro1                dq  0
    registro2                dq  0
    auxIndice                dq  0
    indiceUnion              dq  0

section .bss

    buffer          resb    500
    cantConjuntos   resq    1
    operacion       resq    1
    conjuntoA       resb    41
    conjuntoB       resb    41
    conjuntoC       resb    41
    conjuntoD       resb    41
    conjuntoE       resb    41
    conjuntoF       resb    41
    ElementoA       resb    3
    conjuntoAux     resb    41
    conjuntoUnion   resb    81


section .text

main:


preguntarOperacion:
    mov     rcx,msjIngreseOperacion
    sub     rsp,32
    call    puts
    add     rsp,32

    mov     rcx,buffer
    sub     rsp,32
    call    gets
    add     rsp,32

    mov     rcx,buffer
    mov     rdx,formatoNumero
    mov     r8,operacion
    sub     rsp,32
    call    sscanf
    add     rsp,32

    call    validarRangoOperacion
    cmp     rax,0
    je      preguntarOperacion

    cmp	    byte[operacion],1
    je      handlePertenencia
    cmp	    byte[operacion],2
    je      handleIgualdad
    cmp	    byte[operacion],3
    je      handleInclusion
    cmp	    byte[operacion],4
    je      handleUnion

    ;cmp	    byte[operacion],'*'
    ;jne     preguntarOperacion

    ret

handlePertenencia:
    mov     rcx,msjIngreseConjunto2
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,buffer
    sub     rsp,32
    call    gets
    add     rsp,32

    mov     rcx,buffer
    mov     rdx,formatoConjunto
    mov     r8,conjuntoA
    sub     rsp,32
    call    sscanf
    add     rsp,32

    mov     rcx,msjIngreseElemento
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,buffer
    sub     rsp,32
    call    gets
    add     rsp,32

    mov     rcx,buffer
    mov     rdx,formatoElemento
    mov     r8,ElementoA
    sub     rsp,32
    call    sscanf
    add     rsp,32

    mov     qword[contadorExtra],0
    mov     qword[contadorExterno],-1       ;Seteo contador externo para operacion igualdad

    call    pertenenciaDeElemento           ;Llamado a funcion

    ret

handleIgualdad:
    call    preguntarCantidadDeConjuntos    ;Cargo conjuntos

    mov     qword[contadorExtra],0
    mov     qword[contadorExterno],-1       ;Seteo contador externo para operacion igualdad

    call    igualdadDeConjuntos             ;Llamado a funcion

    ret

handleInclusion:
    call    preguntarCantidadDeConjuntos    ;Cargo conjuntos

    mov     qword[contadorExtra],0
    mov     qword[contadorExterno],-1       ;Seteo contador externo para operacion igualdad

    call    inclusionDeConjuntos            ;Llamado a funcion

    ret

handleUnion:
    call    preguntarCantidadDeConjuntos    ;Cargo conjuntos
    
    mov     qword[contadorInterno],-1       ;Inicializo contador interno en -1

    copiarConjuntoAuxiliar:
        inc     qword[contadorInterno]      ;Incremento contador interno
        
        mov     rsi,qword[contadorInterno]
        mov     al,byte[conjuntoA + rsi]        ;Almaceno 1er caracter del elemento
        mov     byte[registro1],al

        cmp     byte[registro1],0
        je      terminarLoop

        mov     byte[conjuntoAux + rsi],al

        mov     rsi,qword[conjuntoAux]
        mov     qword[conjuntoUnion],rsi        ;Guardo conjunto en variable

        jmp     copiarConjuntoAuxiliar          ;Loop si no finalizo de evaluar el conjunto

    terminarLoop:
        mov     rsi,qword[contadorInterno]
        mov     qword[indiceUnion],rsi          ;Almaceno en variable el contador
    
        mov     qword[contadorExterno],-1       ;Seteo contador externo para operacion union
        call    unionDeConjuntos                ;Llamado a funcion union

    ret

;
;  OPERACIONES
;
unionDeConjuntos:
    ;LOOP CONJUNTO A
    inc     qword[contadorExterno]          ;Inicializo contador externo en 0
    mov     qword[contadorInterno],-1       ;Inicializo contador interno en -1
    
    mov     rsi,qword[contadorExterno]
    mov     al,byte[conjuntoA + rsi]        ;Almaceno 1er caracter del elemento
    mov     byte[registro1],al
    
    cmp     byte[registro1],0               ;Condicion si es salto de linea (ultimo caracter)
    je      imprimirUnion

    inc     qword[contadorExterno]          ;Incremento contador externo

    mov     rsi,qword[contadorExterno]
    mov     ah,byte[conjuntoA + rsi]        ;Almaceno 2do caracter del elemento
    mov     byte[registro2],ah 

    cmp     byte[registro2],0               ;Condicion si es salto de linea (ultimo caracter)
    je      imprimirUnion

    loopUnionDeConjuntos:
        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bl,byte[conjuntoB + rsi]    ;Almaceno 1er caracter del elemento

        cmp     bl,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      unionDeConjuntos

        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bh,byte[conjuntoB + rsi]    ;Almaceno 2do caracter del elemento

        cmp     bh,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      unionDeConjuntos

        cmp     bl,byte[registro1]          ;Comparo los dos primeros caracteres
        je      compararSegundoByteUni      ;Si son iguales evaluo el segundo caracter del elemento

        jmp     agregarAConjunto

        compararSegundoByteUni:
            cmp     bh,byte[registro2]              ;Si los 2 ultimos caracteres son iguales
            jne     agregarAConjunto                ;significa que el elemento es el mismo y sigo con el siguiente

            jmp     loopUnionDeConjuntos            ;Sino, sigo recorriendo

        agregarAConjunto:
            mov     rsi,qword[indiceUnion]          
            mov     byte[conjuntoUnion + rsi],bl    ;Almaceno primer caracter en variable final

            inc     qword[indiceUnion]              ;incremento contador de union

            mov     rsi,qword[indiceUnion] 
            mov     byte[conjuntoUnion + rsi],bh    ;Almaceno segundo caracter en variable final

            mov     rsi,qword[conjuntoUnion]
            mov     qword[conjuntoAux],rsi

            inc     qword[indiceUnion]              ;incremento contador de union

            jmp     loopUnionDeConjuntos

imprimirUnion:
    mov     rcx,msjConjuntoUnion
    mov     rdx,conjuntoUnion
    sub     rsp,32
    call    printf
    add     rsp,32

    ret

pertenenciaDeElemento:
    ;LOOP CONJUNTO A
    inc     qword[contadorExterno]          ;Inicializo contador externo en 0
    
    mov     rsi,qword[contadorExterno]
    mov     al,byte[conjuntoA + rsi]        ;Almaceno 1er caracter del elemento
    mov     byte[registro1],al

    cmp     byte[registro1],0               ;Condicion si es salto de linea (ultimo caracter)
    je      finElementoNoPertence

    inc     qword[contadorExterno]          ;Incremento contador externo

    mov     rsi,qword[contadorExterno]
    mov     ah,byte[conjuntoA + rsi]        ;Almaceno 2do caracter del elemento
    mov     byte[registro2],ah 

    cmp     byte[registro2],0               ;Condicion si es salto de linea (ultimo caracter)
    je      finElementoNoPertence

    loopPertenenciaDeElemento:
        mov     bl,byte[ElementoA]                  ;Almaceno 1er caracter del elemento

        cmp     bl,0                                ;Condicion si es salto de linea (ultimo caracter)
        je      pertenenciaDeElemento

        mov     rsi,1
        mov     bh,byte[ElementoA + rsi]            ;Almaceno 2do caracter del elemento

        cmp     bh,0                                ;Condicion si es salto de linea (ultimo caracter)
        je      pertenenciaDeElemento

        cmp     bl,byte[registro1]                  ;Comparo los dos primeros caracteres
        je      compararSegundoBytePertenencia      ;Si son iguales evaluo el segundo caracter del elemento

        jmp     pertenenciaDeElemento               ;Sino, sigo recorriendo

        compararSegundoBytePertenencia:
            cmp     bh,byte[registro2]              ;Si los 2 ultimos caracteres son iguales
            je      finElementoPertenece            ;El elemento pertenece a Conjunto

            jmp     pertenenciaDeElemento           ;Sino, sigo recorriendo

finElementoNoPertence:
    mov     rcx,msjElementoNoPertenece      ;Imprimo mensaje de error
    sub     rsp,32
    call    printf
    add     rsp,32
    
    ret

finElementoPertenece:
    mov     rcx,msjElementoPertenece        ;Imprimo mensaje de salida ok
    sub     rsp,32
    call    printf
    add     rsp,32
    
    ret

inclusionDeConjuntos:
    ;LOOP CONJUNTO A
    inc     qword[contadorExterno]          ;Inicializo contador externo en 0
    mov     qword[contadorInterno],-1       ;Inicializo contador interno en -1
    
    mov     rsi,qword[contadorExterno]
    mov     al,byte[conjuntoA + rsi]        ;Almaceno 1er caracter del elemento
    mov     byte[registro1],al
    
    cmp     byte[registro1],0               ;Condicion si es salto de linea (ultimo caracter)
    je      verificarInlusion

    inc     qword[contadorExterno]          ;Incremento contador externo

    mov     rsi,qword[contadorExterno]
    mov     ah,byte[conjuntoA + rsi]        ;Almaceno 2do caracter del elemento
    mov     byte[registro2],ah 

    cmp     byte[registro2],0               ;Condicion si es salto de linea (ultimo caracter)
    je      verificarInlusion

    loopConjuntoBInc:
        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bl,byte[conjuntoB + rsi]    ;Almaceno 1er caracter del elemento

        cmp     bl,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      inclusionDeConjuntos

        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bh,byte[conjuntoB + rsi]    ;Almaceno 2do caracter del elemento

        cmp     bh,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      inclusionDeConjuntos

        cmp     bl,byte[registro1]          ;Comparo los dos primeros caracteres
        je      compararSegundoByteInc      ;Si son iguales evaluo el segundo caracter del elemento

        jmp     loopConjuntoBInc

        compararSegundoByteInc:
            cmp     bh,byte[registro2]              ;Si los 2 ultimos caracteres son iguales
            add     qword[contadorIncluidos],2      ;Sumo exitoso

            mov     rsi,qword[contadorIncluidos] 
            mov     qword[contadorExtra],rsi        ;Paso contador a variable para comparar luego

            cmp     bh,byte[registro2]              ;Si los 2 ultimos caracteres son iguales
            je      inclusionDeConjuntos            ;significa que el elemento es el mismo y sigo con el siguiente

            jmp     loopConjuntoBInc                ;Sino, sigo recorriendo


verificarInlusion:
    mov     qword[longitudDeConjunto],-1        ;Inicializo contador en -1

    mov     rcx,conjuntoA                       ;Muevo conjunto a evaluar a un registro
    call    longitudConjunto                    ;Evaluo longitud de conjunto

    mov     rax,qword[longitudDeConjunto]
    mov     qword[auxIndice],rax

    mov     rbx,qword[contadorExtra]            ;Contador Conjunto A

    cmp     rbx,qword[auxIndice]                ;Comparo longitud obtenida con contador
    jne     verificarInlusion2                  ;Si son distintos el conjunto no se recorrio completo por lo cual evaluamos el segundo conjunto                     


    ;
    ;
    ;REVISAR QUE SEA MAYOR O IGUAL PARA PODER REPETIR ELEMENTO EN CONJUNTO 
    ;
    ;



    mov     rcx,msjConjuntoIncluido             ;Sino, los conjuntos son iguales
    sub     rsp,32
    call    printf
    add     rsp,32

    ret

verificarInlusion2:
    mov     qword[longitudDeConjunto],-1

    mov     rcx,conjuntoB                       ;Muevo conjunto a evaluar a un registro
    call    longitudConjunto                    ;Evaluo longitud de conjunto

    mov     rax,qword[longitudDeConjunto]
    mov     qword[auxIndice],rax

    mov     rbx,qword[contadorExtra]            ;Contador Conjunto A

    cmp     rbx,qword[auxIndice]                ;Comparo longitud obtenida con contador
    jne     finNoIncluido

    mov     rcx,msjConjuntoIncluido2
    sub     rsp,32
    call    printf
    add     rsp,32

    ret

finNoIncluido:
    mov     rcx,msjConjuntoNoIncluido       ;Imprimo mensaje de error
    sub     rsp,32
    call    printf
    add     rsp,32
    
    ret


igualdadDeConjuntos:
    ;LOOP CONJUNTO A
    inc     qword[contadorExterno]          ;Inicializo contador externo en 0
    mov     qword[contadorInterno],-1       ;Inicializo contador interno en -1
    
    mov     rsi,qword[contadorExterno]
    mov     al,byte[conjuntoA + rsi]        ;Almaceno 1er caracter del elemento
    mov     byte[registro1],al

    mov     qword[contadorExtra],rsi
    
    cmp     byte[registro1],0                ;Condicion si es salto de linea (ultimo caracter)
    je      verificarLongitud

    inc     qword[contadorExterno]          ;Incremento contador externo

    mov     rsi,qword[contadorExterno]
    mov     ah,byte[conjuntoA + rsi]        ;Almaceno 2do caracter del elemento
    mov     byte[registro2],ah 

    cmp     byte[registro2],0               ;Condicion si es salto de linea (ultimo caracter)
    je      verificarLongitud

    loopConjuntoB:
        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bl,byte[conjuntoB + rsi]    ;Almaceno 1er caracter del elemento

        cmp     bl,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      finNoIguales

        inc     qword[contadorInterno]      ;Incremento contador interno

        mov     rsi,qword[contadorInterno]
        mov     bh,byte[conjuntoB + rsi]    ;Almaceno 2do caracter del elemento

        cmp     bh,0                        ;Condicion si es salto de linea (ultimo caracter)
        je      finNoIguales

        cmp     bl,byte[registro1]          ;Comparo los dos primeros caracteres
        je      compararSegundoByte         ;Si son iguales evaluo el segundo caracter del elemento

        jmp     loopConjuntoB               ;Sino, sigo recorriendo

        compararSegundoByte:
            cmp     bh,byte[registro2]      ;Si los 2 ultimos caracteres son iguales
            je      igualdadDeConjuntos     ;significa que el elemento es el mismo y sigo con el siguiente

            jmp     loopConjuntoB           ;Sino, sigo recorriendo
    

longitudConjunto:
    inc     qword[longitudDeConjunto]

    mov     rsi,qword[longitudDeConjunto]       
    mov     al,byte[rcx + rsi]                  ; Muevo caracter de conjunto a al. rcx posee el conjunto

    cmp     al,0                                ;Comparo si no es fin de cadena
    jne     longitudConjunto                    ;Si no es igual sigo recorriendo y sumando

    ret

verificarLongitud:
    mov     qword[longitudDeConjunto],-1        ;Inicializo contador en -1

    mov     rcx,conjuntoA                       ;Muevo conjunto a evaluar a un registro

    call    longitudConjunto                    ;Evaluo longitud de conjunto

    mov     rax,qword[longitudDeConjunto]
    mov     qword[auxIndice],rax                ;Muevo longitud a variable para luego comparar

    mov     rbx,qword[contadorExtra]

    cmp     rbx,qword[auxIndice]                ;Comparo longitud obtenida con contador
    jne     finNoIguales                        ;Si son distintos el conjunto no se recorrio completo por lo cual no son iguales                     

    mov     rcx,msjConjuntosIguales             ;Sino, los conjuntos son iguales
    sub     rsp,32
    call    printf
    add     rsp,32

    ret 

finNoIguales:
    mov     rcx,msjConjuntosDistintos       ;Imprimo mensaje de error
    sub     rsp,32
    call    printf
    add     rsp,32
    
    ret

; FUNCIONES DE CARGA
preguntarCantidadDeConjuntos:
    mov     rcx,msjIngreseCantConjuntos
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

    mov     rsi,0                           ;Seteo en 0 iterador de conjuntos
    call    cargarConjuntos

    ret

cargarConjuntos:
    inc     rsi

    mov     rcx,msjIngreseConjunto
    mov     rdx,rsi
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,buffer
    sub     rsp,32
    call    gets
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

        ret

completarConjuntoA:
    mov     rcx,buffer
    mov     rdx,formatoConjunto
    mov     r8,conjuntoA
    sub     rsp,32
    call    sscanf
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoB:
    mov     rcx,buffer
    mov     rdx,formatoConjunto
    mov     r8,conjuntoB
    sub     rsp,32
    call    sscanf
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoC:
    mov     rcx,buffer
    mov     rdx,formatoConjunto
    mov     r8,conjuntoC
    sub     rsp,32
    call    sscanf
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoD:
    mov     rcx,buffer
    mov     rdx,formatoConjunto
    mov     r8,conjuntoD
    sub     rsp,32
    call    sscanf
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoE:
    mov     rcx,buffer
    mov     rdx,formatoConjunto
    mov     r8,conjuntoE
    sub     rsp,32
    call    sscanf
    add     rsp,32

    jmp     continuarConjuntos

completarConjuntoF:
    mov     rcx,buffer
    mov     rdx,formatoConjunto
    mov     r8,conjuntoF
    sub     rsp,32
    call    sscanf
    add     rsp,32

    jmp     continuarConjuntos

; FUNCIONES DE VALIDACION
validarRango:
    mov     rax,1
    cmp     qword[cantConjuntos],1
    jle     rangoInvalido           ;Chequeo si el rango <= 1
    cmp     qword[cantConjuntos],6
    jg      rangoInvalido           ;Chequeo si el rango > 6

    ret

validarRangoOperacion:
    mov     rax,1
    cmp     qword[operacion],0
    jle     rangoInvalido           ;Chequeo si el rango <= 0
    cmp     qword[operacion],4
    jg      rangoInvalido           ;Chequeo si el rango > 4

    ret

rangoInvalido:
    mov     rax,0
    mov     rcx,msjRangoInvalido
    sub     rsp,32
    call    puts
    add     rsp,32

    ret