/*
 * assPWM2.asm
 *
 *  Created: 2020-01-23 19:45:45
 *   Author: a
 */ 
 .DEF tt = R16
 .DEF test = R14
 .ORG $0000
.include "m328Pdef.inc"
   
;konfiguracja A 
cli
;in tt,TCCR2A
ldi tt, (1<<COM2A1)|(1<<WGM20)|(1<<WGM21);
sts TCCR2A , tt
;konfiguracja B
;in tt,TCCR2B
ldi tt, (1<<CS00);|(1<<WGM02)
sts TCCR2B , tt
sbi DDRB, PORTB3 ; Set OC2A pin as output


ldi tt , 20
sts OCR2A , tt;wartosc porownania timera

ldi r16,(1<<TOV2)| (1 << OCF2A); | (1 << OCF0B)
out TIFR0,r16 ; Clear TOV0/ Clear pending interrupts
ldi r16,(1<<TOIE2)|(1<<OCIE2A)
sts TIMSK2,r16 ; Enable Timer/Counter0 Overflow Interrupt
sei
main:
;out TCCR0A , test	
;sts test,LTCNT2

rjmp main




ISR_OCIE2A:
push r16
in r16,SREG
pop r16
reti

