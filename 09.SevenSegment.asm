; 9. Design and develop an assembly program to display messages “FIRE” and “HELP”
; alternately with flickering effects on a 7-segment display interface for a suitable period of
; time. Ensure a flashing rate that makes it easy to read both the messages (Examiner does not
; specify these delay values nor is it necessary for the student to compute these values).

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

        msg1 db 8eh, 0f9h, 88h, 86h
        msg2 db 89h, 86h, 0c7h, 8ch

        pb equ 0dc51h
        pc equ 0dc52h
        cwr equ 0dc53h

.code
        mov ax, @data
        mov ds, ax
        
        send cwr, 80h
repeat:
        mov bh, 04
        lea si, msg1
back1:
        mov bl, [si]
        call display
        inc si
        dec bh
        jnz back1
        call delay

        mov bh, 04
        lea si, msg2
back2:
        mov bl, [si]
        call display
        inc si
        dec bh
        jnz back2
        call delay

        kbhit
        jz repeat
        exit

        delay proc
            push cx
            mov cx, 0fffh
bck1:
            mov bx, 0ffffh
bck:
            dec bx
            jnz bck
            loop bck1
            pop cx
            ret
            delay endp

        display proc
            mov cx, 08
back3:
            rol bl, 1
            jc val1
            send pb, 0
            jmp clk1
val1:
            send pb, 1
clk1:
            send pc, 0
            send pc, 1
            loop back3
            ret
            display endp
end