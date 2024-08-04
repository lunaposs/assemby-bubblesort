; x86 Bubble Sort Challenge

EXIT equ 1

section .rodata ; read-only

section .bss ; uninitialized

section .data ; initialized
    arr db 7,5,2,4,6,3,9,1,8
    arr_len equ $ - arr

section .text ; code
    global _start

; edi, esi as pointers; al, bl for values, cl for iteration, dl for check
; I have no idea how I achieved this without even thinking at all
; make sure to use gdb and do 'd/x (char[9]) arr`

_start: ; set registers
    mov al, 0
    mov bl, 0
    mov cl, 1 ; index, to keep track of
    mov dl, 0 ; check register, for final loop to exit
    mov edi, arr ; point to starting address of the arr
    mov esi, arr
    inc esi ; increment by one to point to the next element
    jmp _iterate ; begin bubble sort

_iterate: ; iterate over elements
    mov al, [edi] ; first element
    mov bl, [esi] ; second element
    cmp al, bl ; is value of al larger than the value of bl?
    jg _swap ; swap!
    add cl, 1 ; if not, move to next element
    add edi, 1
    add esi, 1
    cmp cl, arr_len ; make sure to not go out of bounds
    jl _iterate ; continue if less
    jmp _wrap ; else jump to wrap around

_swap: ; swap adjacent elements
    push eax ; push value onto stack
    mov [edi], bl ; copy value in bl to indexed element in array 
    pop ebx ; pop on ebx
    mov [esi], bl ; copy value in bl to another indexed element in array
    inc edi
    inc esi ; increment pointers by one to move to next element
    inc cl ; increment index
    cmp cl, arr_len ; compare current index to array length
    mov dl, 1 ; set check to 'no'
    je _wrap ; jump if equal
    jmp _iterate ; otherwise continue

_wrap:
    cmp dl, 0 ; check if dl is already set to 'yes, we need to stop the loop'
    je _end ; jump to finish
    mov cl, 1 ; otherwise reset index
    sub edi, arr_len-1 ; reset pointers, offset by 1
    sub esi, arr_len-1
    mov dl, 0 ; set to 'yes' until, _swap says 'no, not yet'
    jmp _iterate ; back to sort

_end:
    mov eax, EXIT ; clean up
    xor ebx, ebx
    int 0x80
