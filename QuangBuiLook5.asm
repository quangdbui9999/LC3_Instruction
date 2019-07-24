; Name: Quang Bui
	.ORIG x3000		; where is the address to beginning of the program
;
; Initialization the value
; R0 - if R0 = 1, we found number 5 in an array has 10 elements, otherwise, R0 = (-1), if number 5 does not include in the array
; R1 - register R1 with value (-5) (Regis R1 is used to check the number 5 whether or not include in the array by ADD with Register R2 (content of each element) and store in R2 (if R2 = 0, have number 5, otherwise, do not have number 5))
; R2 - (value of each element of array) 
; R3 - (the length of array is 10, using loop to read each element and decrement the counter Register R3)
; R4 - the first element in the array into R4 (R4 just contain the address of first element of array)
; R5 - the register R5 with value 0 (after each loop, the counter Register R5 is increament by one, keep track of the position if number is found)
;
	AND 	R0, R0, #0	; Initializes the register R0 and number 0, so the value of Register R0 is 0
	ADD 	R0, R0, #1	; Sets the register R0 with value 1 (if R0 = 1, we found number 5 in an array has 10 elements, otherwise, R0 = (-1), if number 5 does not include in the array)
	AND 	R1, R1, #0	; Initializes the register R1 and number 0, so the value of Register R1 is 0
	ADD 	R1, R1, #-5	; Sets the register R1 with value (-5) (Regis R1 is used to check the number 5 whether or not include in the array by ADD with Register R2 (content of each element) and store in R2 (if R2 = 0, have number 5, otherwise, do not have number 5))
	AND 	R3, R3, #0	; Initializes the register R3 and number 0, so the value of Register R3 is 0
	ADD 	R3, R3, #10	; Sets the register R3 with value 10 (the length of array is 10, using loop to read each element and decrement the counter Register R3)
	AND 	R5, R5, #0	; Initializes the register R5 and number 0, so the value of Register R5 is 0
	ADD 	R5, R5, #0	; Sets the register R5 with value 0 (after each loop, the counter Register R5 is increament by one, keep track of the position if number is found)
	LD 	R4, ARR_NUM	; Load the first element in the array into R4 (R4 just contain the address of first element of array)
;
; Does number 5 is found in array? 
;
	LDR 	R2, R4, x0		; Load the value of the address of R4 (elements in array) into R2 (value of each element of array) 
	ADD 	R2, R2, R1 		; Add (-5) with R2 and store in R2 (if R2 = 0, number is found, otherwise, number is not found)
	BRz 	LOOP_5			; Set condition is zero if number 5 is found and move to label LOOP_5
	ADD 	R4, R4, x1		; Increment the pointer to ger the next element in array
	ADD 	R5, R5, x1		; Increment the counter by 1 (keep track of position of array)
	ADD 	R3, R3, x-1		; Decrement the counter by 1 (R3 is length of array)
	BRp 	#-7			; Loop back to 7 positions (the position is beginning at address x3009)

;
; Number 5 is not found, print the message and Halt the program
;
	AND 	R0, R0, #0		; Reset R0 = 0	
	LEA 	R0, NO_5		; Load the message and place in Register R0 for output 
	PUTS				; TRAP x22 - Write a string pointed to by R0 to the screen.
	HALT				; TRAP x25 - Halt execution

;
; Number 5 is found, print the message, position is found and Halt the program
;
LOOP_5	AND 	R0, R0, x0		; Reset R0 = 0 
	ADD 	R0, R0, x1		; Set R0 = 1 because number is Found.
	AND 	R0, R0, x0		; Reset R0 = 0 in order to output message and position in array
	LEA 	R0, HAVE_5		; Load the message and place in Register R0 for output
	PUTS				; TRAP x22 - Write a string pointed to by R0 to the screen.
	LD 	R0, CHAR_0 		; Label CHAR_0  (number 48 is the character nymber '0' in ASCII Table) load number 48 into R0 for output
	ADD	R0, R0, R5		; Add R5 (position of array) with R0 and store the position in R0 for output
	OUT				; TRAP x21 - Write a character in R0[7:0] to the screen

	HALT				; TRAP x25 - Halt execution


ARR_NUM	ST		R0, #-256			; Load the array at the beginning position x3100
CHAR_0	.FILL		#48				; Label CHAR_0  (number 48 is the character nymber '0' in ASCII Table)
HAVE_5	.STRINGZ 	"A five found at 310"		; Label HAVE_5 - output this string when a number 5 is found
NO_5	.STRINGZ 	"No five found"			; Label NO_5- output this string when a number 5 is not found
	.END						; The end of the program