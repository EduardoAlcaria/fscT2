; ==========================================================
; PROBLEMA 1 – INSERTION SORT
; ==========================================================
; a0 = endereço inicial do vetor
; a1 = endereço final (limite)
; lr = registrador de retorno
; ==========================================================

main
	; ===== TESTE 1 =====
	add a0, zr, VETOR1
	add a1, zr, FIM1
	add lr, zr, RET1
	beq zr, zr, insertionSort

RET1
	; --- Exibe vetor ordenado ---
	add v0, zr, VETOR1
	add v1, zr, FIM1

PRINT1
	bge v0, v1, END_PRINT1
	ldw v2, v0
	stw v2, zr, 0xf000
	add v0, v0, 2
	beq zr, zr, PRINT1
END_PRINT1

	; ===== TESTE 2 =====
	add a0, zr, VETOR2
	add a1, zr, FIM2
	add lr, zr, RET2
	beq zr, zr, insertionSort

RET2
	add v0, zr, VETOR2
	add v1, zr, FIM2

PRINT2
	bge v0, v1, END_PRINT2
	ldw v2, v0
	stw v2, zr, 0xf000
	add v0, v0, 2
	beq zr, zr, PRINT2
END_PRINT2

	; ===== TESTE 3 =====
	add a0, zr, VETOR3
	add a1, zr, FIM3
	add lr, zr, RET3
	beq zr, zr, insertionSort

RET3
	add v0, zr, VETOR3
	add v1, zr, FIM3

PRINT3
	bge v0, v1, END_PRINT3
	ldw v2, v0
	stw v2, zr, 0xf000
	add v0, v0, 2
	beq zr, zr, PRINT3
END_PRINT3

	hlt

; ----------------------------------------------------------
; FUNÇÃO: insertionSort
; ----------------------------------------------------------
; a0 → ponteiro para o início do vetor
; a1 → ponteiro para o final do vetor
; lr → registrador de retorno
; ----------------------------------------------------------
insertionSort
	add v0, a0, 0		; início
	add v1, a1, 0		; fim
	add v2, v0, 2		; índice = início + 2

LOOP_EXTERNO
	bge v2, v1, END_EXTERNO
	ldw v3, v2		; v3 = chave = *índice
	sub v4, v2, 2		; v4 = posição = índice - 2

LOOP_INTERNO
	blt v4, v0, END_INTERNO
	ldw v5, v4		; v5 = vetor[posição]
	bge v5, v3, DESLOCAR
	beq zr, zr, END_INTERNO

DESLOCAR
	stw v5, v4, 2		; vetor[posição+1] = vetor[posição]
	sub v4, v4, 2		; posição--
	beq zr, zr, LOOP_INTERNO

END_INTERNO
	stw v3, v4, 2		; vetor[posição+1] = chave
	add v2, v2, 2		; índice++
	beq zr, zr, LOOP_EXTERNO

END_EXTERNO
	beq zr, lr		; retorno ao chamador

; ----------------------------------------------------------
; DADOS DE TESTE
; ----------------------------------------------------------
VETOR1
	5 3 1 4 2
FIM1

VETOR2
	9 7 5 3 1
FIM2

VETOR3
	4 6 2 8 0
FIM3
