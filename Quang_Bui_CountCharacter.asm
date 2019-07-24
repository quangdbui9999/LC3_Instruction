; Name: Quang Bui
;
; Initialization
; 

		.ORIG x3000 		; the address at program is executing
		AND R0, R0, x0		; Initialize the register R0, set R0 = 0, get the character input by using TRAP routine and store character in R0
		AND R1, R1, x0		; Initialize the register R1, set R1 = 0, R1 is the register store the address of the pointer in file
		AND R2, R2, x0 		; Initialize the register R2, set R2 = 0, R1 is the register store the address of the pointer in file
					; look like R1 but it use in subrountines
		AND R3, R3, x0		; Initialize the register R3, set R3 = 0, R3 store the content of the address (R1 stored the address)
		AND R4, R4, x0		; Initialize the register R4, set R4 = 0, R4 is the counter for count charcter
		AND R7, R7, x0		; Initialize the register R7, set R2 = 0, R7 will store the incremented PC of the subrountines
					; R7 is also the place to store the address when the subrountines return the value, 
					; that's mean R7 stored the address of the next instruction after subrountine executed
		LD R1, POINTER_START 	; R1 is the register store the address of the pointer in file
		IN 			; Trap x23 - print prompt to console, read and echo  character from keyboard
		JSR CountChar		; call the subroutine CountChar		

		JSR ANSWER		; call the subroutine ANSWER
		HALT 			; TRAP x25 - halt execution

;
; Subrountines
; FirstChar finds the first occurrence of a specified character (R0) 
; in a string (R1)
; return pointer to character or to end of string (NULL) (R2).
;
FirstChar 	ST R3, SFCR3		; save register
		ST R4, SFCR4		; save original char
		NOT R4, R0		; nagate R0 for comparisons
		ADD R4, R4, x1		; 2's complment
		ADD R2, R1, x0		; initialize ptr to beginning of string
FC1		LDR R3, R2, x0		; read character
		BRz FC2			; if null, we're done
		ADD R3, R3, R4		; see if matches input char
		BRz FC2			; if yes, we're done
		ADD R2, R2, x1		; increment the pointer
		BRnzp FC1
FC2		LD R3, SFCR3		; restore register
		LD R4, SFCR4
		RET			; and return

;
; Subrountines
; CountChar counts the number of occurrences of a specified character (R0) 
; in a string (R1) and then return count in R2.
;

CountChar	ST R3, SCCR3		; save register
		ST R4, SCCR4
		ST R7, SCCR7		; JSR alters R7
		ST R1, SCCR1		; save original string ptr
		AND R4, R4, x0		; initialize count to 0
CC1		JSR FirstChar		; find next occurrence (ptr in R2)
		LDR R3, R2, x0		; see if the character is null or not null
		BRz CC2			; if null, no more chars
		ADD R4, R4, x1		; increment count
		ADD R1, R2, x1		; point to next char in string
		BRnzp CC1
CC2		ADD R2, R4, x0		; move return val (count) to R2
		LD R3, SCCR3		; restore register
		LD R4, SCCR4
		LD R7, SCCR7
		LD R1, SCCR1
		RET			; and return

;
; Output
;
ANSWER		LD R7, SaveR7		; Save register R7 before the subrountines do its task
		LEA R0, PROMPT		; Load the string with label PROMPT into R0 for preparing output the string
		PUTS 			; TRAP x22 - Write a string to the console
		AND R0, R0, x0		; Initialize R0, set R0 = 0
		LD R0, POS48		; Load the ASCII code number 48 (decimal) into R0
		ADD R0, R0, R2		; R2 will store the number of character in file (compare with character input from keyboard), copy R2 to R0
		OUT 			; output the number of character
		LD R7, SaveR7		; restore the register R7

SCCR1		.FILL x0000
SCCR3		.FILL x0000
SCCR4		.FILL x0000
SCCR7		.FILL x0000
SFCR3		.FILL x0000
SFCR4		.FILL x0000
SaveR7		.FILL x0000
POINTER_START 	.FILL x4000
POS48		.FILL x0030
PROMPT		.STRINGZ "Number of character in the file is: "
		.END ; the end of program