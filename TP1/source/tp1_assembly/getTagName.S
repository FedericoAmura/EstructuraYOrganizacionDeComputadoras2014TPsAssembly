#include <mips/regdef.h>

#define GTN_TAG_POINTER	48

#define GTN_SSIZE	48

#define GTN_RA		40
#define GTN_FP		36
#define GTN_GP		32
#define GTN_NAME_START	24
#define GTN_NAME_LENGTH	20
#define GTN_TAGNAME	16

	.text
	.align	2
	.globl	GetTagName
	.ent	GetTagName
GetTagName:
	.frame	$fp,GTN_SSIZE,ra		
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,GTN_SSIZE			#Crear stack
	.cprestore 12
	sw	ra,GTN_RA(sp)			#Guardo registros del SRA
	sw	$fp,GTN_FP(sp)
	sw	gp,GTN_GP(sp)
	move	$fp,sp

	sw	a0,GTN_TAG_POINTER($fp)		#Guardar argumentos en ABA del caller
	sw	zero,GTN_TAGNAME($fp)		#Inicializa el tagName en NULL
	lw	a0,GTN_TAG_POINTER($fp)		
	la	t9,strlen
	jal	ra,t9
	addu	t0,v0,-2			#Le resto los <> a la longitud
	sw	t0,GTN_NAME_LENGTH($fp)		#Guardo la longitud del nombre
	li	t0,1			
	sw	t0,GTN_NAME_START($fp)		#Almaceno 1 en la pos de comienzo de nombre
	lw	a0,GTN_TAG_POINTER($fp)
	la	t9,isOpenTag			#Verifico si es un tag de apertura
	jal	ra,t9
	bne	v0,zero,GETNAME
	lw	a0,GTN_TAG_POINTER($fp)		#Si no es de apertura tengo </..> y cambio el start index
	la	t9,strlen
	jal	ra,t9
	addu	t0,v0,-3
	sw	t0,GTN_NAME_LENGTH($fp)		#La longitud es tag - 3
	li	t0,2			
	sw	t0,GTN_NAME_START($fp)		#Start index es 2
GETNAME:
	lw	a0,GTN_NAME_LENGTH($fp)
	la	t9,malloc
	jal	ra,t9
	sw	v0,GTN_TAGNAME($fp)		#Memoria alocada para la copia del nombre del tag
	lw	t1,GTN_TAG_POINTER($fp)
	lw	t0,GTN_NAME_START($fp)
	addu	t0,t1,t0			#Apunto al comienzo del nombre
	lw	a0,GTN_TAGNAME($fp)		#Cargo parametros de strncpy. a0: tagName (destino)
	move	a1,t0				#a1: tagPointer con offset (origen)
	lw	a2,GTN_NAME_LENGTH($fp)		#a2: cantidad de caracteres a copiar
	la	t9,strncpy
	jal	ra,t9				#Llamo a strncpy
	lw	t1,GTN_TAGNAME($fp)		
	lw	t0,GTN_NAME_LENGTH($fp)
	addu	t0,t1,t0
	sb	zero,0(t0)			#Pongo el caracter de fin de linea '\0'

	lw	v0,GTN_TAGNAME($fp)		#Pongo en el registro de salida el puntero al nombre
	move	sp,$fp				#Vuelvo a cargar los registros del micro
	lw	ra,GTN_RA(sp)
	lw	$fp,GTN_FP(sp)
	addu	sp,sp,GTN_SSIZE			#Destruyo stack
	j	ra				#Vuelvo
	.end	GetTagName

