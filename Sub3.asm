; Filename SubTest3.asm
 
; This program is designed to demonstrate the use of subroutines in
; programming. 
; This file is phase 3 and introduces a multiply subroutine.
; Current support subroutines include : PMPTOUT, MULT, ATOI, ITOA

		.ORIG	x3000		; load the program here

; Request factor1 from the user
; To be retrieved from R0 according to convention

		AND 	R0,R0,#0

; Call prompt subroutine and output PROMPT1

		LEA	R3,PROMPT1
		JSR	PMPTOUT

		TRAP 	x20		; Use GETC to retrieve user character entry into R0
		TRAP	x21		; Echo the entered factor

; Convert factor1 to an integer
; Use R2 to convert ASCII factor1 to an integer, store in R4 when done

		AND	R2,R2,#0	; Clear R2
		ADD	R2,R0,#0	; Load R2 with the ASCII value of factor1
		JSR	ATOI
		ADD	R4,R4,R2

		LD	R0,NewLine	; Go to a clean line for the next input
		TRAP	x21

; Request factor2 from user
; To be retrieved from R0 according to convention

		AND R0,R0,#0

; Call prompt subroutine and output PROMPT2

		LEA	R3,PROMPT2
		JSR	PMPTOUT

		TRAP 	x20		; Use GETC to retrieve user character entry into R0
		TRAP	x21		; Echo the entered factor

; Convert factor2 to an integer
; Use R2 to convert ASCII factor2 to an integer, store in R5 when done

		AND	R2,R2,#0	; Clear R2
		ADD	R2,R0,#0	; Load R2 with the ASCII value of factor1
		JSR	ATOI
		ADD	R5,R5,R2

		LD	R0,NewLine	; Go to a clean line for the next input
		TRAP	x21

; Perform multiplication with MULT subroutine
; Registers R4 and R5 correctly contain two integer factors here.
; R6 contains the integer product.

		JSR MULT

; Use prompt writing subroutine to announce result

		LEA	R3,RESULT
		JSR	PMPTOUT

; Display the result of the multiplication on a clean line

		JSR	ITOA
		TRAP	x21		; Write the product to the display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		TRAP x25		; HALT the processor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PMPTOUT		ST	R7,SaveR7
		AND 	R0,R0,#0
		ADD 	R0,R3,R0
		TRAP 	x22		; Call PUTS
		LD	R7,SaveR7
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Multiply subroutine
; Expects factor1 in R4 and factor2 in R5
; Returns the product in R6

MULT		AND	R6,R6,#0	; Clear R6 to hold result of multiplication
AGAIN		ADD	R6,R6,R4
		ADD	R5,R5,#-1	
		BRp	AGAIN
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Subroutine to convert ASCII character to an integer
; This routine uses R2 as a holding register for the correction
ATOI		ST	R3,SaveR3
		AND	R3,R3,#0	; Clear R3
		LD	R3,ASCII	; Load ASCII correction into R3
		NOT	R3,R3		; Form 1s complement
		ADD	R3,R3,#1	; Form 2s complement
		ADD	R2,R2,R3	; ACSII correction, R2 now contains integer for
					; math operations
		LD	R3,SaveR3
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
ITOA		ST	R3,SaveR3
		AND	R0,R0,#0	; Clear R0 for product display
		ADD	R0,R6,R0	; Load product integer into R0
		AND	R3,R3,#0	; Clear R3 to ready ASCII correction 
		LD	R3,ASCII	; Load ASCII correction into R3
		ADD	R0,R0,R3	; Make integer an ASCII character for output
		LD	R3,SaveR3
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MEMORY AREA

NewLine		.FILL		x000A
ASCII		.FILL		x0030
SaveR7		.FILL		x0000
SaveR3		.FILL		x0000
PROMPT1		.STRINGZ	"Enter the first factor\n"
PROMPT2		.STRINGZ	"Enter the second factor\n"
RESULT		.STRINGZ	"The product of the factors is :\n"

		.END
; End of file 