; Name: Quang Bui
		.ORIG 		x3000			; the address start position of program
;
; Initialize the register
;
		AND 		R0, R0, #0		; initialized R0 = 0. R0 will get the input from keyboard
		AND 		R1, R1, #0		; initialized R1 = 0. R1 stored the first operand
		AND 		R2, R2, #0		; initialized R2 = 0. R2 stored the second operand
		AND 		R3, R3, #0		; initialized R3 = 0. R3 stored
		AND 		R4, R4, #0		; initialized R4 = 0. R4 stored the result of subtraction of first and second operand (in case R1 >= R2)
		AND 		R5, R5, #0		; initialized R5 = 0. R5 stored the location (2: one for sign and one for number) of result
		AND 		R6, R6, #0		; initialized R6 = 0. R6 stored the result of subtraction of first and second operand (in case R1 < R2)
		
		LD 		R3, NEG_48		; load the number (-48) into R3 to convert ASCII to number
;
; Get input the first operand
; 
		LEA 		R0, FIRST_DISPLAY	; load the string FIRST_DISPLAY into R0
		JSR PUTS_SUB				; call the PUTS_SUB Subrountine to output the string
		JSR GETC_SUB				; call the GETC_SUB Subrountine to get character from keyboard and stored in R0
		JSR OUT_SUB				; call the OUT_SUB Subrountine to display character stored in R0 to the console
		ADD 		R1, R0, R3		; convert the character to number and stored in R1
;
; Get input the secon operand
;
		LEA 		R0, SECOND_DISPLAY	; load the string SECOND_DISPLAY into R0
		JSR PUTS_SUB				; call the PUTS_SUB Subrountine to output the string
		JSR GETC_SUB				; call the OUT_SUB Subrountine to display character stored in R0 to the console
		JSR OUT_SUB				; call the OUT_SUB Subrountine to display character stored in R0 to the console
		ADD 		R2, R0, R3		; convert the character to number and stored in R2
;
; Subtract 2 number
; 
		ADD 		R0, R2, #0		; copy R2 (second operand) into R0 => the purpose is 2's complement the number R2
		JSR		TWO_COMP_SUB		; call the TWO_COMP_SUB Subroutine to 2's complement, the return result is stored in R0
		ADD 		R4, R1, R0		; Add two number to subtract two number
		
		BRn 		NegativeNumber		; if R4 <0, go to NegativeNumber label
;
; if the result >= 0
;		
		LD 		R3, ASCIIplus		; otherwise, (R4 >= 0), load the '+' into R3
		LEA 		R5, ASCIIBUFF		; create 2 location for the result (one for sign and one for number)
		STR 		R3, R5, #0		; stored the '+' into the first location in ASCIIBUFF
		ADD 		R5, R5, #1		; move to the next location in ASCIIBUFF
		LD 		R3, POS_48		; load number (+48) into R3
		ADD		R4, R4, R3		; convert the number (answer) to character 
		STR 		R4, R5, #0		; stored the answer '#' (number) into the first location in ASCIIBUFF
		JSR 		DISPLAY_SUB		; call the DISPLAY_SUB Subrountine to display the answer stored in R5
;
; if the result < 0, get 2's complement the first operand add to second operand and display answer
;
NegativeNumber	ADD 		R0, R1, #0		; if R4 < 0, copy R1 (first operand) into R0 => the purpose is 2's complement the number R2
		JSR		TWO_COMP_SUB		; call the TWO_COMP_SUB Subroutine to 2's complement, the return result is stored in R0
		ADD 		R6, R2, R0		; Add two number to subtract two number
		JSR Neg_Sub				; call the Neg_Sub Subrountine to store the result (the negative result)
		JSR 		DISPLAY_SUB		; call DISPLAY_SUB Subrountine to display the answer stored in R5

;
; if the result < 0, processing this case
; 

Neg_Sub 	LD 		R3, ASCIIminus		; load the '-' into R3
		LEA	 	R5, ASCIIBUFF		; create 2 location for the result (one for sign and one for number)
		STR 		R3, R5, #0		; stored the '+' into the first location in ASCIIBUFF
		ADD 		R5, R5, #1		; move to the next location in ASCIIBUFF
		LD 		R3, POS_48		; load number (+48) into R3
		ADD 		R6, R6, R3		; convert the number (answer stored in R6) to character 
		STR 		R6, R5, #0		; stored the answer '#' (number with no sign) into the first location in ASCIIBUFF
		RET					; return the SubRountine with the next address location stored in R7 and that is the position that program continue
;
; display result
;
DISPLAY_SUB 	ST 		R7, SAVER7		; store the register R7 with current PC
		LEA 		R0, RESULT_DISPLAY	; load the string RESULT_DISPLAY label into R0
		JSR PUTS_SUB				; call the PUTS_SUB Subrountine to output the string
		AND 		R0, R0, #0		; clear R0 = 0 
		LEA 		R0, ASCIIBUFF		; load the location stored the answer and stored in R0
		JSR PUTS_SUB				; call the PUTS_SUB Subrountine to output the answer stored in R0
		LD 		R7, SAVER7		; load the R7 back to current PC
		JSR 		HALT_SUB		; call the HALT_SUB Subrountine to halt the execution

