#include <mips/regdef.h>

#define V_ERR_MSG		4172
#define V_TEXT			4168

#define V_SSIZE			4168

#define V_RA			4160
#define	V_FP			4156
#define V_GP			4152
#define V_INDEX			4144
#define V_RESULT		4140
#define V_TAG_COUNT		4136
#define V_LAST_POSITION		4132
#define V_START_INDEX		4128
#define V_TAGS_START		48

#define V_LOCAL_ERRMSG		24
#define V_LOCAL_LINENUMBER	20
#define V_LOCAL_TAGCOUNT	16

	.text
	.align	2
	.globl	validate
	.ent	validate
validate:
	.frame	$fp,V_SSIZE,ra		
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,V_SSIZE			#Crear stack
	.cprestore 32
	sw	ra,V_RA(sp)			#Guardo registros del SRA
	sw	$fp,V_FP(sp)
	sw	gp,V_GP(sp)
	move	$fp,sp

	sw	a0,V_TEXT($fp)			#Guardar argumentos en ABA del caller
	sw	a1,V_ERR_MSG($fp)

	sw	zero,V_START_INDEX($fp)		#Declara el vector de punteros a tags
	sw	zero,V_LAST_POSITION($fp)	#Declara lastposition
	sw	zero,V_TAG_COUNT($fp)		#Declara tagcount
	sw	zero,V_RESULT($fp)		#Declara result
	sw	zero,V_INDEX($fp)		#Declara index
						#Empieza a cargar los parametros para llamar a findTag
	lw	a0,V_SSIZE($fp)			#a0: text
	lw	a1,V_START_INDEX($fp)		#a1: startIndex
	addu	a2,$fp,V_LAST_POSITION		#a2: lastPosition
	addu	a3,$fp,V_TAGS_START		#a3: tags
	addu	t0,$fp,V_TAG_COUNT
	sw	t0,V_LOCAL_TAGCOUNT(sp)		#a4: tagcount
	addu	t0,$fp,40
	sw	t0,V_LOCAL_LINENUMBER(sp)	#a5: linenumber
	lw	t0,V_ERR_MSG($fp)
	sw	t0,V_LOCAL_ERRMSG(sp)		#a6: errmsg
	la	t9,findTag
	jal	ra,t9				#Llamo a findtag
	sw	v0,V_RESULT($fp)		#Guardo la devolucion de findTag
	sw	zero,V_INDEX($fp)		#i=0
LOOP:
	lw	t0,V_INDEX($fp)			#Cargo i
	lw	t1,V_TAG_COUNT($fp)		#Cargo tagCount
	slt	t0,t0,t1			#Veo si tagCount es mayor que i
	bne	t0,zero,LIBERAR_TAGS		#Si es mayor, libero tag
	b	SALIR				#Si no, salgo
LIBERAR_TAGS:
	lw	t0,V_INDEX($fp)			#Cargo i
	sll	t1,t0,2				#i=i*4
	addu	t0,$fp,V_TAGS_START		#Cargo el inicio de los tags
	addu	t0,t1,t0			#Muevo referencia al tag correspondiente
	lw	a0,0(t0)			#a0: tags[i]
	la	t9,free
	jal	ra,t9				#Libero el tag
	lw	t0,V_INDEX($fp)			#Cargo i
	addu	t0,t0,1				#i++
	sw	t0,V_INDEX($fp)			#Guardo i
	b	LOOP				#Repito el ciclo
SALIR:
	lw	v0,V_RESULT($fp)		#Cargo el resultado para devolverlo
	move	sp,$fp				#Vuelvo a cargar los registros del micro
	lw	ra,V_RA(sp)
	lw	$fp,V_FP(sp)
	addu	sp,sp,V_SSIZE			#Destruyo stack
	j	ra				#Vuelvo
	.end	validate


