

start:
	xor	c, c

ClearDisplay:
	mvi	a, 11111111b
	out	1110b, a

	mvi	a, 11111111b
	out	1101b, a

	mvi	a, 11111111b
	out	1011b, a

	mvi	a, 11111111b
	out	0111b, a

	mvi	d, 2		
	xor	b, b


ReadDigit:

	inn	a,1110b		
	ani	a, 00001111b
zero:	
	cmi	a, 00000111b
	jne	one 
	cal	itIsZero
	cal	VypisCisla	
	cal 	wait
one:
	cmi	a, 00001011b	
	jne	two
	cal	itIsOne
	cal	VypisCisla
	cal 	wait
	adi	b, 1
	cmi	d, 1
	jne	two
	mvi	a, 10
	cal	multiply
two:
	cmi	a, 00001101b	
	jne	three
	cal	itIsTwo
	cal	VypisCisla
	cal 	wait
	adi	b, 2
	cmi	d, 1
	jne	three
	mvi	a, 10
	cal	multiply
three:
	cmi	a, 00001110b
	jne	DruhyRiadok
	cal	itIsThree
	cal	VypisCisla
	cal 	wait
	adi	b, 3
	cmi	d, 1
	jne	DruhyRiadok
	mvi	a, 10
	cal	multiply

DruhyRiadok:

	inn	a,1101b		
	ani	a, 00001111b	
four:
	cmi	a, 00000111b	
	jne	five
	cal	itIsFour
	cal	VypisCisla
	cal 	wait
	adi	b, 4
	cmi	d, 1
	jne	five
	mvi	a, 10
	cal	multiply
five:
	cmi	a, 00001011b	
	jne	six
	cal	itIsFive
	cal	VypisCisla
	cal 	wait
	adi	b, 5
	cmi	d, 1
	jne	six
	mvi	a, 10
	cal	multiply
six:
	cmi	a, 00001101b	
	jne	seven
	cal	itIsSix
	cal	VypisCisla
	cal 	wait
	adi	b, 6
	cmi	d, 1
	jne	seven
	mvi	a, 10
	cal	multiply
seven:
	cmi	a, 00001110b	
	jne	TretiRiadok
	cal	itIsSeven
	cal	VypisCisla
	cal 	wait
	adi	b, 7
	cmi	d, 1
	jne	TretiRiadok
	mvi	a, 10
	cal	multiply

TretiRiadok:

	inn	a,1011b		
	ani	a, 00001111b	
eight:
	cmi	a, 00000111b	
	jne	nine
	cal	itIsEight
	cal	VypisCisla
	cal 	wait
	adi	b, 8
	cmi	d, 1
	jne	nine
	mvi	a, 10
	cal	multiply
nine:
	cmi	a, 00001011b	
	jne	ocisti
	cal	itIsNine
	cal	VypisCisla
	cal 	wait
	adi	b, 9
	cmi	d, 1
	jne	ocisti
	mvi	a, 10
	cal	multiply
ocisti:
	cmi	a, 00001101b	
	jne	skontrolujCifry
	jmp	ClearDisplay

skontrolujCifry:
	cmi	d, 0		
	jne	ReadDigit	
	cal	PockajChvilu
	inc	c		
	cmi	c, 2		
	je	nacitajOperaciu	
	pus	b		
	jmp	ClearDisplay	


nacitajOperaciu:
	pop	c		
	mov	a, c
	mov	c, b
	mov	b, a
nulovanie:
	inn	a,1011b		
	ani	a, 00001111b	
	cmi	a, 00001101b	
	jne	StvrtyRiadok
	cal	wait		
	jmp	start		
StvrtyRiadok:
	inn	a,0111b		
	ani	a, 00001111b	
plus:
	cmi	a, 00000111b	
	jne	minus
	add	b, c
	cal	wait
	jmp	vypisVysledok
minus:
	cmi	a, 00001011b	
	jne	krat
	sub	b, c
	cal	wait
	jmp	vypisVysledok
krat:
	cmi	a, 00001101b	
	jne	deleno
	mov	a, c
	cal	multiply
	cal	wait
	jmp	vypisVysledok
deleno:
	cmi	a, 00001110b	
	jne	nulovanie
	cal	divide
	cal	wait
	jmp	vypisVysledok


vypisVysledok:
	mvi	a, 11111111b
	out	1110b, a

	mvi	a, 11111111b
	out	1101b, a

	mvi	a, 11111111b
	out	1011b, a

	mvi	a, 11111111b
	out	0111b, a
	
	xor	d, d

Writing:
	inc	d
	mvi	c, 10
	cal	divide
	cmi	c, 0
	jne	WriteOne
	cal	itIsZero
WriteOne:
	cmi	c, 1
	jne	WriteTwo
	cal	itIsOne
WriteTwo:
	cmi	c, 2
	jne	WriteThree
	cal	itIsTwo
WriteThree:
	cmi	c, 3
	jne	WriteFour
	cal	itIsThree
WriteFour:
	cmi	c, 4
	jne	WriteFive
	cal	itIsFour
WriteFive:
	cmi	c, 5
	jne	WriteSix
	cal	itIsFive
WriteSix:
	cmi	c, 6
	jne	WriteSeven
	cal	itIsSix
WriteSeven:
	cmi	c, 7
	jne	WriteEight
	cal	itIsSeven
WriteEight:
	cmi	c, 8
	jne	WriteNine
	cal	itIsEight
WriteNine:
	cmi	c, 9
	jne	pokracujVoVypise
	cal	itIsNine
	
pokracujVoVypise:
	cal	VypisCisla
	inc	d
	cmi	b, 0
	je	Koniec
	jmp	Writing
Koniec:
	inn 	a, 0		
	ani 	a, 00001111b
	cmi 	a, 1111b
	je	Koniec
	cal	wait
	jmp	start

VypisCisla:
	cmi 	d, 2
	je 	VypisDesiatku
	cmi	d, 3
	je	VypisStovku
	jmp 	VypisJednotku

VypisJednotku:
	out	0111b, a
	dec	d
	ret

VypisDesiatku:
	out	1011b, a
	dec	d
	ret

VypisStovku:
	out	1101b, a
	dec	d
	ret

wait:
	inn 	a, 0		
	ani 	a, 00001111b
	cmi 	a, 1111b
	jne	wait
	ret

PockajChvilu:
	mvi	d, 250
EsteChvilu:
	dec 	d
	cmi	d, 0
	jne	EsteChvilu
	ret


multiply:
	pus	c
	mov	c, b		
multiplication:
	cmi	a, 1
	je	endOfMultiplication
	add	b, c
	dec	a
	jmp	multiplication
endOfMultiplication:
	pop	c
	ret


divide:
	pus	a
	xor	a, a
dividing:
	cmp	b, c
	jl	endOfDividing
	sub	b, c
	inc	a
	jmp	dividing
endOfDividing:
	mov	c, b
	mov	b, a
	pop	a
	ret


itIsZero:
	mvi	a, 00000011b
	ret

itIsOne:
	mvi	a, 10011111b
	ret

itIsTwo:
	mvi	a, 00100101b
	ret

itIsThree:
	mvi	a, 00001101b
	ret

itIsFour:
	mvi	a, 10011001b
	ret

itIsFive:
	mvi	a, 01001001b
	ret

itIsSix:
	mvi	a, 01000001b
	ret

itIsSeven:
	mvi	a, 00011111b
	ret

itIsEight:
	mvi	a, 00000001b
	ret

itIsNine:
	mvi	a, 00001001b
	ret
