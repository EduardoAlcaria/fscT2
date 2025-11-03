; ==========================================================
; PROBLEMA 2 – TROCO (PUCRS TRM assembler-compatible)
; r1 = R, r2 = ptr DISP, r3 = ptr USED
; return r1 = 0 (success) or -1 (failure)
; ==========================================================

main
	; ===== TEST 1 =====
	add r1, r0, 137
	add r2, r0, DISP1
	add r3, r0, USED1
	add r13, r0, RET1
	beq r0, r0, troco
RET1
	stw r1, r0, 0xf000
	bne r1, r0, NEXT2
	add r5, r3, 0
	add r6, r3, 10
PRINT1
	bge r5, r6, END_PRINT1
	ldw r7, r5
	stw r7, r0, 0xf000
	add r5, r5, 2
	beq r0, r0, PRINT1
END_PRINT1

NEXT2
	; ===== TEST 2 =====
	add r1, r0, 276
	add r2, r0, DISP2
	add r3, r0, USED2
	add r13, r0, RET2
	beq r0, r0, troco
RET2
	stw r1, r0, 0xf000
	bne r1, r0, NEXT3
	add r5, r3, 0
	add r6, r3, 10
PRINT2
	bge r5, r6, END_PRINT2
	ldw r7, r5
	stw r7, r0, 0xf000
	add r5, r5, 2
	beq r0, r0, PRINT2
END_PRINT2

NEXT3
	; ===== TEST 3 =====
	add r1, r0, 3
	add r2, r0, DISP3
	add r3, r0, USED3
	add r13, r0, RET3
	beq r0, r0, troco
RET3
	stw r1, r0, 0xf000
	bne r1, r0, END_MAIN
	add r5, r3, 0
	add r6, r3, 10
PRINT3
	bge r5, r6, END_PRINT3
	ldw r7, r5
	stw r7, r0, 0xf000
	add r5, r5, 2
	beq r0, r0, PRINT3
END_PRINT3

END_MAIN
	hlt

; ----------------------------------------------------------
; troco
; ----------------------------------------------------------
troco
	add r4, r0, 0       ; i byte-offset = 0 (0,2,4,6,8)
	add r5, r0, 10      ; limit = 5 * 2 bytes

LOOP_NOTAS
	bge r4, r5, END_LOOP

	; r2 points to current DISP element
	ldw r6, r2          ; r6 = DISP[i]
	add r7, r0, 0       ; r7 = USED[i] (local counter = 0)

	; pick note value (r8) based on r4 offset
	beq r4, r0, VAL_100
	add r9, r0, 2
	beq r4, r9, VAL_50
	add r9, r0, 4
	beq r4, r9, VAL_10
	add r9, r0, 6
	beq r4, r9, VAL_5
	add r9, r0, 8
	beq r4, r9, VAL_1
	; fallback (shouldn't happen)
	add r8, r0, 1
	beq r0, r0, CALC_NOTA

VAL_100
	add r8, r0, 100
	beq r0, r0, CALC_NOTA
VAL_50
	add r8, r0, 50
	beq r0, r0, CALC_NOTA
VAL_10
	add r8, r0, 10
	beq r0, r0, CALC_NOTA
VAL_5
	add r8, r0, 5
	beq r0, r0, CALC_NOTA
VAL_1
	add r8, r0, 1

CALC_NOTA
	; while (R >= r8 && r6 > 0)
WHILE_USE
	blt r1, r8, END_WHILE
	beq r6, r0, END_WHILE

	; subtract immediate based on r8 (branch to correct immediate)
	add r9, r0, 100
	beq r8, r9, SUB_100
	add r9, r0, 50
	beq r8, r9, SUB_50
	add r9, r0, 10
	beq r8, r9, SUB_10
	add r9, r0, 5
	beq r8, r9, SUB_5
	add r9, r0, 1
	beq r8, r9, SUB_1
	beq r0, r0, END_WHILE

SUB_100
	add r1, r1, -100
	beq r0, r0, AFTER_SUB
SUB_50
	add r1, r1, -50
	beq r0, r0, AFTER_SUB
SUB_10
	add r1, r1, -10
	beq r0, r0, AFTER_SUB
SUB_5
	add r1, r1, -5
	beq r0, r0, AFTER_SUB
SUB_1
	add r1, r1, -1

AFTER_SUB
	sub r6, r6, 1
	add r7, r7, 1
	beq r0, r0, WHILE_USE

END_WHILE
	; store used and updated availability
	stw r7, r3
	stw r6, r2

	; advance DISP and USED pointers (and offset)
	add r2, r2, 2
	add r3, r3, 2
	add r4, r4, 2
	beq r0, r0, LOOP_NOTAS

END_LOOP
	; if remainder is zero -> success, else fail
	beq r1, r0, TROCO_OK
	add r1, r0, -1
	beq r0, r13

TROCO_OK
	add r1, r0, 0
	beq r0, r13

; ----------------------------------------------------------
; DATA
; ----------------------------------------------------------
NOTAS
	100 50 10 5 1

DISP1
	2 1 3 1 10
USED1
	0 0 0 0 0

DISP2
	1 0 30 0 0
USED2
	0 0 0 0 0

DISP3
	0 0 0 1 5
USED3
	0 0 0 0 0
