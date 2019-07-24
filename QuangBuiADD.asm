; Name and Programmer: Quang Bui - CSC-240-01: Computer Organization
; Professor: W. Mink

	.ORIG x3000 ; The Address to start of program

; -- Input the First Operand --

	AND 	R0, R0, #0 	; Reset R0 = 0
	LEA 	R0, PROMP 	; Load the string from LABEL PROMP into R0
	PUTS 			; TRAP x22 - Output the string to console
	LEA 	R0, INPUT1 	; Load the string from LABEL INPUT1 into R0
	PUTS 			; TRAP x22 - Output the string to console
	GETC 			; TRAP x20 - Input a character from the keyboard but does not display to console
	OUT 			; TRAP x21 - Output only one character stored in R0 to console
	ADD 	R1, R0, #0 	; Copy the content of R0 into R0
	LD 	R0, NEG48 	; Load the value (-48) to get the intefer value into R0
	ADD 	R2, R1, R0 	; R2 will keep the integer value after add (-48) entered from the keyboard
	AND 	R3, R3, 0 	; Reset R3 = 0
	AND 	R1, R1, #0 	; Reset R1 = 0
	LD 	R1, RE100 	; Load the value 100 into R1 (R1 keep track of iteration 100 times)
	LOOP100 ADD R3, R3, R2 	; R3 keeps the running sum
	ADD 	R1, R1, #-1 	; R1 keep track of iteration
	BRp 	LOOP100 	; If R1 > 0, loop again to add R2 into R3 and then decreament the counter of register R1
	AND 	R5, R5, #0 	; Reset R5 = 0
	ADD 	R5, R5, R3 	; Add the value after the LOOP100 of the R3 into R5 (R5 keeps track of the sum of first operand)

	GETC 			; TRAP x20 - Input a character from the keyboard but does not display to console
	OUT 			; TRAP x21 - Output only one character stored in R0 to console
	ADD 	R1, R0, #0 	; Copy the content of R0 into R0
	LD 	R0, NEG48 	; Load the value (-48) to get the intefer value into R0
	ADD 	R2, R1, R0 	; R2 will keep the integer value after add (-48) entered from the keyboard
	AND 	R3, R3, 0 	; Reset R3 = 0
	AND 	R1, R1, #0 	; Reset R1 = 0
	ADD 	R1, R1, #10 	; Add R1 to 10, at this time R1 = 10 (R1 keep track of iteration 10 times)
	LOOP10 	ADD R3, R3, R2 	; R3 keeps the running sum
	ADD 	R1, R1, #-1 	; R1 keep track of iteration
	BRp 	LOOP10 		; If R1 > 0, loop again to add R2 into R3 and then decreament the counter of register R1
	ADD 	R5, R5, R3 	; Add the value after the LOOP10 of the R3 into R5 (R5 keeps track of the sum of first operand)

	GETC 			; TRAP x20 - Input a character from the keyboard but does not display to console
	OUT 			; TRAP x21 - Output only one character stored in R0 to console
	ADD 	R1, R0, #0 	; Copy the content of R0 into R0
	LD 	R0, NEG48 	; Load the value (-48) to get the intefer value into R0
	ADD 	R2, R1, R0 	; R2 will keep the integer value after add (-48) entered from the keyboard
	ADD 	R5, R5, R2 	; Add the value of R2 into R5 (R5 keeps track of the sum of first operand)

; -- Input the Second Operand --

	AND 	R0, R0, #0 	; Reset R0 = 0
	LEA 	R0, INPUT2 	; Load the string from LABEL INPUT2 into R0
	PUTS 			; TRAP x22 - Output the string to console
	GETC 			; TRAP x20 - Input a character from the keyboard but does not display to console
	OUT 			; TRAP x21 - Output only one character stored in R0 to console
	ADD 	R1, R0, #0 	; Copy the content of R0 into R0
	LD 	R0, NEG48 	; Load the value (-48) to get the intefer value into R0
	ADD 	R2, R1, R0 	; R2 will keep the integer value after add (-48) entered from the keyboard
	AND 	R3, R3, 0 	; Reset R3 = 0 ; R3 keeps the running sum
	AND 	R1, R1, #0 	; Reset R1 = 0
	LD 	R1, RE100 	; Load the value 100 into R1 (R1 keep track of iteration 100 times)
	REP100 	ADD R3, R3, R2	; R3 keeps the running sum
	ADD 	R1, R1, #-1 	; R1 keep track of iteration
	BRp 	REP100 		; If R1 > 0, loop again to add R2 into R3 and then decreament the counter of register R1
	AND 	R6, R6, #0 	; Reset R5 = 0
	ADD 	R6, R6, R3 	; Add the value after the REP100 of the R3 into R6 (R6 keeps track of the sum of second operand)

	GETC 			; TRAP x20 - Input a character from the keyboard but does not display to console
	OUT 			; TRAP x21 - Output only one character stored in R0 to console
	ADD 	R1, R0, #0 	; Copy the content of R0 into R0
	LD 	R0, NEG48 	; Load the value (-48) to get the intefer value into R0
	ADD 	R2, R1, R0 	; R2 will keep the integer value after add (-48) entered from the keyboard
	AND 	R3, R3, 0 	; Reset R3 = 0
	AND 	R1, R1, #0 	; Reset R1 = 0
	ADD 	R1, R1, #10 	; Add R1 to 10, at this time R1 = 10 (R1 keep track of iteration 10 times)
	REP10 	ADD R3, R3, R2 	; R3 keeps the running sum
	ADD 	R1, R1, #-1 	; R1 keep track of iteration
	BRp 	REP10 		; If R1 > 0, loop again to add R2 into R3 and then decreament the counter of register R1
	ADD 	R6, R6, R3 	; Add the value after the REP10 of the R3 into R6 (R6 keeps track of the sum of second operand)

	GETC 			; TRAP x20 - Input a character from the keyboard but does not display to console
	OUT 			; TRAP x21 - Output only one character stored in R0 to console
	ADD 	R1, R0, #0 	; Copy the content of R0 into R0
	LD 	R0, NEG48 	; Load the value (-48) to get the intefer value into R0
	ADD 	R2, R1, R0 	; R2 will keep the integer value after add (-48) entered from the keyboard
	ADD 	R6, R6, R2 	; Add the value of the R2 into R6 (R6 keeps track of the sum of second operand)

