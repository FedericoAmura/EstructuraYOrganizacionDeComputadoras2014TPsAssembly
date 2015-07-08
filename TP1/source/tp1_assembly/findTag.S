#include <mips/regdef.h>

#define FT_ERROR_MSG		352
#define FT_LINE_NUMBER		348
#define FT_TAGS_POINTER		344
#define FT_TAG_COUNT		340
#define FT_LAST_POSITION	336
#define FT_START_INDEX		332
#define FT_TEXT			328

#define FT_SSIZE		328

#define	FT_RA			324
#define FT_FP			320
#define FT_GP			316
#define FT_S0			312

#define FT_MSG_BUFFER		56
#define	FT_CLOSE_TAG_NAME	52
#define FT_OPEN_TAG_NAME	48
#define FT_TAG_LENGTH_RESULT	44
#define FT_OPEN_TAG_RESULT	40
#define FT_FIND_TAG_RESULT	36
#define FT_RESULT		32
#define FT_LOCAL_ERROR_MSG	24
#define FT_LOCAL_L_NUMBER	20
#define FT_LOCAL_TAGS_PNTR	16

	.globl	ERROR_INVALID_CLOSING_TAG		#Definicion de constantes
	.rdata
	.align	2
	.type	ERROR_INVALID_CLOSING_TAG, @object
	.size	ERROR_INVALID_CLOSING_TAG, 4
ERROR_INVALID_CLOSING_TAG:
	.word	1
	.globl	SUCCESS
	.align	2
	.type	SUCCESS, @object
	.size	SUCCESS, 4
SUCCESS:
	.word	0
	.align	2
MSGFORMAT:
	.ascii	"Error en linea %d: %s cerrado antes que %s\000"
	.text
	.align	2
	.globl	findTag
	.ent	findTag
findTag:
	.frame	$fp,FT_SSIZE,ra					
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,FT_SSIZE				#Crear stack
	.cprestore 28
	sw	ra,FT_RA(sp)				#Guardo registros del SRA
	sw	$fp,FT_FP(sp)
	sw	gp,FT_GP(sp)
	sw	s0,FT_S0(sp)
	move	$fp,sp

	sw	a0,FT_TEXT($fp)				#Guardar argumentos en ABA del caller
	sw	a1,FT_START_INDEX($fp)
	sw	a2,FT_LAST_POSITION($fp)
	sw	a3,FT_TAG_COUNT($fp)
	lw	t0,SUCCESS				#Inicializo los valores para la llamada 
	sw	t0,FT_RESULT($fp)			#a findTagInner
	lw	a0,FT_TEXT($fp)
	lw	a1,FT_START_INDEX($fp)
	lw	a2,FT_LAST_POSITION($fp)
	lw	a3,FT_LINE_NUMBER($fp)
	la	t9,findTagInner				
	jal	ra,t9					#Busco el siguiente tag
	sw	v0,FT_FIND_TAG_RESULT($fp)		#Guardo resultado en el stack
	lw	t0,FT_FIND_TAG_RESULT($fp)
	beq	t0,zero,SALIR				#Si no lo encuentro, salir
	lw	a0,FT_FIND_TAG_RESULT($fp)		#Cargo en a0 el resultado de findTagInner
	la	t9,isOpenTag				#Verifico si es un tag de apertura
	jal	ra,t9
	sw	v0,FT_OPEN_TAG_RESULT($fp)
	lw	t1,FT_OPEN_TAG_RESULT($fp)
	li	t0,1					#Carga en la salida el valor 0x1
	bne	t1,t0,IS_CLOSE_TAG			#Si es tag de cierre salto
	lw	a0,FT_FIND_TAG_RESULT($fp)		#Caso contrario, encolo
	la	t9,strlen
	jal	ra,t9
	sw	v0,FT_TAG_LENGTH_RESULT($fp)		#Obtengo la longitud del tag
	lw	t0,FT_TAGS_POINTER($fp)			#Cargo el puntero a la lista de tags
	lw	t0,0(t0)				#Desreferencio y cargo el valor del puntero al primer tag
	sll	t1,t0,2					#Multiplico por 4 para convertirlo en un offset
	lw	t0,FT_TAG_COUNT($fp)			#Cargo el valor del tagCount
	addu	s0,t1,t0				#Sumo al offset el valor de tagCount
	lw	t0,FT_TAG_LENGTH_RESULT($fp)
	addu	t0,t0,1					#Incremento en 1 la cantidad de memoria a alocar
	move	a0,t0
	la	t9,malloc
	jal	ra,t9
	sw	v0,0(s0)				#Guardo el puntero a la memoria alocada en s0
	lw	t0,FT_TAGS_POINTER($fp)			#Cargo en v0 el puntero a los tags
	lw	t0,0(t0)				#Desreferencio
	sll	t1,t0,2					#Convierto en offset
	lw	t0,FT_TAG_COUNT($fp)			#Cargo el valor del tagCount
	addu	t0,t1,t0				#Sumo tagCount al offset del puntero a tags
	lw	a0,0(t0)				#Desreferencio
	lw	a1,FT_FIND_TAG_RESULT($fp)
	la	t9,strcpy				#Copio en la posicion del array de tags apuntado 
	jal	ra,t9					#por a0, el valor apuntado por a1
	lw	t1,FT_TAGS_POINTER($fp)
	lw	t0,FT_TAGS_POINTER($fp)
	lw	t0,0(t0)
	addu	t0,t0,1
	sw	t0,0(t1)				#Incrementa tagCount en 1. 
	b	CORTE					#TODO: Ver si se puede hacer de otro modo.
