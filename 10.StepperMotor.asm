; 10. Design and develop an assembly program to drive a Stepper Motor interface and rotate the
; motor in specified direction (clockwise or counter-clockwise) by N steps (Direction and N
; are specified by the examiner). Introduce suitable delay between successive steps. (Any
; arbitrary value for the delay may be assumed by the student).

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

        mov al, 88h
        mov cx, 200
back1:
        send pa, al
        call delay
        ROR al, 1
        loop back1

        mov al, 88h
        mov cx, 200
back2:
        send pa, al
        call delay
        ROL al, 1
        loop back2
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