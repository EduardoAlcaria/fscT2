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

	add a0,zr,vet
	add a1,zr,vet_lim
	add lr,zr,RET1
	beq zr,zr,insertionSort

RET1
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

insertionSort
	add v0,a0,0		; base = start
	add v1,a1,0		; end = end
	add v2,v0,2		; i = base + 2

loop_i
	bge v2,v1,endloop_i	; if i >= end → stop

	ldw v3,v2		; key = *i
	sub v4,v2,2		; j = i - 2

loop_j
	blt v4,v0,endloop_j	; if j < start → stop inner
	ldw v5,v4		; v5 = arr[j]
	bge v5,v3,shift		; if arr[j] > key → shift
	beq zr,zr,endloop_j

shift
	stw v5,v4,2		; arr[j+1] = arr[j]
	sub v4,v4,2		; j--
	beq zr,zr,loop_j

endloop_j
	stw v3,v4,2		; arr[j+1] = key
	add v2,v2,2		; i++
	beq zr,zr,loop_i

endloop_i
	beq zr,lr		; return


; --- data section ---
vet
	5 3 1 4 2
vet_lim
