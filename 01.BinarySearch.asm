; 1. Design and develop an assembly language program to search a key element “X” in a list of ‘n’
; 16-bit numbers. Adopt Binary search algorithm in your program for searching.

.model small
.stack
.data
        exit macro
            mov ah, 4ch
            int 21h
            endm

        disp macro msg
            mov ah, 09h
            lea dx, msg
            int 21h
            endm

        a dw 10h, 20h, 30h, 40h, 50h
        n dw ($-a)/2
        key dw 40h
        l dw ?
        h dw ?
        mid dw ?
        msg1 db "Successful Search$"
        msg2 db "Unsuccessful Search$"

.code
        mov ax, @data
        mov ds, ax
        mov l, 0
        mov ax, n
        dec ax
        mov h, ax
        mov ax, key
back:
        mov si, l
        cmp si, h
        jg stop
        add si, h
        shr si, 1
        mov mid, si
        shl si, 1
        cmp ax, a[si]
        jne next1
        disp msg1
        exit
next1:
        jg next2
        mov bx, mid
        dec bx
        mov h, bx
        jmp back
next2:
        mov bx, mid
        inc bx
        mov l, bx
        jmp back
stop:
        disp msg2
        exit
end