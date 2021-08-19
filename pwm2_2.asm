/*
 * assPWM2.asm
 *
 *  Created: 2020-01-23 19:45:45
 *   Author: a
 */ 
 .DEF tt = R16
 .DEF test = R14
 
.include "m328Pdef.inc"

.ORG $0000
	rjmp initTimer

.org OC0Aaddr
	rjmp Timer1





initTimer:
	cli
	;konfiguracja A 
	in tt,TCCR0A
	 ldi tt, (1<<COM0A0);|(1<<COM0A0);|(1<<WGM00);|(1<<WGM01)
	out TCCR0A , tt
	;konfiguracja B
	in tt,TCCR0B
	ldi tt, (1<<CS00);|(1<<WGM02)
	out TCCR0B , tt


	ldi tt , 50
	out OCR0A , tt;wartosc porownania timera

	ldi r16,(1<<TOV0)| (1 << OCF0A) | (1 << OCF0B)
	out TIFR0,r16 ; Clear TOV0/ Clear pending interrupts
	ldi r16,(1<<TOIE0)|(1<<OCIE0A)
	sts TIMSK0,r16 ; Enable Timer/Counter0 Overflow Interrupt
	sei
main:
;out TCCR0A , test	
in test	,TCNT0 
rjmp main

Timer1:
	ldi tt , 20
reti;
