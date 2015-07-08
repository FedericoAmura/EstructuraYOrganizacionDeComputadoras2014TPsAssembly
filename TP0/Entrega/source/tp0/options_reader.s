	.file	"options_reader.c"
	.comm	shortOptions,8,8
	.comm	longOptions,224,32
	.text
	.globl	startsWith
	.type	startsWith, @function
startsWith:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp
	testl	%eax, %eax
	jne	.L2
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	$0, %eax
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	startsWith, .-startsWith
	.section	.rodata
.LC0:
	.string	"="
	.text
	.globl	ignoreEquals
	.type	ignoreEquals, @function
ignoreEquals:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	startsWith
	testl	%eax, %eax
	je	.L5
	addq	$1, -8(%rbp)
	movq	-8(%rbp), %rax
	jmp	.L6
.L5:
	movq	-8(%rbp), %rax
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	ignoreEquals, .-ignoreEquals
	.section	.rodata
.LC1:
	.string	"."
	.text
	.globl	parseOptions
	.type	parseOptions, @function
parseOptions:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -88(%rbp)
	movl	%esi, -92(%rbp)
	movq	%rdx, -104(%rbp)
	movl	$0, -64(%rbp)
	movq	$.LC1, -56(%rbp)
	movl	$0, -48(%rbp)
	movl	$1, -44(%rbp)
	movl	$1, -40(%rbp)
	movl	$0, -36(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -8(%rbp)
	movq	$0, -16(%rbp)
.L22:
	movq	shortOptions(%rip), %rdx
	movq	-104(%rbp), %rsi
	movl	-92(%rbp), %eax
	movl	$0, %r8d
	movl	$longOptions, %ecx
	movl	%eax, %edi
	call	getopt_long
	movl	%eax, -68(%rbp)
	cmpl	$-1, -68(%rbp)
	jne	.L8
	nop
	movl	optind(%rip), %eax
	cmpl	-92(%rbp), %eax
	jge	.L23
	jmp	.L27
.L8:
	movl	-68(%rbp), %eax
	cmpl	$105, %eax
	je	.L11
	cmpl	$105, %eax
	jg	.L12
	cmpl	$63, %eax
	je	.L13
	cmpl	$104, %eax
	je	.L14
	cmpl	$-1, %eax
	je	.L28
	jmp	.L10
.L12:
	cmpl	$115, %eax
	je	.L16
	cmpl	$115, %eax
	jg	.L17
	cmpl	$108, %eax
	je	.L18
	jmp	.L10
.L17:
	cmpl	$116, %eax
	je	.L19
	cmpl	$118, %eax
	je	.L20
	jmp	.L10
.L14:
	movl	$1, -36(%rbp)
	jmp	.L21
.L19:
	movl	$1, -64(%rbp)
	jmp	.L21
.L16:
	movq	optarg(%rip), %rax
	movq	%rax, %rdi
	call	ignoreEquals
	movq	%rax, -56(%rbp)
	jmp	.L21
.L20:
	movq	optarg(%rip), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -48(%rbp)
	jmp	.L21
.L11:
	movq	optarg(%rip), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -44(%rbp)
	jmp	.L21
.L18:
	movq	optarg(%rip), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -40(%rbp)
	jmp	.L21
.L13:
	movl	$1, -24(%rbp)
	jmp	.L21
.L10:
	call	abort
.L28:
	nop
.L21:
	jmp	.L22
.L27:
	movl	$0, -72(%rbp)
	movl	optind(%rip), %eax
	movl	-92(%rbp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -16(%rbp)
	jmp	.L24
.L25:
	movq	-16(%rbp), %rax
	movl	-72(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	leaq	(%rax,%rdx), %rcx
	movl	optind(%rip), %eax
	leal	1(%rax), %edx
	movl	%edx, optind(%rip)
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-104(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	addl	$1, -72(%rbp)
.L24:
	movl	optind(%rip), %eax
	cmpl	-92(%rbp), %eax
	jl	.L25
.L23:
	movq	-88(%rbp), %rax
	movq	-64(%rbp), %rdx
	movq	%rdx, (%rax)
	movq	-56(%rbp), %rdx
	movq	%rdx, 8(%rax)
	movq	-48(%rbp), %rdx
	movq	%rdx, 16(%rax)
	movq	-40(%rbp), %rdx
	movq	%rdx, 24(%rax)
	movq	-32(%rbp), %rdx
	movq	%rdx, 32(%rax)
	movq	-24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	movq	-16(%rbp), %rdx
	movq	%rdx, 48(%rax)
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	movq	-88(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	parseOptions, .-parseOptions
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
