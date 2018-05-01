; 11.a. Design and develop an assembly language program to
; generate the Sine Wave using DAC interface (The output of the DAC is to be
; displayed on the CRO).

.model small
.stack
.data
        exit macro
            mov ah, 4ch
            int 21h
            endm

        send macro port, val
            mov dx, port
            mov al, val
            out dx, al
            endm

        kbhit macro
            mov ah, 01h
            int 16h
            endm

        pa equ 0dc50h
        cwr equ 0dc53h

        arr db 00h, 16h, 2bh, 40h, 52h, 61h, 6eh, 77h, 7dh, 7fh, 7dh, 77h, 6eh, 61h, 52h, 40h, 2bh, 16h

.code
        mov ax, @data
        mov ds, ax

        send cwr, 80h
repeat:
        mov cx, 18
        lea si, arr
back1:
        mov al, 7fh
        add al, [si]
        send pa, al
        call delay
        inc si
        loop back1

        mov cx, 18
        lea si, arr
back2:
        mov al, 7fh
        sub al, [si]
        send pa, al
        call delay
        inc si
        loop back2

        kbhit
        jz repeat
        exit

        delay proc
            push cx
            mov cx, 0fffh
bck1:
            mov bx, 0fffh
bck:
            dec bx
            jnz bck
            loop bck1
            pop cx
            ret
            delay endp
end