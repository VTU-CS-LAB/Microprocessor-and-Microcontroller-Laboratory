; 8.a. Design and develop an assembly program to demonstrate BCD Up-Down Counter (00-99)
; on the Logic Controller Interface.

.model small
.stack
.data
        exit macro
            mov ah, 4ch
            int 21h
            endm

        send macro port, val
            mov al, val
            mov dx, port
            out dx, al
            endm

        pa equ 0dc50h
        cwr equ 0dc53h

.code
        mov ax, @data
        mov ds, ax
        send cwr, 80h

        mov al, 00
        mov cx, 20
back1:
        send pa, al
        inc al
        daa
        loop back1

        mov cx, 20
back2:
        send pa, al
        dec al
        das
        loop back2
        exit
end