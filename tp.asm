global main
extern gets
extern puts
extern printf
extern sscanf


section .data

    msjIngreseConjuntos      db  "Ingrese cantidad de conjuntos por teclado",0
    formatoNumero            db  "%lli",0
    ;msjImprimir              db  "%lli",10,0

    msjRangoInvalido         db  "El rango ingresado es invalido",0

section .bss

    buffer          resb    500
    matriz          resb    1
    cantConjuntos   resq    1
    conjuntoA       resb    500


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

    ;ESTO IMPRIME EL NUMERO INGRESADO
    ;mov     rcx,msjImprimir
    ;mov     rdx,[cantConjuntos]
    ;sub     rsp,32
    ;call    printf
    ;add     rsp,32


    call    validarRango
    cmp     rax,0
    je      preguntarCantidadDeConjuntos


    ret


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