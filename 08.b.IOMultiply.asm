; 8.b. Design and develop an assembly program to read the status of two 8-bit inputs (X & Y)
; from the Logic Controller Interface and display X*Y.

.model small
.stack
.data
        exit macro
            mov ah, 4ch
            int 21h
            endm

        input macro
            mov dx, pb
            in al, dx
            endm

        send macro port, val
            mov dx, port
            mov al, val
            out dx, al
            endm

        pa dw 0dc50h
        pb dw 0dc51h
        cwr dw 0dc53h

.code
        mov ax, @data
        mov ds, ax
        send cwr, 82h
        input
        mov bl, al
        input
        mul bl
        send pa, al
        exit
end             