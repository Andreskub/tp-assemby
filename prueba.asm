	.file	"prueba.c"
	.intel_syntax noprefix
	.text
	.globl	conjutnoA
	.data
	.align 8
conjutnoA:
	.ascii "JKA6AS48DFAL\0"
	.globl	conjutnoB
	.align 8
conjutnoB:
	.ascii "JKA6AS48DFAL\0"
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Tenemos el caracter '%c'\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbp
	.seh_pushreg	rbp
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 56
	.seh_stackalloc	56
	lea	rbp, 128[rsp]
	.seh_setframe	rbp, 128
	.seh_endprologue
	call	__main
	mov	DWORD PTR -84[rbp], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -84[rbp]
	movsx	rdx, eax
	lea	rax, conjutnoA[rip]
	movzx	eax, BYTE PTR [rdx+rax]
	mov	BYTE PTR -85[rbp], al
	movsx	eax, BYTE PTR -85[rbp]
	mov	edx, eax
	lea	rcx, .LC0[rip]
	call	printf
	add	DWORD PTR -84[rbp], 1
.L2:
	mov	eax, DWORD PTR -84[rbp]
	movsx	rbx, eax
	lea	rcx, conjutnoA[rip]
	call	strlen
	cmp	rbx, rax
	jb	.L3
	mov	eax, 0
	add	rsp, 56
	pop	rbx
	pop	rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-win32-sjlj-rev0, Built by MinGW-W64 project) 7.3.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	strlen;	.scl	2;	.type	32;	.endef
