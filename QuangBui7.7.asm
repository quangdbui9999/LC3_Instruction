; Name: Quang BUi
	.ORIG 	x3000			; where is the program is begun
;
; initialize the register
;
	AND 	R0, R0, #0 		; Clear the register R0, initialize R0 = 0
	AND 	R1, R1, #0 		; Clear the register R1, initialize R1 = 0
	AND 	R2, R2, #0 		; Clear the register R2, initialize R2 = 0
	AND 	R3, R3, #0 		; Clear the register R3, initialize R3 = 0
	AND 	R4, R4, #0 		; Clear the register R4, initialize R4 = 0
	AND 	R5, R5, #0 		; Clear the register R5, initialize R5 = 0
; 
; Read 2 digits-number
; Read the first number
;
	LEA 	R0, ENTER 		; Load the content of ENTER label into R0 for output purpose
	PUTS 				; TRAP x22 - Write a string pointed to by R0 to the console
	GETC 				; TRAP x20 - Get a character from keyboard. The character is not displayed in the console. Its ASCII code is copied into R0. The high eight bits of R0 are cleared.
	OUT 				; TRAP x21 - Write a character in R0 [7:0] to the console

	ADD 	R1, R0, #0 		; Copy the character in R0 and storage into R1
	LD 	R0, NE_CHAR0 		; At this time, R0 is entered from keyboard, this is a character. In ASCII Table, number 48 is the character '0', so we plus (-48) to get the number 0 and store in 
	ADD	R1, R1, R0 		; Copy the value of R0 and store in R1

	LD 	R2, TEN 		; Load the value 10 into R2
	LOOP10 	ADD R3, R3, R1 		; R3 is the product by adding a number value in R1 with 10 time by using loop
	ADD 	R2, R2, #-1 		; Decreament the counter, R2 keeps track of the iteration
	BRp 	LOOP10 			; Loop again if value R2 still positive

	ADD 	R4, R3, #0 		; Copy the value in R3 into Register R4 (R4 will contain the value after the LOOP10 executed)
;
; Read the second number
;
	GETC 				; TRAP x20 - Get a character from keyboard. The character is not displayed in the console. Its ASCII code is copied into R0. The high eight bits of R0 are cleared.
	OUT 				; TRAP x21 - Write a character in R0 [7:0] to the console

	ADD 	R1, R0, #0 		; Copy the character in R0 and storage into R1
	LD 	R0, NE_CHAR0 		; At this time, R0 is entered from keyboard, this is a character. In ASCII Table, number 48 is the character '0', so we plus (-48) to get the number 0 and store in
	ADD 	R1, R1, R0 		; Copy the value of R0 and store in R1

	ADD 	R0, R4, R1 		; Add the value of R4 and R1 into R0, R0 will contain the value (two-digits)
;
; Using Bit-Mask to count how many bit value of 1s in the value R0
;
	AND 	R5, R5, #0 		; Reset R5 = 0
	ADD 	R5, R5, #1 		; R5 will act as a mask to mask out the unneeded bit
	AND 	R1, R1, #0 		; Zero out the result register
	AND 	R2, R2, #0 		; R2 will act as a counter
	LD 	R3, NegSixt 		; Load the number (-16) into R3

	MskLoop AND R4, R0, R5 		; mask off the bit
	BRz 	ISZERO 			; If R4 = 1, goto the instrucition ADD R1, R1, #1, otherwise, (R4 = 0, move to ISZERO label)
	ADD 	R1, R1, #1 		; Increament to 1 if R4 = 1
	ISZERO 	ADD R5, R5, R5
	ADD 	R2, R2, #1 		; Increament the counter
	ADD 	R6, R2, #1 		; Add the counter to 1 and store in R6
	ADD 	R6, R2, R3 		; Add the value in R3 (-16) with value of R2 (counter) and store in R6
	BRn 	MskLoop 		; if R6 is negative, the loop is continue until R6 is zero or positive (the condition to exit the loop)
;
; Display Result
;
	LEA 	R0, DIS_INFO 		; Load the content of ENTER label into R0 for output purpose
	PUTS 				; TRAP x22 - Write a string pointed to by R0 to the console
	AND 	R0, R0, #0 		; Reset R0 = 0
	LD 	R0, PO_CHAR0 		; Number 48 is the character '0' in ASCII Table, we load the number 48 into R0
	ADD 	R0, R1, R0 		; R1 is the number value of 1s , add R1 into R0 and store in R0
	OUT 				; TRAP x21 - Write the number value of 1s in R0 [7:0] to the console
	HALT 				; TRAP x25 - Halt execution.

;
; OPCODE
;


NE_CHAR0 .FILL xFFD0			; .FILL allocate one word, initialize with value n, NE_CHAR0 label has value (-48)
NegSixt .FILL xFFF0			; NegSixt label has value (-16)
TEN 	.FILL x000A			; TEN label has value 10
PO_CHAR0 .FILL x0030			; PO_CHAR0 label has value 48

ENTER 	.STRINGZ 	"Enter a value with two-digits number, if value <= 9, please enter number 0 before (00-09-99):" ; .STRINGZ allocate n+1 locations, initialize with characters and null terminator
DIS_INFO .STRINGZ 	"\nThere value of bit 1s is: "						; .STRINGZ allocate n+1 locations, initialize with characters and null terminator

	.END 		; the end of program