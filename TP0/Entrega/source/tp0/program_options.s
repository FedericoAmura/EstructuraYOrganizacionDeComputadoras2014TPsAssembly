	.file	"program_options.c"
	.globl	shortOptions
	.section	.rodata
.LC0:
	.string	"s:v:i:tl:h"
	.align 8
	.type	shortOptions, @object
	.size	shortOptions, 8
shortOptions:
	.quad	.LC0
	.globl	longOptions
.LC1:
	.string	"number-separator"
.LC2:
	.string	"starting-line-number"
.LC3:
	.string	"line-increment"
.LC4:
	.string	"non-empty"
.LC5:
	.string	"join-blank-lines"
.LC6:
	.string	"help"
	.align 32
	.type	longOptions, @object
	.size	longOptions, 224
longOptions:
	.quad	.LC1
	.long	1
	.zero	4
	.quad	0
	.long	115
	.zero	4
	.quad	.LC2
	.long	1
	.zero	4
	.quad	0
	.long	118
	.zero	4
	.quad	.LC3
	.long	1
	.zero	4
	.quad	0
	.long	105
	.zero	4
	.quad	.LC4
	.long	0
	.zero	4
	.quad	0
	.long	116
	.zero	4
	.quad	.LC5
	.long	1
	.zero	4
	.quad	0
	.long	108
	.zero	4
	.quad	.LC6
	.long	1
	.zero	4
	.quad	0
	.long	104
	.zero	4
	.quad	0
	.long	0
	.zero	4
	.quad	0
	.long	0
	.zero	4
	.align 8
.LC7:
	.string	"Uso: %s opciones [ argumentos ...]\n"
	.align 8
.LC8:
	.ascii	"    -s, --number-separator. Indica el texto separador entre "
	.ascii	"n\303\272mero de l\303\255nea y la\n          l\303\255nea.\n"
	.ascii	"    -v, --starting-line-number. Indica el n\303\272mero de l"
	.ascii	"a primer l\303\255nea.\n    -i, --line-increment. Indica el "
	.ascii	"incremento entre l\303\255neas consecutivas.\n    -t, --non-"
	.ascii	"empty. Si est\303\241 presente, solo se "
	.string	"deben numerar las l\303\255neas no\n          vacias. Caso contrario, tambi\303\251n deben numerar las l\303\255neas vacias.\n    -l, --join-blank-lines. Indica la cantidad de l\303\255neas vacias a agrupar en una\n          unica l\303\255nea.\n    -h, --help. Imprime el mensaje de ayuda."
	.text
	.globl	printHelp
	.type	printHelp, @function
printHelp:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	48(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	movl	$.LC8, %edi
	call	puts
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	printHelp, .-printHelp
	.globl	freeOptions
	.type	freeOptions, @function
freeOptions:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	64(%rbp), %rax
	testq	%rax, %rax
	je	.L2
	movq	64(%rbp), %rax
	movq	%rax, %rdi
	call	free
.L2:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	freeOptions, .-freeOptions
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
