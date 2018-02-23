;
; Assignment_1.asm
;
; Created: 2/12/2018 10:54:49 AM
; Author : Damian Cisneros
;

.ORG 0

; Set variables to locations
.EQU STARTADDS = 0x0222
.EQU FOURHUNDRED = 0x0400
.EQU SIXHUNDRED = 0x0600

LDI R23, 255 ; Numbers to place
LDI R20, 0 ; Counter i
LDI R25, 0 ; Bool
LDI R16, 0 ; Sum reg init
LDI R17, 0 ; Sum reg init
LDI R18, 0 ; Sum reg init
LDI R19, 0 ; Sum reg init
ldi r25, 1 ; Used to inc high sum reg

;LDI	R18, LOW(STARTADDS) 
;LDI R19, HIGH(STARTADDS)

; Load X with STARTADDS
LDI XL, LOW(STARTADDS) ; Get lower part
LDI XH, HIGH(STARTADDS)	; Get higher part

; Load Y with divisible by 5 location
LDI YL, LOW(FOURHUNDRED) ; Get lower part
LDI YH, HIGH(FOURHUNDRED) ; Get higher part

; Load Z with not divisible by 5 location
LDI ZL, LOW(SIXHUNDRED) ; Get lower part
LDI ZH, HIGH(SIXHUNDRED) ; Get higher part

lp:
	; Add low + high
	MOV R9, XL
	ADD R9, XH
	MOV R8, R9 ; Copy XL + XH

	; Store sum into location X(STARTADDS) 
	ST X+, R9
	
	LDI R24, 5 ; Dividend
	
	; Divide by sum register by 5
	subtractLp:
		SUB R9, R24
		; Check if N(negative) flag is set
		BRCC subtractLp ; If minus then stop subtracting
;		JMP subtractLp
	doneSub:
		; Add 5 to negative number
		ADD R9, R24
		; If 0 then divisible by 5
		BREQ divisible5
		; Else not divisible by 5
		JMP notDivisible5
		; If divisible, place in (0x0400 + i)
		divisible5:
			ST Y+, R8
		; Add to sum R16:R17
			add r17, r8 
			brcs overflow
			jmp nooverflow
			overflow:
				;subi r17, 1 ; sub overflow
				add r16, r25 ; add overflow to higher bit
			nooverflow:

			JMP doneStore
		; Else place in (0x0600 + i)
		notDivisible5:
			ST Z+, R8

		; Add to sum R18:R19
			add r19, r8 
			brcs overflow1
			jmp nooverflow1
			overflow1:
				;subi r19, 1 ; sub overflow
				add r18, r25 ; add overflow to higher bit
			nooverflow1:

	doneStore:

  	INC R20 ; Increment counter i
	CP R20, R23; Check if reached 255 numbers
	BRLO lp	; If reached skip to next part
			; Else go back to start of loop
	CPI R23, 255; If reached 255 numbers reset count to 45 to complete 300 numbers
	BREQ resetCnt
	
	CPI R23, 45 ; If reached 45 numbers, total numbers saved are 300. Jump to finish
	BREQ donelp
	JMP lp

	resetCnt:
	LDI R23, 45 ; Reset compare reg
	LDI R20, 0 ; Reset count
	JMP lp ; Continue to add remaining 45 numbers

donelp:
	JMP donelp