;
; TWO_COMP_SUB: get 2's complement of a particular number
;
TWO_COMP_SUB	ST R7, SAVER7				; store the register R7 with current PC
		NOT R0, R0				; complement the R0
		ADD R0, R0, #1				; Add (+1) to R0 to make the complement
		LD R7, SAVER7				; load the R7 back to current PC
		RET					; return the SubRountine with the next address location stored in R7 and that is the position that program continue


;
; PUTS_SUB: Output a string
;
PUTS_SUB	ST R7, SAVER7				; Save R7 for later return
		ST R0, SAVER0				; Save other registers that are neeeded by this routine
		ST R1, SAVER1
		ST R2, SAVER2
LOOP_PUTS	LDR R1, R0, #0				; Get the character
		BRz LOAD_R_PUTS				; if 0, done
READ_CONTENTS	LDI R2, DSR				; Load the content of the Data Status Resgister into R2
		BRzp READ_CONTENTS
		STI R1, DDR				; write the character into Display Data Register
		ADD R0, R0, #1				; Incrementing the pointer
		BRnzp LOOP_PUTS				; Do again and again
LOAD_R_PUTS	LD R0, SAVER0				; restore the register
		LD R1, SAVER1
		LD R2, SAVER2
		LD R7, SAVER7
		RET					; JMP R7, actually return to caller
;
; GETC_SUB: enter a character from keyboard (does not display to screen)
;
GETC_SUB	ST R7, SAVER7				; Save the value in register that are neeeded by this routine
LOOP_GETC	LDI R0, KBSR				; Gas the character been type?
		BRzp LOOP_GETC
		LDI R0, KBDR				; Load the character into R0
		RET					; JMP R7, actually return to caller
;
; OUT_SUB: display a character to screen
; 
OUT_SUB		ST R7, SAVER7				; Save the value in register that are neeeded by this routine
		ST R1, SAVER1
LOOP_OUT	LDI R1, DSR				; Get the status register in the Display Status Register
		BRzp LOOP_OUT				; Bit 15 says that the display is ready
		STI R0, DDR				; Write the character to the console
		LD R1, SAVER1				; Restore the original value in register
		LD R7, SAVER7
		RET					; JMP R7, actually return to caller, return from TRAP

;
; HALT_SUB: Halt execution
;
HALT_SUB	ST 	R7, SAVER7			; store the registers - R7 is current PC
		ST 	R1, SAVER1			; R1 - a temp for MC register
		ST	R0, SAVER0			; R0 - is used as working space
		LEA 	R0, FINISH			; load the message that machine halting into R0
		JSR	PUTS_SUB			; print the message that machine halting by calling the PUTS_SUB Subroutine
		LDI 	R1, ADDRESS			; Load MCR register into R1
		ADD	R0, R7, #-1			; 
		AND 	R0, R1, R0			; mask to clear the top bits
		STI 	R0, ADDRESS			; Store R0 into MC register
		LD 	R0, SAVER0			; Restore the registers
		LD 	R1, SAVER1
		LD 	R7, SAVER7
		RET					; JMP R7, actually return to caller

;
; Label
;
ADDRESS		.FILL		xFFFE	; The address for MCR
SAVER0		.BLKW		1	; Get one memory location to store and load register R0, using in Subroutine
SAVER1		.BLKW		1	; Get one memory location to store and load register R1, using in Subroutine
SAVER2		.BLKW		1	; Get one memory location to store and load register R2, using in Subroutine
SAVER7		.BLKW		1	; Get one memory location to store and load register R7, using in Subroutine
ASCIIplus      	.FILL  		x002B	; ASCII character '+'
ASCIIminus     	.FILL  		x002D	; ASCII character '-'
ASCIIBUFF	.BLKW		2	; create two empty memory address location for saving the result
BUFFEREND	.FILL		x0000	; needed to force x0000 at end of ASCIIBUFF
NEG_48		.FILL		x-0030	; number (-30) for converting character to number
POS_48		.FILL		x0030	; number 30 for converting number to ASCII character
FIRST_DISPLAY	.STRINGZ 	"\nPlease enter a number between 0 and 9: "				; the string for outputing the first operand
SECOND_DISPLAY 	.STRINGZ 	"\n\nEnter a number (0 - 9) to subtract from the first number: "	; the string for outputing the second operand
RESULT_DISPLAY	.STRINGZ 	"\n\nResult of subtraction: "		; the string for outputing the result two operand (subtraction)
KBSR		.FILL xFE00	;address for Keyboard Status Register	; the address memory location for Keyboard Status Register
KBDR		.FILL xFE02	;address for Keyboard Data Register	; the address memory location for Keyboard Data Register
DSR		.FILL xFE04	;address for Display Status Register	; the address memory location for Display Status Register
DDR		.FILL xFE06	;address for Display Data Register	; the address memory location for Display Data Register
FINISH		.STRINGZ 	"\n-----Halting the processor-----"	; the string for Halt execution
		.END		; the end of program