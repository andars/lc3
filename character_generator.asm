.orig x0
BR _start
vmem .fill x1000
base_color .fill x00
tmp .fill x00
x_max .fill x-50 ; x < 80
y_max .fill x-1e ; y < 30
ss_disp_mem .fill x0


_start:
	AND R0, R0, #0 ; y coord
	AND R1, R1, #0 ; x coord
	LD R5, vmem
	LEA R6, text
	;LEA R7, end_text
	NOT R7, R7
	ADD R7, R7, #1 ; - r7

loop_y:
	AND R1, R1, #0 
loop_x:

	ADD R2, R0, R0 ; r2 = 2 * r0
	ADD R2, R2, R2 ; r2 = 4 * r0
	ADD R2, R2, R2 ; r2 = 8 * r0
	ADD R2, R2, R2 ; r2 = 16 * r0
	ADD R2, R2, R2 ; r2 = 32 * r0
	ADD R2, R2, R2 ; r2 = 64 * r0
	ADD R2, R2, R2 ; r2 = 128 * r0

	
	

	; compute address
	ADD R3, R2, R1 ; addr_offset = y << 7 + x
	ADD R3, R5, R3 ; addr = vmem_base + offset

	;LD R6, tmp
	
	LDR R2, R6, #0
	BRz next_line ; go to next line on null byte	

	STR R2, R3, #0 ; store char data at computed address
	ADD R6, R6, #1 ; increment pointer to text	


	ADD R1, R1, #1 ; inc x coord
	LD R4, x_max
	ADD R4, R1, R4
	BRn loop_x

	BR next_y
next_line:
	ADD R6, R6, #1 ; increment r6 when moving to next line early
	;ADD R2, R6, R7
	;BRz restart ; reset once we get to the end of text
next_y:
	ADD R0, R0, #1 ; inc y coord
	LD R4, y_max
	ADD R4, R4, R0 ; loop back if y < 30
	BRn loop_y

restart:
	; reset and redraw frame
	LEA R6, text
	AND R0, R0, #0
	AND R1, R1, #0
	BR loop_y

; cool feynman quote, could be anythings
text .stringz " \" What I cannot create, "
	 .stringz "     I do not understand. "
	 .fill x00
	 .stringz "      Know how to solve every problem that has been solved."
	 .fill x00
	 .stringz "                               RICHARD FEYNMAN"