IS_CLOSE_TAG:
	lw	t0,FT_TAGS_POINTER($fp)
	lw	t0,0(t0)
	sll	t1,t0,2
	lw	t0,FT_TAG_COUNT($fp)
	addu	t0,t1,t0
	addu	t0,t0,-4				#Me posiciono en el tag anterior
	lw	t0,0(t0)				#Desreferencio el tag
	sw	t0,FT_TAG_LENGTH_RESULT($fp)		#Guardo puntero al last open tag
	lw	a0,FT_TAG_LENGTH_RESULT($fp)		#Obtengo puntero al last open tag
	la	t9,GetTagName				#Obtengo el nombre del tag de apertura de la cola
	jal	ra,t9
	sw	v0,FT_OPEN_TAG_NAME($fp)
	lw	a0,FT_FIND_TAG_RESULT($fp)
	la	t9,GetTagName				#Obtengo el nombre del tag de cierre
	jal	ra,t9
	sw	v0,FT_CLOSE_TAG_NAME($fp)
	lw	a0,FT_OPEN_TAG_NAME($fp)
	lw	a1,FT_CLOSE_TAG_NAME($fp)
	la	t9,strcmp				#Comparo ambos nombres
	jal	ra,t9
	beq	v0,zero,CONTINUE			#Si son iguales esta bien cerrado y continuo
	lw	t0,ERROR_INVALID_CLOSING_TAG		#Si no, agrego mensaje en errores
	sw	t0,FT_RESULT($fp)
	addu	t1,$fp,FT_MSG_BUFFER			#Apunto al espacio para el msgBuffer
	lw	a2,FT_LINE_NUMBER($fp)
	lw	t0,FT_OPEN_TAG_NAME($fp)
	sw	t0,FT_LOCAL_TAGS_PNTR(sp)
	move	a0,t1					#Asigno el msgBuffer al parametro de sprintf
	la	a1,MSGFORMAT
	lw	a2,0(a2)
	lw	a3,FT_CLOSE_TAG_NAME($fp)
	la	t9,sprintf
	jal	ra,t9
	lw	t1,FT_ERROR_MSG($fp)
	addu	t0,$fp,FT_MSG_BUFFER			#Apunto a la dir del msgBuffer y guardo el mensaje
	sw	t0,0(t1)				#formateado en la dir apuntada por v1. (ERROR_MSG)
CONTINUE:
	lw	t0,FT_TAGS_POINTER($fp)			#Libera los punteros a los nombres
	lw	t0,0(t0)
	lw	t0,FT_TAG_COUNT($fp)
	sll	t1,t0,2
	addu	t0,t1,t0
	addu	t0,t0,-4
	lw	a0,0(t0)
	la	t9,free
	jal	ra,t9
	lw	t0,FT_TAGS_POINTER($fp)
	lw	t0,0(t0)
	addu	t0,t0,-1
	lw	t1,FT_TAGS_POINTER($fp)
	sw	t0,0(t1)
	lw	a0,FT_OPEN_TAG_NAME($fp)
	la	t9,free
	jal	ra,t9
	lw	a0,FT_CLOSE_TAG_NAME($fp)
	la	t9,free
	jal	ra,t9
CORTE:
	lw	t0,SUCCESS
	lw	t1,FT_RESULT($fp)
	bne	t1,t0,SALIR				#Si no hubo errores inicio recursividad
	lw	a0,FT_TEXT($fp)				#a0: text
	lw	t0,FT_LAST_POSITION($fp)
	lw	a1,0(t0)				#a1: *lastPosition
	lw	a2,FT_LAST_POSITION($fp)		#a2: lastPosition
	lw	a3,FT_TAG_COUNT($fp)			#a3: tags
	lw	t0,FT_TAGS_POINTER($fp)
	sw	t0,FT_LOCAL_TAGS_PNTR(sp)		#a4: tagCount
	lw	t0,FT_LINE_NUMBER($fp)
	sw	t0,FT_LOCAL_L_NUMBER(sp)		#a5: lineNumber
	lw	t0,FT_ERROR_MSG($fp)
	sw	t0,FT_LOCAL_ERROR_MSG(sp)		#a6: errmsg
	la	t9,findTag
	jal	ra,t9
	sw	v0,FT_RESULT($fp)
SALIR:
	lw	a0,FT_FIND_TAG_RESULT($fp)
	la	t9,free
	jal	ra,t9

	lw	v0,FT_RESULT($fp)			#Cargo el resultado para devolverlo
	move	sp,$fp					#Vuelvo a cargar los registros del micro
	lw	ra,FT_RA(sp)
	lw	$fp,FT_FP(sp)
	lw	s0,FT_S0(sp)
	addu	sp,sp,FT_SSIZE				#Destruyo stack
	j	ra					#Vuelvo
	.end	findTag

