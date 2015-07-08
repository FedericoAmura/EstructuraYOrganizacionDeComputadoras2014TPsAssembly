	.file	"main.c"
	.comm	shortOptions,8,8
	.comm	longOptions,224,32
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	leaq	-64(%rbp), %rax
	movq	-80(%rbp), %rdx
	movl	-68(%rbp), %ecx
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	parseOptions
	cmpl	$1, -68(%rbp)
	je	.L2
	movl	-36(%rbp), %eax
	cmpl	$1, %eax
	jne	.L3
.L2:
	movq	-64(%rbp), %rax
	movq	%rax, (%rsp)
	movq	-56(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	-48(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	-40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	-32(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	-24(%rbp), %rax
	movq	%rax, 40(%rsp)
	movq	-16(%rbp), %rax
	movq	%rax, 48(%rsp)
	movq	-8(%rbp), %rax
	movq	%rax, 56(%rsp)
	call	printHelp
	jmp	.L4
.L3:
	movl	-24(%rbp), %eax
	testl	%eax, %eax
	je	.L5
	movq	-64(%rbp), %rax
	movq	%rax, (%rsp)
	movq	-56(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	-48(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	-40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	-32(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	-24(%rbp), %rax
	movq	%rax, 40(%rsp)
	movq	-16(%rbp), %rax
	movq	%rax, 48(%rsp)
	movq	-8(%rbp), %rax
	movq	%rax, 56(%rsp)
	call	printHelp
	movl	$1, %edi
	call	exit
.L5:
	movq	-64(%rbp), %rax
	movq	%rax, (%rsp)
	movq	-56(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	-48(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	-40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	-32(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	-24(%rbp), %rax
	movq	%rax, 40(%rsp)
	movq	-16(%rbp), %rax
	movq	%rax, 48(%rsp)
	movq	-8(%rbp), %rax
	movq	%rax, 56(%rsp)
	call	readFiles
.L4:
	movq	-64(%rbp), %rax
	movq	%rax, (%rsp)
	movq	-56(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	-48(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	-40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	-32(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	-24(%rbp), %rax
	movq	%rax, 40(%rsp)
	movq	-16(%rbp), %rax
	movq	%rax, 48(%rsp)
	movq	-8(%rbp), %rax
	movq	%rax, 56(%rsp)
	call	freeOptions
	movl	$0, %edi
	call	exit
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
