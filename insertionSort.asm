main
	; --- print "Before sorting" ---
	add v0,zr,vet
	add v1,zr,vet_lim
loop_print_before
	bge v0,v1,end_print_before
	ldw v2,v0
	stw v2,zr,0xf000	; print element
	add v0,v0,2
	beq zr,zr,loop_print_before
end_print_before

	; --- insertion sort start ---
	add v0,zr,vet		; i = &vet + 2
	add v1,zr,vet_lim	; end
	add v2,zr,vet		; base pointer
	add v3,zr,vet_lim	; limit pointer
	add v0,v0,2		; skip first (i = 1)

loop_i
	bge v0,v1,endloop_i	; if i >= end → stop

	ldw v4,v0		; key = *i
	sub v5,v0,2		; j = i - 2a

loop_j
	blt v5,v2,endloop_j	; if j < start → stop inner
	ldw v6,v5		; v6 = arr[j]
	bge v6,v4,shift		; if arr[j] > key → shift
	beq zr,zr,endloop_j

shift
	stw v6,v5,2		; arr[j+1] = arr[j]
	sub v5,v5,2		; j--
	beq zr,zr,loop_j

endloop_j
	stw v4,v5,2		; arr[j+1] = key
	add v0,v0,2		; i++
	beq zr,zr,loop_i

endloop_i

	; --- print "After sorting" ---
	add v0,zr,vet
	add v1,zr,vet_lim
loop_print_after
	bge v0,v1,end_print_after
	ldw v2,v0
	stw v2,zr,0xf000	; print element
	add v0,v0,2
	beq zr,zr,loop_print_after
end_print_after

	hlt

; --- data section ---
vet
	5 3 1 4 2
vet_lim
