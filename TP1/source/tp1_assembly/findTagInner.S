#include <mips/regdef.h>


#define FTI_LINE_NUMBER  76
#define FTI_LAST_POS	 72
#define FTI_START_INDEX	 68
#define FTI_TEXT	 64

#define FTI_SSIZE 	 64

#define FTI_RA 		 56
#define FTI_FP		 52
#define FTI_GP		 48

#define FTI_RESULT	 40
#define FTI_TOTAL_LENGTH 36
#define FTI_TAG_NAME	 32
#define FTI_TAG_START_POSITION	28
#define FTI_TEXT_LENGTH	 24
#define FTI_CURRENT_POS  20
#define FTI_FOUND	 16





	.text
	.align	2
	.globl	findTagInner
	.ent	findTagInner
findTagInner:
	.frame	$fp,FTI_SSIZE,ra
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,FTI_SSIZE			#Crear stack
	.cprestore 12
	sw	ra,FTI_RA(sp)			#Guardo registros del SRA
	sw	$fp,FTI_FP(sp)
	sw	gp,FTI_GP(sp)
	move	$fp,sp

	sw	a0,FTI_SSIZE($fp)		#Guardar argumentos en ABA del caller
	sw	a1,FTI_START_INDEX($fp)
	sw	a2,FTI_LAST_POS($fp)
	sw	a3,FTI_LINE_NUMBER($fp)

	lw	t0,FTI_START_INDEX($fp)
	sw	t0,FTI_CURRENT_POS($fp)
	sw	zero,FTI_FOUND($fp)
	lw	a0,FTI_SSIZE($fp)
	la	t9,strlen
	jal	ra,t9
	sw	v0,FTI_TEXT_LENGTH($fp)
	li	t0,-1			
	sw	t0,FTI_TAG_START_POSITION($fp)
LOOP:
	lw	t0,FTI_CURRENT_POS($fp)		#Verifico condicion de while
	lw	t1,FTI_TEXT_LENGTH($fp)
	slt	t0,t0,t1
	beq	t0,zero,ENDLOOP
	lw	t0,FTI_FOUND($fp)
	bne	t0,zero,ENDLOOP		
	lw	t1,FTI_TEXT($fp)		#Obtengo puntero a la posicion inicial del texto
	lw	t0,FTI_CURRENT_POS($fp)
	addu	t0,t1,t0
	lb	t1,0(t0)
	li	t0,60				#Comparo contra el caracter '<'			
	bne	t1,t0,CHECKEOL
	lw	t0,FTI_CURRENT_POS($fp)
	sw	t0,FTI_TAG_START_POSITION($fp)   #Si son iguales asigno current pos a tag start pos
CHECKEOL:
	lw	t1,FTI_TEXT($fp)
	lw	t0,FTI_CURRENT_POS($fp)
	addu	t0,t1,t0
	lb	t1,0(t0)
	li	t0,10				#Salto de linea '\n'
	bne	t1,t0,CHECKENDOFTAG
	lw	t1,FTI_LINE_NUMBER($fp)
	lw	t0,FTI_LINE_NUMBER($fp)
	lw	t0,0(t0)
	addu	t0,t0,1
	sw	t0,0(t1)
CHECKENDOFTAG:
	lw	t1,FTI_TEXT($fp)
	lw	t0,FTI_CURRENT_POS($fp)
	addu	t0,t1,t0
	lb	t1,0(t0)
	li	t0,62				#Caracter '>'	
	bne	t1,t0,NEXT			#Si no es igual paso al siguiente caracter
	lw	t1,FTI_CURRENT_POS($fp)
	lw	t0,FTI_TAG_START_POSITION($fp)
	subu	t0,t1,t0
	addu	t0,t0,1
	sw	t0,FTI_TOTAL_LENGTH($fp)		#Calculo el total length del tag
	li	t0,1			
	sw	t0,FTI_FOUND($fp)		#Seteo found en 1
	lw	a0,FTI_TOTAL_LENGTH($fp)
	la	t9,malloc			#Aloco memoria para la copia del tag
	jal	ra,t9
	sw	v0,FTI_TAG_NAME($fp)		
	lw	t1,FTI_TEXT($fp)		#Inicializo los parametros de strncpy
	lw	t0,FTI_TAG_START_POSITION($fp)	
	addu	t0,t1,t0
	lw	a0,FTI_TAG_NAME($fp)		#a0: Puntero al tagName
	move	a1,t0				#a1: Puntero a la posicion del text
	lw	a2,FTI_TOTAL_LENGTH($fp)	#a2: Cantidad de caracteres a copiar
	la	t9,strncpy
	jal	ra,t9
	lw	t1,FTI_TAG_NAME($fp)
	lw	t0,FTI_TOTAL_LENGTH($fp)
	addu	t0,t1,t0
	sb	zero,0(t0)			#Guarda el caracter de fin de string '\0'
NEXT:
	lw	t0,FTI_CURRENT_POS($fp)
	addu	t0,t0,1
	sw	t0,FTI_CURRENT_POS($fp)
	b	LOOP
ENDLOOP:
	lw	t1,FTI_FOUND($fp)
	li	t0,1			
	bne	t1,t0,NOTFOUND
	lw	t0,FTI_LAST_POS($fp)
	lw	t1,FTI_CURRENT_POS($fp)
	sw	t1,0(t0)
	lw	t0,FTI_TAG_NAME($fp)
	sw	t0,FTI_RESULT($fp)
	b	END
NOTFOUND:
	sw	zero,FTI_LAST_POS($fp)
	sw	zero,FTI_RESULT($fp)
END:
	lw	v0,FTI_RESULT($fp)		#Cargo el resultado para devolverlo
	move	sp,$fp				#Vuelvo a cargar los registros del micro
	lw	ra,FTI_RA(sp)
	lw	$fp,FTI_FP(sp)
	addu	sp,sp,FTI_SSIZE			#Destruyo stack
	j	ra				#Vuelvo
	.end	findTagInner

