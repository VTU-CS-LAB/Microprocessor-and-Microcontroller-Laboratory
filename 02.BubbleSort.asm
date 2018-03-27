; 2. Design and develop an assembly program to sort a given set of ‘n’ 16-bit numbers in
; ascending order. Adopt Bubble Sort algorithm to sort given elements.

.model small
.stack
.data
        a dw 50h, 40h, 30h, 20h, 10h
        len dw ($-a)/2
        
        exit macro
            mov ah, 4ch
            int 21h
            endm

.code
        mov ax, @data
        mov ds, ax
        mov cx, len
        dec cx
back:
        mov bx, cx
        lea si, a
repeat:
        mov ax, [si]
        inc si
        inc si
        cmp ax, [si]
        jbe next
        xchg ax, [si]
        mov [si-2], ax
next:
        dec bx
        jnz repeat
        loop back
        exit
end                                            