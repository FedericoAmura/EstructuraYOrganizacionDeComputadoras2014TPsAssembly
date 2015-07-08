	.file	"file_reader.c"
	.comm	shortOptions,8,8
	.comm	longOptions,224,32
	.text
	.globl	blankLinesToPrint
	.type	blankLinesToPrint, @function
blankLinesToPrint:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	40(%rbp), %eax
	movl	%eax, 40(%rbp)
	movl	40(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-20(%rbp), %eax
	cltd
	idivl	-4(%rbp)
	movl	%eax, %ecx
	movl	-20(%rbp), %eax
	cltd
	idivl	-4(%rbp)
	movl	%edx, %eax
	addl	%ecx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	blankLinesToPrint, .-blankLinesToPrint
	.globl	printLine
	.type	printLine, @function
printLine:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	$0, -4(%rbp)
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rax
	movq	16(%rbp), %rcx
	movq	%rcx, (%rsp)
	movq	24(%rbp), %rcx
	movq	%rcx, 8(%rsp)
	movq	32(%rbp), %rcx
	movq	%rcx, 16(%rsp)
	movq	40(%rbp), %rcx
	movq	%rcx, 24(%rsp)
	movq	48(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	56(%rbp), %rcx
	movq	%rcx, 40(%rsp)
	movq	64(%rbp), %rcx
	movq	%rcx, 48(%rsp)
	movq	72(%rbp), %rcx
	movq	%rcx, 56(%rsp)
	movl	%edx, %esi
	movq	%rax, %rdi
	call	shouldFormat
	testl	%eax, %eax
	je	.L4
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %ecx
	movq	-24(%rbp), %rax
	movq	16(%rbp), %rsi
	movq	%rsi, (%rsp)
	movq	24(%rbp), %rsi
	movq	%rsi, 8(%rsp)
	movq	32(%rbp), %rsi
	movq	%rsi, 16(%rsp)
	movq	40(%rbp), %rsi
	movq	%rsi, 24(%rsp)
	movq	48(%rbp), %rsi
	movq	%rsi, 32(%rsp)
	movq	56(%rbp), %rsi
	movq	%rsi, 40(%rsp)
	movq	64(%rbp), %rsi
	movq	%rsi, 48(%rsp)
	movq	72(%rbp), %rsi
	movq	%rsi, 56(%rsp)
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	formatLine
	movl	$1, -4(%rbp)
	jmp	.L5
.L4:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	printUnformatted
.L5:
	movl	-4(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	printLine, .-printLine
	.section	.rodata
.LC0:
	.string	"\n"
	.text
	.globl	readFile
	.type	readFile, @function
readFile:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -56(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -16(%rbp)
	movl	32(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	$0, -40(%rbp)
	jmp	.L8
.L13:
	movq	-8(%rbp), %rax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	isLineEmpty
	testl	%eax, %eax
	je	.L9
	addl	$1, -40(%rbp)
	jmp	.L8
.L9:
	movl	-40(%rbp), %eax
	movq	16(%rbp), %rdx
	movq	%rdx, (%rsp)
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rsp)
	movq	32(%rbp), %rdx
	movq	%rdx, 16(%rsp)
	movq	40(%rbp), %rdx
	movq	%rdx, 24(%rsp)
	movq	48(%rbp), %rdx
	movq	%rdx, 32(%rsp)
	movq	56(%rbp), %rdx
	movq	%rdx, 40(%rsp)
	movq	64(%rbp), %rdx
	movq	%rdx, 48(%rsp)
	movq	72(%rbp), %rdx
	movq	%rdx, 56(%rsp)
	movl	%eax, %edi
	call	blankLinesToPrint
	movl	%eax, -32(%rbp)
	movl	$0, -40(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -36(%rbp)
	jmp	.L10
.L12:
	movl	-44(%rbp), %eax
	movq	16(%rbp), %rdx
	movq	%rdx, (%rsp)
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rsp)
	movq	32(%rbp), %rdx
	movq	%rdx, 16(%rsp)
	movq	40(%rbp), %rdx
	movq	%rdx, 24(%rsp)
	movq	48(%rbp), %rdx
	movq	%rdx, 32(%rsp)
	movq	56(%rbp), %rdx
	movq	%rdx, 40(%rsp)
	movq	64(%rbp), %rdx
	movq	%rdx, 48(%rsp)
	movq	72(%rbp), %rdx
	movq	%rdx, 56(%rsp)
	movl	%eax, %edx
	movl	$0, %esi
	movl	$.LC0, %edi
	call	printLine
	movl	%eax, -28(%rbp)
	cmpl	$0, -28(%rbp)
	je	.L11
	movl	36(%rbp), %eax
	addl	%eax, -44(%rbp)
.L11:
	addl	$1, -36(%rbp)
.L10:
	movl	-36(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	.L12
	movq	-8(%rbp), %rax
	movl	%eax, %ecx
	movq	-24(%rbp), %rax
	movl	-44(%rbp), %edx
	movq	16(%rbp), %rsi
	movq	%rsi, (%rsp)
	movq	24(%rbp), %rsi
	movq	%rsi, 8(%rsp)
	movq	32(%rbp), %rsi
	movq	%rsi, 16(%rsp)
	movq	40(%rbp), %rsi
	movq	%rsi, 24(%rsp)
	movq	48(%rbp), %rsi
	movq	%rsi, 32(%rsp)
	movq	56(%rbp), %rsi
	movq	%rsi, 40(%rsp)
	movq	64(%rbp), %rsi
	movq	%rsi, 48(%rsp)
	movq	72(%rbp), %rsi
	movq	%rsi, 56(%rsp)
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	printLine
	movl	%eax, -28(%rbp)
	cmpl	$0, -28(%rbp)
	je	.L8
	movl	36(%rbp), %eax
	addl	%eax, -44(%rbp)
.L8:
	movq	-56(%rbp), %rdx
	leaq	-16(%rbp), %rcx
	leaq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	getline
	movq	%rax, -8(%rbp)
	cmpq	$-1, -8(%rbp)
	jne	.L13
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	readFile, .-readFile
	.section	.rodata
.LC1:
	.string	"r"
.LC2:
	.string	"Error abriendo archivo %s\n"
	.text
	.globl	readFiles
	.type	readFiles, @function
readFiles:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	$0, -12(%rbp)
	movl	72(%rbp), %eax
	testl	%eax, %eax
	jle	.L16
	movl	$0, -16(%rbp)
	jmp	.L17
.L20:
	movq	64(%rbp), %rax
	movl	-16(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L18
	movq	64(%rbp), %rax
	movl	-16(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L19
.L18:
	movq	-8(%rbp), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, (%rsp)
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rsp)
	movq	32(%rbp), %rdx
	movq	%rdx, 16(%rsp)
	movq	40(%rbp), %rdx
	movq	%rdx, 24(%rsp)
	movq	48(%rbp), %rdx
	movq	%rdx, 32(%rsp)
	movq	56(%rbp), %rdx
	movq	%rdx, 40(%rsp)
	movq	64(%rbp), %rdx
	movq	%rdx, 48(%rsp)
	movq	72(%rbp), %rdx
	movq	%rdx, 56(%rsp)
	movq	%rax, %rdi
	call	readFile
	movl	%eax, -12(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	addl	$1, -16(%rbp)
.L17:
	movl	72(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jg	.L20
	jmp	.L21
.L16:
	movq	stdin(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, (%rsp)
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rsp)
	movq	32(%rbp), %rdx
	movq	%rdx, 16(%rsp)
	movq	40(%rbp), %rdx
	movq	%rdx, 24(%rsp)
	movq	48(%rbp), %rdx
	movq	%rdx, 32(%rsp)
	movq	56(%rbp), %rdx
	movq	%rdx, 40(%rsp)
	movq	64(%rbp), %rdx
	movq	%rdx, 48(%rsp)
	movq	72(%rbp), %rdx
	movq	%rdx, 56(%rsp)
	movq	%rax, %rdi
	call	readFile
	movl	%eax, -12(%rbp)
.L21:
	movl	-12(%rbp), %eax
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	readFiles, .-readFiles
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
