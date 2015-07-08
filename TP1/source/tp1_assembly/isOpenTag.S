#include <mips/regdef.h>

#define IOT_TAG_POINTER	16

#define IOT_SSIZE 	16

#define IOT_FP		12
#define IOT_GP		8
#define IOT_RESULT	0

	.text
	.align	2
	.globl	isOpenTag
	.ent	isOpenTag
isOpenTag:
	.frame	$fp,IOT_SSIZE,ra		
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,IOT_SSIZE			#Crear stack
	.cprestore 0
	sw	$fp,IOT_FP(sp)			#Guardo las variables en el stack. Es una funcion hoja. No requiere ra
	sw	gp,IOT_GP(sp)
	move	$fp,sp

	sw	a0,IOT_TAG_POINTER($fp)		#Guardar argumentos en ABA del caller

	lw	t0,IOT_TAG_POINTER($fp)
	addu	t0,t0,1				#Apunto a la posicion 1 del tag
	lb	t1,0(t0)			#Desreferencio el caracter en la posicion 1	
	li	t0,47				#Cargo el caracter '/'
	bne	t1,t0,SEGUIR			#Si no es igual 
	sw	zero,IOT_RESULT($fp)
	b	SALIR
SEGUIR:
	li	t0,1				#result = 1
	sw	t0,IOT_RESULT($fp)
SALIR:
	lw	v0,IOT_RESULT($fp)		#Cargo el resultado para devolverlo
	move	sp,$fp				#Vuelvo a cargar los registros del micro
	lw	$fp,IOT_FP(sp)
	addu	sp,sp,IOT_SSIZE			#Destruyo stack
	j	ra				#Vuelvo
	.end	isOpenTag