; -- SUM 2 Numbers
	AND 	R4, R4, 0 	; Reset R4 = 0
	ADD 	R4, R5, R6 	; R4 is stored the value of sum of the first operand (R5) and second operand (R6)

	LEA 	R0, DIS_RS 	; Load the String "\nSum is: " in the register R0
	PUTS 			; TRAP x22 - Output the string to console

; -- SUM THOUSAND --
	LD 	R5, POS1000 	; Load the value 1000 into register R5
	LD 	R6, NEG1000 	; Load the value (-1000) into register R6

	AND 	R0, R0, #0 	; Reset register R0 = 0
	ADD 	R0, R0, #1 	; Add value to R0, R0 = 1

	ADD 	R3, R4, R6 	; R4 (total sum) + R6 (-1000) = R3 (keep track of the remain of the total sum)
	BRzp 	THOUSAND 	; If R3 < 0 => go to the loop THOUSAND, otherwise, load the value 48 ('0' character ASCII table into R2)
	ADD 	R0, R0, #-1 	; Decreament R0 by 1 => R0 = 0
	ADD 	R3, R3, R5 	; R3 (negative value) + R5 (1000) = R3 (make sure this R3 have only 3 digits sum)
	THOUSAND LD R2, POS48 	; load the value 48 ('0' character ASCII table into R2)

	ADD 	R0, R0, R2 	; ADD R2 to R0 and store in R0, prepare to output the first digit
	OUT 			; TRAP x21 - Output only one character stored in R0 to console

; -- SUM HUNDRED --
	LD 	R5, POS100 	; Load the value 100 into register R5
	LD 	R6, NEG100 	; Load the value (-100) into register R6

	AND 	R0, R0, #0 	; Reset register R0 = 0
	HUNDRED ADD R0, R0, #1 	; If R3 >= 0, Decreament R3 by 100, otherwise, exit the loop and decreament R0 by 1
	ADD 	R3, R3, R6 ; Decreament R3 by 100, R6 = (-100), the second digit is stored in R0
	BRzp 	HUNDRED ; If R3 < 0, exit the loop, otherwise, Decreament R3 by 100
	ADD 	R0, R0, #-1 	; Decreament R0 by 1 => R0 = 0
	ADD 	R3, R3, R5 	; R3 (negative value) + R5 (100) = R3 (make sure this R3 have only 2 digits sum)
	ADD 	R0, R0, R2 	; ADD R2 to R0 and store in R0, prepare to output the second digit
	OUT 			; TRAP x21 - Output only one character stored in R0 to console

; -- SUM TEN --
	LD 	R5, POS10 	; Load the value 10 into register R5
	LD 	R6, NEG10 	; Load the value (-10) into register R6
	AND 	R0, R0, #0 	; Reset register R0 = 0
	TEN 	ADD R0, R0, #1 	; If R3 >= 0, Decreament R3 by 10, otherwise, exit the loop and decreament R0 by 1
	ADD 	R3, R3, R6 	; Decreament R3 by 10, R6 = (-10), the third digit is stored in R0
	BRzp 	TEN 		; If R3 < 0, exit the loop, otherwise, Decreament R3 by 10
	ADD 	R0, R0, #-1 	; Decreament R0 by 1 => R0 = 0
	ADD 	R3, R3, R5 	; R3 (negative value) + R5 (10) = R3 (make sure this R3 have only 1 digits sum)
	ADD 	R0, R0, R2 	; ADD R2 to R0 and store in R0, prepare to output the third digit
	OUT 			; TRAP x21 - Output only one character stored in R0 to console

; -- SUM UNIT --
	ADD 	R0, R3, R2 	; ADD R2 ('0' character) to R3 (remain sum with only 1 digit) and store in R0, prepare to output the fourth digit
	OUT 			; TRAP x21 - Output only one character stored in R0 to console

	HALT 			; TRAP x25 - Halt execution

; -- List LABEL --

NEG1000 	.FILL #-1000
NEG100 		.FILL #-100
NEG10 		.FILL #-10
POS1000 	.FILL #1000
POS100 		.FILL #100
POS10 		.FILL #10
RE100 		.FILL #100
NEG48 		.FILL #-48
POS48 		.FILL #48

DIS_RS 		.STRINGZ "\n Sum is: "
INPUT1 		.STRINGZ "\n Enter a 3-digits number <###> (First Operand): "
INPUT2 		.STRINGZ "\n Enter a 3-digits number <###> (Second Operand): "
PROMP 		.STRINGZ "This program will add two 3-digit numbers.\nUse 0 as a placeholders for a single or 2-digit numbers (007 for 7 or 093 for 93 etc)"

.END ; The end of program