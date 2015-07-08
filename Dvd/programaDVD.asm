!solucion programada para el controlador de un dvd
!se usa %r1 para trabajar con las entradas
!se usa %r2 para trabajar con el sensor de disco
!se usa %r3 para guardar la cuenta necesaria para esperar 3 segundos
!se usa %r4 para trabajar con las salidas a salir

	.begin
	.org 2048

!direcciones de las entradas y salidas
ENTRADAS .equ	0xB032C008
SALIDAS	.equ	0xB032C00C
	in: ENTRADAS
	out: SALIDAS

!flags de las entradas
EJECT	.equ	1
PLAY	.equ	2
STOP	.equ	4
PAUSA	.equ	8
DISCO	.equ	0x80000000
	disc: DISCO

!flags de las salidas
BANDEJA	.equ	4
MOTOR	.equ	2
REPRODUCTOR .equ	1

reset:	ld [out],%r4	!cargo el registro de las salidas en r4
	andn %r4,BANDEJA+MOTOR+REPRODUCTOR,%r4	!me quedo con todo menos las salidas, pasandolas a 0
	st %r4,[out]	!cargo las salidas desactivadas en su registro

parado:	ld [in],%r1	!cargo el registro donde leo las entradas
	and %r1,EJECT+PLAY,%r1	!me quedo con los bits de las entradas que me pueden cambiar el estado

	andcc %r1,EJECT,%r0	!veo si apretaron el eject, descarto resultado
	bne esperando		!salto si el eject estaba en 1, si no lo apretaron el flag zero debio estar activado

	ld [out],%r2	!cargo el registro de las salidas
	andcc %r2,disc,%r2	!me quedo con el bit del sensor de disco y veo si esta activado
	be parado		!si no hay disco vuelvo a stop, no puedo seguir sin disco dentro

	andcc %r1,PLAY,%r0	!veo si apretaron el play, descarto resultado
	bne reproduccion	!si apretaron el resultado fue distinto de cero

	ba parado		!no apretaron nada, vuelvo


pausar:	ld [out],%r4	!cargo el registro de las salidas en r4
	andn %r4,BANDEJA+MOTOR+REPRODUCTOR,%r4	!me quedo con todo menos las salidas, pasandolas a 0
	add %r4,MOTOR,%r4	!prendo el motor en las salidas
	st %r4,[out]	!cargo las salidas acordes en su registro

pausado:	ld [in],%r1	!cargo el registro donde leo las entradas
	and %r1,EJECT+PLAY+STOP,%r1	!me quedo con los bits de las entradas que me pueden cambiar el estado

	andcc %r1,EJECT,%r0	!veo si apretaron el eject, descarto resultado
	bne esperando		!salto si el eject estaba en 1 y voy a esperar, si no lo apretaron el flag zero debio estar activado

	andcc %r1,PLAY,%r0	!veo si apretaron el play, descarto resultado
	bne reproduccion	!si apretaron el resultado fue distinto de cero

	andcc %r1,STOP,%r0	!veo si apretaron el stop, descarto resultado
	bne reset		!si apretaron el resultado fue distinto de cero

	ba pausado		!no apretaron nada, vuelvo


reproduccion:	ld [out],%r4	!cargo el registro de las salidas en r4
	andn %r4,BANDEJA+MOTOR+REPRODUCTOR,%r4	!me quedo con todo menos las salidas, pasandolas a 0
	add %r4,MOTOR+REPRODUCTOR,%r4	!prendo el motor y el reproductor
	st %r4,[out]	!cargo las salidas acordes en su registro

reproduciendo:	ld [in],%r1	!cargo el registro donde leo las entradas
	and %r1,EJECT+STOP+PAUSA,%r1	!me quedo con los bits de las entradas que me pueden cambiar el estado

	andcc %r1,EJECT,%r0	!veo si apretaron el eject, descarto resultado
	bne esperando		!salto si el eject estaba en 1 y voy a esperar, si no lo apretaron el flag zero debio estar activado

	andcc %r1,STOP,%r0	!veo si apretaron el stop, descarto resultado
	bne reset		!si apretaron el resultado fue distinto de cero

	andcc %r1,PAUSA,%r0	!veo si apretaron el pausa, descarto resultado
	bne pausar		!si apretaron el resultado fue distinto de cero

	ba reproduciendo	!no apretaron nada, vuelvo


esperando:	ld [out],%r4	!cargo el registro de las salidas en r4
	andn %r4,MOTOR+REPRODUCTOR,%r4	!paro el motor y el reproductor
	st %r4,[out]	!cargo las salidas acordes en su registro
	!add %r0,TRESSEGUNDOS,%r3 !cargo la cantidad de ciclos a esperar
	sethi 0x47868,%r3	!cargo los 22 bits mas significativos
	add %r3,0x300,%r3	!cargo los 10 bits restantes

espera:	addcc %r3,-1,%r3	!resto uno al contador
	bne espera	!si no llegue a cero sigo contando

abrircerrar:	xor %r4,BANDEJA,%r4	!cambio el valor de la bandeja
	st %r4,[out]	!cargo las salidas acordes en su registro
	ba parado

	.end
